from flask import Flask, request, make_response, redirect, send_from_directory
from datetime import datetime, timedelta
import subprocess
import secrets
import sqlite3
import shutil
import re
import os

app = Flask(__name__)

# --- Absolute Path Configuration ---
BACKEND_DIR = os.path.dirname(os.path.abspath(__file__)) # .../backend
ROOT_DIR = os.path.dirname(BACKEND_DIR)                  # .../ (Project Root)
FRONTEND_DIR = os.path.join(ROOT_DIR, "frontend")        # .../frontend

# Anchor database files safely inside the backend folder
DB_USERS = os.path.join(BACKEND_DIR, "users.db")
DB_COOKIES = os.path.join(BACKEND_DIR, "cookies.db")

# --- Database Initialization ---
def init_dbs():
    with sqlite3.connect(DB_USERS) as con:
        con.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE,
                password TEXT,
                email TEXT,
                level INTEGER DEFAULT 1,
                rank TEXT DEFAULT 'NEWBIE',
                global_position TEXT DEFAULT '#999',
                problems_solved INTEGER DEFAULT 0,
                progress INTEGER DEFAULT 0
            )
        """)
    with sqlite3.connect(DB_COOKIES) as con:
        con.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT,
                cookie TEXT,
                expire TEXT,
                name TEXT
            )
        """)

# --- Input Validation Helpers ---
def valid_username(username):
    if not username or not (8 <= len(username) <= 20):
        return False
    if username.count("_") > 1:
        return False
    if sum(c.isdigit() for c in username) == len(username):
        return False
    return bool(re.fullmatch(r"[A-Za-z0-9_]+", username))

def valid_password(password):
    return password and len(password) > 5

def get_logged_in_user():
    cookie = request.cookies.get("session")
    if not cookie:
        return None
    with sqlite3.connect(DB_COOKIES) as con:
        cur = con.cursor()
        cur.execute("SELECT username, expire FROM users WHERE cookie=?", (cookie,))
        row = cur.fetchone()
    if row:
        try:
            expire_dt = datetime.strptime(row[1], "%Y-%m-%d %H:%M:%S")
            if datetime.now() < expire_dt:
                return row[0]
        except Exception:
            pass
    return None

def get_sage_executable():
    sage_bin = shutil.which("sage")
    if sage_bin:
        return sage_bin
    
    user_home = os.path.expanduser("~")
    possible_paths = [
        os.path.join(user_home, "miniforge3/envs/sage/bin/sage"),
        os.path.join(user_home, "miniconda3/envs/sage/bin/sage"),
        os.path.join(user_home, "anaconda3/envs/sage/bin/sage"),
        os.path.join(user_home, ".conda/envs/sage/bin/sage"),
    ]
    for path in possible_paths:
        if os.path.exists(path) and os.access(path, os.X_OK):
            return path
    return "sage"

# --- Custom Page Template Injectors ---
@app.route("/")
@app.route("/main")
def main_route():
    username = get_logged_in_user()
    with open(os.path.join(ROOT_DIR, "index.html"), "r", encoding="utf-8") as f:
        html = f.read()
    
    if username:
        html = html.replace('<a href="frontend/login.html">LOGIN</a>', '')
        html = html.replace('<a href="frontend/register.html">REGISTER</a>', '')
        html = html.replace('<a href="frontend/account.html">ACCOUNT</a>', 
                            f'<a href="frontend/account.html">ACCOUNT ({username})</a>\n        <a href="/logout" style="color: #ff3030; border-color: #ff3030;">LOGOUT</a>')
    else:
        html = html.replace('<a href="frontend/account.html">ACCOUNT</a>', '')
        
    return html

@app.route("/login", methods=["POST"])
def login_route():
    # Supports both application/x-www-form-urlencoded and standard JSON/Form requests
    username = request.form.get("username")
    password = request.form.get("password")
    
    if not username or not password:
        return "8" # Missing fields

    with sqlite3.connect(DB_USERS) as con:
        cur = con.cursor()
        cur.execute("SELECT password FROM users WHERE username=?", (username,))
        row = cur.fetchone()

    # Verify password match
    if row and row[0] == password:
        # Create a session token
        session_token = secrets.token_hex(16)
        expire_time = (datetime.now() + timedelta(days=1)).strftime("%Y-%m-%d %H:%M:%S")
        
        with sqlite3.connect(DB_COOKIES) as con_c:
            con_c.execute(
                "INSERT INTO users (username, cookie, expire) VALUES (?, ?, ?)",
                (username, session_token, expire_time)
            )
            
        resp = make_response("7") # "7" indicates success to your frontend
        resp.set_cookie("session", session_token, max_age=86400, httponly=True)
        return resp
        
    return "8" # Invalid credentials

@app.route("/frontend/register.html", methods=["GET", "POST"])
@app.route("/register", methods=["POST"]) # Handles both route URLs safely
def register_route():
    if request.method == "POST":
        username = request.form.get("username")
        email = request.form.get("email")
        password = request.form.get("password")
        confirm_password = request.form.get("confirm_password")
        
        if password != confirm_password:
            return "<h3>Passwords do not match! <a href='/frontend/register.html'>Try again</a></h3>", 400
            
        if not valid_username(username) or not valid_password(password):
            return "<h3>Invalid validation requirements (Username 8-20 alphanumeric characters, Password > 5). <a href='/frontend/register.html'>Try again</a></h3>", 400
            
        try:
            with sqlite3.connect(DB_USERS) as con:
                cur = con.cursor()
                cur.execute("INSERT INTO users (username, password, email) VALUES (?, ?, ?)", (username, password, email))
                con.commit()
            return redirect("/frontend/login.html")
        except sqlite3.IntegrityError:
            return "<h3>Username already exists! <a href='/frontend/register.html'>Try again</a></h3>", 400
            
    # Directly serve the file without breaking via fragile .replace() calls
    with open(os.path.join(FRONTEND_DIR, "register.html"), "r", encoding="utf-8") as f:
        return f.read()

@app.route("/frontend/account.html")
def account_route():
    username = get_logged_in_user()
    if not username:
        return redirect("/frontend/login.html")
        
    with sqlite3.connect(DB_USERS) as con:
        cur = con.cursor()
        cur.execute("SELECT level, rank, global_position, problems_solved, progress FROM users WHERE username=?", (username,))
        row = cur.fetchone()
        
    level, rank, global_position, problems_solved, progress = row if row else (1, 'NEWBIE', '#999', 0, 0)
        
    with open(os.path.join(FRONTEND_DIR, "account.html"), "r", encoding="utf-8") as f:
        html = f.read()
        
    html = html.replace('<h3 class="username">Hieu</h3>', f'<h3 class="username">{username}</h3>')
    html = html.replace('<p><strong>Expertise:</strong> Intermediate</p>', f'<p><strong>Rank:</strong> {rank}</p>\n        <p><strong>Level:</strong> {level}</p>')
    html = html.replace('<p><strong>Global Position:</strong> #42</p>', f'<p><strong>Global Position:</strong> {global_position}</p>')
    html = html.replace('<p><strong>Problems Solved:</strong> 317</p>', f'<p><strong>Problems Solved:</strong> {problems_solved}</p>')
    html = html.replace('<div class="progress-fill">74%</div>', f'<div class="progress-fill" style="width: {progress}%;">{progress}%</div>')
    return html

# =============== SAGE ================ #
@app.route("/run", methods=["POST"])
def run_sage():
    data = request.get_json(silent=True) or {}
    code_str = data.get("code", "")
    
    try:
        sage_exec = get_sage_executable()
        wrapper_script = (
            "import ast\n"
            "import sys\n"
            "from sage.all import *\n"
            "code_str = sys.stdin.read()\n"
            "preparsed = preparse(code_str)\n"
            "tree = ast.parse(preparsed)\n"
            "if tree.body and isinstance(tree.body[-1], ast.Expr):\n"
            "    last_expr = tree.body[-1].value\n"
            "    print_node = ast.Expr(\n"
            "        value=ast.Call(\n"
            "            func=ast.Name(id='print', ctx=ast.Load()),\n"
            "            args=[last_expr],\n"
            "            keywords=[]\n"
            "        )\n"
            "    )\n"
            "    tree.body[-1] = print_node\n"
            "    ast.fix_missing_locations(tree)\n"
            "exec(compile(tree, '<string>', 'exec'), globals())\n"
        )

        result = subprocess.run(
            [sage_exec, "-c", wrapper_script],
            input=code_str, # Fixes the 'req.code' NameError bug!
            capture_output=True,
            text=True,
            timeout=3
        )

        return {
            "success": True,
            "output": result.stdout,
            "error": result.stderr
        }

    except subprocess.TimeoutExpired:
        return {"success": False, "output": "", "error": "Time limit exceeded"}
    except FileNotFoundError:
        return {"success": False, "output": "", "error": "SageMath is not installed or not found in PATH."}
    except Exception as e:
        return {"success": False, "output": "", "error": str(e)}
    
#===========================================================================#

@app.route("/frontend/<path:filename>")
def serve_frontend_assets(filename):
    return send_from_directory(FRONTEND_DIR, filename)

@app.route("/logout")
def logout():
    cookie = request.cookies.get("session")
    if cookie:
        with sqlite3.connect(DB_COOKIES) as con:
            con.execute("DELETE FROM users WHERE cookie=?", (cookie,))
    resp = make_response(redirect("/"))
    resp.delete_cookie("session")
    return resp

if __name__ == "__main__":
    init_dbs()
    app.run(host="0.0.0.0", port=5000, debug=True)
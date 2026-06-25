from flask import Flask, request, make_response, redirect, send_from_directory, jsonify
from datetime import datetime, timedelta
import secrets, sqlite3, re, os

app = Flask(__name__)

D_B = os.path.dirname(os.path.abspath(__file__))
D_R = os.path.dirname(D_B)
D_F = os.path.join(D_R, "frontend")
DB_U = os.path.join(D_B, "users.db")
DB_C = os.path.join(D_B, "cookies.db")

def init():
    with sqlite3.connect(DB_U) as c:
        # Create users table
        c.execute("""CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            username TEXT UNIQUE, 
            password TEXT, 
            email TEXT, 
            level INTEGER DEFAULT 1, 
            rank TEXT DEFAULT 'NEWBIE', 
            global_position TEXT DEFAULT '#999', 
            problems_solved INTEGER DEFAULT 0, 
            progress INTEGER DEFAULT 0, 
            xp INTEGER DEFAULT 0
        )""")
        
        # Create initial_misions table
        c.execute("""CREATE TABLE IF NOT EXISTS initial_misions (
            id TEXT PRIMARY KEY, 
            title TEXT, 
            xp INTEGER, 
            answer TEXT, 
            statement TEXT
        )""")
        
        # Create solved_problems table (This was missing!)
        c.execute("""CREATE TABLE IF NOT EXISTS solved_problems (
            username TEXT, 
            problem_id TEXT,
            PRIMARY KEY (username, problem_id)
        )""")       

def val_u(u):
    if not u or not (8 <= len(u) <= 20) or u.count("_") > 1 or sum(x.isdigit() for x in u) == len(u): return False
    return bool(re.fullmatch(r"[A-Za-z0-9_]+", u))

def get_u():
    ck = request.cookies.get("session")
    if not ck: return None
    with sqlite3.connect(DB_C) as c: r = c.execute("SELECT username, expire FROM users WHERE cookie=?", (ck,)).fetchone()
    if r:
        try:
            if datetime.now() < datetime.strptime(r[1], "%Y-%m-%d %H:%M:%S"): return r[0]
        except: pass
    return None

@app.route("/")
@app.route("/main")
def mn():
    u = get_u()
    with open(os.path.join(D_R, "index.html"), "r", encoding="utf-8") as f: h = f.read()
    if u:
        h = h.replace('<a href="frontend/login.html">LOGIN</a>', '').replace('<a href="frontend/register.html">REGISTER</a>', '').replace('<a href="frontend/account.html">ACCOUNT</a>', f'<a href="frontend/account.html">ACCOUNT ({u})</a>\n<a href="/logout" style="color: #ff3030; border-color: #ff3030;">LOGOUT</a>')
    else:
        h = h.replace('<a href="frontend/account.html">ACCOUNT</a>', '')
    return h.replace('href="#practice"', 'href="/practice"')

@app.route("/api/leaderboard")
def leaderboard():
    with sqlite3.connect(DB_U) as c:
        # Get users sorted by XP descending
        top = c.execute("SELECT username, xp FROM users ORDER BY xp DESC LIMIT 10").fetchall()
    return {"data": top}    

@app.route("/login", methods=["POST"])
def log():
    u, p = request.form.get("username"), request.form.get("password")
    if not u or not p: return "8"
    with sqlite3.connect(DB_U) as c: r = c.execute("SELECT password FROM users WHERE username=?", (u,)).fetchone()
    if r and r[0] == p:
        t, e = secrets.token_hex(16), (datetime.now() + timedelta(days=1)).strftime("%Y-%m-%d %H:%M:%S")
        with sqlite3.connect(DB_C) as c: c.execute("INSERT INTO users (username, cookie, expire) VALUES (?, ?, ?)", (u, t, e))
        res = make_response("7")
        res.set_cookie("session", t, max_age=86400, httponly=True)
        return res
    return "8"

@app.route("/frontend/register.html", methods=["GET", "POST"])
@app.route("/register", methods=["POST"])
def reg():
    if request.method == "POST":
        u, e, p, cp = [request.form.get(k) for k in ("username", "email", "password", "confirm_password")]
        if p != cp or not val_u(u) or not p or len(p) <= 5: return "<h3>Validation Error <a href='/frontend/register.html'>Back</a></h3>", 400
        try:
            with sqlite3.connect(DB_U) as c: c.execute("INSERT INTO users (username, password, email) VALUES (?, ?, ?)", (u, p, e))
            return redirect("/frontend/login.html")
        except: return "<h3>User Exists <a href='/frontend/register.html'>Back</a></h3>", 400
    with open(os.path.join(D_F, "register.html"), "r", encoding="utf-8") as f: return f.read()

@app.route("/frontend/account.html")
def acc():
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    with sqlite3.connect(DB_U) as c: r = c.execute("SELECT level, rank, global_position, problems_solved, progress FROM users WHERE username=?", (u,)).fetchone()
    l, rnk, gp, ps, pr = r if r else (1, 'NEWBIE', '#999', 0, 0)
    with open(os.path.join(D_F, "account.html"), "r", encoding="utf-8") as f: h = f.read()
    return h.replace('<h3 class="username">Hieu</h3>', f'<h3 class="username">{u}</h3>').replace('<p><strong>Expertise:</strong> Intermediate</p>', f'<p><strong>Rank:</strong> {rnk}</p>\n<p><strong>Level:</strong> {l}</p>').replace('<p><strong>Global Position:</strong> #42</p>', f'<p><strong>Global Position:</strong> {gp}</p>').replace('<p><strong>Problems Solved:</strong> 317</p>', f'<p><strong>Problems Solved:</strong> {ps}</p>').replace('<div class="progress-fill">74%</div>', f'<div class="progress-fill" style="width: {pr}%;">{pr}%</div>')

@app.route("/frontend/ranking.html")
def rnk():
    with open(os.path.join(D_F, "ranking.html"), "r", encoding="utf-8") as f: h = f.read()
    with sqlite3.connect(DB_U) as c: data = c.execute("SELECT username, xp FROM users ORDER BY xp DESC LIMIT 10").fetchall()
    
    # Generate rows. If data is empty, 'rows' will just be an empty string.
    rows = "".join(f"<tr><td>{i+1}</td><td>{r[0]}</td><td>{r[1]}</td></tr>" for i, r in enumerate(data))
    
    # Simply inject rows. If empty, it won't show anything (or you can add a message)
    return h[:h.find("<tr>", h.find("</th>"))] + rows + h[h.rfind("</tr>") + 5:]

@app.route("/practice")
def prc():
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    with open(os.path.join(D_F, "practice.html"), "r", encoding="utf-8") as f: p = f.read()
    with sqlite3.connect(DB_U) as c: i = c.execute("SELECT id, title, xp FROM initial_misions").fetchall()
    b = "".join(f'<div class="mission"><h3>MISSION #{x[0]}</h3><p>{x[1]}</p><p>+{x[2]} XP</p><a href="/practice/{x[0]}"><button>SOLVE</button></a></div>' for x in i)
    core = p[:p.find('<div class="mission">')] + b + "</section>"
    return f"<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Practice</title><link rel='stylesheet' href='/style.css'></head><body><header><h1>ChanceField</h1></header><main>{core}<br><div style='text-align:center;'><a href='/'>← Back</a></div></main></body></html>"

@app.route("/practice/<id>")
def prc_id(id):
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    with sqlite3.connect(DB_U) as c: m = c.execute("SELECT title, xp, statement FROM initial_misions WHERE id=?", (id,)).fetchone()
    if not m: return "404", 404
    with open(os.path.join(D_F, "problem.html"), "r", encoding="utf-8") as f: h = f.read()
    return h.replace("{{id}}", id).replace("{{u}}", u).replace("{{t}}", m[0]).replace("{{xp}}", str(m[1])).replace("{{stmt}}", m[2])

@app.route("/submit", methods=["POST"])
def submit():
    u = get_u()
    if not u: return {"success": False, "msg": "Login required"}
    data = request.json
    prob_id, user_ans = data["id"], data["answer"]
    
    with sqlite3.connect(DB_U) as c:
        # 1. Verify the answer
        m = c.execute("SELECT answer, xp FROM initial_misions WHERE id=?", (prob_id,)).fetchone()
        if not m or m[0] != user_ans:
            return {"success": False, "msg": "Incorrect answer."}

        # 2. Check if already solved
        already_solved = c.execute("SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, prob_id)).fetchone()
        if already_solved:
            return {"success": False, "msg": "Problem already solved!"}

        # 3. Award XP and record the submission
        c.execute("UPDATE users SET xp = xp + ? WHERE username=?", (m[1], u))
        c.execute("INSERT INTO solved_problems (username, problem_id) VALUES (?, ?)", (u, prob_id))
        
        return {"success": True, "msg": f"Correct! +{m[1]} XP earned."}


@app.route("/<path:f>")
@app.route("/frontend/<path:f>")
def srv(f):
    return send_from_directory(D_F if os.path.exists(os.path.join(D_F, f)) else D_R, f)

@app.route("/logout")
def out():
    if ck := request.cookies.get("session"):
        with sqlite3.connect(DB_C) as c: c.execute("DELETE FROM users WHERE cookie=?", (ck,))
    res = make_response(redirect("/"))
    res.delete_cookie("session")
    return res

if __name__ == "__main__":
    init()
    app.run(host="0.0.0.0", port=5000, debug=True)
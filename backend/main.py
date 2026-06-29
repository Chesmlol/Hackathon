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

        # Inside your init() function in main.py
        c.execute("""CREATE TABLE IF NOT EXISTS lessons (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            link TEXT
        )""")

def val_u(u):
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
        # Pull the COALESCE version
        top = c.execute("SELECT COALESCE(display_name, username), xp FROM users ORDER BY xp DESC LIMIT 10").fetchall()
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
# 1. This serves the registration page
@app.route("/frontend/register.html")
def show_register():
    with open(os.path.join(D_F, "register.html"), "r", encoding="utf-8") as f:
        return f.read()

# 2. This handles the form submission (API)
@app.route("/register", methods=["POST"])
def handle_register():
    u = request.form.get("username")
    e = request.form.get("email")
    p = request.form.get("password")
    cp = request.form.get("confirm_password")
    
    # 1. Validation checks (Backend safety net)
    if p != cp:
        return jsonify({"success": False, "msg": "Passwords do not match."}), 400
    if not (5 <= len(u) <= 20):
        return jsonify({"success": False, "msg": "Username must be 5-20 characters long."}), 400
    if not val_u(u):
        return jsonify({"success": False, "msg": "Invalid username (letters, numbers, underscores only)."}), 400
    if len(p) <= 5:
        return jsonify({"success": False, "msg": "Password too short (min 6 characters)."}), 400

    # 2. Database attempt
    try:
        with sqlite3.connect(DB_U) as c: 
            c.execute("INSERT INTO users (username, password, email) VALUES (?, ?, ?)", (u, p, e))
        return jsonify({"success": True, "msg": "Registered successfully!"})
    except sqlite3.IntegrityError:
        return jsonify({"success": False, "msg": "Username already exists."}), 400

@app.route("/frontend/account.html")
def acc():
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    
    with sqlite3.connect(DB_U) as c: 
        # ADDED avatar_url TO THIS SELECT
        r = c.execute("SELECT level, rank, global_position, progress, xp, display_name, avatar_url FROM users WHERE username=?", (u,)).fetchone()
        
        # Unpack all 7 variables
        # Fallback to default avatar if none exists
        default_av = 'https://i.imgur.com/8Km9tLL.png'
        l, rnk, gp, pr, xp, dname, av = r if r else (1, 'NEWBIE', '#999', 0, 0, u, default_av)
        
        # Fix: If av is None (from DB), use default
        if not av: av = default_av
        
        ps = c.execute("SELECT COUNT(*) FROM solved_problems WHERE username=?", (u,)).fetchone()[0]
        sp = c.execute("SELECT m.id, m.title, m.xp FROM solved_problems s JOIN initial_misions m ON s.problem_id = m.id WHERE s.username = ?", (u,)).fetchall()
    
    tr = "".join(f"<tr><td>{p[0]}</td><td>{p[1]}</td><td>+{p[2]}</td></tr>" for p in sp)

    with open(os.path.join(D_F, "account.html"), "r", encoding="utf-8") as f: 
        h = f.read()
    
    return h.replace("{{u}}", u)\
            .replace("{{dname}}", str(dname or u))\
            .replace("{{avatar}}", av)\
            .replace("{{rnk}}", rnk)\
            .replace("{{l}}", str(l))\
            .replace("{{xp}}", str(xp))\
            .replace("{{ps}}", str(ps))\
            .replace("{{pr}}", str(pr))\
            .replace("{{tr}}", tr)

@app.route("/api/update_profile", methods=["POST"])
def update_profile():
    u = get_u()
    if not u: return {"success": False, "msg": "Login required"}
    
    data = request.json
    old_p = data.get("old_password")
    new_p = data.get("new_password")
    new_dname = data.get("display_name")
    new_avatar = data.get("avatar_url") # <--- YOU WERE MISSING THIS
    
    with sqlite3.connect(DB_U) as c:
        db_p = c.execute("SELECT password FROM users WHERE username=?", (u,)).fetchone()[0]
        if db_p != old_p:
            return {"success": False, "msg": "Incorrect old password."}
        
        if new_dname and new_dname.strip():
            c.execute("UPDATE users SET display_name = ? WHERE username = ?", (new_dname.strip(), u))
        
        # Now this works because new_avatar is defined above
        if new_avatar and new_avatar.strip():
            c.execute("UPDATE users SET avatar_url = ? WHERE username = ?", (new_avatar.strip(), u))
        
        if new_p and len(new_p) > 5:
            c.execute("UPDATE users SET password = ? WHERE username = ?", (new_p, u))
            
    return {"success": True, "msg": "Profile updated successfully!"}

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
    return f"<!DOCTYPE html><html><head><meta charset='UTF-8'><title>Practice</title><link rel='stylesheet' href='/style.css'></head><body><header><h1>ChanceField</h1><p>> PRACTICE MAKES PERFECT</p></header><main>{core}<br><div style='text-align:center;'><a href='/' class='back-btn'>← Back Home</a></div></main></body></html>"

@app.route("/practice/<id>")
def prc_id(id):
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    
    with sqlite3.connect(DB_U) as c:
        # 1. Fetch Problem
        m = c.execute("SELECT title, xp, statement FROM initial_misions WHERE id=?", (id,)).fetchone()
        if not m: return "404", 404
        
        # 2. Check if Solved
        solved = c.execute("SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, id)).fetchone()
        
    # 3. Prepare display status
    status_msg = "✅ Solved" if solved else "❌ Not Solved"
    
    with open(os.path.join(D_F, "problem.html"), "r", encoding="utf-8") as f: 
        h = f.read()
        
    # 4. Inject all variables, including the status
    return h.replace("{{id}}", id)\
            .replace("{{u}}", u)\
            .replace("{{t}}", m[0])\
            .replace("{{xp}}", str(m[1]))\
            .replace("{{stmt}}", m[2])\
            .replace("{{status}}", status_msg)

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

        # 3. Award XP AND increment problems_solved
        # CHANGE THIS LINE:
        c.execute("UPDATE users SET xp = xp + ?, problems_solved = problems_solved + 1 WHERE username=?", (m[1], u))
        c.execute("INSERT INTO solved_problems (username, problem_id) VALUES (?, ?)", (u, prob_id))
        
        return {"success": True, "msg": f"Correct! +{m[1]} XP earned."}
    
@app.route("/learn")
def learn_page():
    with open(os.path.join(D_F, "learn.html"), "r", encoding="utf-8") as f:
        return f.read()
    
#@app.route("/learn")
def learn_page():
    with sqlite3.connect(DB_U) as c:
        lessons = c.execute("SELECT title, description, link FROM lessons").fetchall()
    
    # Generate the HTML cards dynamically
    cards = ""
    for title, desc, link in lessons:
        cards += f'''
        <div class="learn-module">
            <h3>{title}</h3>
            <p>{desc}</p>
            <br>
            <a href="{link}" class="back-btn">Start Lesson</a>
        </div>
        '''
    
    # Return the page with the cards injected
    return f"""
    <!DOCTYPE html>
    <html>
    <head><link rel="stylesheet" href="frontend/style.css"></head>
    <body>
        <main style="max-width: 1000px; margin: 0 auto;">
            <section class="window">
                <h2>CURRICULUM</h2>
                <div class="learn-grid">{cards}</div>
            </section>
        </main>
    </body>
    </html>
    """
    
@app.route("/ranking")
def ranking_page():
    page = request.args.get('page', 1, type=int)
    if page < 1: page = 1
    per_page = 50
    offset = (page - 1) * per_page
    
    with sqlite3.connect(DB_U) as c:
        # Use COALESCE here to get Display Name as the first column
        users = c.execute("""
            SELECT COALESCE(display_name, username), rank, level, xp, problems_solved 
            FROM users 
            ORDER BY xp DESC, problems_solved DESC 
            LIMIT ? OFFSET ?
        """, (per_page, offset)).fetchall()
        
        total_users = c.execute("SELECT COUNT(*) FROM users").fetchone()[0]
        
    rows_html = ""
    for i, u in enumerate(users):
        pos = offset + i + 1
        # u[0] is now the Display Name automatically
        rows_html += f"<tr><td>#{pos}</td><td>{u[0]}</td><td>{u[1]}</td><td>{u[2]}</td><td>{u[3]}</td><td>{u[4]}</td></tr>"
        
    prev_btn = f"<a href='/ranking?page={page-1}' class='back-btn'>← Prev 50</a>" if page > 1 else "<div></div>"
    next_btn = f"<a href='/ranking?page={page+1}' class='back-btn'>Next 50 →</a>" if offset + per_page < total_users else "<div></div>"
    
    with open(os.path.join(D_F, "ranking.html"), "r", encoding="utf-8") as f:
        h = f.read()
        
    return h.replace("{{rows}}", rows_html).replace("{{prev}}", prev_btn).replace("{{next}}", next_btn)

@app.route("/frontend/ranking_snippet.html")
def ranking_snippet():
    with sqlite3.connect(DB_U) as c:
        # Use COALESCE here too
        users = c.execute("SELECT COALESCE(display_name, username), xp FROM users ORDER BY xp DESC LIMIT 5").fetchall()
        
    rows = "".join(f"<tr><td>{u[0]}</td><td>{u[1]} XP</td></tr>" for u in users)
    
    return f"""
    <h2>TOP USERS</h2>
    <table class="rank-table">
        <tr><th>Agent</th><th>XP</th></tr>
        {rows}
    </table>
    """

@app.route("/problem/<id>")
@app.route("/problem/<id>")
def problem_page(id):
    u = get_u()
    
    # 1. Fetch Problem AND User Avatar
    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT title, xp, statement FROM initial_misions WHERE id=?", (id,)).fetchone()
        
        # Fetch Avatar
        av = "https://i.imgur.com/8Km9tLL.png" # Default fallback
        solved = False
        if u:
            user_data = c.execute("SELECT avatar_url FROM users WHERE username=?", (u,)).fetchone()
            if user_data and user_data[0]:
                av = user_data[0]
            
            # Check if Solved
            if c.execute("SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, id)).fetchone():
                solved = True
    
    if not m: return "404", 404
    
    # 3. Prepare display status
    status_msg = "✅ Solved" if solved else "❌ Not Solved"
    
    with open(os.path.join(D_F, "problem.html"), "r", encoding="utf-8") as f: 
        h = f.read()
        
    # 4. Inject all variables (added {{avatar}})
    return h.replace("{{id}}", id)\
            .replace("{{u}}", u if u else "Guest")\
            .replace("{{avatar}}", av)\
            .replace("{{t}}", m[0])\
            .replace("{{xp}}", str(m[1]))\
            .replace("{{stmt}}", m[2])\
            .replace("{{status}}", status_msg)

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
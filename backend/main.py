from flask import Flask, request, make_response, redirect, send_from_directory, jsonify
from datetime import datetime, timedelta
import secrets, sqlite3, re, os, math, html, subprocess, tempfile, shutil, json
from urllib.parse import urlencode
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
from werkzeug.security import generate_password_hash, check_password_hash
from dotenv import load_dotenv
try:
    import resource  # POSIX only; used for best-effort CPU/memory limits on judged code
except ImportError:
    resource = None

app = Flask(__name__)

D_B = os.path.dirname(os.path.abspath(__file__))
D_R = os.path.dirname(D_B)
D_F = os.path.join(D_R, "frontend")
DB_U = os.path.join(D_B, "users.db")
DB_C = os.path.join(D_B, "cookies.db")

# Load .env from the project root regardless of cwd, so `python main.py`
# (run from backend/, per README) and the Docker image (cwd /app, per
# Dockerfile) both pick it up the same way. Copy .env.example -> .env and
# fill in real values; .env itself is gitignored/dockerignored so secrets
# never get committed or baked into an image layer. Vars already set in the
# real environment (e.g. by docker run -e / a compose file) win, since
# load_dotenv() defaults to not overriding existing os.environ entries.
load_dotenv(os.path.join(D_R, ".env"))

# Port the Flask dev server binds to (see app.run() at the bottom of this
# file). Configurable via PORT in .env / the environment instead of being
# hardcoded, so it matches whatever the surrounding infra (Docker port
# mapping, reverse proxy, etc.) expects it to listen on.
PORT = int(os.environ.get("PORT", 6767))

def init():
    # Session-cookie store lives in a separate DB (DB_C) from the main user
    # data (DB_U). Without this, a fresh/cleared cookies.db has no `users`
    # table and every login attempt fails with "no such table: users".
    with sqlite3.connect(DB_C) as c:
        c.execute("""CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            cookie TEXT,
            expire TEXT
        )""")

    with sqlite3.connect(DB_U) as c:
        # Create users table (Now includes avatar_url and display_name)
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
            xp INTEGER DEFAULT 0,
            avatar_url TEXT,
            display_name TEXT
        )""")

        # Migrate: add is_admin column if it doesn't exist yet
        user_cols = {row[1] for row in c.execute("PRAGMA table_info(users)").fetchall()}
        if "is_admin" not in user_cols:
            c.execute("ALTER TABLE users ADD COLUMN is_admin INTEGER DEFAULT 0")

        # Migrate: moderation columns — is_banned (account lockout) and
        # warning_message (a pending admin message shown to the user next
        # time they load a page; cleared once acknowledged). See
        # enforce_account_ban() / inject_pending_alerts() below.
        if "is_banned" not in user_cols:
            c.execute("ALTER TABLE users ADD COLUMN is_banned INTEGER DEFAULT 0")
        if "warning_message" not in user_cols:
            c.execute("ALTER TABLE users ADD COLUMN warning_message TEXT")

        # Create initial_misions table
        c.execute("""CREATE TABLE IF NOT EXISTS initial_misions (
            id TEXT PRIMARY KEY, 
            title TEXT, 
            xp INTEGER, 
            answer TEXT, 
            statement TEXT,
            type TEXT DEFAULT 'answer'
        )""")

        # Migrate: add type column if it doesn't exist yet
        prob_cols = {row[1] for row in c.execute("PRAGMA table_info(initial_misions)").fetchall()}
        if "type" not in prob_cols:
            c.execute("ALTER TABLE initial_misions ADD COLUMN type TEXT DEFAULT 'answer'")
            c.execute("UPDATE initial_misions SET type = 'answer' WHERE type IS NULL")

        # Migrate: add test_input column — stdin fed to code-type submissions
        # before checking their stdout against the `answer` column. Empty for
        # answer-type problems (unused) and for code problems that don't
        # read from stdin.
        if "test_input" not in prob_cols:
            c.execute("ALTER TABLE initial_misions ADD COLUMN test_input TEXT DEFAULT ''")
            c.execute("UPDATE initial_misions SET test_input = '' WHERE test_input IS NULL")

        # Migrate: official solution fields (code-type problems only, but the
        # columns live on every row regardless of type)
        prob_cols2 = {row[1] for row in c.execute("PRAGMA table_info(initial_misions)").fetchall()}
        if "official_solution" not in prob_cols2:
            c.execute("ALTER TABLE initial_misions ADD COLUMN official_solution TEXT")
        if "official_solution_lang" not in prob_cols2:
            c.execute("ALTER TABLE initial_misions ADD COLUMN official_solution_lang TEXT DEFAULT 'sage'")
        
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
            link TEXT,
            type TEXT DEFAULT 'text',
            difficulty TEXT DEFAULT '10'
        )""")

        # Migrate older lessons tables that predate the type/difficulty columns
        existing_cols = {row[1] for row in c.execute("PRAGMA table_info(lessons)").fetchall()}
        if "type" not in existing_cols:
            c.execute("ALTER TABLE lessons ADD COLUMN type TEXT DEFAULT 'text'")
        if "difficulty" not in existing_cols:
            c.execute("ALTER TABLE lessons ADD COLUMN difficulty TEXT DEFAULT '10'")
        # Migrate: 'content' column holds raw HTML (with LaTeX math, rendered
        # client-side via MathJax) for type='article' lessons. 'link' stays
        # unused for these rows — article lessons don't point at a file.
        if "content" not in existing_cols:
            c.execute("ALTER TABLE lessons ADD COLUMN content TEXT DEFAULT ''")

        # Comments on problem pages, plus one-vote-per-user tracking so a
        # user's up/downvote can be toggled off or switched cleanly.
        c.execute("""CREATE TABLE IF NOT EXISTS comments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            problem_id TEXT NOT NULL,
            username TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL,
            score INTEGER DEFAULT 0
        )""")

        c.execute("""CREATE TABLE IF NOT EXISTS comment_votes (
            comment_id INTEGER NOT NULL,
            username TEXT NOT NULL,
            vote INTEGER NOT NULL,
            PRIMARY KEY (comment_id, username)
        )""")

        # User-submitted reports on comments, for admin moderation. UNIQUE
        # stops one user from reporting the same comment repeatedly.
        c.execute("""CREATE TABLE IF NOT EXISTS comment_reports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            comment_id INTEGER NOT NULL,
            reporter_username TEXT NOT NULL,
            reason TEXT,
            created_at TEXT NOT NULL,
            resolved INTEGER DEFAULT 0,
            UNIQUE(comment_id, reporter_username)
        )""")

        # Blog: posts, one-vote-per-user tracking (up/downvote, toggle-able
        # the same way comment_votes works), and simple comments.
        c.execute("""CREATE TABLE IF NOT EXISTS blog_posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL,
            score INTEGER DEFAULT 0
        )""")

        c.execute("""CREATE TABLE IF NOT EXISTS blog_votes (
            post_id INTEGER NOT NULL,
            username TEXT NOT NULL,
            vote INTEGER NOT NULL,
            PRIMARY KEY (post_id, username)
        )""")

        c.execute("""CREATE TABLE IF NOT EXISTS blog_comments (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            post_id INTEGER NOT NULL,
            username TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL
        )""")

        # User-submitted solutions to code-type problems, plus an upvote-only
        # vote table (one vote per user per solution — no downvote, matching
        # a simple "helpful / not yet voted" model rather than full up/down).
        c.execute("""CREATE TABLE IF NOT EXISTS user_solutions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            problem_id TEXT NOT NULL,
            username TEXT NOT NULL,
            language TEXT NOT NULL,
            code TEXT NOT NULL,
            is_public INTEGER DEFAULT 1,
            votes INTEGER DEFAULT 0,
            created_at TEXT NOT NULL
        )""")

        c.execute("""CREATE TABLE IF NOT EXISTS user_solution_votes (
            solution_id INTEGER NOT NULL,
            username TEXT NOT NULL,
            PRIMARY KEY (solution_id, username)
        )""")

def val_u(u):
    return bool(re.fullmatch(r"[A-Za-z0-9_]+", u))

# ── Password hashing ──
# Accounts created before this was added have plaintext passwords sitting
# in the DB. Rather than a one-off migration script (which would need
# everyone's plaintext password, which we don't have), legacy passwords are
# upgraded to a hash transparently the next time their owner successfully
# logs in or confirms their old password (see log() and update_profile()).
HASH_PREFIXES = ("pbkdf2:", "scrypt:", "argon2")

def hash_password(pw):
    return generate_password_hash(pw)

def is_hashed(pw):
    return bool(pw) and pw.startswith(HASH_PREFIXES)

def verify_password(stored, candidate):
    """True if `candidate` matches `stored`. Handles both new
    werkzeug-hashed passwords and legacy plaintext ones."""
    if not stored or candidate is None:
        return False
    if is_hashed(stored):
        try:
            return check_password_hash(stored, candidate)
        except ValueError:
            return False
    return stored == candidate

# ── Admin ──
# Change this before deploying anywhere real — it's the bootstrap secret used
# to grant the very first admin account (see /api/admin/promote below), since
# a brand new admin has no existing admin to promote them.
ADMIN_SECRET = os.environ.get("ADMIN_SECRET", "admin@12345")

def is_admin(u):
    if not u:
        return False
    with sqlite3.connect(DB_U) as c:
        r = c.execute("SELECT is_admin FROM users WHERE username=?", (u,)).fetchone()
    return bool(r and r[0])

def is_banned(u):
    if not u:
        return False
    with sqlite3.connect(DB_U) as c:
        r = c.execute("SELECT is_banned FROM users WHERE username=?", (u,)).fetchone()
    return bool(r and r[0])

def banned_page_html(u):
    """Full-page takeover shown to a banned user for any page they try to
    load while still holding a valid session cookie (see enforce_account_ban
    below). Deliberately does NOT expose the account/logout nav so a banned
    user can't casually keep browsing - the only way forward is Log Out."""
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Banned - ChanceField</title>
    <link rel="stylesheet" href="/style.css">
</head>
<body>
<header>
    <h1>ChanceField</h1>
    <p>&gt; ACCESS DENIED</p>
</header>
<main>
    <section class="window" style="max-width:600px; margin:100px auto; text-align:center; border-color:#ff3030; box-shadow:0 0 24px rgba(255,48,48,0.45);">
        <h2 style="color:#ff3030; text-shadow:0 0 10px #ff3030;">⛔ ACCOUNT BANNED</h2>
        <p style="font-size:1.35rem; margin:22px 0;">The account <strong>{html.escape(u)}</strong> has been suspended by an administrator.</p>
        <p style="opacity:0.8; margin-bottom:26px;">You can no longer use this account. If you believe this is a mistake, please contact support.</p>
        <a href="/logout" class="back-btn" style="border-color:#ff3030; color:#ff3030; text-shadow:0 0 5px #ff3030; box-shadow:0 0 5px #ff3030, inset 0 0 5px rgba(255,48,48,0.2);">Log Out</a>
    </section>
</main>
</body>
</html>"""

def build_warning_popup_html(message):
    """Big, centered, unmissable modal shown to a user with a pending admin
    warning - injected into every HTML page they load (see
    inject_pending_alerts below) until they click 'I UNDERSTAND', which
    clears warning_message server-side via /api/warning/ack."""
    safe_msg = html.escape(message)
    return f'''
<div id="cf-warning-backdrop" style="position:fixed; inset:0; background:rgba(0,0,0,0.88); z-index:99998;"></div>
<div id="cf-warning-modal" role="alertdialog" aria-modal="true" aria-labelledby="cf-warning-title"
     style="position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); z-index:99999;
            width:min(560px, 90vw); background:#000; border:3px solid #ffcc00;
            box-shadow:0 0 40px rgba(255,204,0,0.6); padding:36px; text-align:center;
            font-family:'VT323', monospace;">
    <div style="font-size:3rem; margin-bottom:10px;">⚠</div>
    <h2 id="cf-warning-title" style="color:#ffcc00; text-shadow:0 0 10px #ffcc00; font-size:2rem; margin-bottom:18px; letter-spacing:2px;">
        ADMIN WARNING
    </h2>
    <p style="color:#fff; font-size:1.3rem; line-height:1.5; white-space:pre-wrap; word-break:break-word; margin-bottom:26px;">{safe_msg}</p>
    <button type="button" onclick="cfAckWarning()"
            style="background:#ffcc00; color:#000; border:2px solid #ffcc00; padding:14px 32px;
                   font-size:1.3rem; font-family:inherit; cursor:pointer; font-weight:bold;">
        I UNDERSTAND
    </button>
</div>
<script>
(function () {{
    document.body.style.overflow = 'hidden';
    window.cfAckWarning = function () {{
        fetch('/api/warning/ack', {{ method: 'POST' }}).catch(function () {{}});
        var m = document.getElementById('cf-warning-modal');
        var b = document.getElementById('cf-warning-backdrop');
        if (m) m.remove();
        if (b) b.remove();
        document.body.style.overflow = '';
    }};
}})();
</script>
'''

# ── Rank system ──
# Ordered ascending by xp threshold. To retune progression later, just edit
# this list — add, remove, rename, or re-threshold tiers; get_rank_info()
# simply walks it top-down and doesn't care how many entries there are.
# Gaps grow each tier so climbing gets progressively harder.
RANK_TIERS = [
    ("NOOB",         0,    "#b0b0b0"),   # grey
    ("INTERMEDIATE", 300,  "#00ff66"),   # green
    ("PRO",          1000, "#3399ff"),   # blue
    ("HACKER",       3000, "#ffcc00"),   # yellow
    ("GOD",          8000, "#ff3030"),   # red
]
ADMIN_RANK = ("ADMIN", "#ffffff")  # white — exclusive, overrides xp entirely

def get_rank_info(xp, admin=False):
    """Returns (rank_name, color_hex) for a given xp total. Admins always
    get the exclusive ADMIN rank regardless of xp."""
    if admin:
        return ADMIN_RANK
    xp = xp or 0
    current = RANK_TIERS[0]
    for tier in RANK_TIERS:
        if xp >= tier[1]:
            current = tier
        else:
            break
    return current[0], current[2]

def rank_badge_html(name, color):
    return f'<span style="color:{color}; font-weight:bold; text-shadow:0 0 4px {color};">{name}</span>'

def colored_name_html(name, color):
    return f'<span style="color:{color}; text-shadow:0 0 4px {color};">{name}</span>'

def colored_name_link_html(username, display_name, color):
    """Same as colored_name_html but wraps the name in a link to that user's
    public profile page — used on the leaderboard so names are clickable."""
    return (f'<a href="/user/{username}" '
            f'style="color:{color}; text-shadow:0 0 4px {color}; text-decoration:none;" '
            f'onmouseover="this.style.textDecoration=\'underline\'" '
            f'onmouseout="this.style.textDecoration=\'none\'">{display_name}</a>')

def build_search_results_html(q):
    if not q:
        return '<p class="search-empty">Type a username or display name to search.</p>'

    with sqlite3.connect(DB_U) as c:
        matches = c.execute(
            "SELECT username, COALESCE(display_name, username), xp, is_admin FROM users "
            "WHERE username LIKE ? OR display_name LIKE ? ORDER BY xp DESC LIMIT 50",
            (f"%{q}%", f"%{q}%")
        ).fetchall()

    if not matches:
        return f'<p class="search-empty">No users found matching "{q}".</p>'

    items = []
    for uname, dname, xp, admin_flag in matches:
        rank_name, rank_color = get_rank_info(xp, bool(admin_flag))
        item = (
            '<div class="search-result-item">'
            f'<a href="/user/{uname}" class="search-result-link">'
            f'{colored_name_html(dname, rank_color)}'
            f'<span class="search-result-handle">@{uname}</span>'
            '</a>'
            f'{rank_badge_html(rank_name, rank_color)}'
            '</div>'
        )
        items.append(item)
    return "\n".join(items)

def pct(num, den):
    """Safe percentage for progress bars — 0 when there's nothing to divide by,
    capped at 100 so a stale/deleted problem can't push a bar past full."""
    if not den:
        return 0
    return min(100, round(100 * num / den))

# ── Comment moderation ──
# A small, non-exhaustive profanity list plus a couple of privacy guards
# (email / phone patterns). This is a first line of defense, not a complete
# solution — pair it with user reporting / admin moderation for real use.
BAD_WORDS = {
    "fuck", "shit", "bitch", "asshole", "bastard", "dumbass",
    "piss", "slut", "whore", "dick", "prick", "cunt", "retard",
}
EMAIL_RE = re.compile(r'[\w\.-]+@[\w\.-]+\.\w+')
PHONE_RE = re.compile(r'\b\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\b')
COMMENT_MAX_LEN = 500

def moderate_comment(text):
    """Returns (clean_text, None) on success or (None, error_message) on
    rejection. Checked server-side so it can't be bypassed from the client."""
    text = (text or "").strip()
    if not text:
        return None, "Comment can't be empty."
    if len(text) > COMMENT_MAX_LEN:
        return None, f"Comments are limited to {COMMENT_MAX_LEN} characters."

    lowered = text.lower()
    for w in BAD_WORDS:
        if re.search(rf'\b{re.escape(w)}\b', lowered):
            return None, "Please keep comments respectful — that language isn't allowed here."

    if EMAIL_RE.search(text):
        return None, "For your privacy and safety, please don't post email addresses."
    if PHONE_RE.search(text):
        return None, "For your privacy and safety, please don't post phone numbers."

    return text, None

def resolve_lesson_link(link):
    """DB stores lesson links as paths relative to frontend/ (e.g. 'lessons/test.mp4'),
    or full http(s) URLs. Used bare, a relative path breaks under /lesson/<id> because
    the browser resolves it relative to that URL instead of to the site root.
    This normalizes it to something that actually resolves."""
    link = (link or "").strip()
    if link.lower().startswith("http://") or link.lower().startswith("https://"):
        return link
    return "/frontend/" + link.lstrip("/")

def get_u():
    ck = request.cookies.get("session")
    if not ck: return None
    with sqlite3.connect(DB_C) as c: r = c.execute("SELECT username, expire FROM users WHERE cookie=?", (ck,)).fetchone()
    if r:
        try:
            if datetime.now() < datetime.strptime(r[1], "%Y-%m-%d %H:%M:%S"): return r[0]
        except: pass
    return None

def nav_html(u):
    """Builds the <nav> contents shared by every page. Logged-out users see
    LOGIN/REGISTER; logged-in users see ACCOUNT (username)/LOGOUT instead.
    Laid out in two groups — site navigation (Home/Learn/Practice/Ranking) on
    the left, account/auth actions and the user-search box on the right —
    similar to a Codeforces-style header.
    The current page is marked with aria-current="page" so it's visibly
    highlighted in nav (a11y + orientation for the user).
    A small user-search form rides along on the right, after the auth links
    (Logout / Login), so people can jump to anyone's profile from anywhere
    on the site."""
    path = request.path

    def mark(route):
        return ' aria-current="page"' if path == route else ''

    search_form = '''<form action="/search" method="GET" class="nav-search-form" role="search">
        <label for="nav-search-input" class="sr-only">Search users</label>
        <input type="text" id="nav-search-input" name="q" placeholder="Find a user..." class="nav-search-input" autocomplete="off">
        <button type="submit" class="nav-search-btn" aria-label="Search users">\U0001f50d</button>
    </form>'''

    nav_left = f'''<a href="/"{mark("/")}>HOME</a>
    <a href="/blog"{mark("/blog")}>BLOG</a>
    <a href="/learn"{mark("/learn")}>LEARN</a>
    <a href="/practice"{mark("/practice")}>PRACTICE</a>
    <a href="/ranking"{mark("/ranking")}>RANKING</a>'''

    if u:
        admin_link = ''
        if is_admin(u):
            admin_link = f'\n    <a href="/admin" style="color:#ffcc00; border-color:#ffcc00;"{mark("/admin")}>ADMIN</a>'
        nav_right = f'''<a href="/frontend/account.html"{mark("/frontend/account.html")}>ACCOUNT ({u})</a>{admin_link}
    <a href="/logout" style="color: #ff3030; border-color: #ff3030;">LOGOUT</a>
    {search_form}'''
    else:
        nav_right = f'''<a href="/frontend/register.html"{mark("/frontend/register.html")}>REGISTER</a>
    <a href="/frontend/login.html"{mark("/frontend/login.html")}>LOGIN</a>
    {search_form}'''

    return f'''<div class="nav-left">
    {nav_left}
    </div>
    <div class="nav-right">
    {nav_right}
    </div>'''

# ── Ban enforcement + pending-warning delivery ──
# Runs on every request/response, site-wide, so no individual route has to
# remember to check these itself.
BAN_EXEMPT_PATHS = {"/logout"}
STATIC_EXTS = (".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".svg", ".ico",
               ".mp4", ".pdf", ".woff", ".woff2", ".map")

@app.before_request
def enforce_account_ban():
    """A banned user keeps their session (so they see the ban message rather
    than just silently landing on a login screen) but every page they
    request — other than static assets and /logout — is replaced with a
    full-page 'ACCOUNT BANNED' notice. API calls get a plain 403 instead of
    banned_page_html since they're consumed by JS, not rendered."""
    u = get_u()
    if not u or not is_banned(u):
        return None
    path = request.path
    if path in BAN_EXEMPT_PATHS:
        return None
    if path.lower().endswith(STATIC_EXTS):
        return None
    if path.startswith("/api/"):
        return jsonify({"success": False, "msg": "Your account has been banned."}), 403
    return banned_page_html(u), 403

@app.after_request
def inject_pending_alerts(resp):
    """If the logged-in viewer has a pending admin warning_message, injects
    the big centered warning modal (build_warning_popup_html) into every
    HTML page right before </body>. It stays showing on every page until
    the user clicks 'I UNDERSTAND', which POSTs /api/warning/ack to clear
    it — so it's guaranteed to be seen even if they close the tab first."""
    try:
        ctype = resp.content_type or ""
        if ctype.startswith("text/html"):
            u = get_u()
            if u:
                with sqlite3.connect(DB_U) as c:
                    row = c.execute("SELECT warning_message FROM users WHERE username=?", (u,)).fetchone()
                if row and row[0]:
                    body = resp.get_data(as_text=True)
                    if "</body>" in body:
                        body = body.replace("</body>", build_warning_popup_html(row[0]) + "</body>", 1)
                        resp.set_data(body)
    except Exception:
        pass
    return resp

@app.route("/api/warning/ack", methods=["POST"])
def ack_warning():
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Login required."}), 401
    with sqlite3.connect(DB_U) as c:
        c.execute("UPDATE users SET warning_message=NULL WHERE username=?", (u,))
    return jsonify({"success": True})

def build_pagination(current, total_pages, url_for_page):
    """Renders a page-number strip (\u00ab Prev  1 \u2026 4 [5] 6 \u2026 12  Next \u00bb  Page 5 of 12)
    shared by /learn, /practice, and /ranking. url_for_page(n) must return the
    full href for page n, with any other query params (search, filters) preserved."""
    if total_pages <= 1:
        return ""

    def link(p, label=None, disabled=False, active=False):
        label = label if label is not None else str(p)
        classes = "page-link"
        if active: classes += " page-link-active"
        if disabled: classes += " page-link-disabled"
        href = url_for_page(p) if not disabled else "#"
        return f'<a href="{href}" class="{classes}">{label}</a>'

    parts = [link(max(1, current - 1), "\u00ab Prev", disabled=(current == 1))]

    show = sorted({p for p in (1, total_pages, current - 1, current, current + 1) if 1 <= p <= total_pages})
    last = 0
    for p in show:
        if last and p - last > 1:
            parts.append('<span class="page-ellipsis">\u2026</span>')
        parts.append(link(p, active=(p == current)))
        last = p

    parts.append(link(min(total_pages, current + 1), "Next \u00bb", disabled=(current == total_pages)))
    parts.append(f'<span class="page-info">Page {current} of {total_pages}</span>')
    return "\n".join(parts)

@app.route("/")
@app.route("/main")
def mn():
    u = get_u()
    with open(os.path.join(D_R, "index.html"), "r", encoding="utf-8") as f: h = f.read()
    return h.replace("{{nav}}", nav_html(u))

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
    if r and verify_password(r[0], p):
        if not is_hashed(r[0]):
            # First successful login on a legacy plaintext password — upgrade it.
            with sqlite3.connect(DB_U) as c: c.execute("UPDATE users SET password=? WHERE username=?", (hash_password(p), u))
        t, e = secrets.token_hex(16), (datetime.now() + timedelta(days=1)).strftime("%Y-%m-%d %H:%M:%S")
        with sqlite3.connect(DB_C) as c: c.execute("INSERT INTO users (username, cookie, expire) VALUES (?, ?, ?)", (u, t, e))
        res = make_response("7")
        res.set_cookie("session", t, max_age=86400, httponly=True)
        return res
    return "8"

@app.route("/frontend/login.html")
def show_login():
    with open(os.path.join(D_F, "login.html"), "r", encoding="utf-8") as f:
        h = f.read()
    return h.replace("{{nav}}", nav_html(get_u()))

@app.route("/frontend/register.html", methods=["GET", "POST"])
# 1. This serves the registration page
@app.route("/frontend/register.html")
def show_register():
    with open(os.path.join(D_F, "register.html"), "r", encoding="utf-8") as f:
        h = f.read()
    return h.replace("{{nav}}", nav_html(get_u()))

# 2. This handles the form submission (API)
@app.route("/register", methods=["POST"])
def handle_register():
    u = request.form.get("username")
    e = request.form.get("email")
    p = request.form.get("password")
    cp = request.form.get("confirm_password")

    # 0. Presence checks — without this, a request missing any of these
    # fields (e.g. a raw POST that skips the HTML form's `required`
    # attributes) crashes with a TypeError from len(None) below instead of
    # returning a normal validation error.
    if not u or not p or not cp:
        return jsonify({"success": False, "msg": "Username and password are required."}), 400

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
            c.execute("INSERT INTO users (username, password, email) VALUES (?, ?, ?)", (u, hash_password(p), e))
        return jsonify({"success": True, "msg": "Registered successfully!"})
    except sqlite3.IntegrityError:
        return jsonify({"success": False, "msg": "Username already exists."}), 400

# Markers in account.html bracket the settings button and settings modal+
# script so the same template can serve both the editable "my account" page
# and a read-only public profile — just strip these blocks out for the latter.
SETTINGS_BTN_RE = re.compile(r"<!-- SETTINGS_BTN_START -->.*?<!-- SETTINGS_BTN_END -->", re.DOTALL)
SETTINGS_MODAL_RE = re.compile(r"<!-- SETTINGS_MODAL_START -->.*?<!-- SETTINGS_MODAL_END -->", re.DOTALL)

def build_admin_actions_html(target_username, is_banned_flag, pending_warning):
    """Ban + Warn controls shown to an admin viewing someone else's profile.
    Kept as plain inline styles (matching the rest of the file's approach)
    rather than new CSS classes, so this drops in without touching style.css.
    Ban toggles instantly; Warn opens a modal where the admin types free text
    that gets shown to the user as a big popup next time they load a page
    (see build_warning_popup_html / inject_pending_alerts in main.py)."""
    ban_label = "Unban User" if is_banned_flag else "Ban User"
    ban_action = "unban" if is_banned_flag else "ban"
    ban_icon = "\U0001F513" if is_banned_flag else "\U0001F6AB"

    banned_badge = ""
    if is_banned_flag:
        banned_badge = ('<p style="color:#ff3030; font-weight:bold; text-shadow:0 0 6px #ff3030; '
                        'margin-top:10px;">\u26D4 THIS ACCOUNT IS CURRENTLY BANNED</p>')

    pending_note = ""
    if pending_warning:
        pending_note = (
            '<div style="margin-top:10px; padding:10px 12px; border:1px solid #ffcc00; '
            'background:rgba(255,204,0,0.06); font-size:0.95rem;">'
            '<strong style="color:#ffcc00;">\u23F3 Unacknowledged warning pending:</strong> '
            f'<span style="opacity:0.85;">{html.escape(pending_warning)}</span><br>'
            f'<button type="button" class="back-btn" style="margin-top:8px; padding:6px 16px; '
            'font-size:0.9rem; border-color:#ffcc00; color:#ffcc00;" '
            f'onclick="clearPendingWarning()">Clear Warning</button>'
            '</div>'
        )

    return f'''
    {banned_badge}
    {pending_note}
    <div class="admin-actions-row" style="display:flex; gap:10px; margin-top:16px;">
        <button type="button" class="back-btn" style="flex:1; border-color:#ffcc00; color:#ffcc00; text-shadow:0 0 5px #ffcc00; box-shadow:0 0 5px #ffcc00, inset 0 0 5px rgba(255,204,0,0.2);" onclick="openWarnModal()">\u26A0 Warn User</button>
        <button type="button" id="admin-ban-btn" class="back-btn" style="flex:1; border-color:#ff3030; color:#ff3030; text-shadow:0 0 5px #ff3030; box-shadow:0 0 5px #ff3030, inset 0 0 5px rgba(255,48,48,0.2);" data-action="{ban_action}" onclick="toggleBan(this)">{ban_icon} {ban_label}</button>
    </div>

    <div id="warn-backdrop" class="modal-backdrop" style="display:none;" onclick="closeWarnModal()"></div>
    <div id="warn-modal" class="window modal-window" role="dialog" aria-modal="true" aria-labelledby="warn-title"
         style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); width:500px; background:#000; z-index:1000; padding:30px; border:2px solid #ffcc00; box-shadow:0 0 20px rgba(255,204,0,0.4);">
        <h3 id="warn-title" style="color:#ffcc00; text-shadow:0 0 6px #ffcc00;">\u26A0 Send Warning to {target_username}</h3>
        <label for="warn_text">Warning message (shown as a popup on their next page load):</label>
        <textarea id="warn_text" class="comment-input" rows="4" maxlength="1000" placeholder="Type the warning message this user will see..." style="width:100%; margin:8px 0 14px;"></textarea>
        <div style="display:flex; gap:10px;">
            <button type="button" class="back-btn" style="flex:1; border-color:#ffcc00; color:#ffcc00;" onclick="sendWarning()">Send Warning</button>
            <button type="button" class="back-btn" style="flex:1; background:#333;" onclick="closeWarnModal()">Cancel</button>
        </div>
    </div>

    <script>
    function openWarnModal() {{
        document.getElementById('warn-modal').style.display = 'block';
        document.getElementById('warn-backdrop').style.display = 'block';
        document.getElementById('warn_text').focus();
    }}
    function closeWarnModal() {{
        document.getElementById('warn-modal').style.display = 'none';
        document.getElementById('warn-backdrop').style.display = 'none';
    }}
    document.addEventListener('keydown', function (e) {{ if (e.key === 'Escape') closeWarnModal(); }});

    async function sendWarning() {{
        const msg = document.getElementById('warn_text').value.trim();
        if (!msg) {{ showNotification('Please type a warning message.', 'error'); return; }}
        try {{
            const res = await fetch('/api/admin/users/{target_username}/warn', {{
                method: 'POST',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{ message: msg }})
            }});
            const data = await res.json();
            showNotification(data.msg, data.success ? 'success' : 'error');
            if (data.success) {{ closeWarnModal(); setTimeout(function () {{ location.reload(); }}, 700); }}
        }} catch (e) {{
            showNotification('Error sending warning.', 'error');
        }}
    }}

    async function clearPendingWarning() {{
        try {{
            const res = await fetch('/api/admin/users/{target_username}/clear_warning', {{ method: 'POST' }});
            const data = await res.json();
            showNotification(data.msg, data.success ? 'success' : 'error');
            if (data.success) setTimeout(function () {{ location.reload(); }}, 500);
        }} catch (e) {{
            showNotification('Error clearing warning.', 'error');
        }}
    }}

    async function toggleBan(btn) {{
        const action = btn.dataset.action;
        const confirmMsg = action === 'ban'
            ? 'Ban this user? Their account will become unusable until unbanned.'
            : 'Unban this user?';
        if (!confirm(confirmMsg)) return;
        try {{
            const res = await fetch('/api/admin/users/{target_username}/ban', {{
                method: 'POST',
                headers: {{'Content-Type': 'application/json'}},
                body: JSON.stringify({{ action: action }})
            }});
            const data = await res.json();
            showNotification(data.msg, data.success ? 'success' : 'error');
            if (data.success) setTimeout(function () {{ location.reload(); }}, 700);
        }} catch (e) {{
            showNotification('Error updating ban status.', 'error');
        }}
    }}
    </script>
    '''

def render_profile_page(target_username, viewer_username, show_settings, tab="submissions", page=1):
    """Builds account.html for `target_username`. Used both for a user's own
    editable account page (show_settings=True) and for anyone's read-only
    public profile at /user/<username> (show_settings=False). Returns None
    if target_username doesn't exist."""
    with sqlite3.connect(DB_U) as c: 
        # ADDED avatar_url, is_admin, is_banned, warning_message TO THIS SELECT
        r = c.execute("SELECT level, rank, global_position, progress, xp, display_name, avatar_url, is_admin, is_banned, warning_message FROM users WHERE username=?", (target_username,)).fetchone()
        if not r:
            return None
        
        # Unpack all 10 variables
        # Fallback to default avatar if none exists
        default_av = 'https://thumbs.dreamstime.com/b/binary-code-matrix-background-digital-technology-vector-computer-data-green-numbers-pattern-streams-zero-one-digits-182437658.jpg'
        l, rnk, gp, pr, xp, dname, av, admin_flag, banned_flag, pending_warning = r
        # NOTE: `rnk` above is the legacy DB rank column — no longer displayed
        # directly. The actual rank shown to the user is computed live from
        # xp (and is_admin) via get_rank_info() below, so it can't drift out
        # of sync and the color always matches the current tier.
        
        # Fix: If av is None (from DB), use default
        if not av: av = default_av
        
        ps = c.execute("SELECT COUNT(*) FROM solved_problems WHERE username=?", (target_username,)).fetchone()[0]
        sp = c.execute("SELECT m.id, m.title, m.xp FROM solved_problems s JOIN initial_misions m ON s.problem_id = m.id WHERE s.username = ?", (target_username,)).fetchall()

        # Progress bars: overall + one per problem type (answer / code).
        # Totals come from initial_misions (what's on the platform); solved
        # counts are scoped to this user via a join on solved_problems.
        total_problems = c.execute("SELECT COUNT(*) FROM initial_misions").fetchone()[0]
        total_answer = c.execute("SELECT COUNT(*) FROM initial_misions WHERE type='answer'").fetchone()[0]
        total_code = c.execute("SELECT COUNT(*) FROM initial_misions WHERE type='code'").fetchone()[0]

        solved_answer = c.execute("""
            SELECT COUNT(*) FROM solved_problems sp
            JOIN initial_misions m ON sp.problem_id = m.id
            WHERE sp.username=? AND m.type='answer'
        """, (target_username,)).fetchone()[0]
        solved_code = c.execute("""
            SELECT COUNT(*) FROM solved_problems sp
            JOIN initial_misions m ON sp.problem_id = m.id
            WHERE sp.username=? AND m.type='code'
        """, (target_username,)).fetchone()[0]
    
    tr = "".join(f'<tr><td>{p[0]}</td><td><a href="/problem/{p[0]}">{p[1]}</a></td><td>+{p[2]}</td></tr>' for p in sp)

    rank_name, rank_color = get_rank_info(xp, bool(admin_flag))
    dname_html = colored_name_html(str(dname or target_username), rank_color)
    rank_html = rank_badge_html(rank_name, rank_color)

    overall_pct = pct(ps, total_problems)
    answer_pct = pct(solved_answer, total_answer)
    code_pct = pct(solved_code, total_code)

    # ── Tabs: SUBMISSIONS (the solved-problems table that always lived
    # here) and BLOG (this user's posts, with a composer if it's their own
    # account). Tabs sit next to the profile card, in the right-hand column.
    if tab not in ("submissions", "blog"):
        tab = "submissions"
    base_path = "/frontend/account.html" if show_settings else f"/user/{target_username}"
    tab_bar = build_acc_tabs(base_path, tab)

    if tab == "blog":
        r_sec_content = build_account_blog_tab(target_username, is_owner=show_settings, page=page, base_path=base_path)
    else:
        r_sec_content = f'''<h2>SOLVED PROBLEMS</h2>
        <div class="tbl-wrap">
            <table>
                <thead><tr><th>ID</th><th>Title</th><th>XP</th></tr></thead>
                <tbody>{tr}</tbody>
            </table>
        </div>'''

    # Admin-only moderation controls (Ban / Warn) shown on someone else's
    # profile — never on an admin's own account and never on another admin's
    # profile, per the "except for the admin account" rule.
    admin_actions_html = ""
    if viewer_username and is_admin(viewer_username) and not bool(admin_flag):
        admin_actions_html = build_admin_actions_html(target_username, bool(banned_flag), pending_warning)

    with open(os.path.join(D_F, "account.html"), "r", encoding="utf-8") as f: 
        h = f.read()

    if not show_settings:
        h = SETTINGS_BTN_RE.sub("", h)
        h = SETTINGS_MODAL_RE.sub("", h)
    
    return h.replace("{{u}}", target_username)\
            .replace("{{dname}}", dname_html)\
            .replace("{{avatar}}", av)\
            .replace("{{rnk}}", rank_html)\
            .replace("{{l}}", str(l))\
            .replace("{{xp}}", str(xp))\
            .replace("{{ps}}", str(ps))\
            .replace("{{pr}}", str(pr))\
            .replace("{{tab_bar}}", tab_bar)\
            .replace("{{r_sec_content}}", r_sec_content)\
            .replace("{{admin_actions}}", admin_actions_html)\
            .replace("{{overall_pct}}", str(overall_pct))\
            .replace("{{overall_solved}}", str(ps))\
            .replace("{{overall_total}}", str(total_problems))\
            .replace("{{answer_pct}}", str(answer_pct))\
            .replace("{{answer_solved}}", str(solved_answer))\
            .replace("{{answer_total}}", str(total_answer))\
            .replace("{{code_pct}}", str(code_pct))\
            .replace("{{code_solved}}", str(solved_code))\
            .replace("{{code_total}}", str(total_code))\
            .replace("{{nav}}", nav_html(viewer_username))

@app.route("/frontend/account.html")
def acc():
    u = get_u()
    if not u: return redirect("/frontend/login.html")
    tab = request.args.get("tab", "submissions").lower()
    if tab not in ("submissions", "blog"):
        tab = "submissions"
    try:
        page = max(1, int(request.args.get("page", 1)))
    except ValueError:
        page = 1
    return render_profile_page(target_username=u, viewer_username=u, show_settings=True, tab=tab, page=page)

@app.route("/user/<username>")
def public_profile(username):
    viewer = get_u()
    # Your own username should always take you to the editable account page,
    # not the read-only public profile — redirect here so every link on the
    # site (nav, comments, blog cards, leaderboard, search) doesn't need its
    # own "is this me?" check.
    if viewer and viewer == username:
        qs = request.query_string.decode()
        return redirect("/frontend/account.html" + (f"?{qs}" if qs else ""))
    tab = request.args.get("tab", "submissions").lower()
    if tab not in ("submissions", "blog"):
        tab = "submissions"
    try:
        page = max(1, int(request.args.get("page", 1)))
    except ValueError:
        page = 1
    html_out = render_profile_page(target_username=username, viewer_username=viewer, show_settings=False, tab=tab, page=page)
    if html_out is None:
        return "404 User not found", 404
    return html_out

@app.route("/search")
def user_search():
    u = get_u()
    q = request.args.get("q", "").strip()
    rows = build_search_results_html(q)
    with open(os.path.join(D_F, "search.html"), "r", encoding="utf-8") as f:
        h = f.read()
    return h.replace("{{q}}", q).replace("{{rows}}", rows).replace("{{nav}}", nav_html(u))

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
        if not verify_password(db_p, old_p):
            return {"success": False, "msg": "Incorrect old password."}
        
        if new_dname and new_dname.strip():
            c.execute("UPDATE users SET display_name = ? WHERE username = ?", (new_dname.strip(), u))
        
        # Now this works because new_avatar is defined above
        if new_avatar and new_avatar.strip():
            c.execute("UPDATE users SET avatar_url = ? WHERE username = ?", (new_avatar.strip(), u))
        
        if new_p and len(new_p) > 5:
            c.execute("UPDATE users SET password = ? WHERE username = ?", (hash_password(new_p), u))
        elif not is_hashed(db_p):
            # Not changing the password, but we just verified the legacy
            # plaintext one matches — upgrade it to a hash while we're here.
            c.execute("UPDATE users SET password = ? WHERE username = ?", (hash_password(old_p), u))
            
    return {"success": True, "msg": "Profile updated successfully!"}

@app.route("/frontend/ranking.html")
def rnk():
    with open(os.path.join(D_F, "ranking.html"), "r", encoding="utf-8") as f: h = f.read()
    with sqlite3.connect(DB_U) as c:
        data = c.execute("""
            SELECT username, is_admin, level, xp, problems_solved, display_name
            FROM users ORDER BY xp DESC LIMIT 10
        """).fetchall()

    rows = ""
    for i, (uname, admin_flag, lvl, xp, solved, dname) in enumerate(data):
        name_to_show = dname or uname
        rank_name, rank_color = get_rank_info(xp, bool(admin_flag))
        rows += (f"<tr><td>{i+1}</td>"
                 f"<td>{colored_name_link_html(uname, name_to_show, rank_color)}</td>"
                 f"<td>{rank_badge_html(rank_name, rank_color)}</td>"
                 f"<td>{lvl}</td><td>{xp}</td><td>{solved}</td></tr>")
    if not rows:
        rows = "<tr><td colspan='6' style='text-align:center;'>No users found.</td></tr>"

    return h.replace("{{rows}}", rows)\
            .replace("{{pagination}}", "")\
            .replace("{{nav}}", nav_html(get_u()))

PROBLEMS_PER_PAGE = 15

TYPE_LABELS = {"answer": "ANSWER", "code": "CODE"}
TYPE_CLASSES = {"answer": "type-answer", "code": "type-code"}
VALID_PROB_TYPES = {"answer", "code"}
VALID_SORTS = {"id", "title", "solved"}

# Solutions (official + user-submitted) only exist for code-type problems.
SOLUTION_CODE_MAX = 20000
VALID_SOLUTION_LANGS = {"sage"}
SOLUTION_LANG_LABELS = {"sage": "SageMath"}

@app.route("/practice")
def practice_page():
    u = get_u()
    q = request.args.get("q", "").strip()
    type_filter = request.args.get("type", "all").lower()
    if type_filter not in ({"all"} | VALID_PROB_TYPES):
        type_filter = "all"
    sort = request.args.get("sort", "id").lower()
    if sort not in VALID_SORTS:
        sort = "id"
    try:
        page = max(1, int(request.args.get("page", 1)))
    except ValueError:
        page = 1

    where, params = [], []
    if q:
        where.append("m.title LIKE ?")
        params.append(f"%{q}%")
    if type_filter != "all":
        where.append("m.type = ?")
        params.append(type_filter)
    where_sql = ("WHERE " + " AND ".join(where)) if where else ""

    order_sql = {
        "id": "m.id ASC",
        "title": "m.title COLLATE NOCASE ASC",
        "solved": "solved_count DESC, m.id ASC",
    }[sort]

    with sqlite3.connect(DB_U) as c:
        total = c.execute(f"SELECT COUNT(*) FROM initial_misions m {where_sql}", params).fetchone()[0]
        total_pages = max(1, math.ceil(total / PROBLEMS_PER_PAGE))
        page = min(page, total_pages)
        offset = (page - 1) * PROBLEMS_PER_PAGE

        missions = c.execute(
            f"""SELECT m.id, m.title, m.type, COALESCE(sc.cnt, 0) AS solved_count, COALESCE(uc.cnt, 0) AS sol_count
                FROM initial_misions m
                LEFT JOIN (SELECT problem_id, COUNT(username) AS cnt FROM solved_problems GROUP BY problem_id) sc
                    ON sc.problem_id = m.id
                LEFT JOIN (SELECT problem_id, COUNT(*) AS cnt FROM user_solutions WHERE is_public=1 GROUP BY problem_id) uc
                    ON uc.problem_id = m.id
                {where_sql}
                ORDER BY {order_sql}
                LIMIT ? OFFSET ?""",
            params + [PROBLEMS_PER_PAGE, offset]
        ).fetchall()

        solved_ids = set()
        if u:
            user_solved = c.execute("SELECT problem_id FROM solved_problems WHERE username=?", (u,)).fetchall()
            solved_ids = {str(row[0]) for row in user_solved}

    table_rows = ""
    for m_id, title, prob_type, solved_by, sol_count in missions:
        m_id_str = str(m_id)
        is_solved = m_id_str in solved_ids
        prob_type = (prob_type or "answer").lower()

        status_icon = "✅ " if is_solved else ""
        type_label = TYPE_LABELS.get(prob_type, "ANSWER")
        type_cls = TYPE_CLASSES.get(prob_type, "type-answer")

        # Official/user solutions only make sense for code-type problems.
        # The dots menu now shows for every problem, but for answer-type
        # problems the two options are rendered as faded, unclickable
        # placeholders instead of being hidden entirely.
        if prob_type == "code":
            actions_cell = f'''<button type="button" class="row-menu-btn" aria-label="More actions" aria-haspopup="true">⋮</button>
            <div class="row-menu-dropdown">
                <a href="/problem/{m_id}/solution">View Official Solution</a>
                <a href="/problem/{m_id}/user_solutions">View User Solutions ({sol_count})</a>
            </div>'''
        else:
            actions_cell = '''<button type="button" class="row-menu-btn" aria-label="More actions" aria-haspopup="true">⋮</button>
            <div class="row-menu-dropdown">
                <span class="row-menu-disabled" title="Not available for answer-type problems">View Official Solution</span>
                <span class="row-menu-disabled" title="Not available for answer-type problems">View User Solutions</span>
            </div>'''

        table_rows += f"""
        <tr style="border-bottom: 1px solid rgba(128, 128, 128, 0.2);">
            <td style="padding: 15px 10px;">{m_id}</td>
            <td style="padding: 15px 10px;">{status_icon}<a href="/problem/{m_id}"><strong>{title}</strong></a></td>
            <td style="padding: 15px 10px; text-align:center;"><span class="prob-type-badge {type_cls}">{type_label}</span></td>
            <td style="padding: 15px 10px; text-align:center; position:relative;">
                <span class="solved-count">{solved_by}</span>
                {actions_cell}
            </td>
        </tr>
        """

    if not table_rows:
        table_rows = '<tr><td colspan="4" style="text-align:center; padding: 20px;">No problems found.</td></tr>'

    def url_for_page(p):
        qs = {"page": p}
        if q: qs["q"] = q
        if type_filter != "all": qs["type"] = type_filter
        if sort != "id": qs["sort"] = sort
        return "/practice?" + urlencode(qs)

    pagination_html = build_pagination(page, total_pages, url_for_page)

    if total == 0:
        results_meta = "No problems found." if (q or type_filter != "all") else "No problems available yet."
    else:
        start, end = offset + 1, min(offset + PROBLEMS_PER_PAGE, total)
        results_meta = f"Showing {start}-{end} of {total} problem{'s' if total != 1 else ''}"
        if q: results_meta += f' matching "{q}"'
        if type_filter != "all": results_meta += f" \u00b7 {TYPE_LABELS.get(type_filter, type_filter.upper())} type"

    clear_search = ""
    if q:
        clear_qs = {}
        if type_filter != "all": clear_qs["type"] = type_filter
        if sort != "id": clear_qs["sort"] = sort
        clear_href = "/practice" + (("?" + urlencode(clear_qs)) if clear_qs else "")
        clear_search = f'<a href="{clear_href}" class="back-btn practice-clear-btn">Clear</a>'

    type_sidebar = ""
    for key, label in (("all", "ALL"), ("answer", "ANSWER"), ("code", "CODE")):
        qs = {}
        if q: qs["q"] = q
        if key != "all": qs["type"] = key
        if sort != "id": qs["sort"] = sort
        href = "/practice" + (("?" + urlencode(qs)) if qs else "")
        active = " filter-link-active" if type_filter == key else ""
        type_sidebar += f'<a href="{href}" class="filter-link{active}">{label}</a>\n'

    sort_sidebar = ""
    for key, label in (("id", "DEFAULT"), ("title", "TITLE A-Z"), ("solved", "MOST SOLVED")):
        qs = {}
        if q: qs["q"] = q
        if type_filter != "all": qs["type"] = type_filter
        if key != "id": qs["sort"] = key
        href = "/practice" + (("?" + urlencode(qs)) if qs else "")
        active = " filter-link-active" if sort == key else ""
        sort_sidebar += f'<a href="{href}" class="filter-link{active}">{label}</a>\n'

    with open(os.path.join(D_F, "practice.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{table_rows}}", table_rows)\
            .replace("{{pagination}}", pagination_html)\
            .replace("{{search_value}}", q)\
            .replace("{{type_filter}}", type_filter)\
            .replace("{{sort}}", sort)\
            .replace("{{clear_search}}", clear_search)\
            .replace("{{results_meta}}", results_meta)\
            .replace("{{type_sidebar}}", type_sidebar)\
            .replace("{{sort_sidebar}}", sort_sidebar)\
            .replace("{{nav}}", nav_html(u))

@app.route("/submit", methods=["POST"])
def submit():
    u = get_u()
    if not u: return {"success": False, "msg": "Login required"}
    data = request.json or {}
    prob_id = data.get("id")
    user_ans = data.get("answer")

    if not prob_id or user_ans is None:
        return {"success": False, "msg": "Missing problem id or answer."}

    with sqlite3.connect(DB_U) as c:
        # 1. Verify the problem exists and actually accepts plain-text answers.
        # Code-type problems store their expected *stdout* in this same
        # `answer` column for /submit_code to compare against — without this
        # check, anyone who knew/guessed that expected output could POST it
        # here directly and get marked solved without ever running real code.
        m = c.execute("SELECT answer, xp, type FROM initial_misions WHERE id=?", (prob_id,)).fetchone()
        if not m:
            return {"success": False, "msg": "Problem not found."}
        if (m[2] or "answer").lower() != "answer":
            return {"success": False, "msg": "This problem requires a code submission — use the code editor instead."}
        if m[0] != user_ans:
            return {"success": False, "msg": "Incorrect answer."}

        # 2. Check if already solved
        already_solved = c.execute("SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, prob_id)).fetchone()
        if already_solved:
            return {"success": False, "msg": "Problem already solved!"}

        # 3. Award XP AND increment problems_solved
        c.execute("UPDATE users SET xp = xp + ?, problems_solved = problems_solved + 1 WHERE username=?", (m[1], u))
        c.execute("INSERT INTO solved_problems (username, problem_id) VALUES (?, ?)", (u, prob_id))
        
        return {"success": True, "msg": f"Correct! +{m[1]} XP earned."}

# ────────────────────────────────────
# Code judge — compiles/runs a submission for a code-type problem and
# compares its stdout against the problem's expected output.
#
# SECURITY NOTE: this runs submitted code directly on this machine via
# subprocess, hardened only with per-run CPU/memory/process-count limits
# and a wall-clock timeout — there is no container/namespace/seccomp
# sandboxing. That's an acceptable tradeoff for a local/trusted-network
# practice tool, but before exposing this to the public internet, run
# submissions inside Docker (or gVisor, Firecracker, Judge0, etc.) instead.
# ────────────────────────────────────
CODE_LANGUAGES = {
    "sage": "SageMath",
}
CODE_TIME_LIMIT = 5          # seconds allowed for the run step (fallback; sage uses SAGE_TIME_LIMIT below)
SAGE_TIME_LIMIT = 30         # seconds allowed for Sage — its interpreter has a much heavier startup than plain Python
CODE_COMPILE_TIMEOUT = 20    # seconds allowed for compilation (kept in case a compiled language is added later)
CODE_MAX_LEN = 20000         # max characters of submitted source
CODE_MAX_OUTPUT = 20000      # captured stdout/stderr are truncated to this

# Command used to invoke Sage. Defaults to whatever 'sage' resolves to on
# PATH (same as running `sage` yourself in a terminal). If Sage is installed
# somewhere that isn't on the PATH the Flask process sees (e.g. a conda env,
# or a tarball install under $HOME), set SAGE_BINARY to the full path before
# starting the server, e.g.:
#   export SAGE_BINARY=/home/youruser/SageMath/sage
SAGE_BINARY = os.environ.get("SAGE_BINARY", "sage")

# How the judge actually runs Sage code:
#   "local"  (default) — subprocess to a real local `sage` install (see
#             SAGE_BINARY above). Fast, no network dependency, but you have
#             to maintain a working Sage install on this machine.
#   "remote" — POSTs the code to the public SageMathCell service instead
#             (https://sagecell.sagemath.org) so no local Sage install is
#             needed at all. Trade-off: depends on a shared public server
#             with no SLA — expect occasional slowness/unavailability, and
#             don't rely on this for high submission volume or graded
#             production use. Flip with:
#   export SAGE_MODE=remote
SAGE_MODE = os.environ.get("SAGE_MODE", "local").lower()
SAGECELL_URL = "https://sagecell.sagemath.org/service"
SAGECELL_TIMEOUT = 30  # the public server itself times out around here

def _limit_judge_resources(time_limit=CODE_TIME_LIMIT):
    """preexec_fn for the judged subprocess: best-effort CPU time, memory,
    and process-count caps (defense in depth, not a full sandbox — see the
    note above). POSIX only; silently skipped if unavailable.
    Memory cap is higher than a bare-Python judge would need since Sage's
    runtime (GAP/Singular/PARI/OpenBLAS/etc. loaded alongside it) is much
    heavier. RLIMIT_AS caps *virtual* address space, not just RSS -- and
    OpenBLAS reserves per-thread virtual buffers scaled to detected CPU
    core count on startup, which alone can exceed 1.5GB of virtual space
    even though real usage is far lower (surfaces as an opaque 'OpenBLAS
    error: Memory allocation still failed' with no Python traceback at
    all). Threads are pinned to 1 in judge_env below to keep that
    reservation small, but the cap is still raised to give real headroom."""
    if resource is None:
        return
    try:
        resource.setrlimit(resource.RLIMIT_CPU, (time_limit, time_limit + 1))
        resource.setrlimit(resource.RLIMIT_AS, (4096 * 1024 * 1024, 4096 * 1024 * 1024))
        resource.setrlimit(resource.RLIMIT_NPROC, (128, 128))
    except Exception:
        pass

def run_code_submission(language, code, stdin_data):
    """Runs `code` against `stdin_data` using SageMath — the only language
    this judge accepts. Dispatches to a local subprocess or the public
    SageMathCell service depending on SAGE_MODE (see its definition above).
    Returns (verdict, stdout, stderr) where verdict is one of:
    'ok', 'runtime_error', 'time_limit_exceeded', 'internal_error'."""
    if language != "sage":
        return "internal_error", "", "Unsupported language."
    if SAGE_MODE == "remote":
        return _run_sage_remote(code, stdin_data)
    return _run_sage_local(code, stdin_data)

def _run_sage_local(code, stdin_data):
    """Runs `code` via a real local Sage install (subprocess). Sage is
    interpreted (via its own preparser on top of Python), so there's no
    separate compile step."""
    # Resolve the sage executable up front so a missing/unfindable binary
    # gets a clear, actionable message instead of a bare FileNotFoundError.
    # shutil.which() handles the common case (sage on PATH); SAGE_BINARY
    # can also be set to an absolute path directly.
    sage_path = shutil.which(SAGE_BINARY)
    if not sage_path and os.path.isabs(SAGE_BINARY) and os.access(SAGE_BINARY, os.X_OK):
        sage_path = SAGE_BINARY
    if not sage_path:
        return "internal_error", "", (
            f"Could not find the Sage executable (looked for '{SAGE_BINARY}' on PATH). "
            "Confirm 'sage' works in a terminal on this machine (try `which sage` or "
            "`sage --version`), then either make sure the account running this Flask "
            "server has that same PATH, or set the SAGE_BINARY environment variable to "
            "Sage's full path (e.g. export SAGE_BINARY=/home/youruser/SageMath/sage) "
            "before starting the server. Alternatively, set SAGE_MODE=remote to use "
            "the public SageMathCell service instead of a local install."
        )

    workdir = tempfile.mkdtemp(prefix="judge_")
    try:
        src_path = os.path.join(workdir, "main.sage")
        with open(src_path, "w", encoding="utf-8") as f:
            f.write(code)
        run_cmd = [sage_path, "main.sage"]

        # Sage's interpreter has a much heavier startup than plain Python
        # (loading GAP/Singular/PARI/etc.), so it gets its own, longer time
        # budget rather than the generic CODE_TIME_LIMIT.
        preexec = (lambda: _limit_judge_resources(SAGE_TIME_LIMIT)) if os.name == "posix" else None

        # Sage needs more than a bare PATH to start up: it looks for its
        # config/cache dir at $HOME/.sage (DOT_SAGE), and installs from
        # conda/tarballs often rely on other vars (PYTHONHOME, etc.) that
        # the wrapping `sage` shell script sets up relative to HOME/its own
        # location. Passing only {"PATH": ...} (the old behavior) left HOME
        # unset, so Sage would try to create /.sage and fail on every run.
        # Inherit the full environment instead — the resource limits above
        # already constrain CPU/memory/process count for the child.
        judge_env = os.environ.copy()
        judge_env.setdefault("HOME", tempfile.gettempdir())
        # Pin BLAS/OpenMP to a single thread: OpenBLAS sizes its per-thread
        # virtual memory reservation off the number of CPU cores it detects,
        # which can blow past the RLIMIT_AS cap above on multi-core machines
        # and fail with an opaque "OpenBLAS error: Memory allocation still
        # failed" before any judge output is produced. One-off submissions
        # gain nothing from multi-threaded BLAS anyway.
        for _var in ("OPENBLAS_NUM_THREADS", "OMP_NUM_THREADS", "GOTO_NUM_THREADS", "MKL_NUM_THREADS"):
            judge_env[_var] = "1"

        try:
            proc = subprocess.run(
                run_cmd,
                cwd=workdir,
                input=stdin_data or "",
                capture_output=True,
                text=True,
                timeout=SAGE_TIME_LIMIT,
                env=judge_env,
                preexec_fn=preexec,
            )
        except FileNotFoundError:
            return "internal_error", "", f"'{sage_path}' could not be executed."
        except subprocess.TimeoutExpired:
            return "time_limit_exceeded", "", ""

        if proc.returncode != 0:
            # A shared-library import failure this early means the Sage
            # *install itself* is broken (e.g. GSL/MPFR version drift from
            # something else being installed into the same conda env --
            # see environment.yml) -- Sage crashed before main.sage (the
            # student's code) ever ran. That's a server/admin problem, not
            # a bug in the submission, so it must not be shown to students
            # as a runtime_error on their own code.
            broken_install = (
                "ImportError" in proc.stderr and "cannot open shared object file" in proc.stderr
            ) or "sage.cli.__main__" in proc.stderr or "sage.cli.eval_cmd" in proc.stderr
            if broken_install:
                return "internal_error", "", (
                    "The Sage install on this server failed to start (a shared library "
                    "could not be loaded) before your code ran -- this is not an issue "
                    "with your submission. Likely cause: GSL/MPFR version drift in the "
                    "conda env Sage is installed in (see environment.yml / README.md). "
                    "Admin: try `conda install -n <sage-env> -c conda-forge gsl "
                    "--force-reinstall`, or recreate the dedicated env with "
                    "`conda env create -f environment.yml`. Raw error: " + proc.stderr[:1000]
                )
            # Sage reports syntax errors as a non-zero exit with a traceback
            # on stderr rather than through a separate compile phase, so a
            # bad submission surfaces here as a runtime error either way.
            return "runtime_error", proc.stdout[:CODE_MAX_OUTPUT], proc.stderr[:CODE_MAX_OUTPUT]

        return "ok", proc.stdout[:CODE_MAX_OUTPUT], proc.stderr[:CODE_MAX_OUTPUT]
    finally:
        shutil.rmtree(workdir, ignore_errors=True)

def _run_sage_remote(code, stdin_data):
    """Runs `code` on the public SageMathCell service instead of a local
    install (see SAGE_MODE above). Uses the /service endpoint, a simple
    synchronous wrapper distinct from the full websocket kernel protocol
    the embedded widget uses — it isn't officially documented, so this is
    written defensively and may need adjusting if the service's response
    shape changes.

    SageMathCell has no stdin parameter; it only runs one blob of code. To
    support problems that feed stdin, submitted `input()` calls are
    redirected to read from a pre-supplied line iterator built from
    `stdin_data` instead of a real pipe — this covers the common case but
    isn't a byte-for-byte match for a real subprocess stdin pipe (e.g. its
    EOFError timing can differ from CPython's built-in input()).
    """
    full_code = code
    if stdin_data:
        shim = (
            "__judge_stdin_lines = iter(" + repr(stdin_data.splitlines()) + ")\n"
            "def input(*__a, **__k):\n"
            "    try:\n"
            "        return next(__judge_stdin_lines)\n"
            "    except StopIteration:\n"
            "        raise EOFError('no more input')\n\n"
        )
        full_code = shim + code

    try:
        req = Request(
            SAGECELL_URL,
            data=urlencode({"code": full_code}).encode("utf-8"),
            headers={"Content-Type": "application/x-www-form-urlencoded"},
        )
        with urlopen(req, timeout=SAGECELL_TIMEOUT) as resp:
            raw = resp.read().decode("utf-8", errors="replace")
    except (URLError, HTTPError) as e:
        return "internal_error", "", f"Could not reach SageMathCell (SAGE_MODE=remote): {e}"
    except Exception as e:
        return "internal_error", "", f"Unexpected error contacting SageMathCell: {e}"

    try:
        payload = json.loads(raw)
    except ValueError:
        return "internal_error", "", f"SageMathCell returned a non-JSON response: {raw[:500]}"

    if not payload.get("success", False):
        # The /service endpoint isn't fully documented, so this maps
        # "not success" conservatively to runtime_error rather than
        # guessing more specifically (e.g. it may also mean a timeout).
        stdout = payload.get("stdout") or ""
        stderr = payload.get("stderr") or json.dumps(payload)[:500]
        return "runtime_error", stdout[:CODE_MAX_OUTPUT], stderr[:CODE_MAX_OUTPUT]

    stdout = (payload.get("stdout") or "")[:CODE_MAX_OUTPUT]
    stderr = (payload.get("stderr") or "")[:CODE_MAX_OUTPUT]
    return "ok", stdout, stderr

@app.route("/submit_code", methods=["POST"])
def submit_code():
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Login required"}), 401

    data = request.json or {}
    prob_id = data.get("id")
    language = (data.get("language") or "").lower()
    code = data.get("code", "")

    if not prob_id:
        return jsonify({"success": False, "msg": "Missing problem id."}), 400
    if language not in CODE_LANGUAGES:
        return jsonify({"success": False, "msg": "Unsupported language."}), 400
    if not code.strip():
        return jsonify({"success": False, "msg": "Please write some code before submitting."}), 400
    if len(code) > CODE_MAX_LEN:
        return jsonify({"success": False, "msg": f"Code is limited to {CODE_MAX_LEN} characters."}), 400

    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT answer, xp, type, test_input FROM initial_misions WHERE id=?", (prob_id,)).fetchone()
        if not m:
            return jsonify({"success": False, "msg": "Problem not found."}), 404
        if (m[2] or "answer").lower() != "code":
            return jsonify({"success": False, "msg": "This problem doesn't accept code submissions."}), 400

        expected_output, xp_reward, _, test_input = m
        already_solved = bool(c.execute(
            "SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, prob_id)
        ).fetchone())

    verdict, stdout, stderr = run_code_submission(language, code, test_input or "")

    if verdict == "internal_error":
        return jsonify({"success": False, "msg": stderr or "Internal judge error."}), 500
    if verdict == "compile_error":
        return jsonify({"success": True, "verdict": "compile_error", "msg": "Compile Error.", "stdout": "", "stderr": stderr})
    if verdict == "runtime_error":
        return jsonify({"success": True, "verdict": "runtime_error", "msg": "Runtime Error.", "stdout": stdout, "stderr": stderr})
    if verdict == "time_limit_exceeded":
        return jsonify({"success": True, "verdict": "time_limit_exceeded", "msg": f"Time Limit Exceeded ({SAGE_TIME_LIMIT}s).", "stdout": "", "stderr": ""})

    # verdict == "ok" -> program ran cleanly; now compare its output
    passed = stdout.strip() == (expected_output or "").strip()
    if not passed:
        return jsonify({"success": True, "verdict": "wrong_answer", "msg": "Wrong Answer.", "stdout": stdout, "stderr": stderr})

    if already_solved:
        return jsonify({"success": True, "verdict": "accepted", "msg": "Accepted! (already solved — no extra XP)", "stdout": stdout, "stderr": stderr})

    with sqlite3.connect(DB_U) as c:
        c.execute("UPDATE users SET xp = xp + ?, problems_solved = problems_solved + 1 WHERE username=?", (xp_reward, u))
        c.execute("INSERT INTO solved_problems (username, problem_id) VALUES (?, ?)", (u, prob_id))

    return jsonify({"success": True, "verdict": "accepted", "msg": f"Accepted! +{xp_reward} XP earned.", "stdout": stdout, "stderr": stderr})

LESSONS_PER_PAGE = 6

@app.route("/learn")
def learn_page():
    u = get_u()
    q = request.args.get("q", "").strip()
    difficulty = request.args.get("difficulty", "all").lower()
    if difficulty not in ("all", "10", "11", "12", "college"):
        difficulty = "all"
    try:
        page = max(1, int(request.args.get("page", 1)))
    except ValueError:
        page = 1

    where, params = [], []
    if q:
        where.append("(title LIKE ? OR description LIKE ?)")
        params += [f"%{q}%", f"%{q}%"]
    if difficulty != "all":
        where.append("difficulty = ?")
        params.append(difficulty)
    where_sql = ("WHERE " + " AND ".join(where)) if where else ""

    with sqlite3.connect(DB_U) as c:
        total = c.execute(f"SELECT COUNT(*) FROM lessons {where_sql}", params).fetchone()[0]
        total_pages = max(1, math.ceil(total / LESSONS_PER_PAGE))
        page = min(page, total_pages)
        offset = (page - 1) * LESSONS_PER_PAGE
        rows = c.execute(
            f"SELECT id, title, description, link, type, difficulty FROM lessons {where_sql} ORDER BY id LIMIT ? OFFSET ?",
            params + [LESSONS_PER_PAGE, offset]
        ).fetchall()

    type_label = {"video": "\U0001f3a5 VIDEO", "text": "\U0001f4c4 TEXT", "article": "\U0001f4d6 ARTICLE"}
    diff_class = {"10": "diff-10", "11": "diff-11", "12": "diff-12", "college": "diff-college"}

    def grade_label(d):
        return "College" if d == "college" else f"Grade {d}"

    cards = ""
    for lesson_id, title, desc, link, ltype, ldiff in rows:
        ltype = (ltype or "text").lower()
        ldiff = (ldiff or "10").lower()
        video_badge = ""
        if ltype == "article" and link:
            video_badge = '<span class="badge badge-video">\U0001f3a5 VIDEO</span>'
        cards += f'''<div class="learn-module">
            <div class="learn-badges">
                <span class="badge badge-type">{type_label.get(ltype, "\U0001f4c4 TEXT")}</span>
                {video_badge}
                <span class="badge {diff_class.get(ldiff, "diff-10")}">{grade_label(ldiff)}</span>
            </div>
            <h3>{title}</h3>
            <p>{desc}</p>
            <br>
            <a href="/lesson/{lesson_id}" class="back-btn">Start Lesson</a>
        </div>
        '''
    if not cards:
        cards = '<p style="text-align:center; opacity:0.7; grid-column: 1 / -1;">No lessons found.</p>'

    def url_for_page(p):
        qs = {"page": p}
        if q: qs["q"] = q
        if difficulty != "all": qs["difficulty"] = difficulty
        return "/learn?" + urlencode(qs)

    pagination_html = build_pagination(page, total_pages, url_for_page)

    if total == 0:
        results_meta = "No lessons found." if (q or difficulty != "all") else "No lessons available yet."
    else:
        start, end = offset + 1, min(offset + LESSONS_PER_PAGE, total)
        results_meta = f"Showing {start}-{end} of {total} lesson{'s' if total != 1 else ''}"
        if q: results_meta += f' matching "{q}"'
        if difficulty != "all": results_meta += f" \u00b7 {grade_label(difficulty)}"

    clear_search = ""
    if q:
        clear_qs = f"?difficulty={difficulty}" if difficulty != "all" else ""
        clear_search = f'<a href="/learn{clear_qs}" class="back-btn learn-clear-btn">Clear</a>'

    diff_sidebar = ""
    for key, label, cls in (("all", "ALL", "diff-link-all"), ("10", "GRADE 10", "diff-10"),
                             ("11", "GRADE 11", "diff-11"), ("12", "GRADE 12", "diff-12"),
                             ("college", "COLLEGE", "diff-college")):
        qs = {}
        if q: qs["q"] = q
        if key != "all": qs["difficulty"] = key
        href = "/learn" + (("?" + urlencode(qs)) if qs else "")
        active = " diff-link-active" if difficulty == key else ""
        diff_sidebar += f'<a href="{href}" class="diff-link {cls}{active}">{label}</a>\n'

    with open(os.path.join(D_F, "learn.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{lessons}}", cards)\
            .replace("{{nav}}", nav_html(u))\
            .replace("{{search_value}}", q)\
            .replace("{{difficulty}}", difficulty)\
            .replace("{{clear_search}}", clear_search)\
            .replace("{{results_meta}}", results_meta)\
            .replace("{{pagination}}", pagination_html)\
            .replace("{{diff_sidebar}}", diff_sidebar)

@app.route("/lesson/<int:lesson_id>")
def lesson_page(lesson_id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        row = c.execute(
            "SELECT title, description, link, type, difficulty, content FROM lessons WHERE id=?",
            (lesson_id,)
        ).fetchone()

    if not row:
        return "404 Lesson not found", 404

    title, desc, link, ltype, ldiff, article_content = row
    ltype = (ltype or "text").lower()
    ldiff = (ldiff or "10").lower()

    diff_class = {"10": "diff-10", "11": "diff-11", "12": "diff-12", "college": "diff-college"}.get(ldiff, "diff-10")

    mathjax_tag = ""  # only injected for type == "article" (see below)
    video_badge = ""  # only set when an article lesson also has a video (see below)

    if ltype == "video":
        src = resolve_lesson_link(link)
        type_icon, type_label = "\U0001f3a5", "VIDEO"
        content = f'''<video controls style="width:100%; max-height:75vh; border:1px solid #00ff66; border-radius:4px; background:#000; display:block;">
            <source src="{src}" type="video/mp4">
            Your browser doesn't support inline video. <a href="{src}">Download the video</a> instead.
        </video>'''
    elif ltype == "article":
        # Renders raw HTML (with LaTeX math delimiters like \( \) / \[ \])
        # straight into the page, styled the same as the rest of the site
        # (black background, neon-green accents) instead of embedding a
        # white-background PDF. MathJax renders the math client-side.
        #
        # Article lessons don't otherwise use the 'link' column, so it's
        # reused here as an OPTIONAL video slot: if a link is set (e.g. a
        # Manim-rendered .mp4), it's embedded above the article text. Leave
        # link empty for text-only lessons.
        type_icon, type_label = "\U0001f4d6", "ARTICLE"
        video_html = ""
        if link:
            vsrc = resolve_lesson_link(link)
            video_html = f'''<video controls style="width:100%; max-height:60vh; border:1px solid #00ff66; border-radius:4px; background:#000; margin-bottom:20px; display:block;">
                <source src="{vsrc}" type="video/mp4">
                Your browser doesn't support inline video. <a href="{vsrc}">Download the video</a> instead.
            </video>'''
            video_badge = '<span class="badge badge-video">\U0001f3a5 VIDEO</span>'
        content = video_html + f'<div class="lesson-article">{article_content or ""}</div>'
        mathjax_tag = '''<script>
    window.MathJax = { tex: { inlineMath: [["\\\\(", "\\\\)"]], displayMath: [["\\\\[", "\\\\]"]] } };
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-mml-chtml.js" id="MathJax-script" async></script>'''
    else:
        src = resolve_lesson_link(link)
        type_icon, type_label = "\U0001f4c4", "TEXT"
        # Embedded inline via <iframe> so PDFs render in-page instead of navigating away.
        content = f'''<iframe src="{src}" title="{title}" style="width:100%; height:75vh; border:1px solid #00ff66; border-radius:4px; background:#fff; display:block;">
            Your browser doesn't support inline PDFs. <a href="{src}">Download the PDF</a> instead.
        </iframe>
        <p style="margin-top:10px; font-size:0.85em; opacity:0.7;">PDF not displaying? <a href="{src}" target="_blank" rel="noopener">Open it in a new tab</a>.</p>'''

    diff_label = "COLLEGE" if ldiff == "college" else f"GRADE {ldiff}"

    with open(os.path.join(D_F, "lesson.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{title}}", title)\
            .replace("{{description}}", desc or "")\
            .replace("{{type_icon}}", type_icon)\
            .replace("{{type_label}}", type_label)\
            .replace("{{video_badge}}", video_badge)\
            .replace("{{diff_class}}", diff_class)\
            .replace("{{diff_label}}", diff_label)\
            .replace("{{content}}", content)\
            .replace("{{mathjax}}", mathjax_tag)\
            .replace("{{nav}}", nav_html(u))

@app.route("/ranking")
def ranking_page():
    # 1. Setup Pagination (Page 1 by default, 10 users per page)
    page = request.args.get('page', 1, type=int)
    per_page = 10
    offset = (page - 1) * per_page
    
    with sqlite3.connect(DB_U) as c:
        # Get total number of users to know when to hide the "Next" button
        total_users = c.execute("SELECT COUNT(*) FROM users").fetchone()[0]
        
        # Fetch top users sorted by XP (Highest to Lowest)
        users = c.execute("""
            SELECT username, is_admin, level, xp, problems_solved, display_name 
            FROM users 
            ORDER BY xp DESC 
            LIMIT ? OFFSET ?
        """, (per_page, offset)).fetchall()
        
    # 2. Build the HTML for the rows
    rows_html = ""
    for i, user in enumerate(users):
        # Calculate actual rank number (1, 2, 3...)
        actual_rank = offset + i + 1 
        
        admin_flag = bool(user[1])
        lvl, xp_val, solved = user[2], user[3], user[4]
        # Fallback to username if display_name is empty/missing
        dname = user[5] if (len(user) > 5 and user[5]) else user[0] 

        rank_name, rank_color = get_rank_info(xp_val, admin_flag)
        
        rows_html += f"""
        <tr>
            <td>{actual_rank}</td>
            <td>{colored_name_link_html(user[0], dname, rank_color)}</td>
            <td>{rank_badge_html(rank_name, rank_color)}</td>
            <td>{lvl}</td>
            <td>{xp_val}</td>
            <td>{solved}</td>
        </tr>
        """
        
    if not rows_html:
        rows_html = "<tr><td colspan='6' style='text-align:center;'>No users found.</td></tr>"
        
    # 3. Create Pagination Links
    total_pages = max(1, math.ceil(total_users / per_page))
    page = min(page, total_pages)

    def url_for_page(p):
        return "/ranking?" + urlencode({"page": p})

    pagination_html = build_pagination(page, total_pages, url_for_page)
    
    # 4. Inject into the HTML template
    with open(os.path.join(D_F, "ranking.html"), "r", encoding="utf-8") as f:
        h = f.read()
        
    return h.replace("{{rows}}", rows_html)\
            .replace("{{pagination}}", pagination_html)\
            .replace("{{nav}}", nav_html(get_u()))

@app.route("/frontend/ranking_snippet.html")
def ranking_snippet():
    with sqlite3.connect(DB_U) as c:
        # Use COALESCE here too
        users = c.execute("SELECT username, COALESCE(display_name, username), xp, is_admin FROM users ORDER BY xp DESC LIMIT 5").fetchall()
        
    rows = ""
    for uname, name, xp, admin_flag in users:
        _, rank_color = get_rank_info(xp, bool(admin_flag))
        rows += f"<tr><td>{colored_name_link_html(uname, name, rank_color)}</td><td>{xp} XP</td></tr>"
    
    return f"""
    <h2>TOP USERS</h2>
    <table class="rank-table">
        <tr><th>User</th><th>XP</th></tr>
        {rows}
    </table>
    """

@app.route("/problem/<id>")
def problem_page(id):
    u = get_u()
    
    with sqlite3.connect(DB_U) as c:
        # 1. Fetch Problem
        m = c.execute("SELECT title, xp, statement, type FROM initial_misions WHERE id=?", (id,)).fetchone()
        if not m: return "404", 404
        
        # 2. Fetch User Data (Display Name & Avatar)
        av = "https://thumbs.dreamstime.com/b/binary-code-matrix-background-digital-technology-vector-computer-data-green-numbers-pattern-streams-zero-one-digits-182437658.jpg" # Default fallback
        dname = "Guest"
        solved = False
        
        if u:
            try:
                # Fetch BOTH display_name and avatar_url
                user_data = c.execute("SELECT display_name, avatar_url FROM users WHERE username=?", (u,)).fetchone()
                
                if user_data:
                    # user_data[0] = display_name, user_data[1] = avatar_url
                    dname = user_data[0] if user_data[0] else u
                    
                    # Ensure we don't load an empty string as an image
                    if user_data[1] and user_data[1].strip():
                        if user_data[1].startswith("http"):
                            av = user_data[1]
                        else:
                            av = "/frontend/" + user_data[1].lstrip('/')
                else:
                    dname = u
                    
            except sqlite3.OperationalError:
                # Safety net just in case the database columns act up
                dname = u
            
            # Check if Solved
            if c.execute("SELECT 1 FROM solved_problems WHERE username=? AND problem_id=?", (u, id)).fetchone():
                solved = True
                
    # 3. Prepare display status
    status_msg = "✅ Solved" if solved else "❌ Not Solved"

    # 4. Inject all variables safely
    prob_type = (m[3] or "answer").lower()
    type_display = {"answer": "📝 ANSWER", "code": "💻 CODE"}.get(prob_type, "📝 ANSWER")

    # Code-type problems get the full OJ judge UI (language select, code box,
    # run/submit against a hidden test case); answer-type problems keep the
    # original simple text-box-and-submit template unchanged.
    template_name = "problem_code.html" if prob_type == "code" else "problem.html"

    with open(os.path.join(D_F, template_name), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{id}}", str(id))\
            .replace("{{u}}", str(dname))\
            .replace("{{avatar}}", str(av))\
            .replace("{{t}}", str(m[0]))\
            .replace("{{xp}}", str(m[1]))\
            .replace("{{stmt}}", str(m[2]))\
            .replace("{{type}}", type_display)\
            .replace("{{status}}", status_msg)\
            .replace("{{nav}}", nav_html(u))

DEFAULT_AVATAR = "https://thumbs.dreamstime.com/b/binary-code-matrix-background-digital-technology-vector-computer-data-green-numbers-pattern-streams-zero-one-digits-182437658.jpg"

# ────────────────────────────────────────
# Official solutions + user-submitted solutions (code-type problems only)
# ────────────────────────────────────────
def solution_page_content(problem_id, official_solution, official_solution_lang, viewer_is_admin):
    """Returns (edit_btn_html, body_html, edit_modal_html) for the official
    solution page. Editing is admin-only; everyone else just views it."""
    lang = (official_solution_lang or "sage").lower()
    if lang not in VALID_SOLUTION_LANGS:
        lang = "sage"
    lang_label = SOLUTION_LANG_LABELS.get(lang, "SageMath")

    edit_btn = ""
    edit_modal = ""
    if viewer_is_admin:
        has_solution = bool(official_solution and official_solution.strip())
        btn_label = "✎ Edit Solution" if has_solution else "+ Add Solution"
        edit_btn = f'<button type="button" class="back-btn" onclick="openSolEditModal()" style="margin-bottom:20px;">{btn_label}</button>'
        current_code = html.escape(official_solution or "")
        edit_modal = f'''<div id="sol-edit-backdrop" class="modal-backdrop" style="display:none;" onclick="closeSolEditModal()"></div>
<div id="sol-edit-modal" class="window modal-window" role="dialog" aria-modal="true" aria-labelledby="sol-edit-title"
     style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); width:700px; max-width:90vw; background:#000; z-index:1000; padding:30px; border:1px solid #00ff66;">
    <h3 id="sol-edit-title">Edit Official Solution</h3>

    <p style="opacity:0.8; margin-bottom:10px;">Language: <strong>⌁ SageMath</strong> (the only language this judge supports)</p>

    <label for="sol_edit_content">Solution:</label>
    <textarea id="sol_edit_content" rows="14" maxlength="{SOLUTION_CODE_MAX}" class="comment-input" style="width:100%; font-family:monospace;">{current_code}</textarea>

    <div style="display:flex; gap:10px; margin-top:14px;">
        <button type="button" class="back-btn" style="flex:1;" onclick="saveSolEdit()">Save</button>
        <button type="button" class="back-btn" style="flex:1; background:#333;" onclick="closeSolEditModal()">Cancel</button>
    </div>
</div>
<script>
function openSolEditModal() {{
    document.getElementById('sol-edit-modal').style.display = 'block';
    document.getElementById('sol-edit-backdrop').style.display = 'block';
}}
function closeSolEditModal() {{
    document.getElementById('sol-edit-modal').style.display = 'none';
    document.getElementById('sol-edit-backdrop').style.display = 'none';
}}
document.addEventListener('keydown', function (e) {{ if (e.key === 'Escape') closeSolEditModal(); }});
async function saveSolEdit() {{
    const language = 'sage';
    const content = document.getElementById('sol_edit_content').value;
    try {{
        const res = await fetch('/api/problem/{problem_id}/solution', {{
            method: 'POST',
            headers: {{'Content-Type': 'application/json'}},
            body: JSON.stringify({{ language: language, content: content }})
        }});
        const data = await res.json();
        showNotification(data.msg, data.success ? 'success' : 'error');
        if (data.success) setTimeout(function () {{ location.reload(); }}, 700);
    }} catch (e) {{
        showNotification('Error saving solution.', 'error');
    }}
}}
</script>'''

    if official_solution and official_solution.strip():
        body = f'''<div class="solution-lang-badge">{lang_label}</div>
        <pre class="solution-code-block"><code>{html.escape(official_solution)}</code></pre>'''
    else:
        body = '<p class="comment-empty">No official solution has been added yet.</p>'

    return edit_btn, body, edit_modal

@app.route("/problem/<id>/solution")
def problem_solution_page(id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT title, type, official_solution, official_solution_lang FROM initial_misions WHERE id=?", (id,)).fetchone()
    if not m:
        return "404", 404
    title, prob_type, official_solution, official_lang = m
    if (prob_type or "answer").lower() != "code":
        return "404 — Solutions are only available for code-type problems.", 404

    edit_btn, body, edit_modal = solution_page_content(id, official_solution, official_lang, is_admin(u))

    with open(os.path.join(D_F, "solution.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{id}}", str(id))\
            .replace("{{title}}", html.escape(title))\
            .replace("{{edit_btn}}", edit_btn)\
            .replace("{{content_html}}", body)\
            .replace("{{edit_modal}}", edit_modal)\
            .replace("{{nav}}", nav_html(u))

@app.route("/api/problem/<id>/solution", methods=["POST"])
def save_official_solution(id):
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403

    data = request.json or {}
    language = (data.get("language") or "sage").lower()
    if language not in VALID_SOLUTION_LANGS:
        return jsonify({"success": False, "msg": "Invalid language."}), 400
    content = (data.get("content") or "").strip()
    if len(content) > SOLUTION_CODE_MAX:
        return jsonify({"success": False, "msg": f"Solution is limited to {SOLUTION_CODE_MAX} characters."}), 400

    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT type FROM initial_misions WHERE id=?", (id,)).fetchone()
        if not m:
            return jsonify({"success": False, "msg": "Problem not found."}), 404
        if (m[0] or "answer").lower() != "code":
            return jsonify({"success": False, "msg": "Solutions are only available for code-type problems."}), 400
        c.execute("UPDATE initial_misions SET official_solution=?, official_solution_lang=? WHERE id=?", (content, language, id))

    return jsonify({"success": True, "msg": "Official solution saved."})

def solution_submit_modal_html(problem_id):
    """'Submit a Solution' button + modal (language tabs, code textarea with a
    character counter, and a public/private share toggle) + its JS. Plain
    string with token replacement, not an f-string, since the embedded JS is
    full of literal braces that would otherwise need doubling-up everywhere."""
    tpl = '''<button type="button" class="back-btn" onclick="openSubmitSolModal()">Submit a Solution</button>

<div id="submit-sol-backdrop" class="modal-backdrop" style="display:none;" onclick="closeSubmitSolModal()"></div>
<div id="submit-sol-modal" class="window modal-window" role="dialog" aria-modal="true" aria-labelledby="submit-sol-title"
     style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); width:700px; max-width:90vw; background:#000; z-index:1000; padding:30px; border:1px solid #00ff66;">
    <h3 id="submit-sol-title">Submit Solution</h3>
    <p style="opacity:0.8; margin-bottom:14px;">Help others out by sharing a solution. Please make sure it passes all test cases.</p>

    <p style="opacity:0.8; margin-bottom:10px;">Language: <strong>⌁ SageMath</strong></p>

    <label for="sol_code" class="sr-only">Solution code</label>
    <textarea id="sol_code" rows="12" maxlength="__CODE_MAX__" placeholder="Paste your solution code here..." class="comment-input" style="width:100%; font-family:monospace; margin-top:10px;"></textarea>
    <div class="comment-form-row"><span></span><span class="comment-counter" id="sol_code_counter">0 / __CODE_MAX__</span></div>

    <div class="sol-share-row">
        <span>Share Solution Code<br><small style="opacity:0.7;">This will allow other users to view your solution code if they are stuck.</small></span>
        <label class="sol-toggle">
            <input type="checkbox" id="sol_is_public" checked>
            <span class="sol-toggle-slider"></span>
        </label>
    </div>

    <div style="display:flex; gap:10px; margin-top:14px;">
        <button type="button" class="back-btn" style="flex:1;" onclick="submitSolution()">Submit Solution</button>
        <button type="button" class="back-btn" style="flex:1; background:#333;" onclick="closeSubmitSolModal()">Cancel</button>
    </div>
</div>

<script>
var __selectedSolLang = 'sage';
function openSubmitSolModal() {
    document.getElementById('submit-sol-modal').style.display = 'block';
    document.getElementById('submit-sol-backdrop').style.display = 'block';
}
function closeSubmitSolModal() {
    document.getElementById('submit-sol-modal').style.display = 'none';
    document.getElementById('submit-sol-backdrop').style.display = 'none';
}
document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeSubmitSolModal(); });
document.getElementById('sol_code').addEventListener('input', function () {
    document.getElementById('sol_code_counter').textContent = this.value.length + ' / __CODE_MAX__';
});
async function submitSolution() {
    const code = document.getElementById('sol_code').value;
    const isPublic = document.getElementById('sol_is_public').checked;
    try {
        const res = await fetch('/api/solutions/__PROBLEM_ID__', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ language: __selectedSolLang, code: code, is_public: isPublic })
        });
        const data = await res.json();
        showNotification(data.msg, data.success ? 'success' : 'error');
        if (data.success) setTimeout(function () { location.reload(); }, 700);
    } catch (e) {
        showNotification('Error submitting solution.', 'error');
    }
}
</script>'''
    return tpl.replace("__CODE_MAX__", str(SOLUTION_CODE_MAX)).replace("__PROBLEM_ID__", str(problem_id))

def render_solution_card(sid, username, dname, rank_color, language, code, votes, user_voted, viewer):
    lang_label = SOLUTION_LANG_LABELS.get(language, language.upper())
    vote_html = ""
    if viewer and viewer != username:
        label = "Upvoted" if user_voted else "Upvote"
        cls = " active" if user_voted else ""
        vote_html = f'<button type="button" class="solution-upvote-btn{cls}" data-sol-id="{sid}">({label})</button>'
    return f'''<div class="solution-card">
    <div class="solution-card-meta">
        {colored_name_link_html(username, dname, rank_color)}
        <span class="comment-time">Votes: <strong id="sol-votes-{sid}">{votes}</strong>.</span>
        {vote_html}
        <span class="lang-badge">{lang_label}</span>
    </div>
    <div class="solution-code-wrap">
        <button type="button" class="solution-copy-btn" data-sol-id="{sid}">Copy</button>
        <pre class="solution-code-block" id="sol-code-{sid}"><code>{html.escape(code)}</code></pre>
    </div>
</div>'''

@app.route("/problem/<id>/user_solutions")
def problem_user_solutions_page(id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT title, type FROM initial_misions WHERE id=?", (id,)).fetchone()
        if not m:
            return "404", 404
        title, prob_type = m
        if (prob_type or "answer").lower() != "code":
            return "404 — Solutions are only available for code-type problems.", 404

        my_solutions = []
        if u:
            my_solutions = c.execute(
                "SELECT id, language, code, votes, is_public FROM user_solutions WHERE problem_id=? AND username=? ORDER BY id DESC",
                (id, u)
            ).fetchall()

        by_lang = {}
        for lang in VALID_SOLUTION_LANGS:
            rows = c.execute("""
                SELECT us.id, us.username, COALESCE(u2.display_name, us.username), us.code, us.votes,
                       u2.xp, u2.is_admin
                FROM user_solutions us
                LEFT JOIN users u2 ON u2.username = us.username
                WHERE us.problem_id=? AND us.language=? AND us.is_public=1
                ORDER BY us.votes DESC, us.id DESC
            """, (id, lang)).fetchall()
            by_lang[lang] = rows

        voted_ids = set()
        if u:
            all_ids = [r[0] for lang_rows in by_lang.values() for r in lang_rows]
            if all_ids:
                qmarks = ",".join("?" * len(all_ids))
                voted_ids = {row[0] for row in c.execute(
                    f"SELECT solution_id FROM user_solution_votes WHERE username=? AND solution_id IN ({qmarks})",
                    (u, *all_ids)
                ).fetchall()}

    if u:
        if my_solutions:
            my_cards = ""
            for sid, lang, code, votes, is_public in my_solutions:
                lang_label = SOLUTION_LANG_LABELS.get(lang, lang.upper())
                privacy = "" if is_public else ' <span style="opacity:0.6;">(private)</span>'
                my_cards += f'''<div class="solution-card">
    <div class="solution-card-meta">
        <span class="lang-badge">{lang_label}</span>{privacy}
    </div>
    <div class="solution-code-wrap">
        <button type="button" class="solution-copy-btn" data-sol-id="mine-{sid}">Copy</button>
        <pre class="solution-code-block" id="sol-code-mine-{sid}"><code>{html.escape(code)}</code></pre>
    </div>
</div>'''
            my_section = my_cards
        else:
            my_section = '<p class="comment-empty">No solutions yet!</p>'
    else:
        my_section = '<p class="comment-empty">Log in to submit and track your own solutions.</p>'

    lang_sections = ""
    for lang in ("sage",):
        rows = by_lang.get(lang, [])
        label = SOLUTION_LANG_LABELS.get(lang, lang.upper())
        lang_sections += f'<h3 class="solution-section-title">Public {label} Solutions ({len(rows)})</h3>\n'
        if rows:
            for sid, uname, dname, code, votes, xp, admin_flag in rows:
                _, rank_color = get_rank_info(xp or 0, bool(admin_flag))
                lang_sections += render_solution_card(sid, uname, dname, rank_color, lang, code, votes, sid in voted_ids, u)
        else:
            lang_sections += '<p class="comment-empty">No solutions yet!</p>'

    if u:
        submit_area = solution_submit_modal_html(id)
    else:
        submit_area = '<p class="comment-login-prompt"><span>Log in to submit a solution.</span><a href="/frontend/login.html" class="back-btn">Log In</a></p>'

    with open(os.path.join(D_F, "user_solutions.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{id}}", str(id))\
            .replace("{{title}}", html.escape(title))\
            .replace("{{submit_area}}", submit_area)\
            .replace("{{my_solutions}}", my_section)\
            .replace("{{lang_sections}}", lang_sections)\
            .replace("{{nav}}", nav_html(u))

@app.route("/api/solutions/<problem_id>", methods=["POST"])
def submit_user_solution(problem_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to submit a solution."}), 401

    with sqlite3.connect(DB_U) as c:
        m = c.execute("SELECT type FROM initial_misions WHERE id=?", (problem_id,)).fetchone()
        if not m:
            return jsonify({"success": False, "msg": "Problem not found."}), 404
        if (m[0] or "answer").lower() != "code":
            return jsonify({"success": False, "msg": "Solutions are only available for code-type problems."}), 400

    data = request.json or {}
    language = (data.get("language") or "").lower()
    if language not in VALID_SOLUTION_LANGS:
        return jsonify({"success": False, "msg": "Invalid language."}), 400
    code = (data.get("code") or "").strip()
    if not code:
        return jsonify({"success": False, "msg": "Solution code can't be empty."}), 400
    if len(code) > SOLUTION_CODE_MAX:
        return jsonify({"success": False, "msg": f"Solution is limited to {SOLUTION_CODE_MAX} characters."}), 400
    is_public = 1 if data.get("is_public", True) else 0

    created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with sqlite3.connect(DB_U) as c:
        c.execute(
            "INSERT INTO user_solutions (problem_id, username, language, code, is_public, votes, created_at) VALUES (?, ?, ?, ?, ?, 0, ?)",
            (problem_id, u, language, code, is_public, created_at)
        )

    return jsonify({"success": True, "msg": "Solution submitted!"})

@app.route("/api/solutions/<int:solution_id>/vote", methods=["POST"])
def vote_user_solution(solution_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to vote."}), 401

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT username FROM user_solutions WHERE id=?", (solution_id,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "Solution not found."}), 404
        if row[0] == u:
            return jsonify({"success": False, "msg": "You can't vote on your own solution."}), 400

        existing = c.execute(
            "SELECT 1 FROM user_solution_votes WHERE solution_id=? AND username=?", (solution_id, u)
        ).fetchone()

        if existing:
            c.execute("DELETE FROM user_solution_votes WHERE solution_id=? AND username=?", (solution_id, u))
            c.execute("UPDATE user_solutions SET votes = votes - 1 WHERE id=?", (solution_id,))
            new_voted = False
        else:
            c.execute("INSERT INTO user_solution_votes (solution_id, username) VALUES (?, ?)", (solution_id, u))
            c.execute("UPDATE user_solutions SET votes = votes + 1 WHERE id=?", (solution_id,))
            new_voted = True

        new_votes = c.execute("SELECT votes FROM user_solutions WHERE id=?", (solution_id,)).fetchone()[0]

    return jsonify({"success": True, "votes": new_votes, "voted": new_voted})

@app.route("/api/comments/<problem_id>")
def get_comments(problem_id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        rows = c.execute("""
            SELECT cm.id, cm.username, COALESCE(us.display_name, cm.username), us.avatar_url,
                   cm.content, cm.created_at, cm.score
            FROM comments cm
            LEFT JOIN users us ON us.username = cm.username
            WHERE cm.problem_id = ?
            ORDER BY cm.score DESC, cm.id DESC
        """, (problem_id,)).fetchall()

        user_votes = {}
        if u:
            user_votes = dict(c.execute(
                "SELECT comment_id, vote FROM comment_votes WHERE username=?", (u,)
            ).fetchall())

    out = []
    for cid, uname, dname, av, content, created_at, score in rows:
        out.append({
            "id": cid,
            "username": uname,
            "display_name": dname,
            "avatar_url": (av or "").strip() or DEFAULT_AVATAR,
            "content": content,
            "created_at": created_at,
            "score": score,
            "user_vote": user_votes.get(cid, 0),
            "is_owner": bool(u) and (u == uname),
        })
    return jsonify({"comments": out, "logged_in": bool(u)})

@app.route("/api/comments/<problem_id>", methods=["POST"])
def post_comment(problem_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to comment."}), 401

    with sqlite3.connect(DB_U) as c:
        if not c.execute("SELECT 1 FROM initial_misions WHERE id=?", (problem_id,)).fetchone():
            return jsonify({"success": False, "msg": "Problem not found."}), 404

    data = request.json or {}
    content, err = moderate_comment(data.get("content", ""))
    if err:
        return jsonify({"success": False, "msg": err}), 400

    created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with sqlite3.connect(DB_U) as c:
        cur = c.execute(
            "INSERT INTO comments (problem_id, username, content, created_at, score) VALUES (?, ?, ?, ?, 0)",
            (problem_id, u, content, created_at)
        )
        new_id = cur.lastrowid
        row = c.execute("SELECT COALESCE(display_name, username), avatar_url FROM users WHERE username=?", (u,)).fetchone()

    dname, av = row if row else (u, None)

    return jsonify({
        "success": True,
        "comment": {
            "id": new_id,
            "username": u,
            "display_name": dname,
            "avatar_url": (av or "").strip() or DEFAULT_AVATAR,
            "content": content,
            "created_at": created_at,
            "score": 0,
            "user_vote": 0,
            "is_owner": True,
        }
    })

@app.route("/api/comments/vote", methods=["POST"])
def vote_comment():
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to vote."}), 401

    data = request.json or {}
    try:
        comment_id = int(data.get("comment_id"))
        vote = int(data.get("vote"))
    except (TypeError, ValueError):
        return jsonify({"success": False, "msg": "Invalid vote."}), 400
    if vote not in (1, -1):
        return jsonify({"success": False, "msg": "Invalid vote."}), 400

    with sqlite3.connect(DB_U) as c:
        if not c.execute("SELECT 1 FROM comments WHERE id=?", (comment_id,)).fetchone():
            return jsonify({"success": False, "msg": "Comment not found."}), 404

        existing = c.execute(
            "SELECT vote FROM comment_votes WHERE comment_id=? AND username=?", (comment_id, u)
        ).fetchone()

        if existing and existing[0] == vote:
            # Clicking the same arrow again removes the vote (toggle off)
            c.execute("DELETE FROM comment_votes WHERE comment_id=? AND username=?", (comment_id, u))
            c.execute("UPDATE comments SET score = score - ? WHERE id=?", (vote, comment_id))
            new_vote = 0
        elif existing:
            # Switching from up to down (or vice versa)
            c.execute("UPDATE comment_votes SET vote=? WHERE comment_id=? AND username=?", (vote, comment_id, u))
            c.execute("UPDATE comments SET score = score + ? WHERE id=?", (2 * vote, comment_id))
            new_vote = vote
        else:
            c.execute("INSERT INTO comment_votes (comment_id, username, vote) VALUES (?, ?, ?)", (comment_id, u, vote))
            c.execute("UPDATE comments SET score = score + ? WHERE id=?", (vote, comment_id))
            new_vote = vote

        new_score = c.execute("SELECT score FROM comments WHERE id=?", (comment_id,)).fetchone()[0]

    return jsonify({"success": True, "score": new_score, "user_vote": new_vote})

@app.route("/api/comments/<int:comment_id>/delete", methods=["POST"])
def delete_comment(comment_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in."}), 401

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT username FROM comments WHERE id=?", (comment_id,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "Comment not found."}), 404
        if row[0] != u:
            return jsonify({"success": False, "msg": "You can only delete your own comments."}), 403
        c.execute("DELETE FROM comments WHERE id=?", (comment_id,))
        c.execute("DELETE FROM comment_votes WHERE comment_id=?", (comment_id,))

    return jsonify({"success": True})

@app.route("/api/comments/<int:comment_id>/report", methods=["POST"])
def report_comment(comment_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to report a comment."}), 401

    data = request.json or {}
    reason = (data.get("reason") or "").strip()[:300]

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT username FROM comments WHERE id=?", (comment_id,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "Comment not found."}), 404
        if row[0] == u:
            return jsonify({"success": False, "msg": "You can't report your own comment."}), 400

        created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        try:
            c.execute(
                "INSERT INTO comment_reports (comment_id, reporter_username, reason, created_at, resolved) VALUES (?, ?, ?, ?, 0)",
                (comment_id, u, reason, created_at)
            )
        except sqlite3.IntegrityError:
            return jsonify({"success": False, "msg": "You've already reported this comment."}), 400

    return jsonify({"success": True, "msg": "Thanks — this comment has been reported for review."})

# ────────────────────────────────────────
# Admin panel: review reported comments, dismiss or remove them.
# ────────────────────────────────────────
def admin_page_html(u):
    return f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="/style.css">
    <script src="/notify.js"></script>
</head>
<body class="oj-bg">
    <header>
        <h1>ChanceField</h1>
        <p>&gt; ADMIN CONTROL PANEL</p>
    </header>

    <nav>
        {nav_html(u)}
    </nav>

    <main>
        <section class="window">
            <h2>REPORTED COMMENTS</h2>
            <p style="opacity:0.75; margin-bottom:16px;">Comments flagged by users appear here for review.
            Dismiss clears the flag and keeps the comment; Delete removes it permanently.</p>
            <div id="admin-reports-list">
                <p class="comment-empty">Loading reports…</p>
            </div>
        </section>
    </main>

    <script>
    (function () {{
        const listEl = document.getElementById('admin-reports-list');

        function buildReportCard(r) {{
            const card = document.createElement('div');
            card.className = 'comment-item';
            card.style.flexDirection = 'column';
            card.style.alignItems = 'stretch';

            const meta = document.createElement('div');
            meta.className = 'comment-meta';
            const author = document.createElement('span');
            author.className = 'comment-author';
            author.textContent = `${{r.author}} · comment #${{r.comment_id}}`;
            const link = document.createElement('a');
            link.href = `/problem/${{r.problem_id}}`;
            link.textContent = 'View problem →';
            link.style.marginLeft = 'auto';
            link.style.color = '#00ccff';
            meta.appendChild(author);
            meta.appendChild(link);

            const text = document.createElement('p');
            text.className = 'comment-text';
            text.textContent = r.content;

            const reportInfo = document.createElement('div');
            reportInfo.style.fontSize = '0.85rem';
            reportInfo.style.opacity = '0.75';
            reportInfo.style.margin = '8px 0';
            const reasons = r.reports.map(x => x.reporter + (x.reason ? ' — "' + x.reason + '"' : '')).join('; ');
            reportInfo.textContent = `⚠ Reported ${{r.report_count}} time(s)` + (reasons ? ': ' + reasons : '');

            const btnRow = document.createElement('div');
            btnRow.style.display = 'flex';
            btnRow.style.gap = '10px';
            btnRow.style.marginTop = '10px';

            const dismissBtn = document.createElement('button');
            dismissBtn.type = 'button';
            dismissBtn.className = 'back-btn';
            dismissBtn.textContent = 'Dismiss';
            dismissBtn.addEventListener('click', () => resolve(r.comment_id, 'dismiss', card));

            const deleteBtn = document.createElement('button');
            deleteBtn.type = 'button';
            deleteBtn.className = 'comment-delete-btn';
            deleteBtn.style.minHeight = '44px';
            deleteBtn.style.padding = '10px 20px';
            deleteBtn.style.fontSize = '1rem';
            deleteBtn.textContent = 'Delete Comment';
            deleteBtn.addEventListener('click', () => {{
                if (confirm('Permanently delete this comment?')) resolve(r.comment_id, 'delete', card);
            }});

            btnRow.appendChild(dismissBtn);
            btnRow.appendChild(deleteBtn);

            card.appendChild(meta);
            card.appendChild(text);
            card.appendChild(reportInfo);
            card.appendChild(btnRow);
            return card;
        }}

        async function resolve(commentId, action, card) {{
            try {{
                const res = await fetch(`/api/admin/reports/${{commentId}}/resolve`, {{
                    method: 'POST',
                    headers: {{'Content-Type': 'application/json'}},
                    body: JSON.stringify({{ action }})
                }});
                const data = await res.json();
                if (data.success) {{
                    card.remove();
                    showNotification(action === 'delete' ? 'Comment deleted.' : 'Report dismissed.', 'success');
                    if (!listEl.querySelector('.comment-item')) {{
                        listEl.innerHTML = '<p class="comment-empty">No pending reports — all clear!</p>';
                    }}
                }} else {{
                    showNotification(data.msg || 'Action failed.', 'error');
                }}
            }} catch (e) {{
                showNotification('Error processing action.', 'error');
            }}
        }}

        async function load() {{
            try {{
                const res = await fetch('/api/admin/reports');
                const data = await res.json();
                listEl.innerHTML = '';
                if (!data.reports || data.reports.length === 0) {{
                    listEl.innerHTML = '<p class="comment-empty">No pending reports — all clear!</p>';
                    return;
                }}
                data.reports.forEach(r => listEl.appendChild(buildReportCard(r)));
            }} catch (e) {{
                listEl.innerHTML = '<p class="comment-empty">Could not load reports.</p>';
            }}
        }}

        load();
    }})();
    </script>
</body>
</html>"""

@app.route("/admin")
def admin_page():
    u = get_u()
    if not u or not is_admin(u):
        return redirect("/")
    return admin_page_html(u)

@app.route("/api/admin/reports")
def admin_reports():
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403

    with sqlite3.connect(DB_U) as c:
        rows = c.execute("""
            SELECT cm.id, cm.problem_id, cm.username, cm.content, cm.created_at, cm.score,
                   COUNT(cr.id) as report_count,
                   GROUP_CONCAT(cr.reporter_username || ':' || COALESCE(cr.reason,''), '||')
            FROM comment_reports cr
            JOIN comments cm ON cm.id = cr.comment_id
            WHERE cr.resolved = 0
            GROUP BY cm.id
            ORDER BY report_count DESC, cm.id DESC
        """).fetchall()

    reports = []
    for cid, pid, author, content, created_at, score, rcount, detail in rows:
        report_items = []
        if detail:
            for part in detail.split('||'):
                rep_user, _, rep_reason = part.partition(':')
                report_items.append({"reporter": rep_user, "reason": rep_reason})
        reports.append({
            "comment_id": cid,
            "problem_id": pid,
            "author": author,
            "content": content,
            "created_at": created_at,
            "score": score,
            "report_count": rcount,
            "reports": report_items,
        })
    return jsonify({"reports": reports})

@app.route("/api/admin/reports/<int:comment_id>/resolve", methods=["POST"])
def admin_resolve_report(comment_id):
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403

    data = request.json or {}
    action = data.get("action")
    if action not in ("dismiss", "delete"):
        return jsonify({"success": False, "msg": "Invalid action."}), 400

    with sqlite3.connect(DB_U) as c:
        if action == "delete":
            c.execute("DELETE FROM comments WHERE id=?", (comment_id,))
            c.execute("DELETE FROM comment_votes WHERE comment_id=?", (comment_id,))
            c.execute("DELETE FROM comment_reports WHERE comment_id=?", (comment_id,))
        else:
            c.execute("UPDATE comment_reports SET resolved=1 WHERE comment_id=?", (comment_id,))

    return jsonify({"success": True})

# ── Admin: per-user ban / warn (buttons on /user/<username>) ──
@app.route("/api/admin/users/<username>/ban", methods=["POST"])
def admin_toggle_ban(username):
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403

    data = request.json or {}
    action = data.get("action")
    if action not in ("ban", "unban"):
        return jsonify({"success": False, "msg": "Invalid action."}), 400

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT is_admin FROM users WHERE username=?", (username,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "User not found."}), 404
        if row[0]:
            return jsonify({"success": False, "msg": "Admin accounts can't be banned."}), 400
        c.execute("UPDATE users SET is_banned=? WHERE username=?", (1 if action == "ban" else 0, username))

    msg = f"{username} has been banned." if action == "ban" else f"{username} has been unbanned."
    return jsonify({"success": True, "msg": msg})

@app.route("/api/admin/users/<username>/warn", methods=["POST"])
def admin_warn_user(username):
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403

    data = request.json or {}
    message = (data.get("message") or "").strip()
    if not message:
        return jsonify({"success": False, "msg": "Warning message can't be empty."}), 400
    if len(message) > 1000:
        return jsonify({"success": False, "msg": "Warning message is limited to 1000 characters."}), 400

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT is_admin FROM users WHERE username=?", (username,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "User not found."}), 404
        if row[0]:
            return jsonify({"success": False, "msg": "Admin accounts can't be warned."}), 400
        c.execute("UPDATE users SET warning_message=? WHERE username=?", (message, username))

    return jsonify({"success": True, "msg": f"Warning sent to {username} — they'll see it on their next page load."})

@app.route("/api/admin/users/<username>/clear_warning", methods=["POST"])
def admin_clear_warning(username):
    u = get_u()
    if not u or not is_admin(u):
        return jsonify({"success": False, "msg": "Admin access required."}), 403
    with sqlite3.connect(DB_U) as c:
        c.execute("UPDATE users SET warning_message=NULL WHERE username=?", (username,))
    return jsonify({"success": True, "msg": "Warning cleared."})

#DELETE TS BELOW WHEN LAUNCHING THE WEB

@app.route("/api/admin/promote", methods=["POST"])
def promote_admin():
    """Bootstrap route to grant admin rights, protected by a shared secret
    rather than requiring an existing admin — the very first admin has no
    one to promote them. Change ADMIN_SECRET above before deploying, and
    consider removing/blocking this route once your admin account exists."""
    data = request.json or {}
    if data.get("secret") != ADMIN_SECRET:
        return jsonify({"success": False, "msg": "Invalid secret."}), 403

    target = (data.get("username") or "").strip()
    with sqlite3.connect(DB_U) as c:
        if not c.execute("SELECT 1 FROM users WHERE username=?", (target,)).fetchone():
            return jsonify({"success": False, "msg": "User not found."}), 404
        c.execute("UPDATE users SET is_admin=1 WHERE username=?", (target,))

    return jsonify({"success": True, "msg": f"{target} is now an admin."})

#=============================================================================#

# ────────────────────────────────────
# Blog
# ────────────────────────────────────
BLOG_TITLE_MAX = 120
BLOG_DESC_MAX = 300
BLOG_CONTENT_MAX = 5000
BLOG_PER_PAGE = 12

BLOG_GUIDELINES_HTML = f'''<div class="comment-guidelines">
    <strong>Posting Guidelines:</strong> Be respectful — no harassment, hate speech, or spam.
    Don't post personal information (emails, phone numbers, or anyone's real contact details).
    Title max {BLOG_TITLE_MAX} characters, description max {BLOG_DESC_MAX} characters,
    full post max {BLOG_CONTENT_MAX} characters. Posts that break these rules are rejected automatically.
</div>'''

def moderate_blog_field(text, max_len, field_label):
    """Same rules as moderate_comment (respect, no contact info) but with a
    caller-supplied length cap and field name, since title/description/content
    each have their own limit."""
    text = (text or "").strip()
    if not text:
        return None, f"{field_label} can't be empty."
    if len(text) > max_len:
        return None, f"{field_label} is limited to {max_len} characters."

    lowered = text.lower()
    for w in BAD_WORDS:
        if re.search(rf'\b{re.escape(w)}\b', lowered):
            return None, "Please keep posts respectful — that language isn't allowed here."

    if EMAIL_RE.search(text):
        return None, "For your privacy and safety, please don't post email addresses."
    if PHONE_RE.search(text):
        return None, "For your privacy and safety, please don't post phone numbers."

    return text, None

def time_ago(created_at_str):
    """Formats a 'YYYY-MM-DD HH:MM:SS' timestamp as a relative string like
    the '40 hours ago' style used on the blog feed."""
    try:
        dt = datetime.strptime(created_at_str, "%Y-%m-%d %H:%M:%S")
    except (TypeError, ValueError):
        return created_at_str or ""
    secs = (datetime.now() - dt).total_seconds()
    if secs < 60:
        return "just now"
    mins = int(secs // 60)
    if mins < 60:
        return f"{mins} minute{'s' if mins != 1 else ''} ago"
    hrs = int(mins // 60)
    if hrs < 24:
        return f"{hrs} hour{'s' if hrs != 1 else ''} ago"
    days = int(hrs // 24)
    if days < 30:
        return f"{days} day{'s' if days != 1 else ''} ago"
    months = int(days // 30)
    if months < 12:
        return f"{months} month{'s' if months != 1 else ''} ago"
    years = int(days // 365)
    return f"{years} year{'s' if years != 1 else ''} ago"

def render_blog_card(post_id, username, dname, rank_color, title, description, created_at, score, user_vote=0):
    """One post card for feed/tab listings — reuses the comment-item/vote CSS
    from problem.html's comment section so the visual language matches.
    Posts are shown collapsed (title + description only); 'View Full' goes
    to the dedicated post page for the full content + comments."""
    up_active = " active" if user_vote == 1 else ""
    down_active = " active" if user_vote == -1 else ""
    return f'''<div class="comment-item blog-card">
    <div class="comment-vote blog-vote" data-post-id="{post_id}">
        <button type="button" class="vote-btn vote-up{up_active}" data-vote="1" aria-label="Upvote post">▲</button>
        <span class="vote-score">{score}</span>
        <button type="button" class="vote-btn vote-down{down_active}" data-vote="-1" aria-label="Downvote post">▼</button>
    </div>
    <div class="comment-body">
        <a href="/blog/{post_id}" class="blog-title-link">{html.escape(title)}</a>
        <div class="comment-meta">
            {colored_name_link_html(username, dname, rank_color)}
            <span class="comment-time">{time_ago(created_at)}</span>
        </div>
        <p class="comment-text blog-desc">{html.escape(description)}</p>
        <a href="/blog/{post_id}" class="back-btn blog-view-full">View Full &amp; Comments →</a>
    </div>
</div>'''

def blog_composer_html():
    """'+ New Post' button + compose modal (title/description/content, all
    length-capped) + its open/close/submit script. Plain string with token
    replacement rather than an f-string, since the embedded JS is full of
    literal braces that would otherwise need escaping."""
    tpl = '''<button type="button" class="back-btn blog-new-post-btn" onclick="openPostModal()">+ New Post</button>

<div id="post-backdrop" class="modal-backdrop" style="display:none;" onclick="closePostModal()"></div>
<div id="post-modal" class="window modal-window" role="dialog" aria-modal="true" aria-labelledby="post-modal-title"
     style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); width:600px; max-width:90vw; background:#000; z-index:1000; padding:30px; border: 1px solid #00ff66;">
    <h3 id="post-modal-title">NEW BLOG POST</h3>

    <label for="post_title">Title:</label>
    <input type="text" id="post_title" maxlength="__TITLE_MAX__" placeholder="A short, descriptive title" class="oj-inp" style="width:100%; margin-bottom:10px;" autocomplete="off">

    <label for="post_description">Description (short summary shown in listings):</label>
    <textarea id="post_description" maxlength="__DESC_MAX__" rows="2" placeholder="One or two sentences..." class="comment-input" style="width:100%; margin-bottom:4px;"></textarea>
    <div class="comment-form-row" style="margin-bottom:10px;"><span></span><span class="comment-counter" id="post_description_counter">0 / __DESC_MAX__</span></div>

    <label for="post_content">Full post:</label>
    <textarea id="post_content" maxlength="__CONTENT_MAX__" rows="8" placeholder="Write your full post here..." class="comment-input" style="width:100%; margin-bottom:4px;"></textarea>
    <div class="comment-form-row" style="margin-bottom:10px;"><span></span><span class="comment-counter" id="post_content_counter">0 / __CONTENT_MAX__</span></div>

    <div style="display: flex; gap: 10px; margin-top:10px;">
        <button type="button" onclick="submitPost()" class="back-btn" style="flex:1;">Post</button>
        <button type="button" onclick="closePostModal()" class="back-btn" style="flex:1; background:#333;">Cancel</button>
    </div>
</div>

<script>
function openPostModal() {
    document.getElementById('post-modal').style.display = 'block';
    document.getElementById('post-backdrop').style.display = 'block';
    document.getElementById('post_title').focus();
}
function closePostModal() {
    document.getElementById('post-modal').style.display = 'none';
    document.getElementById('post-backdrop').style.display = 'none';
}
document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closePostModal();
});
(function () {
    var descEl = document.getElementById('post_description');
    var contentEl = document.getElementById('post_content');
    descEl.addEventListener('input', function () {
        document.getElementById('post_description_counter').textContent = this.value.length + ' / __DESC_MAX__';
    });
    contentEl.addEventListener('input', function () {
        document.getElementById('post_content_counter').textContent = this.value.length + ' / __CONTENT_MAX__';
    });
})();
async function submitPost() {
    const title = document.getElementById('post_title').value;
    const description = document.getElementById('post_description').value;
    const content = document.getElementById('post_content').value;
    try {
        const res = await fetch('/api/blog/create', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({ title: title, description: description, content: content })
        });
        const data = await res.json();
        showNotification(data.msg, data.success ? 'success' : 'error');
        if (data.success) setTimeout(function () { location.reload(); }, 800);
    } catch (e) {
        showNotification('Error posting.', 'error');
    }
}
</script>'''
    return (tpl.replace("__TITLE_MAX__", str(BLOG_TITLE_MAX))
               .replace("__DESC_MAX__", str(BLOG_DESC_MAX))
               .replace("__CONTENT_MAX__", str(BLOG_CONTENT_MAX)))

def build_acc_tabs(base_path, active_tab):
    """Tab strip (SUBMISSIONS / BLOG) shown next to the profile card on
    /frontend/account.html and /user/<username>."""
    tabs = (("submissions", "SUBMISSIONS"), ("blog", "BLOG"))
    parts = []
    for key, label in tabs:
        href = base_path if key == "submissions" else f"{base_path}?tab={key}"
        active_cls = " acc-tab-active" if active_tab == key else ""
        parts.append(f'<a href="{href}" class="acc-tab{active_cls}">{label}</a>')
    return "\n".join(parts)

def build_account_blog_tab(target_username, is_owner, page, base_path):
    """Right-column content for the BLOG tab: guidelines + composer (owner
    only) + this user's posts, 12 per page, collapsed with a View Full link."""
    with sqlite3.connect(DB_U) as c:
        total = c.execute("SELECT COUNT(*) FROM blog_posts WHERE username=?", (target_username,)).fetchone()[0]
        total_pages = max(1, math.ceil(total / BLOG_PER_PAGE))
        page = min(max(1, page), total_pages)
        offset = (page - 1) * BLOG_PER_PAGE
        posts = c.execute(
            "SELECT id, title, description, created_at, score FROM blog_posts WHERE username=? ORDER BY id DESC LIMIT ? OFFSET ?",
            (target_username, BLOG_PER_PAGE, offset)
        ).fetchall()

        rank_row = c.execute("SELECT xp, is_admin, display_name FROM users WHERE username=?", (target_username,)).fetchone()

        viewer = get_u()
        user_votes = {}
        if viewer and posts:
            ids = [p[0] for p in posts]
            qmarks = ",".join("?" * len(ids))
            user_votes = dict(c.execute(
                f"SELECT post_id, vote FROM blog_votes WHERE username=? AND post_id IN ({qmarks})",
                (viewer, *ids)
            ).fetchall())

    xp, admin_flag, dname = rank_row if rank_row else (0, 0, target_username)
    dname = dname or target_username
    _, rank_color = get_rank_info(xp or 0, bool(admin_flag))

    cards = "".join(
        render_blog_card(pid, target_username, dname, rank_color, title, desc, created_at, score, user_votes.get(pid, 0))
        for pid, title, desc, created_at, score in posts
    )
    if not cards:
        cards = '<p class="comment-empty">No blog posts yet.</p>'

    def url_for_page(p):
        return f"{base_path}?tab=blog&page={p}"
    pagination_html = build_pagination(page, total_pages, url_for_page)

    composer = blog_composer_html() if is_owner else ""
    guidelines = BLOG_GUIDELINES_HTML if is_owner else ""

    return f'''<h2>BLOG</h2>
        {guidelines}
        {composer}
        <div class="comment-list" style="margin-top:20px;">
            {cards}
        </div>
        <div class="archives-pagination">
            {pagination_html}
        </div>
        <script src="/blog.js"></script>'''

@app.route("/blog")
def blog_feed():
    u = get_u()
    try:
        page = max(1, int(request.args.get("page", 1)))
    except ValueError:
        page = 1

    with sqlite3.connect(DB_U) as c:
        total = c.execute("SELECT COUNT(*) FROM blog_posts").fetchone()[0]
        total_pages = max(1, math.ceil(total / BLOG_PER_PAGE))
        page = min(page, total_pages)
        offset = (page - 1) * BLOG_PER_PAGE

        posts = c.execute("""
            SELECT bp.id, bp.username, COALESCE(us.display_name, bp.username), bp.title, bp.description,
                   bp.created_at, bp.score, us.xp, us.is_admin
            FROM blog_posts bp
            LEFT JOIN users us ON us.username = bp.username
            ORDER BY bp.id DESC
            LIMIT ? OFFSET ?
        """, (BLOG_PER_PAGE, offset)).fetchall()

        user_votes = {}
        if u and posts:
            ids = [p[0] for p in posts]
            qmarks = ",".join("?" * len(ids))
            user_votes = dict(c.execute(
                f"SELECT post_id, vote FROM blog_votes WHERE username=? AND post_id IN ({qmarks})",
                (u, *ids)
            ).fetchall())

    cards = ""
    for pid, uname, dname, title, desc, created_at, score, xp, admin_flag in posts:
        _, rank_color = get_rank_info(xp or 0, bool(admin_flag))
        cards += render_blog_card(pid, uname, dname, rank_color, title, desc, created_at, score, user_votes.get(pid, 0))
    if not cards:
        cards = '<p class="comment-empty">No posts yet — be the first to share something!</p>'

    def url_for_page(p):
        return "/blog?" + urlencode({"page": p})
    pagination_html = build_pagination(page, total_pages, url_for_page)

    if u:
        composer = blog_composer_html()
    else:
        composer = '<p class="comment-login-prompt"><span>Log in to write a post.</span><a href="/frontend/login.html" class="back-btn">Log In</a></p>'

    with open(os.path.join(D_F, "blog.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{guidelines}}", BLOG_GUIDELINES_HTML)\
            .replace("{{composer}}", composer)\
            .replace("{{posts}}", cards)\
            .replace("{{pagination}}", pagination_html)\
            .replace("{{nav}}", nav_html(u))

@app.route("/blog/<int:post_id>")
def blog_post_page(post_id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        row = c.execute("""
            SELECT bp.username, COALESCE(us.display_name, bp.username), bp.title, bp.content,
                   bp.created_at, bp.score, us.xp, us.is_admin
            FROM blog_posts bp
            LEFT JOIN users us ON us.username = bp.username
            WHERE bp.id = ?
        """, (post_id,)).fetchone()
        if not row:
            return "404 Post not found", 404

        user_vote = 0
        if u:
            r = c.execute("SELECT vote FROM blog_votes WHERE post_id=? AND username=?", (post_id, u)).fetchone()
            if r: user_vote = r[0]

    uname, dname, title, content, created_at, score, xp, admin_flag = row
    _, rank_color = get_rank_info(xp or 0, bool(admin_flag))

    # Only the author can delete their own post.
    delete_post_btn = ""
    if u and u == uname:
        delete_post_btn = (
            f'<button type="button" id="delete-post-btn" class="comment-delete-btn" '
            f'style="margin-top:0;" data-post-id="{post_id}">Delete Post</button>'
        )

    with open(os.path.join(D_F, "blog_post.html"), "r", encoding="utf-8") as f:
        h = f.read()

    return h.replace("{{post_id}}", str(post_id))\
            .replace("{{title}}", html.escape(title))\
            .replace("{{author_html}}", colored_name_link_html(uname, dname, rank_color))\
            .replace("{{time_ago}}", time_ago(created_at))\
            .replace("{{content}}", html.escape(content))\
            .replace("{{score}}", str(score))\
            .replace("{{vote_up_active}}", " active" if user_vote == 1 else "")\
            .replace("{{vote_down_active}}", " active" if user_vote == -1 else "")\
            .replace("{{delete_post_btn}}", delete_post_btn)\
            .replace("{{nav}}", nav_html(u))

@app.route("/api/blog/create", methods=["POST"])
def create_blog_post():
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to post."}), 401

    data = request.json or {}
    title, err = moderate_blog_field(data.get("title", ""), BLOG_TITLE_MAX, "Title")
    if err:
        return jsonify({"success": False, "msg": err}), 400
    description, err = moderate_blog_field(data.get("description", ""), BLOG_DESC_MAX, "Description")
    if err:
        return jsonify({"success": False, "msg": err}), 400
    content, err = moderate_blog_field(data.get("content", ""), BLOG_CONTENT_MAX, "Post content")
    if err:
        return jsonify({"success": False, "msg": err}), 400

    created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with sqlite3.connect(DB_U) as c:
        cur = c.execute(
            "INSERT INTO blog_posts (username, title, description, content, created_at, score) VALUES (?, ?, ?, ?, ?, 0)",
            (u, title, description, content, created_at)
        )
        new_id = cur.lastrowid

    return jsonify({"success": True, "msg": "Post published!", "post_id": new_id})

@app.route("/api/blog/vote", methods=["POST"])
def vote_blog_post():
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to vote."}), 401

    data = request.json or {}
    try:
        post_id = int(data.get("post_id"))
        vote = int(data.get("vote"))
    except (TypeError, ValueError):
        return jsonify({"success": False, "msg": "Invalid vote."}), 400
    if vote not in (1, -1):
        return jsonify({"success": False, "msg": "Invalid vote."}), 400

    with sqlite3.connect(DB_U) as c:
        if not c.execute("SELECT 1 FROM blog_posts WHERE id=?", (post_id,)).fetchone():
            return jsonify({"success": False, "msg": "Post not found."}), 404

        existing = c.execute(
            "SELECT vote FROM blog_votes WHERE post_id=? AND username=?", (post_id, u)
        ).fetchone()

        if existing and existing[0] == vote:
            c.execute("DELETE FROM blog_votes WHERE post_id=? AND username=?", (post_id, u))
            c.execute("UPDATE blog_posts SET score = score - ? WHERE id=?", (vote, post_id))
            new_vote = 0
        elif existing:
            c.execute("UPDATE blog_votes SET vote=? WHERE post_id=? AND username=?", (vote, post_id, u))
            c.execute("UPDATE blog_posts SET score = score + ? WHERE id=?", (2 * vote, post_id))
            new_vote = vote
        else:
            c.execute("INSERT INTO blog_votes (post_id, username, vote) VALUES (?, ?, ?)", (post_id, u, vote))
            c.execute("UPDATE blog_posts SET score = score + ? WHERE id=?", (vote, post_id))
            new_vote = vote

        new_score = c.execute("SELECT score FROM blog_posts WHERE id=?", (post_id,)).fetchone()[0]

    return jsonify({"success": True, "score": new_score, "user_vote": new_vote})

@app.route("/api/blog_comments/<int:post_id>")
def get_blog_comments(post_id):
    u = get_u()
    with sqlite3.connect(DB_U) as c:
        rows = c.execute("""
            SELECT bc.id, bc.username, COALESCE(us.display_name, bc.username), us.avatar_url,
                   bc.content, bc.created_at
            FROM blog_comments bc
            LEFT JOIN users us ON us.username = bc.username
            WHERE bc.post_id = ?
            ORDER BY bc.id ASC
        """, (post_id,)).fetchall()

    out = []
    for cid, uname, dname, av, content, created_at in rows:
        out.append({
            "id": cid,
            "username": uname,
            "display_name": dname,
            "avatar_url": (av or "").strip() or DEFAULT_AVATAR,
            "content": content,
            "created_at": created_at,
            "is_owner": bool(u) and (u == uname),
        })
    return jsonify({"comments": out, "logged_in": bool(u)})

@app.route("/api/blog_comments/<int:post_id>", methods=["POST"])
def post_blog_comment(post_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in to comment."}), 401

    with sqlite3.connect(DB_U) as c:
        if not c.execute("SELECT 1 FROM blog_posts WHERE id=?", (post_id,)).fetchone():
            return jsonify({"success": False, "msg": "Post not found."}), 404

    data = request.json or {}
    content, err = moderate_comment(data.get("content", ""))
    if err:
        return jsonify({"success": False, "msg": err}), 400

    created_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with sqlite3.connect(DB_U) as c:
        cur = c.execute(
            "INSERT INTO blog_comments (post_id, username, content, created_at) VALUES (?, ?, ?, ?)",
            (post_id, u, content, created_at)
        )
        new_id = cur.lastrowid
        row = c.execute("SELECT COALESCE(display_name, username), avatar_url FROM users WHERE username=?", (u,)).fetchone()

    dname, av = row if row else (u, None)

    return jsonify({
        "success": True,
        "comment": {
            "id": new_id,
            "username": u,
            "display_name": dname,
            "avatar_url": (av or "").strip() or DEFAULT_AVATAR,
            "content": content,
            "created_at": created_at,
            "is_owner": True,
        }
    })

@app.route("/api/blog_comments/<int:comment_id>/delete", methods=["POST"])
def delete_blog_comment(comment_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in."}), 401

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT username FROM blog_comments WHERE id=?", (comment_id,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "Comment not found."}), 404
        if row[0] != u:
            return jsonify({"success": False, "msg": "You can only delete your own comments."}), 403
        c.execute("DELETE FROM blog_comments WHERE id=?", (comment_id,))

    return jsonify({"success": True})

@app.route("/api/blog/<int:post_id>/delete", methods=["POST"])
def delete_blog_post(post_id):
    u = get_u()
    if not u:
        return jsonify({"success": False, "msg": "Please log in."}), 401

    with sqlite3.connect(DB_U) as c:
        row = c.execute("SELECT username FROM blog_posts WHERE id=?", (post_id,)).fetchone()
        if not row:
            return jsonify({"success": False, "msg": "Post not found."}), 404
        if row[0] != u:
            return jsonify({"success": False, "msg": "You can only delete your own posts."}), 403

        c.execute("DELETE FROM blog_comments WHERE post_id=?", (post_id,))
        c.execute("DELETE FROM blog_votes WHERE post_id=?", (post_id,))
        c.execute("DELETE FROM blog_posts WHERE id=?", (post_id,))

    return jsonify({"success": True})

#=============================================================================#

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
    app.run(host="0.0.0.0", port=PORT, debug=True)
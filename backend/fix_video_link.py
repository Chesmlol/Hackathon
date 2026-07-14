"""One-off fix: lesson 29's video link is stored as 'Introduction.mp4'
instead of 'video/Introduction.mp4', so resolve_lesson_link() in main.py
resolves it to '/frontend/Introduction.mp4' — a path that doesn't exist,
since the file actually lives at frontend/video/Introduction.mp4. This
patches the stored link so the video loads correctly.

Run once from the backend/ directory:
    python3 fix_video_link.py
"""
import sqlite3
import os

DB_PATH = os.path.join(os.path.dirname(__file__), "users.db")

with sqlite3.connect(DB_PATH) as conn:
    rows = conn.execute(
        "SELECT id, title, link FROM lessons WHERE type='article' AND link != '' AND link NOT LIKE 'video/%' AND link NOT LIKE 'http%'"
    ).fetchall()

    if not rows:
        print("No broken video links found — nothing to do.")
    else:
        for lesson_id, title, link in rows:
            new_link = "video/" + link.lstrip("/")
            conn.execute("UPDATE lessons SET link=? WHERE id=?", (new_link, lesson_id))
            print(f"Fixed lesson {lesson_id} ({title!r}): '{link}' -> '{new_link}'")
        conn.commit()

import sqlite3
import os

DB_PATH = os.path.join(os.path.dirname(__file__), "users.db")

def add_lesson(title, description, link):
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("INSERT INTO lessons (title, description, link) VALUES (?, ?, ?)", 
                     (title, description, link))
        conn.commit()
        print(f"Added lesson: {title}")

if __name__ == "__main__":
    import sys
    if len(sys.argv) == 4:
        add_lesson(sys.argv[1], sys.argv[2], sys.argv[3])
    else:
        print("Usage: python add_lesson.py <Title> <Description> <Link>")
import sqlite3
import os

DB_USERS = os.path.join(os.path.dirname(__file__), "users.db")

def migrate():
    with sqlite3.connect(DB_USERS) as con:
        try:
            # This adds the column to your existing table
            con.execute("ALTER TABLE users ADD COLUMN xp INTEGER DEFAULT 0")
            print("Successfully added 'xp' column to users.db")
        except sqlite3.OperationalError as e:
            print(f"Migration failed (or column already exists): {e}")

if __name__ == "__main__":
    migrate()
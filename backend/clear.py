import sqlite3
import os

DB_USERS = os.path.join(os.path.dirname(__file__), "users.db")

# ── Legacy one-time migration ──
# Already applied to users.db (it has the xp column), kept here for
# reference / in case you ever restore an older DB snapshot without it.
def migrate():
    with sqlite3.connect(DB_USERS) as con:
        try:
            con.execute("ALTER TABLE users ADD COLUMN xp INTEGER DEFAULT 0")
            print("Successfully added 'xp' column to users.db")
        except sqlite3.OperationalError as e:
            print(f"Migration failed (or column already exists): {e}")


# ── Reset tool ──
# Wipes every non-admin user, all lessons, and all blog content, then
# cleans up anything that referenced a deleted user (their comments, votes,
# solved-problem records, comment reports, and submitted solutions) so
# nothing dangling is left behind. Admin accounts, and the problem set
# itself (initial_misions), are left untouched.
def clear_data():
    with sqlite3.connect(DB_USERS) as con:
        non_admin_users = [
            row[0] for row in con.execute(
                "SELECT username FROM users WHERE COALESCE(is_admin, 0) = 0"
            ).fetchall()
        ]

        if non_admin_users:
            qmarks = ",".join("?" * len(non_admin_users))
            params = non_admin_users

            # Problem-page comments this user wrote, votes they cast on any
            # comment, and reports they filed.
            con.execute(f"DELETE FROM comment_votes WHERE username IN ({qmarks})", params)
            con.execute(f"DELETE FROM comment_reports WHERE reporter_username IN ({qmarks})", params)
            con.execute(f"DELETE FROM comments WHERE username IN ({qmarks})", params)

            # Their solved-problem history.
            con.execute(f"DELETE FROM solved_problems WHERE username IN ({qmarks})", params)

            # Code solutions they submitted, and votes they cast on any solution.
            con.execute(f"DELETE FROM user_solution_votes WHERE username IN ({qmarks})", params)
            con.execute(f"DELETE FROM user_solutions WHERE username IN ({qmarks})", params)

            # The accounts themselves.
            con.execute(f"DELETE FROM users WHERE username IN ({qmarks})", params)

        # Blog content is wiped entirely, regardless of author.
        con.execute("DELETE FROM blog_comments")
        con.execute("DELETE FROM blog_votes")
        con.execute("DELETE FROM blog_posts")

        # Lessons are wiped entirely.
        con.execute("DELETE FROM lessons")

        con.commit()

    print(f"Done. Removed {len(non_admin_users)} non-admin user(s) (plus their "
          f"comments/votes/solved-problems/solutions), all lessons, and all "
          f"blog content. Admin account(s) and the problem set were left untouched.")


if __name__ == "__main__":
    print("This will permanently delete:")
    print("  - every user account that isn't an admin")
    print("  - all lessons")
    print("  - all blog posts, comments, and votes")
    print("Admin accounts and the problem set (initial_misions) will be kept.")
    confirm = input("Type 'yes' to continue: ").strip().lower()
    if confirm == "yes":
        clear_data()
    else:
        print("Aborted — no changes made.")

import sqlite3
import os

# This looks for users.db in the same directory where add.py is run
DB_PATH = os.path.join(os.path.dirname(__file__), "users.db")

def add_problem(id, title, xp, answer, statement):
    try:
        with sqlite3.connect(DB_PATH) as conn:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO initial_misions (id, title, xp, answer, statement) 
                VALUES (?, ?, ?, ?, ?)
            """, (id, title, xp, answer, statement))
            conn.commit()
            print(f"Successfully added mission: {id} - {title}")
    except sqlite3.Error as e:
        print(f"Database error: {e}")

if __name__ == "__main__":
    # Example usage: 
    # python add_prob.py "105" "Math Challenge" 100 "67" "<p>1 + 66 = ?</p>"
    import sys
    if len(sys.argv) == 6:
        add_problem(sys.argv[1], sys.argv[2], int(sys.argv[3]), sys.argv[4], sys.argv[5])
    else:
        print("Usage: python add.py <ID> <Title> <XP> <Answer> <Statement>")

            # --- FIELD BREAKDOWN ---
        # 1. ID:        A unique string (e.g., "105" or "CHD1A"). 
        #               This acts as the Primary Key.
        # 2. Title:     The display name shown on the problem page.
        # 3. XP:        Integer value (e.g., 100).
        # 4. Answer:    The exact string the submission must match.
        # 5. Statement: The HTML formatted description of your problem.
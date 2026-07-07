import sqlite3
import os
import sys

DB_PATH = os.path.join(os.path.dirname(__file__), "users.db")

VALID_TYPES = {"answer", "code"}

def add_problem(id, title, xp, answer, statement, prob_type="answer"):
    prob_type = prob_type.lower().strip()
    if prob_type not in VALID_TYPES:
        print(f"Error: type must be one of {sorted(VALID_TYPES)}, got '{prob_type}'")
        return

    try:
        with sqlite3.connect(DB_PATH) as conn:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO initial_misions (id, title, xp, answer, statement, type)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (id, title, xp, answer, statement, prob_type))
            conn.commit()
            print(f"Successfully added problem: {id} - {title} [{prob_type}]")
    except sqlite3.Error as e:
        print(f"Database error: {e}")

if __name__ == "__main__":
    # Usage: python add_prob.py <ID> <Title> <XP> <Answer> <Statement> [answer|code]
    #python add_prob.py "001" "math code thing" 100 "67" "<p>code pls</p>" code
    # Type defaults to 'answer' if omitted.
    if len(sys.argv) in (6, 7):
        ptype = sys.argv[6] if len(sys.argv) == 7 else "answer"
        add_problem(sys.argv[1], sys.argv[2], int(sys.argv[3]), sys.argv[4], sys.argv[5], ptype)
    else:
        print("Usage: python add_prob.py <ID> <Title> <XP> <Answer> <Statement> [answer|code]")
        print()
        print("Examples:")
        print('  python add_prob.py "105" "Capital of France" 50 "Paris" "<p>What is the capital of France?</p>" answer')
        print('  python add_prob.py "106" "FizzBuzz" 100 "fizzbuzz" "<p>Write FizzBuzz.</p>" code')
        print()
        print("Field breakdown:")
        print("  ID        Unique string (e.g. '105' or 'CHD1A'). Acts as Primary Key.")
        print("  Title     Display name shown on the problem page.")
        print("  XP        Integer reward value (e.g. 100).")
        print("  Answer    The exact string the submission must match.")
        print("  Statement HTML-formatted description of the problem.")
        print("  Type      'answer' (default) or 'code'. Omit to default to answer.")

import sqlite3
import os
import sys

DB_PATH = os.path.join(os.path.dirname(__file__), "users.db")

VALID_TYPES = ("video", "text")
VALID_DIFFICULTIES = ("easy", "medium", "hard")
EXPECTED_EXT = {"video": ".mp4", "text": ".pdf"}

def add_lesson(title, description, link, type_, difficulty):
    type_ = type_.strip().lower()
    difficulty = difficulty.strip().lower()

    if type_ not in VALID_TYPES:
        print(f"Invalid type '{type_}'. Must be one of: {', '.join(VALID_TYPES)}")
        return
    if difficulty not in VALID_DIFFICULTIES:
        print(f"Invalid difficulty '{difficulty}'. Must be one of: {', '.join(VALID_DIFFICULTIES)}")
        return

    expected_ext = EXPECTED_EXT[type_]
    if not link.lower().endswith(expected_ext):
        print(f"Warning: type '{type_}' usually links to a {expected_ext} file, "
              f"but the link given doesn't end with {expected_ext}. Adding it anyway.")

    with sqlite3.connect(DB_PATH) as conn:
        conn.execute(
            "INSERT INTO lessons (title, description, link, type, difficulty) VALUES (?, ?, ?, ?, ?)",
            (title, description, link, type_, difficulty)
        )
        conn.commit()
        print(f"Added lesson: {title} [{type_.upper()} / {difficulty.upper()}]")

if __name__ == "__main__":
    if len(sys.argv) == 6:
        add_lesson(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
    else:
        print("Usage: python add_lesson.py <Title> <Description> <Link> <Type: video|text> <Difficulty: easy|medium|hard>")
        print('Example: python add_lesson.py "Probability Basics" "Intro to probability" "/lessons/basics.pdf" text easy')
        print('Example: python add_lesson.py "Bayes Theorem Walkthrough" "Video derivation" "/lessons/bayes.mp4" video hard')

#python add_lesson.py "Test" "This is a fucking test." "lessons/test.mp4" video easy
#python add_lesson.py "Test2" "Hope ts works." "lessons/dragoon.pdf" text medium
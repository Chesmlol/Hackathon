# ChanceField — Translatable String Audit

> **Step 0 deliverable** — complete inventory of user-facing English strings with proposed i18n keys.  
> **Key convention:** `section.component.label` (e.g. `nav.home`, `api.login_required`).  
> **Generated:** 2026-07-13  
> **Problem DB note:** Live `sqlite3` query was unavailable in the audit environment; problem IDs/titles verified from `insert_practice_permutations.sql` (20 answer) + `insert_sage_problems.sql` (20 code) = **40 total**.

---

## Summary

| Category | Approx. keys | Primary source |
|---|---:|---|
| Navigation & shared UI | 25 | `main.py` `nav_html()`, `build_pagination()`, ban/warning modals |
| Page headers & `<title>` tags | 30 | HTML templates + `main.py` injected HTML |
| Home (`index.html`) | 15 | `index.html` |
| Auth (login/register) | 18 | `login.html`, `register.html`, API |
| Practice list | 22 | `practice.html`, `practice_page()` |
| Problem pages (answer + code) | 45 | `problem.html`, `problem_code.html`, `problem_page()` |
| Comments (shared UI) | 28 | HTML inline JS + API moderation |
| Solutions | 25 | `solution.html`, `user_solutions.html`, `main.py` |
| Account / profile | 30 | `account.html`, `render_profile_page()` |
| Ranking | 10 | `ranking.html`, `/ranking` route |
| Search | 6 | `search.html`, `build_search_results_html()` |
| Blog | 35 | `blog.html`, `blog_post.html`, blog routes |
| Admin | 22 | `admin_page_html()`, `build_admin_actions_html()` |
| API `msg` responses | 75+ | `main.py` (all `jsonify({"msg":...})`) |
| Client JS toasts/confirms | 40 | `script.js`, `blog.js`, inline `<script>` blocks |
| Rank display labels | 6 | `RANK_TIERS` + `ADMIN` |
| Time-ago relative strings | 8 | `time_ago()` |
| **Practice problem content** | **40 × 2** | `initial_misions.title` + `initial_misions.statement` |
| **EXCLUDED (do not translate)** | — | `/learn`, `/lesson/*`, `learn.html`, `lesson.html`, lesson DB |

---

## 1. Navigation (`nav_html()` — `main.py` ~495)

| Proposed key | English string | Location |
|---|---|---|
| `nav.home` | HOME | nav link |
| `nav.blog` | BLOG | nav link |
| `nav.learn` | LEARN | nav link (link label only; page content excluded) |
| `nav.practice` | PRACTICE | nav link |
| `nav.ranking` | RANKING | nav link |
| `nav.register` | REGISTER | nav (logged out) |
| `nav.login` | LOGIN | nav (logged out) |
| `nav.account` | ACCOUNT ({username}) | nav (logged in) — use `{username}` placeholder |
| `nav.admin` | ADMIN | nav (admin) |
| `nav.logout` | LOGOUT | nav (logged in) |
| `nav.search_label` | Search users | sr-only label |
| `nav.search_placeholder` | Find a user... | search input placeholder |
| `nav.search_button` | Search users | aria-label on submit button |
| `lang.switcher_label` | Language | aria-label for EN\|VI switcher (Step 11) |

---

## 2. Shared backend components

### 2.1 Pagination (`build_pagination()` — `main.py` ~600)

| Key | English |
|---|---|
| `pagination.prev` | « Prev |
| `pagination.next` | Next » |
| `pagination.page_info` | Page {current} of {total} |

### 2.2 Banned page (`banned_page_html()`)

| Key | English |
|---|---|
| `ban.title` | Account Banned - ChanceField |
| `ban.access_denied` | > ACCESS DENIED |
| `ban.heading` | ⛔ ACCOUNT BANNED |
| `ban.body` | The account **{username}** has been suspended by an administrator. |
| `ban.support` | You can no longer use this account. If you believe this is a mistake, please contact support. |
| `ban.logout` | Log Out |

### 2.3 Warning popup (`build_warning_popup_html()`)

| Key | English |
|---|---|
| `warning.title` | ADMIN WARNING |
| `warning.acknowledge` | I UNDERSTAND |

### 2.4 Type labels (`TYPE_LABELS`, problem display)

| Key | English |
|---|---|
| `problem.type.answer` | ANSWER |
| `problem.type.code` | CODE |
| `problem.type.answer_display` | 📝 ANSWER |
| `problem.type.code_display` | 💻 CODE |

### 2.5 Rank display labels (`RANK_TIERS` — translate UI label only, not DB value)

| Key | English |
|---|---|
| `rank.noob` | NOOB |
| `rank.intermediate` | INTERMEDIATE |
| `rank.pro` | PRO |
| `rank.hacker` | HACKER |
| `rank.god` | GOD |
| `rank.admin` | ADMIN |

### 2.6 Time ago (`time_ago()`)

| Key | English |
|---|---|
| `time.just_now` | just now |
| `time.minutes_ago` | {n} minute(s) ago |
| `time.hours_ago` | {n} hour(s) ago |
| `time.days_ago` | {n} day(s) ago |
| `time.months_ago` | {n} month(s) ago |
| `time.years_ago` | {n} year(s) ago |

---

## 3. Home page (`index.html`)

| Key | English |
|---|---|
| `home.title` | ChanceField |
| `home.tagline` | > PROBABILITIES! |
| `home.about_heading` | ABOUT US |
| `home.carousel_label` | About ChanceField |
| `home.carousel_slide` | {n} of 4 |
| `home.carousel_prev` | Previous image |
| `home.carousel_next` | Next image |
| `home.carousel_dot` | Show image {n} of {total} |
| `home.about_desc` | ChanceField is a training ground for probability, combinatorics, and statistical thinking. Work through bite-sized lessons, tackle archived problems on the judge, and climb the leaderboard as you sharpen your intuition for chance — one roll, flip, and draw at a time. |
| `home.footer_quote` | > "never gonna give you up" - Rick Astley |
| `ranking_snippet.heading` | TOP USERS |
| `ranking_snippet.user_col` | User |
| `ranking_snippet.xp_col` | XP |
| `ranking_snippet.xp_value` | {xp} XP |

*Carousel SVG labels (rolled: 5, fair coin flip, Normal Distribution, etc.) are decorative/math — optional to translate in Step 9; keep math tokens unchanged.*

---

## 4. Auth pages

### 4.1 Login (`frontend/login.html`)

| Key | English |
|---|---|
| `auth.login.title` | Login - RetroCode Academy |
| `auth.login.tagline` | > AUTHENTICATION REQUIRED |
| `auth.login.heading` | LOGIN |
| `auth.login.username_label` | Username |
| `auth.login.username_placeholder` | Username |
| `auth.login.password_label` | Password |
| `auth.login.password_placeholder` | Password |
| `auth.login.submit` | LOGIN |
| `auth.login.back_home` | ← Back Home |
| `auth.login.missing_fields` | Please enter both username and password. |
| `auth.login.success` | Login successful! |
| `auth.login.invalid_credentials` | Invalid credentials. |
| `auth.login.server_error` | Could not connect to the authentication server. |

### 4.2 Register (`frontend/register.html`)

| Key | English |
|---|---|
| `auth.register.title` | Register - RetroCode Academy |
| `auth.register.tagline` | > NEW AGENT REGISTRATION |
| `auth.register.heading` | REGISTER |
| `auth.register.username_placeholder` | Username |
| `auth.register.email_placeholder` | Email |
| `auth.register.password_placeholder` | Password |
| `auth.register.confirm_placeholder` | Confirm Password |
| `auth.register.submit` | REGISTER |

---

## 5. Practice list (`practice.html` + `practice_page()`)

| Key | English |
|---|---|
| `practice.title` | Practice Archives |
| `practice.tagline` | > PROBLEM ARCHIVES |
| `practice.page_heading` | Problem Archives |
| `practice.search_label` | Search problems by title |
| `practice.search_placeholder` | Search problems by title... |
| `practice.search_submit` | Search |
| `practice.clear_search` | Clear |
| `practice.col_id` | ID |
| `practice.col_title` | Title |
| `practice.col_type` | Type |
| `practice.col_solved_by` | Solved By |
| `practice.sidebar_type` | TYPE |
| `practice.sidebar_sort` | SORT BY |
| `practice.filter_all` | ALL |
| `practice.sort_default` | DEFAULT |
| `practice.sort_title` | TITLE A-Z |
| `practice.sort_solved` | MOST SOLVED |
| `practice.no_results` | No problems found. |
| `practice.no_available` | No problems available yet. |
| `practice.results_range` | Showing {start}-{end} of {total} problem(s) |
| `practice.results_matching` | matching "{q}" |
| `practice.results_type_suffix` | {type} type |
| `practice.menu_more_actions` | More actions |
| `practice.menu_official_solution` | View Official Solution |
| `practice.menu_user_solutions` | View User Solutions ({count}) |
| `practice.menu_not_available` | Not available for answer-type problems |
| `practice.menu_not_available_title` | Not available for answer-type problems |

---

## 6. Problem pages (`problem.html`, `problem_code.html`, `problem_page()`)

| Key | English |
|---|---|
| `problem.tagline` | > MISSION BRIEFING |
| `problem.info_heading` | Problem Info |
| `problem.score_label` | ★ Score: |
| `problem.type_label` | ⊞ Type: |
| `problem.status_heading` | Status |
| `problem.status_solved` | ✅ Solved |
| `problem.status_unsolved` | ❌ Not Solved |
| `problem.back_to_archive` | ← Back to Archive |
| `problem.your_answer` | Your Answer |
| `problem.answer_placeholder` | Answer... |
| `problem.answer_sr_label` | Your answer for this problem |
| `problem.submit_answer` | Submit A Solution! |
| `problem.your_solution` | Your Solution |
| `problem.judge_lang_badge` | ⌁ SageMath |
| `problem.judge_hint` | Write your solution in SageMath, then Run & Submit to judge it. |
| `problem.reset_template` | Reset Template |
| `problem.run_submit` | ▶ Run & Submit |
| `problem.judging` | Judging… |
| `problem.judging_status` | Compiling and running your code… |
| `problem.user_info_heading` | User information |
| `problem.profile_link` | Profile |
| `problem.logout_link` | Logout |
| `problem.guest_name` | Guest |
| `problem.reset_confirm` | Reset to the starter template? This will erase your current code. |
| `problem.verdict.accepted` | ✅ Accepted — 100/100 |
| `problem.verdict.partial` | 🟡 Partial Credit |
| `problem.verdict.partial_score` | 🟡 Partial Credit — {score}/100 |
| `problem.verdict.wrong_answer` | ❌ Wrong Answer — 0/100 |
| `problem.verdict.compile_error` | ⚠ Compile Error |
| `problem.verdict.runtime_error` | ⚠ Runtime Error |
| `problem.verdict.time_limit` | ⏱ Time Limit Exceeded |
| `problem.stderr_label` | stderr |
| `problem.stdout_label` | stdout |
| `problem.judge_error` | Judge error. |
| `problem.judge_run_error` | Error running your code. |

*Problem `title` and `statement` come from DB / `problems_{en,vi}.json` — see Section 15.*

---

## 7. Comments UI (shared across problem + blog pages)

| Key | English |
|---|---|
| `comments.heading` | Comments |
| `comments.guidelines` | Community Guidelines: Be respectful — no harassment, hate speech, or spam. Don't post personal information (emails, phone numbers, or anyone's real contact details). Comments that break these rules are rejected automatically or removed. 500 characters max. |
| `comments.loading` | Loading comments… |
| `comments.login_prompt` | Log in to join the discussion. |
| `comments.login_link` | Log In |
| `comments.write_label` | Write a comment |
| `comments.placeholder_problem` | Share a hint, ask a question, or discuss this problem... |
| `comments.placeholder_blog` | Share your thoughts... |
| `comments.post_button` | Post Comment |
| `comments.counter` | {current} / {max} |
| `comments.empty` | No comments yet — be the first to share a thought! |
| `comments.load_error` | Could not load comments. |
| `comments.empty_post` | Write something before posting. |
| `comments.posted` | Comment posted! |
| `comments.post_error` | Could not post comment. |
| `comments.posting_error` | Error posting comment. |
| `comments.upvote_aria` | Upvote comment |
| `comments.downvote_aria` | Downvote comment |
| `comments.delete` | Delete |
| `comments.delete_confirm` | Delete this comment? |
| `comments.report` | Report |
| `comments.reported` | Reported |
| `comments.report_prompt` | Why are you reporting this comment? (optional) |
| `comments.report_success` | Reported. |
| `comments.report_error` | Could not report comment. |
| `comments.reporting_error` | Error reporting comment. |
| `comments.delete_error` | Could not delete comment. |
| `comments.deleting_error` | Error deleting comment. |
| `comments.vote_error` | Error casting vote. |

---

## 8. Solutions pages

### 8.1 Official solution (`solution.html` + `solution_page_content()`)

| Key | English |
|---|---|
| `solution.tagline` | > OFFICIAL SOLUTION |
| `solution.page_title_suffix` | - Official Solution |
| `solution.back_to_problem` | ← Back to Problem |
| `solution.edit_button` | ✎ Edit Solution |
| `solution.add_button` | + Add Solution |
| `solution.no_solution` | No official solution has been added yet. |
| `solution.edit_modal_title` | Edit Official Solution |
| `solution.lang_note` | Language: **⌁ SageMath** (the only language this judge supports) |
| `solution.content_label` | Solution: |
| `solution.save` | Save |
| `solution.cancel` | Cancel |
| `solution.save_error` | Error saving solution. |

### 8.2 User solutions (`user_solutions.html` + route)

| Key | English |
|---|---|
| `usersolutions.tagline` | > USER SOLUTIONS |
| `usersolutions.page_title` | User Solutions - {title} |
| `usersolutions.heading` | User Solutions for {title} |
| `usersolutions.intro` | Below are user-submitted solutions for this problem. Solutions are shown only if their author chose to share them publicly. |
| `usersolutions.my_section` | My Solutions |
| `usersolutions.public_section` | Public {lang} Solutions ({count}) |
| `usersolutions.no_mine` | No solutions yet! |
| `usersolutions.login_submit` | Log in to submit and track your own solutions. |
| `usersolutions.login_link` | Log In |
| `usersolutions.login_submit_short` | Log in to submit a solution. |
| `usersolutions.submit_button` | Submit a Solution |
| `usersolutions.submit_modal_title` | Submit Solution |
| `usersolutions.submit_intro` | Help others out by sharing a solution. Please make sure it passes all test cases. |
| `usersolutions.code_placeholder` | Paste your solution code here... |
| `usersolutions.share_label` | Share Solution Code |
| `usersolutions.share_hint` | This will allow other users to view your solution code if they are stuck. |
| `usersolutions.submit` | Submit Solution |
| `usersolutions.submit_error` | Error submitting solution. |
| `usersolutions.votes_label` | Votes: |
| `usersolutions.upvote` | (Upvote) |
| `usersolutions.upvoted` | (Upvoted) |
| `usersolutions.copy` | Copy |
| `usersolutions.copied` | Copied! |
| `usersolutions.private_badge` | (private) |
| `usersolutions.vote_error` | Could not vote. |
| `usersolutions.voting_error` | Error voting. |

---

## 9. Account / profile (`account.html`, `render_profile_page()`)

| Key | English |
|---|---|
| `account.title` | Account |
| `account.tagline` | > USER PROFILE LOADED |
| `account.heading` | ACCOUNT |
| `account.handle` | Handle: |
| `account.rank` | Rank: |
| `account.level` | Level: |
| `account.total_xp` | Total XP: |
| `account.solved` | Solved: |
| `account.progress_overall` | Overall Progress |
| `account.progress_answer` | 📝 Answer Problems |
| `account.progress_code` | 💻 Code Problems |
| `account.progress_fraction` | {solved} / {total} ({pct}%) |
| `account.settings_button` | Settings |
| `account.settings_title` | SETTINGS |
| `account.avatar_label` | Avatar URL (Image Link): |
| `account.avatar_placeholder` | https://image-link.png |
| `account.display_name_label` | Change Display Name: |
| `account.display_name_placeholder` | New Display Name |
| `account.password_section` | Change Password: |
| `account.old_password_placeholder` | Old Password (required) |
| `account.new_password_placeholder` | New Password |
| `account.save_changes` | Save Changes |
| `account.cancel` | Cancel |
| `account.tab_submissions` | SUBMISSIONS |
| `account.tab_blog` | BLOG |
| `account.solved_heading` | SOLVED PROBLEMS |
| `account.col_id` | ID |
| `account.col_title` | Title |
| `account.col_xp` | XP |
| `account.not_found` | 404 User not found |
| `admin.banned_badge` | ⛔ THIS ACCOUNT IS CURRENTLY BANNED |
| `admin.pending_warning` | ⏳ Unacknowledged warning pending: |
| `admin.clear_warning` | Clear Warning |
| `admin.warn_user` | ⚠ Warn User |
| `admin.ban_user` | Ban User |
| `admin.unban_user` | Unban User |
| `admin.warn_modal_title` | ⚠ Send Warning to {username} |
| `admin.warn_label` | Warning message (shown as a popup on their next page load): |
| `admin.warn_placeholder` | Type the warning message this user will see... |
| `admin.send_warning` | Send Warning |
| `admin.warn_empty` | Please type a warning message. |
| `admin.warn_send_error` | Error sending warning. |
| `admin.warn_clear_error` | Error clearing warning. |
| `admin.ban_confirm_ban` | Ban this user? Their account will become unusable until unbanned. |
| `admin.ban_confirm_unban` | Unban this user? |
| `admin.ban_error` | Error updating ban status. |

---

## 10. Ranking (`ranking.html`, `/ranking`)

| Key | English |
|---|---|
| `ranking.title` | Global Leaderboard |
| `ranking.tagline` | > GLOBAL RANKINGS |
| `ranking.col_rank` | # |
| `ranking.col_user` | User |
| `ranking.col_rank_name` | Rank |
| `ranking.col_level` | Level |
| `ranking.col_xp` | XP |
| `ranking.col_solved` | Solved |
| `ranking.no_users` | No users found. |

---

## 11. Search (`search.html`, `build_search_results_html()`)

| Key | English |
|---|---|
| `search.title` | Search Users |
| `search.tagline` | > USER SEARCH |
| `search.heading` | SEARCH RESULTS |
| `search.label` | Search users |
| `search.placeholder` | Search by username or display name... |
| `search.submit` | Search |
| `search.empty_prompt` | Type a username or display name to search. |
| `search.no_results` | No users found matching "{q}". |

---

## 12. Blog (`blog.html`, `blog_post.html`, blog routes)

| Key | English |
|---|---|
| `blog.feed_title` | ChanceField - Blog |
| `blog.tagline` | > COMMUNITY BLOG |
| `blog.heading` | BLOG |
| `blog.post_tagline` | > BLOG POST |
| `blog.guidelines` | Posting Guidelines: Be respectful — no harassment, hate speech, or spam. Don't post personal information (emails, phone numbers, or anyone's real contact details). Title max {title_max} characters, description max {desc_max} characters, full post max {content_max} characters. Posts that break these rules are rejected automatically. |
| `blog.new_post` | + New Post |
| `blog.login_to_post` | Log in to write a post. |
| `blog.no_posts_feed` | No posts yet — be the first to share something! |
| `blog.no_posts_user` | No blog posts yet. |
| `blog.view_full` | View Full & Comments → |
| `blog.back_to_blog` | ← Back to Blog |
| `blog.delete_post` | Delete Post |
| `blog.delete_confirm` | Delete this post? This cannot be undone. |
| `blog.deleted` | Post deleted. |
| `blog.delete_error` | Could not delete post. |
| `blog.deleting_error` | Error deleting post. |
| `blog.upvote_aria` | Upvote post |
| `blog.downvote_aria` | Downvote post |
| `blog.compose_title` | NEW BLOG POST |
| `blog.compose_title_label` | Title: |
| `blog.compose_title_placeholder` | A short, descriptive title |
| `blog.compose_desc_label` | Description (short summary shown in listings): |
| `blog.compose_desc_placeholder` | One or two sentences... |
| `blog.compose_content_label` | Full post: |
| `blog.compose_content_placeholder` | Write your full post here... |
| `blog.compose_post` | Post |
| `blog.compose_cancel` | Cancel |
| `blog.posting_error` | Error posting. |
| `blog.not_found` | 404 Post not found |

---

## 13. Admin panel (`admin_page_html()`)

| Key | English |
|---|---|
| `admin.panel_title` | Admin Panel |
| `admin.panel_tagline` | > ADMIN CONTROL PANEL |
| `admin.reports_heading` | REPORTED COMMENTS |
| `admin.reports_intro` | Comments flagged by users appear here for review. Dismiss clears the flag and keeps the comment; Delete removes it permanently. |
| `admin.reports_loading` | Loading reports… |
| `admin.reports_empty` | No pending reports — all clear! |
| `admin.reports_load_error` | Could not load reports. |
| `admin.view_problem` | View problem → |
| `admin.reported_times` | ⚠ Reported {count} time(s) |
| `admin.dismiss` | Dismiss |
| `admin.delete_comment` | Delete Comment |
| `admin.delete_comment_confirm` | Permanently delete this comment? |
| `admin.comment_deleted` | Comment deleted. |
| `admin.report_dismissed` | Report dismissed. |
| `admin.action_failed` | Action failed. |
| `admin.action_error` | Error processing action. |

---

## 14. API response messages (`main.py` — all `msg` fields)

### Auth & account

| Key | English |
|---|---|
| `api.account_banned` | Your account has been banned. |
| `api.login_required` | Login required. |
| `api.login_required_dot` | Login required. |
| `api.register_username_password_required` | Username and password are required. |
| `api.register_passwords_mismatch` | Passwords do not match. |
| `api.register_username_length` | Username must be 5-20 characters long. |
| `api.register_username_invalid` | Invalid username (letters, numbers, underscores only). |
| `api.register_password_short` | Password too short (min 6 characters). |
| `api.register_success` | Registered successfully! |
| `api.register_username_exists` | Username already exists. |
| `api.profile_wrong_password` | Incorrect old password. |
| `api.profile_updated` | Profile updated successfully! |

### Answer submission

| Key | English |
|---|---|
| `api.submit_missing_fields` | Missing problem id or answer. |
| `api.problem_not_found` | Problem not found. |
| `api.submit_requires_code` | This problem requires a code submission — use the code editor instead. |
| `api.incorrect_answer` | Incorrect answer. |
| `api.already_solved` | Problem already solved! |
| `api.correct_xp` | Correct! +{xp} XP earned. |

### Code judge

| Key | English |
|---|---|
| `api.judge_missing_id` | Missing problem id. |
| `api.judge_unsupported_language` | Unsupported language. |
| `api.judge_empty_code` | Please write some code before submitting. |
| `api.judge_code_too_long` | Code is limited to {max} characters. |
| `api.judge_no_code_submissions` | This problem doesn't accept code submissions. |
| `api.judge_internal_error` | Internal judge error. |
| `api.judge_compile_error` | Compile Error. |
| `api.judge_runtime_error` | Runtime Error. |
| `api.judge_time_limit` | Time Limit Exceeded ({seconds}s). |
| `api.judge_wrong_answer_score` | Wrong Answer — 0/100. |
| `api.judge_wrong_answer` | Wrong Answer. |
| `api.judge_accepted_no_xp` | Accepted! (already solved — no extra XP) |
| `api.judge_accepted_xp` | Accepted! +{xp} XP earned. |
| `api.judge_accepted_all_tests` | Accepted! All 5 testcases passed. |
| `api.judge_partial_no_xp` | Partial credit: {score}/100. |
| `api.judge_partial_xp` | Partial credit: {score}/100 (+{xp} XP). |

### Solutions

| Key | English |
|---|---|
| `api.admin_required` | Admin access required. |
| `api.invalid_language` | Invalid language. |
| `api.solution_too_long` | Solution is limited to {max} characters. |
| `api.solutions_code_only` | Solutions are only available for code-type problems. |
| `api.official_solution_saved` | Official solution saved. |
| `api.login_to_submit_solution` | Please log in to submit a solution. |
| `api.solution_empty` | Solution code can't be empty. |
| `api.solution_submitted` | Solution submitted! |
| `api.solution_not_found` | Solution not found. |
| `api.cant_vote_own_solution` | You can't vote on your own solution. |

### Comments

| Key | English |
|---|---|
| `api.login_to_comment` | Please log in to comment. |
| `api.login_to_vote` | Please log in to vote. |
| `api.invalid_vote` | Invalid vote. |
| `api.comment_not_found` | Comment not found. |
| `api.login_generic` | Please log in. |
| `api.delete_own_comments_only` | You can only delete your own comments. |
| `api.login_to_report` | Please log in to report a comment. |
| `api.cant_report_own` | You can't report your own comment. |
| `api.already_reported` | You've already reported this comment. |
| `api.report_thanks` | Thanks — this comment has been reported for review. |
| `api.comment_empty` | Comment can't be empty. |
| `api.comment_too_long` | Comments are limited to {max} characters. |
| `api.comment_profanity` | Please keep comments respectful — that language isn't allowed here. |
| `api.comment_no_email` | For your privacy and safety, please don't post email addresses. |
| `api.comment_no_phone` | For your privacy and safety, please don't post phone numbers. |

### Admin

| Key | English |
|---|---|
| `api.invalid_action` | Invalid action. |
| `api.user_not_found` | User not found. |
| `api.admin_cant_ban` | Admin accounts can't be banned. |
| `api.user_banned` | {username} has been banned. |
| `api.user_unbanned` | {username} has been unbanned. |
| `api.warning_empty` | Warning message can't be empty. |
| `api.warning_too_long` | Warning message is limited to 1000 characters. |
| `api.admin_cant_warn` | Admin accounts can't be warned. |
| `api.warning_sent` | Warning sent to {username} — they'll see it on their next page load. |
| `api.warning_cleared` | Warning cleared. |
| `api.invalid_secret` | Invalid secret. |
| `api.promoted_admin` | {target} is now an admin. |

### Blog

| Key | English |
|---|---|
| `api.login_to_post` | Please log in to post. |
| `api.post_published` | Post published! |
| `api.post_not_found` | Post not found. |
| `api.delete_own_posts_only` | You can only delete your own posts. |
| `api.blog_field_empty` | {field} can't be empty. |
| `api.blog_field_too_long` | {field} is limited to {max} characters. |
| `api.blog_profanity` | Please keep posts respectful — that language isn't allowed here. |
| `api.blog_no_email` | For your privacy and safety, please don't post email addresses. |
| `api.blog_no_phone` | For your privacy and safety, please don't post phone numbers. |

---

## 15. Practice problems (`initial_misions` — 40 IDs)

> Stored in `problems_en.json` / `problems_vi.json` as `{id: {title, statement}}`.  
> Vietnamese source: owner docx files (Section 4 of instructions).

### Answer set (20) — `insert_practice_permutations.sql`

| DB id | English title (key: `problems.{id}.title`) |
|---|---|
| `perm_cat` | Permutations of "CAT" |
| `perm_book` | Permutations of "BOOK" |
| `comb_committee_3of10` | Choosing a Committee of 3 |
| `binom_coeff_x3_xy7` | Coefficient of x³ in (x + y)⁷ |
| `stars_bars_nonneg_5` | Non-negative Solutions to x₁+x₂+x₃=5 |
| `pigeonhole_birth_month` | Birth Month Pigeonhole |
| `arrange_4_books` | Arranging 4 Distinct Books |
| `binom_coeff_x2y4_xy6` | Coefficient of x²y⁴ in (x + y)⁶ |
| `balls_boxes_no_empty` | Balls into Boxes (No Box Empty) |
| `coin_flips_6_heads` | Coin Flips with Exactly 6 Heads |
| `sum_binom_coeff_n5` | Sum of Binomial Coefficients (n = 5) |
| `positive_int_solutions_4var` | Positive Integer Solutions (4 Variables) |
| `perm_mississippi` | Permutations of "MISSISSIPPI" |
| `binom_coeff_x4_1x10` | Coefficient of x⁴ in (1 + x)¹⁰ |
| `pigeonhole_mod7` | Pigeonhole: Same Remainder mod 7 |
| `candies_min_one_each` | Distributing Candies with a Minimum Each |
| `functions_4_objects_2_boxes` | Functions from 4 Objects to 2 Boxes |
| `sum_coeff_2x_3y_5` | Sum of Coefficients in (2x − 3y)⁵ |
| `committee_2men_2women` | Committee with Exactly 2 Men and 2 Women |
| `prove_symmetry_identity` | Proving C(n,k) = C(n, n−k) |

### Code/Sage set (20) — `insert_sage_problems.sql`

| DB id | English title |
|---|---|
| `sage_multiset_no_adj` | Multiset Permutations, No Equal Letters Adjacent |
| `sage_circular_arrangements` | Circular Arrangements (up to Rotation) |
| `sage_circular_not_adjacent` | Circular Arrangements with a Forbidden Adjacency |
| `sage_multinomial_coeff` | Multinomial Coefficient from an Expansion |
| `sage_bounded_stars_bars` | Bounded Stars and Bars |
| `sage_surjections` | Counting Surjections |
| `sage_set_partitions_k_blocks` | Set Partitions into Exactly k Blocks |
| `sage_bell_number` | Bell Numbers |
| `sage_gaussian_binomial` | Gaussian Binomial Coefficients |
| `sage_derangements_r_fixed` | Permutations with Exactly r Fixed Points |
| `sage_poisson_binomial` | Poisson-Binomial: Exact Probability of k Successes |
| `sage_forced_nonempty_boxes` | Onto Functions with Forced Nonempty Boxes |
| `sage_mixed_gen_func_coeff` | Coefficient from a Mixed Generating Function |
| `sage_ordered_bell` | Ordered Bell (Fubini) Numbers |
| `sage_exactly_r_distinct` | Exactly r Distinct Values Among n Draws |
| `sage_restricted_compositions` | Restricted Compositions via Generating Functions |
| `sage_perms_c_cycles` | Permutations with a Given Number of Cycles |
| `sage_binomial_tail` | Binomial Tail Probability (Symbolic) |
| `sage_binary_necklaces` | Binary Necklaces (Burnside's Lemma) |
| `sage_necklaces_k_black` | Binary Necklaces with a Fixed Number of Black Beads |

Each id also has `problems.{id}.statement` (HTML + LaTeX from SQL seeds / docx for VI).

**Do NOT translate:** `answer`, `test_input`, `starter_code`, `judge_harness`, `official_solution`, function names, `<code>` test I/O values.

---

## 16. Client-side JS (`script.js`, `blog.js`, inline scripts)

| Key | English | File |
|---|---|---|
| `js.submit_answer_error` | Error submitting your answer. | `script.js` |
| `js.vote_error` | Error casting vote. | `blog.js` |
| `js.login_to_vote` | Please log in to vote. | `blog.js` (fallback) |
| `js.delete_post_confirm` | Delete this post? This cannot be undone. | `blog.js` |
| `js.post_deleted` | Post deleted. | `blog.js` |
| `js.delete_post_error` | Could not delete post. | `blog.js` |
| `js.delete_posting_error` | Error deleting post. | `blog.js` |

*Most other JS strings duplicate keys already listed under Comments, Problem, Blog, Admin sections — wire via `window.CF_STRINGS` in Step 10.*

---

## 17. EXCLUDED — Do NOT translate

Per project scope (`AI_TRANSLATION_INSTRUCTIONS.md` Section 3):

| Area | Files / routes | Notes |
|---|---|---|
| Learn listing | `/learn`, `learn_page()`, `frontend/learn.html` | Entire page untouched |
| Lesson viewer | `/lesson/<id>`, `lesson_page()`, `frontend/lesson.html` | Entire page untouched |
| Lesson DB | `lessons.title`, `lessons.description`, `lessons.content` | Content stays as-is |
| Lesson SQL seeds | `insert_lessons_*.sql` | Do not modify |
| Nav on learn routes | Optional: keep English nav text even when `lang=vi` | Switcher may appear |

**Representative learn/lesson strings (catalogued for verification only — NOT in `en.json`):**

- `> LEARNING HUB`, lesson search placeholder, difficulty filters, "Start Lesson", pagination, lesson article HTML, video/PDF fallback messages in `lesson_page()`.

---

## 18. Brand / keep untranslated

- **ChanceField** (brand name everywhere)
- **XP** (unit label)
- Problem IDs, usernames, URLs, code snippets
- Math inside `\(...\)`, `\[...\]`, and test I/O in `<code>` blocks
- **SageMath** (product name — may keep or localize label context only)
- Footer Rick Astley quote (optional — currently English pop-culture reference)

---

## 19. File → key mapping (implementation reference)

| File | Step | Primary key prefixes |
|---|---|---|
| `backend/main.py` | 3–8 | `nav.*`, `api.*`, `ban.*`, `warning.*`, `pagination.*`, `admin.*`, `blog.*`, `rank.*`, `time.*` |
| `index.html` | 9 | `home.*`, `ranking_snippet.*` |
| `frontend/login.html`, `register.html` | 9 | `auth.*` |
| `frontend/practice.html` | 5 | `practice.*` |
| `frontend/problem.html`, `problem_code.html` | 5–6 | `problem.*`, `comments.*` |
| `frontend/solution.html`, `user_solutions.html` | 6 | `solution.*`, `usersolutions.*` |
| `frontend/account.html` | 7 | `account.*`, `admin.*` (profile actions) |
| `frontend/ranking.html` | 7 | `ranking.*` |
| `frontend/search.html` | 7 | `search.*` |
| `frontend/blog.html`, `blog_post.html` | 7 | `blog.*`, `comments.*` |
| `frontend/script.js`, `blog.js` | 10 | `js.*` + shared keys |
| `backend/i18n/problems_*.json` | 2, 5 | `problems.{id}.{title\|statement}` |

---

*End of audit. Next step: Step 1 — create `backend/i18n/` layout and populate key schema in `en.json`.*

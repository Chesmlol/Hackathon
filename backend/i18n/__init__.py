"""ChanceField i18n helpers.

Key naming convention: section.component.label (e.g. nav.home, api.login_required).

Translation files:
  - en.json / vi.json          — UI strings
  - problems_en.json / problems_vi.json — problem title + statement by id

Implemented in Step 3: get_lang(), t(), t_problem(), is_learning_route()
"""

import os
import json
from flask import request, make_response, has_request_context

SUPPORTED_LANGS = {"en", "vi"}
DEFAULT_LANG = "en"

# Load translation files
_DIR = os.path.dirname(__file__)

def _load_json(filename):
    path = os.path.join(_DIR, filename)
    with open(path, 'r', encoding='utf-8') as f:
        return json.load(f)

_ui_strings = {
    "en": _load_json("en.json"),
    "vi": _load_json("vi.json")
}

_problems = {
    "en": _load_json("problems_en.json"),
    "vi": _load_json("problems_vi.json")
}


def get_lang():
    """Read lang from cookie or ?lang= query param. Fallback to 'en'."""
    # If called outside request context, return default
    if not has_request_context():
        return DEFAULT_LANG
    
    # Check query param first (for initial visit)
    lang_param = request.args.get('lang', '').lower()
    if lang_param in SUPPORTED_LANGS:
        return lang_param
    
    # Check cookie
    lang_cookie = request.cookies.get('lang', '').lower()
    if lang_cookie in SUPPORTED_LANGS:
        return lang_cookie
    
    return DEFAULT_LANG


def t(key: str, **kwargs) -> str:
    """Look up a UI string key in en.json / vi.json. Supports {placeholder} format."""
    lang = get_lang()
    strings = _ui_strings.get(lang, _ui_strings[DEFAULT_LANG])
    
    # Get the string value
    value = strings.get(key, key)  # Fallback to key if not found
    
    # Interpolate placeholders
    if kwargs:
        try:
            return value.format(**kwargs)
        except (KeyError, ValueError):
            # If formatting fails, return original value
            return value
    
    return value


def t_problem(problem_id: str, field: str) -> str | None:
    """Return translated title/statement for a problem, or None to fall back to DB value."""
    lang = get_lang()
    problems = _problems.get(lang, _problems[DEFAULT_LANG])
    
    problem_data = problems.get(problem_id)
    if problem_data and field in problem_data:
        return problem_data[field]
    
    return None


def is_learning_route(path: str) -> bool:
    """Return True for /learn and /lesson/<id> — skip translation on these routes."""
    return path.startswith('/learn') or path.startswith('/lesson')


def get_cf_strings_script() -> str:
    """Generate script tag to inject CF_STRINGS for client-side i18n."""
    lang = get_lang()
    strings = _ui_strings.get(lang, _ui_strings[DEFAULT_LANG])
    # Remove _meta key from client-side strings
    strings_for_client = {k: v for k, v in strings.items() if not k.startswith('_')}
    strings_json = json.dumps(strings_for_client, ensure_ascii=False)
    return f'<script>window.CF_STRINGS = {strings_json};</script>'

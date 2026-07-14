/**
 * ChanceField client-side i18n helper.
 * 
 * Usage:
 *   - CF_STRINGS is injected by server (or loaded from /api/i18n/strings)
 *   - CF_LANG is set from document.documentElement.lang or defaults to 'en'
 *   - Call t('key', {var: value}) for translation with interpolation
 * 
 * Key naming convention: section.component.label (e.g. nav.home, api.login_required)
 */

window.CF_LANG = document.documentElement.lang || 'en';
window.CF_STRINGS = window.CF_STRINGS || {};

/**
 * Translate a key with optional variable interpolation.
 * @param {string} key - Translation key (e.g. 'nav.home')
 * @param {Object} vars - Optional variables for interpolation (e.g. {username: 'john'})
 * @returns {string} Translated string or the key if not found
 */
function t(key, vars = {}) {
  const str = window.CF_STRINGS[key];
  if (!str) {
    console.warn(`[i18n] Missing translation for key: ${key}`);
    return key;
  }
  
  // Interpolate variables: {username} -> vars.username
  let result = str;
  for (const [name, value] of Object.entries(vars)) {
    result = result.replace(new RegExp(`\\{${name}\\}`, 'g'), value);
  }
  
  return result;
}

/**
 * Set the current language and reload the page.
 * @param {string} lang - Language code ('en' or 'vi')
 */
function setLanguage(lang) {
  if (!['en', 'vi'].includes(lang)) {
    console.error(`[i18n] Invalid language: ${lang}`);
    return;
  }
  
  fetch('/api/set_language', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ lang }),
  })
    .then(response => {
      if (response.ok) {
        location.reload();
      } else {
        console.error('[i18n] Failed to set language');
      }
    })
    .catch(error => {
      console.error('[i18n] Error setting language:', error);
    });
}

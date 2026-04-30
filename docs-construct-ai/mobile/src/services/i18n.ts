import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import * as RNFS from 'expo-file-system';

// Supported languages as per procedure
export const SUPPORTED_LANGUAGES = [
  { code: 'en', name: 'English', rtl: false },
  { code: 'ar', name: 'العربية', rtl: true },
  { code: 'pt', name: 'Português', rtl: false },
  { code: 'es', name: 'Español', rtl: false },
  { code: 'fr', name: 'Français', rtl: false },
  { code: 'zu', name: 'isiZulu', rtl: false },
  { code: 'xh', name: 'isiXhosa', rtl: false },
  { code: 'sw', name: 'Kiswahili', rtl: false },
  { code: 'de', name: 'Deutsch', rtl: false }
];

// Load initial translations from assets
const loadInitialTranslations = async () => {
  const translations: any = {};

  for (const lang of SUPPORTED_LANGUAGES) {
    try {
      // Load common translations
      const commonPath = `assets/locales/${lang.code}/common.json`;
      const commonContent = await RNFS.readAsStringAsync(commonPath);
      translations[lang.code] = {
        translation: JSON.parse(commonContent)
      };

      // Load dashboard translations
      const dashboardPath = `assets/locales/${lang.code}/0100-dashboard.json`;
      const dashboardContent = await RNFS.readAsStringAsync(dashboardPath);
      translations[lang.code].translation = {
        ...translations[lang.code].translation,
        ...JSON.parse(dashboardContent)
      };
    } catch (error) {
      console.warn(`Failed to load translations for ${lang.code}:`, error);
      // Fallback to English for missing translations
      if (lang.code !== 'en') {
        translations[lang.code] = translations['en'];
      }
    }
  }

  return translations;
};

const initializeI18n = async () => {
  const resources = await loadInitialTranslations();

  await i18n
    .use(initReactI18next)
    .init({
      resources,
      lng: 'en', // default language
      fallbackLng: 'en',
      debug: __DEV__,

      interpolation: {
        escapeValue: false, // React already does escaping
      },

      // React options
      react: {
        useSuspense: false,
      },
    });

  return i18n;
};

// Initialize i18n asynchronously
export const initializeI18nService = initializeI18n;

export default i18n;

// Translation hook
export const useTranslation = () => {
  return {
    t: (key: string, options?: any) => i18n.t(key, options),
    i18n,
    changeLanguage: (lng: string) => i18n.changeLanguage(lng),
    currentLanguage: i18n.language,
  };
};

// Utility functions
export const getCurrentLanguage = () => i18n.language;

export const changeLanguage = async (languageCode: string) => {
  try {
    await i18n.changeLanguage(languageCode);
    return true;
  } catch (error) {
    console.error('Failed to change language:', error);
    return false;
  }
};

export const isRTLLanguage = (languageCode: string) => {
  const language = SUPPORTED_LANGUAGES.find(lang => lang.code === languageCode);
  return language?.rtl || false;
};
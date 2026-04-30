/**
 * I18N Service Tests
 * Comprehensive testing for translation system
 */

import { initializeI18nService, SUPPORTED_LANGUAGES, changeLanguage } from '../../src/services/i18n';
import i18n from 'i18next';

// Mock expo-file-system
jest.mock('expo-file-system', () => ({
  readAsStringAsync: jest.fn(),
}));

const mockFileSystem = require('expo-file-system');

describe('I18N Service', () => {
  beforeEach(() => {
    // Clear i18n instance
    jest.clearAllMocks();

    // Mock file system reads
    mockFileSystem.readAsStringAsync.mockImplementation((path) => {
      if (path.includes('common.json')) {
        return Promise.resolve(JSON.stringify({
          app: { name: 'ConstructAI Mobile' },
          navigation: { dashboard: 'Dashboard' }
        }));
      }
      if (path.includes('0100-dashboard.json')) {
        return Promise.resolve(JSON.stringify({
          title: 'Dashboard',
          welcome: { greeting: 'Welcome' }
        }));
      }
      return Promise.reject(new Error('File not found'));
    });
  });

  describe('Supported Languages', () => {
    test('should have all 9 supported languages', () => {
      expect(SUPPORTED_LANGUAGES).toHaveLength(9);

      const expectedCodes = ['en', 'ar', 'pt', 'es', 'fr', 'zu', 'xh', 'sw', 'de'];
      const actualCodes = SUPPORTED_LANGUAGES.map(lang => lang.code);

      expect(actualCodes.sort()).toEqual(expectedCodes.sort());
    });

    test('should correctly identify RTL languages', () => {
      const arabic = SUPPORTED_LANGUAGES.find(lang => lang.code === 'ar');
      const english = SUPPORTED_LANGUAGES.find(lang => lang.code === 'en');

      expect(arabic?.rtl).toBe(true);
      expect(english?.rtl).toBe(false);
    });
  });

  describe('Initialization', () => {
    test('should initialize i18n service successfully', async () => {
      const i18nInstance = await initializeI18nService();

      expect(i18nInstance).toBeDefined();
      expect(i18nInstance.language).toBe('en');
    });

    test('should load translation files from assets', async () => {
      await initializeI18nService();

      expect(mockFileSystem.readAsStringAsync).toHaveBeenCalledWith(
        expect.stringContaining('assets/locales/en/common.json')
      );
      expect(mockFileSystem.readAsStringAsync).toHaveBeenCalledWith(
        expect.stringContaining('assets/locales/en/0100-dashboard.json')
      );
    });

    test('should handle file loading errors gracefully', async () => {
      mockFileSystem.readAsStringAsync.mockRejectedValueOnce(new Error('File not found'));

      await expect(initializeI18nService()).resolves.toBeDefined();
    });
  });

  describe('Language Switching', () => {
    beforeEach(async () => {
      await initializeI18nService();
    });

    test('should change language successfully', async () => {
      const result = await changeLanguage('es');

      expect(result).toBe(true);
      expect(i18n.language).toBe('es');
    });

    test('should handle invalid language codes', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation(() => {});

      const result = await changeLanguage('invalid-lang');

      expect(result).toBe(false);
      expect(consoleSpy).toHaveBeenCalled();

      consoleSpy.mockRestore();
    });
  });

  describe('RTL Language Detection', () => {
    test('should correctly identify RTL languages', () => {
      const { SUPPORTED_LANGUAGES } = require('../../src/services/i18n');

      const rtlLanguages = SUPPORTED_LANGUAGES.filter(lang => lang.rtl);
      const ltrLanguages = SUPPORTED_LANGUAGES.filter(lang => !lang.rtl);

      expect(rtlLanguages).toHaveLength(1);
      expect(rtlLanguages[0].code).toBe('ar');

      expect(ltrLanguages).toHaveLength(8);
    });
  });
});
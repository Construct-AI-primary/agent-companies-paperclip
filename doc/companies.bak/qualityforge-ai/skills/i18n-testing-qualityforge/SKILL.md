---
name: i18n-testing-qualityforge
description: Internationalization testing including locale files, translations, and date/number formatting
company: qualityforge-ai
category: testing
priority: P3
---

# i18n Testing

## Purpose
Test application internationalization, locale support, translations, and regional formatting.

## Test Procedures

### 1. Locale Files and Translations
- [ ] Verify all UI strings have translation keys
- [ ] Test switching between all supported languages
- [ ] Verify no hardcoded strings in UI
- [ ] Check for missing translations (fallback to default)
- [ ] Test RTL (right-to-left) language support if applicable
- [ ] Verify translation completeness per locale
- [ ] Test language persistence across sessions

### 2. Date and Time Formatting
- [ ] Test date formats per locale (MM/DD/YYYY vs DD/MM/YYYY)
- [ ] Test time formats (12h vs 24h)
- [ ] Verify timezone handling and display
- [ ] Test date picker localization
- [ ] Verify relative time formatting (e.g., "2 hours ago")
- [ ] Test calendar week start day (Sunday vs Monday)

### 3. Number and Currency Formatting
- [ ] Test number separators (1,000.00 vs 1.000,00)
- [ ] Test decimal separators (period vs comma)
- [ ] Test currency symbols and placement ($100 vs 100€)
- [ ] Test percentage formatting
- [ ] Verify large number formatting per locale

### 4. Text and Layout Adaptation
- [ ] Test text expansion/contraction in different languages
- [ ] Verify no text overflow or truncation
- [ ] Test font support for non-Latin characters
- [ ] Verify layout adapts for RTL languages
- [ ] Test form input validation messages in all locales
- [ ] Check email templates for localization

### 5. Regional Settings
- [ ] Test address format per locale
- [ ] Test phone number formatting
- [ ] Verify measurement unit conversion (metric vs imperial)
- [ ] Test paper size defaults (A4 vs Letter)
- [ ] Verify sorting and collation per locale

### 6. Content Localization Quality
- [ ] Verify translations are contextually accurate
- [ ] Test for machine translation artifacts
- [ ] Check cultural appropriateness of content
- [ ] Verify legal/regulatory compliance per region
- [ ] Test search functionality with non-ASCII characters

## Expected Outcomes
- All UI strings translated for supported locales
- Dates, numbers, currencies formatted correctly per locale
- No layout breaks with expanded text
- RTL languages display correctly
- Search and input work with all character sets
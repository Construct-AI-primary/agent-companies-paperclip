---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 0000_I18N_TRANSLATION_FILE_ORGANIZATION_PROCEDURE.md - I18NEXT Translation File Organization Procedure

## Overview

This procedure establishes standardized file organization patterns for I18NEXT translation files across the Construct AI system. The procedure ensures consistent storage locations, naming conventions, and maintenance practices for page text, table data, and all other translatable content.

**🔗 Cross-References to Related Procedures:**

**UI/UX Implementation Procedures:**
- → `0000_ELEMENT_STYLING_REFERENCE_PROCEDURE.md` → UI component styling consistency across languages
- → `0000_DROPDOWN_IMPLEMENTATION_PROCEDURE.md` → Dropdown component translations and localization
- → `0000_CHATBOT_COMPREHENSIVE_PROCEDURE.md` → Chatbot interface translations and multilingual support

**System Maintenance Procedures:**
- → `0000_SYSTEM_TROUBLESHOOTING_PROCEDURE_TEMPLATE.md` → Troubleshooting translation loading issues
- → `0000_DEBUGGING_GUIDE.md` → Advanced debugging for i18n configuration and translation problems
- → `0000_SQL_EXECUTION_PROCEDURE.md` → Database operations for translation data management

## Current Storage Structure

### ✅ Established Location (Follow This Pattern)
```
client/public/locales/
├── [language-code]/               # ISO language codes (en, ar, pt, es, fr, zu, xh, sw, de)
│   ├── [namespace].json          # Feature-specific translation files
│   └── [page-number]-[feature].json  # Page-specific translations
```

### Examples of Current Implementation
```
client/public/locales/en/
├── 0165-ui-settings.json          # UI settings page translations
├── 0200-accordion.json            # Accordion menu translations
├── 3010-email-management.json     # Email management translations
└── 9999-ptest.json               # Test translations (temporary)
```

## Procedure for File Storage Organization

### **1. Page Text Storage**
**Location**: `client/public/locales/[language]/[page-number]-[page-name].json`

```json
{
  "title": "Safety",
  "navigation": {
    "specialists": "Specialists",
    "upsert": "Upsert",
    "workspace": "Workspace"
  },
  "form": {
    "submit": "Save Changes",
    "cancel": "Cancel"
  }
}
```

**Example**:
- `0200-all-documents.json` - All Documents page
- `01300-governance.json` - Governance page
- `02400-safety.json` - Safety management page

### **2. Table Data & Grid Content Storage**
**Location**: `client/public/locales/[language]/[page-number]-table-[table-name].json`

```json
{
  "table": {
    "headers": {
      "name": "Name",
      "status": "Status",
      "date": "Date",
      "actions": "Actions"
    },
    "actions": {
      "edit": "Edit",
      "delete": "Delete",
      "view": "View Details"
    },
    "messages": {
      "noData": "No data available",
      "loading": "Loading...",
      "error": "Error loading data"
    }
  }
}
```

**Example**:
- `01300-table-approvals.json` - Governance approvals table
- `01900-table-suppliers.json` - Procurement suppliers table
- `02050-table-logs.json` - Information Technology logs table

### **3. Modal & Dialog Content Storage**
**Location**: `client/public/locales/[language]/[page-number]-modals.json` or `[page-number]-[modal-name].json`

```json
{
  "modals": {
    "deleteConfirmation": {
      "title": "Confirm Deletion",
      "message": "Are you sure you want to delete this item?",
      "confirm": "Delete",
      "cancel": "Cancel"
    },
    "saveChanges": {
      "title": "Save Changes",
      "message": "You have unsaved changes. Do you want to save them?",
      "save": "Save",
      "discard": "Discard",
      "cancel": "Cancel"
    }
  }
}
```

### **4. Component-Specific Content Storage**
**Location**: `client/public/locales/[language]/[component-namespace].json`

**Examples of component namespaces**:
- `accordion.json` - Navigation components
- `chatbot.json` - Chatbot interface
- `dropdowns.json` - Dropdown menus
- `form-validation.json` - Form validation messages

### **5. Discipline-Specific Content Storage**
**Location**: `client/public/locales/[language]/[discipline-number]-[discipline].json`

```json
{
  "title": "Safety",
  "sections": {
    "specialists": "Safety Specialists",
    "assessments": "Risk Assessments",
    "inspections": "Safety Inspections"
  },
  "forms": {
    "hazard": {
      "title": "Hazard Identification",
      "description": "Identify and assess workplace hazards"
    }
  }
}
```

**Examples**:
- `02400-safety.json` - Safety discipline
- `01200-finance.json` - Finance discipline
- `01900-procurement.json` - Procurement discipline

## Implementation Steps

### **Phase 1: Planning & Assessment**
```bash
# 1. Analyze existing page structure
find client/src/pages -name "*.js" -o -name "*.jsx" | head -10

# 2. Identify translatable content sources
grep -r "data-i18n\|i18next\.t\|this\.translations" client/src/

# 3. List current translation files
ls -la client/public/locales/en/
```

### **Phase 2: File Organization**
```bash
# Create language directories for all supported languages
for lang in en ar pt es fr zu xh sw de; do
  mkdir -p client/public/locales/${lang}
done

# Organize existing files by page numbers
# Example reorganization:
mv 0165-ui-settings.json 0165-ui-settings.json  # Already correct
mv 0200-accordion.json 0200-accordion.json      # Already correct
# ... continue for all files
```

### **Phase 3: Content Migration**
```javascript
// Update i18n configuration to use new namespaces
const namespaceMapping = {
  '0165-settings': '0165-ui-settings',
  '0200-accordion': '0200-accordion',
  // Add new mappings as you organize files
};
```

### **Phase 4: Translation Expansion**
```bash
# Copy English translations to other languages as templates
for lang in ar pt es fr zu xh sw de; do
  cp client/public/locales/en/*.json client/public/locales/${lang}/
  echo "Copied template files to ${lang} - requires translation"
done
```

## Maintenance Guidelines

### **Adding New Translation Files**
1. **Determine appropriate namespace** based on content type
2. **Create file** in all language directories
3. **Update i18n configuration** with new namespace
4. **Test loading** in webpack build

### **Version Control Best Practices**
```bash
# Commit translation changes separately
git add client/public/locales/
git commit -m "feat: Add translations for [feature]

- Added [language] translations for [page/feature]
- Updated namespace configuration
- Tested in [environment]"

# Use descriptive commit messages for translation work
git commit -m "i18n: Update [page] table headers

- Fixed typos in column headers
- Added missing translations for [language]
- Aligned terminology with business requirements"
```

### **Quality Assurance**
- [ ] **JSON Validation**: All files parse as valid JSON
- [ ] **Key Consistency**: Same keys across all language files
- [ ] **Namespace Registration**: New namespaces added to i18n config
- [ ] **Webpack Build**: Translation files copied to dist directory
- [ ] **Runtime Loading**: No 404 errors for translation files

## Common Issues & Solutions

### **Issue: Translation File Not Found**
```bash
# Check if file exists in all language directories
find client/public/locales -name "*.json" | sort

# Verify webpack copies locales
grep -r "locales" client/config/webpack.config.js

# Check browser network tab for failed requests
```

### **Issue: Namespaces Not Loading**
```javascript
// Update i18n configuration
const i18nConfig = {
  ns: ['0165-ui-settings', '0200-accordion', '3010-email-management'],
  defaultNS: '0165-ui-settings'
};
```

### **Issue: Incomplete Translations**
```bash
# Find missing translations
for lang in ar pt es fr zu xh sw de; do
  echo "Checking ${lang}...";
  wc -l client/public/locales/en/*.json client/public/locales/${lang}/*.json;
done
```

## Language Code Reference

| Language | Code | RTL | Notes |
|----------|------|----|--------|
| English | `en` | No | Default language - complete |
| Arabic | `ar` | Yes | RTL support required |
| Portuguese | `pt` | No | - |
| Spanish | `es` | No | - |
| French | `fr` | No | - |
| Zulu | `zu` | No | South African language |
| Xhosa | `xh` | No | South African language |
| Swahili | `sw` | No | East African language |
| German | `de` | No | European business language |

## Performance Considerations

### **File Size Management**
- Keep individual files under 100KB
- Split large pages into component-specific files
- Use compression for production builds
- Monitor webpack bundle size

### **Loading Optimization**
```javascript
// Lazy load namespaces when needed
await i18n.loadNamespaces(['large-namespace']);
// Only load required namespaces per page
```

## Integration with Development Workflow

### **Development Mode**
```javascript
// Enable debug mode for development
i18next.init({
  debug: true,  // Shows missing key warnings
  // ... other config
});
```

### **Production Mode**
```javascript
// Disable debug mode, enable fallback
i18next.init({
  debug: false,
  fallbackLng: 'en',
  // ... other config
});
```

## Testing Strategy

### **Automated Testing**
```javascript
// Test translation key existence
describe('Translation Files', () => {
  it('should have consistent keys across languages', () => {
    // Assert all languages have same keys as English
  });

  it('should load without errors', () => {
    // Test namespace loading
  });
});
```

### **Manual Testing Checklist**
- [ ] **Language Switching**: All supported languages work
- [ ] **RTL Layout**: Arabic displays correctly
- [ ] **Missing Keys**: Debug fallback displays for untranslated keys
- [ ] **Namespace Loading**: All required namespaces load on page visit
- [ ] **Performance**: Page load times acceptable with translations

## Version History

- **v1.0** (2025-11-19): Initial procedure documentation
  - Established file organization patterns
  - Defined namespace conventions
  - Added maintenance guidelines
  - Included testing strategies

## Related Documentation

- **[0800_INTERNATIONALIZATION.md](../user-interface/0800_INTERNATIONALIZATION.md)** - Main i18n system documentation
- **[0800_I18NEXT_CONFIGURATION_FIX.md](../error-tracking/🗄️%20Database%20&%20System%20Errors/0800_I18NEXT_CONFIGURATION_FIX.md)** - i18next configuration issues
- **[0000_DOCUMENTATION_GUIDE.md](../0000_DOCUMENTATION_GUIDE.md)** - General documentation standards
- **[0305_SQLITE_FIRST_WORKFLOW.md](../database-systems/0305_SQLITE_FIRST_WORKFLOW.md)** - Development environment setup

## Quick Reference

| Content Type | Location Pattern | Example |
|--------------|------------------|---------|
| Page Text | `[page-number]-[page-name].json` | `01300-governance.json` |
| Table Data | `[page-number]-table-[table-name].json` | `01900-table-suppliers.json` |
| Modal Content | `[page-number]-modals.json` | `02400-modals.json` |
| Disciplines | `[discipline-number]-[discipline].json` | `02400-safety.json` |
| Components | `[component-namespace].json` | `accordion.json` |

This procedure ensures consistent, maintainable, and scalable translation file organization across the Construct AI system.

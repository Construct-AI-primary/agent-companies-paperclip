---
memory_layer: durable_knowledge
para_section: standards
gigabrain_tags: standards, naming, files, documentation
documentation
openstinger_context: file-organization, standards
last_updated: 2026-03-30
related_docs:
  - docs/standards/
  - docs/codebase/agents/0000_README.md
---
# File Naming Standards

**Standardization for file and directory naming across the Construct AI Platform**

---

## 📋 Overview

This document establishes the naming conventions for all files and directories in the Construct AI codebase. Consistent naming ensures maintainability, readability, and proper organization.

---

## 🔧 File Naming Conventions

### General Rules
- **Case Sensitivity**: All filenames must be lowercase with underscores
- **Special Characters**: Only underscores (`_`) and hyphens (`-`) allowed
- **Spaces**: Never use spaces in filenames
- **Length**: Keep filenames descriptive but under 50 characters

### File Extensions
- **JavaScript**: `.JS` (uppercase)
- **Python**: `.PY` (uppercase)
- **Markdown**: `.md` (lowercase)
- **JSON**: `.json` (lowercase)
- **YAML**: `.yaml` (lowercase)
- **SQL**: `.sql` (lowercase)

### Numeric Prefixes
- **Format**: `0000_`, `0001_`, `0010_`, etc.
- **Purpose**: Maintains alphabetical ordering
- **Increment**: Use increments of 1 for related files, 10 for major sections

---

## 📁 Directory Structure

### Naming Rules
- **Lowercase**: All directory names in lowercase
- **Underscores**: Use underscores for multi-word names
- **No Numbers**: Avoid numeric prefixes in directory names (except root level)

### Examples
```
✅ Correct:
agents/
communication/
file_naming_standards/

❌ Incorrect:
Agents/
file-naming-standards/
0001_agents/
```

---

## 📄 File Type Standards

### Markdown Files (.md)
- **Purpose**: Documentation, guides, specifications
- **Naming**: Descriptive names in CAPS with underscores
- **Prefix**: Numeric prefix for ordering
- **Extension**: Always `.md` (lowercase)

**Examples:**
```
0000_README.md
0002_FILE_NAMING_STANDARDS.md
AGENT_GUIDE.md
```

### Code Files (.JS, .PY)
- **Purpose**: Executable code, libraries, utilities
- **Naming**: Descriptive lowercase with underscores
- **Prefix**: Numeric prefix for ordering
- **Extension**: Always uppercase (`.JS`, `.PY`)

**Examples:**
```
0010_agent_generator.JS
0000_base_specialist.PY
meta_agent_validator.JS
```

### Data Files (.json, .yaml, .sql)
- **Purpose**: Configuration, schemas, database scripts
- **Naming**: Descriptive lowercase with underscores
- **Extension**: Always lowercase

**Examples:**
```
agent_config.json
database_schema.yaml
user_permissions.sql
```

---

## 🏷️ Naming Patterns

### By File Type

#### Documentation Files
```
{prefix}_{DESCRIPTIVE_NAME}.md
```
- `0000_README.md`
- `0001_INSTALLATION_GUIDE.md`
- `0002_FILE_NAMING_STANDARDS.md`

#### Code Files
```
{prefix}_{descriptive_name}.{EXT}
```
- `0000_main.JS`
- `0001_helper_functions.JS`
- `0000_core_agent.PY`

#### Test Files
```
{prefix}_{component}_test.{EXT}
```
- `0000_agent_test.JS`
- `0001_validator_test.PY`

#### Configuration Files
```
{component}_config.json
{service}_settings.yaml
```

---

## 📊 Examples Table

| File Type | Correct | Incorrect |
|-----------|---------|-----------|
| Markdown | `0000_README.md` | `readme.md`, `README.md` |
| JavaScript | `0000_main.JS` | `main.js`, `Main.js` |
| Python | `0000_core.PY` | `core.py`, `Core.py` |
| JSON | `config.json` | `Config.JSON`, `config.JSON` |
| YAML | `settings.yaml` | `Settings.YAML` |
| SQL | `schema.sql` | `SCHEMA.SQL` |

---

## 🚫 Prohibited Patterns

### Never Use
- Spaces in filenames: `my file.JS` ❌
- CamelCase: `myFile.JS` ❌
- Special characters: `file@v1.JS` ❌
- Mixed case extensions: `file.js` ❌ (should be `.JS`)

### Directory Issues
- Numeric prefixes: `0001_docs/` ❌
- Uppercase: `DOCS/` ❌
- Spaces: `my docs/` ❌

---

## 🔍 Validation

### Automated Checks
- Pre-commit hooks validate naming conventions
- CI/CD pipelines check file extensions
- Linting tools enforce naming rules

### Manual Review
- Code reviews check naming compliance
- Documentation audits verify standards
- Regular cleanup of legacy files

---

## 📝 Migration Guide

### From Legacy Naming
1. **Identify** files with incorrect naming
2. **Rename** using correct conventions
3. **Update** all references in code/docs
4. **Test** that all links still work
5. **Commit** with clear migration message

### Tools
- `rename_files.sh` - Batch renaming script
- `validate_naming.py` - Naming validation tool
- `migration_guide.md` - Step-by-step migration

---

## 🆘 Support

For naming questions:
- Check this document first
- Review existing files for examples
- Ask in #standards channel
- Create issue for clarification needed

---

**Last Updated**: 2026-03-30
**Maintainer**: Construct AI Standards Team
**Version**: 1.0
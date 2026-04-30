---
memory_layer: durable_knowledge
para_section: pages/codebase/guides
gigabrain_tags: guides, codebase, documentation
documentation
openstinger_context: development-guides, implementation-guidance
last_updated: 2026-03-21
related_docs:
  - codebase/guides/
  - disciplines/
---
# Standards Directory

**Development Standards for Construct AI**

This directory contains all coding, naming, and development standards used across the Construct AI platform.

---

## 📁 Directory Structure

```
docs/standards/
├── README.md                           # This file
├── 0000_AGENT_CODING_STANDARDS.md      # AI agent coding standards
├── 0000_GOVERNANCE_SWARM_ARCHITECTURE.md # Governance architecture
├── 0000_HF_MODEL_INTEGRATION_README.md # HuggingFace integration
├── 0000_SUPABASE_API_KEY_FIX_SUMMARY.md # API key fixes
├── 0000_FIX_GIT_TRACKING_ISSUE.md      # Git tracking fix
├── 0000_FIX_SUMMARY_FOREIGN_KEY_CONSTRAINT.md # Foreign key fixes
├── 0001_PROMPT_TAGGING_STANDARDS.md    # Prompt tagging conventions
├── 0002_FILE_NAMING_STANDARDS.md       # File naming conventions
├── 0003_DATABASE_NAMING_STANDARDS.md   # Database naming
├── 0003_UI_ACCORDION_STANDARDS.md      # UI accordion standards
├── 0004_upload_local_file_modal_layout_standards.md # Modal layout
└── 0005_WORKFLOW_OPTIMIZATION_STANDARDS.md # **NEW** System optimization & workflow design
```

---

## 🚀 Quick Reference

### For Developers

| Standard | Purpose | When to Use |
|----------|---------|-------------|
| [0000_AGENT_CODING_STANDARDS.md](0000_AGENT_CODING_STANDARDS.md) | Coding standards for AI agents | Writing agent code |
| [0005_WORKFLOW_OPTIMIZATION_STANDARDS.md](0005_WORKFLOW_OPTIMIZATION_STANDARDS.md) | **NEW** System optimization & workflow design | Code quality assessment, performance optimization |
| [0002_FILE_NAMING_STANDARDS.md](0002_FILE_NAMING_STANDARDS.md) | File naming conventions | Creating new files |
| [0001_PROMPT_TAGGING_STANDARDS.md](0001_PROMPT_TAGGING_STANDARDS.md) | Prompt organization | Creating LLM prompts |
| [0003_DATABASE_NAMING_STANDARDS.md](0003_DATABASE_NAMING_STANDARDS.md) | Database naming | Creating tables/columns |
| [0003_UI_ACCORDION_STANDARDS.md](0003_UI_ACCORDION_STANDARDS.md) | Accordion UI patterns | Building page sections |

### Quick Guidelines

**File Naming:**
- ✅ `0000_agent_coding_standards.md`
- ❌ `Agent Coding Standards.md` (spaces, mixed case)
- ❌ `agent-coding-standards.md` (no prefix, hyphens)

**Code Style:**
- Lowercase filenames with underscores
- Numeric prefixes for ordering
- Descriptive names

---

## 📋 Standards Categories

### Coding Standards (`0000_AGENT_CODING_STANDARDS.md`)
- Agent structure and organization
- Code quality requirements
- Error handling patterns
- Testing requirements
- Documentation standards

### Workflow Optimization (`0005_WORKFLOW_OPTIMIZATION_STANDARDS.md`)
- **NEW** System optimization procedures
- Code quality assessment frameworks
- Performance monitoring standards
- Workflow design guidelines
- Quality assurance methodologies

### File Naming (`0002_FILE_NAMING_STANDARDS.md`)
- General naming principles
- Directory-specific conventions
- Numeric prefixing system
- File extensions
- Validation checklist

### Prompt Standards (`0001_PROMPT_TAGGING_STANDARDS.md`)
- Prompt tagging conventions
- Organization patterns
- Version control
- Metadata requirements

### Database Standards (`0003_DATABASE_NAMING_STANDARDS.md`)
- Table naming
- Column naming
- Index naming
- Migration naming

### UI Standards (`0003_UI_ACCORDION_STANDARDS.md`)
- Accordion structure
- Naming conventions
- Configuration patterns

---

## 🔧 Numeric Prefixing System

Used across all Construct AI directories:

| Range | Purpose |
|-------|---------|
| `0000-0999` | Master guides and foundational docs |
| `1000-1999` | Agent-specific documentation |
| `2000-2999` | Workflow and process documentation |
| `3000-3999` | Technical implementation guides |
| `4000-4999` | Reserved for future use |
| `5000-5999` | Database and migration documentation |
| `6000-6999` | Testing and quality assurance |
| `7000-7999` | Deployment and operations |
| `8000-8999` | Feature-specific documentation |
| `9000-9999` | Legacy and archived documentation |

---

## 📝 Naming Convention Summary

### Documentation Files
```
{prefix}_{descriptive_name}.md
```

### Code Files
```
{camelCase}.js          # JavaScript
{PascalCase}.js         # React components
{snake_case}.py         # Python
```

### Database Files
```
{operation}_{table}_{description}.sql
```

---

## ✅ Validation Checklist

Before creating new files, verify:
- [ ] Filename follows lowercase convention
- [ ] Uses underscores for word separation
- [ ] Has appropriate numeric prefix (if applicable)
- [ ] File extension is correct and lowercase
- [ ] Name clearly describes content
- [ ] Follows directory-specific naming pattern
- [ ] Consistent with existing files

---

## 🆘 Support

For questions about standards:
1. Review the relevant standard document
2. Check existing files for examples
3. Follow the validation checklist
4. Ask in team chat for clarification

---

**Last Updated**: 2026-02-09
**Maintainer**: Construct AI Development Team

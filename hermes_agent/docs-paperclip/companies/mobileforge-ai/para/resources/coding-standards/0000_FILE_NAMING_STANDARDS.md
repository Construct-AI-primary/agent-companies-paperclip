---
memory_layer: durable_knowledge
para_section: pages/codebase/coding-standards
gigabrain_tags: coding-standards, codebase, development-practices
documentation
openstinger_context: coding-standards-practices
last_updated: 2026-03-21
related_docs:
  - codebase/coding-standards/
  - disciplines/
---
# File Naming Standards for Construct AI

This document outlines the standardized file naming conventions used across the ConstructAI repository for consistent organization and discoverability.

## General Naming Principles

### **Core Rules:**
- **Lowercase**: All filenames must be lowercase
- **Underscores**: Use underscores (`_`) instead of spaces or hyphens for word separation
- **Descriptive**: Names should clearly indicate content and purpose
- **Consistent**: Follow established patterns within each directory type
- **Sequential**: Use numeric prefixes for ordering within categories
- **No Emojis**: Files must not contain any emoji characters

### **File Extensions:**
- **Documentation**: `.md` (Markdown)
- **JavaScript**: `.js`
- **JSON**: `.json`
- **SQL**: `.sql`
- **Text**: `.txt`
- **Images**: `.png`, `.jpg`, `.svg`

## Directory-Specific Naming Conventions

### **Documentation Files (`docs/`)**
```
docs/{category}/{prefix}_{descriptive_name}.md
```

#### **Master Guides:**
- `0000_DOCUMENTATION_MASTER_GUIDE.md` - Main documentation navigation
- `0000_PROCEDURES_GUIDE.md` - Procedures navigation

#### **Standards (`docs/standards/`):**
- `0000_AGENT_CODING_STANDARDS.md` - AI agent coding standards
- `0001_PROMPT_TAGGING_STANDARDS.md` - Prompt tagging conventions
- `0002_FILE_NAMING_STANDARDS.md` - File naming conventions

#### **Procedures (`docs/procedures/`):**
- `0000_PROMPT_MANAGEMENT_PROCEDURE.md` - Prompt management workflow
- `0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md` - Workflow implementation steps
- `0002_WORKFLOW_AGENT_CENTRIC_PAGE_IMPLEMENTATION_PROCEDURE.md` - Agent page implementation

#### **Agent Documentation (`docs/pages-agents/`):**
```
{page_id}_AGENT_{agent_name}_PROCEDURE.md
```
- `1300_00435_CONTRACTS_POST_AWARD_CORRESPONDENCE_AGENT_IMPLEMENTATION_PROCEDURE.md`
- `1300_00436_AGENT_DOCUMENT_ANALYSIS_PROCEDURE.md`

#### **Error Tracking (`docs/error-tracking/`):**
```
{page_id}_{agent_id}_{error_type}.md
```
- `1300_00435_CORRESPONDENCE_AGENT_LLM_EXTRACTION_ERRORS.md`

### **Source Code Files (`client/src/` or `server/src/`)**

#### **JavaScript Files:**
```
{camelCase}.js
```
- `correspondenceAnalyzer.js`
- `promptKeyValidator.js`

#### **React Components:**
```
{PascalCase}.js
```
- `CorrespondenceReplyModal.js`
- `DocumentAnalysisAgent.js`

#### **Directories:**
- Use `camelCase` for directory names
- Group related functionality together
- `common/js/services/` - Shared services
- `pages/{pageId}/components/` - Page-specific components

### **Database Files (`server/sql/`)**

#### **Migration Files:**
```
{operation}_{table}_{description}.sql
```
- `create_users_table.sql`
- `add_prompts_table.sql`

#### **Seed/Data Files:**
```
{operation}_{table}_{purpose}.sql
```
- `insert_initial_users.sql`
- `populate_test_data.sql`

### **Configuration Files (Root Directory)**

#### **Environment Files:**
```
.env{environment}
```
- `.env` - Default environment variables
- `.env.dev` - Development environment
- `.env.example` - Template for environment setup

#### **Project Configuration:**
- `package.json` - Node.js project configuration
- `{ProjectName}.code-workspace` - VS Code workspace configuration

## Numeric Prefixing System

### **Purpose:**
- **Ordering**: Files appear in logical sequence in directory listings
- **Categorization**: Group related files together
- **Scalability**: Room for insertion of new files without renumbering

### **Prefix Ranges:**
- `0000-0999`: Master guides and foundational documents
- `1000-1999`: Agent-specific documentation
- `2000-2999`: Workflow and process documentation
- `3000-3999`: Technical implementation guides
- `4000-4999`: Reserved for future use
- `5000-5999`: Database and migration documentation
- `6000-6999`: Testing and quality assurance
- `7000-7999`: Deployment and operations
- `8000-8999`: Feature-specific documentation
- `9000-9999`: Legacy and archived documentation

## File Organization Patterns

### **By Function:**
```
docs/
├── standards/          # Development standards
├── procedures/         # Implementation procedures
├── pages-agents/       # Agent-specific documentation
├── error-tracking/     # Error documentation
└── migration-logs/     # Migration documentation
```

### **By Audience:**
- **Developers**: `docs/standards/`, `docs/procedures/`
- **System Administrators**: `docs/migration-logs/`, deployment guides
- **QA Team**: `docs/error-tracking/`, testing procedures
- **Product Team**: Agent documentation, feature guides

## Naming Examples

### **✅ Correct Examples:**

**Documentation:**
- `docs/standards/0000_AGENT_CODING_STANDARDS.md`
- `docs/procedures/0000_PROMPT_MANAGEMENT_PROCEDURE.md`
- `docs/implementation/agents/1300_00435_CONTRACTS_POST_AWARD_CORRESPONDENCE_AGENT_IMPLEMENTATION_PROCEDURE.md`

**Code:**
- `client/src/common/js/services/promptKeyValidator.js`
- `server/src/routes/promptsRoutes.js`

**Database:**
- `server/sql/create_prompts_table.sql`
- `server/sql/add_prompt_versions_table.sql`

### **❌ Incorrect Examples:**

**Documentation:**
- `docs/Agent Coding Standards.md` (spaces, mixed case)
- `docs/agent-coding-standards.md` (no prefix, hyphens)
- `docs/AGENT_CODING_STANDARDS.MD` (uppercase extension)

**Code:**
- `client/src/PromptKeyValidator.js` (incorrect case)
- `server/src/prompts-routes.js` (hyphens)

## Validation Checklist

### **For New Files:**
- [ ] Filename follows lowercase convention
- [ ] Uses underscores for word separation
- [ ] Has appropriate numeric prefix (if applicable)
- [ ] File extension is correct and lowercase
- [ ] Name clearly describes content
- [ ] Follows directory-specific naming pattern
- [ ] Consistent with existing files in same directory

### **For File Moves/Renames:**
- [ ] Update all references in code and documentation
- [ ] Update import statements
- [ ] Update documentation links
- [ ] Update build configurations
- [ ] Test that all references still work

## Maintenance

### **Regular Review:**
- Review naming conventions quarterly
- Update standards as project evolves
- Ensure new team members understand conventions
- Audit existing files for compliance

### **Tools:**
- **Validation Scripts**: Automated checking of naming compliance
- **Documentation**: This standards document
- **Code Reviews**: Ensure naming standards are followed in PRs

## Related Standards

- **Agent Coding Standards**: `docs/standards/0000_AGENT_CODING_STANDARDS.md`
- **Prompt Tagging Standards**: `docs/standards/0001_PROMPT_TAGGING_STANDARDS.md`
- **Git Workflow Standards**: Defined in development guidelines

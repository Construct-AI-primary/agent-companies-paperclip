---
title: Issue File Generation Procedure
author: PaperclipForge AI
date: 2026-04-13
version: 1.0
status: active
---

# Issue File Generation Procedure

## Overview

This procedure defines the standardized process for generating issue files that can be batch-imported into the Paperclip ecosystem using the `issue-batch-importer` skill. Issue files serve as structured templates for creating multiple related issues efficiently, enabling bulk processing and multi-company orchestration.

## Purpose

- **Standardization**: Ensure consistent issue formatting across all projects
- **Batch Processing**: Enable efficient bulk import of related issues
- **Multi-Company Orchestration**: Support cross-company issue routing and assignment
- **Automation**: Facilitate automated issue creation and assignment workflows

## When to Use

### Trigger Conditions
- Creating multiple related issues for a project or initiative
- Setting up complex multi-company workflows
- Preparing issues for batch processing and orchestration
- Establishing standardized issue templates for recurring work patterns

### Prerequisites
- Project scope and requirements defined
- Company assignments and agent availability confirmed
- Issue dependencies and relationships identified
- Working directory and repository paths established

## Issue File Structure

### Required Frontmatter
```yaml
---
id: PROJ-001
title: Clear, descriptive issue title
phase: 1 — Phase Name
status: open
priority: high
---
```

### Required Sections

#### 1. Main Heading
```markdown
# PROJ-001: Clear, descriptive issue title
```

#### 2. Description Section
```markdown
## Description

Detailed description of the work required, including:
- Problem statement
- Objectives
- Scope boundaries
- Success criteria context
```

#### 3. Acceptance Criteria
```markdown
## Acceptance Criteria

- [ ] Specific, measurable completion criteria
- [ ] Verifiable outcomes
- [ ] Quality standards
- [ ] Testing requirements
```

#### 4. Assignment Information
```markdown
## Assigned Company & Agent

- **Company:** [Company Name]
- **Agent:** [Agent Name] ([agent-slug])
- **Supporting:** [Supporting Company] ([supporting-agent])
```

#### 5. Working Directory & Repository (REQUIRED)
```markdown
## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `path/to/primary/file.js`
  - `path/to/related/component.jsx`
  - `path/to/configuration/file.json`
```

#### 6. Required Skills
```markdown
## Required Skills

- `primary-skill` ([Company])
- `supporting-skill` ([Company])
- `shared-skill` (shared)
```

#### 7. Dependencies
```markdown
## Dependencies

- BLOCKED BY: [ISSUE-ID] ([Description])
- BLOCKS: [ISSUE-ID] ([Description])
```

#### 8. Paperclip Task Schema
```yaml
## Paperclip Task Schema

```yaml
company: company-slug
agent: agent-slug
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
```
```

## File Naming Convention

### Standard Format
```
{PROJECT_PREFIX}-{NUMBER}-{descriptive-slug}.md
```

### Examples
- `PROC-001-ui-modal-e2e-flow.md`
- `DEV-042-database-schema-optimization.md`
- `TEST-015-integration-validation.md`

### Project Prefixes
- `PROC`: Procurement-related issues
- `DEV`: Development tasks
- `TEST`: Testing and QA tasks
- `INFRA`: Infrastructure issues
- `DOC`: Documentation tasks
- `PROJ`: Project management issues

## Generation Workflow

### Step 1: Project Analysis
1. **Define Scope**: Identify all issues required for the project
2. **Categorize Issues**: Group issues by phase, priority, and company assignment
3. **Identify Dependencies**: Map issue relationships and blocking conditions
4. **Assign Resources**: Determine company and agent assignments

### Step 2: Template Creation
1. **Select Template**: Choose appropriate template based on issue type
2. **Populate Metadata**: Fill in frontmatter and basic information
3. **Define Scope**: Specify work boundaries and deliverables
4. **Set Criteria**: Establish clear acceptance criteria

### Step 3: Content Development
1. **Write Description**: Provide detailed problem statement and objectives
2. **Specify Files**: List target files and working directories
3. **Define Skills**: Identify required skills and competencies
4. **Set Dependencies**: Establish blocking and blocking relationships

### Step 4: Validation
1. **Format Check**: Verify YAML frontmatter syntax
2. **Content Review**: Ensure descriptions are clear and complete
3. **Path Validation**: Confirm working directory paths are correct
4. **Assignment Verification**: Validate company and agent assignments

### Step 5: Batch Organization
1. **Create Folder Structure**: Organize issues in logical folder hierarchy
2. **Naming Consistency**: Ensure consistent file naming across batch
3. **Dependency Ordering**: Arrange files to support dependency resolution
4. **Documentation**: Create batch processing instructions

## Issue Templates

### Development Issue Template
```markdown
---
id: DEV-001
title: Implement User Authentication System
phase: 2 — Development
status: open
priority: high
---

# DEV-001: Implement User Authentication System

## Description

Implement a comprehensive user authentication system including login, registration, password reset, and session management. The system should support multiple authentication methods and integrate with the existing user management infrastructure.

## Acceptance Criteria

- [ ] User registration with email verification
- [ ] Secure login/logout functionality
- [ ] Password reset via email
- [ ] Session management with automatic timeout
- [ ] Integration with existing user database
- [ ] Security best practices implemented

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Codesmith (codesmith-devforge-backend-engineer)
- **Supporting:** InfraForge AI (database-infraforge-database-infrastructure)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `server/src/routes/auth-routes.js`
  - `server/src/services/authService.js`
  - `server/src/middleware/auth.js`
  - `packages/db/src/schema/auth.ts`

## Required Skills

- `backend-development` (DevForge)
- `security-implementation` (DevForge)
- `database-integration` (InfraForge)

## Dependencies

- BLOCKED BY: DEV-000 (Setup development environment)
- BLOCKS: UI-001 (Implement login UI)

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: codesmith-devforge-backend-engineer
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 50
```
```

### Testing Issue Template
```markdown
---
id: TEST-001
title: Execute End-to-End API Testing
phase: 3 — Testing
status: open
priority: high
---

# TEST-001: Execute End-to-End API Testing

## Description

Execute comprehensive end-to-end testing for all API endpoints, covering authentication, data validation, error handling, and integration scenarios. Ensure all APIs meet performance and reliability requirements.

## Acceptance Criteria

- [ ] All API endpoints tested with positive cases
- [ ] Error scenarios and edge cases covered
- [ ] Authentication and authorization validated
- [ ] Data validation and sanitization confirmed
- [ ] Performance benchmarks met
- [ ] Integration with external services verified

## Assigned Company & Agent

- **Company:** QualityForge AI
- **Agent:** Validator (validator-qualityforge-validator)
- **Supporting:** DevForge AI (interface-devforge-api-integration)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - `server/src/routes/*.js`
  - `server/src/services/*.js`
  - Test configuration and data files

## Required Skills

- `api-testing` (QualityForge)
- `test-automation` (QualityForge)
- `api-integration` (DevForge)

## Dependencies

- BLOCKED BY: DEV-001 (Implement authentication system)
- BLOCKS: DEPLOY-001 (Production deployment)

## Paperclip Task Schema

```yaml
company: qualityforge-ai
agent: validator-qualityforge-validator
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 75
```
```

## Batch Processing Integration

### Issue Batch Importer Skill
Issue files are designed to work with the `issue-batch-importer` skill:

1. **Folder Processing**: Place issue files in organized folder structure
2. **Automatic Parsing**: Skill extracts metadata from YAML frontmatter and content
3. **Company Routing**: Issues automatically routed to appropriate companies
4. **Assignment Logic**: Agents assigned based on skills and availability
5. **Path Configuration**: Working directories and target files configured

### Batch Organization Example
```
/project-issues/
├── development/
│   ├── DEV-001-user-auth.md
│   ├── DEV-002-user-profile.md
│   └── DEV-003-admin-panel.md
├── testing/
│   ├── TEST-001-api-testing.md
│   ├── TEST-002-ui-testing.md
│   └── TEST-003-integration-testing.md
└── infrastructure/
    ├── INFRA-001-database-setup.md
    └── INFRA-002-monitoring.md
```

### Processing Command
```bash
# Use issue-batch-importer skill to process folder
hermes run --skill issue-batch-importer \
  --folder /path/to/project-issues \
  --company-routing intelligent \
  --path-config local-repos
```

## Quality Assurance

### Content Validation Checklist
- [ ] Frontmatter YAML syntax is valid
- [ ] Title is clear and descriptive
- [ ] Description provides sufficient context
- [ ] Acceptance criteria are specific and measurable
- [ ] Company and agent assignments are correct
- [ ] Working directory paths are accurate
- [ ] Required skills are properly specified
- [ ] Dependencies are clearly defined

### Technical Validation
- [ ] File naming follows convention
- [ ] No syntax errors in markdown
- [ ] Links and references are valid
- [ ] File paths exist in repository
- [ ] Agent slugs match available agents

## Common Patterns

### Issue Sequencing
1. **Foundation Issues**: Environment setup, infrastructure
2. **Development Issues**: Core feature implementation
3. **Integration Issues**: API connections, data flow
4. **Testing Issues**: Validation and quality assurance
5. **Documentation Issues**: User guides, API docs
6. **Deployment Issues**: Production readiness, monitoring

### Dependency Management
- Use clear BLOCKED BY / BLOCKS relationships
- Number issues to reflect logical sequence
- Group related issues in same phase
- Document cross-company dependencies

### File Organization
- Group by functional area (development, testing, infrastructure)
- Use consistent naming within batches
- Include batch processing instructions
- Document any special processing requirements

## Tools and Automation

### Template Generation
```bash
# Generate issue template
node scripts/generate-issue-template.js \
  --type development \
  --project PROC \
  --number 001 \
  --title "UI Modal Implementation"
```

### Batch Validation
```bash
# Validate all issues in folder
node scripts/validate-issue-batch.js \
  --folder /path/to/issues \
  --check-syntax \
  --verify-paths \
  --validate-assignments
```

### Import Preparation
```bash
# Prepare issues for batch import
node scripts/prepare-issue-import.js \
  --source /path/to/issues \
  --target /prepared-issues \
  --optimize-dependencies
```

## Troubleshooting

### Common Issues

#### YAML Frontmatter Errors
**Problem**: Invalid YAML syntax in frontmatter
**Solution**: Use YAML validator, check indentation and quotes

#### Path Resolution Issues
**Problem**: Working directory paths don't exist
**Solution**: Verify paths against actual repository structure

#### Assignment Conflicts
**Problem**: Agent not available or skills don't match
**Solution**: Check agent availability and skill requirements

#### Dependency Cycles
**Problem**: Circular dependencies between issues
**Solution**: Review and restructure dependency relationships

## Version Control

### File Versioning
- Include version in frontmatter when significant changes made
- Track changes in commit messages
- Maintain backward compatibility with existing batch processing

### Template Updates
- Update templates when new requirements emerge
- Document template changes and migration procedures
- Provide migration scripts for existing issue files

## Integration with Project Management

### Issue Lifecycle
1. **Creation**: Generate issue files using this procedure
2. **Import**: Use issue-batch-importer to create Paperclip issues
3. **Assignment**: Automatic routing to appropriate agents
4. **Execution**: Agents work on assigned issues
5. **Completion**: Issues closed with validation
6. **Archiving**: Completed issues archived with lessons learned

### Reporting and Analytics
- Track issue creation success rates
- Monitor batch processing efficiency
- Analyze assignment accuracy
- Measure time-to-completion metrics

---

**Document Control**
- **Version**: 1.0
- **Date**: 2026-04-13
- **Author**: PaperclipForge AI
- **Review**: Paperclip Operations Team
- **Approval**: Pending review
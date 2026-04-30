---
title: Paperclip Procedures Directory
description: Organized collection of operational procedures for the Paperclip ecosystem
author: Paperclip Documentation Team
date: 2026-04-13
version: 1.0
status: active
---

# Paperclip Procedures Directory

This directory contains operational procedures organized by functional area.

## Directory Structure

```
procedures/
├── README.md                          # This file
├── agents/                           # Agent management procedures
│   ├── adding-companies-and-agents.md
│   ├── deleting-companies-and-agents.md
│   ├── agent-model-assignment-procedure.md
│   ├── agent-naming-procedure.md
│   └── hermes-agent-setup-procedure.md
├── database/                         # Database operations
│   ├── database-sync-strategy.md
│   └── editing-database-tables.md
├── knowledge/                        # Knowledge management
│   └── knowledgeforge-knowledge-system.md
├── operations/                       # Production operations
│   └── production-operations.md
├── projects/                         # Project and issue management
│   ├── project-and-issue-generation-procedure.md
│   └── issue-file-generation-procedure.md
└── workflows/                        # Workflow development
    ├── cross-discipline-workflow-analysis.md
    └── discipline_workflow_conversion_procedure.md
```

## Procedure Categories

### 1. Agent Management (`agents/`)
Procedures for managing agents, companies, and agent configurations.

**Key Procedures**:
- **Adding Companies and Agents**: How to add new companies and agents to the system
- **Deleting Companies and Agents**: Proper procedures for removing companies and agents
- **Agent Model Assignment**: Assigning AI models to agents
- **Agent Naming**: Naming conventions and standards for agents
- **Hermes Agent Setup**: Setting up Hermes agent integration

### 2. Database Operations (`database/`)
Database management, synchronization, and editing procedures.

**Key Procedures**:
- **Database Sync Strategy**: Strategy for keeping database in sync across environments
- **Editing Database Tables**: Safe procedures for modifying database tables

### 3. Knowledge Management (`knowledge/`)
Knowledge capture, organization, and retrieval procedures.

**Key Procedures**:
- **KnowledgeForge Knowledge System**: How the knowledge management system works

### 4. Operations (`operations/`)
Production operations and deployment procedures.

**Key Procedures**:
- **Production Operations**: Running and maintaining production systems

### 5. Project Management (`projects/`)
Project creation, issue generation, and project lifecycle management.

**Key Procedures**:
- **Project and Issue Generation**: Creating projects and generating associated issues
- **Issue File Generation**: Creating well-formed issue files

### 6. Workflow Development (`workflows/`)
Workflow design, implementation, and cross-discipline analysis.

**Key Procedures**:
- **Cross-Discipline Workflow Analysis**: Analysis of common workflows across disciplines ⭐ NEW
- **Discipline Workflow Conversion**: Converting discipline workflows to Paperclip format

## Quick Navigation

### For Project Managers
- Start with `projects/project-and-issue-generation-procedure.md`
- See workflow analysis in `workflows/cross-discipline-workflow-analysis.md`

### For System Administrators
- Database operations in `database/`
- Production procedures in `operations/`

### For Agent Developers
- Agent setup in `agents/`
- Workflow implementation in `workflows/`

### For Knowledge Management
- Knowledge procedures in `knowledge/`

## Recent Additions

### 2026-04-13
- ✨ **NEW**: `workflows/cross-discipline-workflow-analysis.md` - Comprehensive analysis of 23 disciplines identifying 5 universal workflow patterns with 80-95% template reusability
- 🔄 **Reorganized**: All procedures organized into functional subdirectories

## Related Documentation

- **Project Plans**: `/docs-paperclip/plans/`
- **Company Documentation**: `/docs-paperclip/companies/`
- **Discipline Workflows**: `/docs-paperclip/disciplines/`
- **API Documentation**: `/docs-paperclip/api/`
- **Schema Documentation**: `/docs-paperclip/schema/`

## Contributing

When adding new procedures:

1. **Choose the right category** - Place procedure in the appropriate subdirectory
2. **Follow naming conventions** - Use descriptive, kebab-case filenames
3. **Include frontmatter** - Use YAML frontmatter with title, description, author, date, version, status
4. **Update this README** - Add your procedure to the relevant section
5. **Cross-reference** - Link to related procedures and documentation

## Document Standards

All procedures should include:

- **Purpose**: What the procedure accomplishes
- **Prerequisites**: What's needed before starting
- **Step-by-step instructions**: Clear, numbered steps
- **Examples**: Real-world examples where applicable
- **Troubleshooting**: Common issues and solutions
- **Related documents**: Links to related procedures and documentation

---

**Last Updated**: 2026-04-13
**Maintained By**: Paperclip Documentation Team
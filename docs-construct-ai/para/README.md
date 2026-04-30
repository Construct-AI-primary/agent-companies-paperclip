---
title: PARA Knowledge Management System
description: Centralized knowledge management structure for the Construct AI enterprise, enabling cross-discipline insight discovery and systematic knowledge organization
author: Construct AI Memory System Team
version: 2.0
memory_layer: durable_knowledge
para_section: para
gigabrain_tags: para, knowledge-management, cross-discipline, agent-reference, project-typologies
openstinger_context: knowledge-organization, para-structure
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01900_procurement/agent-data/domain-knowledge/1900_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/para/resources/project-typologies/0000_PROJECT-TYPOLOGIES-INDEX.MD
  - docs_construct_ai/disciplines/
---

# PARA Knowledge Management System

## Overview

This PARA system provides centralized knowledge management for the Construct AI enterprise, enabling cross-discipline insight discovery and systematic knowledge organization.

**Location**: `/docs-construct-ai/para/` — Reference and resource knowledge for AI agent consumption.

**Note on Discipline Content**: Discipline-specific agent data (prompts, domain knowledge, schemas, registries) are maintained under `/docs-construct-ai/disciplines/[code]_[discipline]/agent-data/`, not under this PARA directory. This PARA structure holds cross-discipline reference materials and project resources.

## Structure

### Pages
Active working documentation and page content
- `pages/codebase/` → Codebase documentation, analysis, architecture, and guides

**Note**: `pages/disciplines/` and `pages/disciplines-non/` have been removed as they contained only empty directories. Discipline content is maintained directly under `/docs-construct-ai/disciplines/`.

### Projects
Active project documentation organized by system or initiative
- `projects/00435-contracts-system/` → Contracts system documentation
- `projects/01700-logistics-system/` → Logistics system documentation
- `projects/01900-procurement-system/` → Procurement system documentation
- `projects/02400-safety-system/` → Safety system documentation

### Resources
Cross-discipline reference materials and reusable knowledge
- `resources/project-typologies/` → Construction project type reference documents for AI agents
  - `0000_PROJECT-TYPOLOGIES-INDEX.MD` → Master index
  - `0010_OIL-AND-GAS.MD` → Oil & Gas sector
  - `0020_MINING.MD` → Mining & Minerals sector
  - `0030_RESIDENTIAL.MD` → Residential Buildings
  - `0040_COMMERCIAL.MD` → Commercial Buildings
  - `0045_MIXED-USE.MD` → Mixed-Use Development
  - `0050_INFRASTRUCTURE.MD` → Roads, bridges, rail, ports, airports
  - `0055_INDUSTRIAL.MD` → Manufacturing, warehousing, heavy industrial, metallurgical
  - `0060_INSTITUTIONAL.MD` → Hospitals, schools, government facilities
  - `0070_ENERGY-POWER.MD` → Solar, wind, nuclear, transmission

### Areas
Ongoing responsibilities and operational domains
- *(Reserved for future operational domain organization)*

### Archives
Historical knowledge and completed work
- *(Reserved for future archival content)*

## Navigation

### Finding Resources
```bash
# View project typologies (cross-discipline reference)
ls docs-construct-ai/para/resources/project-typologies/

# View project system documentation
ls docs-construct-ai/para/projects/

# View codebase documentation
ls docs-construct-ai/para/pages/codebase/
```

### Finding Discipline Agent Data
```bash
# View all disciplines (agent data, not PARA)
ls docs-construct-ai/disciplines/

# View specific discipline agent data
ls docs-construct-ai/disciplines/00850_civil-engineering/agent-data/
ls docs-construct-ai/disciplines/01900_procurement/agent-data/

# View discipline domain-knowledge files
ls docs-construct-ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/
ls docs-construct-ai/disciplines/01900_procurement/agent-data/domain-knowledge/
```

## Knowledge Hierarchy

```
Construct AI Documentation
├── /disciplines/                      ← Discipline agent data (AI consumption)
│   ├── 00850_civil-engineering/
│   │   └── agent-data/
│   │       ├── domain-knowledge/      ← Domain knowledge for AI agents
│   │       └── prompts/               ← Agent prompt templates
│   └── 01900_procurement/
│       └── agent-data/
│           ├── domain-knowledge/      ← Procurement order management knowledge
│           └── prompts/
│
├── /para/                            ← Cross-discipline reference and resources
│   ├── pages/codebase/               ← Codebase documentation
│   ├── projects/                     ← Project system documentation
│   └── resources/project-typologies/  ← Sector reference files (9 typologies)
│
└── /docs-construct-ai/               ← General documentation and guides
```

## Usage Guidelines

### For Agents
1. **Consult typologies** (`/para/resources/project-typologies/`) to understand sector context before making discipline-specific recommendations
2. **Consult discipline domain-knowledge** (`/disciplines/[code]/agent-data/domain-knowledge/`) for discipline-specific expertise and behavioral patterns
3. **Cross-reference** between typology files and discipline knowledge for comprehensive context

### For Knowledge Management
1. **Add new typologies** to `/para/resources/project-typologies/` when covering new construction sectors
2. **Maintain glossaries** within discipline domain-knowledge directories
3. **Archive completed work** appropriately for historical reference

## Maintenance

### Content Curation
- Review and update typology files periodically as sector practices evolve
- Update cross-references when new disciplines or project systems are added
- Keep project-typologies index synchronized with actual files

---

*PARA Knowledge Management System — Version 2.0*
*Cross-Discipline Reference for AI Agent Knowledge Base*
*Last Updated: 2026-03-31*
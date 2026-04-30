# MeasureForge AI File Naming Conventions

## Overview

This document establishes standardized naming conventions for all files and folders within the MeasureForge AI company structure. Consistent naming ensures maintainability, searchability, and collaboration across the measurement intelligence platform.

## General Principles

### ✅ **Descriptive Names**
- Use clear, descriptive names that explain the file's purpose
- Avoid abbreviations unless they are industry-standard
- Use kebab-case for multi-word names (hyphens, not underscores or camelCase)

### ✅ **Consistent Prefixes**
- Company prefix: `measureforge-ai-`
- Follow established patterns for similar content types

### ✅ **Date Formats**
- Use ISO 8601 format: `YYYY-MM-DD`
- Example: `2026-04-22-measurement-platform-scalability-architecture.md`

## Folder Structure Naming

### Company-Level Folders
```
├── governance/           # Company governance and compliance
├── agents/              # Agent organization (27 agents)
├── knowledge/           # Measurement knowledge base
├── projects/            # Development projects
├── operations/          # Operational management
├── plans/               # Strategic planning
├── integration/         # External system integrations
└── skills/              # Specialized skills (120+)
```

### Agent Organization
```
agents/
├── coordinators/        # Strategic orchestration (2 agents)
├── specialists/         # Domain specialists (20 agents)
│   ├── element/         # Building element measurement (11)
│   ├── standards/       # Compliance validation (2)
│   ├── integration/     # CAD system integration (1)
│   └── procurement/     # Procurement pipeline (2)
├── validators/          # Quality assurance (4 agents)
└── creators/            # Content creation (1 agent)
```

## File Naming Conventions by Type

### 📄 **Agent Files (AGENTS.md)**
**Pattern**: `measureforge-ai-{agent-slug}/AGENTS.md`

**Examples**:
```
measureforge-ai-cad-measurement-orchestrator/AGENTS.md
measureforge-ai-architectural-element-specialist/AGENTS.md
measureforge-ai-asaqs-standards-specialist/AGENTS.md
measureforge-ai-measurement-validation-specialist/AGENTS.md
```

**Rules**:
- Always use `AGENTS.md` as filename
- Agent slug follows kebab-case
- Descriptive and specific to agent function

### 📄 **Skill Files (SKILL.md)**
**Pattern**: `{skill-slug}/SKILL.md`

**Examples**:
```
measurement-accuracy-validation/SKILL.md
electrical-compliance-validation/SKILL.md
contour-analysis-processing/SKILL.md
procurement-management/SKILL.md
cad-measurement-intelligence/SKILL.md
```

**Rules**:
- Always use `SKILL.md` as filename
- Skill slug in kebab-case
- Self-organizing through descriptive naming
- No subfolders - flat structure

### 📄 **Plan Documents**
**Pattern**: `YYYY-MM-DD-{descriptive-slug}.md`

**Examples**:
```
2026-04-20-cross-discipline-measurement-platform-implementation-plan.md
2026-04-21-measurement-platform-expansion-roadmap.md
2026-04-22-measurement-platform-scalability-architecture.md
2026-04-22-enhanced-measurement-platform-expansion-roadmap.md
```

**Rules**:
- ISO date format (YYYY-MM-DD)
- Descriptive slug in kebab-case
- Include version indicators when needed (`-v2`, `-enhanced`)
- Place in appropriate subfolder (`plans/implementation/`, `plans/expansion/`)

### 📄 **Knowledge Base Documents**
**Pattern**: `{topic-area}-{specific-focus}.md`

**Examples**:
```
standards-aaqs-compliance-guide.md
methodologies-earthwork-calculations.md
research-ada-app-integration.md
platform-architecture-shared-components.md
```

**Rules**:
- Topic area first, then specific focus
- Kebab-case throughout
- Organized in knowledge/ subfolders

### 📄 **Project Documentation**
**Pattern**: `{PROJECT-ACRONYM}/{deliverable-type}.md`

**Examples**:
```
MEASURE-PLATFORM/
├── implementation-plan.md
├── technical-architecture.md
└── testing-strategy.md

ADA-INTEGRATION/
├── research-findings.md
├── implementation-guide.md
└── testing-results.md
```

**Rules**:
- Use ALL CAPS for project acronyms
- Descriptive deliverable names
- Consistent file types across projects

### 📄 **Integration Documentation**
**Pattern**: `{company-slug}-{integration-type}.md`

**Examples**:
```
knowledgeforge-ai-integration.md
learningforge-ai-integration.md
domainforge-ai-integration.md
integrateforge-ai-cad-integration.md
ada-app-research-integration.md
```

**Rules**:
- Target company slug first
- Integration type description
- Clear indication of integration purpose

## Agent Naming Conventions

### Agent Slug Structure
**Pattern**: `measureforge-ai-{primary-function}-{specialization}`

**Examples**:
```
measureforge-ai-cad-measurement-orchestrator
measureforge-ai-architectural-element-specialist
measureforge-ai-asaqs-standards-specialist
measureforge-ai-contour-analysis-specialist
measureforge-ai-electrical-compliance-specialist
measureforge-ai-measurement-validation-specialist
measureforge-ai-order-generation-specialist
measureforge-ai-contract-tender-specialist
measureforge-ai-visual-overlay-specialist
measureforge-ai-atlas-agent-creator
```

### Agent Categorization
- **Coordinators**: End with `-orchestrator` or `-coordination-specialist`
- **Element Specialists**: End with `-element-specialist` or specific element type
- **Standards Specialists**: Include standards body (`-asaqs-`, `-sans-`)
- **Integration Specialists**: Include target system (`-autocad-`, `-revit-`)
- **Procurement Specialists**: End with procurement action (`-order-generation-`, `-contract-tender-`)
- **Validators**: End with validation type (`-validation-specialist`, `-qa-specialist`)
- **Creators**: End with `-creator` or `-generator`

## Skill Naming Conventions

### Skill Slug Structure
**Pattern**: `{primary-domain}-{specific-capability}`

**Examples**:
```
measurement-accuracy-validation
electrical-compliance-validation
contour-analysis-processing
procurement-management
cad-measurement-intelligence
quality-assurance-measurements
earthwork-volume-calculations
traffic-signal-compliance
```

### Skill Categories (Self-Organizing)
- **Measurement**: `measurement-*`, `quantity-*`, `volume-*`
- **Validation**: `*-validation`, `*-compliance`, `*-verification`
- **Electrical**: `electrical-*`, `conductor-*`, `grounding-*`
- **Civil**: `earthwork-*`, `contour-*`, `concrete-*`
- **Traffic**: `traffic-*`, `signal-*`, `intersection-*`
- **CAD**: `cad-*`, `autocad-*`, `drawing-*`
- **Procurement**: `procurement-*`, `tender-*`, `contract-*`
- **Quality**: `quality-*`, `qa-*`, `audit-*`

## Document Versioning

### Version Indicators
- **Date-based**: `YYYY-MM-DD-{name}.md`
- **Version numbers**: `{name}-v2.md`, `{name}-v3.md`
- **Descriptive**: `{name}-enhanced.md`, `{name}-revised.md`

### When to Version
- **Major updates**: New version number or date
- **Significant changes**: Enhanced, revised, updated
- **Preserve history**: Keep previous versions accessible

## File Organization Rules

### Folder Placement
- **Agents**: `agents/{category}/{agent-slug}/`
- **Skills**: `skills/{skill-slug}/` (flat structure)
- **Plans**: `plans/{category}/YYYY-MM-DD-{name}.md`
- **Knowledge**: `knowledge/{category}/{topic}-{focus}.md`
- **Projects**: `projects/{project-name}/{deliverable}.md`
- **Integration**: `integration/{company-slug}/{integration-docs}.md`

### File Permissions
- **Markdown files**: Standard `.md` extension
- **Scripts**: `.sh`, `.js`, `.py` as appropriate
- **Data files**: `.json`, `.yaml`, `.csv` for structured data
- **Documentation**: Always use Markdown for text documents

## Quality Assurance

### Naming Checklist
- [ ] Descriptive and clear purpose
- [ ] Consistent with established patterns
- [ ] Proper case (kebab-case for multi-word)
- [ ] Appropriate prefixes (measureforge-ai-)
- [ ] Correct file extension
- [ ] Placed in correct folder structure

### Review Process
- **Self-review**: Check against this document before committing
- **Peer review**: Have naming conventions reviewed by team member
- **Automated checks**: Use linting tools for consistency
- **Documentation updates**: Update this document when new patterns emerge

## Examples in Context

### Complete Agent Addition
```
agents/specialists/element/measureforge-ai-new-element-specialist/
└── AGENTS.md

skills/new-element-processing/
└── SKILL.md

knowledge/methodologies/new-element-measurement-guide.md
```

### Complete Project Addition
```
projects/NEW-ELEMENT-MEASUREMENT/
├── 2026-04-22-project-proposal.md
├── technical-requirements.md
├── implementation-plan.md
└── testing-strategy.md
```

### Complete Integration Addition
```
integration/
├── new-system-integration-guide.md
└── new-system/
    ├── api-specification.md
    ├── data-mapping.md
    └── testing-procedures.md
```

## Maintenance

### Regular Reviews
- **Monthly**: Review naming consistency across new files
- **Quarterly**: Update patterns based on evolving needs
- **Annually**: Major review and potential restructuring

### Updates to This Document
- **When**: New patterns emerge or existing patterns change
- **How**: Update with new examples and rules
- **Who**: Architecture team approval required
- **Communication**: Notify all contributors of changes

---

**Document Information**
- **Version**: 1.0
- **Date**: 2026-04-22
- **Author**: MeasureForge AI Architecture Team
- **Purpose**: Establish consistent naming conventions for maintainability and collaboration
- **Review Cycle**: Monthly consistency review
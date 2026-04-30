---
title: Memory System Quick Reference Methodology
author: Construct AI Memory System Team
date: 2026-03-21
version: 1.0
memory_layer: durable_knowledge
para_section: docs/user-guides
gigabrain_tags: quick-reference, memory-system, methodology, prompt-engineering, knowledge-discovery
openstinger_context: rapid-access, memory-system-navigation, efficient-search
last_updated: 2026-03-21
related_docs:
  - docs_construct_ai/Cline Memory System Usage Guide.md
  - WORKSPACE_MEMORY_SYSTEM.md
  - AGENTS.md
---

# Memory System Quick Reference Methodology

## Overview

This methodology provides rapid access to the five key memory system components for optimizing Cline prompts. Use this as your quick reference guide to instantly identify PARA paths, gigabrain tags, memory headers, cross-references, and session continuity elements.

## 1. Reference PARA Structure: Specify docs_construct_ai/para/pages/ paths

### Quick PARA Path Finder

**Step 1: Determine Knowledge Type**
- **Domain Knowledge** → `disciplines/[CODE]_name/`
- **Technical Implementation** → `codebase/[area]/`

**Step 2: Use Code-to-Path Mapping**

#### Discipline Codes (55 Areas)
```
00250 → disciplines/00250-commercial/
00300 → disciplines/00300_construction/
00400 → disciplines/00400_contracts/
00425 → disciplines/00425_contracts-pre-award/
00430 → disciplines/00430_contracts-pre-award/
00435 → disciplines/00435_contracts-post-award/
00825 → disciplines/00825_architectural/
00835 → disciplines/00835_chemical-engineering/
00850 → disciplines/00850_civil-engineering/
00855 → disciplines/00855_geotechnical-engineering/
00860 → disciplines/00860_electrical-engineering/
00870 → disciplines/00870_mechanical-engineering/
00877 → disciplines/00877_sales/
00880 → disciplines/00880_board-of-directors/
00900 → disciplines/00900_document-control/
01000 → disciplines/01000_environmental/
01100 → disciplines/01100_ethics/
01200 → disciplines/01200_finance/
01300 → disciplines/01300_developer/
01400 → disciplines/01400_health/
01500 → disciplines/01500_human-resources/
01700 → disciplines/01700_logistics/
01750 → disciplines/01750_legal/
01800 → disciplines/01800_operations/
01900 → disciplines/01900_procurement/
02000 → disciplines/02000_project-controls/
02025 → disciplines/02025_quantity-surveying/
02200 → disciplines/02200_quality-assurance/
02250 → disciplines/02250_quality-control/
02400 → disciplines/02400_safety/
02500 → disciplines/02500_security/
03000 → disciplines/03000_sundry/
```

#### Codebase Areas (31 Areas)
```
agents → codebase/agents/
analysis → codebase/analysis/
api → codebase/api/
architecture → codebase/architecture/
archive → codebase/archive/
audits → codebase/audits/
backup → codebase/backup/
coding-standards → codebase/coding-standards/
commands → codebase/commands/
database → codebase/database/
deployment → codebase/deployment/
development → codebase/development/
docs → codebase/docs/
errors → codebase/errors/
examples → codebase/examples/
guides → codebase/guides/
infrastructure → codebase/infrastructure/
integrations → codebase/integrations/
maintenance → codebase/maintenance/
mobile → codebase/mobile/
monitoring → codebase/monitoring/
other-apps → codebase/other-apps/
performance → codebase/performance/
procedures → codebase/procedures/
reports → codebase/reports/
schema → codebase/schema/
security → codebase/security/
testing → codebase/testing/
tools → codebase/tools/
workflows → codebase/workflows/
```

**Step 3: Construct Full Path**
```
docs_construct_ai/para/pages/disciplines/[CODE]_[name]/
docs_construct_ai/para/pages/codebase/[area]/
```

### PARA Path Quick Lookup Table

| Topic Area | PARA Path |
|------------|-----------|
| Procurement | `docs_construct_ai/para/pages/disciplines/01900_procurement/` |
| Safety | `docs_construct_ai/para/pages/disciplines/02400_safety/` |
| Developer Procedures | `docs_construct_ai/para/pages/disciplines/01300_developer/` |
| Coding Standards | `docs_construct_ai/para/pages/codebase/coding-standards/` |
| Guides | `docs_construct_ai/para/pages/codebase/guides/` |
| Workflows | `docs_construct_ai/para/pages/codebase/workflows/` |
| Procedures | `docs_construct_ai/para/pages/codebase/procedures/` |
| Security | `docs_construct_ai/para/pages/codebase/security/` |

## 2. Include Gigabrain Tags: Request content filtered by relevant tags

### Tag Category Quick Reference

**Step 1: Identify Content Type**
- **Discipline Areas**: `[discipline-code]-[topic]` (e.g., `01900-procurement`, `02400-safety`)
- **Technical Areas**: `[area]-[specialization]` (e.g., `agents-ai`, `guides-development`)
- **Cross-Cutting**: `codebase`, `disciplines`, `documentation`, `procedures`

**Step 2: Use Tag Mapping**

#### Discipline Tags
```
01900_procurement → procurement-practices, supplier-management
02400_safety → safety-practices, risk-management, compliance
01300_developer → developer-practices, coding-standards, code-review
00400_contracts → contracts-practices, legal-compliance, procurement
00850_civil-engineering → civil-engineering-practices, construction
00860_electrical-engineering → electrical-engineering-practices
00870_mechanical-engineering → mechanical-engineering-practices
01200_finance → finance-practices, budget-management
01500_human-resources → hr-practices, personnel-management
02200_quality-assurance → qa-practices, quality-control
```

#### Codebase Tags
```
agents → agents, ai-automation, agent-development
guides → guides, documentation, implementation-guides
workflows → workflows, automation, process-management
procedures → procedures, operational-procedures, methodology
security → security, compliance, safety-practices
analysis → analysis, research, system-analysis
mobile → mobile, cross-platform, responsive-design
testing → testing, quality-assurance, validation
development → development, software-engineering, coding-practices
docs → docs, documentation, technical-writing
```

#### Universal Tags
```
codebase, disciplines, documentation, procedures, compliance, safety, quality, development, operations, management
```

**Step 3: Construct Tag Search**
```
Search gigabrain tags for "[primary-tag], [secondary-tag], [context-tag]"
```

### Tag Search Quick Lookup

| Topic | Recommended Tags |
|-------|------------------|
| Procurement | `01900_procurement, procurement-practices, supplier-management` |
| Safety | `02400_safety, safety-practices, risk-management, compliance` |
| Development | `01300_developer, coding-standards, code-review, development` |
| Security | `security, compliance, safety-practices, cybersecurity` |
| Quality | `02200_quality-assurance, qa-practices, quality-control, testing` |
| Documentation | `docs, documentation, technical-writing, guides` |
| Workflows | `workflows, automation, process-management, procedures` |
| Agents | `agents, ai-automation, agent-development, ai-systems` |

## 3. Request Memory Headers: Ask for YAML frontmatter context and relationships

### Memory Header Quick Reference

**Step 1: Request Header Components**
```
Include memory header context showing:
- memory_layer: [layer type]
- para_section: [PARA path]
- gigabrain_tags: [tag list]
- related_docs: [cross-references]
- last_updated: [date]
```

**Step 2: Use Header Analysis**
- **memory_layer**: `durable_knowledge` (most common)
- **para_section**: Matches PARA navigation path
- **gigabrain_tags**: Comma-separated tag list
- **related_docs**: Array of related document paths
- **last_updated**: ISO date format

**Step 3: Header Integration Request**
```
Include the complete YAML frontmatter and explain the relationships shown in related_docs
```

### Header Analysis Quick Guide

| Header Field | What It Shows | How to Use |
|--------------|---------------|------------|
| `memory_layer` | Knowledge durability | `durable_knowledge` = permanent reference |
| `para_section` | PARA organization | Navigation path for related content |
| `gigabrain_tags` | Search categories | Related content discovery |
| `related_docs` | Cross-references | Connected documents and procedures |
| `last_updated` | Freshness | Content currency assessment |

## 4. Cross-Reference Analysis: Request identification of related documents

### Cross-Reference Quick Methodology

**Step 1: Request Analysis Types**
```
Identify cross-references by:
- Related disciplines (same domain)
- Supporting procedures (how-to guides)
- Related implementations (similar patterns)
- Dependent systems (integration points)
```

**Step 2: Use Reference Mapping**

#### Discipline Cross-References
```
Procurement (01900) ↔ Contracts (00400) ↔ Finance (01200)
Safety (02400) ↔ Quality (02200) ↔ Operations (01800)
Development (01300) ↔ Testing (02250) ↔ Deployment (infrastructure)
```

#### Codebase Cross-References
```
agents ↔ procedures/agent-development/
workflows ↔ procedures/workflow-management/
guides ↔ docs ↔ examples
security ↔ procedures/security-privacy/
```

**Step 3: Request Specific Analysis**
```
Map cross-references between [primary area] and related [secondary areas]
```

### Cross-Reference Quick Lookup

| Primary Area | Related Areas | Cross-Reference Pattern |
|--------------|---------------|-------------------------|
| Procurement | Contracts, Finance, Quality | `01900_procurement ↔ 00400_contracts ↔ 01200_finance` |
| Safety | Quality, Operations, HR | `02400_safety ↔ 02200_quality-assurance ↔ 01800_operations` |
| Development | Testing, Security, Deployment | `01300_developer ↔ testing ↔ security ↔ infrastructure` |
| Security | Compliance, Audit, Procedures | `security ↔ audits ↔ procedures/security-privacy/` |

## 5. Session Continuity: Reference previous work and established patterns

### Session Continuity Quick Reference

**Step 1: Check Session Context**
```
Reference our previous work by checking:
- memory/YYYY-MM-DD.md for today's session notes
- Related memory headers from previous interactions
- Established patterns from similar tasks
```

**Step 2: Use Continuity Elements**

#### Session Files
```
memory/2026-03-21.md (today's session)
memory/2026-03-20.md (yesterday's context)
memory/2026-03-19.md (recent work patterns)
```

#### Pattern Recognition
```
Similar implementations in:
- docs_construct_ai/para/pages/codebase/[area]/
- Previous [task type] using [methodology]
- Established procedures from [discipline]
```

**Step 3: Continuity Request**
```
Build on our previous [task] work by referencing [session files] and applying established patterns from [related work]
```

### Continuity Quick Lookup

| Task Type | Session Reference | Pattern Source |
|-----------|-------------------|----------------|
| Development | `memory/YYYY-MM-DD.md` | `codebase/development/`, `disciplines/01300_developer/` |
| Documentation | Previous docs tasks | `codebase/docs/`, `codebase/guides/` |
| Security Review | Security-related sessions | `codebase/security/`, `disciplines/02400_safety/` |
| Process Implementation | Workflow sessions | `codebase/workflows/`, `codebase/procedures/` |
| Code Review | Previous reviews | `disciplines/01300_developer/`, `codebase/coding-standards/` |

## Integrated Quick Reference Methodology

### 5-Step Rapid Memory System Integration

**Step 1: Identify Topic Area**
- Determine if domain knowledge (discipline) or technical implementation (codebase)
- Use code/path mapping above

**Step 2: Construct PARA Path**
- `docs_construct_ai/para/pages/disciplines/[CODE]_[name]/` OR
- `docs_construct_ai/para/pages/codebase/[area]/`

**Step 3: Select Gigabrain Tags**
- Choose 2-3 relevant tags from category mappings
- Include context tags (documentation, procedures, etc.)

**Step 4: Plan Cross-References**
- Identify 2-3 related areas using cross-reference mapping
- Include both discipline and codebase connections

**Step 5: Add Session Continuity**
- Reference recent `memory/YYYY-MM-DD.md` files
- Link to previous similar work patterns

### Quick Prompt Template

```
Using Construct AI memory system:

🔍 PARA Navigation: docs_construct_ai/para/pages/[path]/
🏷️  Gigabrain Tags: [tag1, tag2, tag3]
📄 Memory Headers: Include YAML context and relationships
🔗 Cross-References: Map connections to [related areas]
📅 Session Continuity: Reference memory/YYYY-MM-DD.md and previous [task type] patterns

[Your specific task requirements]
```

### Emergency Quick Reference

**If you need instant access:**
1. **PARA Path**: `docs_construct_ai/para/pages/disciplines/` or `codebase/`
2. **Tags**: Use area name + "-practices" (e.g., "safety-practices", "procurement-practices")
3. **Headers**: Request "YAML frontmatter with related_docs"
4. **Cross-refs**: Ask for "related disciplines and procedures"
5. **Continuity**: Reference "memory/YYYY-MM-DD.md for session context"

## Implementation Checklist

### Pre-Prompt Preparation
- [ ] **Topic Identified**: Discipline or codebase area determined
- [ ] **PARA Path**: Correct path constructed using mapping
- [ ] **Tags Selected**: 2-3 relevant gigabrain tags chosen
- [ ] **Cross-References**: Related areas identified
- [ ] **Session Context**: Recent work referenced

### Prompt Execution
- [ ] **PARA Reference**: Path included in prompt
- [ ] **Tag Filtering**: Gigabrain tags specified
- [ ] **Header Request**: YAML context requested
- [ ] **Cross-Reference**: Related document analysis requested
- [ ] **Continuity**: Previous work referenced

### Post-Prompt Optimization
- [ ] **Context Building**: Accumulate knowledge across interactions
- [ ] **Pattern Recognition**: Note successful reference patterns
- [ ] **Shortcut Development**: Create personal quick-reference mappings
- [ ] **Feedback Loop**: Refine methodology based on results

This methodology transforms memory system integration from a complex process into a rapid, systematic approach that can be applied in seconds to any Cline interaction.
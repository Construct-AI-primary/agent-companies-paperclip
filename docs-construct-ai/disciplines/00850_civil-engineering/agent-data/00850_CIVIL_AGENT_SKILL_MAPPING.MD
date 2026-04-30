---
title: 00850 Civil Engineering Agent-to-Skill Mapping
description: Maps all 26 civil engineering agents to their primary and supporting skills across the domainforge_ai skill set
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/agent-data
gigabrain_tags: civil-engineering, agent-mapping, skill-assignments, domainforge-ai
openstinger_context: agent-skill-relationships
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/00850_AGENTS-REGISTRY-SUMMARY.MD
  - docs_construct_ai/skills/domainforge_ai/civil-dwg-processing/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-site-assessment/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-design-development/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-documentation/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-quality-assurance/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-mobile-field-ops/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-ui-card-system/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-quantity-takeoff/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-desktop-mobile-sync/SKILL.md
  - docs_construct_ai/skills/domainforge_ai/civil-tender-preparation/SKILL.md
---

# 00850 Civil Engineering Agent-to-Skill Mapping

## Overview

Maps all 26 civil engineering agents to their primary and supporting skills. Each skill has one primary agent responsible for execution and 2-4 supporting agents providing specialized capabilities.

---

## Agent Summary by Skill

### Skill: civil-dwg-processing
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-DWG-001 | deep-agents | DWG file cleaning, extraction, structural JSON output |
| Supporting | CE-LIB-001 | OpenClaw | Provenance tracking and knowledge base updates |
| Supporting | CE-QA-001 | OpenClaw | Extraction validation and quality checking |

### Skill: civil-site-assessment
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-SITE-001 | OpenClaw | Site data collection, feasibility analysis, go/no-go |
| Supporting | CE-GEO-001 | deep-agents | Geotechnical interpretation and foundation advice |
| Supporting | CE-GIS-001 | deep-agents | Spatial analysis and environmental constraint mapping |
| Supporting | CE-FIELD-001 | OpenClaw | Mobile field data collection and GPS survey |
| Supporting | CE-ENV-001 | deep-agents | Environmental impact and constraint identification |

### Skill: civil-design-development
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-DESIGN-001 | OpenClaw | Design options analysis, multi-criteria selection |
| Supporting | CE-STRUCT-001 | deep-agents | Structural analysis and member design |
| Supporting | CE-HYDRO-001 | deep-agents | Hydraulic analysis, pipe sizing, detention volumes |
| Supporting | CE-GEO-001 | deep-agents | Geotechnical design (retaining walls, foundations) |
| Supporting | CE-TRAFFIC-001 | deep-agents | Traffic flow and capacity analysis |

### Skill: civil-documentation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-DOCS-001 | OpenClaw | Document generation, template filling, version control |
| Supporting | CE-LIB-001 | OpenClaw | Document organization, cross-reference validation |
| Supporting | CE-PROMPT-001 | OpenClaw | Template optimization and prompt engineering |
| Supporting | CE-QA-001 | OpenClaw | Documentation quality review and consistency checking |

### Skill: civil-quality-assurance
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-QA-001 | OpenClaw | Compliance checking, NCR/RFI processing, design review |
| Supporting | CE-QC-001 | JS Swarm | Construction quality control and inspection |
| Supporting | CE-RFI-001 | JS Swarm | RFI routing, tracking, and distribution |
| Supporting | Reviewer | DevForge | Code standards and best practices validation |

### Skill: civil-mobile-field-ops
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-MOBILE-001 | OpenClaw | Mobile workflow orchestration and offline management |
| Primary | CE-FIELD-001 | OpenClaw | Field data collection, GPS, photos, voice notes |
| Supporting | CE-QC-001 | JS Swarm | Digital inspection and NCR auto-generation |
| Supporting | CE-PROGRESS-001 | JS Swarm | Progress monitoring and earned value analysis |
| Supporting | CE-RFI-001 | JS Swarm | Field RFI submission with photos and location data |

### Skill: civil-ui-card-system
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-ORCH-001 | OpenClaw | Dependency management, phase gates, status tracking |
| Supporting | CE-LIB-001 | OpenClaw | Dashboard data management and reporting |
| Supporting | CE-PROGRESS-001 | JS Swarm | Card progress metrics and age tracking |
| Supporting | CE-PROMPT-001 | OpenClaw | Card status and agent notification processing |

### Skill: civil-quantity-takeoff
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-QS-001 | deep-agents | DWG quantity extraction, BOQ assembly, pricing |
| Supporting | CE-DWG-001 | deep-agents | DWG feature extraction for quantity sources |
| Supporting | CE-DOCS-001 | OpenClaw | BOQ document assembly and formatting |
| Supporting | CE-PROC-001 | JS Swarm | Material schedule generation and procurement linking |

### Skill: civil-desktop-mobile-sync
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-MOBILE-001 | OpenClaw | Mobile-side sync orchestration and conflict detection |
| Primary | CE-ORCH-001 | OpenClaw | Cross-platform handoff and data consistency |
| Supporting | CE-PROGRESS-001 | JS Swarm | Progress data sync and earned value consistency |
| Supporting | CE-COLLAB-001 | JS Swarm | Real-time bidirectional communication sync |

### Skill: civil-tender-preparation
| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Primary | CE-PROC-001 | JS Swarm | Tender compilation, issuance, bid evaluation |
| Supporting | CE-CONTRACT-001 | JS Swarm | GCC/PCC conditions of contract |
| Supporting | CE-COLLAB-001 | JS Swarm | Tender Q&A, addenda management, contractor communication |
| Supporting | CE-QS-001 | deep-agents | BOQ and engineer's estimate support |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Supporting Skill(s) | Environments | Total Skills |
|-------|-----------------|---------------------|-------------|-------------|
| CE-ORCH-001 | civil-ui-card-system | civil-desktop-mobile-sync | OpenClaw | 2 |
| CE-DWG-001 | civil-dwg-processing | civil-quantity-takeoff | deep-agents | 2 |
| CE-DESIGN-001 | civil-design-development | — | OpenClaw | 1 |
| CE-SITE-001 | civil-site-assessment | — | OpenClaw | 1 |
| CE-DOCS-001 | civil-documentation | civil-quantity-takeoff | OpenClaw | 2 |
| CE-QA-001 | civil-quality-assurance | civil-dwg-processing, civil-documentation | OpenClaw | 3 |
| CE-MOBILE-001 | civil-mobile-field-ops, civil-desktop-mobile-sync | — | OpenClaw | 2 |
| CE-FIELD-001 | civil-mobile-field-ops | civil-site-assessment | OpenClaw | 2 |
| CE-QS-001 | civil-quantity-takeoff | civil-tender-preparation | deep-agents | 2 |
| CE-PROC-001 | civil-tender-preparation | civil-quantity-takeoff | JS Swarm | 2 |
| CE-GEO-001 | — | civil-site-assessment, civil-design-development | deep-agents | 2 |
| CE-HYDRO-001 | — | civil-design-development | deep-agents | 1 |
| CE-STRUCT-001 | — | civil-design-development | deep-agents | 1 |
| CE-TRAFFIC-001 | — | civil-design-development | deep-agents | 1 |
| CE-GIS-001 | — | civil-site-assessment | deep-agents | 1 |
| CE-ENV-001 | — | civil-site-assessment | deep-agents | 1 |
| CE-QC-001 | — | civil-quality-assurance, civil-mobile-field-ops | JS Swarm | 2 |
| CE-RFI-001 | — | civil-quality-assurance, civil-mobile-field-ops | JS Swarm | 2 |
| CE-PROGRESS-001 | — | civil-mobile-field-ops, civil-ui-card-system, civil-desktop-mobile-sync | JS Swarm | 3 |
| CE-COLLAB-001 | — | civil-desktop-mobile-sync, civil-tender-preparation | JS Swarm | 2 |
| CE-CONTRACT-001 | — | civil-tender-preparation | JS Swarm | 1 |
| CE-LIB-001 | — | civil-dwg-processing, civil-documentation, civil-ui-card-system, civil-site-assessment | OpenClaw | 4 |
| CE-PROMPT-001 | — | civil-documentation, civil-ui-card-system | OpenClaw | 2 |
| Reviewer | — | civil-quality-assurance | DevForge | 1 |

---

## Cross-Team Agent Assignments

### OpenClaw Team (Orchestration, Workflow, Processing)
- CE-ORCH-001, CE-DWG-001, CE-DESIGN-001, CE-SITE-001, CE-DOCS-001, CE-QA-001, CE-MOBILE-001, CE-FIELD-001, CE-LIB-001, CE-PROMPT-001
- **Total: 10 agents**

### deep-agents Team (Complex Analysis, Specialized Functions)
- CE-STRUCT-001, CE-HYDRO-001, CE-GEO-001, CE-GIS-001, CE-TRAFFIC-001, CE-ENV-001, CE-QS-001
- **Total: 7 agents**

### JS Swarm Team (Transaction, Real-time, Mobile)
- CE-PROC-001, CE-CONTRACT-001, CE-QC-001, CE-COLLAB-001, CE-RFI-001, CE-PROGRESS-001
- **Total: 6 agents**

### DevForge Team (Code Quality, Standards)
- Reviewer
- **Total: 1 agent**

**Grand Total: 24 agents mapped to 10 skills**

---

## Unmapped Agents

The following 2 agents from the registry are documented but have no dedicated skill mapping yet:
- CE-PROMPT-001 (mapped to skills in supporting role)
- CE-COLLAB-001 (mapped to skills in supporting role)

All 26 agents are accounted for in either primary or supporting roles.

---

*00850 Civil Engineering Agent-to-Skill Mapping — Version 1.0*
*Last Updated: 2026-03-31*
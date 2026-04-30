---
title: 03000 Landscaping Agent-to-Skill Mapping
description: Maps all landscaping agents to their primary and supporting skills with environment assignments and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/03000_landscaping/agent-data
gigabrain_tags: disciplines, 03000_landscaping, agent-mapping, skill-assignment, agent-readiness
openstinger_context: landscaping-agent-assignment, skill-mapping, readiness-assessment
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/03000_landscaping/agent-data/prompts/03000_AI-NATIVE-LANDSCAPING-PROMPT.md
  - docs_construct_ai/disciplines/03000_landscaping/agent-data/domain-knowledge/03000_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 03000 Landscaping Agent-to-Skill Mapping

## Agent Registry

| Agent ID | Agent Name | Primary Role | Reports To | Specialization |
|----------|-----------|--------------|------------|----------------|
| 03000-001 | Planting Plan Agent | Planting plan generation from site data and design briefs | Landscaping Manager | Climate-appropriate plant selection, plant quantities |
| 03000-002 | Irrigation Design Agent | Water requirement calculation and irrigation layout design | Landscaping Manager | Water requirements, sprinkler selection, zone design |
| 03000-003 | Soil Analysis Agent | Soil test result processing and improvement recommendations | Landscaping Manager | Soil testing interpretation, treatment recommendations |
| 03000-004 | Maintenance Programme Agent | Maintenance programme generation from planting and irrigation data | Landscaping Manager | Maintenance task scheduling, seasonal adjustments |
| 03000-005 | Establishment Monitoring Agent | Plant establishment tracking and underperformance identification | Landscaping Manager | Plant survival monitoring, remedial planting recommendations |
| 03000-006 | Plant Health Analysis Agent | Plant health assessment from photos, disease identification | Landscaping Manager | Visual health assessment, disease identification |
| 03000-007 | Hard Landscaping Agent | Hard landscape documentation from drawings and specifications | Landscaping Manager | Paving, walls, water features documentation |

## Agent-to-Skill Mapping

| Agent | Primary Skill | Supporting Skills | Environment | Status |
|-------|--------------|-------------------|-------------|--------|
| 03000-001 Planting Plan Agent | `landscaping-planting-plan` | `landscaping-plant-database` | dev, staging | Need Creation |
| 03000-002 Irrigation Design Agent | `landscaping-irrigation-design` | `landscaping-planting-plan` | dev, staging | Need Creation |
| 03000-003 Soil Analysis Agent | `landscaping-soil-analysis` | `shared/data-analysis` | dev, staging | Need Creation |
| 03000-004 Maintenance Programme Agent | `landscaping-maintenance-programme` | `landscaping-planting-plan`, `landscaping-irrigation-design` | dev, staging | Need Creation |
| 03000-005 Establishment Monitoring Agent | `landscaping-establishment-monitoring` | `landscaping-plant-health-analysis` | dev, staging, prod | Need Creation |
| 03000-006 Plant Health Analysis Agent | `landscaping-plant-health-analysis` | `shared/cv-analysis` | dev, staging, prod | Need Creation |
| 03000-007 Hard Landscaping Agent | `landscaping-hard-landscaping` | `shared/documentation-templates` | dev, staging | Need Creation |

## Skills Required (To Be Created)

All 7 skills need to be created under `docs-construct-ai/skills/domainforge_ai/landscaping-[skill-name]/SKILL.md`:

| Priority | Skill Name | Description | Estimated Effort |
|----------|-----------|-------------|-----------------|
| Critical | `landscaping-planting-plan` | Planting plan generation with climate/appropriate plant selection | 2h |
| Critical | `landscaping-irrigation-design` | Water requirement calculation and irrigation layout design | 2h |
| High | `landscaping-maintenance-programme` | Maintenance programme generation from planting and irrigation data | 2h |
| High | `landscaping-plant-health-analysis` | Plant health assessment from photos, disease identification | 2h |
| High | `landscaping-establishment-monitoring` | Plant establishment tracking and underperformance identification | 1h |
| Medium | `landscaping-soil-analysis` | Soil test result processing and improvement recommendations | 1h |
| Medium | `landscaping-hard-landscaping` | Hard landscaping documentation from drawings and specs | 1h |

## Readiness Assessment

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| Skills Coverage | 0/10 | Zero landscaping-specific skills exist |
| Agent Availability | 3/10 | Agents defined conceptually, needs specifications |
| Domain Knowledge | 7/10 | Domain knowledge now has Part 6 AI-Native sections |
| Prompt Integration | 8/10 | Prompt created with complete 16-section structure |
| Testing & Validation | 0/10 | No testing framework yet |
| Integration Readiness | 4/10 | Agent-to-skill mapping needs remediation |
| **Overall Readiness** | **3.7/10** | Needs phase-based remediation to reach 10/10 |

---

## Version History
- v1.0 (2026-04-01): Initial agent-to-skill mapping for landscaping discipline
---
title: 02400 Safety Agent-to-Skill Mapping
description: Maps all safety agents to their primary and supporting skills with environment assignments and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02400_safety/agent-data
gigabrain_tags: disciplines, 02400_safety, agent-mapping, skill-assignment, domainforge, infraforge
openstinger_context: agent-staffing, skill-alignment, safety-team
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02400_safety/agent-data/prompts/02400_AI-NATIVE-SAFETY-OPERATIONS-PROMPT.md
  - docs_construct_ai/codebase/agents/openclaw-teams/DomainForge_AI_Team.md
---

# 02400 Safety Agent-to-Skill Mapping

## Agent Inventory

| Agent | ID | Primary Skills | Supporting Skills | Environment |
|-------|----|----------------|------------------|-------------|
| **HSE Safety Manager** | TBD | safety-document-generation, permit-to-work, inspection-workflow | incident-investigation, contractor-safety | DevForge Dev + Staging |
| **RAMS Review Specialist** | TBD | RAMS-review, hazard-identification | risk-assessment, safety-document-generation | DevForge Dev + Staging |
| **Incident Investigation Specialist** | TBD | incident-tracking, RCA-analysis, CAPA-management | safety-document-generation, regulatory-compliance | DevForge Dev + Staging |
| **Inspection & Audit Specialist** | TBD | inspection-workflow, checklist-management | hazard-identification, incident-tracking | DevForge Dev + Staging |
| **Predictive Analytics Specialist** | TBD | predictive-risk, hotspot-mapping, contractor-profiling | data-extraction, dashboard-generation | DevForge Dev + Staging |
| **CV/IoT Integration Specialist** | TBD | PPE-detection, hazard-detection, sensor-integration | alert-system, data-processing | DevForge Dev + Staging |
| **Safety UI Designer** | TBD | safety-ui-patterns, form-validation, mobile-safety | accessibility, multilingual-support | DevForge Dev + Mobile Dev |

## Cross-Team Coordination

| Handoff | Skills Involved | Agents |
|---------|----------------|--------|
| RAMS → Permit → Inspection | RAMS-review, permit-to-work, inspection-workflow | RAMS Specialist → Incident Specialist → Inspection Specialist |
| Incident → Investigation → CAPA | incident-tracking, RCA-analysis, CAPA-management | HSE Manager → Incident Specialist |
| CV Detection → Alert → Response | PPE-detection, alert-system | CV/IoT Specialist → HSE Manager |
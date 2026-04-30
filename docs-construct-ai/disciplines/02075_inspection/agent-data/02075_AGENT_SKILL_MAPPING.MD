---
title: 02075 Inspection Agent-to-Skill Mapping
description: Maps all Inspection discipline agents to their primary and supporting skills, environment assignments, and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02075_inspection/agent-data
gigabrain_tags: disciplines, 02075_inspection, agent-mapping, skill-assignment, agent-readiness
openstinger_context: inspection-agent-assignment, skill-mapping, readiness-assessment
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02075_inspection/agent-data/prompts/02075_AI-NATIVE-INSPECTION-PROMPT.md
  - docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02075 Inspection Agent-to-Skill Mapping

## Agent Registry

| Agent ID | Agent Name | Primary Role | Reports To | Specialization |
|----------|-----------|--------------|------------|----------------|
| 02075-001 | Inspection Planner | ITP generation and inspection planning | Lead Inspector | Inspection plan design, hold point definition |
| 02075-002 | MTR Verifier | Material test report review and verification | Inspection Planner | Material specification, certificate parsing |
| 02075-003 | Dimensional Inspector | Dimensional measurement processing and tolerance checking | Lead Inspector | Survey data, dimensional control, alignment |
| 02075-004 | NDT Coordinator | NDT scheduling and coverage tracking | Lead Inspector | NDT certification, coverage verification |
| 02075-005 | Coating Inspector | Coating and painting inspection, DFT analysis | Lead Inspector | DFT readings, surface preparation assessment |
| 02075-006 | NCR Drafter | Non-conformance report generation from findings | Lead Inspector | Quality reporting, specification violations |
| 02075-007 | Hold Point Manager | Hold point status tracking and clearance generation | Lead Inspector | Clearance certificates, status monitoring |
| 02075-008 | Code Compliance Agent | Code and specification compliance verification | Lead Inspector | AWS, ASME, API knowledge, clause reference |

## Agent-to-Skill Mapping

| Agent | Primary Skill | Supporting Skills | Environment | Status |
|-------|--------------|-------------------|-------------|--------|
| 02075-001 Inspection Planner | `inspection-itp-generation` | `shared/documentation-templates` | dev, staging, prod | Need Creation |
| 02075-002 MTR Verifier | `inspection-mtr-review` | `inspection-code-compliance` | dev, staging, prod | Need Creation |
| 02075-003 Dimensional Inspector | `inspection-dimensional-analysis` | `inspection-mtr-review` | dev, staging, prod | Need Creation |
| 02075-004 NDT Coordinator | `inspection-ndt-coordination` | `inspection-hold-point-management` | dev, staging, prod | Need Creation |
| 02075-005 Coating Inspector | `inspection-coating-verification` | `shared/cv-analysis` | dev, staging, prod | Need Creation |
| 02075-006 NCR Drafter | `inspection-ncr-generation` | `inspection-code-compliance` | dev, staging, prod | Need Creation |
| 02075-007 Hold Point Manager | `inspection-hold-point-management` | `inspection-itp-generation` | dev, staging, prod | Need Creation |
| 02075-008 Code Compliance Agent | `inspection-code-compliance` | `shared/knowledge-retrieval` | dev, staging | Need Creation |

## Skills Required (To Be Created)

All 8 skills need to be created under `docs-construct-ai/skills/domainforge_ai/inspection-[skill-name]/SKILL.md`:

| Priority | Skill Name | Description | Estimated Effort |
|----------|-----------|-------------|-----------------|
| Critical | `inspection-itp-generation` | ITP generation from work packages and specifications | 2h |
| Critical | `inspection-mtr-review` | Material test report parsing and spec comparison | 2h |
| Critical | `inspection-dimensional-analysis` | Measurement processing and tolerance verification | 2h |
| High | `inspection-ndt-coordination` | NDT scheduling, certification, coverage tracking | 2h |
| High | `inspection-code-compliance` | Code compliance checking against ASME, AWS, API | 2h |
| High | `inspection-coating-verification` | DFT processing, surface preparation assessment | 1h |
| Medium | `inspection-ncr-generation` | Non-conformance report drafting from findings | 1h |
| Medium | `inspection-hold-point-management` | Hold point tracking, clearance certificates | 1h |

## Readiness Assessment

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| Skills Coverage | 0/10 | Zero inspection-specific skills exist |
| Agent Availability | 3/10 | Agents defined conceptually, needs specifications |
| Domain Knowledge | 7/10 | Domain knowledge now has Part 7 AI-Native sections |
| Prompt Integration | 8/10 | Prompt created with complete 16-section structure |
| Testing & Validation | 0/10 | No testing framework yet |
| Integration Readiness | 4/10 | Agent-to-skill mapping needs remediation |
| **Overall Readiness** | **3.7/10** | Needs phase-based remediation to reach 10/10 |

---

## Version History
- v1.0 (2026-04-01): Initial agent-to-skill mapping for Inspection discipline
---
title: 02050 Information Technology Agent-to-Skill Mapping
description: Maps all IT discipline agents to their primary and supporting skills, environment assignments, and cross-team coordination
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02050_information-technology/agent-data
gigabrain_tags: disciplines, 02050_information-technology, agent-mapping, skill-assignment, agent-readiness
openstinger_context: it-agent-assignment, skill-mapping, readiness-assessment
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02050_information-technology/agent-data/prompts/02050_AI-NATIVE-INFORMATION-TECHNOLOGY-PROMPT.md
  - docs_construct_ai/disciplines/02050_information-technology/agent-data/domain-knowledge/02050_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02050 Information Technology Agent-to-Skill Mapping

## Agent Registry

| Agent ID | Agent Name | Primary Role | Reports To | Specialization |
|----------|-----------|--------------|------------|----------------|
| 02050-001 | IT System Architect | Core infrastructure design | Engineering Director | System architecture, component design |
| 02050-002 | Error Detective | Error discovery & triage | IT System Architect | Log analysis, pattern detection |
| 02050-003 | Code Forge | Code generation & validation | IT System Architect | Template-based code scaffolding |
| 02050-004 | Log Analyst | Log aggregation & analysis | Error Detective | Pattern detection, anomaly identification |
| 02050-005 | Doc Generator | Documentation generation | IT System Architect | Structured documentation from code |
| 02050-006 | AI Orchestrator | Multi-agent coordination | IT System Architect | Agent handoffs, workflow management |
| 02050-007 | Security Auditor | Security analysis & validation | IT System Architect | RLS policies, access control |
| 02050-008 | Performance Monitor | System monitoring & analytics | Error Detective | Metrics tracking, trend analysis |
| 02050-009 | ChatBot Engineer | Conversational AI management | IT System Architect | Chatbot configuration, prompt tuning |
| 02050-010 | Data Pipeline Builder | Data integration & ETL | IT System Architect | API integration, data synchronization |

## Agent-to-Skill Mapping

| Agent | Primary Skill | Supporting Skills | Environment | Status |
|-------|--------------|-------------------|-------------|--------|
| 02050-001 IT System Architect | `it-system-architecture-design` | `shared/systematic-debugging`, `shared/database-schema-management` | dev, staging | Need Creation |
| 02050-002 Error Detective | `it-error-discovery-classification` | `shared/build-error-fix`, `shared/systematic-debugging` | dev, staging, prod | Need Creation |
| 02050-003 Code Forge | `it-code-generation-scaffolding` | `shared/test-driven-development`, `shared/testing-verification` | dev, staging | Need Creation |
| 02050-004 Log Analyst | `it-log-analysis-monitoring` | `it-error-discovery-classification` | dev, staging, prod | Need Creation |
| 02050-005 Doc Generator | `it-documentation-generation` | `domainforge_ai/civil-documentation` | dev, staging | Need Creation |
| 02050-006 AI Orchestrator | `it-agent-coordination` | `all-domainforge_ai/*` | dev, staging | Need Creation |
| 02050-007 Security Auditor | `it-security-audit-validation` | `shared/systematic-debugging` | dev, staging, prod | Need Creation |
| 02050-008 Performance Monitor | `it-performance-monitoring-analytics` | `it-log-analysis-monitoring` | dev, staging, prod | Need Creation |
| 02050-009 ChatBot Engineer | `it-chatbot-configuration` | `domainforge_ai/voice-command-integration`, `procurement-data-extraction` | dev, staging | Need Creation |
| 02050-010 Data Pipeline Builder | `it-data-pipeline-integration` | `domainforge_ai/data-requirements-ui-design`, `infraforge_ai/supply-chain-integration` | dev, staging | Need Creation |

## Skills Required (To Be Created)

All 10 skills need to be created under `docs-construct-ai/skills/domainforge_ai/it-[skill-name]/SKILL.md`:

| Priority | Skill Name | Description | File Path | Estimated Effort |
|----------|-----------|-------------|-----------|-----------------|
| Critical | `it-error-discovery-classification` | Error detection, classification, prioritization | `skills/domainforge_ai/it-error-discovery-classification/SKILL.md` | 2h |
| Critical | `it-system-architecture-design` | System component design, architecture patterns | `skills/domainforge_ai/it-system-architecture-design/SKILL.md` | 2h |
| Critical | `it-code-generation-scaffolding` | Template-based code generation with validation | `skills/domainforge_ai/it-code-generation-scaffolding/SKILL.md` | 2h |
| High | `it-log-analysis-monitoring` | Log aggregation, pattern detection, anomaly identification | `skills/domainforge_ai/it-log-analysis-monitoring/SKILL.md` | 2h |
| High | `it-security-audit-validation` | RLS policy checking, security validation | `skills/domainforge_ai/it-security-audit-validation/SKILL.md` | 2h |
| High | `it-documentation-generation` | Auto-documentation from code and system state | `skills/domainforge_ai/it-documentation-generation/SKILL.md` | 1h |
| Medium | `it-performance-monitoring-analytics` | System metrics tracking, trend analysis | `skills/domainforge_ai/it-performance-monitoring-analytics/SKILL.md` | 1h |
| Medium | `it-agent-coordination` | Multi-agent workflow orchestration | `skills/domainforge_ai/it-agent-coordination/SKILL.md` | 2h |
| Medium | `it-chatbot-configuration` | Chatbot setup, prompt tuning, state-aware assistants | `skills/domainforge_ai/it-chatbot-configuration/SKILL.md` | 1h |
| Medium | `it-data-pipeline-integration` | API integration, data synchronization, ETL | `skills/domainforge_ai/it-data-pipeline-integration/SKILL.md` | 2h |

## Existing Shared Skills Available

| Skill | Location | IT Applicability |
|-------|----------|-----------------|
| Systematic Debugging | `skills/shared/systematic-debugging/SKILL.md` | Direct — Error investigation, root cause analysis |
| Build Error Fix | `skills/shared/build-error-fix/SKILL.md` | Direct — Build error resolution |
| Test-Driven Development | `skills/shared/test-driven-development/SKILL.md` | Direct — Code generation with tests |
| Testing Verification | `skills/shared/testing-verification/SKILL.md` | Direct — Code validation |
| Database Schema Management | `skills/shared/database-schema-management/SKILL.md` | Direct — Schema changes, migrations |
| UI Configuration Validation | `skills/shared/ui-configuration-validation-interface/SKILL.md` | Direct — IT page configuration |

## Cross-Team Coordination

| Team | Coordination Point | Shared Skills Used |
|------|-------------------|-------------------|
| PromptForge AI Team | AI prompt integration, agent orchestration | `it-agent-coordination` |
| DomainForge AI Team | Document generation, code scaffolding | `it-documentation-generation`, `it-code-generation-scaffolding` |
| QualityForge AI Team | Error validation, security audit | `it-security-audit-validation`, `it-error-discovery-classification` |
| DevForge AI Team | Testing, code quality | `shared/test-driven-development`, `shared/testing-verification` |

## Readiness Assessment

| Dimension | Score (1-10) | Notes |
|-----------|-------------|-------|
| Skills Coverage | 2/10 | Zero IT-specific skills exist; shared skills provide minimal coverage |
| Agent Availability | 3/10 | Agents defined conceptually but need role specifications |
| Domain Knowledge | 7/10 | Domain knowledge file created with Part 7 AI-Native sections |
| Prompt Integration | 8/10 | Prompt created with complete 16-section structure |
| Testing & Validation | 0/10 | No testing framework yet |
| Integration Readiness | 4/10 | Agent-to-skill mapping needs remediation |
| **Overall Readiness** | **4.0/10** | Needs phase-based remediation to reach 10/10 |

## Remediation Priority

1. **Phase 1 (Critical):** Create 3 critical skills (error-discovery, system-arch, code-gen)
2. **Phase 2 (High):** Create 3 high-priority skills (log-analysis, security-audit, documentation)
3. **Phase 3 (Medium):** Create 4 medium-priority skills + agent verification
4. **Phase 4 (Validation):** Validate all skills, update prompt, create dashboard

---

## Version History
- v1.0 (2026-04-01): Initial agent-to-skill mapping for IT discipline
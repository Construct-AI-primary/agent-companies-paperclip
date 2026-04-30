---
title: 00425 Contracts Pre-Award AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Contracts Pre-Award features including tender creation, supplier invitation, submission handling, evaluation framework, award management, and contract preparation with structured data architecture
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/prompts
gigabrain_tags: disciplines, 00425_contracts-pre-award, ai-native-operations, document-generation, tender-management, supplier-invitation, evaluation-framework, award-management, multi-agent-orchestration
openstinger_context: contracts-pre-award-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/domain-knowledge/00425_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/domain-knowledge/00425_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 00425 Contracts Pre-Award AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Contracts Pre-Award features on large-scale engineering and construction projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant tendering code covering tender specification, supplier invitation, submission handling, evaluation, and award management. Use this prompt when agents are developing tendering components, workflows, APIs, or UI elements.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Data Classification
- [ ] **Classify tendering data sources** — Tag each input as text-native (tender specs, evaluation reports, award recommendations), structured data (evaluation scores, supplier responses, pricing data, timelines), document-native (technical drawings, specifications, submissions), or human-led (panel scoring, award decisions, negotiations)
- [ ] **Implement tender specification pipeline** — Draft → Review → Approval → Publication workflow
- [ ] **Implement evaluation framework pipeline** — Criteria definition → Scoring → Analysis → Recommendation
- [ ] **Implement provenance tracking** — Every tender and evaluation value tagged with source data, evaluator, date, approval

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all tender document templates (tender specifications, supplier invitations, evaluation reports, award recommendations, contract drafts)
- [ ] **Implement structured data injection** — Template engine fills placeholders from tender data, supplier responses, evaluation data, award decisions
- [ ] **Develop Phase 1 documents (Tender Preparation)** — Tender specifications, evaluation criteria, supplier invitation templates, tender notices
- [ ] **Develop Phase 2 documents (Publication)** — Tender notices, supplier communications, clarification responses, addenda
- [ ] **Develop Phase 3 documents (Evaluation)** — Evaluation summaries, score analysis, compliance checks, recommendation reports
- [ ] **Develop Phase 4 documents (Award)** — Award recommendations, contract drafts, notification letters, appeal responses
- [ ] **Add compliance validation** — Automated procurement regulation compliance checks, conflict of interest detection
- [ ] **Implement approval workflow** — Document revision tracking with verified authorization

### Phase 3: Multi-Agent Tender Orchestration
- [ ] **Implement Tender Creation Agent** — Auto-generate tender specifications from requirements
- [ ] **Implement Supplier Invitation Agent** — Identify and invite qualified suppliers
- [ ] **Implement Submission Compliance Agent** — Verify submission completeness and compliance
- [ ] **Implement Evaluation Analysis Agent** — Process evaluation scores, generate analysis
- [ ] **Implement Award Recommendation Agent** — Generate award recommendations from evaluations
- [ ] **Implement Contract Preparation Agent** — Draft contracts from award decisions
- [ ] **Implement Supplier Communication Agent** — Manage supplier queries and responses
- [ ] **Implement agent coordination layer** — Tender creation → Supplier invitation → Submission receipt → Evaluation → Award recommendation workflow

### Phase 4: Compliance Intelligence
- [ ] **Implement procurement regulation compliance** — Auto-check tender specs against applicable procurement regulations
- [ ] **Implement conflict of interest detection** — Identify potential conflicts from tender participants
- [ ] **Implement audit trail generation** — Generate comprehensive audit records for regulatory review
- [ ] **Implement fairness monitoring** — Monitor process for equal treatment of all suppliers

### Phase 5: Natural Language Tender Interface
- [ ] **Implement Tender Specification Assistant** — "Draft a tender for structural steel supply" → compliant tender spec
- [ ] **Develop Evaluation Analysis Query** — "Show me evaluation scores for Tender X" → score analysis
- [ ] **Implement Award Recommendation Query** — "What is the recommended award for Tender X?" → recommendation report
- [ ] **Implement Contract Query Assistant** — "What are the key terms from the awarded contract?" → contract summary

### Phase 6: Evaluation Intelligence
- [ ] **Implement score trend analysis** — Track evaluation scores across tenders
- [ ] **Develop supplier performance correlation** — Correlate evaluation scores with post-award performance
- [ ] **Implement pricing analysis** — Analyze pricing data for anomalies and competitiveness
- [ ] **Develop evaluation panel efficiency** — Track panel member productivity and consistency

### Phase 7: Data-Driven Tender Operations
- [ ] **Implement tender cycle tracking** — Track tender cycle times, identify improvement opportunities
- [ ] **Develop supplier engagement trending** — Track supplier response rates and engagement
- [ ] **Implement cost savings analysis** — Track procurement savings from tenders
- [ ] **Develop compliance monitoring** — Monitor procurement compliance across all tenders

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Award decisions always require human authority
- [ ] **Develop uncertainty disclosure** — AI must disclose when compliance uncertain, evaluation incomplete
- [ ] **Implement immutable audit trail** — Log all tender actions with provenance tags
- [ ] **Develop human review gates** — All evaluations, recommendations, awards require human validation
- [ ] **Implement data confidentiality** — Protect confidential tender information between suppliers

## Discipline Context

### 00425 Contracts Pre-Award Scope
The 00425 Contracts Pre-Award discipline encompasses:
- **AI-Native Operations**: Automating tendering documentation from tender specifications to contract drafts
- **Tender Creation Pipeline**: Automated tender specification generation from requirements
- **Evaluation Framework Pipeline**: Score processing, analysis, and recommendation generation
- **Award Management Pipeline**: Award recommendations, contract preparation, notification
- **Compliance Intelligence**: Procurement regulation compliance, conflict detection, audit trail
- **Supplier Communication**: Query handling, clarification management, notification
- **Tendering Governance**: AI safety boundaries, human review gates, audit trails, authority sign-off

### Related Disciplines
- **01900 Procurement**: Supplier management, contract execution
- **00400 Contracts**: Contract post-award management
- **00435 Contracts Post-Award**: Contract administration
- **01200 Finance**: Budget control for procurement

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 00425 Contracts Pre-Award AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/00425_contracts-pre-award/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 4 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 00425_contracts-pre-award", "ai-native-operations", "[specific-capability]"
- Filter by tags: "tender-management", "supplier-invitation", "evaluation-framework", "award-management", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with pre-award domain knowledge and glossary
- Check memory for recent tendering AI implementation patterns

**Pre-Award AI-Native Context:**
- Reference text-native, structured data, document-native, and human-led input classification
- Apply tender specification pipeline (requirements → spec → approval → publication)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (award decisions, conflict of interest determinations)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar tendering AI implementations
- Build on established pre-award organizational knowledge
- Ensure compliance with procurement regulations and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Automation Spectrum for Pre-Award Operations

### Fully Automatable Tasks
| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Tender Specification Draft** | Requirements received | Scope description, technical requirements | Auto-validation: procurement compliance, completeness |
| **Submission Compliance Check** | Submission received | Tender requirements, submission documents | Auto-validation: mandatory requirements verified |
| **Evaluation Summary** | Evaluation complete | Evaluation scores, criteria weights | Auto-validation: all criteria scored, weights applied |
| **Award Recommendation Draft** | Evaluation complete | Evaluation results, criteria | Auto-validation: recommendation consistent with scores |
| **Contract Draft** | Award decision made | Award details, standard contract | Auto-validation: terms match award, mandatory clauses present |
| **Supplier Notification** | Stage change | Supplier list, notification template | Auto-validation: recipients verified, content approved |

### Augmented Tasks (AI + Human)
| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Evaluation Criteria Weighting** | Suggest weights based on procurement type | Procurement manager approves | Human |
| **Supplier Pre-Qualification** | Compile supplier data, assess against criteria | Procurement team reviews, confirms | Human |
| **Tender Addenda** | Draft clarification responses | Tender committee approves | Human |
| **Appeal Response** | Draft based on appeal grounds | Legal/procurement reviews, finalizes | Human |

### Human-Led Tasks
| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Final Tender Publication** | Compile specs, compliance check | Procurement authority approves |
| **Evaluation Panel Scoring** | Compile evaluation framework, distribute | Panel members score |
| **Award Decision** | Compile recommendation report | Decision authority approves award |
| **Contract Negotiation** | Compile contract terms, identify variations | Procurement negotiates |
| **Appeal Decision** | Compile appeal grounds, precedent | Appeal authority decides |

## AI Safety Boundaries

**Non-Delegable Human Decisions:**
1. Final tender publication approval
2. Supplier selection for tender invitation
3. Evaluation panel scoring
4. Award decision and recommendation approval
5. Contract terms negotiation
6. Appeal decisions
7. Conflict of interest determinations

**AI Must Always Disclose:**
1. When tender specifications may not meet procurement regulations
2. When evaluation criteria weights require panel approval
3. When supplier responses are incomplete or non-compliant
4. When conflicts of interest may exist
5. What procurement regulations apply
6. What information must remain confidential between suppliers

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in tender documents vs source data
- **Timeliness**: 80%+ reduction in tender documentation time vs manual
- **Compliance**: 100% of tender documents procurement compliant
- **Review Efficiency**: 50%+ reduction in review cycles through pre-validation

### Evaluation Metrics
- **Scoring Completion**: 95%+ of evaluations completed within panel timeline
- **Score Consistency**: 90%+ of panel member scores consistent with criteria
- **Recommendation Validity**: 100% of recommendations consistent with scores

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of tender workflow sequences complete
- **Error Recovery**: 100% of failed executions recovered or escalated
- **Audit Trail Integrity**: 100% of actions logged with source, timestamp, decision

## Version History

- **v1.0** (2026-04-01): Initial Contracts Pre-Award AI-Native Prompt Template

## Pre-Award AI Agent Behavioral Rules

### Non-Negotiable Rules

1. **Confidentiality Rule:** Never disclose one supplier's tender information to another supplier. Maintain strict confidentiality throughout the process.

2. **Fairness Rule:** Ensure all suppliers are treated equally throughout the tender process. Never give advantage to any supplier.

3. **No Evaluation Fabrication:** Never invent evaluation scores, modify scores, or create evaluation content without source data.

4. **Provenance Tracking:** All tender outputs must carry provenance tags (source data, evaluator, date, approval status).

5. **Compliance First:** Always check tender processes against procurement regulations. Flag any potential compliance issues.

6. **Conflict of Interest:** Always identify and disclose potential conflicts of interest in the tender process.

7. **Authority Rule:** Never approve tender publications, modify evaluation scores, or recommend awards without proper authorization.

8. **Audit Trail Rule:** All tender actions, communications, and decisions must be recorded with full audit trail.
---
title: 02200 Quality Assurance AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Quality Assurance features including PQP generation, ITP development, audit management, NCR workflows, CAPA tracking, supplier quality assessment, and quality management systems with structured data architecture
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02200_quality-assurance/agent-data/prompts
gigabrain_tags: disciplines, 02200_quality-assurance, ai-native-operations, document-generation, quality-management, audit-management, ncr-management, capa-tracking, supplier-quality, multi-agent-orchestration, iso-compliance
openstinger_context: quality-assurance-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/02200_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/02200_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02200 Quality Assurance AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Quality Assurance features on large-scale engineering and construction projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant QA code covering PQP generation, ITP development, audit management, NCR workflows, CAPA tracking, supplier quality assessment, and quality management systems. Use this prompt when agents are developing QA components, workflows, APIs, or UI elements.

**Key Lessons from Safety, Civil, IT, Inspection, and PR Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what QA code they can generate independently vs. what requires human architect review. Quality data must never be fabricated and all quality decisions must have verified authority.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Quality-Native Architecture
- [ ] **Classify all QA data sources** — Tag each input as text-native (PQPs, ITPs, NCRs, audit reports), structured data (quality KPIs, audit findings, supplier metrics), image-native (defect images, weld photos), or human-led (audits, management reviews)
- [ ] **Implement quality data processing pipeline** — Quality records input → schema validate → compliance check → report generation
- [ ] **Implement NCR workflow pipeline** — NCR data input → root cause analysis → CAPA generation → closure tracking
- [ ] **Build extraction schemas per QA document type** — PQP, ITP, audit plan, NCR, CAPA, quality report
- [ ] **Implement provenance tracking** — Every quality document value tagged with source record, data date, and verification status

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all QA document templates (PQP, ITP, audit reports, NCR forms, CAPA records, quality performance reports)
- [ ] **Implement structured data injection** — Template engine fills placeholders from quality records, audit findings, supplier data
- [ ] **Develop Phase 1 documents (Project Setup)** — Project Quality Plan, quality procedures, document control procedures, quality training plans
- [ ] **Develop Phase 2 documents (Planning)** — ITPs, audit plans, supplier quality plans, inspection procedures
- [ ] **Develop Phase 3 documents (Execution)** — Audit reports, NCRs, quality performance reports, inspection summaries
- [ ] **Develop Phase 4 documents (Review)** — Management review reports, lessons learned, quality system assessments
- [ ] **Add quality validation** — Automated completeness checks, ISO 9001 compliance verification
- [ ] **Implement approval workflow** — Document revision tracking with verified authorization

### Phase 3: Multi-Agent QA Orchestration
- [ ] **Implement ITP Generation Agent** — Auto-generate ITPs from work packages and specifications
- [ ] **Implement Audit Planning Agent** — Create audit plans from schedule and requirements
- [ ] **Implement Audit Reporting Agent** — Generate audit reports from findings data
- [ ] **Implement NCR Management Agent** — Process NCRs, track root cause, manage CAPA
- [ ] **Implement Supplier Quality Agent** — Assess supplier quality, track performance metrics
- [ ] **Implement Quality Metrics Agent** — Generate quality performance reports, trend analysis
- [ ] **Implement CAPA Tracking Agent** — Track corrective action completion, verify effectiveness
- [ ] **Implement agent coordination layer** — ITP development → Audit planning → Findings → NCR → CAPA → Closure workflow

### Phase 4: Quality Intelligence & Metrics
- [ ] **Implement quality metrics tracking** — Real-time KPI monitoring, NCR rates, audit closure rates
- [ ] **Develop quality trend analysis** — Identify quality degradation trends before they become systemic
- [ ] **Implement supplier quality dashboard** — Track supplier performance across all quality metrics
- [ ] **Develop quality system health monitoring** — Monitor QMS effectiveness across all components
- [ ] **Implement predictive intelligence** — Predict quality issues from audit findings, NCR trends

### Phase 5: Natural Language QA Interface
- [ ] **Implement Procedure Query Assistant** — "What are the document control requirements for quality procedures?" → clause reference
- [ ] **Develop ITP Query Assistant** — "What are the hold points for concrete placement?" → ITP extraction
- [ ] **Implement NCR Analysis Assistant** — "What are the top NCR causes this quarter?" → root cause summary
- [ ] **Develop Audit Query Assistant** — "What findings were raised for the piping audit?" → findings summary
- [ ] **Implement chatbot with QA boundaries** — Cannot classify major non-conformances, cannot approve dispositions without authority

### Phase 6: Audit Management Intelligence
- [ ] **Implement audit scheduling intelligence** — Optimize audit schedule based on work progress and requirements
- [ ] **Develop audit finding trend analysis** — Identify systemic quality issues from audit patterns
- [ ] **Implement audit report generation** — Auto-generate audit reports with findings and recommendations
- [ ] **Develop corrective action tracking** — Track audit corrective actions to completion
- [ ] **Implement audit dashboard** — Real-time audit status visualization with trend analysis

### Phase 7: Data-Driven QA Operations
- [ ] **Implement CAPA effectiveness tracking** — Verify corrective actions resolve root causes
- [ ] **Develop quality cost analysis** — Track cost of quality, rework costs, prevention costs
- [ ] **Implement supplier performance trending** — Predict supplier quality issues from performance data
- [ ] **Develop root cause pattern analysis** — Identify systemic root causes across multiple NCRs
- [ ] **Implement quality intelligence dashboard** — Real-time quality system visualization with all KPIs

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Major non-conformance classification always requires human authority
- [ ] **Develop uncertainty disclosure** — AI must disclose when quality data incomplete, findings unverified
- [ ] **Implement immutable audit trail** — Log all quality outputs with provenance tags
- [ ] **Develop human review gates** — Disposition decisions, quality system acceptance require human validation
- [ ] **Implement data retention requirements** — Compliance with quality record retention requirements

### Phase 9: Agent Assessment and Assignment
- [ ] **QA Agent assessment** — Define agents needed based on prompt requirements
- [ ] **QA Agent-to-skill mapping** — Map each agent to required skills
- [ ] **Identify skill gaps** — Document what skills need creation
- [ ] **Create remediation plan** — Plan skills creation and agent definition

## Discipline Context

### 02200 Quality Assurance Scope
The 02200 Quality Assurance discipline encompasses:
- **AI-Native Operations**: Automating QA documentation from PQP generation to management review reports
- **ITP Generation Pipeline**: Automated inspection plan generation from work packages and specifications
- **Audit Management Pipeline**: Audit planning, execution, reporting, and corrective action tracking
- **NCR Management Pipeline**: Non-conformance reporting, root cause analysis, CAPA generation, closure verification
- **Supplier Quality Assessment**: Supplier quality evaluation, performance tracking, risk identification
- **Quality Metrics and Intelligence**: KPI tracking, trend analysis, predictive quality intelligence
- **Document Control**: Quality document control, revision management, distribution control
- **QA Governance**: AI safety boundaries, human review gates, audit trails, authority sign-off

### Related Disciplines
- **00850 Civil Engineering**: Construction inspection, hold points, dimensional control
- **00870 Mechanical Equipment**: Equipment inspection, fabrication hold points
- **02250 Quality Control**: Inspection activities, dimensional verification
- **01900 Procurement**: Supplier quality, incoming inspection
- **02075 Inspection**: Field inspection, NDT coordination, coating inspection
- **02400 Safety**: Incident investigation, safety audit coordination

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02200 Quality Assurance AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 9 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02200_quality-assurance", "ai-native-operations", "[specific-capability]"
- Filter by tags: "quality-management", "audit-management", "ncr-management", "capa-tracking", "supplier-quality", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with QA domain knowledge and glossary
- Check memory for recent QA AI implementation patterns

**Quality Assurance AI-Native Context:**
- Reference text-native, structured data, image-native, and human-led input classification
- Apply quality data processing pipeline (records → compliance check → reporting)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (major non-conformance, quality authority sign-off)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar QA AI implementations
- Build on established QA organizational knowledge
- Ensure compliance with ISO 9001, ISO 19011, and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## QA AI-Native Use Case Templates

### ITP Generation Pipeline Execution
```
Generate Inspection and Test Plan for [WORK_PACKAGE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/02200_DOMAIN-KNOWLEDGE.MD
- Reference ITP generation: Part 3
- Check applicable codes and standards: Part 1.3

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02200_quality-assurance", "quality-planning", "[work-package-type]"
- Filter by tags: "itp-generation", "hold-point-definition", "acceptance-criteria"

Memory Context:
- Include memory headers with ITP generation gigabrain_tags
- Cross-reference with engineering specifications and standards
- Reference historical ITP templates for similar work packages

QA AI-NATIVE CONTEXT:
- Apply automated ITP generation from work package specifications
- Define hold points, witness points, and review points from specification requirements
- Set verification methods, acceptance criteria, and responsibilities per applicable standards
- Generate ITP with traceability to work package and specification clauses

Provide ITP generation with:
- Specification and standard analysis for quality requirements
- Inspection and test activity identification and sequencing
- Hold point and witness point definition with appropriate authority levels
- Verification methods, acceptance criteria, and responsibility assignments
- Template structure with all required fields mapped to specification clauses
- Provenance tracking: source data, template version, generation date
```

### Audit Report Generation Pipeline
```
Generate Audit Report for [AUDIT_TYPE] - [SCOPE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/
- Reference audit management: Part 4
- Check audit finding classification: Part 4.3

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02200_quality-assurance", "audit-management", "[audit-type]"
- Filter by tags: "audit-reporting", "finding-classification", "corrective-action-tracking"

Memory Context:
- Include memory headers with audit management gigabrain_tags
- Cross-reference with previous audit reports and corrective action status
- Reference audit standards checklists (ISO 9001, ISO 19011, project requirements)

QA AI-NATIVE CONTEXT:
- Apply audit reporting pipeline: Audit findings input → Structured formatting → Classification generation → Report output
- Classify findings per ISO 19011 (conformance, minor non-conformance, major non-conformance, observation)
- Generate recommendations and corrective actions based on findings
- Do NOT classify major non-conformances without human auditor review

Provide audit report generation with:
- Audit execution details (scope, objectives, criteria, dates, locations, auditors)
- Findings summary categorized by type (conformance, minor, major, observation)
- Evidence and observations for each finding
- Recommendations and suggested corrective actions
- Corrective action tracking with due dates and responsibilities
- Provenance tracking: audit data source, findings data, report format
```

### NCR and CAPA Management Pipeline
```
Process Non-Conformance and Generate CAPA for [NCR_SOURCE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/02200_DOMAIN-KNOWLEDGE.MD
- Reference non-conformance management: Part 5
- Check disposition options: Part 5.2

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02200_quality-assurance", "ncr-management", "[non-conformance-type]"
- Filter by tags: "ncr-generation", "root-cause-analysis", "capa-tracking", "disposition-management"

Memory Context:
- Include memory headers with NCR management gigabrain_tags
- Cross-reference with quality procedures and acceptance criteria
- Reference historical NCRs for similar issues and disposition outcomes

QA AI-NATIVE CONTEXT:
- Apply NCR management pipeline: Issue discovery → NCR documentation → Root cause analysis → Disposition determination → CAPA generation → Closure verification
- Generate NCR with all required fields from structured data
- Generate CAPA based on root cause analysis
- Never close NCRs without verified corrective action and evidence

Provide NCR and CAPA management with:
- NCR documentation with all required fields (description, location, date, discoverer, standard violation)
- Root cause analysis documentation (use 5-why, fishbone, or FTA analysis results)
- Disposition determination (rework, repair, accept-as-is, reject) with justification
- CAPA plan with corrective actions, preventive actions, responsibilities, and due dates
- Closure verification requirements (evidence needed, effectiveness criteria)
- Provenance tracking: NCR source data, root cause analysis, disposition authority
```

### Multi-Agent QA Orchestration
```
Coordinate QA Workflow for [QUALITY_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02200_quality-assurance/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 9D
- Check agent definitions and capabilities documentation

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02200_quality-assurance", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and quality workflows
- Reference completed implementations of similar QA workflows

QA AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: ITP Development → Audit Planning → Quality Surveillance → NCR Generation → Root Cause Analysis → CAPA Generation → Closure Verification → Management Review
- Define data formats passed between agents (structured JSON, not free text)
- Implement QA boundaries: no agent can classify major non-conformances, no agent can approve dispositions without authority

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents (ITP data, audit findings, NCR data, CAPA records, closure data)
- Error handling and escalation when agent cannot process (complex NCR, missing root cause, overdue CAPA)
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow (major NC classification, disposition approval, NCR closure verification)
- Audit trail tracking for all quality actions and decisions
```

## Automation Spectrum for QA Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **ITP Template Generation** | Work package approved | Work package spec, applicable standards | Auto-validation: hold points identified, criteria specified |
| **Audit Report Draft** | Audit completed | Audit findings, observation notes | Auto-validation: findings classified, evidence complete |
| **NCR Generation** | Non-conformance discovered | Finding data, standard violations | Auto-validation: description complete, standard clause identified |
| **Quality Performance Report** | Scheduled reporting | Quality metrics, KPI data | Auto-validation: all metrics included, trends calculated |
| **CAPA Tracking Report** | Scheduled or overdue | CAPA records, completion status | Auto-validation: all CAPAs tracked, overdue items flagged |
| **Supplier Quality Summary** | Periodic review | Supplier quality metrics, audit findings | Auto-validation: metrics calculated, trends identified |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Project Quality Plan** | Generate draft PQP from requirements | Quality manager reviews, adjusts, approves | Human |
| **Quality Audit Plan** | Generate audit schedule and scope | Quality manager reviews, adjusts, approves | Human |
| **Supplier Quality Assessment** | Compile assessment from audit and performance data | QA engineer reviews, finalizes assessment | Human |
| **Root Cause Analysis Documentation** | Compile analysis from 5-why, fishbone analysis results | QA team reviews, validates, approves | Human |
| **Corrective Action Plan** | Generate CAPA from root cause and disposition | QA engineer reviews, assigns responsibilities | Human |
| **Management Review Report** | Compile quality data, trends, recommendations | Management reviews, adjusts, approves | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Major Non-Conformance Classification** | Compile findings, evidence, standard violations | Quality authority classifies and approves |
| **Supplier Rejection Decision** | Present quality assessment, performance trends | Procurement and QA leads decide |
| **Quality System Acceptance** | Compile QMS status, audit findings, performance data | Quality director accepts system |
| **Disposition Decision** | Present non-conformance, options, analysis | Quality authority approves disposition |
| **NCR Closure Verification** | Compile corrective action evidence, effectiveness | Quality authority verifies and closes NCR |
| **Management Review Decisions** | Compile quality data, trends, recommendations | Management team decides actions |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated quality documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (quality records, audit findings, NCR data, supplier metrics)
    ↓
STRUCTURED DATA VALIDATION (schema, completeness, verification status)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, applicable standard, project requirements)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, ISO compliance, traceability)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — major NCs, disposition decisions, quality acceptance)
    ↓
FINAL APPROVAL (quality authority for major decisions, quality system acceptance)
    ↓
OUTPUT GENERATION (PDF, structured forms, quality reports, dashboards)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & QUALITY SYSTEM INTEGRATION
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (quality records, audit findings, NCR data, supplier metrics). The LLM structures and formats, but does not invent findings or measurements.
2. **Provenance Tracking**: Every finding, measurement, and quality value injected into a template is tagged with its source (e.g., "finding from audit #A-2026-045, location: welding shop, auditor: Jane Doe, date: 2026-04-01").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data (e.g., "if no findings, note 'No non-conformances raised'").
4. **ISO Compliance and Accuracy**: Templates must reference applicable ISO standards and acceptance criteria. Standard updates trigger template reviews.
5. **Multi-Format Output**: Construction-phase documents (NCR forms, audit checklists) and formal reports (audit reports, management review) must both be supported.
6. **Traceable and Auditable**: All quality documentation must be traceable to source data, audits, and specification requirements.

## AI-Native QA Capabilities Beyond Automation

### Quality Intelligence
- **Audit Finding Trend Analysis**: Identify patterns in audit findings across projects, contractors, and time
- **NCR Root Cause Pattern Analysis**: Identify systemic root causes across multiple NCRs and activities
- **Quality System Health Monitoring**: Monitor QMS effectiveness across all components and report degradation
- **Supplier Quality Performance Assessment**: Track supplier quality metrics and identify at-risk suppliers

### Natural Language QA Interface
- **Procedure Query Assistant**: "What are the document control requirements for quality procedures?" → standard clause
- **ITP Query Assistant**: "What are the hold points for concrete placement?" → extracted ITP data
- **NCR Analysis Assistant**: "What are the top root causes this quarter?" → analyzed findings
- **Audit Query Assistant**: "What findings were raised for the piping process audit?" → findings summary

### Predictive Intelligence
- **NCR Rate Prediction**: Predict NCR rates from work activities, contractor history, and quality system status
- **Audit Finding Prediction**: Predict likely audit findings from work progress and quality surveillance history
- **Supplier Risk Assessment**: Identify suppliers at risk of quality issues from performance trends
- **Quality Degradation Prediction**: Predict quality system degradation from audit and performance trends

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for quality, legal, and safety reasons:

**Non-Delegable Human Decisions:**
1. Major non-conformance classification
2. Supplier rejection decisions
3. Quality system acceptance
4. Management review decisions
5. Quality authority sign-off
6. Disposition decisions (repair, rework, accept-as-is, reject)
7. Quality escalation decisions
8. NCR closure verification for critical items

**AI Must Always Disclose:**
1. When quality data is incomplete or audit findings unverified
2. When NCR analysis is based on preliminary or unconfirmed information
3. When supplier quality assessment relies on limited audit data
4. When quality system performance may be affected by incomplete data
5. What specialist input is required (certified auditors for audit findings)
6. What quality decisions require human authority sign-off
7. What quality records may affect regulatory compliance
8. What findings require escalation due to safety or compliance implications

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from quality records, audit findings, NCR data |
| **NCR management** | Structured data pipeline for NCR workflow: discovery → documentation → root cause → disposition → CAPA |
| **Audit management** | Structured audit data pipeline; LLM works from audit findings only |
| **Quality metrics** | Dedicated KPI tracking system; LLM generates reports and trend analysis |
| **Supplier quality** | Integration with supplier database; LLM generates assessments and trend analysis |
| **Knowledge retrieval** | RAG pattern for quality procedures, ITPs, code requirements, audit standards |
| **Audit trail** | Immutable log of all quality actions with provenance tags and authorization records |
| **Predictive intelligence** | Trend analysis and machine learning for quality degradation and NCA prediction |

## AI Agent Coordination Workflow

```
Trigger Event Received (work package approved, audit completed, NCR discovered, supplier assessment due)
    → Classification Agent categorizes event type and urgency
    → If work package approved: ITP Generation Agent creates ITP
    → If audit completed: Audit Reporting Agent drafts report
    → If NCR discovered: NCR Management Agent documents and initiates workflow
    → If supplier assessment due: Supplier Quality Agent prepares assessment
    → Root Cause Analysis Agent processes findings and generates analysis
    → CAPA Generation Agent creates corrective and preventive actions
    → CAPA Tracking Agent monitors completion and effectiveness
    → Quality Metrics Agent updates performance dashboards
    → Escalation Agent flags overdue, critical, or unresolved items
    → All quality actions logged with provenance and audit trail
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for quality AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all quality actions** with audit trail for regulatory compliance and internal audits
6. **Never let LLM process unverified quality findings** as confirmed facts

### QA Boundary Enforcement
1. **Never allow AI to classify major non-conformances** — always require quality authority
2. **Never allow AI to approve dispositions** — always require quality authority sign-off
3. **Never allow AI to close NCRs without verification** — always require human verification
4. **Always disclose AI limitations** — data coverage, verification status, standard currency
5. **Always maintain immutable audit trail** — all quality outputs with provenance
6. **Always tag quality data** with provenance (source, auditor, date, verification status)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated quality documents vs source records
- **Timeliness**: 80%+ reduction in quality documentation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of quality documents generated within required timeframes

### Audit Management Metrics
- **Audit Completion Rate**: 95%+ of scheduled audits completed
- **Finding Closure Rate**: 90%+ of corrective actions completed within due date
- **Report Generation**: 80%+ reduction in audit report preparation time
- **Finding Detection**: 90%+ of findings correctly classified

### NCR Management Metrics
- **NCR Detection Coverage**: 95%+ of non-conformances documented
- **Root Cause Accuracy**: 90%+ of root cause analyses verified correct
- **NCR Closure Rate**: 90%+ of NCRs closed within agreed timeframes
- **CAPA Effectiveness**: 85%+ of corrective actions verified effective

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of QA workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of quality actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Quality Assurance Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety, Civil Engineering, IT, Inspection domains
- Created QA-specific use case templates for ITP generation, audit reporting, NCR/CAPA management, and agent orchestration
- Defined automation spectrum for all QA operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Detailed success metrics for all AI capabilities
- Added implementation best practices and QA boundary enforcement
- Added Phase 9 for agent assessment and assignment

## Quality Assurance AI Agent Behavioral Rules

### Non-Negotiable Rules for All QA AI Agents

1. **Quality First Rule:** Never accept incomplete or unverified quality data. If quality data cannot be verified, the agent must flag it as "unverified — requires confirmation."

2. **Authorization Required Rule:** No quality decision can be finalized without proper authorization. Always verify approval status before finalizing any quality action.

3. **No Quality Fabrication Rule:** Never invent quality findings, audit observations, or measurement values. Only use data from verified quality records and audits.

4. **Provenance Tracking Rule:** All quality content must carry provenance tags (source data, auditor, date, verification status). Never present quality findings without their source attribution.

5. **No Authority Substitution Rule:** When quality decisions require authority (major NC classification, disposition approval, NCR closure), escalate to quality authority. AI cannot substitute for authorized judgment.

6. **Standard Compliance Rule:** During quality evaluation, follow applicable ISO standards, project requirements, and approved procedures. Do not improvise. Use verified standards only.

7. **Traceability Rule:** Ensure all quality documentation is traceable to source records, applicable standards, and approved requirements. If traceability is lost, flag for investigation.

8. **Documentation Rule:** All quality outputs should be structured for formal quality records. Use professional, auditable language that meets project quality standards and regulatory requirements.

9. **Respect Non-Delegable Decisions:** Never classify major non-conformances, approve dispositions, or accept quality systems without authority. These require human quality authority judgment.

10. **Audit Trail Rule:** All quality inputs, outputs, and decisions must be recorded with full audit trail for quality compliance, internal audits, and regulatory review.

## Phase 9: Agent Assessment & Skills Inventory Analysis

### Current Agent Assessment
Based on the prompt analysis, the following agents are needed for 02200 Quality Assurance:

| Agent ID | Agent Name | Primary Role | Reports To | Specialization |
|----------|-----------|--------------|------------|----------------|
| 02200-001 | QA System Architect | QMS design and quality plan development | QA Manager | QMS architecture, PQP development |
| 02200-002 | ITP Generator | ITP development from work packages | QA Manager | Specification analysis, hold point definition |
| 02200-003 | Audit Planner | Audit scheduling and audit plan development | QA Manager | Audit scheduling, risk-based planning |
| 02200-004 | Audit Reporter | Audit report generation from findings | Audit Planner | Finding classification, report drafting |
| 02200-005 | NCR Manager | NCR documentation and root cause analysis | QA Manager | NCR processing, root cause analysis |
| 02200-006 | CAPA Tracker | Corrective action tracking and closure verification | QA Manager | CAPA tracking, effectiveness verification |
| 02200-007 | Supplier Quality Agent | Supplier quality assessment and monitoring | QA Manager | Supplier evaluation, performance tracking |
| 02200-008 | Quality Metrics Agent | Quality KPI tracking and performance reporting | QA Manager | Metrics analysis, trend reporting |

### Skills Required Mapping

| Agent | Primary Skill | Supporting Skills | Environment | Status |
|-------|--------------|-------------------|-------------|--------|
| 02200-001 QA System Architect | `quality-qms-development` | `shared/documentation-templates` | dev, staging, prod | Need Assessment |
| 02200-002 ITP Generator | `quality-itp-generation` | `quality-code-compliance` | dev, staging, prod | Need Assessment |
| 02200-003 Audit Planner | `quality-audit-planning` | `shared/scheduling` | dev, staging | Need Assessment |
| 02200-004 Audit Reporter | `quality-audit-reporting` | `quality-audit-planning` | dev, staging, prod | Need Assessment |
| 02200-005 NCR Manager | `quality-ncr-management` | `quality-root-cause-analysis` | dev, staging, prod | Need Assessment |
| 02200-006 CAPA Tracker | `quality-capa-tracking` | `quality-ncr-management` | dev, staging, prod | Need Assessment |
| 02200-007 Supplier Quality Agent | `quality-supplier-assessment` | `quality-audit-reporting` | dev, staging | Need Assessment |
| 02200-008 Quality Metrics Agent | `quality-metrics-analysis` | `shared/data-analysis` | dev, staging, prod | Need Assessment |

### Skills Assessment Summary

- **Skills needed**: 8 new quality-specific skills
- **Skills needed prefixes**: `quality-*` for consistency with domain-specific naming
- **Readiness**: Phase 9 agent assessment complete; skills creation and validation required via remediation plan
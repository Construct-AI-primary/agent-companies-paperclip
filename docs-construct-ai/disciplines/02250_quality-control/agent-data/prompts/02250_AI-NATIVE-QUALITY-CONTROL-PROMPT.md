---
title: 02250 Quality Control AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Quality Control features including materials inspection, weld inspection, NDT coordination, dimensional verification, hydrotest procedures, inspection reporting, and quality dossier compilation with structured data architecture
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02250_quality-control/agent-data/prompts
gigabrain_tags: disciplines, 02250_quality-control, ai-native-operations, document-generation, materials-inspection, weld-inspection, ndt-coordination, dimensional-verification, multi-agent-orchestration, code-compliance
openstinger_context: quality-control-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02250 Quality Control AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Quality Control features on large-scale engineering and construction projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant QC code covering materials inspection, weld inspection, NDT coordination, dimensional verification, hydrotest procedures, inspection reporting, and quality dossier compilation. Use this prompt when agents are developing QC components, workflows, APIs, or UI elements.

**Key Lessons from Safety, Civil, IT, Inspection, QA, and PR Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what QC code they can generate independently vs. what requires human architect review. Quality data must never be fabricated and all acceptance decisions must have human verification.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Image-Native Architecture
- [ ] **Classify all QC data sources** — Tag each input as text-native (inspection reports, ITPs, MTRs), structured data (NDT results, dimensional measurements, DFT readings), image-native (weld photos, defect images), or human-led (physical inspections)
- [ ] **Implement dimensional data processing pipeline** — Measurement input → schema validate → tolerance check → report generation
- [ ] **Implement MTR verification pipeline** — Material certificate input → parse → specification comparison → compliance verification
- [ ] **Implement inspection data processing** — Inspection findings input → structured extraction → report generation
- [ ] **Implement provenance tracking** — Every measurement, NDT result, and inspection value tagged with source record, inspector, date, equipment
- [ ] **Enforce guard rails** — LLM cannot create/edit inspection findings without structured data; must flag missing data as "not inspected"

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all QC document templates (inspection reports, NDT reports, dimensional reports, hydrotest certificates, welding records, material verification checklists, turnover packages)
- [ ] **Implement structured data injection** — Template engine fills placeholders from inspection records, NDT results, dimensional data (not raw LLM text)
- [ ] **Develop Phase 1 documents (Pre-Construction)** — Material verification checklists, weld qualification records, inspection procedures, testing procedures
- [ ] **Develop Phase 2 documents (Construction)** — Inspection reports, NDT reports, dimensional reports, welding records, hydrotest certificates
- [ ] **Develop Phase 3 documents (Closeout)** — Quality dossiers, turnover packages, as-built documentation, NCR close-out reports
- [ ] **Develop Phase 4 documents (Archive)** — Quality records storage, traceability reports, final acceptance certificates
- [ ] **Add quality validation** — Automated completeness checks, code compliance verification against ASME, AWS, API, ASTM
- [ ] **Implement version control** — Document revision tracking with immutable audit trail

### Phase 3: Multi-Agent QC Orchestration
- [ ] **Implement Material Verification Agent** — Process MTRs, verify against specifications, track material traceability
- [ ] **Implement Weld Inspection Agent** — Process weld records, verify WPS compliance, track weld quality
- [ ] **Implement NDT Coordination Agent** — Schedule NDT activities, process NDT results, track coverage
- [ ] **Implement Dimensional Verification Agent** — Process dimensional data, check against tolerances, generate reports
- [ ] **Implement Pressure Testing Agent** — Process hydrotest data, verify test completion, generate certificates
- [ ] **Implement Inspection Reporting Agent** — Auto-generate inspection reports from inspection records
- [ ] **Implement Dossier Compilation Agent** — Compile turnover packages from all quality records
- [ ] **Implement agent coordination layer** — Material verification → Weld inspection → NDT → Dimensional → Final sign-off workflow

### Phase 4: Weld Quality Intelligence
- [ ] **Implement weld tracking system** — Track all welds from WPS generation through NDT clearance
- [ ] **Develop weld quality trending** — Track weld rejection rates by welder, WPS, joint type
- [ ] **Implement weld bead profile analysis** — Analyze weld photos for reinforcement, undercut, profile defects
- [ ] **Develop welder performance assessment** — Track welder qualifications, rejection rates, productivity
- [ ] **Implement weld quality dashboard** — Real-time weld status visualization with trend analysis

### Phase 5: Natural Language QC Interface
- [ ] **Implement Code Query Assistant** — "What does AWS D1.1 require for weld reinforcement?" → exact clause + plain language
- [ ] **Develop ITP Query Assistant** — "What are the hold points for pipe hydrotest?" → checklist extraction
- [ ] **Implement MTR Review Assistant** — "Does this MTR meet SA-106 Gr B requirements?" → compliance status
- [ ] **Develop Dimensional Query Assistant** — "Are all dimensions within tolerance for column C-5?" → dimensional summary
- [ ] **Implement chatbot with QC boundaries** — Cannot accept materials without MTR verification, cannot approve dispositions without authority

### Phase 6: Measurement Intelligence & Dimensional Analysis
- [ ] **Implement dimensional data analysis** — Compare measurement data against drawings and tolerances
- [ ] **Develop tolerance trending** — Track dimensional trends across construction phases
- [ ] **Implement DFT compliance analysis** — Track coating thickness, identify areas outside specification
- [ ] **Develop hydrotest data analysis** — Process hydrotest results, identify failures and trends
- [ ] **Implement dimensional dashboard** — Real-time dimensional status with tolerance compliance

### Phase 7: Data-Driven QC Operations
- [ ] **Implement inspection coverage tracking** — Correlate inspection completion against construction progress
- [ ] **Develop material rejection analysis** — Track rejection reasons, identify systemic issues
- [ ] **Implement NCR trend analysis** — Analyze quality issues by activity, contractor, or material
- [ ] **Develop turnover readiness assessment** — Evaluate system completeness, identify missing documentation
- [ ] **Implement QC dashboard** — Real-time quality status with all inspection metrics

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Material acceptance always requires human inspector verification
- [ ] **Develop uncertainty disclosure** — AI must disclose when inspection data incomplete, results outside criteria
- [ ] **Implement immutable audit trail** — Log all inspection outputs with provenance tags for measurements
- [ ] **Develop human review gates** — Material disposition, weld acceptance, turnover package sign-off require human validation
- [ ] **Implement data retention requirements** — Compliance with quality record retention requirements

## Discipline Context

### 02250 Quality Control Scope
The 02250 Quality Control discipline encompasses:
- **AI-Native Operations**: Automating QC documentation from inspection reports to quality dossiers
- **Material Verification Pipeline**: MTR processing, specification comparison, acceptance decisions
- **Weld Inspection Pipeline**: WPS verification, weld tracking, weld quality assessment, NDT coordination
- **Dimensional Verification Pipeline**: Measurement processing, tolerance checking, compliance reporting
- **NDT Coordination**: NDT scheduling, result processing, coverage verification
- **Quality Dossier Compilation**: Turnover package assembly, documentation verification, system handover
- **QC Governance**: Human verification gates, audit trails, acceptance authority

### Related Disciplines
- **00850 Civil Engineering**: Construction inspection, concrete inspection
- **00870 Mechanical Equipment**: Equipment inspection, fabrication hold points
- **02075 Inspection**: Field inspection, specialized inspection coordination
- **01900 Procurement**: Material specification, incoming inspection requirements
- **02200 Quality Assurance**: Quality system requirements, ITP development

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02250 Quality Control AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 8 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02250_quality-control", "ai-native-operations", "[specific-capability]"
- Filter by tags: "materials-inspection", "weld-inspection", "ndt-coordination", "dimensional-verification", "multi-agent-orchestration", "code-compliance"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with QC domain knowledge and glossary
- Check memory for recent QC AI implementation patterns

**Quality Control AI-Native Context:**
- Reference text-native, structured data, image-native, and human-led input classification
- Apply dimensional data processing pipeline (measurement → tolerance check → report)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (material acceptance, hold point clearance)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar QC AI implementations
- Build on established QC organizational knowledge
- Ensure compliance with welding codes (ASME, AWS), dimensional standards, and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## QC AI-Native Use Case Templates

### Material Acceptance Pipeline Execution
```
Verify Material for [MATERIAL_TYPE] - [HEAT/BATCH]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_DOMAIN-KNOWLEDGE.MD
- Reference material inspection: Part 2
- Check applicable material specifications: Part 1.3

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02250_quality-control", "materials-inspection", "[material-type]"
- Filter by tags: "material-verification", "MTR-review", "compliance-assessment"

Memory Context:
- Include memory headers with material inspection gigabrain_tags
- Cross-reference with material specifications and purchase order requirements
- Reference historical MTR review patterns

QC AI-NATIVE CONTEXT:
- Apply MTR review pipeline: Certificate input → Parse → Spec comparison → Compliance determination
- Verify chemical composition against specification requirements
- Verify mechanical properties against specification minimums
- Flag any values outside tolerance for human inspector review

Provide material acceptance with:
- MTR parsing and data extraction (chemical composition, mechanical properties)
- Specification requirements lookup for the specific material grade
- Compliance assessment for each property and element
- Discrepancies and out-of-specification items identified
- Recommendation for human inspector review on any ambiguous items
- Provenance tracking: source MTR, heat/batch number, review date
```

### Weld Inspection Pipeline Execution
```
Process Weld Inspection for [WELD_ID] - [WPS_REFERENCE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_DOMAIN-KNOWLEDGE.MD
- Reference weld inspection: Part 3
- Check acceptance criteria: Part 3.4

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02250_quality-control", "weld-inspection", "[weld-type]"
- Filter by tags: "weld-tracking", "NDT-coordination", "weld-quality"

Memory Context:
- Include memory headers with weld inspection gigabrain_tags
- Cross-reference with WPS, welder qualifications, and applicable codes
- Reference historical weld inspection records

QC AI-NATIVE CONTEXT:
- Apply weld inspection pipeline: Weld record input → WPS compliance check → NDT data processing → Weld assessment → Report generation
- Verify pre-weld, during-weld, and post-weld inspection requirements
- Process NDT results and compare against acceptance criteria
- Generate weld inspection report with pass/fail determination

Provide weld inspection with:
- Weld record analysis (WPS, welder qualification, joint configuration)
- Pre-weld inspection verification (fit-up, preheat, joint preparation)
- During-weld inspection data (interpass temperature, visual checks)
- Post-weld inspection (NDT results, dimensional checks, PWHT if required)
- Weld assessment against applicable code criteria (ASME, AWS)
- Report generation with provenance tracking (weld ID, WPS, NDT reports, inspection date)
```

### Dimensional Verification Pipeline Execution
```
Process Dimensional Inspection for [COMPONENT_ID]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_DOMAIN-KNOWLEDGE.MD
- Reference dimensional verification: Part 4
- Check dimensional tolerances in applicable standard

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02250_quality-control", "dimensional-verification", "[component-type]"
- Filter by tags: "dimensional-analysis", "tolerance-checking", "measurement-processing"

Memory Context:
- Include memory headers with dimensional verification gigabrain_tags
- Cross-reference with design dimensions and tolerance requirements
- Reference historical dimensional inspection records

QC AI-NATIVE CONTEXT:
- Apply dimensional verification pipeline: Measurement input → Schema validation → Tolerance comparison → Report generation
- Verify measurements against design drawings and tolerance standards
- Apply appropriate tolerance standards per component type and specification
- Generate dimensional inspection report with pass/fail determination

Provide dimensional verification with:
- Measurement data analysis (required points, calibration verification)
- Tolerance application per applicable standard (ASME, project specifications)
- Compliance assessment for each measured dimension
- Out-of-tolerance items identified for human inspector review
- Dimensional inspection report generation with provenance tracking
- Trend analysis for progressive tolerances (alignment, level, plumbness)
```

### Multi-Agent QC Orchestration
```
Coordinate QC Workflow for [SYSTEM_NAME]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 8D
- Check agent definitions and capabilities documentation

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02250_quality-control", "multi-agent-orchestration", "[system-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and QC workflows
- Reference completed implementations of similar QC workflows

QC AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Material verification → Weld inspection → NDT coordination → Dimensional verification → Hydrotest → Quality dossier compilation
- Define data formats passed between agents (structured JSON, not free text)
- Implement QC boundaries: no agent can accept materials without MTR verification, no agent can approve dispositions without authority

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions and hold points
- Data schema passed between agents (MTR data, weld records, NDT results, dimensional data)
- Error handling and escalation when agent cannot process (missing MTR, NDT failure, out-of-tolerance)
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow (material acceptance, disposition, turnover sign-off)
- Audit trail tracking for all QC actions and acceptance decisions
```

## Automation Spectrum for QC Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Inspection Report Draft** | Inspection activity complete | Inspection records, measurement data | Auto-validation: all fields populated, measurements compared against criteria |
| **MTR Verification** | MTR received | MTR data, specification requirements | Auto-validation: chemical and mechanical properties compared against spec |
| **Dimensional Report Draft** | Measurements received | Measurement data, tolerance standards | Auto-validation: measurements compared against tolerances |
| **NDT Report Draft** | NDT results received | NDT data, acceptance criteria | Auto-validation: results compared against criteria, coverage verified |
| **Hydrotest Certificate Draft** | Hydrotest completed | Hydrotest data, procedure requirements | Auto-validation: test pressure, holding time, leak check verified |
| **Quality Dossier Compilation** | System completed | All quality records, ITPs, MTRs | Auto-validation: all required documents verified present |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Weld Inspection Assessment** | Compile weld records, NDT results, visual inspection | Welding inspector reviews, signs off | Human |
| **Material Acceptance Recommendation** | Compare MTR against specification requirements | QC inspector verifies, makes decision | Human |
| **Coating Inspection Report** | Process DFT readings, surface preparation records | QC inspector verifies, assesses adhesion | Human |
| **Dimensional Analysis Report** | Process measurements, identify deviations | QC engineer reviews, assesses impact | Human |
| **Turnover Package Assembly** | Compile all quality records, verify completeness | QC manager reviews, approves package | Human |
| **NDT Coverage Analysis** | Track NDT completion, identify gaps | NDT coordinator reviews, certifies | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Material Acceptance** | Compile MTR verification, inspection records | QC inspector accepts or rejects |
| **Weld Disposition** | Compile weld records, NDT results, code analysis | Welding inspector approves repair or accepts |
| **Hold Point Clearance** | Compile inspection results, ITP status | QC inspector signs off |
| **Pressure Test Authorization** | Compile test preparation, equipment verification | QC inspector or engineer authorizes |
| **Dimensional Deviation Approval** | Compile deviations, impact analysis, code requirements | QC engineer or client representative approves |
| **Turnover Package Sign-Off** | Compile completeness analysis, missing items list | QC manager signs off |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated quality documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (inspection records, MTRs, NDT results, dimensional data)
    ↓
STRUCTURED DATA VALIDATION (schema, units, ranges, completeness)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, applicable code, system requirements)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, code compliance, measurement verification)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — material acceptance, disposition, hold point)
    ↓
FINAL APPROVAL (QC inspector for hold point clearance, authority acceptance)
    ↓
OUTPUT GENERATION (PDF, structured forms, turnover package)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & QUALITY SYSTEM ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (inspection records, MTRs, NDT results, dimensional data). The LLM structures and formats, but does not invent measurements or inspection findings.
2. **Provenance Tracking**: Every measurement, NDT result, and inspection finding injected into a template is tagged with its source (e.g., "measurement from dimensional survey #234, location: column C-5, inspector: John Smith, date: 2026-04-01").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data (e.g., "if no NDT required, omit NDT section").
4. **Code Compliance and Accuracy**: Templates must reference applicable code criteria and acceptance standards (ASME, AWS, API, ASTM). Code updates trigger template reviews.
5. **Multi-Format Output**: Construction-phase documents (inspection checklists, field inspection forms) and formal reports (NDT reports, quality dossiers) must both be supported.
6. **Traceable and Auditable**: All inspection documentation must be traceable to ITP items, MTRs, weld logs, and specification clauses.

## AI-Native QC Capabilities Beyond Automation

### Computer Vision & Weld Analysis
- **Weld Bead Profile Analysis:** Analyze weld photos for reinforcement height, undercut, and profile conformity against WPS requirements
- **Surface Defect Detection:** Identify surface cracking, porosity, and other defects from inspection photos
- **Coating Surface Defect Detection:** Detect coating defects (blistering, peeling, pinholes) from photos; auto-classify defect type and severity
- **Material Surface Condition Assessment:** Assess material surface conditions (corrosion, damage, pitting) from field photos

### Measurement Intelligence
- **Dimensional Data Analysis:** Compare measurement data against design tolerances; auto-flag out-of-specification items
- **DFT Compliance Checking:** Process DFT readings; identify areas below minimum or above maximum thickness
- **Hydrotest Analysis:** Process hydrotest data; identify pressure decay or leaks indicating failures
- **Tolerance Trending:** Track dimensional trends across construction; identify developing issues before they exceed limits

### Natural Language QC Interface
- **Code Query Assistant:** "What does AWS D1.1 require for fillet weld size tolerance?" → returns exact clause + plain-language explanation
- **ITP Query Assistant:** "What are the hold points for structural steel welding?" → returns ITP-derived checklist
- **MTR Review Assistant:** "Does this MTR meet SA-106 Gr B requirements?" → returns compliance status with evidence
- **Weld Query Assistant:** "What is the NDT coverage for weld category A?" → returns NDT completion status

### Predictive Intelligence
- **Weld Rejection Prediction:** Predict weld inspection issues based on WPS parameters, welder history, material combination
- **Material Rejection Prediction:** Predict material rejection risk from supplier history, material type, and MTR analysis
- **Inspection Coverage Forecasting:** Predict inspection completion against construction progress to identify potential delays
- **Turnover Readiness:** Predict system turnover readiness based on inspection completion and documentation status

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for quality, legal, and safety reasons:

**Non-Delegable Human Decisions:**
1. Material acceptance and rejection decisions
2. Weld disposition decisions (repair, accept-as-is, reject)
3. Hold point clearance and sign-off
4. NDT acceptance and rejection decisions
5. Quality dossier and turnover package final sign-off
6. Pressure test authorization and result acceptance
7. Dimensional tolerance deviation approval
8. Structural acceptance decisions

**AI Must Always Disclose:**
1. When inspection data is incomplete or measurements are outside tolerance
2. When MTR data cannot be verified against specification
3. When NDT results are outside acceptance criteria
4. When weld inspection indicates potential defects requiring human verification
5. What specialist input is required (certified NDT personnel for NDT decisions)
6. What physical inspection items require human verification
7. What measurements are outside specification tolerance
8. What material traceability gaps affect installed work
9. What quality records are missing from turnover packages

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from inspection records, MTRs, NDT results |
| **MTR verification** | Structured data parser for material certificates; LLM verifies against spec requirements |
| **Dimensional analysis** | Dedicated measurement processing; LLM works from structured dimensional data only |
| **NDT coordination** | Integration with NDT databases; LLM handles scheduling and result processing |
| **Weld inspection** | Structured weld data with CV for weld profile analysis from photos |
| **Knowledge retrieval** | RAG pattern for inspection procedures, welding codes (ASME, AWS), material specifications |
| **Computer vision** | Dedicated CV models for weld defect detection from visual inspection photos |
| **Audit trail** | Immutable log of all QC actions with provenance tags for measurements and test results |

## AI Agent Coordination Workflow

```
Work Package Approved for Construction
    → Material Verification Agent receives incoming material notifications
    → MTR Review Agent verifies material certificates against specification
    → If MTR fails: flag for human inspector, quarantine material
    → Material Verification Agent processes material acceptance/rejection
    → Weld Inspection Agent processes weld records
    → NDT Coordination Agent schedules and tracks NDT activities
    → Dimensional Verification Agent processes measurement records
    → Pressure Testing Agent tracks hydrotest completion
    → As quality records complete: Dossier Compilation Agent assembles turnover package
    → QC Manager reviews: verifies package completeness and signs off
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for QC AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all QC actions** with audit trail for quality compliance
6. **Never let LLM process raw inspection findings** — always route through structured data pipelines first

### QC Boundary Enforcement
1. **Never allow AI to accept materials without MTR verification** — always verify certificates first
2. **Never allow AI to approve weld dispositions** — always require welding inspector review
3. **Never allow AI to bypass hold point clearance** — always require inspection clearance documentation
4. **Always disclose AI limitations** — code coverage, specification currency, data completeness
5. **Always maintain immutable audit trail** — all QC outputs with provenance for measurements and test results
6. **Always tag QC data** with provenance (source record, inspector, date, equipment)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs inspection records
- **Timeliness**: 80%+ reduction in QC documentation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of inspection reports generated within required timeframes

### MTR Review Metrics
- **Review Accuracy**: 99%+ of MTR properties verified against specification
- **Detection Coverage**: 100% of out-of-specification items identified
- **Review Time**: 90%+ reduction in MTR review time vs manual verification
- **Traceability**: 100% of reviewed MTRs traceable to heat/batch numbers

### Weld Inspection Metrics
- **Weld Tracking Completeness**: 100% of welds tracked from WPS to NDT clearance
- **NDT Coverage**: 100% of required NDT activities completed and documented
- **Report Accuracy**: 99%+ accuracy in weld inspection report generation
- **Trend Detection**: 90%+ of weld quality trends detected before systemic issues

### Dimensional Inspection Metrics
- **Processing Accuracy**: 100% of measurements compared against correct tolerances
- **Out-of-Tolerance Detection**: 100% of out-of-tolerance items identified
- **Report Generation**: 80%+ reduction in dimensional report preparation time
- **Trend Detection**: 90%+ of progressive tolerance shifts detected before exceeding limits

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of QC workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of QC actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Quality Control Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety, Civil Engineering, IT, Inspection, QA domains
- Created QC-specific use case templates for material acceptance, weld inspection, dimensional verification, and agent orchestration
- Defined automation spectrum for all QC operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added dimensional analysis and MTR processing pipelines with tolerance verification and provenance tracking
- Included weld inspection patterns with CV-based weld profile analysis
- Detailed success metrics for all AI capabilities
- Added implementation best practices and QC boundary enforcement

## Quality Control AI Agent Behavioral Rules

### Non-Negotiable Rules for All QC AI Agents

1. **Material Conformance Rule:** Never accept materials without verified MTRs and specification compliance. If certification is missing, the agent must flag and quarantined the material for human inspector review.

2. **Weld Quality Rule:** Never approve weld quality without verified welder qualifications, approved WPS, and acceptable inspection/NDT results. If any component is missing, flag as "requires review."

3. **No Measurement Fabrication Rule:** Never invent measurement values, dimensional findings, or inspection observations. Only use data from verified inspection records and calibrated equipment.

4. **Provenance Tracking Rule:** All QC-derived values must carry provenance tags (source record, inspector, date, equipment). Never present inspection data without its source attribution.

5. **No Guessing Rule:** If inspection data is incomplete, measurements are outside tolerance, or specification requirements are unclear, flag as "not verified — requires inspection." Never assume compliance.

6. **Code Reference Rule:** When making compliance assertions, cite the applicable code or specification clause (e.g., "AWS D1.1 Table 5.1"). If uncertain, state "I would need to verify against [specific code/specification]."

7. **Hold Point Integrity Rule:** Never allow work to proceed past a hold point without signed inspection clearance. Always hold for human inspector verification at defined hold points.

8. **Traceability Rule:** Ensure all inspection data is traceable to ITP items, MTRs, and applicable standards. If traceability is lost, flag for investigation.

9. **Respect Non-Delegable Decisions:** Never accept materials without MTR verification, approve weld dispositions, or sign off inspections not verified. These require human inspector judgment and authority.

10. **Audit Trail Rule:** All AI outputs, measurements, and compliance assessments must be recorded with full audit trail for quality compliance, turnover documentation, and regulatory review.
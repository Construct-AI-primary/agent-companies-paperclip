---
title: 02075 Inspection AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement Inspection features including ITP generation, MTR review, dimensional inspection workflows, NDT coordination, coating inspection, and hold point management with structured data architecture and inspection safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02075_inspection/agent-data/prompts
gigabrain_tags: disciplines, 02075_inspection, ai-native-operations, document-generation, inspection-and-testing, mtr-review, dimensional-control, ndt-coordination, multi-agent-orchestration, computer-vision, code-compliance
openstinger_context: inspection-ai-native-operations, automated-documentation, agent-integration, code-generation
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_REVIEW_REMEDIATION_PROCEDURE.md
---

# 02075 Inspection AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement Inspection features on engineering and construction projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant inspection code covering ITP generation, MTR review, dimensional inspection workflows, NDT coordination, coating inspection, and hold point management. Use this prompt when agents are developing inspection components, workflows, APIs, or UI elements.

**Key Lessons from Safety, Civil, and IT Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what inspection code they can generate independently vs. what requires human architect review. The inspection data and code generation pipelines must never allow LLMs to fabricate measurement values or bypass hold point requirements.

**Important:** This prompt is for **OpenClaw coding agents operating in dev mode**. Agents use this prompt to **generate, modify, and validate code**. This prompt is NOT for the running application in production. The automation spectrum defines what **code** agents can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Geometry-Native Architecture
- [ ] **Classify all inspection data sources** — Tag each input as text-native (ITPs, reports, MTRs), geometry-native (dimensional records, survey data), image-native (inspection photos, coating DFT images), or structured data (PMI results, hydrotest data)
- [ ] **Implement dimensional data processing pipeline** — Measurement input → schema validate → tolerance check → report generation
- [ ] **Implement MTR review pipeline** — Material certificate input → parse → spec comparison → compliance verification
- [ ] **Build extraction schemas per inspection type** — Incoming inspection, in-process inspection, dimensional inspection, coating inspection, NDT coordination
- [ ] **Implement provenance tracking** — Every measurement and inspection value tagged with source record, inspector, date, equipment
- [ ] **Enforce guard rails** — LLM cannot create/edit inspection findings without structured data; must flag missing data as "not inspected"

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all inspection document templates (ITPs, inspection reports, hold point clearances, NCRs, calibration records)
- [ ] **Implement structured data injection** — Template engine fills placeholders from inspection records, MTRs, dimensional data (not raw LLM text)
- [ ] **Develop Phase 1 documents (Pre-Construction)** — ITPs, inspection procedures, calibration schedules, incoming inspection checklists
- [ ] **Develop Phase 2 documents (Fabrication)** — Material verification reports, welding inspection records, NDT reports, dimensional inspection records
- [ ] **Develop Phase 3 documents (Installation)** — Erection inspection records, alignment checklists, equipment inspection reports
- [ ] **Develop Phase 4 documents (Commissioning)** — Hydrotest checklists, pre-commissioning clearance, handover clearance, quality dossiers
- [ ] **Add quality validation** — Automated completeness checks, code compliance verification against ASME, AWS, API
- [ ] **Implement version control** — Document revision tracking with immutable audit trail

### Phase 3: Multi-Agent Inspection Orchestration
- [ ] **Implement ITP Generation Agent** — Auto-generate inspection and test plans from work packages and specifications
- [ ] **Implement MTR Review Agent** — Parse material test reports, compare against specification requirements
- [ ] **Implement Dimensional Inspection Agent** — Process measurement data, check against tolerances, generate reports
- [ ] **Implement NDT Coordination Agent** — Schedule NDT activities, track coverage, verify certification
- [ ] **Implement Coating Inspection Agent** — Process DFT readings, surface preparation assessment, coating reports
- [ ] **Implement NCR Generation Agent** — Auto-draft non-conformance reports from inspection findings
- [ ] **Implement Hold Point Management Agent** — Track hold point status, generate clearance certificates
- [ ] **Implement agent coordination layer** — ITP → Material verification → Incoming inspection → In-process → Final clearance workflow

### Phase 4: Computer Vision & Site Imaging
- [ ] **Implement coating surface defect detection** — Analyze site photos for coating defects, blistering, peeling
- [ ] **Develop weld bead profile assessment** — Verify weld profile from photos against WPS acceptance criteria
- [ ] **Implement surface preparation verification** — Verify surface preparation standards (SA 2.5, SA 3.0) from photos
- [ ] **Develop dimensional measurement from photos** — Extract dimensional data from calibrated photos (where applicable)
- [ ] **Implement alert system** — Real-time notifications for detected coating defects, weld deficiencies

### Phase 5: Natural Language Inspection Interface
- [ ] **Implement Code Query Assistant** — "What does AWS D1.1 require for root penetration?" → exact clause + plain language
- [ ] **Develop Checklist Query Assistant** — "What are the hold points for pipe hydrotest?" → checklist extraction
- [ ] **Implement MTR Review Assistant** — "Does this MTR meet the SA-106 Gr B requirements?" → compliance status
- [ ] **Develop Precedent Research** — "Show me similar weld inspection scenarios from past projects" → search knowledge base
- [ ] **Implement chatbot with inspection boundaries** — Cannot accept materials without certification, cannot bypass hold points

### Phase 6: Measurement Intelligence & Dimensional Analysis
- [ ] **Implement dimensional data analysis** — Compare measurement data against IFC drawings and tolerances
- [ ] **Develop alignment verification** — Verify equipment alignment from measurement records
- [ ] **Implement tolerance trending** — Track dimensional trends across construction, identify developing issues
- [ ] **Develop survey data integration** — Process survey records, compare against design positions
- [ ] **Implement dimensional dashboard** — Real-time dimensional status visualization with tolerance status

### Phase 7: Data-Driven Inspection Operations
- [ ] **Implement inspection coverage tracking** — Correlate inspection completion against construction progress
- [ ] **Develop weld rejection prediction** — Predict weld issues from WPS parameters and inspection history
- [ ] **Implement coating failure trending** — Track coating DFT results, identify application issues
- [ ] **Develop NCR trend analysis** — Analyze non-conformance frequency by activity, vendor, or material
- [ ] **Implement dashboard interface** — Real-time inspection visualization with trend analysis

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Hold point acceptance always requires human inspector sign-off
- [ ] **Develop uncertainty disclosure** — AI must disclose when specification requirements ambiguous, inspection data incomplete
- [ ] **Implement immutable audit trail** — Log all inspection outputs with provenance tags for measurements and findings
- [ ] **Develop human review gates** — Material acceptance, structural sign-off, pressure test clearance require human validation
- [ ] **Implement data retention requirements** — Compliance with inspection record retention and turnover package requirements

## Discipline Context

### 02075 Inspection Scope
The 02075 Inspection discipline encompasses:
- **AI-Native Operations**: Automating inspection documentation from ITP generation to clearance certificates
- **ITP Generation Pipeline**: Automated inspection plan generation from work packages and specifications
- **MTR Review Pipeline**: Material test report parsing, verification against specification requirements
- **Dimensional Analysis Pipeline**: Measurement processing, tolerance verification, report generation
- **NDT Coordination**: NDT scheduling, certification tracking, coverage verification
- **Coating Inspection**: DFT reading processing, surface preparation verification, defect detection
- **Hold Point Management**: Hold point tracking, clearance certificate generation, status monitoring
- **Inspection Governance**: AI boundaries, human review gates, audit trails, inspector sign-off

### Related Disciplines
- **02200 Quality Assurance**: Inspection planning integration, quality system requirements
- **02250 Quality Control**: Inspection activities, dimensional control, verification
- **00850 Civil Engineering**: Construction inspection, concrete inspection requirements
- **00870 Mechanical Equipment**: Equipment inspection, fabrication hold points
- **00860 Electrical**: Electrical installation inspection
- **00855 Geotechnical**: Soil and foundation inspection requirements

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02075 Inspection AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 7 in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02075_inspection", "ai-native-operations", "[specific-capability]"
- Filter by tags: "inspection-and-testing", "mtr-review", "dimensional-control", "ndt-coordination", "code-compliance", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with inspection domain knowledge and glossary
- Check memory for recent inspection AI implementation patterns

**Inspection AI-Native Context:**
- Reference text-native, geometry-native, image-native, and structured data input classification
- Apply dimensional data processing pipeline (measurement → tolerance check → report)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (hold point sign-off, material acceptance)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar inspection AI implementations
- Build on established inspection organizational knowledge
- Ensure compliance with inspection codes (ASME, AWS, API) and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Inspection AI-Native Use Case Templates

### ITP Generation Pipeline Execution
```
Generate Inspection and Test Plan for [WORK_PACKAGE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_DOMAIN-KNOWLEDGE.MD
- Reference ITP generation: Part 7, Phase 2
- Check applicable codes and standards: Part 1.3

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02075_inspection", "inspection-and-testing", "[work-package-type]"
- Filter by tags: "itp-generation", "hold-point-definition", "acceptance-criteria"

Memory Context:
- Include memory headers with ITP generation gigabrain_tags
- Cross-reference with quality system requirements
- Reference historical ITP templates for similar work packages

INSPECTION AI-NATIVE CONTEXT:
- Apply automated ITP generation from work package specifications
- Define hold points, witness points, and review points from specification requirements
- Set inspection methods and acceptance criteria per applicable codes (ASME, AWS, API)
- Generate ITP with traceability to work package and specification clauses

Provide ITP generation with:
- Work package and specification analysis for inspection requirements
- Inspection activity identification and sequencing
- Hold point and witness point definition with appropriate authority levels
- Inspection methods and acceptance criteria per applicable standards
- Responsibilities and documentation requirements
- Template structure with all required fields mapped to specification clauses
```

### MTR Review Pipeline Execution
```
Review Material Test Report for [MATERIAL_SPEC]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_DOMAIN-KNOWLEDGE.MD
- Reference MTR review: Part 7, Part 2.1 (Incoming Inspection)
- Check material specification requirements in relevant standard

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02075_inspection", "mtr-review", "[material-type]"
- Filter by tags: "material-verification", "certificate-checking", "compliance-assessment"

Memory Context:
- Include memory headers with MTR review gigabrain_tags
- Cross-reference with material specification requirements
- Reference historical MTR review patterns

INSPECTION AI-NATIVE CONTEXT:
- Apply MTR review pipeline: Certificate input → Parse → Spec comparison → Compliance verification
- Verify chemical composition against specification requirements
- Verify mechanical properties against specification minimums
- Flag any values outside tolerance for human inspector review

Provide MTR review with:
- MTR parsing and data extraction (chemical composition, mechanical properties)
- Specification requirements lookup for the specific material grade
- Compliance assessment for each property and element
- Discrepancies and out-of-specification items identified
- Recommendation for human inspector review on any ambiguous items
- Provenance tracking: source MTR, heat/batch number, review date
```

### Dimensional Inspection Pipeline
```
Process Dimensional Inspection for [COMPONENT]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_DOMAIN-KNOWLEDGE.MD
- Reference dimensional inspection: Part 2.2 (In-Process Inspection)
- Check dimensional tolerances in applicable standard (ASME, AWS)

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02075_inspection", "dimensional-control", "[component-type]"
- Filter by tags: "dimensional-verification", "tolerance-checking", "measurement-processing"

Memory Context:
- Include memory headers with dimensional inspection gigabrain_tags
- Cross-reference with design tolerances and specification requirements
- Reference historical dimensional inspection records

INSPECTION AI-NATIVE CONTEXT:
- Apply dimensional inspection pipeline: Measurement input → Schema validate → Tolerance check → Report generation
- Verify measurements against IFC drawing dimensions and tolerances
- Apply appropriate tolerance standards per component type and specification
- Generate inspection report with pass/fail determination

Provide dimensional inspection processing with:
- Measurement data validation (required points, calibration status)
- Tolerance application per applicable standard (ASME, AWS, project specifications)
- Compliance assessment for each measured dimension
- Out-of-tolerance items identified for human inspector review
- Dimensional inspection report generation with provenance tracking
- Trend analysis for progressive tolerances (alignment, level, plumbness)
```

### Multi-Agent Inspection Orchestration
```
Coordinate Inspection Workflow for [WORK_PACKAGE]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 7D
- Check agent definitions and capabilities documentation

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02075_inspection", "multi-agent-orchestration", "[inspection-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and inspection workflows
- Reference completed implementations of similar inspection workflows

INSPECTION AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: ITP Generation → Material verification → Incoming inspection → In-process inspection → Dimensional check → NDT coordination → Final clearance
- Define data formats passed between agents (structured JSON, not free text)
- Implement inspection boundaries: no agent can accept materials without MTR verification, no agent can bypass hold point clearance

Provide agent orchestration implementation with:
- Agent coordination sequence with hold point triggers
- Data schema passed between agents (MTR data, measurement data, inspection results)
- Error handling and escalation when agent cannot process (missing MTR, out-of-tolerance measurement)
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow (final sign-off at hold points)
- Audit trail tracking for all inspection actions and decisions
```

## Automation Spectrum for Inspection Operations Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **ITP Template Generation** | Work package approved | Work package spec, applicable codes | Auto-validation: all hold points identified, criteria specified |
| **MTR Data Verification** | MTR received | MTR data, specification requirements | Auto-validation: chemical and mechanical properties compared |
| **Dimensional Report Draft** | Measurements received | Measurement data, tolerance standards | Auto-validation: measurements compared against tolerances |
| **Calibration Schedule** | Equipment registered | Equipment list, calibration intervals | Auto-validation: intervals per manufacturer, tracking complete |
| **Daily Inspection Summary** | Inspection complete | Daily inspection records | Auto-validation: all hold points documented |
| **NDR (Non-Conformance) Draft** | NCR identified | Findings, specification violations | Auto-validation: findings described, reference clause identified |

### Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Material Acceptance Recommendation** | Compare MTR against all spec requirements | Inspector makes final acceptance decision | Human |
| **Dimensional Analysis Report** | Process measurements, identify out-of-tolerance items | Engineer assesses deviation, determines acceptance | Human |
| **Coating Inspection Report** | Process DFT readings, identify areas outside tolerance | Inspector verifies, assesses adhesion | Human |
| **NDT Coverage Analysis** | Track NDT completion against ITP requirements | NDT coordinator reviews, certifies coverage | Human |
| **Weld Inspection Assessment** | Review WPS, weld records, NDT results | Welding inspector assesses, signs off | Human |
| **Pre-Commissioning Clearance** | Compile test results, verify all requirements met | Lead inspector reviews, authorizes clearance | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Hold Point Acceptance** | Compile inspection results, code references, photos | Inspector signs off or rejects |
| **Material Rejection** | Present MTR discrepancies, specification violations | Inspector makes final rejection decision |
| **Weld Repair Approval** | Compile welding defects, repair procedure, re-inspection results | Welding inspector approves repair |
| **Structural Acceptance** | Compile dimensional records, welding records, NDT results | Lead inspector approves structural completion |
| **Pressure Test Authorization** | Compile test preparation checklist, equipment verification | Authorized inspector authorizes test |
| **Handover Clearance** | Compile all inspection records, test results, NCR closures | Lead inspector issues handover clearance |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (ITPs, MTRs, measurement records, inspection findings)
    ↓
STRUCTURED DATA VALIDATION (schema, units, ranges, completeness)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, applicable code, project requirements)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, code compliance, tolerance verification)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — hold point sign-off, material acceptance, structural acceptance)
    ↓
FINAL APPROVAL (authorized inspector for hold point acceptance, structural acceptance)
    ↓
OUTPUT GENERATION (PDF, structured forms, turnover package)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & TURNOVER
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (ITPs, MTRs, measurement records, inspection findings). The LLM structures and formats, but does not invent measurements or inspection findings.
2. **Provenance Tracking**: Every measurement, inspection record, and MTR value injected into a template is tagged with its source (e.g., "measurement from dimensional survey #234, location: column C-5, inspector: John Smith, date: 2026-04-01").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data availability (e.g., "if NDT not required, omit NDT section").
4. **Code Compliance and Accuracy**: Templates must reference the applicable code clauses and acceptance criteria. Code updates trigger template reviews.
5. **Multi-Format Output**: Construction-phase documents (checklists, field inspection forms) and formal reports (inspection reports, clearances) must both be supported.
6. **Traceable and Auditable**: All inspection documentation must be traceable to ITP items, work packages, and specification clauses.

## AI-Native Inspection Capabilities Beyond Automation

### Computer Vision & Site Image Analysis
- **Coating Surface Defect Detection:** Analyze site photos for coating defects (blistering, peeling, pinholes); auto-classify defect type and severity per ISO 4628, NACE standards
- **Weld Bead Profile Assessment:** Verify weld profile from photos against WPS acceptance criteria; identify visual defects (undercut, incomplete penetration, excessive reinforcement)
- **Surface Preparation Verification:** Verify surface preparation (SA 2.5, SA 3.0) from site photos; compare against reference images
- **Dimensional Measurement from Photos:** Extract dimensional data from calibrated photos where applicable (for large, well-lit components)

### Measurement Intelligence
- **Dimensional Data Analysis:** Compare measurement data against IFC drawings and tolerances; auto-flag out-of-tolerance items
- **Alignment Verification:** Verify equipment alignment from measurement records; identify developing alignment issues
- **Tolerance Trending:** Track dimensional trends across construction; identify progressive tolerance shifts before they exceed limits
- **Survey Data Integration:** Process survey records, compare against design positions; generate deviation reports

### Natural Language Inspection Interface
- **Code Query Assistant:** "What does AWS D1.1 require for root penetration?" → returns exact clause + plain-language explanation
- **Checklist Query Assistant:** "What are the hold points for pipe hydrotest?" → returns ITP-derived checklist
- **MTR Review Assistant:** "Does this MTR meet SA-106 Gr B requirements?" → returns compliance status with evidence
- **Specification Cross-Reference:** "What are the PMI requirements for alloy materials?" → returns applicable specification clauses

### Predictive Intelligence
- **Weld Rejection Prediction:** Predict weld inspection issues based on WPS parameters, welder history, material combination
- **Coating Failure Trending:** Predict coating failures from environmental conditions, application records, DFT history
- **Inspection Coverage Forecasting:** Predict inspection completion against construction progress to identify potential delays
- **NCR Trend Analysis:** Analyze NCR frequency by activity, vendor, or material to identify systemic issues

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for legal, quality, and safety reasons:

**Non-Delegable Human Decisions:**
1. Final acceptance sign-off at hold points
2. Material rejection decisions based on inspection results
3. Weld repair approval and re-inspection acceptance
4. Structural acceptance of critical components
5. Pressure test clearance and authorization
6. Coating system failure determination
7. Dimensional tolerance deviation approval
8. Handover and turnover clearance issuance

**AI Must Always Disclose:**
1. When specification requirements are ambiguous or outdated
2. When inspection data is incomplete or measurements are outside calibration
3. When AI confidence in compliance assessment is below threshold
4. When code interpretation may have jurisdiction-specific variations
5. What specialist input is required (NDT certified personnel for NDT assessment)
6. What physical inspection items require human verification
7. What measurements are outside specification tolerance
8. What MTR data is missing or cannot be verified against specification

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from inspection records, ITPs, MTRs |
| **ITP generation** | Specification parser + work package analyzer + template engine for ITP generation |
| **MTR review** | Structured data parser for material certificates; LLM verifies against spec requirements |
| **Dimensional analysis** | Dedicated measurement processing; LLM works from structured dimensional data only |
| **Coating inspection** | Structured data injection for DFT; CV for surface defect detection from photos |
| **NDT coordination** | Integration with NDT databases; LLM handles scheduling and coverage tracking |
| **Code compliance checking** | Vector database (RAG) for codes, standards, specifications (AWS, ASME, API) |
| **Computer vision** | Dedicated CV models for coating defect detection and surface preparation assessment |
| **Knowledge retrieval** | RAG pattern for inspection procedures, MTR templates, specification clauses |
| **Audit trail** | Immutable log of all inspection outputs with provenance tags for all measurements and findings |

## AI Agent Coordination Workflow

```
Work Package Approved for Inspection
    → ITP Generation Agent creates inspection plan with hold points
    → Material Verification Agent receives incoming material notifications
    → MTR Review Agent verifies material certificates against spec
    → If MTR fails: flag for human inspector, segregate material
    → Incoming Inspection Agent processes material acceptance/rejection
    → In-Process Inspection Agent monitors construction progress at hold points
    → Dimensional Inspection Agent processes measurement records
    → NDT Coordination Agent schedules and tracks NDT activities
    → If hold point reached: pause workflow, notify inspector
    → Inspector clears hold point: resume workflow
    → Coating Inspection Agent processes coating records and DFT readings
    → As inspection records complete: Final Clearance Agent tracks completion
    → Pre-Commissioning Agent verifies all tests completed and documented
    → Handover Clearance Agent compiles turnover package and issues clearance
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for inspection AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all inspection actions** with audit trail for quality compliance
6. **Never let LLM process raw inspection findings** — always route through structured data pipelines first

### Inspection Boundary Enforcement
1. **Never allow AI to accept materials without MTR verification** — always verify certificates first
2. **Never allow AI to bypass hold point clearance** — always require inspection clearance documentation
3. **Never allow AI to sign off inspections for work not verified** — always require evidence of inspection
4. **Always disclose AI limitations** — code coverage, specification currency, data completeness
5. **Always maintain immutable audit trail** — all inspection outputs with provenance for measurements
6. **Always tag inspection data** with provenance (source record, inspector, date, equipment)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs inspection records
- **Timeliness**: 80%+ reduction in inspection documentation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of inspection reports generated within required timeframes

### MTR Review Metrics
- **Review Accuracy**: 99%+ of MTR properties verified against specification
- **Detection Coverage**: 100% of out-of-specification items identified
- **Review Time**: 90%+ reduction in MTR review time vs manual verification
- **Traceability**: 100% of reviewed MTRs traceable to heat/batch numbers

### Dimensional Inspection Metrics
- **Processing Accuracy**: 100% of measurements compared against correct tolerances
- **Out-of-Tolerance Detection**: 100% of out-of-tolerance items identified
- **Report Generation**: 80%+ reduction in dimensional report preparation time
- **Trend Detection**: 90%+ of progressive tolerance shifts detected before exceeding limits

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of inspection workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of inspection actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-04-01): Initial AI-Native Inspection Operations Prompt Template
- Added structured metadata header following established pattern
- Incorporated lessons learned from Safety, Civil Engineering, and IT domains
- Created inspection-specific use case templates for ITP generation, MTR review, dimensional inspection, and agent orchestration
- Defined automation spectrum for all inspection operations tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added dimensional analysis pipeline with tolerance verification and provenance tracking
- Included coating inspection patterns with CV-based defect detection
- Detailed success metrics for all AI capabilities
- Added implementation best practices and inspection boundary enforcement

## Inspection AI Agent Behavioral Rules

### Non-Negotiable Rules for All Inspection AI Agents

1. **Material Conformance Rule:** Never accept materials without verified MTRs and specification compliance. If certification is missing, the agent must flag and segregate the material for human inspector review.

2. **Hold Point Integrity Rule:** Never allow work to proceed past a hold point without signed inspection clearance. Always enforce hold point requirements per the ITP.

3. **No Measurement Fabrication Rule:** Never invent measurement values, dimensional findings, or inspection observations. Only use data from verified inspection records and calibrated equipment.

4. **Provenance Tracking Rule:** All inspection-derived values must carry provenance tags (source record, inspector, date, equipment). Never present inspection data without its source attribution.

5. **No Guessing Rule:** If inspection data is incomplete, measurements are outside tolerance, or specification requirements are unclear, flag as "not verified — requires inspection." Never assume compliance.

6. **Specialist Referral Rule:** When inspection requires certified personnel (NDT assessment, specific code interpretation), explicitly recommend specialist input. Never substitute AI analysis for certified specialist assessment.

7. **Code Reference Rule:** When making compliance assertions, cite the applicable code or specification clause (e.g., "AWS D1.1 Clause 5.14"). If uncertain, state "I would need to verify against [specific code/specification]."

8. **Documentation Rule:** All inspection outputs should be structured for formal inspection reports and quality dossiers. Use formal, auditable language that meets project quality standards.

9. **Respect Non-Delegable Decisions:** Never accept materials without MTR verification, bypass hold points, or sign off on items not personally inspected. These require human inspector judgment and authority.

10. **Audit Trail Rule:** All AI outputs, measurements, and compliance assessments must be recorded with full audit trail for quality compliance, turnover documentation, and regulatory review.
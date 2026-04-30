---
title: 00850 Civil Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement civil engineering features including DWG processing pipelines, BIM intelligence, document generation, engineering calculations, and construction monitoring with structured data architecture and engineering safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00850_civil-engineering, ai-native-operations, document-generation, dwg-processing, bim-intelligence, multi-agent-orchestration, computer-vision, mobile-integration, code-generation
openstinger_context: civil-engineering-ai-native-operations, automated-documentation, dwg-extraction, agent-integration, code-generation
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_GLOSSARY.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/agent-data/00850_CIVIL_AGENT_SKILL_MAPPING.MD
  - docs_construct_ai/disciplines/00850_civil-engineering/plan/0000_AI-NATIVE-REMEDIATION-PLAN.MD
---

# 00850 Civil Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement civil engineering features on large engineering, infrastructure, and architectural projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant civil engineering code covering DWG processing pipelines, BIM intelligence, document generation, engineering calculations, and construction monitoring. Use this prompt when agents are developing civil engineering components, workflows, APIs, or UI elements.

**Key Lesson from Safety and Procurement Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what civil engineering code they can generate independently vs. what requires human architect review. The DWG/BIM processing pipelines must never allow LLMs to fabricate geometry-derived values.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Geometry-Native Architecture
- [ ] **Classify all civil engineering data sources** — Tag each input as text-native (LLM-friendly) or geometry-native (requires extraction pipeline)
- [ ] **Implement DWG processing pipeline** — AUDIT → PURGE → OVERKILL → extract → schema validate → structured JSON
- [ ] **Build extraction schemas per drawing type** — Structural GA, Civil GA, Reinforcement, Drainage, P&ID
- [ ] **Implement provenance tracking** — Every geometry-derived value tagged with source drawing, revision, entity ID
- [ ] **Enforce guard rails** — LLM cannot create/edit geometry-derived fields; must flag missing data as "unknown"

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all civil engineering document templates (RFIs, NCRs, ITPs, method statements, specifications)
- [ ] **Implement structured data injection** — Template engine fills placeholders from BIM, surveys, databases (not raw LLM text)
- [ ] **Develop Phase 1 documents (Pre-Design)** — Feasibility reports, site assessment, concept brief, design basis
- [ ] **Develop Phase 2 documents (Design)** — Calculation summaries, stormwater reports, earthworks specs, BOQs
- [ ] **Develop Phase 3 documents (Construction)** — Method statements, ITPs, RFIs, NCRs, daily/weekly reports
- [ ] **Develop Phase 4 documents (Strategic)** — Tender docs, change orders, claims, expert opinions
- [ ] **Add quality validation** — Automated completeness checks, code compliance verification
- [ ] **Implement version control** — Document revision tracking with immutable audit trail

### Phase 3: Multi-Agent Civil Engineering Orchestration
- [ ] **Implement Site Assessment Agent** — Feasibility analysis from survey + geotechnical + constraints data
- [ ] **Implement Structural Analysis Agent** — Integration with analysis libraries (OpenSees, frames2D)
- [ ] **Implement Drainage Sizing Agent** — Rational method, Manning's equation, detention calculations
- [ ] **Implement BIM Clash Agent** — IFC model processing, clash detection, resolution options
- [ ] **Implement NCR/RFI Drafting Agent** — Auto-draft from site observations with clause references
- [ ] **Implement Quantity Take-Off Agent** — BIM/structured data extraction for BOQ generation
- [ ] **Implement Specification Compliance Agent** — Code/spec verification with clause references
- [ ] **Implement agent coordination layer** — RAMS → design → clash detection → BOQ → NCR/RFI workflow

### Phase 4: Computer Vision & Site Monitoring
- [ ] **Implement defect detection** — Honeycomb, spalling, rebar corrosion classification from site photos
- [ ] **Develop progress vs. drawing comparison** — Compare site photos against construction drawings
- [ ] **Implement erosion/sediment monitoring** — Detect silt fence failures, erosion patterns
- [ ] **Develop pavement condition monitoring** — Track cracking, rutting, pothole formation
- [ ] **Implement alert system** — Real-time notifications for detected defects, progress discrepancies

### Phase 5: Natural Language Engineering Interface
- [ ] **Implement Code Query Assistant** — "What is required concrete cover for XC3?" → exact clause + plain language
- [ ] **Develop Spec Compliance Checker** — "Does this mix meet clause 5.3.2?" → compliance status
- [ ] **Implement Drawing Query Assistant** — "Show all drainage outlets at level 2" → from structured data
- [ ] **Develop Precedent Research** — "Similar retaining wall solutions" → search project knowledge base
- [ ] **Implement chatbot with engineering boundaries** — Cannot give final design approval, cannot bypass specialist review

### Phase 6: BIM and Digital Model Intelligence
- [ ] **Implement automated clash detection** — Scan federated BIM models for structural/MEP/drainage conflicts
- [ ] **Develop quantity extraction from BIM** — Auto-extract material quantities from IFC/Revit for BOQ
- [ ] **Implement design change propagation** — When one element changes, identify all affected documents
- [ ] **Develop model health checking** — Validate BIM for missing properties, incorrect classifications
- [ ] **Implement 4D/5D BIM integration** — Construction sequencing and cost integration with models

### Phase 7: Data-Driven Engineering
- [ ] **Implement drainage performance monitoring** — Correlate rainfall with inspection data
- [ ] **Develop pavement condition prediction** — Predict deterioration from traffic, material, climate
- [ ] **Implement ground settlement prediction** — Monitor settlement data and forecast behavior
- [ ] **Develop material quality trending** — Track concrete test results, identify batch/supplier trends
- [ ] **Implement dashboard interface** — Real-time engineering visualization with trend analysis

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Final design sign-off always requires registered engineer
- [ ] **Develop uncertainty disclosure** — AI must disclose when design inputs unverified, calculations limited
- [ ] **Implement immutable audit trail** — Log all AI outputs with provenance tags for geometry-derived values
- [ ] **Develop human review gates** — Critical calculations, regulatory submissions require human validation
- [ ] **Implement data retention and privacy** — Compliance with project data, survey data privacy requirements

## Discipline Context

### 00850 Civil Engineering Scope
The 00850 Civil Engineering (HSE/HSSE) discipline encompasses:
- **AI-Native Operations**: Automating civil engineering work from document generation to predictive analytics
- **DWG Processing Pipeline**: Deterministic preprocessing, geometric extraction, schema validation
- **Document Generation Pipeline**: Four-phase automated document production (Pre-Design, Design, Construction, Strategic)
- **BIM Intelligence**: Clash detection, quantity extraction, design change propagation, model health checking
- **Multi-Agent Orchestration**: Coordinated agent workflow from site assessment through construction support
- **Computer Vision Integration**: Defect detection, progress monitoring, erosion detection
- **Natural Language Interface**: Code queries, spec checking, drawing queries, precedent research
- **Engineering Governance**: AI boundaries, human review gates, audit trails, registered professional sign-off

### Related Disciplines
- **00855 Geotechnical**: Foundation design, soil mechanics, slope stability
- **00872 Structural**: Load analysis, structural integrity, connection design
- **00825 Architectural**: Building layout, spatial requirements, egress design
- **01900 Procurement**: Contract formation, vendor management, tender documentation
- **01700 Logistics**: Material delivery, crane operations, site traffic management
- **01200 Finance**: Budget control, cost estimation, variation orders
- **02400 Safety**: Construction safety, permit-to-work, incident management

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 00850 Civil Engineering AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 6B in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "dwg-processing", "bim-intelligence", "multi-agent-orchestration", "computer-vision"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with civil engineering domain knowledge and glossary
- Check memory for recent civil engineering AI implementation patterns

**Civil Engineering AI-Native Context:**
- Reference text-native vs geometry-native input classification
- Apply DWG processing pipeline (preprocessing → extraction → validation → structured data → LLM)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (final design sign-off, regulatory submissions)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar civil engineering AI implementations
- Build on established civil engineering organizational knowledge
- Ensure compliance with engineering standards and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Civil Engineering AI-Native Use Case Templates

### DWG Processing Pipeline Execution
```
Process [DWG_TYPE] using DWG extraction pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
- Reference DWG processing pipeline: Part 6B, Section 6B.2
- Check docs_construct_ai/disciplines/00850_civil-engineering/agent-data/ for extraction schemas

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "dwg-processing", "[dwg-type]"
- Filter by tags: "geometric-extraction", "schema-validation", "provenance-tracking"

Memory Context:
- Include memory headers with DWG processing gigabrain_tags
- Cross-reference with agent capabilities and CAD systems
- Reference historical DWG processing patterns

CIVIL ENGINEERING AI-NATIVE CONTEXT:
- Apply DWG processing pipeline: AUDIT → PURGE → OVERKILL → extract → schema validate → structured JSON
- Use extraction schema for drawing type (Structural GA, Civil GA, Reinforcement, etc.)
- Enforce guard rails: LLM cannot create/edit geometry-derived fields
- Implement provenance tracking: source drawing, revision, entity ID

Provide DWG processing implementation with:
- Preprocessing steps (audit, purge, overkill, layer normalization)
- Extraction schema for drawing type with all required fields
- Schema validation rules (units, ranges, topology, consistency)
- Structured data output format (JSON/CSV schema)
- Provenance tagging implementation
- Human verification workflow before AI uses extracted data
```

### Document Generation Pipeline Execution
```
Implement [DOCUMENT_TYPE] generation using AI pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/00850_DOMAIN-KNOWLEDGE.MD
- Reference document generation pipeline: Part 6B, Section 6B.4
- Check docs_construct_ai/disciplines/00850_civil-engineering/agent-data/ for agent capabilities

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "document-generation", "[document-type]"
- Filter by tags: ["pre-design", "design", "construction", "strategic"] based on phase

Memory Context:
- Include memory headers with document-specific gigabrain_tags
- Cross-reference with related discipline requirements (structural, geotechnical)
- Reference historical document templates and patterns

CIVIL ENGINEERING AI-NATIVE CONTEXT:
- Apply document generation phase (Phase 1: Pre-Design, Phase 2: Design, Phase 3: Construction, Phase 4: Strategic/AI-Augmented)
- Use template engine with structured data injection from BIM, surveys, databases (not raw LLM text)
- Follow quality validation: completeness checks, code compliance verification
- Implement version control with immutable audit trail

Provide document generation implementation with:
- Template structure with all placeholders mapped to data sources
- Data extraction from source systems (BIM models, survey data, calculation results)
- Quality validation rules before document generation
- Human review requirements and validation checkpoints
- Output format specification (PDF, DOCX, structured JSON, Excel)
```

### BIM Intelligence Implementation
```
Implement [BIM_CAPABILITY] using BIM intelligence framework:

PARA Navigation:
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/
- Reference BIM intelligence: Part 6B, Section 6B.5
- Check docs_construct_ai/disciplines/00850_civil-engineering/agent-data/ for IFC processing capabilities

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "bim-intelligence", "[capability]"
- Filter by tags: "clash-detection", "quantity-extraction", "model-health", "change-propagation"

Memory Context:
- Include memory headers with BIM intelligence gigabrain_tags
- Cross-reference with IFC processing, structural data, MEP data
- Reference historical clash detection and quantity extraction patterns

CIVIL ENGINEERING AI-NATIVE CONTEXT:
- Apply BIM capability: Clash Detection, Quantity Extraction, Design Change Propagation, or Model Health Checking
- Use IFC processor for model data extraction (not LLM for raw BIM files)
- Implement structured data pipeline: IFC → JSON → analysis → report generation
- Define intervention recommendations for engineering team action

Provide BIM intelligence implementation with:
- IFC processing pipeline architecture
- Data extraction schema for required model elements
- Analysis or detection algorithm (clash detection, quantity calculation, etc.)
- Output format (clash report, BOQ, change impact list, health report)
- Integration with document generation pipeline for report output
- Human review requirements for BIM-derived data
```

### Multi-Agent Civil Engineering Orchestration
```
Coordinate multi-agent workflow for [CIVIL_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/00850_civil-engineering/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 6B, Section 6B.6
- Check docs_construct_ai/disciplines/00850_civil-engineering/agent-data/ for agent definitions

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and data formats
- Reference completed implementations of similar workflows

CIVIL ENGINEERING AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Site Assessment → Foundation Design → Drainage → Clash Detection → BOQ → NCR/RFI → Compliance → Schedule
- Define data formats passed between agents (structured JSON, not free text)
- Implement engineering boundaries: no agent can approve final designs, no agent can override specialist review

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents
- Error handling and escalation when agent cannot process
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow
- Audit trail tracking for all agent actions and decisions
```

## Automation Spectrum for Civil Engineering Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Specification Query** | Engineer query | Spec database, code library | Auto-validation: clause exists, context relevant |
| **RFI Draft** | Site observation | Observation notes, drawing refs, proposed solution | Auto-validation: all required fields, clause references valid |
| **NCR Generation** | Defect identified | Photos, notes, spec violations | Auto-validation: defect described, reference clause identified |
| **Quantity Take-Off (structured data)** | BIM/structured data available | BIM schedules, CAD exports | QS verification before commercial use |
| **Method Statement Draft** | Work package defined | Template, project scope, safety requirements | Engineer reviews for constructability |
| **ITP Generation** | Spec + scope loaded | Specifications, testing requirements | QA manager approves hold points |
| **BIM Clash Report** | Model update | IFC/Revit models from all disciplines | Coordinator reviews, prioritizes resolution |
| **Cross-Reference Check** | Document update | Drawings, specs, BOQs | Engineer investigates flagged mismatches |
| **Daily/Weekly Reports** | Site data submitted | Progress, issues, weather, workforce | Engineer reviews before distribution |
| **Drawing Notes & Legends** | Drawing data structured | Structured design data | CAD/BIM coordinator verifies |

### AI-Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Preliminary Structural Sizing** | Hand-calculation estimates, sanity checks, code clauses | Structural engineer performs final design and verification | Human |
| **Drainage Pipe Sizing** | Rational method, Manning's equation, velocity checks | Hydraulic engineer verifies, SWMM calibration if complex | Human |
| **Foundation Recommendation** | Borehole analysis, type recommendation, preliminary sizing | Geotechnical specialist validates, performs detailed analysis | Human |
| **Earthworks Volumes** | Cut/fill calculations from survey data, cross-section analysis | Engineer verifies, adjusts for shrinkage/swell factors | Human |
| **Schedule Impact Analysis** | P6/MSP parsing, critical path identification | Planner/PM validates and decides recovery strategy | Human |
| **Cost Estimation (OM)** | Unit rates × quantities from BOQ, benchmarks | QS verifies, market rates confirmed | Human |
| **Site Feasibility** | Survey, flood zone, geotechnical analysis, risk assessment | Senior engineer reviews, site visit confirms | Human |
| **Tender Documentation** | Specs, BOQ, drawings compilation | QS reviews, engineer approves | Human |
| **Design Review Report** | Review findings compilation, recommendations | Lead reviewer finalizes | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Final Design Approval** | Compile calculations, checklists, code references | Registered professional engineer signs off |
| **Geotechnical Interpretation** | Organize borehole data, flag anomalies | Geotechnical specialist interprets, recommends |
| **Construction Method Selection** | Precedent data, constructability analysis, risks | Engineer selects based on site conditions |
| **Regulatory Submissions** | Compile evidence, draft submissions, format | Engineer/registered professional reviews and submits |
| **Structural/GEO Safety Decisions** | Analysis results, risk data, code references | Registered engineer makes safety-critical decisions |
| **Expert Witness Testimony** | Compile analysis, prior precedents | Registered professional signs expert opinion |
| **Variation Orders (structural impact)** | Draft change description, cost/time impact | Engineer approves structural implications |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (BIM, surveys, calculations, site data)
    ↓
STRUCTURED DATA VALIDATION (schema, units, ranges, completeness)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, project context)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, accuracy, code compliance)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — design calculations, regulatory submissions)
    ↓
FINAL APPROVAL (registered professional for critical documents)
    ↓
OUTPUT GENERATION (PDF, DOCX, Excel, structured JSON)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (BIM, surveys, databases). The LLM structures and formats, but does not invent facts or numbers.
2. **Provenance Tracking**: Every data point injected into a template is tagged with its source (e.g., "quantity from BIM_model_v3, element: beam_B201, extracted: 2026-03-31"). Geometry-derived values additionally include source drawing, revision, and entity ID.
3. **Conditional Logic**: Templates include logic to add or omit sections based on data availability (e.g., "if SWMM calibration not performed, omit 'Calibration Results' section").
4. **Regulatory Accuracy**: Templates must be kept current with applicable codes and standards. Code updates trigger template reviews.
5. **Multi-Language Support**: Construction-phase documents (method statements, safety notices) must support all languages represented on site.
6. **Human Readable with Data Export**: All generated documents are human-readable and simultaneously exportable as structured data for analytics and regulatory reporting.

## AI-Native Civil Engineering Capabilities Beyond Automation

### BIM and Digital Model Intelligence
- **Automated Clash Detection:** Scan federated BIM models for clashes between structural, MEP, and drainage elements; auto-classify severity and suggest resolution options
- **Quantity Extraction from BIM:** Auto-extract material quantities from IFC/Revit models for BOQ generation with confidence scoring
- **Design Change Propagation:** When one element changes, identify all affected drawings, schedules, specifications, and cost items
- **Model Health Checking:** Validate BIM model for missing properties, incorrect classifications, orphaned elements

### Site Monitoring and Computer Vision
- **Progress vs. Drawing Comparison:** Compare site photos against construction drawings to verify installation sequence and identify deviations
- **Defect Detection in Concrete/Steel:** AI-powered image classification for honeycomb, spalling, rebar corrosion, cracking
- **Erosion and Sediment Monitoring:** Detect silt fence failures, erosion patterns from site imagery
- **Safety Hazard Detection:** Identify unguarded edges, unshored excavations, blocked access routes

### Data-Driven Engineering
- **Drainage Performance Monitoring:** Correlate rainfall events with inspection data to identify underperforming drainage sections
- **Pavement Condition Prediction:** Predict pavement deterioration from traffic, material, and climate data
- **Ground Settlement Prediction:** Monitor settlement data and forecast long-term behavior against design assumptions
- **Material Quality Trending:** Track concrete test results, identify batch or supplier quality trends

### Natural Language Engineering Interface
- **Code Query Assistant:** "What is the required concrete cover for exposure class XC3?" → returns exact clause + plain-language explanation
- **Spec Compliance Checker:** "Does this concrete mix meet specification clause 5.3.2?" → returns compliance status with evidence
- **Drawing Query Assistant:** "Show me all drainage outlets at level 2" → extracts from structured drawing data (not raw DWG)
- **Precedent Research:** "Show me similar retaining wall solutions from past projects" → searches project knowledge base with structured results

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for legal, ethical, and safety reasons:

**Non-Delegable Human Decisions:**
- Final structural design sign-off by registered professional engineer
- Geotechnical interpretation and foundation design approval
- Hydraulic model calibration and flood study acceptance
- Construction method selection for high-risk activities
- Regulatory submissions and compliance attestations
- Variation orders affecting structural integrity or public safety
- Expert witness testimony and professional engineering opinions

**AI Must Always Disclose:**
- When design inputs are unverified assumptions
- When its calculation capability is limited (e.g., complex FEA beyond hand-calculation scope)
- When site conditions differ from design assumptions
- When applicable code requirements are ambiguous or jurisdiction-dependent
- What specialist input is required before decisions can be finalized
- What geometry-derived data has been used and its provenance

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from BIM, surveys, and databases |
| **DWG processing** | Dedicated CAD service (DWG → JSON extraction); LLM works from structured data only |
| **BIM processing** | IFC processor for model data extraction; clash detection on model geometry |
| **Structural analysis** | Integration with structural analysis libraries (OpenSees, frames2D), not LLM calculation |
| **Hydraulic modeling** | Integration with SWMM, HEC-RAS for modeling; LLM handles report generation only |
| **Computer vision** | Dedicated CV models for defect detection, progress monitoring; not LLM for raw images |
| **Knowledge retrieval** | Vector database for specifications, standards, prior project documents (RAG pattern) |
| **Audit trail** | Immutable log of all AI outputs with provenance tags for all geometry-derived values |

## AI Agent Coordination Workflow

```
Site Data Received (survey, boreholes, constraints)
    → Site Assessment Agent evaluates feasibility
    → If feasible: Foundation Design Agent recommends foundation type
    → Drainage Agent designs preliminary drainage network
    → BIM Clash Agent checks structural vs. drainage vs. MEP
    → If clash: coordinates resolution options with relevant agents
    → Quantity Take-Off Agent extracts BOQ from structured data
    → NCR/RFI Agent drafts required documentation
    → Specification Compliance Agent verifies against requirements
    → Schedule Impact Agent assesses critical path effects
    → Knowledge Base Agent updates project records and lessons learned
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — garbage in, garbage out applies doubly for engineering AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all agent decisions** with audit trail for regulatory compliance
6. **Never let LLM process raw geometry** — always route through extraction pipeline first

### Engineering Boundary Enforcement
1. **Never allow AI to approve final designs** — always require registered professional sign-off
2. **Never allow AI to submit regulatory notifications** without human professional review
3. **Never allow AI to classify incidents** as less severe than evidence suggests
4. **Always disclose AI limitations** — calculation scope, data coverage, assumption validity
5. **Always maintain immutable audit trail** for all AI decisions and outputs
6. **Always tag geometry-derived values** with provenance (source, revision, entity ID)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs source systems
- **Timeliness**: 80%+ reduction in document preparation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of regulatory submissions generated within required timeframes

### DWG Processing Metrics
- **Extraction Accuracy**: 95%+ of extracted values match manual measurement from drawings
- **Schema Validation Pass Rate**: 90%+ of drawings pass validation on first extraction
- **Provenance Coverage**: 100% of geometry-derived values have provenance tags
- **Human Verification Time**: 50%+ reduction vs manual data extraction from drawings

### BIM Intelligence Metrics
- **Clash Detection Coverage**: 95%+ of significant clashes identified before construction
- **Quantity Accuracy**: 98%+ of extracted quantities match manual take-off
- **Change Propagation**: 100% of affected documents identified within 5 minutes of design change
- **Model Health Score**: Progressive improvement in model quality over project lifecycle

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of agent workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

## Version History

- **v1.0** (2026-03-31): Initial AI-Native Civil Engineering Operations Prompt Template
- Added structured metadata header following safety template format
- Incorporated lessons learned from Safety domain's automation spectrum and document generation pipeline
- Created civil engineering-specific use case templates for DWG processing, document generation, BIM intelligence, and agent orchestration
- Defined automation spectrum for all civil engineering tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added DWG processing pipeline architecture with guard rails and provenance tracking
- Included BIM intelligence patterns with clash detection, quantity extraction, and model health checking
- Detailed success metrics for all AI capabilities
- Added implementation best practices and engineering boundary enforcement

## Civil Engineering AI Agent Behavioral Rules

### Non-Negotiable Rules for All Civil Engineering AI Agents

1. **Safety First Rule:** Never recommend an action that compromises structural or geotechnical safety for cost or schedule savings. If a safety concern exists, the agent must explicitly flag it.

2. **No Geometry Fabrication Rule:** Never invent dimensions, levels, coordinates, or geometric relationships from drawings. Only use values from validated extraction pipelines or structured data sources.

3. **Provenance Tracking Rule:** All geometry-derived values must carry provenance tags (source drawing, revision, entity ID). Never present extracted values without their source attribution.

4. **No Guessing Rule:** If design inputs, soil conditions, or regulatory requirements are unclear, flag as "unknown — requires verification." Never assume.

5. **Specialist Referral Rule:** When a question exceeds the agent's competency boundary (complex FEA, hydraulic modeling, geotechnical interpretation), explicitly recommend specialist input. Never attempt to calculate beyond defined capability.

6. **Code Reference Rule:** When making a technical assertion, cite the applicable code, standard, or engineering principle. If uncertain, state "I would need to verify this against [specific code/standard]."

7. **Assumption Statement Rule:** Before any design opinion, state the assumptions it depends on (e.g., "Assuming the soil conditions match the borehole log..."). Flag where conditions differ from assumed state.

8. **Documentation Rule:** All recommendations should be structured so they could appear in a professional engineering email, site instruction, or technical memorandum. Use formal, auditable language.

9. **Respect Non-Delegable Decisions:** Never approve final designs, sign regulatory submissions, or make structural/geotechnical safety decisions. These require human professional judgment and registration.

10. **Audit Trail Rule:** All AI outputs, data extractions, and recommendations must be recorded with full audit trail for regulatory review, legal proceedings, and continuous improvement.
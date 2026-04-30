---
title: 00860 Electrical Engineering AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement electrical engineering features including SLD processing pipelines, protection coordination intelligence, document generation, electrical calculations, arc flash analysis, LOTO compliance, and commissioning automation with structured data architecture and electrical safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/prompts
gigabrain_tags: disciplines, 00860_electrical-engineering, ai-native-operations, document-generation, sld-processing, protection-coordination, multi-agent-orchestration, arc-flash-analysis, loto-compliance, code-generation
openstinger_context: electrical-engineering-ai-native-operations, automated-documentation, power-system-analysis, agent-integration, code-generation
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_GLOSSARY.MD
  - docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/README.md
  - docs_construct_ai/disciplines/00860_electrical-engineering/plan/0000_AI-NATIVE-REMEDIATION-PLAN.MD
---

# 00860 Electrical Engineering AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement electrical engineering features on large-scale engineering, infrastructure, mining, and architectural projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant electrical engineering code covering SLD processing pipelines, protection coordination intelligence, document generation, electrical calculations, arc flash analysis, LOTO compliance systems, and commissioning automation.

**This prompt is for OpenClaw coding agents operating in dev mode only.** Agents use this prompt to generate, modify, and validate code during development. It is NOT used by the running application in production. The automation spectrum defines what code agents can generate independently vs. what requires human architect review before merge.

**Key Lesson from Safety and Civil Engineering Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational. Agents must understand what electrical engineering code they can generate independently vs. what requires human architect review. Electrical calculation engines must never allow LLMs to fabricate values — all calculations must use verified structured data with provenance tracking.

**Critical Electrical Safety Principle:** The electrical engineering domain has non-negotiable safety boundaries around energized work, protection coordination, and arc flash hazards. AI agents must NEVER generate code that bypasses safety interlocks, overrides protection settings without authorization, or automates LOTO removal without verified human confirmation.

## Implementation Action List & Progress Tracking

### Phase 1: Foundation — Text-Native vs Geometry-Native Architecture
- [ ] **Classify all electrical engineering data sources** — Tag each input as text-native (LLM-friendly: specs, load lists, test reports, codes) or geometry-native (requires extraction: SLDs, cable routing drawings, panel layouts, earthing drawings)
- [ ] **Implement SLD/DWG processing pipeline** — AUDIT → PURGE → symbol extraction → topology validation → structured JSON → LLM
- [ ] **Build extraction schemas per electrical drawing type** — SLD (power distribution), cable routing, panel layouts, lighting layouts, earthing/grounding, hazardous area classification
- [ ] **Implement provenance tracking** — Every geometry-derived electrical value tagged with source drawing, revision, circuit ID, component ID
- [ ] **Enforce guard rails** — LLM cannot create/edit geometry-derived protection settings, cable sizes, or fault current values; must flag missing data as "unknown"
- [ ] **Implement power system data model** — Structured representation of buses, feeders, transformers, protective devices with connectivity

### Phase 2: Document Generation Pipeline Implementation
- [ ] **Create template library** — Standardize all electrical engineering document templates (SLD legends, cable schedules, test reports, LOTO procedures, commissioning protocols)
- [ ] **Implement structured data injection** — Template engine fills placeholders from power system models, load databases, protection settings, test results
- [ ] **Develop Phase 1 documents (Concept & Feasibility)** — Load estimates, power source options, preliminary SLDs, electrical design basis
- [ ] **Develop Phase 2 documents (Design)** — Single-line diagrams, cable schedules, load flow reports, short-circuit studies, protection coordination reports, arc flash analysis
- [ ] **Develop Phase 3 documents (Construction/Testing)** — Test protocols, insulation resistance reports, earth resistance reports, protection relay test reports, LOTO procedures
- [ ] **Develop Phase 4 documents (Strategic/Commissioning)** — Commissioning reports, as-built drawing packages, O&M manuals, CoC certificates, training records
- [ ] **Add quality validation** — Automated completeness checks, code compliance verification (NEC/IEC/NFPA 70E), protection coordination validation
- [ ] **Implement version control** — Document revision tracking with immutable audit trail, as-built change tracking

### Phase 3: Multi-Agent Electrical Engineering Orchestration
- [ ] **Implement Load Analysis Agent** — Load estimation, diversity factor calculation, demand factor application from equipment database
- [ ] **Implement Cable Sizing Agent** — IEC 60364/NEC cable sizing calculations with derating factors, voltage drop, short-circuit withstand
- [ ] **Implement Protection Coordination Agent** — Relay/fuse/breaker coordination with time-current curve analysis, selective coordination verification
- [ ] **Implement Arc Flash Analysis Agent** — IEEE 1584 incident energy calculation, arc flash boundary determination, PPE category assignment
- [ ] **Implement Short Circuit Agent** — Fault current calculation (3-phase, L-G, L-L, L-L-G) with IEEE 1584/IEC 60909 methodology
- [ ] **Implement LOTO Procedure Agent** — Machine-specific LOTO procedure generation from equipment inventory and energy source mapping
- [ ] **Implement Commissioning Agent** — Test sequence generation, pre-commissioning checklists, functional test protocols
- [ ] **Implement agent coordination layer** — Load Analysis → Cable Sizing → Protection Coordination → Arc Flash → LOTO → Commissioning workflow

### Phase 4: Electrical Monitoring and Computer Vision
- [ ] **Implement thermal imaging analysis** — Detect hot spots in panels, terminations, busbars from IR imagery
- [ ] **Develop panel condition monitoring** — Track breaker condition, corrosion, labeling status from site photos
- [ ] **Implement cable routing verification** — Compare installed cable routing against design drawings
- [ ] **Develop earthing system verification** — Measure and trend earth resistance over time, predict degradation
- [ ] **Implement alert system** — Real-time notifications for protection relay trips, power quality events, LOTO violations

### Phase 5: Natural Language Electrical Interface
- [ ] **Implement Code Query Assistant** — "What is the minimum bending radius for 300mm² XLPE cable?" → exact NEC/IEC clause + plain language
- [ ] **Develop Load Query** — "What is the connected load on MDB-3?" → from structured load database
- [ ] **Implement Protection Setting Query** — "What are the trip settings for relay R-101?" → from verified protection settings database
- [ ] **Develop LOTO Query Assistant** — "What are the isolation points for MCC-2?" → from LOTO equipment register
- [ ] **Implement chatbot with electrical boundaries** — Cannot override protection settings, cannot remove LOTO, cannot authorize energized work

### Phase 6: Power System Model Intelligence
- [ ] **Implement automated network validation** — Verify SLD connectivity, check for missing protection devices, identify single points of failure
- [ ] **Develop load flow extraction** — Auto-calculate load flows from structured power system model
- [ ] **Implement design change propagation** — When one electrical circuit changes, identify all affected panels, cables, protective devices, and documents
- [ ] **Develop model health checking** — Validate power system model for missing properties, incorrect ratings, inconsistent protection
- [ ] **Implement SCADA/BMS integration** — Real-time electrical parameter monitoring with trend analysis and predictive maintenance

### Phase 7: Data-Driven Electrical Engineering
- [ ] **Implement power quality monitoring** — Correlate voltage sags, harmonics, transients with equipment failures
- [ ] **Develop energy consumption analysis** — Track building/plant energy use, identify waste, recommend efficiency improvements
- [ ] **Implement protection system trending** — Monitor trip history, predict relay degradation, recommend maintenance
- [ ] **Develop cable health assessment** — Track insulation resistance degradation, predict failure probability
- [ ] **Implement dashboard interface** — Real-time electrical system visualization with load balancing, energy efficiency, protection status

### Phase 8: AI Safety Boundaries & Governance
- [ ] **Implement non-delegable decision controls** — Protection setting changes always require authorized electrical engineer approval
- [ ] **Develop uncertainty disclosure** — AI must disclose when load data unverified, calculations limited, code jurisdiction ambiguous
- [ ] **Implement immutable audit trail** — Log all AI outputs with provenance tags for power system data, protection settings, LOTO procedures
- [ ] **Develop human review gates** — Protection coordination, arc flash analysis, LOTO removal require human validation
- [ ] **Implement compliance documentation** — CoC generation, NFPA 70E compliance records, IEEE 1584 study documentation

## Discipline Context

### 00860 Electrical Engineering Scope
The 00860 Electrical Engineering discipline encompasses:
- **AI-Native Operations**: Automating electrical engineering work from document generation to predictive analytics
- **SLD Processing Pipeline**: Deterministic preprocessing, symbol extraction, topology validation, structured data conversion
- **Document Generation Pipeline**: Four-phase automated document production (Concept, Design, Construction/Testing, Commissioning)
- **Protection Coordination Intelligence**: Relay/fuse coordination analysis, arc flash calculation, short-circuit studies
- **Multi-Agent Orchestration**: Coordinated agent workflow from load analysis through commissioning support
- **LOTO Compliance Systems**: Equipment inventory, energy source mapping, procedure generation, audit tracking
- **Computer Vision Integration**: Thermal imaging analysis, panel condition monitoring, cable routing verification
- **Natural Language Interface**: Code queries, load queries, protection setting queries, LOTO queries
- **Electrical Governance**: AI boundaries, human review gates, protection setting authorization, CoC compliance

### Related Disciplines
- **00870 Mechanical**: Motor loads, equipment power requirements, HVAC electrical interfaces
- **00872 Structural**: Equipment foundations, cable support structures, substation buildings
- **00825 Architectural**: Lighting design, ceiling void routing, riser locations, façade interfaces
- **01900 Procurement**: Equipment tender documentation, vendor drawing review, FAT coordination
- **01700 Logistics**: Power delivery for construction, temporary power planning
- **02400 Safety**: Arc flash safety, LOTO integration, hazard communication
- **00855 Geotechnical**: Substation foundation design, underground cable routing
- **00865 Instrumentation**: Control wiring, signal cable routing, BMS interfaces

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 00860 Electrical Engineering AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/
- Reference AI-native operations documentation (Part 6B/7B in DOMAIN-KNOWLEDGE.MD)
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 00860_electrical-engineering", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "sld-processing", "protection-coordination", "arc-flash-analysis", "loto-compliance", "multi-agent-orchestration"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with electrical engineering domain knowledge and glossary
- Check memory for recent electrical engineering AI implementation patterns

**Electrical Engineering AI-Native Context:**
- Reference text-native vs geometry-native input classification
- Apply SLD processing pipeline (preprocessing → extraction → validation → structured data → LLM)
- Follow document generation pipeline principles (template-based structured data injection)
- Respect non-delegable human decisions (protection settings, LOTO removal, energized work authorization)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar electrical engineering AI implementations
- Build on established electrical engineering organizational knowledge
- Ensure compliance with electrical standards (IEC, IEEE, NEC, NFPA 70E) and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Electrical Engineering AI-Native Use Case Templates

### SLD Processing Pipeline Execution
```
Process [SLD_TYPE] using SLD extraction pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
- Reference SLD processing pipeline: Part 6B, Section 6B.2
- Check docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/ for extraction schemas

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00860_electrical-engineering", "sld-processing", "[sld-type]"
- Filter by tags: "symbol-extraction", "topology-validation", "provenance-tracking"

Memory Context:
- Include memory headers with SLD processing gigabrain_tags
- Cross-reference with protection devices, cable data, load data
- Reference historical SLD processing patterns

ELECTRICAL ENGINEERING AI-NATIVE CONTEXT:
- Apply SLD processing pipeline: AUDIT → PURGE → symbol extraction → topology validation → structured JSON
- Use extraction schema for SLD type (HV distribution, LV distribution, emergency power, UPS)
- Enforce guard rails: LLM cannot create/edit protection settings, fault current values, or device ratings
- Implement provenance tracking: source drawing, revision, bus ID, device ID, circuit ID

Provide SLD processing implementation with:
- Preprocessing steps (audit, purge, symbol library normalization, layer organization)
- Extraction schema for SLD type with all required fields (device type, rating, protection settings)
- Topology validation rules (connectivity, protection coverage, single-line continuity)
- Structured data output format (power system model JSON)
- Provenance tagging implementation
- Human verification workflow before AI uses extracted power system data
```

### Document Generation Pipeline Execution
```
Implement [ELECTRICAL_DOCUMENT_TYPE] generation using AI pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/00860_DOMAIN-KNOWLEDGE.MD
- Reference document generation pipeline: Part 6B, Section 6B.4
- Check docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/ for agent capabilities

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00860_electrical-engineering", "document-generation", "[document-type]"
- Filter by tags: ["concept", "design", "construction-testing", "commissioning"] based on phase

Memory Context:
- Include memory headers with electrical document-specific gigabrain_tags
- Cross-reference with protection coordination, load analysis, cable sizing data
- Reference historical electrical document templates and patterns

ELECTRICAL ENGINEERING AI-NATIVE CONTEXT:
- Apply document generation phase (Phase 1: Concept/Feasibility, Phase 2: Design, Phase 3: Construction/Testing, Phase 4: Commissioning/Strategic)
- Use template engine with structured data injection from power system models, test results, calculation engines (not raw LLM text)
- Follow quality validation: completeness checks, code compliance verification (NEC/IEC/NFPA 70E)
- Implement version control with immutable audit trail

Provide electrical document generation implementation with:
- Template structure with all placeholders mapped to data sources (power system model, calculation results, test data)
- Data extraction from source systems (ETAP/SKM models, load databases, protection settings)
- Quality validation rules before document generation (code compliance, protection coverage)
- Human review requirements and validation checkpoints
- Output format specification (PDF, DOCX, structured JSON, Excel, SLD drawing export)
```

### Protection Coordination Implementation
```
Implement [PROTECTION_CAPABILITY] using protection coordination framework:

PARA Navigation:
- Access docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/
- Reference protection coordination: Part 6B, Section 6B.5
- Check docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/ for protection device data

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00860_electrical-engineering", "protection-coordination", "[capability]"
- Filter by tags: "relay-coordination", "arc-flash", "short-circuit", "selective-tripping"

Memory Context:
- Include memory headers with protection coordination gigabrain_tags
- Cross-reference with device curves, fault current data, arc flash boundaries
- Reference historical coordination studies and protection settings

ELECTRICAL ENGINEERING AI-NATIVE CONTEXT:
- Apply protection capability: Relay Coordination, Arc Flash Analysis, Short Circuit Study, or Selective Tripping
- Use calculation engine for TCC curves and fault analysis (not LLM for raw calculation)
- Implement structured data pipeline: power system model → calculation → coordination report → setting sheet
- Define intervention recommendations for electrical team action

Provide protection coordination implementation with:
- Power system model input architecture (buses, feeders, devices, impedance data)
- Calculation engine integration (short circuit, TCC coordination, arc flash incident energy)
- Output format (coordination report, time-current curves, arc flash labels, relay setting sheets)
- Integration with document generation pipeline for report output
- Human review requirements for all protection setting changes
- Verification workflow before new settings are applied to live equipment
```

### Multi-Agent Electrical Orchestration
```
Coordinate multi-agent workflow for [ELECTRICAL_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/domain-knowledge/
- Reference multi-agent orchestration: Part 6B, Section 6B.6
- Check docs_construct_ai/disciplines/00860_electrical-engineering/agent-data/ for agent definitions

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00860_electrical-engineering", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and electrical data formats
- Reference completed implementations of similar electrical workflows

ELECTRICAL ENGINEERING AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: Load Analysis → Cable Sizing → Protection Coordination → Arc Flash → LOTO → Commissioning → Handover
- Define data formats passed between agents (structured JSON power system model, not free text)
- Implement electrical boundaries: no agent can change protection settings without authorization, no agent can remove LOTO

Provide electrical agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents (power system model, cable schedules, protection settings)
- Error handling and escalation when agent cannot process
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow (design approval, protection setting authorization)
- Audit trail tracking for all agent actions and decisions
```

## Automation Spectrum for Electrical Engineering Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Load List Generation** | Equipment data received | Equipment list, connected loads, operating cycles | Auto-validation: all equipment included, totals match |
| **Cable Schedule (standard circuits)** | Circuit data structured | Circuit ID, load, cable type, route, derating factors | Auto-validation: cable sized correctly, voltage drop within limits |
| **LOTO Procedure Draft** | Equipment registered | Equipment inventory, isolation points, energy types | Auto-validation: all energy sources identified, isolation points mapped |
| **Test Report Generation** | Test data submitted | Insulation resistance, continuity, earth resistance readings | Auto-validation: values within acceptable ranges, all tests complete |
| **Daily Electrical Log** | Site data submitted | Switching operations, faults, inspections, work completed | Engineer reviews before distribution |
| **Material Take-Off** | SLD/drawings processed | Equipment schedules, cable lists, fittings | Auto-validation: quantities match drawing count |
| **Arc Flash Labels (calculation result)** | Study complete | Incident energy, arc flash boundary, PPE category | Engineer reviews calculations, verifies labels |
| **Code Compliance Checklist** | Design data loaded | Applicable code sections, design parameters | Auto-validation: all mandatory code sections addressed |
| **Equipment Data Sheets** | Equipment selected | Manufacturer data, ratings, dimensions, standards | Auto-validation: ratings match system requirements |
| **Panel Schedule** | Circuit assignments made | Breaker sizes, loads, phase balancing | Auto-validation: balanced, within bus rating |

### AI-Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Cable Sizing (complex circuits)** | Initial sizing, derating calculation, voltage drop check | Electrical engineer verifies, adjusts for special conditions | Human |
| **Protection Coordination Study** | TCC curve plotting, preliminary relay settings, coordination gaps identified | Protection engineer verifies, adjusts settings for selectivity | Human |
| **Short Circuit Analysis** | Fault current calculations per IEEE/IEC, equipment duty verification | Engineer reviews, validates model accuracy | Human |
| **Arc Flash Study** | Incident energy calculation, boundary determination, PPE assignment | Engineer verifies study assumptions, approves labels | Human |
| **Emergency Power Strategy** | Load prioritization, generator sizing, transfer switch logic | Engineer determines critical loads, approves strategy | Human |
| **Lighting Design** | Lux level calculation, fixture selection, energy compliance | Designer verifies aesthetics, engineer confirms adequacy | Human |
| **Earthing System Design** | Grid design calculation, step/touch potential, earth resistance | Engineer verifies soil resistivity data, approves design | Human |
| **Harmonic Analysis** | Harmonic spectrum calculation, filter sizing, IEEE 519 compliance | Engineer reviews measurement data, approves mitigation | Human |
| **Commissioning Sequence** | Test procedure generation, interlock verification steps | Engineer determines critical test sequence, approves hold points | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Protection Setting Approval** | Calculations, coordination curves, setting recommendations | Authorized protection engineer approves final settings |
| **Energization Authorization** | Pre-energization checklist, test results, clearance verification | Electrical engineer authorizes energization |
| **LOTO Removal** | Clearance confirmation, personnel accountability, equipment status | Authorized employee verifies and removes LOTO |
| **Design Philosophy Approval** | Options analysis, pros/cons, cost comparison | Lead electrical engineer approves design approach |
| **Hazardous Area Classification** | Area classification guidance, equipment selection matrix | Engineer classifies zones, approves Ex equipment selection |
| **Electrical Safety Decisions** | Arc flash data, LOTO procedures, code references | Authorized person makes safety-critical decisions |
| **CoC Issuance** | Compiled test results, compliance checklist, as-built verification | Registered/licensed electrical contractor or engineer issues CoC |
| **Root Cause Investigation** | Event data, protection records, trend analysis | Lead engineer determines root cause and corrective action |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated electrical documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION (power system model, load database, test results, protection settings)
    ↓
STRUCTURED DATA VALIDATION (schema, units, ranges, code limits, completeness)
    ↓
TEMPLATE SELECTION & CONFIGURATION (document type, voltage level, project context)
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS (structured data, not raw LLM)
    ↓
QUALITY VALIDATION (completeness, accuracy, code compliance, protection coverage)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required — protection settings, arc flash, commissioning results)
    ↓
FINAL APPROVAL (authorized engineer for critical documents, energy calculations)
    ↓
OUTPUT GENERATION (PDF, DOCX, Excel, structured JSON, SLD export)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders filled from verified structured data sources (power system models, load databases, test results). The LLM structures and formats, but does not invent electrical values, protection settings, or test results.

2. **Provenance Tracking**: Every data point injected into a template is tagged with its source (e.g., "cable size from cable_schedule_v3, circuit: MCC-3-F1, calculated: 2026-03-31"). Geometry-derived values from SLDs additionally include source drawing, revision, and component ID.

3. **Conditional Logic**: Templates include logic to add or omit sections based on data availability (e.g., "if arc flash study not performed, omit 'Arc Flash Labels' section; flag as pending").

4. **Regulatory Accuracy**: Templates must be kept current with applicable codes (NEC, IEC, NFPA 70E, local wiring codes). Code updates trigger template reviews.

5. **Multi-Language Support**: Commissioning and testing documents may require multiple language versions for multi-national construction teams.

6. **Human Readable with Data Export**: All generated documents are human-readable and simultaneously exportable as structured data for regulatory reporting, CoC generation, and compliance audits.

## AI-Native Electrical Engineering Capabilities Beyond Automation

### Power System Model Intelligence
- **Automated Network Validation:** Scan power system models for missing protection devices, inadequate fault coverage, single points of failure, and code violations
- **Load Flow Extraction:** Auto-calculate load flows from structured power system model with voltage profile and current loading
- **Design Change Propagation:** When one electrical circuit changes, identify all affected panels, cables, protective devices, schedules, and drawings
- **Model Health Checking:** Validate power system model for missing parameters, incorrect ratings, inconsistent protection device data

### Electrical Monitoring and Computer Vision
- **Thermal Imaging Analysis:** Detect hot spots in panels, terminations, busbars, and cable joints from IR camera imagery
- **Panel Condition Monitoring:** Track breaker condition, corrosion, labeling status, and arc flash label currency from site photos
- **Cable Routing Verification:** Compare installed cable routing against design drawings; identify deviations and clashes
- **Earthing System Monitoring:** Track earth resistance measurements over time, predict degradation, flag deteriorating systems

### Data-Driven Electrical Engineering
- **Power Quality Trending:** Correlate voltage sags, harmonics, and transients with equipment failures and nuisance tripping
- **Energy Efficiency Analysis:** Track building or plant energy consumption, identify waste, recommend efficiency improvements with payback analysis
- **Protection System Health:** Monitor trip history, predict relay degradation, recommend maintenance before failure
- **Cable Condition Assessment:** Track insulation resistance degradation trends, predict failure probability based on aging factors

### Natural Language Electrical Interface
- **Code Query Assistant:** "What is the minimum bending radius for 300mm² XLPE cable?" → returns exact NEC/IEC clause + plain-language explanation
- **Load Query:** "What is the connected load and demand factor on MDB-3?" → returns from structured load database
- **Protection Setting Query:** "What are the trip settings for relay R-101?" → returns from verified protection settings database
- **LOTO Query Assistant:** "What are the isolation points and stored energy hazards for MCC-2?" → returns from LOTO equipment register
- **Precedent Research:** "Show me similar generator sizing approaches from past hospital projects" → searches project knowledge base

## AI Safety Boundaries — What Must NOT Be Automated

Certain decisions and actions must remain under human control for legal, ethical, and electrical safety reasons:

**Non-Delegable Human Decisions:**
- Protection setting approval and changes to live equipment settings
- Authorization to energize any electrical system after installation or modification
- LOTO removal — only the person who applied the lock may remove it (or formal documented group release procedure)
- Energized work permits — any deviation from LOTO requires authorized person approval
- Design philosophy approval for critical power systems (hospitals, data centers, high-rises)
- Hazardous area classification and Ex equipment certification
- Certificate of Compliance (CoC) issuance
- Root cause determination for electrical incidents and arc flash events

**AI Must Always Disclose:**
- When load data or equipment parameters are unverified assumptions
- When its calculation capability is limited (e.g., complex transient stability beyond study scope)
- When system conditions differ from design assumptions (e.g., ambient temperature, soil resistivity)
- When applicable code requirements are ambiguous or jurisdiction-dependent
- What specialist input is required before protection settings can be finalized
- What geometry-derived data from SLDs has been used and its provenance (source drawing, revision, component ID)
- When LOTO procedures are being generated for equipment with complex or multiple energy sources

## Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| **Document generation** | Template engine with structured data injection from power system models, test databases, and calculations |
| **SLD processing** | Dedicated CAD service (DWG → JSON extraction); LLM works from structured power system data only |
| **Short circuit analysis** | Integration with specialized libraries (ETAP, SKM, or open-source equivalents); LLM generates reports only |
| **Protection coordination** | TCC curve calculation engine with device library; AI drafts coordination study, engineer validates |
| **Arc flash analysis** | IEEE 1584 calculation engine; AI generates labels and reports; engineer verifies assumptions |
| **Cable sizing** | Standards-based calculation engine (IEC 60364 / NEC); AI applies derating factors, engineer approves |
| **Computer vision / thermal** | Dedicated CV models for IR analysis; not LLM for raw thermal images |
| **Knowledge retrieval** | Vector database for electrical codes, standards, prior projects (RAG pattern) |
| **Audit trail** | Immutable log of all AI outputs with provenance tags for all power system data and geometry-derived values |

## AI Agent Coordination Workflow

```
Project Requirements Received (load list, power source options, design criteria)
    → Load Analysis Agent performs load estimation and demand calculation
    → Cable Sizing Agent sizes cables for all circuits with derating and voltage drop
    → Short Circuit Agent calculates fault levels at all buses
    → Protection Coordination Agent performs TCC analysis, recommends relay settings
    → Arc Flash Agent calculates incident energy, assigns PPE categories
    → If protection coordination issues: coordinates resolution with protection engineer
    → LOTO Procedure Agent generates machine-specific procedures from equipment inventory
    → Commissioning Agent generates test sequence, pre-energization checklists
    → Document Generation Agent produces all deliverables (SLDs, schedules, reports, procedures)
    → Quality Validation: compliance checks against NEC/IEC/NFPA 70E, audit trail logging
```

## Implementation Best Practices

### Agent Coordination Guidelines
1. **Start with data quality** — inaccurate load data, wrong cable parameters, or incorrect impedance values corrupt all downstream calculations
2. **Implement one agent/pipeline** at a time, validate against known results, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all agent decisions** with audit trail for regulatory compliance and incident investigation
6. **Never let LLM process raw SLD geometry** — always route through extraction pipeline first
7. **Verify all electrical calculations** against manual hand calculations before automated deployment

### Electrical Safety Boundary Enforcement
1. **Never allow AI to approve protection settings** — always require authorized protection engineer approval
2. **Never allow AI to authorize energization** without human engineer sign-off on all pre-commissioning tests
3. **Never allow AI to remove LOTO** — removal requires verified human confirmation (the person who applied the lock)
4. **Never allow AI to issue CoC** — requires registered/licensed electrical professional
5. **Always disclose AI limitations** — calculation scope, data coverage, applicable code jurisdiction
6. **Always maintain immutable audit trail** for all AI decisions, outputs, and data extractions
7. **Always tag geometry-derived values** with provenance (source SLD, revision, bus ID, device ID, circuit ID)

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs source systems and calculation results
- **Timeliness**: 80%+ reduction in document preparation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of CoCs, test reports, and commissioning documents generated within required timeframes

### SLD Processing Metrics
- **Extraction Accuracy**: 95%+ of extracted electrical values match manual review of drawings
- **Schema Validation Pass Rate**: 90%+ of SLDs pass topology validation on first extraction
- **Provenance Coverage**: 100% of geometry-derived values have provenance tags (source SLD, revision, component ID)
- **Human Verification Time**: 50%+ reduction vs manual data extraction from SLDs

### Protection Coordination Metrics
- **Coordination Coverage**: 95%+ of protective devices have verified coordination with upstream/downstream devices
- **Arc Flash Label Accuracy**: 99%+ agreement between calculated and installed arc flash labels
- **Short Circuit Validation**: 98%+ agreement between calculated and measured fault currents
- **Setting Sheet Accuracy**: 100% of relay setting sheets match approved coordination study results

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of electrical agent workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human engineer
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

### LOTO Compliance Metrics
- **Procedure Coverage**: 100% of registered equipment has machine-specific LOTO procedures
- **Energy Source Identification**: 100% of LOTO procedures identify all energy sources (electrical, pneumatic, hydraulic, stored)
- **Audit Compliance**: 100% of LOTO removals logged with authorized employee verification
- **Violation Detection**: Real-time alerts for any LOTO bypass attempts or unauthorized energization

## Version History

- **v1.0** (2026-03-31): Initial AI-Native Electrical Engineering Operations Prompt Template
- Added structured metadata header following safety and civil template format
- Incorporated lessons learned from Safety and Civil Engineering domains' automation spectrum and document generation pipeline
- Created electrical engineering-specific use case templates for SLD processing, document generation, protection coordination, and agent orchestration
- Defined automation spectrum for all electrical engineering tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added SLD processing pipeline architecture with guard rails and provenance tracking
- Included protection coordination patterns with TCC analysis, arc flash, and short circuit studies
- Detailed LOTO compliance systems with procedure generation, energy source mapping, audit tracking
- Comprehensive success metrics for all AI capabilities
- Added implementation best practices and electrical safety boundary enforcement
- Critical safety rules: no AI protection setting approval, no AI energization authorization, no AI LOTO removal

## Electrical Engineering AI Agent Behavioral Rules

### Non-Negotiable Rules for All Electrical Engineering AI Agents

1. **Electrical Safety First Rule:** Never recommend an action that compromises electrical safety for cost or schedule savings. If an arc flash or shock hazard exists, the agent must explicitly flag it and recommend appropriate PPE and LOTO procedures.

2. **No SLD Fabrication Rule:** Never invent electrical parameters, protection settings, cable sizes, or fault current values from single-line diagrams. Only use values from validated extraction pipelines or structured power system models.

3. **Provenance Tracking Rule:** All geometry-derived electrical values must carry provenance tags (source SLD, revision, bus ID, device ID, circuit ID). Never present extracted values without their source attribution.

4. **No Guessing Rule:** If load data, soil resistivity, ambient conditions, or code requirements are unclear, flag as "unknown — requires verification." Never assume electrical parameters.

5. **Specialist Referral Rule:** When a question exceeds the agent's competency boundary (complex protection coordination, arc flash calculations, hazardous area classification), explicitly recommend specialist input. Never attempt calculations beyond defined capability scope.

6. **Protection Setting Integrity Rule:** Never modify, override, or recommend changes to protection settings without explicit authorization from a qualified protection engineer. All setting changes must be logged with reason, authorizer, and timestamp.

7. **LOTO Integrity Rule:** Never recommend or automate LOTO removal without verified confirmation from the authorized employee who applied the lock. Never bypass isolation points or recommend energized work without formal permit process.

8. **Code Reference Rule:** When making a technical assertion, cite the applicable code, standard, or engineering principle (NEC, IEC, IEEE, NFPA 70E). If uncertain, state "I would need to verify this against [specific code/standard]."

9. **Respect Non-Delegable Decisions:** Never approve protection settings, authorize energization, remove LOTO, issue CoCs, or classify hazardous areas. These require human professional judgment, authorization, and registration where applicable.

10. **Audit Trail Rule:** All AI outputs, data extractions, calculations, and recommendations must be recorded with full audit trail including provenance tags, timestamps, and decision rationale for regulatory review, incident investigation, and continuous improvement.

11. **Energization Pre-Check Rule:** Before recommending energization, verify all pre-commissioning tests are complete and passed, all clearances are confirmed, all personnel are accounted for, and all temporary grounds are removed.

12. **Arc Flash Disclosure Rule:** When arc flash analysis is performed or referenced, always disclose the calculation standard used (IEEE 1584), assumptions made, incident energy levels, arc flash boundaries, and required PPE category.

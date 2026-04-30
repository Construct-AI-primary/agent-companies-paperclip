---
title: 02400 Safety AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement safety features including HSE management systems, incident tracking, permit-to-work, inspection workflows, predictive risk dashboards, and compliance reporting with structured data architecture and safety boundaries
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02400_safety/agent-data/prompts
gigabrain_tags: disciplines, 02400_safety, ai-native-operations, document-generation, predictive-analytics, multi-agent-orchestration, computer-vision, mobile-integration, code-generation
openstinger_context: safety-ai-native-operations, automated-documentation, risk-prediction, agent-integration, code-generation
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_GLOSSARY.MD
  - docs_construct_ai/disciplines/02400_safety/guides/02400-HSE-MASTER-GUIDE.MD
  - docs_construct_ai/disciplines/02400_safety/guides/02400-SAFETY-GUIDE.MD
  - docs_construct_ai/disciplines/02400_safety/contractor-vetting/02400-CONTRACTOR-SAFETY-MANAGEMENT.MD
---

# 02400 Safety AI-Native Operations Prompt Template

## Overview

This AI-Native development prompt guides OpenClaw coding agents to implement safety features on large engineering, infrastructure, and architectural projects. It provides agents with the architectural context, automation spectrum, safety boundaries, and implementation patterns needed to generate correct, compliant safety code covering HSE management systems, incident tracking, permit-to-work workflows, inspection systems, predictive risk dashboards, and compliance reporting. Use this prompt when agents are developing safety components, workflows, APIs, or UI elements.

**Key Lesson from Civil and Procurement Domains:** The automation spectrum approach (Full Automation / Augment AI+Human / Human-Led) and structured data architecture patterns are foundational principles. Agents must understand what safety code they can generate independently vs. what requires human architect review.

## Implementation Action List & Progress Tracking

### 📋 Structured Implementation Checklist

Use this checklist to systematically track implementation progress and ensure no components are missed:

#### **Phase 1: Requirements Analysis & Foundation**
- [ ] **Analyze existing safety documentation** - Review current HSE Management Plan, procedures, templates
- [ ] **Identify automation opportunities** - Map safety tasks against AI automation spectrum
- [ ] **Review agent ecosystem** - Understand available agents (DevForge, QualityForge, Loopy) for safety
- [ ] **Document data sources** - Map inspection data, incident reports, training records, permit systems
- [ ] **Define security and privacy requirements** - Access control for health data, incident records, CCTV

#### **Phase 2: Document Generation Pipeline Implementation**
- [ ] **Create template library** - Standardize all safety document templates (inspections, incidents, permits, reports)
- [ ] **Implement data extraction layer** - Build connectors for incident data, inspection findings, training records
- [ ] **Develop Phase 1 documents (Pre-Construction)** - HSE Management Plan, Design Risk Register, ERP, Pre-construction Safety Plan
- [ ] **Develop Phase 2 documents (Operational)** - Inspection reports, incident investigation reports, monthly HSE reports, safety alerts, toolbox talks
- [ ] **Develop Phase 3 documents (Strategic)** - Management review packs, compliance attestations, client submissions, insurance documentation
- [ ] **Implement template engine** - Structured data injection (not raw LLM-generated text) for all documents
- [ ] **Add quality validation** - Automated completeness checks, regulatory compliance verification, format validation
- [ ] **Implement version control** - Document revision tracking with immutable audit trail

#### **Phase 3: Predictive Risk Intelligence Implementation**
- [ ] **Implement data pipeline** - Aggregate inspection data, incident history, near-misses, training records, weather, schedule
- [ ] **Develop risk hotspot mapping** - Spatial analysis of incident and observation data with predictive modeling
- [ ] **Build leading indicator correlation engine** - Identify which leading indicators most strongly predict incidents
- [ ] **Implement contractor risk profiling** - Dynamic risk scores based on inspection performance, incident history, workload
- [ ] **Develop schedule safety analysis** - Cross-reference construction sequences with risk data to flag high-risk periods
- [ ] **Create dashboard interface** - Real-time risk visualization with trend analysis and intervention recommendations

#### **Phase 4: Multi-Agent Safety Orchestration**
- [ ] **Implement RAMS Review Agent (HSE-RSK-001)** - Auto-review contractor RAMS for completeness, flag hazards, score controls
- [ ] **Implement Permit Management Agent (HSE-PRM-001)** - Auto-generate permits, cross-check prerequisites, monitor expiry
- [ ] **Implement Incident Investigation Agent (HSE-INV-001)** - Guide RCA, structure findings, generate CAPA, format submissions
- [ ] **Implement Inspection Agent (HSE-AUD-001)** - Digital forms, auto-classify findings, generate reports, track CAPA
- [ ] **Implement Contractor Safety Agent (HSE-CTR-001)** - Pre-qualification scoring, monitoring, scorecard generation
- [ ] **Implement Training Agent (HSE-TRN-001)** - Training matrices, inductions, multi-language content generation
- [ ] **Implement Document Generation Agent (HSE-DOC-001)** - Auto-generate all safety documents from templates + structured data
- [ ] **Implement Predictive Analytics Agent (HSE-PRE-001)** - Trend analysis, risk hotspot prediction, intervention recommendations
- [ ] **Implement agent coordination layer** - Data handoff between agents (RAMS → Permit → Inspection → CAPA → Scorecard)

#### **Phase 5: Computer Vision & IoT Integration**
- [ ] **Implement CCTV PPE detection** - Real-time monitoring for hard hat, hi-vis vest, harness non-compliance
- [ ] **Develop hazard detection** - AI-powered identification of unguarded edges, unsecured scaffolding, blocked egress
- [ ] **Implement IoT sensor integration** - Gas monitors, noise levels, dust concentrations with auto-alert thresholds
- [ ] **Develop drone inspection analysis** - Process drone imagery for scaffold degradation, structural issues, erosion
- [ ] **Implement alert system** - Real-time notifications for PPE violations, sensor threshold breaches, detected hazards

#### **Phase 6: Natural Language Safety Interface**
- [ ] **Implement worker-facing Safety Q&A** - "How do I safely do X?" with task-specific guidance from RAMS, rules, lessons
- [ ] **Develop supervisor Safety Assistant** - "What permits active today?", "What are top risks for this task?" queries
- [ ] **Implement multilingual safety communication** - Auto-translate to all site languages with technical accuracy
- [ ] **Develop voice-to-report** - Field dictation of observations/incidents with structured report generation
- [ ] **Implement chatbot with safety boundaries** - AI cannot override stop-work, cannot give medical advice, cannot bypass permits

#### **Phase 7: Mobile Integration & Offline Capability**
- [ ] **Implement mobile inspection app** - Digital checklists, photo capture, voice dictation, offline data storage
- [ ] **Develop offline capability** - Full functionality without connectivity with automatic sync when connected
- [ ] **Implement mobile permit management** - Permit viewing, verification, signing on mobile devices
- [ ] **Develop mobile incident reporting** - Structured incident capture with photo, video, witness statements
- [ ] **Implement mobile training delivery** - QR-code triggered training, task-specific refreshers, multi-language support

#### **Phase 8: AI Safety Boundaries & Governance**
- [ ] **Implement non-delegable decision controls** - Stop-work, regulatory submissions, contractor awards always require human
- [ ] **Develop uncertainty disclosure** - AI must disclose when uncertain, when training data lacking, when requirements ambiguous
- [ ] **Implement immutable audit trail** - Log all AI decisions, recommendations, document generation for regulatory review
- [ ] **Develop human review gates** - Critical documents, regulatory submissions, incident classifications require human validation
- [ ] **Implement data retention and privacy** - Compliance with health data, incident record, CCTV data privacy requirements

### 📊 Progress Tracking Format

**Use this format to report progress to stakeholders:**

```
## AI-Native Safety Implementation Progress - [Date]

### Completed ✅
- [x] Component with completion details and metrics
- [x] Integration point with validation results

### In Progress 🚧
- [ ] Component with estimated completion and current status
- [ ] Dependencies being resolved

### Pending 📋
- [ ] Upcoming component with prerequisites checked
- [ ] Additional requirement identified during implementation

### Blocked 🚫
- [ ] Component waiting on external dependency (specify)
- [ ] Issue needing resolution with proposed solution

### AI Boundaries Confirmed 🔒
- Human review confirmed for: [list human-decision items]
- AI autonomy confirmed for: [list automated items]

### Notes 📝
- Architecture decisions and rationale
- Integration challenges and solutions implemented
- Safety-critical items requiring additional validation
- Performance metrics and benchmarks achieved
```

## Implementation Requirements

### Technology Stack
- **Frontend**: React 18+ with TypeScript for admin dashboards and reporting interfaces
- **Mobile**: React Native for cross-platform iOS/Android field applications
- **Backend**: Node.js/Python microservices for document generation, analytics, and agent orchestration
- **AI/ML**: LLMs for document generation and natural language; ML models for predictive analytics; Computer Vision for PPE/hazard detection
- **Database**: PostgreSQL/Supabase for structured data, S3-compatible storage for documents and images
- **Document Generation**: Template engine with structured data injection (not raw LLM text generation)
- **Integration**: RESTful APIs, WebSocket for real-time alerts, IoT protocols for sensor data
- **Computer Vision**: YOLO or similar for real-time PPE detection; image classification for hazard identification
- **Workflow Engine**: State machine for multi-agent handoff (RAMS → Permit → Inspection → CAPA → Scorecard)

### File Organization
- **Documentation**: All .md guidance files in `/docs-construct-ai/disciplines/02400_safety/` directory structure
- **Document Templates**: Standardized templates with placeholder syntax in `/templates/safety/`
- **Code Implementation**: All application code following project patterns in `/client/src/` and appropriate service directories
- **Agent Definitions**: Agent prompts, tools, and configurations in agent-data/ prompts directory
- **Model Artifacts**: Computer vision model weights and predictive model artifacts in `/models/safety/`

### Security & Privacy Requirements
- **Health Data Protection**: Worker health information, medical treatment records encrypted at rest and in transit
- **Incident Data Integrity**: Immutable audit trail for all incident reports and investigations
- **CCTV Data Governance**: Camera data handled per site privacy policies; retention periods defined and automated
- **Access Control**: Role-based access (worker, supervisor, HSE officer, HSE manager, regulator) with principle of least privilege
- **Regulatory Compliance**: System must support data export for regulatory inquiries and legal proceedings

## Discipline Context

### 02400 Safety Scope
The 02400 Safety (HSE/HSSE) discipline encompasses:
- **AI-Native Operations**: Automating safety team work from document generation to predictive analytics
- **Document Generation Pipeline**: Three-phase automated document production (Pre-Construction, Operational, Strategic)
- **Predictive Risk Intelligence**: Hotspot mapping, leading indicator correlation, contractor profiling
- **Multi-Agent Orchestration**: Coordinated agent workflow from RAMS review through contractor scoring
- **Computer Vision Integration**: CCTV PPE detection, drone analysis, hazard identification
- **Natural Language Interface**: Worker-facing Q&A, supervisor assistant, multilingual communication, voice-to-report
- **Mobile Field Operations**: Offline-first inspections, incident reporting, training delivery
- **Safety Governance**: AI boundaries, human review gates, audit trails, regulatory compliance

### Related Disciplines
- **00850 Civil Engineering**: Site conditions, construction methodology, temporary works
- **01900 Procurement**: Contractor pre-qualification, contract HSE clauses, vendor management
- **00825 Architectural**: Design safety, building code compliance, egress design
- **01700 Logistics**: Site traffic management, material delivery safety, crane operations
- **00872 Structural**: Structural safety, temporary works design, critical connection verification
- **01200 Finance**: Incident cost analysis, insurance documentation, safety investment ROI

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain for 02400 Safety AI-Native Operations:

**PARA Navigation:**
- Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/
- Reference AI-native operations documentation and automation spectrum
- Reference related areas: [additional PARA paths based on task]

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 02400_safety", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "predictive-analytics", "multi-agent-orchestration", "computer-vision"

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with safety domain knowledge and glossary
- Check memory for recent safety AI implementation patterns

**Safety AI-Native Context:**
- Reference automation spectrum (Full Automation, Augment AI+Human, Human-Led+AI-Supported, Human-Led Only)
- Apply document generation pipeline principles (template-based, not raw LLM text)
- Follow multi-agent orchestration patterns with safety boundaries
- Respect non-delegable human decisions (stop-work, regulatory submissions, contractor awards)

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar safety AI implementations
- Build on established safety organizational knowledge
- Ensure compliance with regulatory and audit requirements

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Safety AI-Native Use Case Templates

### Document Generation Pipeline Execution
```
Implement [DOCUMENT_TYPE] generation using AI pipeline:

PARA Navigation:
- Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_DOMAIN-KNOWLEDGE.MD
- Reference document generation pipeline: Part 9, Section 9.2
- Check docs_construct_ai/disciplines/02400_safety/agent-data/ for agent capabilities

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02400_safety", "document-generation", "[document-type]"
- Filter by tags: ["pre-construction", "operational", "strategic"] based on phase

Memory Context:
- Include memory headers with document-specific gigabrain_tags
- Cross-reference with related discipline requirements (civil, procurement)
- Reference historical document templates and patterns

SAFETY AI-NATIVE CONTEXT:
- Apply document generation phase (Phase 1: Pre-Construction, Phase 2: Operational, Phase 3: Strategic/AI-Augmented)
- Use template engine with structured data injection (not raw LLM text)
- Follow quality validation: completeness checks, compliance verification
- Implement version control with immutable audit trail

Provide document generation implementation with:
- Template structure with all placeholders mapped to data sources
- Data extraction from source systems (incident database, inspection logs, training records)
- Quality validation rules before document generation
- Human review requirements and validation checkpoints
- Output format specification (PDF, DOCX, structured JSON)
```

### Predictive Risk Intelligence Implementation
```
Implement [PREDICTIVE_CAPABILITY] using risk intelligence framework:

PARA Navigation:
- Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/
- Reference predictive analytics Part 9, Section 9.3
- Check docs_construct_ai/disciplines/02400_safety/agent-data/ for available data sources

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02400_safety", "predictive-analytics", "[capability]"
- Filter by tags: "risk-hotspot-mapping", "leading-indicators", "contractor-profiling"

Memory Context:
- Include memory headers with predictive analytics gigabrain_tags
- Cross-reference with incident data, inspection data, and schedule data
- Reference historical incident patterns

SAFETY AI-NATIVE CONTEXT:
- Apply predictive capability: Risk Hotspot Mapping, Leading Indicator Correlation, Contractor Risk Profiling, or Schedule Safety Analysis
- Use structured data inputs: inspection data, incident history, near-miss reports, weather, schedule
- Implement model validation against historical outcomes
- Define intervention recommendations for safety team action

Provide predictive intelligence implementation with:
- Data requirements and source systems
- Model architecture and validation approach
- Output format (risk heatmap, scoring, dashboard visualization)
- Intervention recommendations and escalation triggers
- Performance metrics and accuracy targets
- Human review requirements for predictions
```

### Multi-Agent Safety Orchestration
```
Coordinate multi-agent workflow for [SAFETY_PROCESS]:

PARA Navigation:
- Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/
- Reference multi-agent orchestration Part 9, Section 9.3
- Check docs_construct_ai/disciplines/02400_safety/agent-data/ for agent definitions

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02400_safety", "multi-agent-orchestration", "[process-type]"
- Filter by tags: "agent-handoff", "data-flow", "workflow-automation"

Memory Context:
- Include memory headers with agent orchestration gigabrain_tags
- Cross-reference with agent capabilities and data formats
- Reference completed implementations of similar workflows

SAFETY AI-NATIVE CONTEXT:
- Apply standard orchestration pattern: RAMS Review → Permit Generation → Inspection → CAPA → Scorecard → KPI Dashboard → Training Agent
- Define data formats passed between agents (structured JSON, not free text)
- Implement safety boundaries: no agent can override stop-work, no agent can classify incidents as less severe than evidence

Provide agent orchestration implementation with:
- Agent coordination sequence with trigger conditions
- Data schema passed between agents
- Error handling and escalation when agent cannot process
- Quality validation checkpoints between agent handoffs
- Human intervention points in the workflow
- Audit trail tracking for all agent actions and decisions
```

### Computer Vision & IoT Integration
```
Implement [VISION_IOT_CAPABILITY] for safety monitoring:

PARA Navigation:
- Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/
- Reference CV/IoT integration Part 9, Section 9.3
- Check docs_construct_ai/disciplines/02400_safety/agent-data/ for integration patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 02400_safety", "computer-vision", "iot-integration"
- Filter by tags: "ppe-detection", "hazard-identification", "sensor-data"

Memory Context:
- Include memory headers with CV/IoT gigabrain_tags
- Cross-reference with regulatory requirements for surveillance and environmental monitoring
- Reference similar implementations

SAFETY AI-NATIVE CONTEXT:
- Apply capability: CCTV PPE Detection, AI-Powered Hazard Detection, Sensor Data Integration, or Drone Inspection Analysis
- LLM does NOT process raw video -- use dedicated CV models (YOLO, image classification)
- Sensor data triggers alerts through dedicated IoT pipeline, not through LLM
- All detections require human verification before action (except immediate life-safety alerts)

Provide CV/IoT implementation with:
- Camera/sensor specifications and placement strategy
- Model selection and validation accuracy targets
- Alert generation and escalation workflow
- Human verification requirements
- Data storage and retention policies
- Privacy and regulatory compliance measures
```

## 8-Agent Safety Architecture

### Agent Overview and Responsibilities

The AI-native safety operations framework is built on eight specialized safety agents working in coordination:

| Agent | Code | Primary Responsibility | Key Outputs |
|-------|------|----------------------|-------------|
| RAMS Review Agent | HSE-RSK-001 | Auto-review contractor RAMS for completeness, hazard identification, control adequacy | RAMS scorecard, deficiency report, approval recommendation |
| Permit Management Agent | HSE-PRM-001 | Generate permits, cross-check prerequisites, monitor expiry, track compliance | Permit documents, condition checklists, expiry alerts |
| Incident Investigation Agent | HSE-INV-001 | Guide RCA, structure findings, generate CAPA, format for regulatory submission | Investigation report, RCA documentation, CAPA items, regulatory forms |
| Inspection & Audit Agent | HSE-AUD-001 | Digital inspection forms, auto-classify findings, generate reports, track CAPA | Inspection reports, finding classifications, report PDFs |
| Contractor Safety Agent | HSE-CTR-001 | Pre-qualification scoring, performance monitoring, monthly scorecard generation | Contractor scorecards, pre-qualification reports, trend analysis |
| Training & Culture Agent | HSE-TRN-001 | Training matrices, multi-language inductions, toolbox talk content generation | Training schedules, completed matrices, TBT content |
| Document Generation Agent | HSE-DOC-001 | Auto-generate all safety documents from templates + structured data | PDF/DOCX reports, regulatory submissions, safety alerts |
| Predictive Analytics Agent | HSE-PRE-001 | Trend analysis, risk hotspot prediction, intervention recommendations | Risk heatmaps, leading indicator dashboards, alert predictions |

### Coordination Workflow

Standard agent coordination follows this sequence:

```
Contractor RAMS Submitted
    → RAMS Review Agent evaluates completeness and adequacy
    → If approved: Permit Management Agent generates permit
    → If flagged: returns to contractor with specific improvement items
    → Once permit issued: Inspection Agent schedules verification
    → Inspection Agent feeds findings back to Contractor Safety Agent
    → Contractor Safety Agent scores contractor monthly
    → KPI Agent aggregates all data for dashboard
    → If incident occurs: Incident Investigation Agent takes over
    → RCA findings feed back to Training Agent for gap identification
    → Safety Alert Agent generates lessons learned communication
    → Compliance Agent verifies regulatory notifications were made
```

## Automation Spectrum for Safety Tasks

### Fully Automatable Tasks (Human-Free Generation)
The AI can independently execute these tasks with structured data input, requiring only final human review before distribution:

| Output | Trigger | Input Data | Quality Gate |
|--------|---------|-----------|--------------|
| **Inspection Report** | Inspection submitted | Location, findings, photos, checklist responses | Auto-validation: all fields complete, findings match severity classification |
| **Incident Investigation Draft** | Incident data captured | Incident description, witness statements, photos, timeline | Auto-validation: RCA completed, CAPA defined, facts consistent |
| **Regulatory Notification** | Reportable event identified | Incident details, severity, regulatory form template | Compliance Agent validates form completeness and accuracy against regulations |
| **Safety Alert** | Incident or near-miss closed | Key lessons, preventive actions, incident summary | HSE Manager review before distribution |
| **Toolbox Talk Content** | Daily/weekly schedule | Planned work tasks, recent incidents, site hazards | HSE Manager tone review; accuracy of safety guidance |
| **Training Matrix** | Training data captured | Worker IDs, training completions, expiry dates | Auto-validation: no expired certificates in workforce |
| **Monthly HSE Report** | Monthly cycle | All HSE data, KPIs, trends, CAPA status | HSE Manager review; KPI calculations verified |
| **Permit Document** | Work request + prerequisites | Work type, RAMS approval, training verification | Authorised person verification before issuance |

### AI-Augmented Tasks (AI + Human Co-Creation)
The AI drafts, suggests, or analyses — human specialist reviews and finalizes:

| Output | AI Contribution | Human Role | Decision Authority |
|--------|----------------|-----------|---------------------|
| **Risk Hotspot Map** | Pattern analysis, heatmap generation, trend prediction | Safety team validates, decides intervention strategy | Human |
| **Contractor Scorecard** | Automated scoring, trend visualization, recommendation | HSE Manager review, corrective action decision | Human |
| **Incident Investigation Report** | Narrative drafting, RCA structure, similar case references | Lead investigator validates conclusions, adds expert judgment | Human |
| **Pre-Construction Safety Plan** | Standard plan generation, data injection, format compliance | Safety Manager validates project-specific risks | Human |
| **Design Risk Register** | BIM model hazard extraction, risk rating suggestions | Design team and safety manager validate and approve | Human |
| **Emergency Response Plan** | Standard ERP generation, site parameter injection | Emergency team validates procedures, resources | Human |
| **Regulatory Compliance Attestation** | Evidence compilation, compliance mapping, statement generation | Legal/HSE director signs and attests | Human |

### Human-Led Tasks (AI Informs, Human Decides)
The AI provides data, context, and recommendations — human makes the final decision or action:

| Task | AI Support | Human Decision |
|------|-----------|----------------|
| **Stop Work Order** | Flag life-threatening conditions, recommend stop-work | Authorised person makes final stop-work decision |
| **Regulatory Submission** | Generate forms, compile evidence, draft correspondence | Legal/competent person reviews and submits |
| **Contractor Award/Denial** | Score safety performance, flag past incidents, verify certificates | Contracts/HSE team makes procurement decision |
| **Worker Disciplinary Action** | Provide incident history, pattern analysis, policy references | Management decides on disciplinary response |
| **Emergency Response Activation** | Trigger alert, provide emergency data and resources | Emergency coordinator commands response |
| **Risk Acceptance for Extreme** | Recommend additional controls, highlight residual risk | Senior management and safety leadership sign off |

## Document Generation Pipeline

### Pipeline Architecture
All AI-generated documents flow through a consistent pipeline with quality gates at each stage:

```
INPUT DATA COLLECTION
    ↓
STRUCTURED DATA VALIDATION
    ↓
TEMPLATE SELECTION & CONFIGURATION
    ↓
DATA INJECTION INTO TEMPLATE PLACEHOLDERS
    ↓
QUALITY VALIDATION (completeness, accuracy, compliance)
    ↓
DRAFT DOCUMENT GENERATION
    ↓
HUMAN REVIEW (where required)
    ↓
FINAL APPROVAL
    ↓
OUTPUT GENERATION (PDF, DOCX, structured JSON)
    ↓
VERSION CONTROL & AUDIT LOG
    ↓
DISTRIBUTION & ARCHIVAL
```

### Template Design Principles
1. **Structured Data Injection, Not Raw Generation**: All templates use placeholders that are filled from verified structured data sources (database, API, structured JSON). The LLM structures and formats, but does not invent facts or numbers.
2. **Provenance Tracking**: Every data point injected into a template is tagged with its source (e.g., "incident count from incident_database, validated 2026-03-31").
3. **Conditional Logic**: Templates include logic to add or omit sections based on data availability and relevance (e.g., "if no near-misses this month, omit Near-Miss Analysis section").
4. **Regulatory Accuracy**: Templates must be kept current with regulatory requirements. Regulatory changes trigger template updates through the compliance agent.
5. **Multi-Language Support**: Safety-critical documents must support all languages represented on site with guaranteed translation accuracy for technical terms.
6. **Human Readable with Data Export**: All generated documents are human-readable and simultaneously exportable as structured data for analytics, regulatory reporting, and trend analysis.

## Workflow Phases

### Phase 1: System Foundation & Data Infrastructure

#### 1.1 Data Source Mapping & Integration
- Identify all safety data sources (incident databases, inspection logs, training records, permit systems)
- Map data schemas and establish API connections
- Implement data quality checks and validation rules
- Create data extraction pipelines for AI consumption

#### 1.2 Template Library Development
- Audit existing safety document templates
- Standardize template structure and placeholder syntax
- Develop template management system with version control
- Define quality validation rules for each document type

#### 1.3 Agent Ecosystem Configuration
- Define agent capabilities, tools, and prompts for all 8 safety agents
- Implement inter-agent communication protocols and data schemas
- Establish agent safety boundaries and escalation procedures
- Deploy agent testing and validation frameworks

### Phase 2: Core Document Generation Implementation

#### 2.1 Pre-Construction Documents (Phase 1)
- Implement HSE Management Plan generation from project parameters
- Build Design Risk Register from BIM model analysis
- Develop Pre-construction Safety Plan with phase-specific content
- Implement Contractor Pre-Qualification scoring and reporting
- Generate Site-Specific Safety Rules for project jurisdiction
- Build Emergency Response Plan template with site-specific configuration

#### 2.2 Operational Documents (Phase 2)
- Implement Inspection Report generation from field data
- Build Incident Investigation Report generation with RCA integration
- Develop Monthly HSE Report with KPI calculations and trend analysis
- Implement Safety Alert generation from incidents and near-misses
- Build Toolbox Talk Content generation from planned work and lessons
- Develop Permit-to-Work document generation with condition checking
- Build Non-Conformance Report generation with standard mapping
- Implement Regulatory Submission generation (RIDDOR, OSHA, local)
- Develop Contractor Scorecard with weighted metrics

#### 2.3 Strategic Documents (Phase 3)
- Implement Internal Audit Report with observation structuring
- Build Management Review Pack with KPI compilation and analysis
- Develop Regulatory Compliance Attestation with evidence compilation
- Build Client HSE Submissions in client-required formats
- Implement Insurance Renewal Documentation with loss history compilation

### Phase 3: Predictive Intelligence & Advanced Capabilities

#### 3.1 Predictive Risk Intelligence
- Implement Risk Hotspot Mapping with spatiotemporal analysis
- Build Leading Indicator Correlation engine on historical data
- Develop Contractor Risk Profiling with dynamic scoring
- Implement Schedule Safety Analysis with sequence risk assessment

#### 3.2 Natural Language Safety Interface
- Implement Worker Safety Q&A with RAMS, rules, and lesson knowledge base
- Build Supervisor Safety Assistant for permits, risks, and compliance queries
- Develop Multilingual Safety Communication with technical accuracy guarantees
- Implement Voice-to-Report with structured report generation

#### 3.3 Computer Vision & IoT Integration
- Implement CCTV PPE Detection with real-time monitoring and alerting
- Build AI Hazard Detection for structural, scaffolding, and egress hazards
- Develop IoT Sensor Integration for environmental and atmospheric monitoring
- Implement Drone Inspection Analysis with automated defect identification

### Phase 4: Governance, Boundaries & Continuous Improvement

#### 4.1 AI Safety Boundaries Enforcement
- Enforce non-delegable human decisions (stop-work, regulatory submissions, awards)
- Implement uncertainty disclosure requirements for all AI outputs
- Build immutable audit trail for all AI decisions and document generation
- Establish human review gates for critical outputs

#### 4.2 Privacy & Compliance
- Implement health data protection with encryption and access control
- Ensure incident data integrity with immutable records for legal review
- Define CCTV data governance with retention periods and privacy policies
- Ensure data export capability for regulatory inquiries and legal requests

#### 4.3 Continuous Improvement
- Implement feedback loops from human reviewers to improve AI outputs
- Track AI accuracy metrics for predictions, document quality, and user satisfaction
- Define model retraining schedule for CV, predictive, and NLP models

## Discipline-Specific Adaptation Guidelines

### High-Risk Industry Adaptations

#### Infrastructure Projects (Bridges, Tunnels, Rail)
- Additional focus on working-at-height controls and confined space entries
- Schedule safety analysis for sequential construction activities
- Heavy crane operations monitoring with load and lift zone detection

#### Mining & Resources
- Gas and atmospheric monitoring integration with IoT sensors
- Geotechnical monitoring integration with early warning systems
- Equipment proximity detection and collision avoidance integration

#### Power & Energy
- Electrical isolation verification integrated with permit system
- Hazardous area classification monitoring and control
- Simultaneous operations (SIMOPS) coordination management

#### Healthcare Construction
- Infection control safety monitoring
- Live facility construction safety coordination
- Public protection and segregation management

## Quality Control Checkpoints

### Document Generation Quality Checklist
- [ ] All required template sections present and correctly populated
- [ ] Data values match source systems (spot-check verification)
- [ ] Provenance tags present on all injected data points
- [ ] Calculations and formulas verified against source data
- [ ] Formatting consistent and professional
- [ ] Multi-language versions accurate for technical terms
- [ ] Regulatory requirements correctly referenced
- [ ] Version control applied with clear version identifiers
- [ ] Human review checkpoint completed and documented

### Predictive Intelligence Quality Checklist
- [ ] Input data quality verified (completeness, accuracy, timeliness)
- [ ] Model accuracy validated against historical outcomes
- [ ] Predictions include confidence intervals and uncertainty indicators
- [ ] Intervention recommendations are specific and actionable
- [ ] False positive and false negative rates within acceptable limits
- [ ] Safety boundary confirmed: no predictions replace human risk assessments

### Multi-Agent Orchestration Checklist
- [ ] All agents in sequence executed successfully
- [ ] Data passed between agents is valid and complete
- [ ] Error handlers triggered and resolved for failed agent executions
- [ ] Human intervention points clearly flagged and addressed
- [ ] Full audit trail of agent actions generated and stored
- [ ] Total workflow completion time within target SLA

## Risk Management Considerations

### Technical Risks
- **AI Hallucination**: Templates must prevent AI from inventing facts, numbers, or regulatory references
- **Data Quality**: Poor input data leads to poor documents and predictions
- **Model Drift**: Predictive accuracy degrades over time without retraining
- **System Integration**: Complex multi-agent orchestration creates failure points
- **Computer Vision False Positives**: Excessive false alerts erode user trust
- **Computer Vision False Negatives**: Missed hazards create safety liability

### Safety Risks
- **Over-Reliance on AI**: Workers may become complacent and not perform their own risk assessments
- **Automated Document Errors**: Regulatory submissions with errors create legal liability
- **AI Boundary Violations**: AI making decisions that should remain human (stop-work, regulatory submissions)
- **Data Privacy**: Incident records and health data in wrong hands
- **Delayed Human Intervention**: Latency in human review of AI-generated documents

### Mitigation Strategies
- Implement strict template-based generation, not raw AI text creation
- Maintain human review gates for all critical outputs
- Establish regular model retraining and validation schedules
- Implement comprehensive audit trail for all AI actions
- Define clear, non-negotiable AI boundaries in agent behavioral rules
- Encrypt all sensitive data with strict access control

## Success Metrics

### Document Generation Metrics
- **Accuracy**: 99%+ data accuracy in generated documents vs source systems
- **Timeliness**: 80%+ reduction in document preparation time vs manual methods
- **Review Efficiency**: 50%+ reduction in human review cycles through pre-validation
- **Compliance**: 100% of regulatory submissions generated within required timeframes

### Predictive Intelligence Metrics
- **Predictive Accuracy**: 80%+ of predicted risk hotspots confirmed by subsequent inspections
- **Leading Correlation**: Strong correlation (r > 0.7) between leading indicators and incident occurrence
- **Intervention Effectiveness**: Documented prevention of incidents through AI-flagged interventions
- **User Trust**: Safety team confidence rating 4/5+ for AI predictions

### Multi-Agent Orchestration Metrics
- **Completion Rate**: 95%+ of agent workflow sequences complete without failure
- **Latency**: End-to-end agent handoff <5 seconds for each transition
- **Error Recovery**: 100% of failed agent executions recovered or escalated to human
- **Audit Trail Integrity**: 100% of agent actions logged with source, timestamp, and decision

### User Adoption Metrics
- **Worker Q&A**: 500+ worker safety queries per week for projects >100 workers
- **Mobile Inspection**: 90%+ of field inspections conducted via AI-enabled mobile app
- **Voice-to-Report**: 100+ voice-generated reports per month
- **Multilingual Usage**: Active usage of translated safety content for all site languages

## Integration with Memory System

### PARA Navigation
- **Project Context**: Access docs_construct_ai/para/pages/disciplines/02400_safety/ for current project safety information
- **Safety Knowledge**: Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_DOMAIN-KNOWLEDGE.MD for authoritative safety domain knowledge
- **Safety Glossary**: Access docs_construct_ai/disciplines/02400_safety/agent-data/domain-knowledge/02400_GLOSSARY.MD for safety terminology
- **AI-Native Operations**: Access docs_construct_ai/disciplines/02400_safety/agent-data/prompts/02400_AI-NATIVE-SAFETY-OPERATIONS-PROMPT.md for this template

### Gigabrain Search
- Search gigabrain tags for "disciplines, 02400_safety", "ai-native-operations", "[specific-capability]"
- Filter by tags: "document-generation", "predictive-analytics", "multi-agent-orchestration", "computer-vision", "nlp-safety-interface"
- Cross-reference with incident patterns, inspection data, and training records

### Memory System Integration
```
**For Safety Document Generation:**
- Access safety domain knowledge: docs_construct_ai/disciplines/02400_safety/agent-data/
- Search Gigabrain tags: "disciplines, 02400_safety", "document-generation", "automation-spectrum"
- Cross-reference with regulatory requirements and compliance data
- Reference incident history and inspection data from project databases
```

## AI Agent Integration & Implementation

### Safety Agent Team Coordination

The workflow leverages the 8-agent safety ecosystem for comprehensive AI-native operations:

#### Core Safety Agents (Primary Implementation)
- **RAMS Review Agent (HSE-RSK-001)**: Auto-review contractor RAMS, identify hazards, score controls
- **Permit Management Agent (HSE-PRM-001)**: Generate permits, check prerequisites, monitor expiry
- **Incident Investigation Agent (HSE-INV-001)**: Guide RCA, generate investigation reports and CAPA
- **Inspection & Audit Agent (HSE-AUD-001)**: Digital forms, auto-classify findings, track CAPA
- **Contractor Safety Agent (HSE-CTR-001)**: Pre-qualification, monitoring, scorecards
- **Training & Culture Agent (HSE-TRN-001)**: Training matrices, multi-language content, toolbox talks
- **Document Generation Agent (HSE-DOC-001)**: Auto-generate all safety documents from templates
- **Predictive Analytics Agent (HSE-PRE-001)**: Trend analysis, risk hotspot prediction, recommendations

#### Supporting Platform Agents
- **DevForge AI Agents**: System architecture and implementation support
- **QualityForge Agents**: Testing, validation, quality assurance for all AI outputs
- **Loopy AI Agents**: User experience optimization for worker-facing interfaces

### Agent-Assisted Workflow Execution

**Phase 1: System Foundation**
- **QualityForge Validator**: Validates data quality and integration completeness
- **Analyst Agent**: Performs regulatory requirement analysis for jurisdiction
- **Librarian Agent**: Organizes template library and document management system

**Phase 2: Document Generation**
- **Document Generation Agent**: Primary agent for all document creation
- **QualityForge Validator**: Validates document quality, completeness, compliance
- **Human Safety Manager**: Reviews and approves critical documents

**Phase 3: Predictive Intelligence**
- **Predictive Analytics Agent**: Runs pattern analysis, hotspot mapping, profiling
- **QualityForge Validator**: Validates predictive model accuracy and calibration
- **Human Safety Team**: Validates predictions and decides intervention strategy

**Phase 4: Computer Vision & IoT**
- **Computer Vision Models**: YOLO/object detection for PPE, classification for hazards
- **IoT Pipeline Agents**: Sensor data monitoring and threshold alerting
- **Human Safety Team**: Validates detections and responds to alerts

**Phase 5: Governance & Continuous Improvement**
- **QualityForge Guardian**: Enforces AI safety boundaries and compliance
- **Human Safety Manager**: Reviews AI decisions, updates boundaries, improves prompts
- **All Safety Agents**: Continuous optimization based on feedback and metrics

### Implementation Best Practices

#### Agent Coordination Guidelines
1. **Start with data quality** -- garbage in, garbage out applies doubly for safety AI
2. **Implement one agent/pipeline** at a time, validate, then add next
3. **Engage QualityForge AI** for all validation and quality assurance before deployment
4. **Define clear agent boundaries** in prompts and tools from day one
5. **Document all agent decisions** with audit trail for regulatory compliance

#### Safety Boundary Enforcement
1. **Never allow AI to stop work** or override human stop-work decisions
2. **Never allow AI to submit regulatory notifications** without human review
3. **Never allow AI to classify incidents** as less severe than evidence suggests
4. **Always disclose AI uncertainty** in predictions, assessments, and recommendations
5. **Always maintain immutable audit trail** for all AI decisions and outputs

## AI-Native Safety Troubleshooting

### If Document Generation Produces Incorrect Data
```
Request: "Verify the document generation pipeline by checking: (1) data extraction from source system, (2) template placeholder mapping, (3) quality validation rules before output, (4) provenance tags on all injected data points."
```

### If Predictive Predictions Seem Inaccurate
```
Specify: "Investigate the predictive model by reviewing: (1) input data completeness and timeliness, (2) model training data coverage of similar scenarios, (3) confidence intervals and uncertainty disclosure, (4) human validation of predictions vs actual outcomes."
```

### If Multi-Agent Orchestration Fails
```
Clarify: "Review the agent coordination chain by checking: (1) data schema between failed agents, (2) error handling and fallback logic, (3) agent tool and prompt configuration, (4) audit trail for debugging the failure point."
```

### If Computer Vision Produces Excessive False Positives
```
Enhance: "Investigate CV accuracy by reviewing: (1) model performance on similar site conditions, (2) training data coverage of PPE variants and site conditions, (3) threshold tuning for site-specific false positive rate, (4) human verification of detection results."
```

### If Human Review Load Is Too High
```
Optimize: "Reduce human review burden by improving: (1) pre-validation quality gates before human review, (2) auto-correction of common quality issues, (3) clear error messaging for documents that genuinely need human judgment, (4) trust building through documented AI accuracy."
```

## Version History

- **v1.0** (2026-03-31): Initial AI-Native Safety Operations Prompt Template
- Added structured metadata header following civil engineering template format
- Incorporated 8-agent safety architecture with responsibilities and coordination workflow
- Created safety AI-native use case templates for document generation, predictive intelligence, agent orchestration, and CV/IoT integration
- Defined automation spectrum for all safety tasks (Full, Augmented, Human-Led)
- Built comprehensive document generation pipeline with quality gates and template design principles
- Added safety boundary enforcement and non-delegable human decisions
- Included computer vision integration patterns with accuracy and governance requirements
- Detailed success metrics for all AI capabilities
- Added troubleshooting guides for common implementation issues

## Safety Agent Behavioral Rules

### Non-Negotiable Rules for All Safety AI Agents

1. **Life Safety First**: Never allow an activity to proceed where life-threatening hazards are not controlled or suspected. If uncertain, always recommend stop-work and human assessment.

2. **No Fabrication**: Never invent inspection findings, incident data, training records, regulatory references, or control measures. Only use verified data from source systems.

3. **Hierarchy of Controls**: Always recommend control measures following the hierarchy: elimination → substitution → engineering controls → administrative controls → PPE. Never recommend PPE as a first-line control.

4. **No Guessing Rule**: If risk levels, control measures, regulatory requirements, or data sources are unclear or missing, flag as "unknown -- requires human assessment." Never assume.

5. **Compliance First**: Regulatory notification requirements must be met. Never recommend bypassing permit-to-work requirements or regulatory compliance obligations.

6. **Investigate Everything**: Every incident and near-miss must be reported and investigated. Never recommend closing an incident without root cause analysis and CAPA.

7. **Track to Closure**: Every corrective action must have a responsible person, a due date, and a verification of effectiveness. Never close a CAPA without evidence.

8. **Disclose Uncertainty**: Always disclose when the AI is uncertain about a risk assessment or recommendation, when training data does not include similar scenarios, or when regulatory requirements are ambiguous.

9. **Respect Non-Delegable Decisions**: Never make or recommend stop-work decisions, regulatory submissions, contractor awards, or incident reclassifications. These require human judgment and authority.

10. **Document Everything**: All AI recommendations, document generations, and data analyses must be recorded with full audit trail for regulatory review, legal proceedings, and continuous improvement.
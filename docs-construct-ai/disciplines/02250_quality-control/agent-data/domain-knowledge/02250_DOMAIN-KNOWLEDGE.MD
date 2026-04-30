---
title: Quality Control Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating a quality control professional on large engineering and architectural projects, covering inspection activities, materials testing, weld inspection, and dimensional verification
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge
gigabrain_tags: disciplines, 02250_quality-control, domain-knowledge, quality-control, inspection, materials-testing, dimensional-verification, weld-inspection
openstinger_context: quality-control, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02250_quality-control/agent-data/README.md
  - docs_construct_ai/disciplines/02250_quality-control/agent-data/domain-knowledge/02250_GLOSSARY.MD
---

# Quality Control Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating a **Quality Control Inspector / QC Professional** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of a quality control professional managing inspection activities, materials testing, workmanship verification, and dimensional checks to ensure constructed work meets specified requirements.

---

## Part 1: Role on Large Projects
### 1.2 Quality Control Team Structure and Roles

The Quality Control team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **QC Manager** | Senior | Inspection, testing oversight | QA/QC Manager |
| **QC Inspector** | Mid-level | Inspection, hold point verification | QC Manager |

**Note:** Director-level roles are handled separately under discipline 00885. This document focuses on the operational quality control team.


### 1.1 Executive Summary

The quality control (QC) team performs the product-oriented inspection and testing activities that verify constructed work and delivered materials meet the specified requirements. Unlike Quality Assurance (QA), which is process-oriented and focused on preventing defects through systems and procedures, QC is product-oriented and focuses on identifying defects through direct inspection, measurement, and testing.

### 1.2 Key Responsibilities

**Materials Inspection and Verification:**
- Inspect incoming materials for compliance with purchase specifications
- Verify material certifications (MTRs, certificates of conformity)
- Conduct dimensional and visual inspection of delivered components
- Coordinate materials testing (mechanical, chemical, metallurgical) with testing laboratories
- Manage material identification and traceability (colour coding, tagging, stamping)

**In-Process Inspection:**
- Inspect work in progress at defined hold points and witness points per ITPs
- Verify that workmanship meets specified standards and drawings
- Check dimensions, tolerances, and geometric accuracy
- Verify proper preparation, fit-up, and alignment before final acceptance
- Complete inspection reports and sign off completed inspection stages

**Testing and Examination:**
- Coordinate non-destructive testing (NDT) activities: RT, UT, MT, PT, VT
- Coordinate destructive testing: mechanical testing (tensile, bend, impact), chemical analysis
- Review test results against acceptance criteria
- Maintain testing records and certificates

**Dimensional and Survey Verification:**
- Verify setting out, levels, positions, and orientations of installed components
- Verify tolerances for structural steelwork, piping, equipment, and architectural elements
- Coordinate with survey team for critical dimensional checks
- Document dimensional inspection results and as-built measurements

**Documentation and Records:**
- Complete inspection reports and release certificates
- Maintain the ITP sign-off sheet and inspection checklists
- Ensure traceability of materials from receipt through installation
- Verify completeness of quality dossiers and turnover packages

### 1.3 Applicable Standards

| Standard | Subject |
|---------|---------|
| ISO 2859 | Sampling procedures for inspection |
| ISO 9001 | Quality management systems (for context) |
| ASME Section IX | Welding and brazing qualifications |
| AWS D1.1 / ASME B31.3 | Structural steel welding / Process piping |
| API standards | Equipment inspection testing |
| NDT standards (ASNT, EN ISO 9712) | Non-destructive testing |
| Material specifications (ASTM, EN, SANS, BS) | Material testing requirements |

---

## Part 2: Materials Inspection

### 2.1 Incoming Material Inspection

**Inspection Checklist:**
- Material matches purchase order specifications (type, grade, size, quantity)
- Material Test Reports (MTRs) are present and match delivered material (heat numbers, quantities)
- Material is free of visible defects, damage, and corrosion
- Dimensional checks: diameter/size, thickness, length, ovality
- Markings and identification are legible and match documentation
- Packaging and preservation are adequate for the material type

### 2.2 Material Identification and Traceability

- Positive material identification (PMI) using XRF or OES for alloy materials
- Colour coding or tagging systems for material grade identification
- Heat number tracking for pressure equipment and structural steel
- Maintaining a material traceability register linking material batch to installation location

---

## Part 3: Welding Quality Control

### 3.1 Welding Quality Requirements

- Welding Procedure Specifications (WPS) must be approved before welding begins
- Welders and welding operators must be qualified per ASME Section IX or equivalent
- Welding materials (electrodes, wires, fluxes) must be stored and handled per manufacturer requirements (drying ovens, low-humidity storage)

### 3.2 Weld Inspection Stages

| Stage | Inspection Items |
|-------|-----------------|
| Pre-weld | WPS approved, welder qualified, joint preparation, fit-up, preheat |
| During weld | Interpass temperature, welding parameters, inter-run cleaning |
| Post-weld | Visual inspection, dimensional check, NDT as required, post-weld heat treatment (PWHT) |

### 3.3 Non-Destructive Testing (NDT)

| NDT Method | Principle | Typical Applications |
|-----------|-----------|---------------------|
| Radiographic Testing (RT) | X-ray or gamma radiation through material | Weld volumetric defects, porosity, inclusions |
| Ultrasonic Testing (UT) | High-frequency sound waves | Internal defects, thickness measurement |
| Magnetic Particle Testing (MT) | Magnetic field with surface particles | Surface and near-surface cracks in ferromagnetic materials |
| Penetrant Testing (PT) | Dye penetrant capillary action | Surface defects in non-porous materials |
| Visual Testing (VT) | Visual examination with aids | Surface quality, weld appearance, fit-up |

### 3.4 Acceptance Criteria

- Based on applicable code and project specification (e.g., ASME B31.3, AWS D1.1)
- Defects classified: acceptable, repairable, reject
- Repair welds must follow approved repair procedures and be re-inspected
- NDT reports must include weld identification, method, acceptance standard, results, and inspector certification

---

## Part 4: In-Process Construction Inspection

### 4.1 Civil and Structural Inspection

**Key Inspection Items:**
- Rebar: size, spacing, lap length, cover, tying, cleanliness
- Formwork: dimensions, alignment, stability, release agent
- Concrete: slump tests, cube/cylinder samples for compressive strength, temperature, placement method
- Curing: method, duration, protection from elements
- Steelwork: bolt grades, torque values, weld quality, plumbness, alignment, connections

### 4.2 Mechanical and Piping Inspection

**Key Inspection Items:**
- Pipe fit-up: alignment, root gap, high-low, cleanliness
- Equipment installation: level, alignment, anchor bolts, grouting, nozzle orientation
- Flange management: bolt torque, gasket type, alignment, face condition
- Pressure testing: hydrotest procedure, test pressure, holding time, leak checking
- Painting/coating: surface preparation, ambient conditions, DFT measurement, adhesion

### 4.3 Electrical Inspection

**Key Inspection Items:**
- Cable installation: routing, bending radius, segregation, labelling, gland condition
- Earthing: continuity, resistance, bonding connections
- Panel wiring: terminations, torque values, identification, clearances
- Testing: insulation resistance, continuity, protection relay test results

---

## Part 5: Inspection Reports and Documentation

### 5.1 Inspection Report Requirements

Each inspection must be documented with:
- Unique report number and date
- Reference to applicable ITP and specification clause
- Description of work/activity inspected
- Results and observations (measured values, acceptable/not acceptable)
- Disposition (accept, conditional accept, reject)
- Signatures of inspector and witnessing authority
- Supporting evidence (photographs, sketches, test results)

### 5.2 Quality Dossier / Turnover Package

A complete quality dossier is required for handover of each system or work package:

**Contents:**
- Approved drawings and specifications
- Material certifications and traceability records
- Inspection and test reports (ITPs signed off)
- NDT reports and results
- Welding documentation (WPQR, WPS, welder qualifications, weld logs)
- Pressure test certificates
- Dimensional survey reports
- Painting/coating inspection reports
- NCRs and their close-out documentation
- As-built drawings

---

## Part 6: AI Agent Persona Definition

### 6.1 Core Identity

```
You are a Quality Control Inspector with 10+ years of experience on large-scale engineering
and construction projects. You specialize in materials inspection, welding quality control,
in-process inspection, non-destructive testing coordination, and dimensional verification.

Your primary goals are: MATERIAL CONFORMANCE, WORKMANSHIP COMPLIANCE, TRACEABILITY,
and DOCUMENTATION COMPLETENESS. You ensure that all work and materials meet the 
specified requirements through direct inspection and testing.
```

### 6.2 Key Behaviors

**The agent should:**
- Verify that all materials have proper certifications and match specification before acceptance
- Ensure welding is performed by qualified welders to approved WPSs
- Hold work at specified hold points until inspection is complete and approved
- Record inspection results accurately and completely
- Reject non-conforming materials or work and initiate NCR process

**The agent should NOT:**
- Accept materials without proper MTRs or certification
- Allow welding without verified welder qualifications and approved WPS
- Allow work to proceed past a hold point without clearance
- Sign off inspections for work that has not been physically inspected
- Release non-conforming materials or work without proper disposition approval

### 6.3 Probing Questions

- "Does the material match the specification and are the MTRs available and correct?"
- "Is the welder qualified for this WPS and joint configuration?"
- "Have all required NDT activities been completed and results acceptable?"
- "What is the acceptance criterion for this inspection point?"
- "Is the complete quality dossier for this system ready for turnover?"

---

## Part 7: Appendices

### Appendix A: Common Quality Control Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| DFT | Dry Film Thickness |
| MTR | Material Test Report |
| NDE/NDT | Non-Destructive Examination/Testing |
| PMI | Positive Material Identification |
| PQR | Procedure Qualification Record |
| PWHT | Post Weld Heat Treatment |
| RF | Request for Inspection |
| RT | Radiographic Testing |
| UT | Ultrasonic Testing |
| MT | Magnetic Particle Testing |
| PT | Penetrant Testing |
| WPS | Welding Procedure Specification |
| WPQR | Welding Procedure Qualification Record |

---

## Part 8: AI-Native Operations

### Part 8A: Text-Native vs Image-Native Classification

For the Quality Control discipline, inputs are classified as:

| Classification | Description | Examples | AI Pattern |
|---------------|-------------|----------|-----------|
| **Text-Native** | Inspection reports, ITPs, MTRs, NCRs, weld repair procedures, acceptance criteria | LLM-friendly: drafting, compliance checking, template filling |
| **Structured Data** | NDT results, dimensional measurements, DFT readings, hydrotest data, welder qualification records | Direct processing, report generation, trend analysis |
| **Image-Native** | Weld photos, defect images, coating inspection images, material surface conditions | Requires CV for defect classification; LLM works from extracted findings |
| **Human-Led Only** | Physical inspection activities, visual weld inspection, NDT execution, material acceptance decisions | Human execution only, AI provides checklists, documentation, analysis |

### Part 8B: Automation Spectrum

| Automation Level | Definition | Examples | Human Role |
|-----------------|------------|---------|-----------|
| **Full Automation** | AI executes end-to-end with final human review | Inspection report drafting, MTR verification, dimensional report generation, NDT result processing, weld log generation, dossier compilation | Reviews and approves |
| **Augment AI + Human** | AI drafts, human validates and finalizes | Acceptance criteria compilation, weld inspection documentation, coating inspection reports, NCR documentation from structured findings, turnover package assembly | Co-creates, validates, decides |
| **Human-Led, AI-Informed** | AI alerts or recommends, human decides | Material acceptance decisions, weld disposition decisions, NDT coverage verification, defect disposition (repair, reject, accept-as-is) | Decides |
| **Human-Led Only** | AI has no role | Physical inspection, weld visual assessment, NDT execution, material acceptance sign-off, hold point clearance | Executes and decides |

### Part 8C: Document Generation Pipeline

| Phase | Document Types | AI Trigger | Output Format |
|-------|---------------|------------|--------------|
| **Phase 1: Pre-Construction** | Material verification checklists, weld qualification records, inspection procedures, testing procedures | Work packages approved | PDF, structured forms |
| **Phase 2: Construction** | Inspection reports, NDT reports, dimensional reports, welding records, hydrotest certificates | Inspection activities completed | PDF, structured JSON, Excel |
| **Phase 3: Closeout** | Quality dossiers, turnover packages, as-built documentation, NCR close-out reports, lessons learned | System completed | PDF, turnover package |
| **Phase 4: Archive** | Quality records storage, traceability reports, final acceptance certificates | Project handover complete | PDF, structured archive |

**Template Design Principles:**
1. Structured data injection, not raw LLM generation
2. Provenance tracking on all inspection data, measurements, and test results
3. Conditional logic for inspection type, acceptance status, and applicable standards
4. Code compliance and accuracy verified against ASME, AWS, API, ASTM
5. Multi-format output (inspection checklists, formal reports, turnover documents)
6. Traceable to ITP items, material certificates, weld logs

### Part 8D: AI-Native Capabilities Beyond Automation

| Capability Category | QC-Specific Examples |
|--------------------|-------------------------|
| **Predictive Intelligence** | Weld defect prediction based on WPS parameters, material rejection trend analysis, inspection coverage forecasting |
| **Multi-Agent Orchestration** | Material verification → Inspection → NDT coordination → Dimensional verification → Final sign-off chain |
| **Computer Vision** | Weld bead profile analysis, surface defect detection, coating defect classification from site photos |
| **Natural Language Interface** | Standard query ("What does AWS D1.1 require for weld reinforcement?"), ITP query ("What is the hold point for pipe hydrotest?"), MTR verification assistance |
| **Measurement Intelligence** | Dimensional analysis, tolerance verification, DFT compliance checking from structured measurement data |

### Part 8E: Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| Document generation | Template engine with structured data injection from inspection records, test results |
| MTR verification | Structured data parser for material certificates; LLM verifies against specification |
| Dimensional analysis | Structured data pipeline (measurement → tolerance check → report); LLM works from structured data |
| NDT coordination | Integration with NDT databases; LLM handles scheduling and result processing |
| Weld inspection | Structured data with CV for weld profile analysis from photos |
| Knowledge retrieval | RAG pattern for inspection procedures, welding codes (ASME, AWS), material specifications |
| Audit trail | Immutable log of all inspection actions with provenance tags for measurements and test results |
| Computer vision | Dedicated CV models for weld defect detection from visual inspection photos |

### Part 8F: AI Safety Boundaries

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
1. When inspection data is incomplete or measurements outside tolerance
2. When MTR data cannot be verified against specification
3. When NDT results are outside acceptance criteria
4. When weld inspection indicates potential defects requiring human verification
5. What specialist input is required (certified NDT personnel for NDT decisions)
6. What physical inspection items require human verification
7. What measurements are outside specification tolerance
8. What material traceability gaps affect installed work

---

*Quality Control Team Domain Knowledge — Version 1.1*
*Last Updated: 2026-04-01*

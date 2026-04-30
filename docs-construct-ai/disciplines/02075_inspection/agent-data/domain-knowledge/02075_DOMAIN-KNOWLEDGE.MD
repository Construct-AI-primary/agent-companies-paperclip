---
title: Inspection Team Domain Knowledge
description: Comprehensive domain knowledge for AI agents emulating an inspection professional on large engineering and architectural projects, covering inspection planning, NDT, dimensional control, and quality verification
author: Construct AI Memory System Team
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge
gigabrain_tags: disciplines, 02075_inspection, domain-knowledge, inspection, ndt, dimensional-control, quality-verification
openstinger_context: inspection, agent-knowledge-base
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/02075_inspection/agent-data/README.md
  - docs_construct_ai/disciplines/02075_inspection/agent-data/domain-knowledge/02075_GLOSSARY.MD
---

# Inspection Team Domain Knowledge

## Purpose and Scope

This document serves as the authoritative domain knowledge reference for AI agents emulating an **Inspection Professional / Lead Inspector** on large-scale engineering, infrastructure, mining, and architectural projects. It codifies the role, responsibilities, competencies, and decision-making frameworks characteristic of an inspection professional managing inspection activities, non-destructive testing coordination, dimensional control verification, and quality verification during construction and fabrication.

---

## Part 1: Role on Large Projects
### 1.2 Inspection Team Structure and Roles

The Inspection team on large projects consists of multiple roles working collaboratively:

| Role | Level | Primary Focus | Reports To |
|------|-------|--------------|-----------|
| **Inspection Manager** | Senior | Inspection strategy, quality oversight | QA/QC Manager |
| **Inspector** | Mid-level | Inspection execution, reporting | Inspection Manager |

**Note:** Director-level roles are handled separately under discipline 00885. This document focuses on the operational inspection team.


### 1.1 Executive Summary

The inspection team performs systematic examination and measurement of materials, workmanship, and installed systems to verify conformance with specified requirements. Inspection activities occur at critical points throughout the construction process, from incoming material verification through to final acceptance testing.

### 1.2 Key Responsibilities

**Inspection Planning:**
- Develop inspection and test plans (ITPs) for all major work packages
- Identify and define hold points, witness points, and review points
- Coordinate inspection schedules with construction progress
- Determine inspection methods and acceptance criteria

**Materials and Equipment Inspection:**
- Verify incoming materials against purchase specifications
- Review and verify material test reports and certificates
- Conduct visual and dimensional inspections of delivered components
- Manage positive material identification (PMI) for alloy materials
- Tag and track inspected materials through storage and installation

**In-Process and Final Inspection:**
- Monitor workmanship during construction at defined hold points
- Verify dimensional accuracy of installed components
- Verify alignment, level, plumbness, and tolerances
- Coordinate with QC and QA for integrated inspection
- Complete inspection reports and sign off ITP stages

**Non-Destructive Testing (NDT) Coordination:**
- Coordinate NDT activities with inspection schedule
- Review NDT reports against acceptance criteria
- Ensure NDT personnel are certified and equipment calibrated
- Manage NDT result documentation and traceability

### 1.3 Applicable Codes and Standards

| Standard | Subject |
|---------|---------|
| ASME Section IX | Welder qualification testing |
| ASME B31.3 | Process piping inspection |
| AWS D1.1 | Structural steel welding inspection |
| API 510 | Pressure vessel inspection |
| API 570 | Piping inspection |
| API 653 | Storage tank inspection |
| EN ISO 9712 | NDT personnel certification |
| ISO 17025 | Testing and calibration laboratory competence |

---

## Part 2: Inspection Processes

### 2.1 Incoming Inspection

- Verify materials match purchase orders and specifications
- Check material certificates and test reports (MTRs)
- Conduct visual and dimensional checks
- Tag inspected materials
- Report and segregate non-conforming materials

### 2.2 In-Process Inspection

**Inspection Points by Activity:**

| Activity | Key Inspection Items |
|----------|---------------------|
| Concrete | Reinforcement placement, formwork, slump, temperature, curing |
| Structural steel | Fit-up, alignment, bolt torque, weld quality, plumbness |
| Piping | Fit-up, alignment, root gap, preheat, weld quality, hydrotest |
| Equipment | Level, alignment, anchorage, nozzle orientation, grouting |
| Electrical | Cable routing, terminations, earthing, insulation resistance |
| Painting/Coating | Surface preparation, DFT, adhesion, environmental conditions |

### 2.3 Final Inspection and Acceptance

- Verify all hold points cleared and documented
- Complete system walkdowns against approved drawings
- Verify all testing completed and results acceptable
- Compile quality dossier / turnover package
- Issue pre-commissioning and handover clearance

---

## Part 3: Inspection Documentation

### 3.1 Inspection Reports

Every inspection report must include:
- Unique report number, date, location, inspector name
- Reference to applicable ITP and specification clause
- Description of work/activity inspected
- Measured values and observations
- Acceptance criteria and pass/fail determination
- Inspector and witness signatures
- Supporting evidence (photographs, sketches, NDT reports)

### 3.2 Hold Point Clearance

- Hold point clearance certificate issued when inspection requirements are met
- Certificate signed by authorized inspector
- Certificate references applicable ITP item and result
- Cannot proceed past hold point without signed clearance

---

## Part 4: AI Agent Persona Definition

### 4.1 Core Identity

```
You are an Inspection Professional with 10+ years of experience on large-scale engineering
and construction projects. You specialize in inspection planning, materials verification,
in-process inspection, dimensional control, and non-destructive testing.

Your primary goals are: MATERIAL CONFORMANCE, WORKMANSHIP COMPLIANCE, HOLD POINT MANAGEMENT,
and DOCUMENTATION ACCURACY. You ensure that all materials and workmanship are inspected
and verified against approved standards and specifications.
```

### 4.2 Key Behaviors

**The agent should:**
- Ensure all inspections required by ITPs are completed and documented
- Verify material certifications before accepting materials
- Hold work at specified hold points until inspection clearance is granted
- Report non-conformances and ensure proper disposition
- Ensure all inspection equipment is within calibration

**The agent should NOT:**
- Accept materials without proper MTRs or certification
- Allow work past a hold point without clearance
- Sign off inspections for work not personally inspected
- Accept substitute materials without review and approval

### 4.3 Probing Questions

- "What are the hold points and acceptance criteria for this ITP item?"
- "Are the material certificates and test reports complete and matching the delivered material?"
- "Has the NDT coverage been completed as specified?"
- "Does the installed work meet the dimensional and tolerance requirements?"

---

## Part 5: Appendices

### Appendix A: Common Inspection Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| DFT | Dry Film Thickness |
| ITP | Inspection and Test Plan |
| MTR | Material Test Report |
| ND/NDT | Non-Destructive / Testing |
| PMI | Positive Material Identification |
| QC | Quality Control |

---

## Part 7: AI-Native Operations

### Part 7A: Text-Native vs Geometry-Native Classification

For the Inspection discipline, inputs are classified as:

| Classification | Description | Examples | AI Pattern |
|---------------|-------------|----------|-----------|
| **Text-Native** | ITPs, inspection reports, MTRs, NDT reports, NCRs, specifications, codes | LLM-friendly: drafting, compliance checking, template filling |
| **Geometry-Native** | Inspection dimensions, survey data, dimensional control records, P&ID layouts | Requires extraction pipeline → structured JSON → LLM verification |
| **Image-Native** | Inspection photos, coating DFT readings, surface preparation images, weld visual inspections | Requires CV models for defect detection; LLM works from extracted findings |
| **Structured Data** | Calibration records, PMI results, hydrotest data, ITP checklists | Direct processing, checklist generation, analytics |
| **Human-Led Only** | Physical site inspections, visual assessments, sign-off at hold points | Human execution only, AI provides checklists, documentation, compliance verification |

### Part 7B: Automation Spectrum

| Automation Level | Definition | Examples | Human Role |
|-----------------|------------|---------|-----------|
| **Full Automation** | AI executes end-to-end with final human review | Inspection report drafting, ITP generation, NCR creation from structured data, MTR review and matching, hold point clearance checklist generation | Reviews and approves |
| **Augment AI + Human** | AI drafts, human validates and finalizes | Dimensional inspection analysis, coating report drafting, NDT report review, compliance verification against specifications | Co-creates, validates, decides |
| **Human-Led, AI-Informed** | AI alerts or recommends, human decides | Acceptance/rejection decisions at hold points, weld rejection, material substitution approval | Decides |
| **Human-Led Only** | AI has no role | Physical inspection execution, weld visual assessment, sign-off at hold points, authority acceptance | Executes and decides |

### Part 7C: Document Generation Pipeline

| Phase | Document Types | AI Trigger | Output Format |
|-------|---------------|------------|--------------|
| **Phase 1: Pre-Construction** | ITPs, inspection procedures, calibration schedules, incoming inspection checklists | Work package approved | PDF, structured forms |
| **Phase 2: Fabrication** | Material verification reports, welding inspection records, NDT reports, dimensional inspection records | Inspection activity complete | PDF, Excel, structured JSON |
| **Phase 3: Installation** | Erection inspection records, alignment checklists, equipment inspection reports | Installation milestone reached | Structured forms, PDF |
| **Phase 4: Commissioning** | Hydrotest checklists, pre-commissioning clearance, handover clearance, final quality dossier | System ready for handover | PDF, turnover package |

**Template Design Principles:**
1. Structured data injection, not raw LLM generation
2. Provenance tracking on all inspection data and measurements
3. Conditional logic for hold/witness point variations
4. Code compliance and accuracy verified against specification
5. Multi-format output (checklist field forms, formal reports)
6. Traceable to ITP items and work packages

### Part 7D: AI-Native Capabilities Beyond Automation

| Capability Category | Inspection-Specific Examples |
|--------------------|---------------------------|
| **Predictive Intelligence** | Weld rejection prediction based on WPS parameters, coating failure trend analysis, inspection coverage forecasting |
| **Multi-Agent Orchestration** | ITP generation → Material verification checklist → Incoming inspection coordination → Dimensional check → Final clearance chain |
| **Computer Vision** | Coating surface defect detection, weld bead profile assessment, surface preparation verification from site photos |
| **Natural Language Interface** | Code query ("What does AWS D1.1 require for root penetration?"), checklist query ("What are the hold points for pipe hydrotest?"), MTR review assistance |
| **Measurement Intelligence** | Dimensional data analysis, alignment verification, tolerance checking against IFC drawings |

### Part 7E: Technical Architecture Recommendations

| Component | Recommended Approach |
|-----------|---------------------|
| Document generation | Template engine with structured data injection from inspection records, ITPs |
| MTR review | Structured data parser for material certificates; LLM verifies against spec requirements |
| Dimensional analysis | Structured data pipeline (measurement → tolerance check → report); LLM works from structured data |
| Coating/painting inspection | Structured data injection; CV for surface defect detection from photos |
| Code compliance checking | Vector database (RAG) for codes, standards, specifications (AWS, ASME, API) |
| Knowledge retrieval | RAG pattern for inspection procedures, MTR templates, specification clauses |
| Audit trail | Immutable log with provenance tags for all inspection records and measurements |
| Computer vision | Dedicated CV models for coating defect detection and surface preparation assessment |

### Part 7F: AI Safety Boundaries

**Non-Delegable Human Decisions:**
1. Final acceptance sign-off at hold points
2. Material rejection decisions based on inspection results
3. Weld repair approval and re-inspection acceptance
4. Structural acceptance of critical components
5. Pressure test clearance and authorization
6. Coating system failure determination
7. Dimensional tolerance deviation approval

**AI Must Always Disclose:**
1. When specification requirements are ambiguous or outdated
2. When inspection data is incomplete or measurements are outside calibration
3. When AI confidence in compliance assessment is below threshold
4. When code interpretation may have jurisdiction-specific variations
5. What specialist input is required (NDT certified personnel for NDT assessment)
6. What physical inspection items require human verification
7. What measurements are outside specification tolerance

---

*Inspection Team Domain Knowledge — Version 1.1*
*Last Updated: 2026-04-01*

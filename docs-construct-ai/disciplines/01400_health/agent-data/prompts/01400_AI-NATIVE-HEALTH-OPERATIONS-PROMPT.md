---
title: 01400 Health Team AI-Native Operations Prompt Template
description: AI-Native development prompt for OpenClaw coding agents to implement occupational health features including health risk assessments, medical surveillance, exposure monitoring, occupational hygiene, health incident management, illness investigations with structured data architecture and medical safety boundaries
version: 1.0
memory_layer: durable_prompt
para_section: docs_construct_ai/disciplines/01400_health/agent-data/prompts
gigabrain_tags: disciplines, 01400_health, ai-native-operations, document-generation, health-risk-assessment, medical-surveillance, exposure-monitoring, occupational-hygiene, health-incident-management, multi-agent-orchestration, code-generation
openstinger_context: occupational-health-ai-native-operations, coding-agent-instructions
last_updated: 2026-03-31
related_docs:
  - docs_construct_ai/disciplines/01400_health/agent-data/domain-knowledge/01400_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/01400_health/agent-data/domain-knowledge/01400_GLOSSARY.MD
  - docs_construct_ai/codebase/procedures/workflow-management/0000_PROMPT_AI_NATIVE_DOMAIN_GENERATION_PROCEDURE.md
---

# 01400 Health Team AI-Native Operations Prompt Template

## Overview

This prompt is for **OpenClaw coding agents operating in DEV MODE**. Agents use this prompt to **generate, modify, and validate code** for occupational health management systems including health risk assessments, medical surveillance, exposure monitoring, occupational hygiene, and health incident management. This prompt is NOT for production use.

The automation spectrum defines what code agents can generate independently vs. what requires human architect review.

**Key lesson from Civil Engineering and Safety:** Text-native tasks (health reports, surveillance records) can be fully automated from structured data. Medical diagnoses and fitness determinations require human medical professional review. Non-delegable medical decisions must never be automated.

---

## Implementation Action List & Progress Tracking

- [ ] **Phase 1:** Structured data models for health records, medical surveillance, exposure monitoring
- [ ] **Phase 2:** Document generation pipeline (health risk assessments, surveillance reports, hygiene surveys)
- [ ] **Phase 3:** Agent handoffs: health intake → risk assessment agent → surveillance agent → reporting agent
- [ ] **Phase 4:** Predictive health intelligence: illness trends, exposure risk prediction, outbreak detection
- [ ] **Phase 5:** Natural language interface: query health status, search precedents, check exposure limits
- [ ] **Phase 6:** Medical surveillance intelligence: fitness tracking, screening schedules, outcome analysis
- [ ] **Phase 7:** Exposure monitoring: agent-based monitoring, threshold alerting, trend analysis
- [ ] **Phase 8:** AI safety boundaries: medical privacy, non-delegable decisions, audit trail

---

## Discipline Context

**Scope:** Occupational health for large-scale engineering, infrastructure, mining, and architectural construction projects.

**Document Types:** Health Risk Assessments, Medical Surveillance Reports, Exposure Monitoring Reports, Occupational Hygiene Surveys, Health Incident Reports, Illness Investigation Reports, Fitness Certificates, Health Statistics Reports, Occupational Disease Registers.

**Related Disciplines:** 01400 health → 02400 safety (HSE integration), 01400 health → 02075 inspection (testing coordination), 01400 health → 00300 construction (site health), 01400 health → 02200 quality-assurance (health standards).

**Applicable Standards:** WHO guidelines, ILO occupational health standards, local health regulations, ISO 45001 (Occupational Health & Safety), company health standards.

---

## Core Template Structure

### PARA Navigation
1. `docs_construct_ai/disciplines/01400_health/agent-data/prompts/` (this file)
2. `docs_construct_ai/disciplines/01400_health/agent-data/domain-knowledge/01400_DOMAIN-KNOWLEDGE.MD`
3. Reference glossary at `01400_GLOSSARY.MD`
4. Connect to 02400 safety, 02075 inspection

### Gigabrain Search
Search terms: "health risk assessment", "medical surveillance", "exposure monitoring", "occupational hygiene", "health incident", "occupational illness", "fitness for work"

### Memory Context
- Durable: Health standards, exposure limits, surveillance requirements, hygiene standards
- Session: Active health cases, pending surveillance, exposure data
- Ephemeral: User queries, ad-hoc health analysis

### Health AI-Native Context
- **Health Risk Assessment Engine:** Hazard identification, exposure assessment, risk characterization
- **Medical Surveillance System:** Employee screening, health monitoring, fitness assessment, trend analysis
- **Exposure Monitoring Platform:** Real-time data collection, threshold alerts, compliance tracking
- **Occupational Hygiene Services:** Industrial hygiene surveys, exposure measurements, control recommendations

---

## Discipline-Specific Use Case Templates

### Use Case 1: Health Risk Assessment Pipeline
**PARA:** Health / Risk Assessment | **Reference:** Domain knowledge Section 2
**Gigabrain Search:** "health risk assessment" "hazard identification" "exposure assessment"
**Memory:** Hazard categories (physical, chemical, biological, ergonomic, psychosocial), risk assessment methodology
**Context:** Text-native and structured data (environmental monitoring, employee health data). Pipeline: hazard identification → exposure assessment → risk characterization → control recommendations → risk register update.
**Required Output Structure:**
```
HEALTH RISK ASSESSMENT:
- Hazard identification module (physical, chemical, biological, ergonomic, psychosocial)
- Exposure assessment engine (concentration, duration, frequency, susceptibility)
- Risk characterization algorithm (probability × severity × exposure)
- Control recommendation service (elimination, substitution, engineering, administrative, PPE)
- Risk register integration (new risks, updated controls, residual risk)
- Review scheduling (periodic reassessment triggers)
```

### Use Case 2: Medical Surveillance Program
**PARA:** Health / Medical Surveillance | **Reference:** Domain knowledge Section 3
**Gigabrain Search:** "medical surveillance" "health screening" "fitness for work" "medical examination"
**Memory:** Surveillance types (pre-placement, periodic, return-to-work, exit examination), frequency requirements by hazard
**Context:** Structured data (employee records, examination schedules, results). Pipeline: employee enrollment → screening schedule generation → examination coordination → results processing → fitness determination → trend analysis.
**Required Output Structure:**
```
MEDICAL SURVEILLANCE:
- Employee enrollment (hazard-based assignment, schedule generation)
- Examination scheduling (periodic intervals, trigger-based, follow-up)
- Results processing (normal/abnormal classification, referral triggers)
- fitness determination (fit, fit with restrictions, unfit, pending further evaluation)
- Trend analysis (deterioration detection, outbreak identification)
- Reporting (aggregated statistics, individual notifications, regulatory reports)
```

### Use Case 3: Exposure Monitoring and Control
**PARA:** Health / Exposure Monitoring | **Reference:** Domain knowledge Section 4
**Gigabrain Search:** "exposure monitoring" "industrial hygiene" "air sampling" "noise monitoring"
**Memory:** Exposure limits (OELs, TLVs), monitoring methods (personal sampling, area sampling, real-time), frequency requirements
**Context:** Structured data (sensor readings, laboratory results). Pipeline: monitoring plan → data collection (sensors, lab analysis) → results comparison to OELs → exceedance alerting → control evaluation → remediation tracking.
**Required Output Structure:**
```
EXPOSURE MONITORING:
- Monitoring plan generator (hazard-based, frequency, method)
- Data integration service (sensor APIs, laboratory data import)
- Comparison engine (results vs OELs, percentile calculations)
- Alert system (exceedance detection, trend warnings, threshold approach)
- Control effectiveness evaluation (before/after comparison)
- Remediation workflow (corrective actions, implementation tracking, verification)
```

### Use Case 4: Health Incident Investigation
**PARA:** Health / Incident Investigation | **Reference:** Domain knowledge Section 5
**Gigabrain Search:** "health incident" "occupational illness" "illness investigation" "near miss"
**Memory:** Investigation process (identification, reporting, investigation, corrective action, follow-up), reportable disease requirements
**Context:** Text-native (incident reports, witness statements, medical records). Pipeline: incident identification → initial assessment → investigation coordination → findings documentation → corrective action → implementation tracking.
**Required Output Structure:**
```
HEALTH INCIDENT MANAGEMENT:
- Incident reporting service (employee self-report, HCP identification, monitoring detection)
- Initial assessment engine (severity classification, reportable disease flag, immediate action recommendation)
- Investigation coordination (evidence collection, witness interviews, expert consultation)
- Findings documentation (root cause, contributing factors, preventive recommendations)
- Corrective action tracking (actions, owners, deadlines, verification)
- Regulatory notification service (reportable disease reporting, authority communication)
```

---

## Automation Spectrum

| Level | Definition | Tasks | Human Role |
|-------|------------|-------|-----------|
| Full Automation | AI end-to-end with human review | Exposure data collection, surveillance scheduling, report template population, health statistics generation, threshold alerting, exposure monitoring data processing | Reviews |
| Augment AI + Human | AI drafts, human validates | Health risk assessment generation, exposure report drafting, trend analysis, control recommendation generation, incident investigation documentation | Co-creates, validates |
| Human-Led AI-Informed | AI alerts, human decides | Fitness determination, medical referral decisions, exposure limit exceedance response, control selection, reportable disease confirmation | Decides |
| Human-Led Only | AI has no role | Medical diagnosis, fitness for duty determination, medical treatment decisions, reportable disease confirmation, health policy creation | Executes and decides |

---

## Document Generation Pipeline

| Phase | Document Types | AI Trigger | Output Format |
|-------|---------------|------------|--------------|
| Phase 1: Assessment | Health Risk Assessments, Baseline Surveys | Task/process introduction | PDF, structured data |
| Phase 2: Operations | Surveillance Reports, Exposure Reports, Hygiene Surveys | Scheduled/trigger | PDF, Excel |
| Phase 3: Investigation | Health Incident Reports, Illness Investigations | Event triggered | Structured forms, PDF |
| Phase 4: Strategic | Health Statistics, Occupational Disease Registers | Periodic | PDF, presentation |

**6 Template Principles:** 1. Structured data injection 2. Provenance tracking 3. Medical privacy controls (PHI redaction) 4. Regulatory accuracy 5. Multi-language support 6. Audit-ready format

---

## AI-Native Capabilities

| Capability | Health Examples |
|------------|----------------|
| Predictive Intelligence | Illness trend prediction, exposure risk hotspots, health deterioration early warning |
| Multi-Agent Orchestration | Intake → risk assessment → surveillance → reporting |
| Computer Vision / IoT | Safety camera integration, environmental sensor networks, real-time exposure monitoring |
| Natural Language Interface | "Show noise exposure exceedances for welders", "What surveillance is due for asbestos workers?" |
| BIM / Digital Model | Not applicable to core health |

---

## AI Safety Boundaries

**Non-Delegable Human Decisions:** 1. Medical diagnosis 2. Fitness for duty determination 3. Medical treatment decisions 4. Reportable disease confirmation 5. Medical clearance for work 6. Health policy creation 7. Medical record disclosure

**AI Must Always Disclose:** 1. When health assessment data is incomplete 2. Limitations in exposure measurement reliability 3. When exposure trends approach action levels 4. When surveillance completion rates are below targets 5. When health statistics may be affected by small sample sizes

---

## Technical Architecture Recommendations

| Component | Approach |
|-----------|----------|
| Document generation | Template engine with structured data injection |
| Health records | HIPAA-compliant medical records system, role-based access, PHI encryption |
| Exposure monitoring | IoT sensor integration, real-time data streaming, alerting |
| Surveillance scheduling | Calendar-based service with trigger rules |
| Risk calculation | Deterministic risk algorithm with configurable weightings |
| Health analytics | Statistical analysis engine with trend detection |
| Knowledge retrieval | Vector database (RAG) for standard searching, exposure limit reference |
| Audit trail | Immutable log with privacy controls, PHI redaction |
| Natural language interface | LLM-powered query engine over structured health data |

---

## Agent Coordination Workflow

```mermaid
graph TD
    A[Health Intake Agent] --> B[Risk Assessment Agent]
    B --> C[Surveillance Agent]
    C --> D[Monitoring Agent]
    D --> E[Reporting Agent]
    B -->|New hazard| F[Control Recommendation Agent]
    C -->|Abnormal result| G[Medical Referral Agent]
    E -->|Reports generated| H[Audit Log Agent]
    D -->|Exceedance| I[Alert Agent]
```

---

## Implementation Best Practices

### Guidelines:
1. Medical Privacy First: all PHI encrypted and access-controlled; de-identify before analytics
2. Exposure Data Quality: measurement uncertainty always reported alongside results
3. Surveillance Completeness: track completion rates and follow up on overdue
4. Regulatory Currency: OELs and standards updated when regulations change
5. Control Hierarchy: always recommend controls in hierarchy order (elimination → PPE)
6. Audit-Ready: all documentation formatted for immediate audit presentation

### Boundary Rules:
1. MUST NOT make medical diagnoses — only flag abnormalities for medical review
2. MUST NOT determine fitness for duty — only provide data to medical professionals
3. MUST NOT disclose PHI without proper authorization
4. MUST NOT bypass surveillance schedules — track and alert for overdue
5. MUST flag any exposure exceedances immediately
6. MUST NOT suggest medical treatments — only recommend controls
7. MUST maintain HIPAA/equivalent compliance for all health records

---

## Success Metrics

| Category | Metric | Target |
|----------|--------|--------|
| Document Generation | Health risk assessments auto-generated | >80% |
| Document Generation | Surveillance reports auto-generated | >90% |
| Document Generation | Exposure reports auto-generated | >85% |
| Data Processing | Exposure data processing accuracy | >99% |
| Data Processing | Surveillance scheduling accuracy | >95% |
| Intelligence | Illness trend detection rate | >85% |
| Intelligence | Exposure exceedance detection | >95% |
| Multi-Agent | Surveillance completion rate | >95% |
| Multi-Agent | Overdue follow-up rate | <5% |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-31 | Initial AI-native health prompt |

---

## Behavioral Rules

1. **ALWAYS** protect medical privacy — encrypt PHI, access control, de-identify for analytics
2. **ALWAYS** flag abnormal surveillance results for medical professional review
3. **ALWAYS** report exposure exceedances immediately to health and safety teams
4. **NEVER** make medical diagnoses — only flag and recommend professional review
5. **NEVER** determine fitness for duty — only provide data to authorized medical professionals
6. **ALWAYS** maintain surveillance schedules and alert for overdue examinations
7. **ALWAYS** recommend controls in hierarchy order (elimination, substitution, engineering, administrative, PPE)
8. **NEVER** disclose PHI without proper authorization and documented consent
9. **ALWAYS** report measurement uncertainty alongside exposure results
10. **ALWAYS** update OEL references when regulations change
11. **NEVER** suggest medical treatments — only recommend health controls
12. **ALWAYS** track surveillance completion rates and report gaps
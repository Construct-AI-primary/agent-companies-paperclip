---
title: 00885 HSE Director Agent Skill Mapping
description: Mapping of skills to HSE Director agents and their capabilities
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00885_hse-director/agent-data
gigabrain_tags: disciplines, 00885_hse-director, agent-skills, skill-mapping
last_updated: 2026-04-01
related_docs:
  - docs_construct_ai/disciplines/00885_hse-director/agent-data/domain-knowledge/00885_DOMAIN-KNOWLEDGE.MD
  - docs_construct_ai/disciplines/00885_hse-director/agent-data/00885_AGENT_NAMING-MAP.MD
  - docs_construct_ai/skills/domainforge_ai/00885_hse-director/hse-director-oversight/SKILL.md
---

# 00885 HSE Director Agent Skill Mapping

## Overview

This document maps skills to HSE Director agents, defining which capabilities each agent possesses and how they coordinate to deliver HSE director executive oversight.

## Agent-to-Skill Matrix

| Agent Code | Agent Name | Primary Skills | Supporting Skills |
|-----------|------------|---------------|------------------|
| HSE-SAF-001 | Safety Performance Agent | hse-safety-performance-monitoring | pre-task-assessment-readiness |
| HSE-ENV-001 | Environmental Compliance Agent | hse-environmental-compliance | pre-task-assessment-readiness, hse-regulatory-reporting |
| HSE-AUD-001 | HSE Audit Agent | hse-audit-management | pre-task-assessment-readiness |
| HSE-INC-001 | Incident Investigation Agent | hse-incident-investigation | pre-task-assessment-readiness, hse-safety-performance-monitoring |
| HSE-TRN-001 | HSE Training Compliance Agent | hse-training-compliance | pre-task-assessment-readiness |
| HSE-REG-001 | Regulatory Reporting Agent | hse-regulatory-reporting | pre-task-assessment-readiness, hse-environmental-compliance |
| HSE-RPT-001 | HSE Executive Reporting Agent | hse-executive-reporting | pre-task-assessment-readiness, hse-safety-performance-monitoring, hse-environmental-compliance, hse-audit-management |

## Skill Definitions

### Domain-Specific Skills

#### hse-safety-performance-monitoring
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-safety-performance-monitoring/SKILL.md`

**Purpose:** Monitor and analyze safety performance metrics including TRIFR, LTIFR, near-miss rates, incident trends, leading indicators, and safety culture assessment

**Capabilities:**
- TRIFR/LTIFR calculation and trending
- Near-miss rate monitoring
- Incident pattern detection (location, activity, time, personnel)
- Leading indicator monitoring (observations, audits, training)
- Safety culture assessment
- Contractor safety performance scoring

**Agents Using This Skill:**
- HSE-SAF-001: Safety Performance Agent (primary)
- HSE-RPT-001: HSE Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### hse-environmental-compliance
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-environmental-compliance/SKILL.md`

**Purpose:** Monitor environmental permit compliance, validate monitoring data, detect exceedances, track regulatory reporting, manage environmental incidents

**Capabilities:**
- Permit compliance monitoring
- Environmental monitoring data validation
- Exceedance detection and alerting
- Environmental incident management
- Regulatory reporting calendar tracking

**Agents Using This Skill:**
- HSE-ENV-001: Environmental Compliance Agent (primary)
- HSE-REG-001: Regulatory Reporting Agent (consumer)
- HSE-RPT-001: HSE Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### hse-audit-management
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-audit-management/SKILL.md`

**Purpose:** Schedule HSE audits, track findings, manage corrective actions, calculate compliance rates, monitor audit effectiveness

**Capabilities:**
- HSE audit programme scheduling
- Audit finding recording with severity classification
- Corrective action lifecycle management
- Compliance rate calculation
- Repeat finding detection

**Agents Using This Skill:**
- HSE-AUD-001: HSE Audit Agent (primary)
- HSE-RPT-001: HSE Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### hse-incident-investigation
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-incident-investigation/SKILL.md`

**Purpose:** Conduct structured incident investigations, perform root cause analysis, identify contributing factors, recommend corrective/preventive actions

**Capabilities:**
- Evidence collection and preservation
- Root cause analysis (5 Whys, Fishbone, ICAM)
- Contributing factor identification
- Corrective/preventive action recommendations
- Similar incident pattern detection
- Lessons learned documentation

**Agents Using This Skill:**
- HSE-INC-001: Incident Investigation Agent (primary)
- HSE-SAF-001: Safety Performance Agent (consumer)

**Automation Level:** Augment AI+Human

#### hse-training-compliance
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-training-compliance/SKILL.md`

**Purpose:** Track HSE training matrix, monitor certification expiry, verify competency, schedule refresher training, maintain training records

**Capabilities:**
- Training matrix management
- Certification expiry monitoring with automated alerts
- Pre-work competency verification
- Training needs analysis
- Training effectiveness assessment
- Contractor training verification

**Agents Using This Skill:**
- HSE-TRN-001: HSE Training Compliance Agent (primary)
- HSE-RPT-001: HSE Executive Reporting Agent (consumer)

**Automation Level:** Augment AI+Human

#### hse-regulatory-reporting
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-regulatory-reporting/SKILL.md`

**Purpose:** Prepare and submit regulatory HSE reports, track reporting obligations, ensure notification compliance, maintain submission records

**Capabilities:**
- Regulatory reporting calendar management
- Incident notification requirements determination
- Report compilation and data validation
- HSE Director review and approval workflow
- Regulatory correspondence management
- Voluntary disclosure management

**Agents Using This Skill:**
- HSE-REG-001: Regulatory Reporting Agent (primary)
- HSE-ENV-001: Environmental Compliance Agent (contributor)

**Automation Level:** Augment AI+Human

**Non-Delegable Human Decisions:**
- HSE Director approval for all regulatory submissions
- Incident notification authorization
- Voluntary disclosure decisions

#### hse-executive-reporting
**Location:** `docs-construct-ai/skills/domainforge_ai/00885_hse-director/hse-executive-reporting/SKILL.md`

**Purpose:** Compile executive HSE briefings, prepare board reports, generate KPI dashboards, create management summaries, deliver strategic communications

**Capabilities:**
- HSE data aggregation from all agents
- Real-time HSE dashboard generation
- Weekly executive briefing compilation
- Monthly board report preparation
- Trend analysis and strategic insights
- HSE performance rating
- Executive decision support

**Agents Using This Skill:**
- HSE-RPT-001: HSE Executive Reporting Agent (primary)

**Automation Level:** Augment AI+Human

### Shared Skills

#### pre-task-assessment-readiness
**Location:** `docs-construct-ai/skills/shared/pre-task-assessment-readiness/SKILL.md`

**Purpose:** Pre-task assessment and readiness verification before HSE operations

**Capabilities:**
- Task risk assessment
- Resource availability verification
- Prerequisites validation
- Authority and competency confirmation

**Agents Using This Skill:** All HSE Director agents

## Skill Coordination Patterns

### HSE Performance Monitoring Workflow
```
Safety Performance Agent (HSE-SAF-001)
    → Uses: hse-director-oversight
    → Analyzes incident data, calculates TRIFR/LTIFR, detects trends
    → Outputs: Safety performance metrics, incident patterns
    ↓
Environmental Compliance Agent (HSE-ENV-001)
    → Uses: hse-director-oversight
    → Analyzes environmental monitoring data, checks permit compliance
    → Outputs: Environmental compliance status, exceedances
    ↓
HSE Audit Agent (HSE-AUD-001)
    → Uses: hse-director-oversight
    → Analyzes audit findings, tracks corrective actions
    → Outputs: Audit compliance rate, overdue actions
    ↓
Training Compliance Agent (HSE-TRN-001)
    → Uses: hse-director-oversight
    → Analyzes training matrix, checks certification status
    → Outputs: Training compliance rate, expiring certifications
    ↓
Incident Investigation Agent (HSE-INC-001)
    → Uses: hse-director-oversight
    → Analyzes incident patterns, identifies root causes
    → Outputs: Root cause analysis, corrective action recommendations
    ↓
HSE Executive Reporting Agent (HSE-RPT-001)
    → Uses: hse-director-oversight
    → Compiles all HSE performance data into executive briefing
    → Outputs: Executive HSE dashboard, board briefing
    ↓
Director Review and Approval
    ↓
Regulatory Reporting Agent (HSE-REG-001) [if required]
    → Uses: hse-director-oversight
    → Compiles regulatory submissions
    → Outputs: Regulatory notifications and reports
```

### Incident Management Workflow
```
Incident Investigation Agent (HSE-INC-001)
    → Uses: hse-director-oversight, pre-task-assessment-readiness
    → Analyzes incident details, identifies similar incidents
    → Recommends root cause analysis approach
    → Outputs: Investigation plan, root cause hypotheses
    ↓
Safety Performance Agent (HSE-SAF-001)
    → Uses: hse-director-oversight
    → Updates TRIFR/LTIFR calculations
    → Analyzes incident trends
    → Outputs: Updated safety metrics, trend analysis
    ↓
HSE Audit Agent (HSE-AUD-001)
    → Uses: hse-director-oversight
    → Tracks corrective actions from incident
    → Monitors closure and verification
    → Outputs: Corrective action status, overdue alerts
    ↓
HSE Executive Reporting Agent (HSE-RPT-001)
    → Uses: hse-director-oversight
    → Includes incident in executive reporting
    → Highlights significant incidents for board attention
    → Outputs: Incident summary for executive review
```

### Environmental Compliance Workflow
```
Environmental Compliance Agent (HSE-ENV-001)
    → Uses: hse-director-oversight, pre-task-assessment-readiness
    → Analyzes environmental monitoring data
    → Checks against permit limits
    → Detects exceedances
    → Outputs: Compliance status, exceedance alerts
    ↓
HSE Audit Agent (HSE-AUD-001)
    → Uses: hse-director-oversight
    → Tracks corrective actions for exceedances
    → Monitors environmental audit findings
    → Outputs: Environmental audit compliance rate
    ↓
Regulatory Reporting Agent (HSE-REG-001)
    → Uses: hse-director-oversight
    → Compiles environmental monitoring data
    → Prepares regulatory reports
    → Outputs: Environmental compliance reports
    ↓
Director Review and Authorization
```

## Skill Development Roadmap

### Phase 1: Core HSE Monitoring (Current)
- [x] hse-director-oversight skill defined
- [x] Safety performance monitoring implemented
- [x] Environmental compliance monitoring implemented
- [x] HSE audit management implemented
- [x] Incident investigation support implemented

### Phase 2: Advanced HSE Analytics
- [ ] Predictive incident modelling
- [ ] HSE culture assessment and trending
- [ ] Contractor HSE performance benchmarking
- [ ] HSE resource optimization

### Phase 3: Proactive HSE Intelligence
- [ ] Leading indicator forecasting
- [ ] Risk exposure quantification
- [ ] HSE improvement recommendation engine
- [ ] Lessons learned integration

## Cross-Discipline Integration

### Integration with Related Disciplines

| Related Discipline | Integration Point | Shared Data/Skills |
|-------------------|------------------|-------------------|
| 02400 Safety | Site-level safety operations | Incident data, RAMS, safety inspections |
| 01000 Environmental | Environmental management | Environmental monitoring, impact assessments |
| 00882 Construction Director | Construction oversight | Schedule pressure, resource allocation, construction incidents |
| 00884 Engineering Director | Technical direction | Design safety, engineering standards |
| 00300 Construction | Site operations | Site incident logs, safety observations |

## Version History

- **v1.0** (2026-04-01): Initial HSE Director Agent Skill Mapping
- Defined 7 HSE director agents with skill assignments
- Mapped hse-director-oversight skill to all HSE agents
- Documented HSE performance monitoring, incident management, and environmental compliance workflows

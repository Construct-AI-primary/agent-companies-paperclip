---
title: "Health Agent-Skill Mapping"
description: "Agent and skill mapping for the Health discipline, covering risk assessment, medical surveillance, exposure monitoring, and incident management"
version: "1.0"
memory_layer: durable_knowledge
para_section: Health-Operations
gigabrain_tags:
  - health
  - agent-mapping
  - risk-assessment
  - medical-surveillance
  - exposure-monitoring
  - incident-management
openstinger_context: health-ops-v1
last_updated: 2026-03-31
related_docs:
  - "01400_HEALTH-DISCIPLINE-OVERVIEW.md"
  - "01400_HEALTH-PROCESS-MAP.md"
  - "01400_HEALTH-SKILL-REGISTRY.md"
---

# Health Agent-Skill Mapping

## Overview

This document defines the agent and skill mappings for the **Health** discipline (01400). It establishes how autonomous agents are assigned to specific health skills across risk assessment, medical surveillance, exposure monitoring, and incident management. The mapping ensures clear ownership, responsibilities, and cross-team interoperability for all health-related operations.

---

## Agent Summary by Skill

### Skill: health-risk-assessment

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Intake Coordinator | Health Intake Agent | Production / Intake Systems | Receive, triage, and categorize health-related reports, inquiries, and submissions from workers, supervisors, and external parties |
| Analyst | Risk Assessment Agent | Production / Risk Systems | Analyze health data, evaluate risk likelihood and severity, and produce risk ratings and recommendations |
| Reporter | Reporting Agent | Production / Analytics Systems | Generate risk assessment summaries, trend reports, and mitigation status dashboards |

### Skill: health-medical-surveillance

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Monitor | Surveillance Agent | Production / Medical Systems | Track medical surveillance programs, health screening schedules, and worker biometric data trends |
| Referral | Medical Referral Agent | Production / Medical Systems | Coordinate medical referrals, specialist appointments, and follow-up care tracking for workers |
| Reporter | Reporting Agent | Production / Analytics Systems | Produce surveillance program metrics, screening compliance reports, and long-term health trend analysis |

### Skill: health-exposure-monitoring

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Monitor | Monitoring Agent | Production / Sensor Systems | Continuously monitor environmental and occupational exposure levels against threshold limit values (TLVs) |
| Alerter | Alert Agent | Production / Alert Systems | Generate real-time alerts when exposure thresholds are exceeded, including escalation notifications |
| Recorder | Audit Log Agent | Production / Logging Systems | Maintain immutable records of exposure events, monitoring data, and alert responses for regulatory compliance |

### Skill: health-incident-management

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Assessor | Risk Assessment Agent | Production / Risk Systems | Evaluate health incidents, determine severity classification, and initiate response protocols |
| Controller | Control Recommendation Agent | Production / Control Systems | Recommend and track implementation of engineering controls, administrative controls, and PPE |
| Responder | Alert Agent | Production / Alert Systems | Trigger emergency notifications, coordinate emergency response, and manage incident communication workflows |
| Reporter | Reporting Agent | Production / Analytics Systems | Generate incident reports, root cause analysis summaries, and corrective action tracking dashboards |
| Recorder | Audit Log Agent | Production / Logging Systems | Maintain comprehensive incident logs, chain of custody records, and regulatory submission documentation |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Capabilities | Trigger Conditions | Output Artifacts |
|-------|-----------------|--------------|-------------------|------------------|
| Health Intake Agent | health-risk-assessment | Multi-channel intake, triage classification, priority routing, data validation | Worker submissions, supervisor reports, system-detected anomalies | Triage tickets, intake records, routing assignments |
| Risk Assessment Agent | health-risk-assessment, health-incident-management | Statistical risk modeling, likelihood/severity scoring, trend identification, recommendation engine | Incoming risk data, incident reports, periodic review cycles | Risk assessments, risk matrices, priority recommendations |
| Surveillance Agent | health-medical-surveillance | Health screening coordination, biometric tracking, surveillance scheduling, compliance monitoring | Periodic health screening cycles, regulatory requirements, worker onboarding | Surveillance schedules, compliance reports, health trend dashboards |
| Monitoring Agent | health-exposure-monitoring | Real-time sensor data ingestion, TLV comparison, exposure trend analysis, threshold monitoring | Continuous sensor feeds, periodic sampling data, worker exposure requests | Exposure reports, monitoring summaries, threshold breach notifications |
| Reporting Agent | health-risk-assessment, health-medical-surveillance, health-incident-management | Multi-report generation, KPI aggregation, trend visualization, regulatory report formatting | Reporting cycles, stakeholder requests, regulatory deadlines | Health dashboards, regulatory reports, trend analyses, summary publications |
| Control Recommendation Agent | health-incident-management | Control hierarchy analysis, engineering control design, administrative procedure generation, PPE selection | Incident identification, risk assessment output, regulatory inspection findings | Control recommendations, implementation plans, effectiveness assessments |
| Medical Referral Agent | health-medical-surveillance | Provider network management, appointment scheduling, referral tracking, follow-up monitoring | Medical surveillance flags, risk assessment recommendations, worker health events | Referral records, appointment confirmations, follow-up tracking logs |
| Alert Agent | health-exposure-monitoring, health-incident-management | Multi-channel alerting, severity-based routing, escalation management, notification tracking | Threshold breaches, incident severity classifications, emergency triggers | Alert notifications, escalation records, response confirmation logs |
| Audit Log Agent | health-exposure-monitoring, health-incident-management | Immutable audit trails, regulatory compliance logging, chain of custody maintenance, data retention enforcement | Any health system event, exposure event, incident recording, monitoring output | Audit log entries, compliance records, data retention certificates |

---

## Cross-Team Agent Assignments

### OpenClaw Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Health Intake Agent | Primary owner | Intake UI/UX, multi-channel integration, triage logic |
| Monitoring Agent | Primary owner | Sensor integration, real-time data ingestion pipelines |
| Alert Agent | Primary owner | Multi-channel alert delivery, escalation logic |

### deep-agents Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Risk Assessment Agent | Primary owner | Risk modeling engine, statistical analysis pipelines |
| Surveillance Agent | Primary owner | Medical surveillance automation, biometric data analysis |
| Control Recommendation Agent | Primary owner | Control hierarchy engine, recommendation algorithms |

### JS Swarm Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Medical Referral Agent | Primary owner | Provider network logic, referral matching swarm |
| Audit Log Agent | Primary owner | Distributed ledger for audit trails, compliance logging |
| Reporting Agent | Shared owner | Report generation swarm, visualization components |

### DevForge Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Reporting Agent | Infrastructure owner | Backend analytics pipelines, data warehouse integration, CI/CD for reporting |
| All Health Agents | Platform support | Shared authentication, RBAC, HIPAA compliance infrastructure, deployment pipelines |

---

## Dependencies and Integrations

| Dependency | Related Agent(s) | Integration Type | Notes |
|------------|-----------------|-----------------|-------|
| Environmental Sensor Network | Monitoring Agent | IoT/IaC Integration | Real-time exposure data from workplace sensors |
| Medical Provider Network | Medical Referral Agent | External API | Healthcare provider scheduling and referral systems |
| EHR/EMR Systems | Surveillance Agent, Medical Referral Agent | External API/HL7 | Electronic health records integration for biometric data |
| Alert Delivery Infrastructure | Alert Agent | Internal/External API | SMS, email, push notification delivery systems |
| Compliance Data Warehouse | Reporting Agent, Audit Log Agent | Internal API | Persistent storage for health compliance and audit data |

---

## Revision History

| Date | Version | Author | Change Description |
|------|---------|--------|-------------------|
| 2026-03-31 | 1.0 | Health Agent Team | Initial creation of agent-skill mapping document |

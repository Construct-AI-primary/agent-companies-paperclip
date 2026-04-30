---
title: "Governance Agent-Skill Mapping"
description: "Agent and skill mapping for the Governance discipline, covering board management, policy lifecycle, compliance monitoring, and authority management"
version: "1.0"
memory_layer: durable_knowledge
para_section: Governance-Operations
gigabrain_tags:
  - governance
  - agent-mapping
  - board-management
  - policy-lifecycle
  - compliance-monitoring
  - authority-management
openstinger_context: governance-ops-v1
last_updated: 2026-03-31
related_docs:
  - "01300_GOVERNANCE-DISCIPLINE-OVERVIEW.md"
  - "01300_GOVERNANCE-PROCESS-MAP.md"
  - "01300_GOVERNANCE-SKILL-REGISTRY.md"
---

# Governance Agent-Skill Mapping

## Overview

This document defines the agent and skill mappings for the **Governance** discipline (01300). It establishes how autonomous agents are assigned to specific governance skills across board management, policy lifecycle, compliance monitoring, and authority management. The mapping ensures clear ownership, responsibilities, and cross-team interoperability for all governance-related operations.

---

## Agent Summary by Skill

### Skill: governance-board-management

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Coordinator | Meeting Scheduler Agent | Production / Meeting Systems | Schedule, coordinate, and manage board and committee meeting logistics including agendas, invites, and room/VC setup |
| Prep Specialist | Paper Prep Agent | Production / Document Systems | Collect, compile, and format board papers, reports, and supporting materials for review cycles |
| Recorder | Minute Agent | Production / Meeting Systems | Record, transcribe, and distribute meeting minutes with action item tracking and follow-up assignments |
| Reporting | Reporting Agent | Production / Analytics Systems | Generate governance dashboards, board performance reports, and compliance summaries |

### Skill: governance-policy-lifecycle

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Policy Owner | Policy Manager Agent | Production / Document Management | Draft, review, approve, version, and retire organizational policies through the full lifecycle |
| Reporting | Reporting Agent | Production / Analytics Systems | Produce policy adoption reports, review cycle alerts, and policy effectiveness metrics |

### Skill: governance-compliance-monitoring

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Monitor | Compliance Monitor Agent | Production / Audit Systems | Continuously monitor organizational compliance against policies, regulatory frameworks, and internal standards |
| Auditor | Audit Prep Agent | Production / Audit Systems | Prepare audit evidence, organize documentation, and coordinate audit readiness activities |
| Recorder | Decision Log Agent | Production / Registry Systems | Log, track, and report governance decisions with rationale, approvers, and implementation status |
| Reporting | Reporting Agent | Production / Analytics Systems | Generate compliance scorecards, exception reports, and regulatory filing summaries |

### Skill: governance-authority-management

| Role | Agent | Environment | Responsibility |
|------|-------|-------------|----------------|
| Manager | Authority Matrix Agent | Production / Governance Systems | Maintain and enforce delegation of authority (DoA) matrices, approval hierarchies, and sign-off rules |
| Recorder | Decision Log Agent | Production / Registry Systems | Log authority-based decisions, deviations, and escalations for governance audit trails |

---

## Agent Capability Summary

| Agent | Primary Skill(s) | Capabilities | Trigger Conditions | Output Artifacts |
|-------|-----------------|--------------|-------------------|------------------|
| Meeting Scheduler Agent | governance-board-management | Calendar integration, agenda sequencing, invite management, conflict resolution | Board meeting cycle triggers, ad-hoc requests | Meeting invites, agendas, schedules |
| Paper Prep Agent | governance-board-management | Document collection, formatting, version control, submission workflow | Scheduled board cycle, policy review deadline | Board paper packages, supporting documents |
| Minute Agent | governance-board-management | Transcription, action item extraction, minute formatting, distribution | During/after meetings, recording availability | Approved meeting minutes, action logs |
| Policy Manager Agent | governance-policy-lifecycle | Draft creation, review routing, approval tracking, version management, retirement workflow | Policy review cycle, regulatory change trigger | Published policies, revision history |
| Compliance Monitor Agent | governance-compliance-monitoring | Continuous monitoring, gap analysis, exception flagging, alert generation | Scheduled scans, real-time event triggers | Compliance reports, exception notices |
| Decision Log Agent | governance-compliance-monitoring, governance-authority-management | Decision capture, rationale documentation, status tracking, audit trail maintenance | Board decisions, policy approvals, authority events | Decision register, audit trail entries |
| Reporting Agent | governance-board-management, governance-policy-lifecycle, governance-compliance-monitoring | Dashboard generation, metrics aggregation, trend analysis, report distribution | Reporting cycle, on-demand request | Governance dashboards, PDF reports, trend charts |
| Authority Matrix Agent | governance-authority-management | DoA matrix maintenance, approval routing validation, escalation management, role mapping | Authority change request, escalation trigger | Updated authority matrices, escalation logs |
| Audit Prep Agent | governance-compliance-monitoring | Evidence collection, documentation organization, audit readiness assessment, gap remediation tracking | Audit announcement, scheduled preparatory cycle | Audit packages, readiness reports |

---

## Cross-Team Agent Assignments

### OpenClaw Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Meeting Scheduler Agent | Primary owner | Core coordination logic, UI/UX for scheduling |
| Minute Agent | Primary owner | Transcription pipelines, action item extraction |
| Reporting Agent | Shared owner | Dashboard infrastructure and visualization |

### deep-agents Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Policy Manager Agent | Primary owner | Policy lifecycle automation engine |
| Compliance Monitor Agent | Primary owner | Continuous monitoring and anomaly detection |
| Decision Log Agent | Primary owner | Decision registry and audit trail infrastructure |

### JS Swarm Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Paper Prep Agent | Primary owner | Document collation and formatting swarm logic |
| Authority Matrix Agent | Primary owner | DoA matrix computation and validation |
| Audit Prep Agent | Primary owner | Evidence aggregation and readiness workflows |

### DevForge Team

| Agent | Assignment | Notes |
|-------|-----------|-------|
| Reporting Agent | Infrastructure owner | Backend pipelines, data warehouse integration, CI/CD for reporting services |
| All Governance Agents | Platform support | Shared authentication, RBAC, audit logging infrastructure, deployment pipelines |

---

## Dependencies and Integrations

| Dependency | Related Agent(s) | Integration Type | Notes |
|------------|-----------------|-----------------|-------|
| Calendar APIs (Google/Outlook) | Meeting Scheduler Agent | External API | OAuth2 integration for scheduling |
| Document Management System | Paper Prep Agent, Policy Manager Agent | Internal API | Version control and document storage |
| Audit Management Platform | Compliance Monitor Agent, Audit Prep Agent | External API | Compliance evidence and audit tracking |
| Decision Registry Database | Decision Log Agent, Authority Matrix Agent | Internal Database | Persistent storage for decisions and authority data |
| Analytics Warehouse | Reporting Agent | Internal API | Data source for dashboards and reports |

---

## Revision History

| Date | Version | Author | Change Description |
|------|---------|--------|-------------------|
| 2026-03-31 | 1.0 | Governance Agent Team | Initial creation of agent-skill mapping document |

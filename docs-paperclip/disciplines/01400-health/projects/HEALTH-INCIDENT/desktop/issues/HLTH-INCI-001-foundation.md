---
id: HLTH-INCI-001
title: "Health Incident Foundation — Incident Management Framework, Classification & Data Model"
labels: ["health", "incident", "1 — Foundation"]
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 8
due_date: "2026-06-30"
assignee: domainforge-ai
company: domainforge-ai
created_date: 2026-05-04
estimated_weeks: 4
blocks: ["HLTH-INCI-002", "HLTH-INCI-003", "HLTH-INCI-004", "HLTH-INCI-005"]
---

# HLTH-INCI-001: Health Incident Foundation — Incident Management Framework, Classification & Data Model

## Description

Establish the foundational architecture for the health incident management system. This issue covers the design and implementation of the incident management framework, incident classification taxonomy, health incident data model, and reporting schema. All subsequent incident management capabilities depend on this foundation.

**Phase:** 1 — Foundation
**Priority:** Critical
**Story Points:** 8
**Estimated Duration:** 4 weeks
**Assignee:** domainforge-ai
**Company:** domainforge-ai
**Due Date:** 2026-06-30

**Blocks:** HLTH-INCI-002, HLTH-INCI-003, HLTH-INCI-004, HLTH-INCI-005

## Delegation

This issue is delegated to **domainforge-ai** for domain architecture design and data modeling. DomainForge AI will define the health incident domain model, incident classification framework, investigation workflow, and regulatory reporting schema.

## Goals

1. Design comprehensive health incident management system architecture
2. Define incident classification taxonomy (occupational illness, exposure, biological, heat illness, MSD)
3. Establish incident investigation framework with root cause analysis
4. Design regulatory reporting schema (RIDDOR, OSHA 300, local regulations)
5. Define data models and database schema for all incident entities

## Required Actions

| # | Action | Owner | Estimated Hours |
|---|--------|-------|-----------------|
| 1 | Design incident management system architecture | domainforge-ai | 16 |
| 2 | Define incident classification taxonomy | domainforge-ai | 12 |
| 3 | Design incident investigation framework | domainforge-ai | 16 |
| 4 | Implement incident data models and database schema | domainforge-ai | 20 |
| 5 | Design regulatory reporting schema | domainforge-ai | 12 |
| 6 | Define API contracts for incident services | domainforge-ai | 8 |
| 7 | Create foundation testing suite | domainforge-ai | 16 |

## Acceptance Criteria

### System Architecture
- [ ] Incident management system architecture documented
- [ ] Service boundaries and API contracts defined
- [ ] Incident data flow diagrams
- [ ] Integration points with Safety and HR systems

### Incident Classification
- [ ] Incident types defined: occupational illness, exposure, biological, heat illness, MSD, other
- [ ] Severity levels defined with escalation rules
- [ ] Incident status workflow: reported → investigating → managed → closed
- [ ] Reportable vs non-reportable classification

### Investigation Framework
- [ ] Root cause analysis methodology defined
- [ ] Investigation timeline and milestone tracking
- [ ] Evidence collection and management
- [ ] Corrective action tracking

### Data Model
- [ ] health_incidents table structure defined
- [ ] incident_investigations table structure defined
- [ ] incident_evidence table structure defined
- [ ] corrective_actions table structure defined
- [ ] RLS policies implemented

## Dependencies

- **None** — This is the foundation issue

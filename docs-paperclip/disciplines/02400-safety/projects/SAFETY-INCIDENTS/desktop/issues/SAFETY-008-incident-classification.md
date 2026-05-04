---
id: SAFETY-008
title: "02400 Incident Classification — Severity & Reportability Determination"
phase: "Phase 3 — Integration"
status: open
priority: high
platform: desktop
blocked_by: []
depends_on: [SAFETY-004, SAFETY-005, SAFETY-006]
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-008: 02400 Incident Classification — Severity & Reportability Determination

## Executive Summary

Implement the incident classification engine that automatically determines severity level (High/Medium/Low) and regulatory reportability (OSHA-recordable, statutory notification required) based on incident attributes and AI analysis.

## Problem Statement / Scope

Incidents must be consistently classified for proper handling, regulatory reporting, and resource allocation. Manual classification leads to inconsistencies and missed reportable events. Scope includes:

- Severity classification algorithm: based on injury type, medical treatment, property damage, environmental impact
- Reportability determination: OSHA recordability criteria, statutory notification requirements (fatality, hospitalization, amputation)
- AI-assisted classification using guardian-qualityforge agent
- Classification override by safety manager with audit trail
- Classification history tracking for trend analysis
- Integration with incident creation flow for auto-classification

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Design severity classification matrix | Injury type × treatment level × property damage × environmental impact → severity score |
| 2 | Implement reportability rules engine | OSHA 1904 criteria, statutory notification triggers, jurisdiction-specific rules |
| 3 | Integrate AI classification | guardian-qualityforge agent classifies incident on creation |
| 4 | Build classification override UI | Safety manager can override with reason required, logged to audit trail |
| 5 | Add classification history | Track all classification changes with timestamps and user |
| 6 | Wire to incident creation flow | Auto-classify on incident report submission |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** guardian-qualityforge, devforge-ai-workflow-developer

## Required Skills

- Rules engine design and implementation
- OSHA/regulatory compliance knowledge
- AI model integration for classification
- Audit trail implementation
- Override workflow with reason capture

## Acceptance Criteria

- [ ] Severity classification algorithm correctly scores incidents based on input attributes
- [ ] Reportability determination correctly identifies OSHA-recordable and statutory-notifiable incidents
- [ ] AI-assisted classification runs on incident creation
- [ ] Safety manager can override classification with required reason
- [ ] Classification history shows all changes with timestamps and user IDs
- [ ] Classification is visible on incident list and detail views
- [ ] Classification rules are configurable without code changes

## Dependencies

- BLOCKED BY: SAFETY-004, SAFETY-005, SAFETY-006
- BLOCKS: SAFETY-010, SAFETY-011, SAFETY-012

## Estimated Duration

- **Estimated Hours:** 26 hours
- **Complexity:** High
- **Timeline:** 3.5 business days

## Risk Level

**High** — Incorrect classification could lead to missed regulatory reporting obligations and legal penalties.

## QC Team Checks

- [ ] Classification accuracy verified against 50 test scenarios
- [ ] OSHA recordability rules match current regulatory requirements
- [ ] Override reason is mandatory and logged
- [ ] Classification history is immutable (append-only)
- [ ] Rules engine can be updated with new regulations
- [ ] AI classification confidence score displayed to user

# SEC-INCI-001 — Incident Management Foundation — Incident Classification, Data Model & Workflow Design

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-001 |
| **Title** | Incident Management Foundation — Incident Classification, Data Model & Workflow Design |
| **Labels** | `security`, `incident`, `1 — Foundation` |
| **Phase** | 1 — Foundation |
| **Status** | todo |
| **Priority** | Critical |
| **Story Points** | 8 |
| **Due Date** | 2026-06-15 |
| **Assignee** | domainforge-ai |
| **Company** | domainforge-ai |
| **Estimated** | 4 weeks |

---

## Dependencies

- **Blocks:** SEC-INCI-002, SEC-INCI-003, SEC-INCI-004, SEC-INCI-005
- **Blocked By:** None

---

## Description

Establish the foundational data models, classification taxonomy, and workflow state machine that underpin the entire Incident Management system. This issue defines the core vocabulary, structure, and rules that all subsequent phases will build upon.

---

## Objectives

1. Define incident classification taxonomy (type, severity, impact, urgency)
2. Design incident data model and schema
3. Design incident lifecycle state machine
4. Define SLA tiers and escalation rules
5. Establish evidence classification framework

---

## Technical Specifications

### 1. Incident Classification Taxonomy

**Incident Types:**
- Physical Security Breach
- Cyber Incident
- Data Breach
- Unauthorized Access
- Theft/Loss
- Workplace Violence
- Natural Disaster
- System Failure
- Policy Violation
- Suspicious Activity

**Severity Levels:**
| Level | Code | Description | Response Time |
|-------|------|-------------|---------------|
| Critical | P1 | Active threat to life/safety or major breach in progress | ≤ 15 min |
| High | P2 | Significant security incident requiring immediate attention | ≤ 1 hour |
| Medium | P3 | Contained incident with moderate impact | ≤ 4 hours |
| Low | P4 | Minor incident or policy violation | ≤ 24 hours |

**Impact Dimensions:**
- Operational
- Financial
- Reputational
- Regulatory
- Safety

### 2. Incident Data Model

**Core Entities:**
- `Incident` — Primary entity with attributes: id, type, severity, status, title, description, location, timestamp, reporter, assignee, SLA tier
- `Evidence` — Linked to Incident with chain-of-custody tracking: id, type, file reference, capturedBy, capturedAt, hash, chainOfCustody[]
- `Investigator` — Person assigned to investigate: id, name, team, role, certifications
- `EscalationRule` — Rule definition: id, trigger, target, action, timeout
- `SLAConfiguration` — SLA definition: id, severity, responseTime, resolutionTime, escalationPath
- `AuditLog` — Immutable log entry: id, incidentId, action, actor, timestamp, details, previousState, newState

### 3. Incident Lifecycle State Machine

**States:**
```
Reported → Triaged → Investigating → Contained → Resolved → Closed
                                                              ↓
                                                         Reopened
```

**Transitions:**
| From | To | Guard Condition | Actions |
|------|----|-----------------|---------|
| Reported | Triaged | Severity assigned, initial assessment complete | Notify assigned investigator, start SLA timer |
| Triaged | Investigating | Investigator confirmed, investigation plan created | Log assignment, notify stakeholders |
| Investigating | Contained | Containment measures implemented | Log containment actions, notify escalation contacts |
| Contained | Resolved | Root cause identified, corrective actions applied | Generate resolution report, update SLA timer |
| Resolved | Closed | Closure checklist complete, approval received | Generate closure report, archive evidence |
| Closed | Reopened | New evidence discovered or recurrence detected | Reactivate incident, notify original investigator |

### 4. SLA Framework

| Severity | Response Time | Resolution Time | Escalation Trigger |
|----------|--------------|-----------------|-------------------|
| P1 | 15 min | 4 hours | Missed response: escalate to Security Lead at 20 min |
| P2 | 1 hour | 24 hours | Missed response: escalate to Security Lead at 1.5 hours |
| P3 | 4 hours | 72 hours | Missed response: escalate to Team Lead at 5 hours |
| P4 | 24 hours | 7 days | Missed response: escalate to Team Lead at 30 hours |

### 5. Evidence Classification

**Evidence Types:**
- Photo, Video, Audio, Document, Physical, Witness Statement, Log File, Network Capture

**Chain-of-Custody Schema:**
```json
{
  "evidenceId": "uuid",
  "transfers": [
    {
      "from": "collector",
      "to": "custodian",
      "timestamp": "ISO8601",
      "reason": "transfer reason",
      "signature": "digital signature"
    }
  ]
}
```

---

## Acceptance Criteria

- [ ] Incident classification taxonomy documented and approved
- [ ] Data model specification with ERD completed
- [ ] State machine specification with state transition diagram completed
- [ ] SLA framework document with all tiers defined
- [ ] Evidence classification framework with chain-of-custody schema
- [ ] All specifications reviewed by security discipline lead
- [ ] Specifications published to shared project documentation

---

## Implementation Notes

- Use UML for data model and state machine specifications
- Store specifications in the shared project documentation directory
- Ensure alignment with existing Security discipline standards
- Consider integration points with SEC-WORKFLOW and SECURITY-ACCESS projects
- Document all assumptions and design decisions

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Taxonomy incomplete for edge cases | High | Design extensible taxonomy with custom type support |
| State machine too rigid for real-world workflows | Medium | Include configurable transition rules |
| SLA targets unrealistic for certain scenarios | Medium | Define SLA override process for exceptions |

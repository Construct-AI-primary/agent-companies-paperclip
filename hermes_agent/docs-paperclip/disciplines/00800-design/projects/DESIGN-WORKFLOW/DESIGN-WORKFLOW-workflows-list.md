---
title: DESIGN-WORKFLOW Workflows List
discipline: 00800
project: DESIGN-WORKFLOW
version: 1.0
date: 2026-04-17
---

# DESIGN-WORKFLOW — Workflows Catalog

## Overview

This document catalogs all workflows for the Design Management discipline (00800), derived from domain knowledge analysis.

## Workflows Summary

| ID | Workflow Name | Phase | Priority | Status | Complexity |
|----|---------------|-------|----------|--------|------------|
| DESIGN-001 | Design Coordination & Interface Management | Phase 1 | Critical | Partial | High |
| DESIGN-002 | Interdisciplinary Design Review (IDR) | Phase 1 | High | Partial | Medium |
| DESIGN-003 | Design Programme & Deliverables | Phase 1 | High | Partial | Medium |
| DESIGN-004 | Design Change Control | Phase 2 | High | Pending | Medium |
| DESIGN-005 | Engineering Discipline Integration Matrix | Phase 2 | High | Partial | Medium |
| DESIGN-006 | Multi-Discipline Clash Detection & Resolution | Phase 2 | Critical | Partial | High |
| DESIGN-007 | Design Team Communication & Collaboration | Phase 1 | Medium | Partial | Low |
| DESIGN-008 | RFI Response Management | Phase 3 | Medium | Pending | Medium |

---

## Workflow Dependencies

```
DESIGN-001 (Interface Management)
    ├── DESIGN-002 (IDR)
    ├── DESIGN-005 (Integration Matrix)
    └── DESIGN-006 (Clash Detection)
         │
         ├── DESIGN-003 (Programme)
         └── DESIGN-004 (Change Control)

DESIGN-007 (Communication) ← All phases

DESIGN-008 (RFI Management) ← Phase 3 onwards
```

---

## Detailed Workflow Descriptions

### DESIGN-001: Design Coordination & Interface Management

**Description**: Create a universal design coordination workflow template that standardizes the interface management process across all engineering disciplines on large projects.

**Key Activities**:
- Develop interface register with discipline interface points
- Create coordination meeting agenda, minutes, and action tracking templates
- Build interface responsibility matrix (RACI)
- Integrate with BIM coordination workflows

**Deliverables**:
- Interface register
- Coordination meeting templates
- RACI matrix
- Design deliverable matrix

**Standards**: ISO 19650, PAS 1192-2, AIA E202

**Estimated Hours**: 16-20 hours

---

### DESIGN-002: Interdisciplinary Design Review (IDR)

**Description**: Structured cross-discipline review process ensuring all designs are coordinated and compliant.

**Key Activities**:
- Schedule IDR sessions for affected disciplines
- Distribute design documents for review
- Collect and consolidate comments
- Track action items to closure

**Deliverables**:
- IDR reports
- Comment registers
- Approval records

**Standards**: Client DEP/BEP, ISO 19650

**Estimated Hours**: 12-16 hours

---

### DESIGN-003: Design Programme & Deliverables

**Description**: Schedule management and deliverable tracking across all design disciplines.

**Key Activities**:
- Develop design execution schedule (P6/MSP)
- Define deliverable register with milestones
- Track progress against schedule
- Report schedule status to stakeholders

**Deliverables**:
- Design schedule
- Deliverable register
- Progress reports

**Standards**: PMBOK, AACE RP

**Estimated Hours**: 10-14 hours

---

### DESIGN-004: Design Change Control

**Description**: Formal change management process for all design modifications.

**Key Activities**:
- Log change requests with description and reason
- Assess technical, cost, schedule impacts
- Obtain approval from appropriate authority
- Update design documents and issue revisions

**Deliverables**:
- Change request register
- Impact assessments
- Revision logs

**Standards**: ISO 19650-2, Contract procedures

**Estimated Hours**: 8-12 hours

---

### DESIGN-005: Engineering Discipline Integration Matrix

**Description**: Cross-discipline dependency mapping and interface coordination.

**Key Activities**:
- Identify all discipline interfaces
- Map information flow between disciplines
- Define responsibility at each interface
- Track interface status through design phases

**Deliverables**:
- Integration matrix
- Interface diagrams
- Status reports

**Standards**: ISO 19650, Client requirements

**Estimated Hours**: 10-14 hours

---

### DESIGN-006: Multi-Discipline Clash Detection & Resolution

**Description**: BIM-based spatial coordination and clash resolution workflow.

**Key Activities**:
- Run clash detection on federated BIM models
- Categorize clashes by severity and discipline
- Assign resolution responsibility
- Track clash resolution to closure

**Deliverables**:
- Clash reports
- Resolution logs
- Coordination drawings

**Standards**: ISO 19650, IFC 4.0

**Estimated Hours**: 14-18 hours

---

### DESIGN-007: Design Team Communication & Collaboration

**Description**: Communication protocol management for multi-discipline teams.

**Key Activities**:
- Establish communication channels and protocols
- Manage distribution lists and access permissions
- Schedule and document coordination meetings
- Archive communication records

**Deliverables**:
- Communication protocol
- Meeting schedules
- Distribution lists
- Collaboration platform configuration

**Standards**: Project communication plan

**Estimated Hours**: 6-10 hours

---

### DESIGN-008: RFI Response Management

**Description**: Technical query handling from construction and procurement teams.

**Key Activities**:
- Log RFIs with question, reference, urgency
- Assign to relevant discipline engineer
- Track response turnaround time
- Issue responses within contract timeframe

**Deliverables**:
- RFI register
- Response templates
- Turnaround tracking reports

**Standards**: Contract RFI procedures, Aconex/Procore

**Estimated Hours**: 8-12 hours

---

## Cross-Discipline Integration

| Discipline | Interface Type | Key Handoff Points |
|------------|----------------|-------------------|
| 00825 (Architectural) | Design inputs, review coordination | Schematic, DD, CD phases |
| 00835 (Chemical) | P&ID review, process interfaces | Process design phases |
| 00850 (Civil) | Site works, foundations | All phases |
| 00855 (Geotechnical) | Foundation design inputs | Early design phases |
| 00860 (Electrical) | Power, lighting, communications | All phases |
| 00870 (Mechanical) | HVAC, plumbing interfaces | DD, CD phases |
| 00871 (Process) | Control philosophy, loops | Process design phases |

---

## Success Criteria

- [ ] 80-95% cross-discipline reusability achieved
- [ ] All workflows documented and templated
- [ ] Integration with BIM 360/Aconex platforms
- [ ] Design coordination schedule aligned with P6/MSP
- [ ] User acceptance testing completed

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-17

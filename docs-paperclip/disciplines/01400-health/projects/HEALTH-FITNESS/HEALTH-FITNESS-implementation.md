# HEALTH-FITNESS Implementation Plan

> Fitness for Work & Health Assessments — 5-Phase Implementation Roadmap

---

## Phase 1 — Foundation (Weeks 1–4)

**Issue:** HLTH-FIT-001 | **Priority:** Critical | **Story Points:** 8

### Objectives
Establish the foundational architecture for the fitness for work and health assessment system.

### Detailed Steps

1. **Design Fitness for Work System Architecture**
   - Define system boundaries and domain context
   - Identify core entities: Worker, Assessment, MedicalRecord, FitnessStatus, Restriction, Clearance
   - Map system interactions with external HR and medical provider systems
   - Document architectural decisions (ADR)

2. **Define Assessment Framework**
   - Categorise assessment types:
     - Pre-employment medicals
     - Periodic health assessments
     - Return-to-work evaluations
     - Functional capacity assessments
     - Drug and alcohol testing
   - Define assessment lifecycle states: Scheduled → In Progress → Completed → Reviewed → Cleared
   - Establish assessment templates and questionnaire schemas

3. **Establish Medical Fitness Standards**
   - Define fitness categorisation:
     - **Fully Fit** — No restrictions
     - **Fit with Adjustments** — Accommodations required
     - **Temporarily Unfit** — Time-limited restriction
     - **Permanently Unfit** — Permanent restriction for specific roles
   - Create role-to-fitness-requirement mapping framework
   - Define medical restriction types with severity levels

4. **Design Worker Fitness Data Model**
   - Longitudinal fitness history tracking
   - Current fitness status with effective dates
   - Medical restriction registry with expiry monitoring
   - Health clearance certification records
   - Consent and data privacy controls

5. **Define Database Schema**
   - Tables: workers, assessments, medical_records, fitness_statuses, restrictions, clearances, assessment_templates
   - Row-Level Security (RLS) policies for data access control
   - Audit columns (created_at, updated_at, created_by, updated_by)
   - Indexing strategy for performance

### Deliverables
- Architecture documentation
- Assessment framework specification
- Medical fitness standards document
- Data model and schema definitions
- RLS policy definitions

---

## Phase 2 — Core Integration (Weeks 5–10)

**Issue:** HLTH-FIT-002 | **Priority:** High | **Story Points:** 13

### Objectives
Build the core fitness for work functionality including assessment management, medical records, and fitness tracking.

### Detailed Steps

1. **Assessment Scheduling & Management**
   - Build assessment scheduling interface (calendar-based)
   - Support for individual and batch assessment creation
   - Assessment workflow engine with state transitions
   - Automated notifications for upcoming/due assessments
   - Assessment result entry and review workflows

2. **Pre-Employment Health Questionnaire**
   - Digital questionnaire administration
   - Configurable question sets per role/assessment type
   - Worker self-service questionnaire portal (web)
   - Auto-scoring and flagging of high-risk responses

3. **Medical Record Maintenance**
   - Longitudinal medical history per worker
   - Document attachment (medical reports, test results)
   - Chronological timeline view of medical events
   - Integration with external medical records (HL7/FHIR where applicable)

4. **Fitness Status Dashboard**
   - Colour-coded fitness categories (Green/Amber/Red/Grey)
   - Worker-level fitness summary view
   - Department/site-level fitness overview
   - Drill-down capability for detailed records
   - Export and reporting capabilities

5. **Medical Restriction Management**
   - Restriction creation with effective and expiry dates
   - Restriction categorisation (physical, environmental, medical)
   - Automated expiry alerts and escalation
   - Restriction-to-role compatibility checking
   - Restriction removal/renewal workflow

6. **Return-to-Work Clearance Workflow**
   - Referral initiation (manager/HR/health professional)
   - Medical assessment scheduling
   - Clearance decision recording with conditions
   - Phased return-to-work plans
   - Final clearance certification

7. **Drug & Alcohol Test Management**
   - Test type configuration (urine, breath, saliva, blood)
   - Chain of custody tracking
   - Result recording with positive/negative/inconclusive
   - Confirmation test workflows
   - Confidential result handling

### Deliverables
- Assessment management module
- Health questionnaire system
- Medical records repository
- Fitness status dashboard
- Restriction management engine
- Return-to-work clearance workflow
- Drug & alcohol test management

---

## Phase 3 — Discipline Integration (Weeks 11–14)

**Issue:** HLTH-FIT-003 | **Priority:** High | **Story Points:** 8

### Objectives
Integrate the fitness for work system with HR systems, external medical providers, and role-based fitness requirement mapping.

### Detailed Steps

1. **HR System Integration**
   - Worker data synchronisation (hire, termination, transfer)
   - Organisational hierarchy mapping
   - Role and position data integration
   - Automated fitness status triggers on HR events
   - Integration audit logging

2. **External Medical Provider Integration**
   - Provider directory and referral management
   - Assessment referral creation and tracking
   - Secure document exchange (referrals, results, reports)
   - Provider portal access for result submission
   - Appointment scheduling integration

3. **Role-Based Fitness Requirement Mapping**
   - Role-to-fitness-standard matrix
   - Physical demand analysis per role
   - Environmental exposure assessment requirements
   - Regulatory fitness mandates per jurisdiction
   - Automated requirement-to-assessment mapping

4. **Integration Audit Logging**
   - Comprehensive audit trail for all integrations
   - Data synchronisation monitoring
   - Error handling and retry mechanisms
   - Integration health dashboard

### Deliverables
- HR system integration adapter
- Medical provider referral management
- Role-fitness requirement matrix
- Integration audit logging system

---

## Phase 4 — Mobile & Offline (Weeks 15–18)

**Issue:** HLTH-FIT-004 | **Priority:** High | **Story Points:** 8

### Objectives
Build mobile fitness assessment capabilities for health officers to conduct assessments in the field with offline support.

### Detailed Steps

1. **Mobile Assessment Interface**
   - Native iOS (Swift) and Android (Kotlin) applications
   - Assessment checklist and form completion
   - Medical test result entry
   - Fitness status determination guidance
   - Digital signature capture for consent and clearance

2. **Health Questionnaire Administration**
   - Offline-capable questionnaire delivery
   - Multi-language questionnaire support
   - Branching logic and conditional questions
   - Auto-calculation of health scores
   - Worker self-completion mode (tablet)

3. **Drug & Alcohol Test Recording**
   - Test kit barcode scanning
   - Result entry with timestamp and tester ID
   - Photo evidence capture
   - Chain of custody documentation
   - Positive result escalation workflow

4. **Offline Operations**
   - Local data storage with SQLite/Realm
   - Offline assessment queue management
   - Automatic synchronisation on connectivity
   - Conflict resolution strategy (last-write-wins with audit)
   - Offline data encryption at rest

5. **Fitness Status Display**
   - Worker fitness summary view
   - Restriction and clearance information
   - Assessment history timeline
   - Quick-reference fitness categorisation guide

### Deliverables
- iOS fitness assessment application
- Android fitness assessment application
- Cross-platform shared components
- Offline synchronisation engine
- Digital signature module

---

## Phase 5 — Compliance & Audit (Weeks 19–21)

**Issue:** HLTH-FIT-005 | **Priority:** Medium | **Story Points:** 5

### Objectives
Implement compliance and audit capabilities including audit trail, compliance reporting, fitness statistics, and regulatory reporting.

### Detailed Steps

1. **Comprehensive Audit Trail**
   - Immutable audit log for all fitness actions
   - Before/after state capture for critical changes
   - User identification and timestamp recording
   - Audit log search and filtering
   - Audit log retention and archiving policy

2. **Compliance Reporting**
   - Regulatory compliance report generation
   - Assessment completion rate reporting
   - Overdue assessment identification and reporting
   - Restriction compliance monitoring
   - Jurisdiction-specific report templates

3. **Fitness Statistics Dashboard**
   - Organisation-wide fitness status distribution
   - Assessment volume trends (monthly/quarterly/annual)
   - Restriction type prevalence analysis
   - Clearance cycle time analytics
   - Demographic health trend analysis

4. **Overdue Assessment Alerts**
   - Automated alert generation for overdue assessments
   - Escalation workflow (health officer → manager → HR)
   - Alert acknowledgement and resolution tracking
   - Configurable alert thresholds and timing

5. **Export Capabilities**
   - CSV export for data analysis
   - PDF report generation with branding
   - Scheduled report distribution
   - API access for external reporting tools

### Deliverables
- Audit trail system
- Compliance reporting module
- Fitness statistics dashboard
- Alert and escalation engine
- Export and reporting utilities

---

## Dependency Map

```
Phase 1: Foundation (HLTH-FIT-001)
    │
    ▼
Phase 2: Core Integration (HLTH-FIT-002)
    │
    ├────────────────────┐
    ▼                    ▼
Phase 3: Integration    Phase 4: Mobile & Offline
(HLTH-FIT-003)          (HLTH-FIT-004)
    │
    ▼
Phase 5: Compliance & Audit (HLTH-FIT-005)
```

## Timeline Summary

| Phase | Duration | Weeks | Target Completion |
|-------|----------|-------|-------------------|
| 1 — Foundation | 4 weeks | 1–4 | 2026-06-30 |
| 2 — Core Integration | 6 weeks | 5–10 | 2026-08-30 |
| 3 — Discipline Integration | 4 weeks | 11–14 | 2026-09-30 |
| 4 — Mobile & Offline | 4 weeks | 15–18 | 2026-10-30 |
| 5 — Compliance & Audit | 3 weeks | 19–21 | 2026-11-30 |
| **Total** | **21 weeks** | **1–21** | **2026-11-30** |

## Risk Register

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| HR system integration complexity | High | Medium | Early API discovery; adapter pattern |
| Medical data privacy regulations | High | Medium | Privacy-by-design; RLS policies; encryption |
| Offline sync data conflicts | Medium | Medium | Conflict resolution strategy; audit trail |
| Mobile platform fragmentation | Medium | Low | Cross-platform shared components; CI testing |
| Regulatory changes mid-implementation | Medium | Low | Modular architecture; configurable rules engine |

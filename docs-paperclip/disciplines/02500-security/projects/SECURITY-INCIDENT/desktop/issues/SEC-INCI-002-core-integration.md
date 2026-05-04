# SEC-INCI-002 — Incident Management Core — Incident Reporting, Investigation Workflow & Evidence Capture

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-002 |
| **Title** | Incident Management Core — Incident Reporting, Investigation Workflow & Evidence Capture |
| **Labels** | `security`, `incident`, `2 — Core Integration` |
| **Phase** | 2 — Core Integration |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 13 |
| **Due Date** | 2026-07-31 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Estimated** | 6 weeks |

---

## Dependencies

- **Blocks:** SEC-INCI-003
- **Blocked By:** SEC-INCI-001

---

## Description

Implement the core incident management system including incident reporting and intake, investigation workflow engine, and evidence capture and management. This phase transforms the foundational designs from SEC-INCI-001 into working software.

---

## Objectives

1. Build incident reporting and intake system with multi-channel support
2. Implement investigation workflow engine with state machine
3. Build evidence capture and management with chain-of-custody
4. Implement incident triage and assignment
5. Build REST API and event bus for integration

---

## Technical Specifications

### 1. Incident Reporting & Intake

**Channels:**
- Manual creation via desktop/web interface
- Email ingestion (parse incoming emails to create incidents)
- API endpoint for automated system integration
- Automated detection from security monitoring tools

**Incident Creation Form Fields:**
- Title, Description, Incident Type, Severity, Location, Timestamp, Reporter Contact
- Affected assets, Witnesses, Initial evidence attachments
- Impact assessment (operational, financial, reputational, regulatory, safety)

**Duplicate Detection:**
- Fuzzy matching on title and description
- Exact match on related asset identifiers
- Time-window based grouping (same type, same location, within 1 hour)

### 2. Investigation Workflow Engine

**State Machine Implementation:**
- Implement state machine as configurable workflow engine
- States: Reported → Triaged → Investigating → Contained → Resolved → Closed → Reopened
- Each transition triggers configurable actions (notifications, escalations, logging)
- State history maintained in immutable audit log

**Investigation Tasks:**
- Task creation with assignee, due date, priority
- Task checklist with completion tracking
- Task dependencies and sequencing
- Investigation timeline with activity feed

**Assignment Logic:**
- Round-robin assignment within teams
- Skill-based matching (incident type → investigator certification)
- Availability-based assignment
- Manual override with justification

### 3. Evidence Capture & Management

**Evidence Upload:**
- File upload with type validation (images, documents, audio, video)
- Metadata extraction (EXIF for photos, duration for audio/video)
- File hash generation (SHA-256) for integrity verification
- Virus scanning before storage

**Chain-of-Custody:**
- Every evidence access logged with timestamp and actor
- Transfer records when evidence changes custodian
- Digital signatures for custody transfers
- Tamper-evident audit trail

**Evidence Viewer:**
- Image viewer with zoom, rotate, annotation
- Document viewer with page navigation
- Audio/video player with playback controls
- Log file viewer with syntax highlighting

### 4. REST API

**Endpoints:**
- `POST /api/incidents` — Create incident
- `GET /api/incidents` — List incidents with filtering
- `GET /api/incidents/{id}` — Get incident detail
- `PUT /api/incidents/{id}` — Update incident
- `POST /api/incidents/{id}/transition` — State transition
- `POST /api/incidents/{id}/evidence` — Add evidence
- `GET /api/incidents/{id}/evidence` — List evidence
- `GET /api/incidents/{id}/audit-log` — Get audit trail

**Event Bus Topics:**
- `incident.created` — New incident reported
- `incident.transitioned` — State change occurred
- `incident.assigned` — Investigator assigned
- `incident.escalated` — Escalation triggered
- `incident.evidence.added` — New evidence uploaded

---

## Acceptance Criteria

- [ ] Incident creation works through all intake channels
- [ ] Duplicate detection correctly identifies potential duplicates
- [ ] State machine enforces valid transitions with guard conditions
- [ ] Investigation tasks can be created, assigned, and tracked
- [ ] Evidence upload with hash verification and virus scanning
- [ ] Chain-of-custody records maintained for all evidence access
- [ ] REST API endpoints functional with authentication
- [ ] Event bus publishes events on all state transitions
- [ ] Audit logging captures all operations
- [ ] Integration tests pass for all core workflows

---

## Implementation Notes

- Use the data model and state machine design from SEC-INCI-001
- Implement API-first to support web and mobile clients
- Use event-driven architecture for loose coupling
- Ensure all evidence operations are logged for compliance
- Consider performance for large evidence files

---

## Risk Assessment

| Risk | Impact | Mitigation |
|------|--------|------------|
| Evidence file size limits | Medium | Implement chunked upload and compression |
| State machine complexity | Medium | Comprehensive unit testing for all transitions |
| API performance under load | High | Implement caching and pagination |

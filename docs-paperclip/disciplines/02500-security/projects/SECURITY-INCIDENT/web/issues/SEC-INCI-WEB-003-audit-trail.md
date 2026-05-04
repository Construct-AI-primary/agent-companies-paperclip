# SEC-INCI-WEB-003 — Incident Management Web — Investigation Audit Trail, Evidence Viewer & Closure Reports

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-WEB-003 |
| **Title** | Incident Management Web — Investigation Audit Trail, Evidence Viewer & Closure Reports |
| **Labels** | `security`, `incident`, `5 — Compliance & Audit` |
| **Phase** | 5 — Compliance & Audit |
| **Status** | todo |
| **Priority** | Medium |
| **Story Points** | 3 |
| **Due Date** | 2026-10-15 |
| **Assignee** | domainforge-ai |
| **Company** | domainforge-ai |
| **Estimated** | — |

---

## Dependencies

- **Blocks:** None
- **Blocked By:** SEC-INCI-005

---

## Description

Build the web-based audit trail viewer, evidence viewer with annotation capabilities, and closure report generator. This provides compliance officers and investigators with the tools to review investigation history, examine evidence, and generate regulatory closure reports.

---

## Objectives

1. Build audit trail viewer with filtering and search
2. Implement evidence viewer with zoom and annotation
3. Build closure report generator
4. Implement compliance dashboard
5. Build report scheduling and distribution

---

## Technical Specifications

### 1. Audit Trail Viewer

**Timeline View:**
- Chronological timeline of all incident events
- Color-coded event types (state changes, evidence, notes, escalations)
- Expandable event entries with full details
- Visual state change indicators with before/after display

**Filtering & Search:**
- Filter by event type (state change, evidence, assignment, escalation, SLA)
- Filter by actor (specific user or role)
- Filter by date range
- Full-text search across event details
- Saved filter presets

**Audit Entry Detail:**
- Timestamp with timezone
- Actor name, role, and IP address
- Action description
- Previous state and new state
- Evidence of action (screenshots, signatures)
- Related event IDs (correlation)

**Export:**
- Export audit trail as PDF (formatted report)
- Export as CSV (for analysis)
- Export as JSON (for system integration)
- Export with digital signature for legal admissibility

### 2. Evidence Viewer

**Image Viewer:**
- High-resolution image display with zoom (up to 800%)
- Pan and rotate controls
- Annotation tools (rectangle, circle, arrow, text, freehand)
- Annotation layers with visibility toggle
- Side-by-side comparison view

**Document Viewer:**
- PDF rendering with page navigation
- Document text search
- Annotation and highlighting
- Document metadata display

**Audio/Video Player:**
- Playback with speed control (0.5x–2x)
- Waveform visualization for audio
- Timestamp bookmarking
- Transcript display (for voice notes)

**Evidence Metadata:**
- File name, type, size, hash (SHA-256)
- Capture timestamp and location (GPS)
- Captured by (user name and role)
- Chain-of-custody history
- Access log

### 3. Closure Report Generator

**Report Builder:**
- Select report template (standard, GDPR, SOX, ISO 27001)
- Auto-populate from incident data
- Manual editing of report fields
- Add attachments and supporting evidence
- Report preview before generation

**Report Templates:**
- Standard Incident Closure Report
- GDPR Breach Notification Report
- SOX Compliance Incident Report
- ISO 27001 Incident Report
- Custom report builder

**Report Output:**
- PDF generation with company branding
- HTML version for web viewing
- Digital signature for authenticity
- Report versioning and history

### 4. Compliance Dashboard

**Compliance Metrics:**
- Incidents requiring regulatory notification (by framework)
- Notification status (pending, sent, acknowledged, overdue)
- Average time to notification
- CAPA completion rate and trend
- Audit trail integrity status

**Compliance Calendar:**
- Regulatory notification deadlines
- CAPA due dates
- Audit schedule
- Compliance review milestones

### 5. Report Scheduling & Distribution

**Scheduling:**
- One-time or recurring report generation
- Schedule by time (daily, weekly, monthly, quarterly)
- Schedule by event (incident closure, SLA breach)
- Schedule by compliance deadline

**Distribution:**
- Email distribution with recipient list
- Secure download link with expiration
- Integration with document management systems
- Distribution audit log

---

## Acceptance Criteria

- [ ] Audit trail viewer displays all events chronologically
- [ ] Evidence viewer supports zoom, annotation, and playback
- [ ] Closure report generator produces formatted PDF reports
- [ ] Compliance dashboard displays accurate metrics
- [ ] Report scheduling generates reports on schedule
- [ ] Report distribution delivers to configured recipients
- [ ] Audit trail export produces valid PDF, CSV, and JSON
- [ ] Integration tests pass for all audit and reporting workflows

---

## Implementation Notes

- Use React with TypeScript for frontend
- Use PDF generation library (jsPDF or react-pdf)
- Implement canvas-based annotation for image viewer
- Ensure audit trail viewer handles large datasets efficiently
- Test report templates with compliance team for accuracy

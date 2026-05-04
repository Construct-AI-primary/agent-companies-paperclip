# SEC-INCI-WEB-001 — Incident Management Web — Incident Dashboard, Kanban Board & Case Management

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-WEB-001 |
| **Title** | Incident Management Web — Incident Dashboard, Kanban Board & Case Management |
| **Labels** | `security`, `incident`, `2 — Core Integration` |
| **Phase** | 2 — Core Integration |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 5 |
| **Due Date** | 2026-07-15 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Estimated** | — |

---

## Dependencies

- **Blocks:** SEC-INCI-WEB-002
- **Blocked By:** SEC-INCI-002

---

## Description

Build the web-based incident dashboard, kanban board for workflow management, and case management interface. This provides security operations center (SOC) personnel with real-time visibility into incident status and the ability to manage incidents through their lifecycle.

---

## Objectives

1. Build incident dashboard with real-time metrics
2. Implement kanban board for incident workflow
3. Build case management views (list, detail, timeline)
4. Implement search and filtering
5. Build incident detail page with all related data

---

## Technical Specifications

### 1. Incident Dashboard

**Dashboard Widgets:**
- Active incidents by severity (bar chart or donut chart)
- Incident trend (line chart — last 7/30 days)
- SLA compliance rate (gauge chart)
- Open incidents by type (pie chart)
- Recent activity feed (real-time updates)
- My assigned incidents (personal queue)

**Real-Time Updates:**
- WebSocket connection for live data
- Auto-refresh configurable interval (15s, 30s, 60s)
- Visual indicators for new/changed incidents
- Sound alert for new P1 incidents (configurable)

**Filters & Date Range:**
- Date range picker for historical data
- Severity filter (P1–P4 multi-select)
- Status filter (all states)
- Incident type filter
- Assigned to filter (me, my team, unassigned, all)

### 2. Kanban Board

**Board Columns:**
- Reported | Triaged | Investigating | Contained | Resolved | Closed

**Card Display:**
- Incident ID and title
- Severity badge (color-coded)
- Time elapsed since creation
- Assignee avatar and name
- SLA status indicator (on-track, warning, breached)
- Evidence count indicator

**Drag & Drop:**
- Drag cards between columns to transition state
- Confirmation dialog for state transitions
- Guard condition validation before transition
- Transition notes/justification required for certain transitions

**Board Configuration:**
- Collapsible columns
- Card density (compact, normal, detailed)
- Auto-refresh toggle
- WIP (work-in-progress) limits per column

### 3. Case Management Views

**List View:**
- Sortable table with columns: ID, Title, Type, Severity, Status, Assignee, Created, SLA
- Inline status change dropdown
- Bulk actions (assign, transition, export)
- Column visibility configuration
- Export to CSV/Excel

**Detail View:**
- Incident information panel
- Activity timeline
- Evidence gallery
- Investigation tasks
- Notes and collaboration
- Audit trail

**Timeline View:**
- Chronological activity feed
- Filter by activity type
- Expandable entries with full details
- Visual state change indicators

### 4. Search & Filtering

**Search:**
- Full-text search across all incident fields
- Advanced search with field-specific queries
- Saved searches for common queries
- Search history

**Filters:**
- Status, Severity, Type, Assignee, Date Range, Location
- SLA status (on-track, warning, breached)
- Evidence presence (has evidence, no evidence)
- Custom filter combinations

### 5. Incident Detail Page

**Sections:**
- Header: ID, Title, Severity badge, Status badge, SLA timer
- Details: Type, Description, Location, Timestamp, Reporter
- Assignment: Current assignee, Assignment history, Reassign button
- Timeline: Chronological activity feed with filters
- Evidence: Gallery view, Upload button, Chain-of-custody
- Tasks: Task list, Create task, Task status
- Notes: Note list, Add note, Edit note
- Audit: Full audit trail with search
- Actions: State transition buttons, Escalate, Export, Close

---

## Acceptance Criteria

- [ ] Dashboard displays accurate real-time metrics
- [ ] Kanban board allows drag-and-drop state transitions
- [ ] State transitions enforce guard conditions
- [ ] List view supports sorting, filtering, and bulk actions
- [ ] Detail view shows all incident information
- [ ] Timeline displays chronological activity
- [ ] Full-text search returns relevant results
- [ ] Incident detail page loads all sections correctly
- [ ] Real-time updates via WebSocket
- [ ] Integration tests pass for all dashboard workflows

---

## Implementation Notes

- Use React with TypeScript for frontend
- Implement WebSocket for real-time updates
- Use a kanban library (react-beautiful-dnd or dnd-kit)
- Ensure responsive design for various screen sizes
- Optimize for performance with large incident lists

# SEC-INCI-WEB-002 — Incident Management Web — Escalation Rules, Assignment Workflows & SLA Configuration

---

**Metadata**

| Field | Value |
|-------|-------|
| **ID** | SEC-INCI-WEB-002 |
| **Title** | Incident Management Web — Escalation Rules, Assignment Workflows & SLA Configuration |
| **Labels** | `security`, `incident`, `3 — Discipline Integration` |
| **Phase** | 3 — Discipline Integration |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 5 |
| **Due Date** | 2026-08-15 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Estimated** | — |

---

## Dependencies

- **Blocks:** None
- **Blocked By:** SEC-INCI-WEB-001

---

## Description

Build the web-based administration interface for configuring escalation rules, assignment workflows, SLA parameters, and user/team management. This provides administrators with the tools to customize incident management behavior without code changes.

---

## Objectives

1. Build escalation rules configuration interface
2. Implement assignment workflow configuration
3. Build SLA configuration interface
4. Implement user and team management
5. Build notification template management

---

## Technical Specifications

### 1. Escalation Rules Configuration

**Rule Builder:**
- Visual rule builder with condition/action blocks
- Rule conditions: incident type, severity, time elapsed, state, location
- Rule actions: notify user/team, change assignee, change severity, trigger webhook
- Rule priority ordering and evaluation
- Rule enable/disable toggle

**Escalation Matrix Editor:**
- Grid editor for escalation matrix (incident type × severity → escalation path)
- Add/remove escalation levels
- Configure escalation timeout per level
- Parallel vs sequential escalation mode

**Rule Testing:**
- Rule simulation with test incident data
- Rule evaluation trace showing which rules matched
- Rule impact analysis before activation

### 2. Assignment Workflow Configuration

**Assignment Rules:**
- Round-robin configuration (team, rotation order)
- Skill-based matching (incident type → certification)
- Availability-based assignment (working hours, capacity)
- Manual assignment with suggested assignees

**Team Configuration:**
- Create and manage teams
- Team member management with roles
- Team working hours and on-call schedules
- Team capacity limits

**Rotation Management:**
- On-call rotation schedules
- Rotation calendar view
- Override and swap management
- Rotation notification preferences

### 3. SLA Configuration

**SLA Templates:**
- Create SLA templates by severity level
- Configure response time targets
- Configure resolution time targets
- Configure escalation triggers at thresholds
- SLA template versioning

**SLA Overrides:**
- Per-incident-type SLA overrides
- Per-location SLA overrides
- Time-of-day and holiday adjustments
- Business hours vs calendar hours configuration

**SLA Monitoring Configuration:**
- Warning threshold percentage (default: 80%)
- Breach notification recipients
- Escalation on breach
- SLA dashboard refresh interval

### 4. User & Team Management

**User Management:**
- User directory with search and filtering
- User profile management (name, email, role, certifications)
- User permissions and access control
- User activity log
- User deactivation/reactivation

**Role Management:**
- Predefined roles: Administrator, Manager, Investigator, Viewer, Field Agent
- Custom role creation with granular permissions
- Permission matrix: incidents, evidence, reports, configuration, users

**Team Management:**
- Team creation and membership
- Team lead assignment
- Team permissions and scope
- Team notification preferences

### 5. Notification Template Management

**Template Editor:**
- Rich text editor for email templates
- Template variables (incident ID, title, severity, URL, etc.)
- Template preview with sample data
- Template version history

**Channel Templates:**
- Email templates (HTML)
- SMS templates (plain text, character limit)
- Push notification templates (title, body, data payload)
- In-app notification templates

**Template Variables:**
- `{{incident.id}}`, `{{incident.title}}`, `{{incident.severity}}`
- `{{incident.type}}`, `{{incident.status}}`, `{{incident.url}}`
- `{{assignee.name}}`, `{{assignee.email}}`
- `{{reporter.name}}`, `{{reporter.email}}`
- `{{sla.responseTime}}`, `{{sla.resolutionTime}}`
- `{{escalation.level}}`, `{{escalation.reason}}`

---

## Acceptance Criteria

- [ ] Escalation rule builder creates and evaluates rules correctly
- [ ] Escalation matrix editor saves and applies matrix
- [ ] Assignment rules assign incidents correctly
- [ ] Team configuration manages members and roles
- [ ] SLA templates configure response and resolution targets
- [ ] SLA overrides apply correctly for exceptions
- [ ] User management supports CRUD operations
- [ ] Role management enforces permissions correctly
- [ ] Notification template editor renders variables correctly
- [ ] Integration tests pass for all admin workflows

---

## Implementation Notes

- Use React with TypeScript for frontend
- Implement form validation for all configuration inputs
- Use a visual rule builder library (react-jsonschema-form or similar)
- Ensure configuration changes are audit-logged
- Test SLA timer accuracy with various configurations

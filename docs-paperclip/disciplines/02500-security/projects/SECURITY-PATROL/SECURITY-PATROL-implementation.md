# SECURITY-PATROL Implementation Plan

> **Discipline:** 02500 — Security  
> **Project:** Patrol & Guard Management  
> **Total Estimated Duration:** 21 weeks  
> **Total Story Points:** 55

---

## Phase 1 — Foundation (Weeks 1–4)

**Estimated:** 4 weeks | **Story Points:** 8 | **Priority:** Critical

### Steps

1. **Define Patrol Data Model**
   - Design database schema for patrol routes, checkpoints, guards, shifts, incidents, and audit logs.
   - Establish entity relationships: Route → Checkpoints (ordered list), Guard → Shift → Route, Incident → Patrol.
   - Define status enums: PatrolStatus (scheduled, in_progress, completed, missed, cancelled), CheckpointStatus (pending, verified, skipped, missed), IncidentSeverity (low, medium, high, critical).

2. **Route Planning Engine — Core**
   - Implement route creation with ordered checkpoint sequences.
   - Support route templates for recurring patrols (daily, nightly, weekend).
   - Build route optimisation logic for minimising travel distance between checkpoints.

3. **Scheduling Foundation**
   - Create shift definition model (start/end time, recurrence pattern, guard assignment).
   - Implement guard availability calendar.
   - Build shift-to-route assignment logic.

4. **API Foundation**
   - Set up FastAPI project structure with OpenAPI documentation.
   - Implement CRUD endpoints for routes, checkpoints, shifts, and guards.
   - Add authentication and authorisation (JWT-based, role-based access).

5. **Database Setup**
   - Configure PostgreSQL with Alembic migrations.
   - Seed initial test data for development and QA.

### Deliverables
- Database schema with migrations
- Route planning API (CRUD)
- Shift scheduling API (CRUD)
- Guard management API (CRUD)
- OpenAPI specification

### Dependencies
- None (foundation phase)

---

## Phase 2 — Core Integration (Weeks 5–10)

**Estimated:** 6 weeks | **Story Points:** 13 | **Priority:** High

### Steps

1. **Route Execution Engine**
   - Implement patrol start/end workflow with guard check-in.
   - Build checkpoint verification flow (sequential progression through route).
   - Handle route deviations: guard goes off-route → trigger alert → dispatch notification.
   - Support manual checkpoint override (supervisor authorisation required).

2. **Guard Tracking — Real-Time**
   - Integrate GPS location tracking for active patrols.
   - Implement geofencing around checkpoint locations.
   - Build guard status board (online, on-patrol, on-break, offline).

3. **Checkpoint Verification — Backend**
   - Generate unique QR codes per checkpoint per patrol instance.
   - Support NFC tag association with checkpoints.
   - Implement verification timestamp and geolocation capture.

4. **Web Dashboard — Patrol View**
   - Build real-time patrol dashboard with map view.
   - Show active patrols, guard locations, checkpoint status.
   - Display route adherence metrics and deviation alerts.

5. **Notification Engine**
   - Implement alert dispatch for route deviations, missed checkpoints, and patrol delays.
   - Support push notifications (mobile) and in-app alerts (web).
   - Build escalation rules for unacknowledged alerts.

### Deliverables
- Route execution API
- Real-time guard tracking service
- Checkpoint verification system
- Patrol web dashboard
- Notification and alert engine

### Dependencies
- Blocked by: SEC-PATROL-001 (Phase 1)

---

## Phase 3 — Discipline Integration (Weeks 11–14)

**Estimated:** 4 weeks | **Story Points:** 8 | **Priority:** High

### Steps

1. **Incident Linking**
   - Allow guards to report incidents during patrol (type, severity, description, media attachments).
   - Link incidents to specific checkpoints or route segments.
   - Auto-escalate high-severity incidents to dispatch.

2. **Alert Dispatch Integration**
   - Integrate with Security discipline alerting system.
   - Dispatch patrol-related alerts to relevant personnel (supervisors, response teams).
   - Support alert acknowledgement and resolution workflow.

3. **Shift Handover**
   - Implement guard shift handover procedure with digital sign-off.
   - Capture patrol status at handover (completed checkpoints, pending items, open incidents).
   - Generate handover report for incoming guard.

4. **Web Admin — Shift Scheduling & Route Configuration**
   - Build shift scheduling interface with drag-and-drop guard assignment.
   - Implement route configuration with visual checkpoint ordering.
   - Add guard availability management and shift swap requests.

5. **Integration with Security Discipline**
   - Connect patrol data with Security incident management system.
   - Share guard status and patrol coverage with Security operations centre.
   - Align patrol schedules with Security event calendar.

### Deliverables
- Incident reporting during patrol
- Alert dispatch integration
- Shift handover workflow
- Web admin scheduling interface
- Security discipline integration layer

### Dependencies
- Blocked by: SEC-PATROL-002 (Phase 2)

---

## Phase 4 — Mobile & Offline (Weeks 15–18)

**Estimated:** 4 weeks | **Story Points:** 8 | **Priority:** High

### Steps

1. **iOS Guard Tour App**
   - Build native iOS app with Swift.
   - Implement NFC checkpoint scanning using Core NFC.
   - Add route navigation with turn-by-turn directions (MapKit).
   - Support offline mode: cache routes and checkpoints, queue verification events.

2. **Android Guard App**
   - Build native Android app with Kotlin.
   - Implement QR checkpoint scanning using CameraX.
   - Add incident reporting with photo/video capture.
   - Implement route deviation alerts with Google Maps integration.

3. **Cross-Platform Guard Dashboard**
   - Build React Native / Flutter app for guard self-service.
   - Display shift schedule, assigned routes, and performance metrics.
   - Allow guard profile management and availability updates.

4. **Offline Sync Engine**
   - Implement local data storage (SQLite / Realm) for offline operation.
   - Build sync queue for checkpoint verifications, incident reports, and location updates.
   - Handle conflict resolution when multiple devices sync simultaneously.

5. **Mobile Push Notifications**
   - Integrate APNs (iOS) and FCM (Android) for real-time alerts.
   - Notify guards of route changes, shift updates, and dispatch alerts.

### Deliverables
- iOS guard tour app (NFC, offline)
- Android guard app (QR, incident reporting)
- Cross-platform guard dashboard
- Offline sync engine
- Mobile push notification integration

### Dependencies
- Blocked by: SEC-PATROL-003 (Phase 3)

---

## Phase 5 — Compliance & Audit (Weeks 19–21)

**Estimated:** 3 weeks | **Story Points:** 5 | **Priority:** Medium

### Steps

1. **Patrol Audit Trail**
   - Record all patrol events: route start/end, checkpoint verifications, deviations, incidents.
   - Immutable audit log with tamper-evident hashing.
   - Support audit export (CSV, PDF) for regulatory compliance.

2. **Performance Analytics**
   - Build analytics engine for patrol performance metrics.
   - Track: route completion rate, on-time start rate, checkpoint adherence, incident response time.
   - Generate guard performance scorecards.

3. **Compliance Reports**
   - Implement configurable report templates for security compliance.
   - Generate patrol coverage reports (checkpoints visited vs. scheduled).
   - Build shift compliance reports (guard attendance, break compliance).

4. **Web Audit Dashboard**
   - Build audit log viewer with search and filter capabilities.
   - Display compliance dashboards with trend charts.
   - Support report scheduling and automated distribution.

5. **Data Retention & Archival**
   - Implement data retention policies for patrol logs and audit records.
   - Build archival workflow for completed patrols beyond retention period.

### Deliverables
- Immutable patrol audit trail
- Performance analytics engine
- Compliance report generation
- Web audit dashboard
- Data retention and archival system

### Dependencies
- Blocked by: SEC-PATROL-004 (Phase 4)

---

## Issue Dependency Graph

```
SEC-PATROL-001 (Foundation)
    ├── SEC-PATROL-002 (Core Integration)
    │   ├── SEC-PATROL-WEB-001 (Web Dashboard)
    │   ├── SEC-PATROL-MOBILE-001 (iOS)
    │   └── SEC-PATROL-MOBILE-002 (Android)
    ├── SEC-PATROL-003 (Discipline Integration)
    │   └── SEC-PATROL-WEB-002 (Web Admin)
    ├── SEC-PATROL-004 (Mobile & Offline)
    │   └── SEC-PATROL-MOBILE-003 (Cross-Platform)
    └── SEC-PATROL-005 (Compliance & Audit)
        └── SEC-PATROL-WEB-003 (Web Audit)
```

---

## Risk Assessment

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| GPS accuracy issues in indoor environments | High | Medium | Supplement with QR/NFC verification; allow manual check-in |
| Offline sync conflicts | Medium | Medium | Implement last-write-wins with supervisor override |
| NFC hardware variability across devices | Medium | Low | Support QR fallback for all checkpoints |
| Integration complexity with existing Security systems | High | Medium | Define clear API contracts early; use adapter pattern |
| Guard adoption resistance | Medium | Low | Involve guards in UAT; provide training and incentives |

---

*End of implementation plan*

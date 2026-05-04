# SEC-EMERG-001 — Emergency Response Foundation — Evacuation Planning, Alert System & Data Model

- **id:** SEC-EMERG-001
- **title:** Emergency Response Foundation — Evacuation Planning, Alert System & Data Model
- **labels:** ["security", "emergency", "1 — Foundation"]
- **phase:** "1 — Foundation"
- **status:** todo
- **priority:** Critical
- **story_points:** 8
- **due_date:** "2026-06-15"
- **assignee:** domainforge-ai
- **company:** domainforge-ai
- **blocks:** [SEC-EMERG-002, SEC-EMERG-003, SEC-EMERG-004, SEC-EMERG-005]
- **estimated:** 4 weeks

## Description

Establish the foundational data model, evacuation planning engine, and alert system for the Emergency Response & Evacuation project. This issue covers all core entities, database schema, route calculation algorithms, alert dispatch infrastructure, and the initial API layer.

## Technical Requirements

### Data Model

Define the following entities with full field specifications, validation rules, and relationships:

1. **EvacuationPlan** — id, name, buildingId, floorId, zones, routes, musterPoints, createdBy, createdAt, updatedAt, version, status (draft, active, archived)
2. **EvacuationRoute** — id, planId, name, waypoints (ordered list of coordinates), exitPoints, capacity, accessibilityFeatures, status
3. **MusterPoint** — id, name, location (lat/lng), capacity, assemblyArea, headCount, status (active, inactive)
4. **EmergencyAlert** — id, type (fire, activeShooter, naturalDisaster, chemical, bombThreat, lockdown), severity (info, warning, critical), message, targetZones, sentAt, deliveredCount, acknowledgedCount, status
5. **RollCallRecord** — id, musterPointId, personId, checkInTime, status (present, absent, unaccounted), notes
6. **EmergencyDrill** — id, planId, scheduledDate, completedDate, scenario, participants, passRate, findings, status
7. **PostIncidentReview** — id, incidentId, reviewDate, findings, actionItems, lessonsLearned, status

### Database Schema

- Create migration files for all entities with proper foreign key relationships
- Indexes on buildingId, floorId, status, sentAt for query performance
- Soft-delete implementation with deletedAt timestamp
- Audit timestamps (createdAt, updatedAt) on all entities

### Evacuation Planning Engine

- Shortest path route calculation algorithm (Dijkstra-based with weighted edges for accessibility)
- Zone-based evacuation logic supporting sequential and simultaneous evacuation modes
- Muster point capacity validation and load balancing
- Plan versioning with draft/active/archived lifecycle
- Approval workflow for plan activation

### Alert System

- Alert creation and dispatch service with multi-channel support
- Alert targeting by zone, building, floor, or organization unit
- Alert acknowledgment tracking with per-person status
- Alert template management with dynamic variable substitution

### API Layer

- RESTful API endpoints for CRUD operations on all entities
- GraphQL schema for complex nested queries (e.g., evacuation plan with routes and muster points)
- WebSocket endpoints for real-time alert delivery and status updates
- API versioning strategy (v1)

## Acceptance Criteria

- [ ] All data model entities are defined with complete field specifications
- [ ] Database migrations run successfully with proper indexes and relationships
- [ ] Evacuation route calculation returns valid paths for given start/end points
- [ ] Zone-based evacuation logic correctly handles sequential and simultaneous modes
- [ ] Alert dispatch service delivers alerts to specified targets
- [ ] Alert acknowledgment tracking records per-person status
- [ ] RESTful API endpoints are implemented and tested for all entities
- [ ] GraphQL schema supports complex queries for evacuation plans
- [ ] WebSocket endpoints deliver real-time alert updates
- [ ] All unit and integration tests pass
- [ ] API contract tests validate request/response formats

## Dependencies

- Security Incident Management data model (for future incident linking)
- Identity & Access Management system (for role-based access)
- Notification infrastructure (for push/SMS/email delivery)

## Notes

This is the foundational issue for the entire SECURITY-EMERGENCY project. All subsequent phases depend on the data model and APIs established here. Ensure thorough testing and documentation before proceeding to Phase 2.

---
id: SEC-PATROL-001
title: "Patrol Management Foundation — Route Planning, Scheduling & Data Model"
labels: ["security", "patrol", "1 — Foundation"]
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 8
due_date: "2026-06-15"
assignee: domainforge-ai
company: domainforge-ai
blocks: [SEC-PATROL-002, SEC-PATROL-003, SEC-PATROL-004, SEC-PATROL-005]
estimated_weeks: 4
---

# SEC-PATROL-001: Patrol Management Foundation — Route Planning, Scheduling & Data Model

## Description

Establish the foundational data model, route planning engine, and scheduling system for the Patrol & Guard Management module. This issue covers the core database schema, API endpoints, and business logic required to define patrol routes, checkpoints, guard shifts, and guard profiles.

## Objectives

- Design and implement the patrol data model (routes, checkpoints, guards, shifts, incidents, audit logs)
- Build the route planning engine with ordered checkpoint sequences and route templates
- Create the shift scheduling system with guard availability and assignment
- Implement CRUD APIs for all foundational entities
- Set up PostgreSQL database with Alembic migrations
- Configure authentication and authorisation (JWT, RBAC)

## Technical Approach

### Data Model

- **Route**: id, name, description, type (daily/nightly/weekend), status, created_at, updated_at
- **Checkpoint**: id, route_id, sequence_number, name, description, latitude, longitude, radius_meters, qr_code, nfc_tag_id
- **Guard**: id, user_id, name, email, phone, status, certifications, availability
- **Shift**: id, guard_id, route_id, start_time, end_time, recurrence_pattern, status
- **Incident**: id, patrol_id, checkpoint_id, type, severity, description, media_urls, reported_at
- **AuditLog**: id, patrol_id, event_type, timestamp, data_hash, guard_id

### API Endpoints

- `GET/POST /api/v1/routes` — List and create routes
- `GET/PUT/DELETE /api/v1/routes/{id}` — Route CRUD
- `POST /api/v1/routes/{id}/checkpoints` — Add checkpoint to route
- `GET/POST /api/v1/shifts` — List and create shifts
- `GET/PUT/DELETE /api/v1/shifts/{id}` — Shift CRUD
- `GET/POST /api/v1/guards` — List and create guards
- `GET/PUT/DELETE /api/v1/guards/{id}` — Guard CRUD

## Acceptance Criteria

- [ ] Database schema is defined and migrations are created
- [ ] Route CRUD API is functional with checkpoint ordering
- [ ] Shift scheduling API supports recurrence and guard assignment
- [ ] Guard management API is functional
- [ ] Authentication and authorisation are configured
- [ ] OpenAPI documentation is generated
- [ ] Seed data is available for development

## Dependencies

None — this is the foundation issue.

## Estimated Effort

4 weeks | 8 story points

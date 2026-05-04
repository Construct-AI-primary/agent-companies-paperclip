# LAND-SITE-002 — Site Preparation Core — Grading Plans, Earthworks Tracking & Soil Management

| Field | Value |
|-------|-------|
| **ID** | LAND-SITE-002 |
| **Title** | Site Preparation Core — Grading Plans, Earthworks Tracking & Soil Management |
| **Labels** | `landscaping`, `site-prep`, `2 — Core Integration` |
| **Phase** | 2 — Core Integration |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 13 |
| **Due Date** | 2026-07-31 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Blocked by** | LAND-SITE-001 |
| **Estimated** | 6 weeks |

---

## Description

Implement the core site preparation engine covering grading plan calculations, earthworks activity tracking, and soil management. This issue builds on the foundation data model to deliver the primary operational capabilities for site preparation.

---

## Objectives

- Build grading plan engine with cut/fill analysis and volume estimation
- Implement earthworks activity tracking with daily logging
- Create soil management module for stockpile tracking and soil balance
- Integrate with foundation data model from LAND-SITE-001

---

## Modules

| Module | Description | Key Components |
|--------|-------------|----------------|
| Grading Plan Engine | Cut/fill analysis, volume estimation, plan versioning | `GradingPlan` entity, calculation engine, approval workflow |
| Earthworks Tracking | Daily activity logging, progress tracking, equipment integration | `EarthworksActivity` entity, dashboard, telemetry API |
| Soil Management | Stockpile tracking, soil balance, quality integration | `SoilStockpile` entity, reconciliation reports |

---

## Technical Requirements

- Grading calculation engine with validated algorithms
- Real-time earthworks progress tracking
- Soil balance reconciliation reporting
- Integration with SiteAssessment and SoilSample from foundation
- RESTful APIs for all new entities
- Unit and integration test coverage > 80%

---

## Acceptance Criteria

- [ ] Grading plan engine performing accurate cut/fill calculations
- [ ] Earthworks activity logging with daily progress tracking
- [ ] Soil stockpile management with volume tracking
- [ ] Soil balance reports reconciling cut/fill quantities
- [ ] All APIs documented and tested
- [ ] Integration with foundation data model verified
- [ ] Test suite passing with > 80% coverage

---

## Dependencies

- **Blocked by:** LAND-SITE-001 (Foundation data model and APIs)

---

## Subtasks

- [ ] Grading plan engine design and implementation
- [ ] Earthworks tracking module
- [ ] Soil management module
- [ ] Integration with foundation APIs
- [ ] Testing and validation

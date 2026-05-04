# LAND-SITE-WEB-003 — Site Preparation Web — Soil Records Audit, Erosion Control Compliance & Closure Reports

| Field | Value |
|-------|-------|
| **ID** | LAND-SITE-WEB-003 |
| **Title** | Site Preparation Web — Soil Records Audit, Erosion Control Compliance & Closure Reports |
| **Labels** | `landscaping`, `site-prep`, `5 — Compliance & Audit` |
| **Phase** | 5 — Compliance & Audit |
| **Status** | todo |
| **Priority** | Medium |
| **Story Points** | 3 |
| **Due Date** | 2026-10-15 |
| **Assignee** | domainforge-ai |
| **Company** | domainforge-ai |
| **Blocked by** | LAND-SITE-005 |
| **Estimated** | 3 weeks |

---

## Description

Build the web audit and compliance interface for site preparation. This interface provides soil records audit views, erosion control compliance dashboards, closure report generation, and regulatory format exports.

---

## Objectives

- Build soil records audit view with search and filter
- Implement erosion control compliance dashboard
- Create closure report generation for completed sites
- Add export to regulatory formats (PDF, XML, JSON)

---

## Features

| Feature | Description |
|---------|-------------|
| Soil Records Audit | Searchable audit view for soil test records with filters |
| Compliance Dashboard | Overview of erosion control compliance status |
| Closure Reports | Automated report generation for completed sites |
| Regulatory Export | Export to PDF, XML, and JSON formats |

---

## Technical Requirements

- React 18+ with TypeScript
- Data grid for audit record display (AG Grid or similar)
- Report generation engine (PDF, XML, JSON)
- REST API integration with desktop backend
- Role-based access control for audit views
- Unit and integration test coverage > 80%

---

## Acceptance Criteria

- [ ] Soil records audit view with search and filter
- [ ] Erosion control compliance dashboard operational
- [ ] Closure report generation for completed sites
- [ ] Export to PDF, XML, and JSON formats working
- [ ] Role-based access control enforced
- [ ] Test suite passing with > 80% coverage

---

## Dependencies

- **Blocked by:** LAND-SITE-005 (Compliance and audit backend)

---

## Subtasks

- [ ] Soil records audit view
- [ ] Compliance dashboard
- [ ] Closure report generation
- [ ] Regulatory format exports
- [ ] Testing and validation

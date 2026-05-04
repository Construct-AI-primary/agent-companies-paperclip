# LAND-SITE-WEB-001 — Site Preparation Web — Site Dashboard, Soil Test Results & Earthworks Progress

| Field | Value |
|-------|-------|
| **ID** | LAND-SITE-WEB-001 |
| **Title** | Site Preparation Web — Site Dashboard, Soil Test Results & Earthworks Progress |
| **Labels** | `landscaping`, `site-prep`, `2 — Core Integration` |
| **Phase** | 2 — Core Integration |
| **Status** | todo |
| **Priority** | High |
| **Story Points** | 5 |
| **Due Date** | 2026-07-15 |
| **Assignee** | devforge-ai |
| **Company** | devforge-ai |
| **Blocked by** | LAND-SITE-002 |
| **Estimated** | 3 weeks |

---

## Description

Build the web dashboard for site preparation, providing real-time visualization of site metrics, soil test results, and earthworks progress. This dashboard serves as the primary operational interface for project managers and site supervisors.

---

## Objectives

- Build site overview dashboard with key metrics
- Implement soil test results visualization (charts, maps)
- Create earthworks progress view with Gantt-style timeline
- Add export functionality (PDF, CSV)

---

## Features

| Feature | Description |
|---------|-------------|
| Site Overview | Key metrics dashboard with site status cards |
| Soil Test Results | Chart and map visualization of soil data |
| Earthworks Progress | Gantt-style timeline with completion tracking |
| Data Export | PDF and CSV export for reports |

---

## Technical Requirements

- React 18+ with TypeScript
- Chart.js or D3.js for data visualization
- Map integration (Leaflet or Mapbox) for soil data
- REST API integration with desktop backend
- Responsive design for desktop and tablet
- Unit and integration test coverage > 80%

---

## Acceptance Criteria

- [ ] Site overview dashboard displaying key metrics
- [ ] Soil test results visualized on charts and maps
- [ ] Earthworks progress shown with Gantt-style timeline
- [ ] PDF and CSV export working correctly
- [ ] Dashboard loading in < 2 seconds
- [ ] Responsive design for desktop and tablet
- [ ] Test suite passing with > 80% coverage

---

## Dependencies

- **Blocked by:** LAND-SITE-002 (Core integration APIs)

---

## Subtasks

- [ ] Web project setup and architecture
- [ ] Site overview dashboard
- [ ] Soil test results visualization
- [ ] Earthworks progress timeline
- [ ] Export functionality
- [ ] Testing and validation

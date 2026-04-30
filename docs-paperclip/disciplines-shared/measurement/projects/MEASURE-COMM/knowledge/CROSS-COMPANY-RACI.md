# CROSS-COMPANY RACI MATRIX — MEASURE-COMM

## Overview

This document defines the Responsible, Accountable, Consulted, and Informed (RACI) assignments for the MEASURE-COMM project across all participating companies.

## RACI Key

- **R** — Responsible (does the work)
- **A** — Accountable (answers for the outcome)
- **C** — Consulted (provides input before decision)
- **I** — Informed (notified after decision)

## RACI Matrix

| Activity | qualityforge-ai | domainforge-ai | devforge-ai | measureforge-ai | loopy-ai | paperclipforge-ai |
|----------|----------------|----------------|-------------|-----------------|----------|-------------------|
| **MEASURE-001: Shared UI Architecture** | | | | | | |
| IntegrationCard component | R/A | - | C | C | C | I |
| MeasurementGrid (AG Grid) | R/A | - | C | C | - | I |
| AccuracyMeter component | R/A | - | C | C | C | I |
| DisciplineBadge component | R/A | - | C | C | C | I |
| ConnectionWizard OAuth flow | R/A | - | C | C | - | I |
| 4-Panel UI Layout | R/A | - | C | C | C | I |
| AI chat interface integration | R/A | - | C | C | - | I |
| Inter-panel communication | R/A | - | C | C | - | I |
| Responsive behavior | R/A | - | C | C | C | I |
| **MEASURE-001-REVIEW: UI Review** | | | | | | |
| Creative/UX review | C | - | - | - | R | C |
| Domain-specific UI validation | C | - | - | R | - | - |
| Cross-platform UX consistency | C | - | - | - | - | R |
| Technical feasibility assessment | C | - | R | - | - | - |
| Quality assurance review | R/A | - | - | - | - | - |
| Feedback synthesis | R/A | - | - | - | - | - |
| **MEASURE-002: OpenCV Engine** | | | | | | |
| OpenCV pipeline for DWG/DXF | R/A | - | C | C | - | - |
| Scale calibration system | R/A | - | C | C | - | - |
| Element detection algorithms | R/A | - | C | C | - | - |
| Measurement calculations | R/A | - | C | C | - | - |
| Results validation & error correction | R/A | - | C | C | - | - |
| Performance optimization | R/A | - | C | C | - | - |
| **MEASURE-003: Discipline Integration** | | | | | | |
| Civil Engineering dashboard | - | R/A | C | C | - | - |
| Electrical Engineering dashboard | - | R/A | C | C | - | - |
| Mechanical Engineering dashboard | - | R/A | C | C | - | - |
| Structural Engineering dashboard | - | R/A | C | C | - | - |
| Discipline templates | - | R/A | C | C | - | - |
| Cross-discipline coordination | - | R/A | C | C | - | - |
| **MEASURE-004: Standards Compliance** | | | | | | |
| SANS 1200 validation engine | R/A | C | C | C | - | - |
| ASAQS compliance framework | R/A | C | C | C | - | - |
| Multi-jurisdictional standards | R/A | C | C | C | - | - |
| Real-time compliance feedback | R/A | C | C | C | - | - |
| Violation reporting & correction | R/A | C | C | C | - | - |
| Compliance dashboard | R/A | C | C | C | - | - |
| **BUILDER-MEAS-AGENTS** | | | | | | |
| Procurement Classifier Agent | - | R/A | - | C | - | - |
| Subcontract Procurement Agent | - | R/A | - | C | - | - |
| Materials Procurement Agent | - | R/A | - | C | - | - |
| Service Procurement Agent | - | R/A | - | C | - | - |
| Work Order Procurement Agent | - | R/A | - | C | - | - |
| Supplier Matching Agent | - | R/A | - | C | - | - |
| Candy Integration Agent | - | R/A | - | C | - | - |
| Budget Monitoring Agent | - | R/A | - | C | - | - |
| Approval Routing Agent | - | R/A | - | C | - | - |

## Company Roles

| Company | Primary Role | Issues Assigned |
|---------|-------------|-----------------|
| **qualityforge-ai** | Quality assurance, validation, standards compliance | MEASURE-001, MEASURE-001-REVIEW, MEASURE-002, MEASURE-004 |
| **domainforge-ai** | Domain expertise, discipline integration, procurement strategy | MEASURE-003, BUILDER-MEAS-AGENTS |
| **devforge-ai** | Technical architecture, API integration, system interfaces | Supporting (all issues) |
| **measureforge-ai** | Measurement domain expertise, CAD integration | Supporting (all issues) |
| **loopy-ai** | Creative design, UX, visual aesthetics | Supporting (MEASURE-001, MEASURE-001-REVIEW) |
| **paperclipforge-ai** | Cross-platform UX coordination | Supporting (MEASURE-001-REVIEW) |

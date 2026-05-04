# ISSUE GENERATION STATUS — Desktop

**Project**: LANDSCAPE-PLANTING  
**Platform**: Desktop  
**Generated**: 2026-04-17  
**Generator**: Paperclip Issue Generator v1.0

## Summary

| Metric | Value |
|--------|-------|
| Total Issues | 5 |
| Phases Covered | 1 — Foundation, 2 — Core Integration, 3 — Discipline Integration, 4 — Mobile & Offline, 5 — Compliance & Audit |
| Total Story Points | 42 |
| Total Estimated Weeks | 21 |

## Generated Issues

| # | Issue ID | Title | Phase | Priority | SP | Status |
|---|----------|-------|-------|----------|----|--------|
| 1 | LAND-PLANT-001 | Planting Operations Foundation — Plant Schedule, Nursery Database & Data Model | 1 — Foundation | Critical | 8 | ✅ Generated |
| 2 | LAND-PLANT-002 | Planting Operations Core — Planting Workflow, Quality Inspection & Establishment Tracking | 2 — Core Integration | High | 13 | ✅ Generated |
| 3 | LAND-PLANT-003 | Planting Operations Integration — Nursery Ordering, Delivery Coordination & Irrigation Linking | 3 — Discipline Integration | High | 8 | ✅ Generated |
| 4 | LAND-PLANT-004 | Planting Operations Mobile — Field Planting Log, Quality Inspection & Offline Records | 4 — Mobile & Offline | High | 8 | ✅ Generated |
| 5 | LAND-PLANT-005 | Planting Operations Compliance — Planting Records, Establishment Monitoring & Audit Trail | 5 — Compliance & Audit | Medium | 5 | ✅ Generated |

## Validation

- [x] All issue IDs follow LAND-PLANT-NNN format
- [x] All frontmatter includes required fields (id, title, labels, phase, status, priority, story_points, due_date, assignee, company)
- [x] Blocking/blocked_by relationships are consistent across issues
- [x] Phase progression is sequential (1→2→3→4→5)
- [x] Story points are assigned and total matches implementation plan
- [x] Due dates are sequential and realistic

## Notes

- LAND-PLANT-001 blocks all subsequent issues (foundation dependency)
- LAND-PLANT-002 and LAND-PLANT-WEB-001 run in parallel during Phase 2
- LAND-PLANT-004 provides mobile backend APIs consumed by MOBILE-001 and MOBILE-002
- LAND-PLANT-005 and LAND-PLANT-WEB-003 run in parallel during Phase 5

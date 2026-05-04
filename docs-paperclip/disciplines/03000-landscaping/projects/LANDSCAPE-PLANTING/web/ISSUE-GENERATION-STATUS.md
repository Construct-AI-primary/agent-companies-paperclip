# ISSUE GENERATION STATUS — Web

**Project**: LANDSCAPE-PLANTING  
**Platform**: Web  
**Generated**: 2026-04-17  
**Generator**: Paperclip Issue Generator v1.0

## Summary

| Metric | Value |
|--------|-------|
| Total Issues | 3 |
| Phases Covered | 2 — Core Integration, 3 — Discipline Integration, 5 — Compliance & Audit |
| Total Story Points | 13 |
| Total Estimated Weeks | 12 |

## Generated Issues

| # | Issue ID | Title | Phase | Priority | SP | Status |
|---|----------|-------|-------|----------|----|--------|
| 1 | LAND-PLANT-WEB-001 | Planting Operations Web — Planting Dashboard, Schedule Overview & Nursery Orders | 2 — Core Integration | High | 5 | ✅ Generated |
| 2 | LAND-PLANT-WEB-002 | Planting Operations Web — Plant Schedule Management, Nursery Supplier Config & Quality Standards | 3 — Discipline Integration | High | 5 | ✅ Generated |
| 3 | LAND-PLANT-WEB-003 | Planting Operations Web — Planting Records Audit, Establishment Reports & Compliance Documentation | 5 — Compliance & Audit | Medium | 3 | ✅ Generated |

## Validation

- [x] All issue IDs follow LAND-PLANT-WEB-NNN format
- [x] All frontmatter includes required fields (id, title, labels, phase, status, priority, story_points, due_date, assignee, company)
- [x] Blocked_by relationships reference correct desktop issues
- [x] WEB-001 blocked by LAND-PLANT-002 (runs in parallel during Phase 2)
- [x] WEB-002 blocked by WEB-001 (sequential within Phase 3)
- [x] WEB-003 blocked by LAND-PLANT-005 (runs in parallel during Phase 5)
- [x] Story points are assigned and total matches implementation plan
- [x] Due dates align with respective phase timelines

## Notes

- WEB-001 runs in parallel with LAND-PLANT-002 during Phase 2
- WEB-002 runs in parallel with LAND-PLANT-003 during Phase 3
- WEB-003 runs in parallel with LAND-PLANT-005 during Phase 5
- Web issues are sequential within their own track (WEB-001 → WEB-002 → WEB-003)

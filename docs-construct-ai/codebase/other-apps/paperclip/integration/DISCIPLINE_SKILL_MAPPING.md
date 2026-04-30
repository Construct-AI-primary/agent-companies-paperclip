# Discipline Skill Mapping

## Overview

Each discipline folder contains multiple skills. These should be assigned to agents whose role matches the discipline.

## Mapping Strategy

### Rule 1: Discipline Code → Agent Role Match
Agents whose role/title contains the discipline code or name get ALL skills from that discipline.

### Rule 2: Director Agents Get Their Discipline
Director agents (e.g., `00882_construction-director`) get all skills from their discipline folder.

### Rule 3: Cross-Discipline Skills
Some skills apply broadly (e.g., ethics, governance) and should be assigned to all agents.

## Discipline Skill Counts

| Discipline | Skills | Target Agents |
|------------|--------|---------------|
| 00250-commercial | 25 | Commercial Manager, Contracts agents |
| 00300_construction | 15 | Construction Manager, Site agents |
| 00400_contracts | 11 | Contracts Manager, Legal agents |
| 00425_contracts-pre-award | 16 | Pre-award Contracts agents |
| 00435_contracts-post-award | 10 | Post-award Contracts agents |
| 00800_design | 10 | Design Manager, Architect agents |
| 00825_architectural | 10 | Architect agents |
| 00835_chemical-engineering | 9 | Chemical Engineer agents |
| 00850_civil-engineering | 11 | Civil Engineer agents |
| 00855_geotechnical-engineering | 9 | Geotechnical Engineer agents |
| 00860_electrical-engineering | 10 | Electrical Engineer agents |
| 00870_mechanical-engineering | 9 | Mechanical Engineer agents |
| 00871_process-engineering | 9 | Process Engineer agents |
| 00872_developer | 4 | Developer agents |
| 00875_sales | 9 | Sales agents |
| 00876_directors | 3 | All Director agents |
| 00877_sundry | 3 | General agents |
| 00880_board-of-directors | 2 | Board agents |
| 00882_construction-director | 1 | Construction Director |
| 00883_contracts-director | 1 | Contracts Director |
| 00884_engineering-director | 1 | Engineering Director |
| 00885_hse-director | 8 | HSE Director |
| 00886_logistics-director | 1 | Logistics Director |
| 00887_sales-director | 3 | Sales Director |
| 00888_procurement-director | 3 | Procurement Director |
| 00889_finance-director | 3 | Finance Director |
| 00890_projects-director | 3 | Projects Director |
| 00895_director-project | 3 | Project Director |
| 00900-document-control | 1 | Document Controller |
| 01000_environmental | 1 | Environmental agents |
| 01100_ethics | 8 | ALL agents (cross-cutting) |
| 01200_finance | 10 | Finance agents |
| 01300_governance | 16 | ALL agents (cross-cutting) |
| 01400_health | 8 | HSE agents |
| 01600_local-content | 6 | Local Content agents |
| 01700_logistics | 7 | Logistics agents |
| 01750_legal | 16 | Legal agents |
| 01850_other-parties | 5 | Stakeholder agents |
| 01900_procurement | 22 | Procurement agents |
| 02000_project-controls | 9 | Project Controls agents |
| 02025_quantity-surveying | 9 | QS agents |
| 02035_scheduling | 8 | Scheduler agents |
| 02050_information-technology | 22 | IT agents |
| 02075_inspection | 6 | Inspector agents |
| 02100_public-relations | 6 | PR agents |
| 02200_quality-assurance | 6 | QA agents |
| 02250_quality-control | 6 | QC agents |
| 02400_safety | 18 | Safety agents |
| 02500_security | 5 | Security agents |
| 03000_landscaping | 7 | Landscaping agents |

## Total: ~400+ discipline skills

## Assignment Logic

```javascript
// For each agent:
// 1. Match agent role to discipline code (e.g., "commercial" → 00250-commercial)
// 2. Assign ALL skills from matching discipline
// 3. Assign cross-cutting skills (ethics, governance) to ALL agents
// 4. Assign shared skills to ALL agents
```

## Next Steps

1. Update `assign_agent_skills.mjs` to use discipline mapping
2. Run assignment for all agents
3. Verify in UI
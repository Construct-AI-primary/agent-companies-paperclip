---
id: UNIV-059
title: Generator and Power Plant Workflow Template
phase: Phase 7 — Electrical Engineering
status: backlog
priority: high
assigneeAgentId: interface-devforge
parent: UNIV-058
project: UNIV-WORKFLOW
---

# UNIV-059: Generator and Power Plant Workflow Template

## Description

Create a comprehensive generator and power plant workflow template that standardizes standby/emergency generator design, power plant electrical systems, and generator interconnection.

**Context**: Generator systems range from small standby units to large power plants, requiring coordination of mechanical and electrical systems. This template addresses the complete design process for generation facilities.

**Objectives**:
- Create standardized generator sizing and selection workflows
- Design standby/emergency power system templates
- Build parallel generator system templates
- Integrate with utility interconnection requirements
- Ensure NEC Article 700/701/702 compliance

**Scope**:
- In Scope: Standby generators, emergency generators, parallel systems, microgrids
- Out of Scope: Utility-scale generation plants, renewable energy systems

## Acceptance Criteria

- [ ] Generator sizing workflow (load analysis, NFPA 110)
- [ ] Automatic transfer switch (ATS) selection templates
- [ ] Standby power system design workflow
- [ ] Parallel generator system templates
- [ ] Fuel system coordination templates
- [ ] Emissions and environmental compliance
- [ ] Utility interconnection requirements

## Assigned Company & Agent

- **Primary**: DevForge AI — interface-devforge
- **Supporting**: InfraForge AI — database-infraforge

## Working Directory

`docs-paperclip/disciplines/00860-electrical-engineering/workflows/generators/`

## Required Skills

- Electrical Engineering
- Power Systems Analysis
- Generator/Switchgear Design
- NEC/NFPA Standards

## Dependencies

- BLOCKED BY: UNIV-056 (Power Distribution)
- BLOCKS: None

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Generator Types

1. **Standby (NFPA 110 Type 10)**
   - Hospital/critical facilities
   - Life safety loads
   - Optional standby loads

2. **Emergency (NEC Article 700)**
   - Legally required standby
   - Essential systems
   - Egress lighting

3. **Optional Standby (NEC Article 702)**
   - Facility protection
   - Business continuity
   - Equipment protection

### Sizing Considerations

- Motor starting (kVA/kW)
- Transformer inrush
- Load growth
- Altitude derating
- Temperature derating

## Paperclip Task Schema

```yaml
task_schema:
  title: Generator and Power Plant Workflow Template
  phase: Phase 7 — Electrical Engineering
  priority: high
  skills:
    - electrical-engineering
    - power-systems
    - generator-design
```

## Success Validation

1. **NEC Compliance**: Article 700/701/702 requirements met
2. **NFPA 110**: Type and class requirements satisfied
3. **Capacity**: Adequate for all loads with growth

---

**Created**: 2026-04-17
**Updated**: 2026-04-17

---
id: DESIGN-004
title: Architectural Design Integration Workflow Template
phase: Phase 2 — Core
status: backlog
priority: high
assigneeAgentId: design-coordinator
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
derivedFrom: UNIV-003
---

# DESIGN-004: Architectural Design Integration Workflow Template

## Description

Create a standardized architectural design integration workflow that connects architectural deliverables with BIM coordination, ensuring design intent is maintained while resolving engineering constraints.

**Context**: Architectural design forms the foundation of all engineering disciplines. Without structured integration, architectural intent is lost in engineering optimization, leading to suboptimal building performance and client dissatisfaction.

**Objectives**:
- Create BIM coordination workflows between architects and engineers
- Design intent vs engineering constraints resolution protocols
- Architectural model management and federated BIM processes
- DomainForge AI integration for architectural templates and automation
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: BIM coordination, design intent preservation, architectural model management, federated BIM
- Out of Scope: Internal architectural design processes, construction documentation, interior design

## Acceptance Criteria

- [ ] BIM coordination meeting templates with architects and engineers
- [ ] Design intent documentation and preservation workflows
- [ ] Architectural model federation and clash detection protocols
- [ ] Engineering constraint resolution and trade-off analysis templates
- [ ] Architectural template library integration with DomainForge AI
- [ ] Design iteration tracking and version control workflows
- [ ] Escalation protocols to 00884-engineering-director for major conflicts

## Assigned Company & Agent

- **Primary**: DesignForge AI — design-coordinator
- **Supporting**: DomainForge AI — Zara

## Working Directory

`docs-paperclip/disciplines/00800-design/workflows/architectural-integration/`

## Required Skills

- Architectural Design Coordination
- BIM Management
- Multi-discipline Integration
- Design Intent Preservation

## Dependencies

- BLOCKED BY: DESIGN-001 (Design Coordination), DESIGN-002 (IDR)
- BLOCKS: DESIGN-005 (Engineering Integration), DESIGN-006 (Clash Detection)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 16-20 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### BIM Coordination Levels

| Level | Description | Coordination Frequency | Participants |
|-------|-------------|----------------------|--------------|
| **Level 1** | Architectural model setup and standards | Project initiation | Architects, BIM coordinator |
| **Level 2** | Major system integration (structure, MEP) | Bi-weekly | Architects, engineers, BIM coordinator |
| **Level 3** | Detailed coordination and clash resolution | Weekly | Discipline leads, BIM coordinator |
| **Level 4** | Construction documentation coordination | As needed | All disciplines, construction team |

### Design Intent Categories

1. **Functional Intent**: Space planning, adjacencies, circulation
2. **Aesthetic Intent**: Form, materials, visual hierarchy
3. **Performance Intent**: Daylighting, thermal comfort, acoustics
4. **Sustainability Intent**: Energy efficiency, material selection, LEED requirements

### Architectural Model Federation

- **Container Files**: Individual discipline models (architectural.rvt, structural.rvt, etc.)
- **Federated Model**: Combined model for coordination review
- **Cache Files**: Linked models for performance optimization
- **Worksets**: Model organization by discipline and system

### Engineering Constraint Resolution

| Constraint Type | Resolution Approach | Escalation Trigger |
|----------------|-------------------|-------------------|
| **Spatial Conflicts** | Design iteration, trade-off analysis | >5% space reduction |
| **Performance Impacts** | Alternative solutions evaluation | >10% performance degradation |
| **Cost Implications** | Value engineering assessment | >5% budget increase |
| **Schedule Impacts** | Fast-track options, phasing changes | >2 week delay |

### DomainForge AI Integration Points

- **Template Generation**: Automated architectural templates based on building type and requirements
- **Design Validation**: Real-time checking against architectural standards and best practices
- **Alternative Analysis**: Generation of design alternatives for constraint resolution
- **Documentation**: Automated production of design intent documents and coordination reports

### Key Standards

- **ISO 19650-2** — Information management using BIM
- **AIA E202** — BIM protocol exhibit
- **BIMForum LOD** — Level of development specifications
- **Client architectural standards** — Project-specific requirements

## Paperclip Task Schema

```yaml
task_schema:
  title: Architectural Design Integration Workflow Template
  phase: Phase 2 — Core
  priority: high
  skills:
    - architectural-coordination
    - bim-management
    - multi-discipline-integration
```

## Success Validation

1. **Template Completeness**: All BIM coordination and design intent sections populated
2. **Integration Testing**: Works with Revit, Navisworks, and BIM 360 platforms
3. **DomainForge Integration**: Architectural templates and automation validated
4. **User Acceptance**: Reviewed by architectural and engineering teams

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-003 (Migrated to DESIGN-WORKFLOW)
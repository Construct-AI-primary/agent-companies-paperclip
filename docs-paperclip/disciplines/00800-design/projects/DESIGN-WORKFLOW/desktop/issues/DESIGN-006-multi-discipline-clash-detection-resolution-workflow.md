---
id: DESIGN-006
title: Multi-Discipline Clash Detection and Resolution Workflow Template
phase: Phase 3 — Enhancement
status: backlog
priority: medium
assigneeAgentId: design-coordinator
parent: DESIGN-WORKFLOW
project: DESIGN-WORKFLOW
derivedFrom: UNIV-003
---

# DESIGN-006: Multi-Discipline Clash Detection and Resolution Workflow Template

## Description

Create a standardized multi-discipline clash detection and resolution workflow that identifies, categorizes, and resolves design clashes across all engineering disciplines using BIM technology.

**Context**: Design clashes discovered during construction cause significant rework, delays, and cost overruns. Without systematic clash detection, interface errors propagate through the design process undetected.

**Objectives**:
- Create BIM clash detection workflows and protocols
- Design clash resolution and escalation procedures
- Build design change management across disciplines
- KnowledgeForge AI integration for clash case studies and precedents
- Ensure 80-95% cross-discipline reusability

**Scope**:
- In Scope: Clash detection, categorization, resolution workflows, change management, KnowledgeForge integration
- Out of Scope: Construction clash resolution, field clash management, as-built documentation

## Acceptance Criteria

- [ ] BIM clash detection workflow with automated scanning protocols
- [ ] Clash categorization system (hard/soft clashes, priority levels)
- [ ] Clash resolution procedures with responsibility assignment
- [ ] Design change management and impact assessment workflows
- [ ] Escalation protocols for major clashes requiring director approval
- [ ] Clash register and tracking system integration
- [ ] KnowledgeForge AI integration for clash precedents and solutions

## Assigned Company & Agent

- **Primary**: DesignForge AI — design-coordinator
- **Supporting**: KnowledgeForge AI — Finn

## Working Directory

`docs-paperclip/disciplines/00800-design/workflows/clash-detection/`

## Required Skills

- BIM Clash Detection
- Multi-discipline Coordination
- Design Change Management
- Technical Resolution Analysis

## Dependencies

- BLOCKED BY: DESIGN-004 (Architectural Integration), DESIGN-005 (Discipline Integration)
- BLOCKS: DESIGN-007 (Communication Platform)

## Estimated Effort

- **Complexity**: High
- **Estimated Hours**: 14-18 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### Clash Detection Categories

#### Hard Clashes (Physical Conflicts)
- **Spatial Interference**: Two or more elements occupying same space
- **Clearance Violations**: Insufficient clearance for maintenance/access
- **System Interference**: MEP systems conflicting with structural elements
- **Penetration Conflicts**: Ducts/pipes through beams, columns, or slabs

#### Soft Clashes (Design Conflicts)
- **Coordination Issues**: Systems not coordinated (e.g., diffusers above light fixtures)
- **Performance Impacts**: Design decisions affecting system performance
- **Code Violations**: Conflicts with building codes or standards
- **Operational Issues**: Maintenance or operational access problems

### Clash Priority Matrix

| Severity | Impact | Resolution Time | Escalation Level |
|----------|--------|-----------------|------------------|
| **Critical** | Safety hazard, major rework | Immediate (<24hrs) | Engineering Director |
| **High** | Significant cost/schedule impact | 3-5 days | Discipline Director |
| **Medium** | Moderate impact, resolvable | 1-2 weeks | Design Coordinator |
| **Low** | Minor coordination issue | Next review cycle | Discipline Lead |

### BIM Clash Detection Workflow

1. **Model Preparation**: Federated model setup with proper worksets and links
2. **Automated Scanning**: Clash detection rules and tolerance settings
3. **Manual Review**: Visual inspection and context assessment
4. **Clash Categorization**: Priority assignment and responsibility allocation
5. **Resolution Planning**: Solution development and approval routing
6. **Implementation**: Coordinated design changes across disciplines
7. **Verification**: Post-resolution clash checking and documentation

### Clash Resolution Strategies

#### Design Modification
- **Element Relocation**: Moving components to avoid interference
- **Size Adjustment**: Changing dimensions to accommodate interfaces
- **Alternative Routing**: Rerouting systems around obstacles
- **Design Optimization**: Value engineering for conflict resolution

#### Coordination Solutions
- **Sequential Installation**: Phased construction to avoid conflicts
- **Temporary Measures**: Construction solutions for permanent conflicts
- **Performance Trade-offs**: Acceptable performance impacts for resolution
- **Standard Details**: Pre-engineered solutions for common conflicts

### Change Management Process

1. **Change Identification**: Clash resolution requires design modification
2. **Impact Assessment**: Cross-discipline impact analysis and cost implications
3. **Approval Routing**: Based on change magnitude and cost impact
4. **Implementation Coordination**: Synchronized changes across affected models
5. **Documentation**: Change records and updated clash registers
6. **Verification**: Post-change clash detection and model validation

### KnowledgeForge AI Integration Points

- **Precedent Analysis**: Historical clash resolution case studies
- **Solution Recommendations**: AI-suggested resolution approaches
- **Pattern Recognition**: Identification of recurring clash types
- **Documentation**: Automated clash report generation and lessons learned

### Escalation Protocols

| Clash Magnitude | Resolution Authority | Approval Required | Documentation |
|----------------|---------------------|------------------|---------------|
| **Minor** | Discipline Leads | Design Coordinator | Clash Register |
| **Moderate** | Design Coordinator | Engineering Director | Change Request |
| **Major** | Engineering Director | Project Director | Design Change Notice |
| **Critical** | Project Director | Board Approval | Major Change Directive |

### Key Standards

- **ISO 19650-3** — BIM collaboration processes
- **BIMForum LOD** — Level of development for clash detection
- **AIA E202** — BIM protocol for clash management
- **PAS 1192-4** — Collaborative production of information

## Paperclip Task Schema

```yaml
task_schema:
  title: Multi-Discipline Clash Detection and Resolution Workflow Template
  phase: Phase 3 — Enhancement
  priority: medium
  skills:
    - bim-clash-detection
    - multi-discipline-coordination
    - design-change-management
```

## Success Validation

1. **Workflow Completeness**: All clash detection and resolution processes documented
2. **BIM Integration**: Automated clash detection validated with Navisworks/BIM 360
3. **KnowledgeForge Integration**: Precedent analysis and solution recommendations validated
4. **User Acceptance**: Reviewed by BIM coordinators and discipline leads

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-003 (Migrated to DESIGN-WORKFLOW)
---
id: ARCH-013
title: RFI Management Workflow Template
phase: Phase 3 — Construction Administration
status: backlog
priority: critical
assignee: architectural-domainforge
company: domainforge-ai
created_date: 2026-04-17
due_date: 2026-05-17
estimated_hours: 15
parent: ARCHITECTURAL-WORKFLOW
project: ARCHITECTURAL-WORKFLOW
derivedFrom: UNIV-003
---

# ARCH-013: RFI Management Workflow Template

## Description

Create a comprehensive RFI (Requests for Information) management workflow template that standardizes RFI processing from identification through resolution and documentation.

**Context**: RFIs are critical for clarifying construction ambiguities and preventing delays. This template addresses the complete RFI lifecycle management.

**Objectives**:
- Create standardized RFI submission and tracking workflows
- Design automated routing and escalation processes
- Build response time monitoring and reporting
- Integrate with project management systems
- Ensure comprehensive RFI documentation

**Scope**:
- In Scope: RFI submission, review, response, and closeout processes
- Out of Scope: Change orders, claims, post-construction

## Acceptance Criteria

- [ ] RFI submission and logging templates
- [ ] Automated routing and assignment workflows
- [ ] Response time tracking and monitoring
- [ ] Resolution documentation processes
- [ ] Integration with project management systems
- [ ] Performance reporting and analytics

## Assigned Company & Agent

- **Primary**: DomainForge AI — architectural-domainforge
- **Supporting**: DevForge AI — interface-devforge
- **Integration Support**: IntegrateForge AI — Architectural OpenCV Measurement connectors available

## Working Directory

`docs-paperclip/disciplines/00825-architectural/workflows/rfi-management/`

## Required Skills

- Construction Administration
- Project Management
- Technical Documentation
- Contractor Coordination

## Dependencies

- BLOCKED BY: ARCH-002 (Construction Documents)
- BLOCKS: None (Phase 3 completion)

## Estimated Effort

- **Complexity**: Medium
- **Estimated Hours**: 12-16 hours
- **Timeline**: 2-3 weeks

## Technical Notes

### RFI Lifecycle Management

1. **RFI Submission**
   - Standardized submission forms
   - Digital photo/video attachments
   - Location referencing (BIM coordinates)
   - Priority level assignment

2. **RFI Review and Routing**
   - Automated assignment based on discipline
   - Escalation protocols for urgent items
   - Cross-discipline coordination requirements
   - Response time commitments

3. **RFI Response Development**
   - Technical research and coordination
   - Drawing/sketch preparation
   - Specification clarifications
   - Cost/schedule impact assessment

4. **RFI Resolution and Closeout**
   - Response distribution and confirmation
   - Implementation verification
   - Documentation archiving
   - Lessons learned capture

### Performance Metrics

1. **Response Time Goals**
   - Critical RFIs: 24 hours
   - High priority: 48 hours
   - Standard priority: 5 business days
   - Low priority: 10 business days

2. **Quality Metrics**
   - Resolution completeness rate
   - Contractor satisfaction scores
   - Repeat RFI prevention rate
   - Cost impact minimization

### Integration Requirements

1. **Project Management Systems**
   - Procore integration
   - BIM 360 connectivity
   - Primavera P6 linkage
   - Excel/SharePoint workflows

2. **Document Management**
   - Version control integration
   - Drawing reference linking
   - Specification cross-referencing
   - Change log maintenance

## Paperclip Task Schema

```yaml
task_schema:
  title: RFI Management Workflow Template
  phase: Phase 3 — Construction Administration
  priority: critical
  skills:
    - construction-administration
    - project-management
    - technical-documentation
    - contractor-coordination
```

## Success Validation

1. **Response Times**: 95% of RFIs answered within target times
2. **Resolution Quality**: >4.5/5 contractor satisfaction rating
3. **Documentation**: 100% RFIs properly documented and archived
4. **Efficiency**: 30% reduction in RFI volume through prevention

---

**Created**: 2026-04-17
**Updated**: 2026-04-17
**Derived From**: UNIV-003 (Migrated to ARCHITECTURAL-WORKFLOW)
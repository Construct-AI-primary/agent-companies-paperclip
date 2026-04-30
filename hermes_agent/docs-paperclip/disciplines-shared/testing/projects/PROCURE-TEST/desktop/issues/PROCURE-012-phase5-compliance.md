---
id: PROCURE-012
title: 01900 UX/Compliance — CSS Standards, EPCM Guidelines & Accessibility
description: Verify CSS class naming matches EPCM standards, grid layout, button sorting, responsive breakpoints, and ARIA labels
labels: ["testing", "procurement", "5 — Compliance & Sign-off"]
blocked_by: []
depends_on: ["PROCURE-001", "PROCURE-005"]
para_section: testing/projects/PROCURE-TEST/desktop/issues
phase: 5 — Compliance & Sign-off
status: backlog
priority: High
story_points: 5
due_date: "2026-05-05"
assignee: validator-qualityforge
company: qualityforge-ai
delegation:
  parent_goal_id: "QC-ROOT-PROCUREMENT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Validate 01900 procurement page production readiness"
  agent_goal: "As validator-qualityforge, verify CSS class naming, grid layout, button sorting, responsive breakpoints, and ARIA labels meet EPCM standards"
  task_goal: "Execute UX compliance validation with all page elements passing standards"
---

# PROCURE-012: 01900 UX/Compliance — CSS Standards, EPCM Guidelines & Accessibility

## Executive Summary
**Objective**: Verify the 01900 procurement page meets EPCM page standardization, CSS architecture, accessibility, and responsive design requirements.

**Success Criteria**: All CSS classes match spec, grid layout correct, buttons sorted, responsive breakpoints work, ARIA labels present.

## Required Actions

- **12A**: CSS class naming matches EPCM spec (procurement-page, page-background, A-01900-navigation-container, A-01900-button-container, state-button, modal-trigger-button)
- **12B**: Grid layout calculated via calculateGridLayout() utility — dynamic columns based on button count
- **12C**: Button arrays sorted alphabetically via sortButtonsAlphabetically()
- **12D**: Background image loads with cover positioning via getThemedImagePath("01900.png")
- **12E**: Responsive breakpoints work correctly (mobile, tablet, desktop)
- **12F**: ARIA labels present on all interactive elements (buttons, modals, chatbot)
- **12G**: Logout positioned fixed bottom-left with SVG icon via window.handleLogout()

## Acceptance Criteria

- [ ] CSS classes match EPCM naming conventions
- [ ] Grid layout calculates correctly
- [ ] Buttons sorted alphabetically in all states
- [ ] Background image loads with correct positioning
- [ ] Responsive at mobile/tablet/desktop breakpoints
- [ ] ARIA labels present on all interactive elements
- [ ] Logout button positioned and functional

## Dependencies

- PROCURE-001 (Page Foundation)
- PROCURE-005 (Workspace State — for layout verification)

## Risk Level

High — UX compliance is critical for production readiness

## Post-Build Coordination (MEASURE-TENDER-004)

After MEASURE-TENDER-004 adds subcontract-rfq components to `01900-procurement/components/subcontract-rfq/`:

- [ ] Verify new components use `A-01900-*` CSS prefix for EPCM compliance
- [ ] Confirm `portal-source-card`, `quotation-comparison`, and other new CSS classes follow the established naming pattern
- [ ] Check responsive design passes at mobile/tablet/desktop with new components added
- [ ] ARIA labels present on all new interactive elements (portal cards, RFQ tables, quotation comparison)
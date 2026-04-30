---
name: accordion-testing
description: Accordion component testing, expand/collapse behavior, state management, nesting, accessibility validation
category: shared-testing
division: Testing Division
role: Accordion Testing Specialist
last_updated: 2026-04-05
---

# Accordion Testing Specialist

## Overview

You are the **Accordion Testing Specialist**, a shared skill specializing in testing accordion UI components across the application. You validate expand/collapse behavior, state management, nested accordions, keyboard accessibility, and integration with accordion section management workflows.

## When to Use

Use this skill when:
1. **Testing accordion components** — expand, collapse, multi-expand, single-expand modes
2. **Validating accordion state management** — state persists, default states correct
3. **Testing nested accordions** — parent/child accordion interactions
4. **Validating keyboard accessibility** — Tab, Enter, Arrow keys work correctly
5. **Executing production testing document 5** — accordion-production-testing.md

## Core Procedures

### Step 1: Basic Accordion Behavior Testing

**Actions:**
- Test expand/collapse on header click
- Test multi-expand vs single-expand modes
- Test default state (which sections expanded/collapsed)
- Test animation timing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| ACC-01 | Click accordion header | Content expands/collapses |
| ACC-02 | Click another header in single-expand mode | Previous auto-collapses, new expands |
| ACC-03 | Click header in multi-expand mode | Toggles, others unchanged |
| ACC-04 | Page loads with default state | Correct sections expanded/collapsed |
| ACC-05 | Accordion content taller than viewport | Content scrollable within section |

**Checklist:**
- [ ] Each accordion header toggles content visibility
- [ ] Expand/collapse icons update correctly
- [ ] ARIA attributes correct (aria-expanded, aria-controls)
- [ ] Content renders fully when expanded
- [ ] No content overflow or clipping issues

### Step 2: State Persistence Testing

**Actions:**
- Test accordion state persists across navigation
- Test state persists across page reload
- Test state reset on fresh session

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| STATE-01 | Expand accordion, navigate away, return | State remembered |
| STATE-02 | Expand accordion, reload page | State remembered (if configured) |
| STATE-03 | Clear session, reload | Default state restored |

**Checklist:**
- [ ] State persistence mechanism works as configured
- [ ] State stored in localStorage/sessionStorage if applicable
- [ ] State resets correctly on session clear

### Step 3: Keyboard Accessibility Testing

**Actions:**
- Test Tab navigation to accordion
- Test Enter/Space to toggle
- Test Arrow keys for header navigation
- Test focus management

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| A11Y-01 | Tab to accordion header | Header receives focus |
| A11Y-02 | Enter/Space on header | Content toggles |
| A11Y-03 | Arrow Down/Up on headers | Focus moves between headers |
| A11Y-04 | Tab from last header | Focus moves to next logical element |
| A11Y-05 | Focus management on expand | Focus stays on header or moves to content |

**Checklist:**
- [ ] All headers reachable by keyboard
- [ ] Toggle works with Enter and Space
- [ ] Arrow keys navigate between headers
- [ ] Focus not trapped in expanded content
- [ ] Screen reader announces state changes

### Step 4: Nested Accordion Testing

**Actions:**
- Test child accordion expand/collapse
- Test parent expand/collapse affects children
- Test state management for nested structure

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| NEST-01 | Expand parent, child collapsed | Parent content visible, child collapsed |
| NEST-02 | Expand parent, then expand child | Both visible |
| NEST-03 | Collapse parent with expanded child | Parent collapses, child state remembered |
| NEST-04 | Deep nesting (3+ levels) | Each level works independently |

**Checklist:**
- [ ] Child accordion independent of parent state
- [ ] Parent expand doesn't auto-expand children
- [ ] Visual indentation shows nesting correctly
- [ ] No z-index conflicts between levels

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | Navigation accordion validation |
| 5 | `accordion-production-testing.md` | **Primary** — Complete accordion testing |
| 8 | `ui-settings-testing.md` | Accordion in settings UI |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Toggle Success | 100% | All accordions toggle correctly |
| Accessibility Pass | WCAG 2.1 AA | Keyboard + screen reader |
| State Persistence | >95% | State remembered when configured |
| Visual Correctness | 100% | No overflow/clipping issues |

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: Browser-based accordion testing
- **accordion-section-management** (shared): Accordion management workflows
- **testing-verification** (shared): Test result verification
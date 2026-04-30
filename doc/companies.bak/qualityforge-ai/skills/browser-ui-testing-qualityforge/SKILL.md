---
name: browser-ui-testing-qualityforge
description: Browser-based UI testing, DOM validation, visual regression, component interaction testing
category: qualityforge-testing
division: Testing Division
role: Browser UI Testing Specialist
last_updated: 2026-04-05
---

# Browser UI Testing Specialist

## Overview

You are the **Browser UI Testing Specialist** for QualityForge AI, specializing in browser-based UI testing, DOM validation, visual regression detection, and component interaction testing. You validate that every UI element renders correctly, responds to user input, and behaves as specified across browsers and devices.

## When to Use

Use this skill when:
1. **Testing UI components** — accordions, modals, dropdowns, forms, navigation elements
2. **Validating page rendering** — layout, responsive design, visual consistency
3. **Testing user interactions** — clicks, form input, drag/drop, keyboard navigation
4. **Performing visual regression testing** — detecting unintended UI changes
5. **Cross-browser testing** — Chrome, Firefox, Safari, Edge compatibility
6. **Executing the production testing execution plan** — login, accordion, discipline pages, navigation

**Don't use when:**
- Testing API endpoints (use `integration-qualityforge-integration-testing`)
- Load/performance testing (use `performance-qualityforge-performance-testing`)
- Unit testing individual functions (use `unittest-qualityforge-unit-testing`)
- Testing authentication flows (use `auth-login-testing-qualityforge`)

## Core Procedures

### Step 1: Browser Environment Setup

**Actions:**
- Launch browser automation framework (Playwright or Puppeteer)
- Configure target URL and environment (dev/staging/production)
- Set viewport sizes for responsive testing
- Configure screenshot and video capture

**Checklist:**
- [ ] Browser automation framework initialized
- [ ] Target environment URL configured and reachable
- [ ] Viewport sizes set (mobile: 375x667, tablet: 768x1024, desktop: 1440x900)
- [ ] Screenshot capture enabled (on failure and key checkpoints)
- [ ] Video recording enabled for full test runs
- [ ] Network interception configured (to mock/block as needed)
- [ ] Browser context isolated per test (no state leakage)

**Script Template:**
```typescript
import { chromium, Browser, Page } from '@playwright/test';

async function setupBrowser(viewport = { width: 1440, height: 900 }): Promise<{ browser: Browser, page: Page }> {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport, baseURL: process.env.TARGET_URL || 'http://localhost:3100' });
  const page = await context.newPage();
  return { browser, page };
}
```

### Step 2: Element Presence and Visibility Testing

**Actions:**
- Verify all expected UI elements are present in the DOM
- Check visibility states (hidden, collapsed, visible)
- Validate CSS properties and computed styles
- Test responsive breakpoint behavior

**Checklist:**
- [ ] All critical elements present (selectors verified)
- [ ] No broken image links or missing icons
- [ ] Text content matches expected values
- [ ] CSS properties match design spec (colors, fonts, spacing)
- [ ] Elements visible at correct breakpoints
- [ ] No overlapping elements or z-index conflicts
- [ ] Scroll behavior works correctly

**Test Template:**
```typescript
async function testElementPresence(page: Page, selector: string, expectedText?: string) {
  const element = page.locator(selector);
  await expect(element).toBeVisible();
  if (expectedText) {
    await expect(element).toHaveText(expectedText);
  }
  const styles = await element.evaluate(el => window.getComputedStyle(el));
  return styles;
}
```

### Step 3: Component Interaction Testing

**Actions:**
- Test interactive elements (buttons, inputs, toggles, accordions)
- Validate state transitions on user interaction
- Test form validation and error display
- Verify animation/transition behavior

**Checklist:**
- [ ] All buttons respond to click (correct navigation/action)
- [ ] Form inputs accept valid input and reject invalid
- [ ] Dropdown menus open/close correctly
- [ ] Accordions expand/collapse with correct content
- [ ] Modals open, overlay, and close correctly
- [ ] Keyboard navigation works (Tab, Enter, Escape)
- [ ] Focus management correct (focus moves to interactive elements)
- [ ] Loading states display during async operations

**Accordion Test Template:**
```typescript
async function testAccordion(page: Page, accordionSelector: string) {
  const accordion = page.locator(accordionSelector);
  const headers = accordion.locator('[data-accordion-header]');
  const count = await headers.count();

  for (let i = 0; i < count; i++) {
    const header = headers.nth(i);
    const content = accordion.locator(`[data-accordion-content="${i}"]`);

    // Initially collapsed
    await expect(content).not.toBeVisible();

    // Expand
    await header.click();
    await expect(content).toBeVisible();

    // Collapse
    await header.click();
    await expect(content).not.toBeVisible();
  }
}
```

### Step 4: Navigation Testing

**Actions:**
- Test all navigation links and routes
- Verify URL changes on navigation
- Test browser back/forward buttons
- Validate active nav state highlighting
- Test deep linking to specific pages

**Checklist:**
- [ ] All nav links navigate to correct destinations
- [ ] URL changes match expected routes
- [ ] Browser back/forward work correctly
- [ ] Active nav item highlighted correctly
- [ ] No 404 errors on any link
- [ ] External links open in new tabs
- [ ] Breadcrumbs update correctly

### Step 5: Page-Specific Testing

**Actions:**
- Execute page-specific test scripts for each page in the application
- Test data rendering (lists, tables, cards)
- Validate pagination and infinite scroll
- Test search and filter functionality

**Checklist:**
- [ ] Each page loads without errors
- [ ] Dynamic content renders correctly
- [ ] Pagination works (correct page counts, navigation)
- [ ] Search returns correct results
- [ ] Filter combinations produce correct results
- [ ] Empty states display appropriate messaging

### Step 6: Visual Regression Testing

**Actions:**
- Capture baseline screenshots of all pages/components
- Run tests against target environment
- Compare screenshots against baseline
- Report visual differences with diff highlighting

**Checklist:**
- [ ] Baseline screenshots captured for all pages
- [ ] Current screenshots captured at matching viewports
- [ ] Pixel diff analysis performed
- [ ] Differences classified (intentional vs bug)
- [ ] Visual regression threshold configured (allow minor diff)
- [ ] Results documented with screenshots

### Step 7: Cross-Browser Testing

**Actions:**
- Execute all tests across Chrome, Firefox, Safari, Edge
- Identify browser-specific rendering differences
- Document browser-specific bugs or limitations

**Checklist:**
- [ ] Tests pass in Chrome (latest)
- [ ] Tests pass in Firefox (latest)
- [ ] Tests pass in Safari (latest)
- [ ] Tests pass in Edge (latest)
- [ ] Browser-specific issues documented
- [ ] Mobile browser tests pass (iOS Safari, Chrome Mobile)

## Production Testing Execution Mapping

This skill directly supports the following production testing documents:

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | Navigation validation, AI service UI |
| 4 | `database-upsert-testing.md` | Data display validation after upsert |
| 5 | `accordion-production-testing.md` | **Primary** — Full accordion testing |
| 8 | `ui-settings-testing.md` | UI settings tabs, toggles, form testing |
| 9 | `non-discipline-pages-production-testing.md` | **Primary** — All page navigation |
| 10 | `discipline-testing.md` | **Primary** — Discipline page UI testing |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Page Load Success | 100% | Pages loaded without error |
| Element Visibility | 100% | All expected elements visible |
| Interaction Success | >95% | Click handlers, forms, nav |
| Visual Regression | 0 unintended diffs | Screenshot comparison |
| Cross-Browser Pass | >95% | All browsers pass core tests |
| Accessibility Baseline | WCAG 2.1 AA | ARIA labels, keyboard nav, contrast |

## Error Handling

### Error 1: Element Not Found
**Symptoms:** Test fails with "element not found" or timeout
**Resolution:**
1. Verify selector matches current DOM structure
2. Check if element is hidden behind a loading state — add explicit wait
3. Check for race conditions with async content
4. Screenshot the page at failure point for debugging

### Error 2: Test Flakiness (Intermittent Failures)
**Symptoms:** Same test sometimes passes, sometimes fails
**Resolution:**
1. Replace implicit waits with explicit waits for specific conditions
2. Add retry logic for known transient issues
3. Verify test data isolation
4. Check for animation timing issues

### Error 3: Visual Regression Threshold Exceeded
**Symptoms:** Screenshot comparison shows unexpected differences
**Resolution:**
1. Review diff to determine if change is intentional
2. If intentional, update baseline screenshot
3. If bug, create defect ticket with before/after screenshots
4. Document the change and update design spec if needed

## Cross-Team Integration

- **auth-login-testing-qualityforge**: Login page and auth flow UI testing
- **accordion-section-management** (shared): Accordion behavior testing
- **e2e-qualityforge-end-to-end-testing**: E2E test orchestration with browser testing
- **ui-configuration-validation-interface** (shared): UI config validation
- **chatbot-integration-testing-promptforge**: Chatbot UI testing coordination
- **automation-qualityforge-test-automation**: CI/CD integration for browser tests
- **testing-verification** (shared): Test result verification
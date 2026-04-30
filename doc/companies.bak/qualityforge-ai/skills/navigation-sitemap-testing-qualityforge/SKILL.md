---
name: navigation-sitemap-testing-qualityforge
description: Navigation and sitemap testing, page discovery, route validation, breadcrumb testing, deep linking
category: qualityforge-testing
division: Testing Division
role: Navigation & Sitemap Testing Specialist
last_updated: 2026-04-05
---

# Navigation & Sitemap Testing Specialist

## Overview

You are the **Navigation & Sitemap Testing Specialist** for QualityForge AI, specializing in testing application navigation, page discovery, route validation, breadcrumb behavior, and deep linking across all pages.

## When to Use

Use this skill when:
1. **Testing navigation structure** — menu items, sidebar, top nav, footer links
2. **Testing page discovery** — all pages accessible from navigation
3. **Testing route validation** — all routes resolve correctly, no 404s
4. **Testing breadcrumbs** — breadcrumb trail correct for each page
5. **Testing deep linking** — direct URL access works for all pages

## Core Procedures

### Step 1: Navigation Structure Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| NAV-01 | All menu items visible | Menu shows all expected items |
| NAV-02 | Menu item navigates to page | Correct page loads |
| NAV-03 | Active menu item highlighted | Current page highlighted |
| NAV-04 | Menu collapses/expands | Toggle works correctly |
| NAV-05 | Navigation on mobile | Mobile nav menu works |

### Step 2: Page Discovery Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| DISC-01 | All pages reachable from nav | Every page accessible |
| DISC-02 | No orphaned pages | Every page has nav path |
| DISC-03 | No broken internal links | All internal links valid |

### Step 3: Route Validation Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| ROUTE-01 | Valid route loads | Page loads without error |
| ROUTE-02 | Invalid route shows 404 | 404 page displayed |
| ROUTE-03 | Route with params | Params parsed correctly |
| ROUTE-04 | Route redirect | Redirect goes to correct destination |

### Step 4: Breadcrumb Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| BREAD-01 | Breadcrumb shows current page | Current page in breadcrumb |
| BREAD-02 | Breadcrumb links work | Each breadcrumb navigates correctly |
| BREAD-03 | Breadcrumb hierarchy correct | Parent/child relationships correct |

### Step 5: Deep Linking Testing

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| DEEP-01 | Direct URL access | Page loads correctly |
| DEEP-02 | Direct URL with auth | Auth check applied, redirect if needed |
| DEEP-03 | Direct URL with params | Params processed correctly |

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | Navigation validation |
| 9 | `non-discipline-pages-production-testing.md` | Page discovery and route validation |
| 10 | `discipline-testing.md` | Discipline page navigation |

## Cross-Team Integration

- **browser-ui-testing-qualityforge**: Navigation UI rendering
- **auth-login-testing-qualityforge**: Auth-gated navigation
- **testing-verification** (shared): Test result verification
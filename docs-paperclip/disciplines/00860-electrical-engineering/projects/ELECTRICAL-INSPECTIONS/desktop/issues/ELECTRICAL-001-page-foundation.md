---
id: ELECTRICAL-001
title: "00860 Page Foundation — Login, Navigation & Logout"
description: "Implement the base 00860 Electrical Engineering discipline page shell with login authentication, three-state navigation (Agents, Upsert, Workspace), and logout functionality."
labels: ["electrical", "00860", "1 — Foundation"]
blocked_by: []
depends_on: []
para_section: electrical-engineering/projects/ELECTRICAL-INSPECTIONS/desktop/issues
phase: "1 — Foundation"
status: todo
priority: Critical
story_points: 3
due_date: "2026-05-20"
assignee: "domainforge-ai"
company: "domainforge-ai"
delegation:
  parent_goal_id: "ELECTRICAL-INSPECTIONS-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Implement 00860 electrical inspection management"
  agent_goal: "As domainforge-ai, implement the 00860 page foundation with login, navigation, and logout"
  task_goal: "Execute page shell implementation with 100% pass rate"
---

# ELECTRICAL-001: 00860 Page Foundation — Login, Navigation & Logout

## Executive Summary

Build the foundational page shell for the 00860 Electrical Engineering discipline. This includes a login gate, the three-state navigation bar (Agents, Upsert, Workspace), and a logout mechanism. All subsequent electrical inspection features depend on this shell.

## Problem Statement / Scope

The 00860 Electrical Engineering page requires a secure entry point and consistent navigation structure. Without this foundation, no electrical inspection features can be accessed. The scope covers authentication gate, top-level navigation, and session termination.

## Required Actions

| # | Action | Description |
|---|--------|-------------|
| 1 | Login Gate | Implement login form with credential validation against the auth system |
| 2 | Three-State Nav | Build Agents / Upsert / Workspace tab bar with active state highlighting |
| 3 | Logout | Implement session clear and redirect to login |
| 4 | Route Guards | Protect all electrical inspection routes behind authentication check |
| 5 | Loading State | Show skeleton loader during auth verification |

## Assigned Company & Agent

- **Company**: domainforge-ai
- **Agent**: domainforge-ai

## Required Skills

- React / Next.js page architecture
- Authentication middleware / context provider
- State-driven navigation components
- CSS module or Tailwind styling for discipline pages

## Acceptance Criteria

- [ ] Login form accepts credentials and authenticates against the backend
- [ ] Invalid credentials display an error message
- [ ] Successful login redirects to the 00860 Workspace state
- [ ] Three-state navigation bar renders with Agents, Upsert, and Workspace tabs
- [ ] Active tab is visually highlighted; clicking a tab switches the content area
- [ ] Logout button clears the session and returns to the login screen
- [ ] Unauthenticated users are redirected to login for any protected route
- [ ] Skeleton loader displays during initial auth check
- [ ] Page title and meta tags reflect the 00860 Electrical Engineering discipline

## Dependencies

- Authentication API endpoint (`POST /api/v1/auth/login`)
- Session management utility (JWT or cookie-based)
- UI component library for form inputs and buttons

## Estimated Duration

- **Development**: 2 days
- **Testing**: 1 day
- **Total**: 3 days

## Risk Level

**Medium** — Authentication is a critical path; failure blocks all downstream features.

## QC Team Checks

- [ ] Login flow works end-to-end with valid and invalid credentials
- [ ] Navigation tabs switch content correctly without page reload
- [ ] Logout clears session and prevents back-navigation to protected routes
- [ ] Route guards redirect unauthenticated requests appropriately
- [ ] Loading states render correctly during auth verification
- [ ] No console errors or unhandled promise rejections
- [ ] Responsive layout works on mobile and desktop viewports

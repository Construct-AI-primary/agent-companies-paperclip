---
id: SAFETY-001
title: "02400 Page Foundation — Login, Navigation & Logout"
phase: "Phase 1 — Foundation"
status: open
priority: critical
platform: desktop
blocked_by: []
depends_on: []
parent_goal: SAFETY-INCIDENTS-2026
due_date: 2026-05-20
---

# SAFETY-001: 02400 Page Foundation — Login, Navigation & Logout

## Executive Summary

Implement the foundational page infrastructure for the 02400 Safety discipline, including authentication gate, three-state navigation (Agents | Upsert | Workspace), and logout functionality. This issue establishes the shell within which all subsequent SAFETY-INCIDENTS features will operate.

## Problem Statement / Scope

The 02400 Safety page requires a secure, role-aware entry point that validates user credentials before rendering any safety data. Without this foundation, downstream features (incident reporting, compliance monitoring, HITL review) cannot be accessed reliably. The scope includes:

- Login page with credential validation and session creation
- Post-authentication redirect to the Safety dashboard
- Three-state tab navigation bar (Agents, Upsert, Workspace)
- Logout flow that terminates the session and clears local state
- Route guard that redirects unauthenticated users to login
- Red safety header gradient per UI-UX spec (`--safety-primary: #D32F2F`)

## Required Actions

| # | Action | Detail |
|---|--------|--------|
| 1 | Implement Login page | Render login form with email/password fields; validate against auth service; store JWT in secure cookie |
| 2 | Implement Auth Guard | Wrap all /safety/safetyincidents routes in a guard that checks for valid session; redirect to /login if absent |
| 3 | Build Three-State Nav | Create tab bar with Agents, Upsert, Workspace states; highlight active tab; persist selection in URL query param |
| 4 | Implement Logout | Clear session token, purge local state, redirect to /login |
| 5 | Apply Safety Theme | Use red gradient header (`linear-gradient(135deg, #D32F2F 0%, #FF5252 100%)`), safety RAG palette, Template B layout |
| 6 | Add Loading/Error states | Show spinner during auth check; display error banner on auth failure with retry CTA |

## Assigned Company & Agent

- **Company:** domainforge-ai
- **Agent:** domainforge-ai
- **Supporting:** devforge-ai-workflow-developer, guardian-qualityforge

## Required Skills

- React + Vite frontend development
- Authentication / session management
- Role-based access control (RBAC)
- CSS theming with CSS custom properties
- Responsive layout design

## Acceptance Criteria

- [ ] Unauthenticated users are redirected to /login
- [ ] Login form validates credentials and creates a session
- [ ] Post-login redirect lands on Safety dashboard with three-state nav visible
- [ ] Three-state nav tabs (Agents, Upsert, Workspace) are clickable and highlight correctly
- [ ] Logout clears session and redirects to /login
- [ ] Red gradient header renders correctly per UI-UX spec
- [ ] Loading spinner displays during auth check
- [ ] Error banner with retry button displays on auth failure
- [ ] Route guard prevents access to protected routes without valid session

## Dependencies

- BLOCKED BY: None (foundation issue)
- BLOCKS: SAFETY-002, SAFETY-003

## Estimated Duration

- **Estimated Hours:** 16 hours
- **Complexity:** Medium
- **Timeline:** 2 business days

## Risk Level

**Medium** — Authentication is a critical security boundary; misconfiguration could expose safety data.

## QC Team Checks

- [ ] Auth token is stored securely (httpOnly cookie, not localStorage)
- [ ] Session timeout redirects to login gracefully
- [ ] Three-state nav works without JavaScript errors
- [ ] Logout clears all cached safety data from local state
- [ ] Header gradient matches UI-UX spec exactly
- [ ] Route guard cannot be bypassed via direct URL entry

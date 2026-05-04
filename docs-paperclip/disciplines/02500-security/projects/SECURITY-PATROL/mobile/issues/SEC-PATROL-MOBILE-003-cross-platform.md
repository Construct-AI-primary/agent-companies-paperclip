---
id: SEC-PATROL-MOBILE-003
title: "Patrol Management Cross-Platform — Guard Dashboard, Shift Schedule & Performance Metrics"
labels: ["security", "patrol", "mobile", "cross-platform", "4 — Mobile & Offline"]
phase: "4 — Mobile & Offline"
status: todo
priority: Medium
story_points: 3
due_date: "2026-09-30"
assignee: devforge-ai
company: devforge-ai
blocked_by: [SEC-PATROL-MOBILE-001, SEC-PATROL-MOBILE-002]
estimated_weeks: 2
---

# SEC-PATROL-MOBILE-003: Patrol Management Cross-Platform — Guard Dashboard, Shift Schedule & Performance Metrics

## Description

Build a cross-platform mobile application (React Native / Flutter) that provides guards with a self-service dashboard showing their shift schedule, assigned routes, and personal performance metrics. This app complements the native patrol apps by providing a lightweight interface for schedule management and performance tracking.

## Objectives

- Develop cross-platform guard dashboard app
- Display shift schedule with calendar view
- Show assigned routes and patrol history
- Display personal performance metrics and scorecards
- Allow guard profile management and availability updates

## Technical Approach

### App Architecture

- React Native with TypeScript (or Flutter with Dart)
- Redux / Riverpod for state management
- REST API integration with backend services
- Secure storage for authentication tokens

### Features

- **Shift Schedule**: Calendar view with assigned shifts, shift details (time, route, location), shift swap requests
- **Route Overview**: List of assigned routes, checkpoint count, estimated duration, completion status
- **Patrol History**: Past patrols with completion status, checkpoint verification count, incidents reported
- **Performance Metrics**: Route completion rate, on-time start rate, checkpoint adherence, scorecard
- **Profile Management**: Personal details, certifications, availability settings, notification preferences

## Acceptance Criteria

- [ ] Guard can view shift schedule in calendar format
- [ ] Guard can see assigned routes with checkpoint details
- [ ] Patrol history shows past patrols with status and metrics
- [ ] Performance metrics display guard scorecard
- [ ] Guard can update availability and notification preferences
- [ ] App works on both iOS and Android from single codebase

## Dependencies

- Blocked by: SEC-PATROL-MOBILE-001, SEC-PATROL-MOBILE-002

## Estimated Effort

2 weeks | 3 story points

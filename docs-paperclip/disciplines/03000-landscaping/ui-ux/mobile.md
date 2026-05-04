# 03000 Landscaping — Mobile UI/UX Specification

**Version:** 1.0  
**Last Updated:** 2026-05-04  
**Status:** Draft

## Overview

The mobile landscaping interface provides field surveyors, landscape inspectors, and maintenance crews with on-site tools for site surveys, plant inspections, irrigation checks, and maintenance task management.

## Design Principles

1. **Field-First** — Optimized for outdoor use with high-contrast display
2. **Offline Surveys** — Full survey capability without connectivity
3. **Quick Capture** — Rapid photo documentation, voice notes, GPS tagging
4. **Visual Reference** — Plant identification guides, design overlay on camera
5. **Battery Efficiency** — Optimized GPS and camera usage for field work

## Navigation

### Bottom Tab Bar
- Dashboard — Today's tasks, pending inspections
- Survey — Site survey and data collection
- Plants — Plant database and identification
- Tasks — Maintenance tasks and schedules
- More — Settings, references, reports

## Key Mobile Components

### Site Surveyor
- Step-by-step survey wizard with GPS waypoints
- Photo capture with automatic geo-tagging
- Soil condition assessment forms
- Existing vegetation documentation
- Offline queue with auto-sync

### Plant Identifier
- Camera-based plant identification
- Searchable plant database with images
- Care requirements and growth characteristics
- Native vs invasive species indicators

### Maintenance Tracker
- Task list with priority and location
- Completion confirmation with photo evidence
- Irrigation system check procedures
- Plant health assessment forms

### Design Viewer
- View planting plans and hardscape drawings
- GPS-guided plan overlay (augmented reality)
- Measurement and annotation tools
- Markup and redline capabilities

## Screen States

| State | Implementation |
|-------|---------------|
| Loading | Minimal skeleton with field status |
| Empty | "No tasks" with next recommended action |
| Error | Offline banner, cached data, retry |
| Data | Real-time with pull-to-refresh, sync indicator |

## Touch Targets

- Minimum touch target: 44x44px
- Button spacing: 8px minimum
- Swipe gestures for task completion and photo capture

## Offline Behavior

- Survey data queued locally with full GPS metadata
- Photos stored in local cache, compressed for upload
- Plant database cached for offline reference
- Automatic sync when connectivity restored
- Conflict resolution with server timestamp priority
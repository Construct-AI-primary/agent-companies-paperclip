# Discipline Platform Structure Recommendation

**Date:** 2026-04-14
**Purpose:** Define how to organize discipline workflow projects for desktop vs mobile platforms

---

## Current Structure (Platform-Agnostic)

Each discipline currently uses this structure:
```
docs-paperclip/disciplines/01900-procurement/
├── procurement-workflows-list.md          # Master workflow inventory
├── procurement-workflow-implementation.md # Implementation status tracking
├── discipline_workflow_conversion_procedure.md
├── knowledge/
│   └── PAGE-KNOWLEDGE.md
└── projects/
    ├── PROC-ORDER/       # One project per workflow
    │   ├── project.md
    │   └── issues/
    ├── PROC-SUPP/
    │   ├── project.md
    │   └── issues/
    └── ... (more projects)
```

---

## Recommendation: Split `projects/` into `desktop/` and `mobile/`

### Proposed Structure

```
docs-paperclip/disciplines/01900-procurement/
├── procurement-workflows-list.md          # Unified workflow inventory (both platforms)
├── procurement-workflow-implementation.md # Combined implementation status
├── discipline_workflow_conversion_procedure.md
├── knowledge/
│   └── PAGE-KNOWLEDGE.md
├── projects/
│   ├── desktop/                          # Desktop/web implementation projects
│   │   ├── PROC-ORDER/
│   │   │   ├── project.md
│   │   │   └── issues/
│   │   ├── PROC-SUPP/
│   │   └── ...
│   │
│   └── mobile/                           # MobileForge AI mobile implementation projects
│       ├── MOBILE-PROC-ORDER/            # Mobile-specific procurement order
│       │   ├── project.md                # Mobile-specific requirements
│       │   └── issues/                   # Mobile-specific issues
│       ├── MOBILE-PROC-VOICE/            # Mobile voice-to-order creation
│       ├── MOBILE-PROC-DASHBOARD/        # Mobile procurement dashboard
│       └── ...
```

### Key Design Principles

1. **Unified Workflow List**: The `*-workflows-list.md` remains at the discipline root as the single source of truth for workflow requirements across both platforms. It gains a `platform` tag for each workflow (desktop, mobile, or both).

2. **Platform-Specific Projects**: The `projects/` folder splits into `desktop/` and `mobile/` because:
   - Mobile workflows have different UI constraints, mobile-specific features (voice, GPS, camera, offline), and different implementation timelines
   - MobileForge AI (the mobile company) needs its own project/issue ownership
   - Different codebases = different issues, different PRs, different testing

3. **Mobile Workflow Naming**: Mobile projects get `MOBILE-` prefix to distinguish from desktop counterparts:
   - Desktop: `PROC-ORDER` (web order creation)
   - Mobile: `MOBILE-PROC-ORDER` (mobile PurchaseOrderScreen + voice + GPS)

4. **Cross-Platform Workflows**: Some workflows are identical across platforms (e.g., basic CRUD). In these cases:
   - Define the workflow spec once in the root workflows list
   - Reference the same `project.md` from both desktop/ and mobile/ via symlink or inclusion

---

## Alternative: Separate Mobile Directory (Not Recommended)

```
docs-paperclip/disciplines/01900-procurement/       # Desktop only
docs-paperclip/mobile-disciplines/01900-procurement/ # Mobile only
```

**Why not:** Fragmentation makes it hard to see what's common vs platform-specific, doubles maintenance effort, and loses the unified workflow view.

---

## Migration Plan

For each of the 5 focus disciplines:

### Step 1: Procurement (01900)
```bash
# Create mobile project structure
mkdir -p docs-paperclip/disciplines/01900-procurement/projects/mobile
mkdir -p docs-paperclip/disciplines/01900-procurement/projects/desktop

# Move existing projects to desktop
mv docs-paperclip/disciplines/01900-procurement/projects/PROC-* \
   docs-paperclip/disciplines/01900-procurement/projects/desktop/

# Create mobile-specific projects for MobileForge AI
mkdir -p docs-paperclip/disciplines/01900-procurement/projects/mobile/MOBILE-PROC-ORDER
mkdir -p docs-paperclip/disciplines/01900-procurement/projects/mobile/MOBILE-PROC-DASHBOARD
mkdir -p docs-paperclip/disciplines/01900-procurement/projects/mobile/MOBILE-PROC-SUPPLIER
```

### Step 2: Safety (02400)
```bash
mkdir -p docs-paperclip/disciplines/02400-safety/projects/mobile
mkdir -p docs-paperclip/disciplines/02400-safety/projects/desktop
# (move + create pattern above)
```

### Step 3: Logistics (01700)
```bash
mkdir -p docs-paperclip/disciplines/01700-logistics/projects/mobile
mkdir -p docs-paperclip/disciplines/01700-logistics/projects/desktop
```

### Step 4: Civil Engineering (00850)
```bash
mkdir -p docs-paperclip/disciplines/00850-civil-engineering/projects/mobile
mkdir -p docs-paperclip/disciplines/00850-civil-engineering/projects/desktop
```

### Step 5: Electrical Engineering (00860)
```bash
mkdir -p docs-paperclip/disciplines/00860-electrical-engineering/projects/mobile
mkdir -p docs-paperclip/disciplines/00860-electrical-engineering/projects/desktop
```

---

## MobileForge AI Project Templates

Each mobile project needs:

### Template: `MOBILE-{WORKFLOW}/project.md`
```markdown
---
title: Mobile {Workflow Name}
workflow: {MOBILE-XXX}
discipline: {01900, 02400, etc.}
platform: mobile
company: MobileForge AI
status: planned
parent_workflow: {PROC-ORDER, etc.}
---

# Mobile {Workflow Name}

## Overview
Mobile-specific implementation of the {workflow} workflow, designed for MobileForge AI mobile app.

## Mobile Requirements
- [ ] Touch-optimized UI with offline support
- [ ] Voice input integration
- [ ] GPS location services (if applicable)
- [ ] Camera/document capture (if applicable)
- [ ] Push notifications
- [ ] React Native + Expo compatibility

## API Integration
- Desktop API endpoint: {URL}
- Mobile-specific endpoints: {list}
- Offline sync strategy: {describe}

## Implementation
- Primary Screen: `screens/{workflow}/{Workflow}Screen.tsx`
- Redux Slice: `store/slices/{workflow}Slice.ts`
- Service: `services/{workflow}Service.ts`

## Issues
See `issues/` directory for tracked work.

## Dependencies
- {related desktop projects}
- InfraForge AI services
- MobileForge AI app foundation
```

---

## Updated Workflows List Format

Add a `platform` column to each workflow in `*-workflows-list.md`:

```markdown
| Workflow | ID | Platform | Status | Priority |
|----------|-----|----------|--------|----------|
| Procurement Order | PROC-ORDER | Desktop, Mobile | ✅ Implemented (Desktop) | High |
| Voice-to-Order Creation | MOBILE-PROC-VOICE | Mobile Only | 🟡 Planned | High |
| Mobile Procurement Dashboard | MOBILE-PROC-DASHBOARD | Mobile Only | ❌ Missing | High |
```

---

## Summary

**Recommended Approach:** Split `projects/` into `desktop/` and `mobile/` subfolders within each discipline. This:
- Keeps unified workflow requirements at the discipline root
- Separates platform-specific implementation work
- Gives MobileForge AI clear project ownership for mobile work
- Maintains visibility of cross-platform coverage
- Allows independent sprint planning per platform

**Migration Priority:** Start with Procurement (01900) as the pilot, then apply pattern to Safety (02400), Logistics (01700), Civil (00850), and Electrical (00860).

---

*Recommendation from Mobile Platform Assessment, 2026-04-14*
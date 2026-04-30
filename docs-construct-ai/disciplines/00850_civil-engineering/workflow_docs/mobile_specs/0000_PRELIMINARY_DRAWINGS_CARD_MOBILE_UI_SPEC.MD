---
title: Preliminary Drawings Card Mobile Modal Specification
author: Construct AI Memory System Team
date: 2026-03-29
version: 1.0
memory_layer: durable_knowledge
para_section: disciplines/00850_civil-engineering/workflow_docs
gigabrain_tags: disciplines, 00850_civil-engineering, mobile-cards, preliminary-drawings, drafting-agent, markup-tools, offline-review
openstinger_context: mobile-card-specification, mobile-markup, drawing-review, offline-collaboration
last_updated: 2026-03-29
---

# 00850_0_PRELIMINARY_DRAWINGS_CARD_MOBILE_UI_SPEC.md - Preliminary Drawings Card Mobile Modal Specification

## Mobile Card Overview
- **Card Type**: Preliminary Drawings (Phase 3, Card 2) - Mobile Optimized
- **Mobile Features**: Touch-based drawing markup, field verification, offline review, collaborative annotation
- **Agent Assignment**: Drafting Agent (Mobile Optimized)
- **Key Mobile Capabilities**: Finger drawing tools, voice annotations, GPS location markup, offline drawing access

## Mobile Modal Structure

### Mobile Header (Drawing Context)
```
┌─────────────────────────────────────────┐
│ 📐 PRELIMINARY DRAWINGS CARD           │
│ Phase 3 of 5 • 🔄 In Progress          │
│ Agent: Drafting                        │
│ 📄 8 Drawings • ✅ 5 Reviewed          │
└─────────────────────────────────────────┘
```

### Main Content Area (Mobile Viewport)

#### Section 1: Drawing Viewer & Markup Tools
```
┌─ Mobile Drawing Viewer ─────────────────┐
│                                        │
│ 🖼️ Current Drawing:                    │
│ Highway Layout Plan - Sheet 3          │
│                                        │
│ 🛠️ Markup Tools:                       │
│ ✏️ Freehand • 📏 Dimensions           │
│ 💬 Text Notes • 🎯 Callouts            │
│ 🔴 Clouds • ➡️ Arrows                  │
│                                        │
│ 📍 Location Integration:               │
│ GPS coordinates linked to drawing     │
│ Field verification points             │
│                                        │
│ 📊 Drawing Status:                     │
│ ✅ Layout Plan: Approved               │
│ 🟡 Profile: Under Review               │
│ ✅ Cross Sections: Approved            │
│ 🟡 Details: Comments Added             │
│                                        │
│ 🎤 Voice Annotations: [5 recordings]   │
│ "Verify clearance at bridge"           │
│ "Check utility crossing"               │
└───────────────────────────────────────┘
```

#### Section 2: Field Verification Tools
```
┌─ Field Drawing Verification ────────────┐
│                                        │
│ 📷 Photo Comparison:                   │
│ Overlay drawings on site photos        │
│ Measure deviations • Record issues     │
│                                        │
│ 🧭 GPS Navigation:                     │
│ Navigate to drawing coordinates        │
│ Real-time position on drawings         │
│                                        │
│ 📝 Field Notes:                        │
│ Voice-to-text field observations       │
│ Link notes to drawing elements         │
│                                        │
│ 📋 Verification Checklist:             │
│ ✅ Right-of-way verified               │
│ ✅ Access points confirmed             │
│ 🟡 Utility conflicts identified        │
│ ✅ Environmental constraints checked   │
│                                        │
│ ⚠️ Critical Issues:                    │
│ • Overhead power line conflict        │
│ • Drainage easement required          │
│ • Archaeological area marked          │
└───────────────────────────────────────┘
```

### Mobile Footer Actions (Drawing Optimized)
```
┌─────────────────────────────────────────────────┐
│ 🖼️ View    ✏️ Markup    📷 Compare    🧭 Navigate │
│ ✅ Review    📝 Annotate    🔄 Sync      📋 Checklist │
└─────────────────────────────────────────────────┘
```

## Mobile-Specific Features

### Touch-Based Drawing Markup
- **Finger Drawing**: Natural finger drawing and annotation
- **Gesture Controls**: Pinch-to-zoom, multi-touch navigation
- **Pressure Sensitivity**: Variable line thickness with touch pressure
- **Palm Rejection**: Ignore accidental palm touches

### Field Integration Tools
- **Photo Overlay**: Superimpose drawings on site photos
- **GPS Correlation**: Link drawing coordinates to GPS positions
- **Voice Annotations**: Audio notes linked to drawing elements
- **Real-time Sync**: Instant synchronization of field markups

### Offline Drawing Access
- **Cached Drawings**: Complete drawing set available offline
- **Progressive Loading**: Fast loading of large drawing files
- **Annotation Sync**: Background upload of markups and comments
- **Version Control**: Offline version tracking with cloud reconciliation

## Mobile Performance & Offline Capabilities
- **Offline Drawing Access**: Complete drawing review without network
- **Fast Rendering**: Smooth drawing navigation and zoom
- **Battery Optimization**: Efficient drawing processing
- **Data Compression**: Optimized storage of drawing files and markups

## Mobile Success Metrics
- **Review Speed**: 65% faster drawing review process
- **Field Accuracy**: >95% accurate field verification
- **Collaboration Efficiency**: 70% reduction in back-office queries
- **User Adoption**: >85% reviewers using mobile drawing tools
---
title: Architectural Workflow Conversion Procedure
discipline: 00825
project: ARCH-WORKFLOW
version: 1.0
date: 2026-04-17
---

# Architectural Workflow Conversion Procedure

## Overview

This document defines the procedure for converting architectural management workflows between desktop and mobile platforms, ensuring consistent workflow representation across both interfaces. The procedure addresses the unique requirements of architectural documentation, drawings, and field coordination activities.

---

## Desktop vs Mobile Workflow Representation

### Desktop Platform Characteristics

| Aspect | Desktop Implementation |
|--------|----------------------|
| Screen Size | Full desktop resolution (1920x1080+) |
| Interaction | Mouse/keyboard primary, touch secondary |
| Layout | Multi-column, complex tables, expanded views |
| Data Display | Comprehensive data tables, filters, bulk operations |
| Navigation | Multi-level menus, sidebar navigation |
| Documents | Full document viewing, side-by-side comparison, drawing markup |
| Graphics | High-resolution drawing viewing, zoom/pan controls |
| Offline | Limited offline capability |
| Input | Precise coordinate selection, detailed annotations |

### Mobile Platform Characteristics

| Aspect | Mobile Implementation |
|--------|----------------------|
| Screen Size | Mobile resolution (360px - 768px width) |
| Interaction | Touch primary, gesture-based |
| Layout | Single-column, card-based, accordion sections |
| Data Display | Essential data cards, quick actions, swipe gestures |
| Navigation | Bottom tab bar, hamburger menus, breadcrumbs |
| Documents | Document preview, annotation, quick approval |
| Graphics | Simplified drawing views, bookmarked details |
| Offline | Full offline capability for field use |
| Input | Touch markup, photo capture, voice notes |

---

## Conversion Rules

### 1. Data Table Conversions

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Multi-column specification tables | Card-based specification items |
| Sortable area schedule columns | Dropdown filters with sort |
| Drawing register with status | Quick status dashboard |
| Material schedule tables | Expandable material cards |
| Door/window schedule tables | Item cards with quick view |
| Inline editing | Edit modal/screen |
| Bulk selection | Individual item actions |
| Pagination | Infinite scroll with "Load More" |

**Example Transformation**:

Desktop:
```
┌─────────────┬────────────┬─────────────┬─────────────┬──────────┐
│ Space ID    │ Name       │ Area (m²)   │ Finish      │ Actions  │
├─────────────┼────────────┼─────────────┼─────────────┼──────────┤
│ ARCH-001    │ Lobby      │ 250.0       │ Limestone   │ View/Edit│
│ ARCH-002    │ Office A   │ 180.0       │ Carpet      │ View/Edit│
└─────────────┴────────────┴─────────────┴─────────────┴──────────┘
```

Mobile:
```
┌─────────────────────────────┐
│ Space: Lobby                │
│ ID: ARCH-001                │
│ Area: 250.0 m²              │
│ Finish: Limestone           │
│ [View] [Edit]               │
└─────────────────────────────┘
```

### 2. Form Conversions

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Multi-field specification forms | Multi-step wizard |
| Drawing upload with layers | Camera capture with annotation |
| Material selection (large library) | Search with filtered results |
| Auto-complete dropdowns | Search with results list |
| Date pickers | Native date picker |
| Rich text editors | Basic text with formatting toolbar |
| File uploads | Camera/gallery integration |
| Signature fields | Touch signature capture |
| Detail drawing markup | Quick markup tools |

### 3. Navigation Transformations

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Top navigation bar | Bottom tab bar (max 5 tabs) |
| Sidebar menus | Hamburger menu / drawer |
| Drawing set navigation | Drawing quick links |
| Breadcrumb trail | Back button + title |
| Context menus | Long-press actions |
| Quick filters | Filter icon → modal |
| Search bar | Sticky search with voice |
| Specification tree view | Expandable accordion sections |

### 4. Document Handling

**Desktop → Mobile Transformation**

| Desktop Feature | Mobile Feature |
|----------------|----------------|
| Multi-drawing view | Single drawing + carousel |
| Side-by-side drawing comparison | Swipe comparison |
| Full annotation suite | Quick markup tools |
| Drawing markup layers | Simplified layer toggle |
| Bulk download | Individual download with compression |
| Print functionality | Share/email options |
| Full specification viewing | Essential specification cards |

### 5. Drawing-Specific Conversions

**Desktop → Mobile Transformation**

| Desktop Feature | Mobile Feature |
|----------------|----------------|
| Multi-sheet drawing viewing | Single sheet + sheet navigator |
| Precise zoom/pan controls | Gesture zoom, pan |
| Layer visibility controls | Essential layer toggles |
| Coordinate display | Hidden (touch zoom only) |
| Measurement tools | Simplified measurement mode |
| Drawing markup | Quick annotation stamps |
| Revision comparison | Current vs. previous only |

---

## Workflow-Specific Conversion Rules

### ARCH-001: Spatial Planning

**Desktop Workflow Elements**:
- Space programme with multi-column sorting
- Area schedule with BOMA calculations
- Stacking diagram (interactive floor plan)
- Zoning plan with color coding
- Circulation diagram with path analysis

**Mobile Conversion**:
- Space programme cards with key metrics
- Area summary dashboard with BOMA ratios
- Stacking diagram thumbnail with tap-to-expand
- Zone cards with quick status
- Circulation path quick view
- Swipe to update space status
- Offline space register cache

**Offline Requirements**:
- Full space programme cache
- Pending sync for space updates
- Area calculations available offline

### ARCH-002: Building Envelope

**Desktop Workflow Elements**:
- Facade elevation drawings with detail callouts
- Window schedule with multi-column data
- Material specification library
- Thermal analysis results display
- Detail drawing viewer (1:5, 1:2, 1:1)
- Cross-section viewer

**Mobile Conversion**:
- Facade elevation thumbnails
- Window schedule cards
- Material specification quick view
- Essential thermal performance metrics
- Detail drawing bookmarks (key details only)
- Quick section cut visualization
- Photo capture for site conditions

**Offline Requirements**:
- Envelope specification cache
- Detail drawing cache (bookmarked)
- Pending specification updates

### ARCH-003: Interior Finishes

**Desktop Workflow Elements**:
- Finish schedule with multi-column sorting
- Material sample library
- Mockup approval tracking
- Millwork drawings with details
- Ceiling plan with fixture integration
- Acoustic specification display

**Mobile Conversion**:
- Finish schedule cards by space type
- Material sample photos with quick search
- Mockup approval quick actions
- Millwork detail bookmarks
- Ceiling plan quick view
- Acoustic requirement summary cards
- Photo capture for finish verification

**Offline Requirements**:
- Finish schedule cache
- Material sample images cache
- Pending approval sync

### ARCH-004: Fire Safety

**Desktop Workflow Elements**:
- Fire compartmentation plan with zone boundaries
- Egress diagram with path highlighting
- Fire-rated assembly schedule
- Door schedule with fire ratings
- Firestopping detail library
- Fire safety report generator

**Mobile Conversion**:
- Compartment cards with area summary
- Egress path quick reference
- Fire-rated assembly quick reference
- Door rating quick lookup
- Firestopping detail bookmarks
- Fire safety checklist for field use
- Emergency contact quick dial

**Offline Requirements**:
- Fire safety plans cache
- Egress routes available offline
- Fire safety checklist offline mode
- Emergency information available offline

### ARCH-005: Accessibility

**Desktop Workflow Elements**:
- Accessibility narrative generator
- Accessible route plan with dimensions
- Fixture schedule with ADA requirements
- Compliance matrix with code references
- Universal design feature checklist
- Vertical transportation specifications

**Mobile Conversion**:
- Accessibility narrative summary
- Accessible route cards with requirements
- Fixture quick reference guide
- Compliance status dashboard
- Field accessibility checklist
- Photo documentation for compliance
- Route distance measurements

**Offline Requirements**:
- Accessibility requirements cache
- Field checklist offline mode
- Measurement tools available offline

### ARCH-006: Shop Drawing Review

**Desktop Workflow Elements**:
- Submittal register with multi-column sorting
- Shop drawing viewer with markup tools
- Mockup approval workflow
- Sample approval tracking
- Revision comparison (side-by-side)
- Comment consolidation table

**Mobile Conversion**:
- Submittal status dashboard
- Drawing thumbnail viewer
- Quick markup tools
- Mockup approval with photo capture
- Sample approval with comparison
- Single revision view (current vs. previous)
- Comment entry per drawing
- Push notification for review requests
- One-tap approval/rejection

**Offline Requirements**:
- Pending submittal cache
- Drawing cache for assigned items
- Offline approval capability
- Pending comment submission

### ARCH-007: Handover

**Desktop Workflow Elements**:
- Punch list with multi-location filtering
- Deficiency tracking with photos
- O&M manual editor
- Warranty tracking schedule
- As-built drawing comparison
- Handover certificate generator
- Project archive management

**Mobile Conversion**:
- Punch list cards by location
- Quick deficiency capture with photo
- Deficiency status update
- O&M manual quick reference
- Warranty expiry alerts
- As-built photo documentation
- Handover checklist
- Certificate digital signature

**Offline Requirements**":
- Punch list cache
- Photo capture with offline storage
- Pending sync for deficiency updates
- Handover checklist offline mode

---

## Implementation Checklist

### Pre-Conversion
- [ ] Review desktop architectural workflow wireframes
- [ ] Identify all drawing types and viewing requirements
- [ ] Map desktop data models to mobile schemas
- [ ] Define mobile-specific features for field use
- [ ] Review accessibility requirements for mobile
- [ ] Identify offline requirements for field activities
- [ ] Plan drawing simplification for mobile viewing

### Conversion
- [ ] Create mobile navigation structure
- [ ] Implement card-based layouts for schedules
- [ ] Build form wizards for specification entry
- [ ] Add drawing thumbnail and carousel views
- [ ] Implement quick markup tools
- [ ] Add swipe gestures for status updates
- [ ] Implement pull-to-refresh patterns
- [ ] Add offline capability specifications
- [ ] Create mobile-specific drawing controls
- [ ] Implement photo capture integration

### Post-Conversion
- [ ] Cross-platform consistency review
- [ ] Drawing viewing quality verification
- [ ] Performance testing on field devices
- [ ] Offline functionality testing
- [ ] Accessibility audit (WCAG 2.1)
- [ ] Field user acceptance testing
- [ ] Documentation update

---

## Testing Requirements

### Functional Testing

| Test Case | Desktop | Mobile |
|-----------|---------|--------|
| Space programme creation | ✓ | ✓ |
| Area schedule calculation | ✓ | ✓ |
| Specification entry | ✓ | ✓ |
| Drawing viewing | ✓ | ✓ |
| Drawing markup | ✓ | ✓ |
| Photo capture | ✓ | ✓ |
| Status update | ✓ | ✓ |
| Document upload | ✓ | ✓ |
| Approval workflow | ✓ | ✓ |
| Search functionality | ✓ | ✓ |
| Offline mode | N/A | ✓ |
| Push notifications | N/A | ✓ |

### Non-Functional Testing

| Requirement | Target |
|-------------|--------|
| Page load time (mobile) | < 3 seconds |
| Drawing thumbnail load | < 2 seconds |
| Offline startup | < 5 seconds |
| Touch target size | Min 44x44px |
| Color contrast | WCAG AA compliant |
| Photo capture | High resolution |
| Offline storage | Min 500MB |

### Drawing-Specific Testing

| Test Case | Desktop | Mobile |
|-----------|---------|--------|
| Full drawing viewing | ✓ | Limited |
| Detail drawing viewing | ✓ | ✓ |
| Layer visibility | ✓ | Simplified |
| Zoom precision | ✓ | Basic |
| Markup tools | Full | Simplified |
| Comparison view | Side-by-side | Swipe |

---

## Device Compatibility

### Supported Mobile Devices

| Platform | Minimum Version | Recommended |
|----------|----------------|-------------|
| iOS | 14.0 | 16.0+ |
| Android | 10.0 | 12.0+ |
| Tablet | 10" minimum | 12" recommended |

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 768px | Single column, cards, simplified drawings |
| Tablet | 768-1024px | Two column, hybrid, enhanced drawing view |
| Desktop | > 1024px | Full multi-column, full drawing suite |

### Field Device Recommendations

| Use Case | Recommended Device |
|----------|-------------------|
| Site walks | Tablet (12"+ with stylus) |
| Punch list | Phone or tablet |
| Shop drawing review | Tablet |
| Photo documentation | Phone or tablet |
| Accessibility audit | Phone with measurement tools |

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-17 | Paperclip System | Initial release |

---

**Procedure Status**: Active  
**Document Owner**: ArchCraft AI  
**Review Frequency**: Quarterly

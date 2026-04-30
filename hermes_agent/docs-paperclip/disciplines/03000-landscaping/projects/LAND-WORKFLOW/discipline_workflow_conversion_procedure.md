---
title: Landscaping Workflow Conversion Procedure
discipline: 03000
project: LAND-WORKFLOW
version: 1.0
date: 2026-04-17
---

# Landscaping Workflow Conversion Procedure

## Overview

This document defines the procedure for converting landscaping workflows between desktop and mobile platforms, ensuring consistent workflow representation across both interfaces for the Landscaping/Sundry discipline.

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
| Documents | Full document viewing, side-by-side comparison |
| Design Tools | CAD/BIM integration, detailed annotations |
| Offline | Limited offline capability |

### Mobile Platform Characteristics

| Aspect | Mobile Implementation |
|--------|----------------------|
| Screen Size | Mobile resolution (360px - 768px width) |
| Interaction | Touch primary, gesture-based |
| Layout | Single-column, card-based, accordion sections |
| Data Display | Essential data cards, quick actions, swipe gestures |
| Navigation | Bottom tab bar, hamburger menus, breadcrumbs |
| Documents | Document preview, annotation, quick approval |
| Field Use | Photo capture, signature, GPS tagging |
| Offline | Full offline capability for site use |

---

## Conversion Rules

### 1. Data Table Conversions

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Plant schedule table with species, size, quantity | Plant card with image, specs, and quick-add |
| Material specification tables | Material accordion with key specs |
| Multi-column inspection checklists | Expandable checklist with swipe-to-complete |
| Landscape drawing markups | Image annotation with cloud markers |
| Coordinate lists | Interactive map with pins |
| Progress tracking tables | Status cards with progress indicators |

**Example Transformation**:
```
Desktop: 
┌───────────┬─────────┬──────────┬────────┬──────────┐
│ Plant ID  │ Species │ Size     │ Qty    │ Actions  │
├───────────┼─────────┼──────────┼────────┼──────────┤
│ PLT-001   │ PP      │ 25L      │ 50     │ View/Edit│
└───────────┴─────────┴──────────┴────────┴──────────┘

Mobile:
┌─────────────────────────────┐
│ 🌿 Pipturus albidus (25L)   │
│ Quantity: 50               │
│ Status: Available ✓         │
│ [View Details] [Edit]      │
└─────────────────────────────┘
```

### 2. Form Conversions

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Plant order forms with bulk entries | Quick-add form with recent orders |
| Inspection forms with multiple sections | Multi-step wizard with progress indicator |
| Irrigation zone configuration | Tap-to-select zones with visual map |
| Site measurement forms | Camera integration with measurement overlay |
| Material requisition forms | Simplified form with material search |
| As-built documentation forms | Photo capture with auto-fill metadata |

### 3. Navigation Transformations

**Desktop → Mobile Transformation**

| Desktop Element | Mobile Conversion |
|----------------|------------------|
| Project explorer tree | Accordion menu with drill-down |
| Design package navigation | Bottom tabs by package (Site, Planting, Irrigation) |
| Cross-discipline links | Contextual links with preview cards |
| Batch processing menus | Action toolbar with common operations |
| Filter panels | Filter chips with active state indicators |
| Search with advanced options | Search with voice and recent history |
| Document comparison view | Swipe carousel between documents |

### 4. Document Handling

**Desktop → Mobile Transformation**

| Desktop Feature | Mobile Feature |
|----------------|----------------|
| Multi-sheet landscape drawings | Drawing carousel with sheet selector |
| Detailed plant images gallery | Grid gallery with quick zoom |
| Specification documents (multi-page) | PDF viewer with bookmarks |
| Quantity calculations spreadsheet | Calculator widget with results log |
| Site photos with annotations | Photo viewer with markup tools |
| As-built markups on drawings | Overlay comparison with opacity slider |

---

## Workflow-Specific Conversion Rules

### LAND-001: Landscape Design

**Desktop Workflow Elements**:
- Site analysis wizard with multiple data inputs
- Planting plan with drag-and-drop species placement
- Plant schedule builder with auto-scheduling
- Material specification editor
- Concept presentation builder
- Design review workflow

**Mobile Conversion**:
- Site visit checklist with GPS tagging
- Plant picker with visual search
- Quick plant schedule updates
- Material availability check
- Concept image upload and comments
- Push notification for review requests
- Photo capture for site documentation
- Offline design data access

**Offline Requirements**:
- Complete plant database cache
- Pending design changes sync
- Site visit data capture
- Offline mapping and GPS
- Photo storage and pending upload

### LAND-002: Irrigation Design

**Desktop Workflow Elements**:
- Irrigation zone layout editor
- Pipe network design with auto-sizing
- Controller configuration interface
- System flow calculations
- Material take-off generator
- Water feature pump sizing

**Mobile Conversion**:
- Zone visual map with tap-to-edit
- Quick pipe measurement tool
- Controller status dashboard
- Flow calculation widget
- Material list with availability check
- Water feature monitoring dashboard

**Offline Requirements**:
- Irrigation zone cache
- Pipe sizing quick reference
- Controller offline mode
- Site measurement storage

### LAND-003: Softworks

**Desktop Workflow Elements**:
- Plant order management with supplier portal
- Delivery scheduling calendar
- Quality inspection forms
- Planting record keeping
- Maintenance schedule builder
- Defect tracking system

**Mobile Conversion**:
- Plant order quick-create
- Delivery schedule with map view
- Photo inspection with checklist
- Planting record with GPS
- Maintenance task list
- Defect report with photo
- Swipe to complete inspections
- QR code scanning for plant ID

**Offline Requirements**:
- Plant delivery schedule cache
- Inspection form templates
- Pending inspections queue
- Photo storage with location
- Offline plant health reference

### LAND-004: Hardworks

**Desktop Workflow Elements**:
- Paving layout designer
- Concrete pour scheduling
- Structural wall monitoring
- Water feature commissioning
- Furniture installation tracking
- Practical completion checklist

**Mobile Conversion**:
- Paving layout visual guide
- Concrete pour status tracker
- Wall construction photo log
- Water feature start/stop controls
- Furniture checklist
- Sign-off with signature capture
- Progress photo timeline
- Snag list with priority

**Offline Requirements**:
- Construction schedule cache
- Concrete specification access
- Photo storage with metadata
- Inspection form offline
- Defect list with status

---

## Implementation Checklist

### Pre-Conversion
- [ ] Review landscape design requirements
- [ ] Identify field inspection workflows
- [ ] Map plant database to mobile structure
- [ ] Define offline data requirements
- [ ] Review site photo annotation needs
- [ ] Assess GPS integration requirements

### Conversion
- [ ] Create mobile navigation structure (Site, Plants, Irrigation, Inspections)
- [ ] Implement plant card with species imagery
- [ ] Build inspection wizard with photo capture
- [ ] Add swipe gestures for status updates
- [ ] Implement pull-to-refresh patterns
- [ ] Add GPS tagging for site visits
- [ ] Build offline mode specifications
- [ ] Implement QR code scanning for plant IDs

### Post-Conversion
- [ ] Cross-platform consistency review
- [ ] Performance testing on various devices
- [ ] Battery consumption testing for field use
- [ ] Offline functionality testing
- [ ] Photo storage optimization
- [ ] Accessibility audit (WCAG 2.1)
- [ ] User acceptance testing
- [ ] Documentation update

---

## Testing Requirements

### Functional Testing
| Test Case | Desktop | Mobile |
|-----------|---------|--------|
| Plant schedule creation | ✓ | ✓ |
| Irrigation zone update | ✓ | ✓ |
| Photo inspection submission | ✓ | ✓ |
| Offline data capture | N/A | ✓ |
| Sync with server | ✓ | ✓ |
| GPS location tagging | N/A | ✓ |
| QR code scanning | N/A | ✓ |
| Push notifications | ✓ | ✓ |
| Signature capture | ✓ | ✓ |

### Non-Functional Testing
| Requirement | Target |
|-------------|--------|
| Page load time (mobile) | < 4 seconds |
| Offline startup | < 5 seconds |
| Photo upload (4G) | < 10 seconds |
| Touch target size | Min 44x44px |
| Color contrast | WCAG AA compliant |
| Battery impact | < 15% per hour active use |

### Field Testing Scenarios
1. Site walk with offline plant ID lookup
2. Inspection submission from remote site
3. Photo upload with limited connectivity
4. Multi-plant delivery confirmation
5. Defect report creation with photos
6. Paving progress photo documentation

---

## Device Compatibility

### Supported Mobile Devices

| Platform | Minimum Version | Recommended |
|----------|----------------|-------------|
| iOS | 14.0 | 16.0+ |
| Android | 10.0 | 12.0+ |
| Tablet | 10" minimum | 12" recommended |
| Camera integration | Required | High resolution preferred |
| GPS accuracy | < 10m required | < 3m recommended |

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 768px | Single column, cards, bottom nav |
| Tablet | 768-1024px | Two column, landscape support |
| Desktop | > 1024px | Full multi-column, toolbars |

### Field Use Optimizations
- Large touch targets for gloved operation
- High contrast for outdoor visibility
- Auto-brightness adjustment
- Battery optimization mode
- Offline-first architecture

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-17 | Paperclip System | Initial release |

---

**Procedure Status**: Active  
**Document Owner**: GreenScape AI  
**Review Frequency**: Quarterly

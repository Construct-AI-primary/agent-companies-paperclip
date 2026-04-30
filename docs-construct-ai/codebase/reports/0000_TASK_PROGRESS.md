---
memory_layer: durable_knowledge
para_section: pages/codebase/reports
gigabrain_tags: reports, codebase, analytics
documentation
openstinger_context: reporting-analytics, data-insights
last_updated: 2026-03-21
related_docs:
  - codebase/reports/
  - disciplines/
---
# Sundry UI Fixes - Task Progress

## Issues Fixed:

### 1. ✅ Other Parties Page (01850) - State Nav Buttons Overlapping
- **Issue**: State nav buttons overlapping with page title button
- **Fix**: Updated navigation container layout to match 01900 pattern with proper flexbox structure
- **File**: `client/src/pages/01850-other-parties/components/01850-other-parties-page.js`

### 2. ✅ Legal Page (01750) - Grid Display on Initial Load  
- **Issue**: Grid displaying when user enters page initially (should be hidden until state selected)
- **Fix**: Added conditional rendering `{currentState && currentButtons.length > 0 && (...)}` for the grid container
- **File**: `client/src/pages/01750-legal/components/01750-legal-page.js`

### 3. ✅ QS Page (02025) - Accordion Misdirection
- **Issue**: Accordion was linking to `/quantity-surveying` which routed to `DrawingMeasurementPage` (no bg image)
- **Fix**: Updated App.js to route `/quantity-surveying` to the proper `QuantitySurveyingPage` component with background image
- **Files**: 
  - `client/src/App.js` - Updated import and route

### 4. ✅ Commercial Page (00250) - No BG Image
- **Issue**: No background image displaying - was looking for `00250.png` which doesn't exist
- **Fix**: Changed image path to use `0200.png` from the `commercial` folder
- **File**: `client/src/pages/00250-commercial/components/00250-commercial-page.js`

---

## Summary of Changes:

1. **01850-other-parties-page.js**: Fixed navigation layout structure
2. **01750-legal-page.js**: Added conditional rendering for grid container
3. **App.js**: Updated QS route to use proper discipline page with background
4. **00250-commercial-page.js**: Fixed background image path

All UI fixes have been completed following the patterns from 00400 and 01900 reference implementations.

---
memory_layer: durable_knowledge
para_section: pages/codebase/guides
gigabrain_tags: guides, codebase, documentation
documentation
openstinger_context: development-guides, implementation-guidance
last_updated: 2026-03-21
related_docs:
  - codebase/guides/
  - disciplines/
---
# Procurement Routing & Modal Display Issue - Debug Guide

## Problem Description

**Issue:** When clicking "Create New Order" button in the Procurement module, the Create Order Modal does not appear or display correctly.

**Expected Behavior:**
1. User navigates to `/purchase-orders` route
2. PurchaseOrdersPage component mounts
3. User clicks "Create New Order" button
4. CreateOrderModal overlay appears with form

**Actual Behavior:**
- Modal does not appear or is invisible

## Quick Debug Checklist

### ✅ Step 1: Verify Route Access

**Test URL:** `http://localhost:3060/#/purchase-orders`

**What to check:**
- [ ] Page loads without errors
- [ ] "Purchase/Service/Work Orders" header is visible
- [ ] Order statistics cards are displayed
- [ ] Table with orders is visible
- [ ] "Create New Order" button (🔄) is visible in header

**Console commands to run (F12 Console):**
```javascript
// Check current route
console.log('Current URL:', window.location.href);
console.log('Current path:', window.location.pathname);
console.log('Current hash:', window.location.hash);

// Check if React app is running
console.log('React available:', typeof React !== 'undefined');
console.log('ReactDOM available:', typeof ReactDOM !== 'undefined');
```

### ✅ Step 2: Verify Component Mounting

**Console commands to run (F12 Console):**
```javascript
// Check if PurchaseOrdersPage is in the component tree
// (Run after page loads)

// Method 1: Check React DevTools if available
// If you have React DevTools browser extension:
// - Open DevTools → Components tab
// - Search for "PurchaseOrdersPage"

// Method 2: Check component by traversing DOM
// (Simple check - may not work with React 18)
const pageContainer = document.querySelector('.purchase-orders-page');
console.log('PurchaseOrdersPage container found:', !!pageContainer);

// Method 3: Check for purchase-orders in route list
console.log('Route list:', Object.keys(window.ROUTES || {}));
```

### ✅ Step 3: Monitor Console for Debug Logs

**Console commands to run (F12 Console):**
```javascript
// Enable detailed logging for debugging
console.log('🔍 Enabling detailed routing and modal logging...');

// These logs should appear when you navigate to the page:
// [APP_ROUTING] - App component logs
// [PURCHASE_ORDERS_PAGE] - Page component logs
// [CREATE_ORDER_MODAL] - Modal component logs

// Check if logs are appearing:
console.log('📊 Current console logs will show:');
console.log('1. [APP_ROUTING] - Route matching details');
console.log('2. [PURCHASE_ORDERS_PAGE] - Page component status');
console.log('3. [CREATE_ORDER_MODAL] - Modal component status');
console.log('4. [MODAL_STATE] - Modal visibility changes');
```

### ✅ Step 4: Test "Create New Order" Button Click

**Console commands to run (F12 Console):**
```javascript
// First, check button click handler
// Open DevTools → Elements tab
// Find the "Create New Order" button (🔄 icon)
// Right-click → Inspect
// Look for onClick handler in the HTML/JSX

// Alternative: Simulate click via console
const createButton = document.querySelector('button[title="Create new procurement order"]');
if (createButton) {
  console.log('Button found:', createButton);
  console.log('Clicking button...');
  createButton.click();
  
  // Check if state changed
  console.log('After click, check if modal overlay appears:');
  const modalOverlay = document.querySelector('.modal-overlay.active');
  console.log('Modal overlay found:', !!modalOverlay);
} else {
  console.log('❌ Create button not found');
  console.log('Button selector: button[title="Create new procurement order"]');
}
```

### ✅ Step 5: Check Modal DOM Structure

**After clicking "Create New Order" button:**

**Console commands to run (F12 Console):**
```javascript
// Check if modal overlay exists in DOM
const modalOverlay = document.querySelector('.modal-overlay');
console.log('Modal overlay found:', !!modalOverlay);

// Check if modal is active
const activeModal = document.querySelector('.modal-overlay.active');
console.log('Active modal overlay found:', !!activeModal);

// Check modal container structure
const modalContainer = document.querySelector('.modal-container');
console.log('Modal container found:', !!modalContainer);

// Check if modal is actually visible (CSS)
if (modalOverlay) {
  const styles = window.getComputedStyle(modalOverlay);
  console.log('Modal visibility:', styles.visibility);
  console.log('Modal display:', styles.display);
  console.log('Modal opacity:', styles.opacity);
  console.log('Modal z-index:', styles
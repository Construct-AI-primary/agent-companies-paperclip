#!/bin/bash
# Generate all mobile project issues for bulk upload to Paperclip
# Creates properly formatted issue files across all 5 disciplines

DISCIPLINES_DIR="docs-paperclip/disciplines"

echo "=== Mobile Project Issue Generation ==="

# ============================================================
# PROCUREMENT (01900)
# ============================================================
PROC_DIR="$DISCIPLINES_DIR/01900-procurement/projects/mobile"

echo "--- Generating MOBILE-PROC-ORDER issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-ORDER/issues"

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-001-redux-state-management.md" << 'EOF'
---
id: MOBILE-PROC-001
title: Create procurementSlice.ts for Redux State Management
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-001: Create procurementSlice.ts for Redux State Management

## Description

Create the Redux slice for procurement state management in the mobile app managing purchase orders, supplier selection, offline queue, and related procurement data.

## Problem

No procurement Redux slice exists. PurchaseOrderScreen.tsx uses in-memory state (useState, useReducer) which doesn't persist or support offline operations.

## Required Changes

Create `store/slices/procurementSlice.ts` with:
1. Purchase order state (orders, currentOrder, loading, error)
2. Supplier state (suppliers, selectedSupplier, supplierSearch)
3. Offline queue state (offlineQueue, isSyncing, lastSyncTime)
4. Reducers: createOrder, updateOrder, selectSupplier, loadSuppliers, addToOfflineQueue, syncOnline, clearError
5. Async thunks: fetchSuppliersAsync, saveOrderAsync, syncOfflineQueueAsync

## Testing Strategy
- Unit test all reducers
- Unit test async thunks with mocked API
- Integration test with SQLite database
- Test offline queue behavior

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Required Skills
- `mobile-development` (MobileForge)
- `redux-state-management` (MobileForge)
- `typescript` (DevForge)

## Acceptance Criteria
- [ ] procurementSlice.ts created with all state types
- [ ] All reducers implemented and typed
- [ ] Async thunks implemented for API/DB operations
- [ ] Offline queue reducer handles pending operations
- [ ] Unit tests pass for all reducers
- [ ] Slice exported from store/slices/index.ts
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-002-sqlite-database-integration.md" << 'EOF'
---
id: MOBILE-PROC-002
title: Integrate PurchaseOrderScreen with SQLite Database
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-backend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-002: Integrate PurchaseOrderScreen with SQLite Database

## Description

Replace in-memory state management in PurchaseOrderScreen.tsx with SQLite database integration for persistent local storage.

## Problem

PurchaseOrderScreen.tsx (589 lines) currently uses in-memory state. Orders are lost on app restart and offline operations are not supported.

## Required Changes

1. Create procurement tables in services/database.ts:
   - `purchase_orders` (id, order_number, supplier_id, items, status, created_at, updated_at)
   - `purchase_order_items` (id, order_id, item_name, quantity, unit_price, total)
2. Create CRUD operations in services/procurementService.ts
3. Replace useState/useReducer with redux-thunk integration using SQLite
4. Implement load/save operations
5. Add error handling for database operations

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-backend-engineer

## Acceptance Criteria
- [ ] purchase_orders table created in SQLite
- [ ] purchase_order_items table created in SQLite
- [ ] CRUD operations in procurementService.ts
- [ ] PurchaseOrderScreen loads from SQLite on mount
- [ ] PurchaseOrderScreen saves to SQLite on submit
- [ ] Error handling for all database operations
- [ ] No more in-memory state for orders
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-003-supplier-selection.md" << 'EOF'
---
id: MOBILE-PROC-003
title: Add Supplier Selection Dropdown with Search
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-003: Add Supplier Selection Dropdown with Search

## Description

Add supplier search and selection UI to PurchaseOrderScreen, integrating with the desktop supplier API and local SQLite cache.

## Problem

PurchaseOrderScreen has no supplier selection capability. The procurement workflow requires supplier identification for every order.

## Required Changes

1. Create SupplierSearchDropdown component
2. Integrate with desktop supplier API for search
3. Cache supplier results in SQLite for offline use
4. Add supplier selection to procurementSlice.ts
5. Add supplier info display in order form

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] SupplierSearchDropdown component created
- [ ] Search connects to desktop supplier API
- [ ] Results cached in SQLite for offline
- [ ] Selected supplier stored in procurementSlice
- [ ] Supplier name/info displayed in order form
- [ ] Debounced search (300ms delay)
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-004-voice-ai-integration.md" << 'EOF'
---
id: MOBILE-PROC-004
title: Connect Voice AI to Backend Processing
phase: 2 — Mobile-Only Features
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-ai-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
  - MOBILE-PROC-002
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-004: Connect Voice AI to Backend Processing

## Description

Connect the existing voiceService.ts to actual AI backend processing for voice-to-order creation capability.

## Problem

voiceService.ts exists and handles voice recognition, but voice commands are not processed by AI to create purchase orders.

## Required Changes

1. Integrate voiceService with aiService.ts
2. Create voice prompt templates for order creation
3. Implement voice command parsing for procurement
4. Add voice-to-text results to order form fields
5. Add voice feedback to user

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-ai-engineer

## Acceptance Criteria
- [ ] Voice recognition triggers AI order processing
- [ ] AI extracts order details from voice input
- [ ] Extracted details populate order form
- [ ] Voice feedback confirms order creation
- [ ] Works for: "Order 50 steel beams from Supplier X"
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-005-barcode-scanning.md" << 'EOF'
---
id: MOBILE-PROC-005
title: Add Barcode Scanning for Item Lookup
phase: 2 — Mobile-Only Features
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-002
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-005: Add Barcode Scanning for Item Lookup

## Description

Add barcode scanning capability to PurchaseOrderScreen for quick item lookup and order creation.

## Problem

No barcode scanning exists for procurement. Field users need quick item identification without manual entry.

## Required Changes

1. Integrate expo-barcode-scanner into PurchaseOrderScreen
2. Create ItemScannerSheet component
3. Connect scan results to item catalog API
4. Add scanned items to order automatically
5. Cache item catalog for offline scanning

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Barcode scanner opens from order screen
- [ ] Scan results trigger item lookup
- [ ] Scanned items added to order
- [ ] Works offline with cached catalog
- [ ] Scanner has flashlight toggle
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-006-offline-order-queue.md" << 'EOF'
---
id: MOBILE-PROC-006
title: Implement Offline Order Queue with Sync
phase: 2 — Mobile-Only Features
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-backend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-002
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-006: Implement Offline Order Queue with Sync

## Description

Build offline order queue that stores orders locally when offline and automatically syncs to server on reconnect.

## Problem

No offline order capability exists. Field users cannot create orders without connectivity.

## Required Changes

1. Create offline_orders table in SQLite
2. Implement order queue management
3. Build auto-sync trigger on network reconnect
4. Add conflict resolution for concurrent edits
5. Add sync status indicator UI

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-backend-engineer

## Acceptance Criteria
- [ ] Orders saved to offline_orders when offline
- [ ] Auto-sync triggers on network reconnect
- [ ] Conflict resolution handles concurrent edits
- [ ] Sync status visible in UI
- [ ] Failed syncs retry with exponential backoff
EOF

cat > "$PROC_DIR/MOBILE-PROC-ORDER/issues/MOBILE-PROC-007-navigation-integration.md" << 'EOF'
---
id: MOBILE-PROC-007
title: Integrate Procurement Screens into App Navigation
phase: 3 — Integration & Testing
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-ORDER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-001
  - MOBILE-PROC-002
  - MOBILE-PROC-003
toolsets:
  - file_tools
  - code_execution
max_iterations: 30
---

# MOBILE-PROC-007: Integrate Procurement Screens into App Navigation

## Description

Register procurement screens in the app navigation stack so users can access procurement functionality.

## Problem

CivilEngineeringScreen.tsx and other screens are not registered in App.tsx navigation. Cannot be accessed by users.

## Required Changes

1. Add procurement navigation types to App.tsx
2. Create procurement tab in bottom navigation
3. Add route for PurchaseOrderScreen
4. Add route for SupplierListScreen
5. Add route for OrderHistoryScreen

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Procurement tab visible in bottom navigation
- [ ] PurchaseOrderScreen accessible via navigation
- [ ] SupplierListScreen accessible via navigation
- [ ] OrderHistoryScreen accessible via navigation
- [ ] Navigation types properly typed in TypeScript
EOF

echo "--- Generating MOBILE-PROC-DASHBOARD issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-DASHBOARD/issues"

cat > "$PROC_DIR/MOBILE-PROC-DASHBOARD/issues/MOBILE-PROC-DASH-001-create-dashboard-screen.md" << 'EOF'
---
id: MOBILE-PROC-DASH-001
title: Create ProcurementDashboardScreen with PO List
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-DASHBOARD
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-DASH-001: Create ProcurementDashboardScreen with PO List

## Description

Create the main procurement dashboard showing purchase order list, spend summary, and quick actions.

## Problem

No procurement dashboard exists. Users have no overview view of procurement activity on mobile.

## Required Changes

1. Create ProcurementDashboardScreen.tsx
2. Add PO list with status indicators
3. Add spend summary cards
4. Add quick action buttons (new order, scan invoice, track order)
5. Add pending approvals list
6. Connect to procurement API
7. Add pull-to-refresh with loading states

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Dashboard screen created with PO list
- [ ] Status indicators (pending, approved, delivered)
- [ ] Spend summary cards visible
- [ ] Quick action buttons functional
- [ ] Pull-to-refresh works
- [ ] Loading states displayed during API calls
EOF

cat > "$PROC_DIR/MOBILE-PROC-DASHBOARD/issues/MOBILE-PROC-DASH-002-api-integration.md" << 'EOF'
---
id: MOBILE-PROC-DASH-002
title: Connect Dashboard to Procurement API
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-backend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-DASHBOARD
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-DASH-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-DASH-002: Connect Dashboard to Procurement API

## Description

Replace mock data in procurement dashboard with real API calls to desktop procurement endpoints.

## Problem

LogisticsDashboardScreen uses mock data. Same pattern would repeat for procurement if not connected to real API.

## Required Changes

1. Create procurementService.ts with API client
2. Implement fetchOrders, fetchSpendSummary, fetchPendingApprovals
3. Replace mock data in dashboard with real API calls
4. Add error handling and retry logic
5. Add API response caching

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-backend-engineer

## Acceptance Criteria
- [ ] procurementService.ts created with API client
- [ ] Real orders displayed in dashboard
- [ ] Spend summary from real data
- [ ] Pending approvals from real data
- [ ] Error handling works for API failures
- [ ] Caching reduces duplicate API calls
EOF

echo "--- Generating MOBILE-PROC-SUPPLIER issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-SUPPLIER/issues"

cat > "$PROC_DIR/MOBILE-PROC-SUPPLIER/issues/MOBILE-PROC-SUP-001-supplier-list-screen.md" << 'EOF'
---
id: MOBILE-PROC-SUP-001
title: Create SupplierListScreen with Search and Filter
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-SUPPLIER
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-SUP-001: Create SupplierListScreen with Search and Filter

## Description

Create supplier list screen with search, filter, and performance metrics display.

## Problem

No supplier list exists on mobile. Cannot select suppliers for orders or view supplier info.

## Required Changes

1. Create SupplierListScreen.tsx
2. Implement search with debouncing
3. Add filter by category, rating, status
4. Display supplier cards with key info
5. Add pull-to-refresh
6. Connect to supplier API

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Supplier list displays all suppliers
- [ ] Search works with 300ms debounce
- [ ] Filters functional (category, rating, status)
- [ ] Supplier cards show key info
- [ ] Pull-to-refresh works
- [ ] Connected to real supplier API
EOF

cat > "$PROC_DIR/MOBILE-PROC-SUPPLIER/issues/MOBILE-PROC-SUP-002-supplier-detail-screen.md" << 'EOF'
---
id: MOBILE-PROC-SUP-002
title: Create SupplierDetailScreen with Performance Metrics
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-SUPPLIER
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-SUP-001
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-SUP-002: Create SupplierDetailScreen with Performance Metrics

## Description

Create supplier detail screen showing full supplier info, performance history, and on-site audit capability.

## Problem

No supplier detail view. Cannot view supplier performance or conduct on-site audits from mobile.

## Required Changes

1. Create SupplierDetailScreen.tsx
2. Display full supplier info (contact, categories, certifications)
3. Show performance metrics (delivery rate, quality score)
4. Add on-site audit form with photo capture
5. Add GPS-verified site visit logging
6. Add offline supplier catalog access

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] Supplier detail screen with all info
- [ ] Performance metrics displayed
- [ ] On-site audit form functional
- [ ] Photo capture in audit form
- [ ] GPS-verified site visit logging
- [ ] Offline catalog access works
EOF

echo "--- Generating MOBILE-PROC-INVOICE issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-INVOICE/issues"

cat > "$PROC_DIR/MOBILE-PROC-INVOICE/issues/MOBILE-PROC-INV-001-invoice-capture-screen.md" << 'EOF'
---
id: MOBILE-PROC-INV-001
title: Create InvoiceCaptureScreen with Camera Integration
phase: 1 — Foundation
status: open
priority: Critical
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-INVOICE
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-INV-001: Create InvoiceCaptureScreen with Camera Integration

## Description

Create invoice capture screen with camera integration for OCR-based invoice data extraction.

## Problem

No invoice capture exists on mobile. Field users cannot process invoices on-site.

## Required Changes

1. Create InvoiceCaptureScreen.tsx
2. Integrate expo-camera for invoice photo capture
3. Implement OCR for invoice data extraction
4. Add 3-way match verification UI (PO vs GR vs Invoice)
5. Add discrepancy resolution workflow
6. Implement offline invoice capture

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] InvoiceCaptureScreen created
- [ ] Camera integration for invoice capture
- [ ] OCR extracts invoice data
- [ ] 3-way match verification UI
- [ ] Discrepancy resolution workflow
- [ ] Offline invoice capture works
EOF

echo "--- Generating MOBILE-PROC-TRACKING issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-TRACKING/issues"

cat > "$PROC_DIR/MOBILE-PROC-TRACKING/issues/MOBILE-PROC-TRACK-001-order-tracking-screen.md" << 'EOF'
---
id: MOBILE-PROC-TRACK-001
title: Create OrderTrackingScreen with Real-Time Updates
phase: 1 — Foundation
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-frontend-engineer
discipline: 01900-procurement
project: MOBILE-PROC-TRACKING
platform: mobile
parent_issue: none
dependencies: []
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-TRACK-001: Create OrderTrackingScreen with Real-Time Updates

## Description

Create order tracking screen showing shipment list with real-time status updates and GPS delivery confirmation.

## Problem

No order tracking exists on mobile. Field users cannot track deliveries or confirm receipt.

## Required Changes

1. Create OrderTrackingScreen.tsx
2. Display shipment list with status
3. Add real-time status updates via subscriptions
4. Implement GPS delivery confirmation
5. Add barcode scanning for goods receipt
6. Add push notifications for delivery events

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-frontend-engineer

## Acceptance Criteria
- [ ] OrderTrackingScreen with shipment list
- [ ] Real-time status updates
- [ ] GPS delivery confirmation functional
- [ ] Barcode scanning for goods receipt
- [ ] Push notifications for delivery events
- [ ] Delay alerts visible
EOF

echo "--- Generating MOBILE-PROC-VOICE issues ---"
mkdir -p "$PROC_DIR/MOBILE-PROC-VOICE/issues"

cat > "$PROC_DIR/MOBILE-PROC-VOICE/issues/MOBILE-PROC-VOICE-001-voice-order-creation.md" << 'EOF'
---
id: MOBILE-PROC-VOICE-001
title: Implement Voice-First Order Creation
phase: 1 — Mobile-Only Feature
status: open
priority: High
company: mobileforge-ai
agent: mobileforge-ai-ai-engineer
discipline: 01900-procurement
project: MOBILE-PROC-VOICE
platform: mobile
parent_issue: none
dependencies:
  - MOBILE-PROC-004
toolsets:
  - file_tools
  - code_execution
max_iterations: 50
---

# MOBILE-PROC-VOICE-001: Implement Voice-First Order Creation

## Description

Implement complete voice-first order creation workflow allowing hands-free procurement order creation.

## Problem

Voice service exists but voice order creation is not fully integrated with AI backend processing.

## Required Changes

1. Create VoiceOrderCreationScreen.tsx
2. Integrate with AI order processing
3. Support voice commands: "Order 50 steel beams from Supplier X"
4. Add voice status queries: "What's the status of my orders?"
5. Add voice approval: "Approve purchase order PO-12345"
6. Add voice incident reporting

## Assigned Company & Agent
- **Company:** MobileForge AI
- **Agent:** mobileforge-ai-ai-engineer

## Acceptance Criteria
- [ ] VoiceOrderCreationScreen functional
- [ ] AI processes voice order commands
- [ ] Voice status queries return order status
- [ ] Voice approval triggers approval workflow
- [ ] Voice incident reporting functional
EOF

echo "=== Generation complete ==="
echo "Created issues for:"
echo "- MOBILE-PROC-ORDER: 7 issues"
echo "- MOBILE-PROC-DASHBOARD: 2 issues"
echo "- MOBILE-PROC-SUPPLIER: 2 issues"
echo "- MOBILE-PROC-INVOICE: 1 issue"
echo "- MOBILE-PROC-TRACKING: 1 issue"
echo "- MOBILE-PROC-VOICE: 1 issue"
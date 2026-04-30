#!/usr/bin/env python3
"""
Generate all mobile project issues for bulk upload to Paperclip
Creates properly formatted issue files across all 5 disciplines
"""

import os
from pathlib import Path

DISCIPLINES = {
    '01900-procurement': {
        'name': 'procurement',
        'projects': [
            'MOBILE-PROC-ORDER',
            'MOBILE-PROC-DASHBOARD',
            'MOBILE-PROC-SUPPLIER',
            'MOBILE-PROC-INVOICE',
            'MOBILE-PROC-TRACKING',
            'MOBILE-PROC-VOICE'
        ]
    },
    '02400-safety': {
        'name': 'safety',
        'projects': [
            'MOBILE-SAFETY-INCIDENT',
            'MOBILE-SAFETY-HAZARD',
            'MOBILE-SAFETY-INSPECTION',
            'MOBILE-SAFETY-EMERGENCY',
            'MOBILE-SAFETY-PPE',
            'MOBILE-SAFETY-TRAINING',
            'MOBILE-SAFETY-CONTRACTOR',
            'MOBILE-SAFETY-HEALTH',
            'MOBILE-SAFETY-VOICE',
            'MOBILE-SAFETY-CAMERA'
        ]
    },
    '01700-logistics': {
        'name': 'logistics',
        'projects': [
            'MOBILE-LOGISTICS-DASHBOARD',
            'MOBILE-LOGISTICS-TRACKING',
            'MOBILE-LOGISTICS-DELIVERY',
            'MOBILE-LOGISTICS-CUSTOMS',
            'MOBILE-LOGISTICS-SCAN',
            'MOBILE-LOGISTICS-GPS',
            'MOBILE-LOGISTICS-SITE',
            'MOBILE-LOGISTICS-MATERIAL',
            'MOBILE-LOGISTICS-TRAFFIC',
            'MOBILE-LOGISTICS-DOCUMENTS',
            'MOBILE-LOGISTICS-DELAY',
            'MOBILE-LOGISTICS-OFFLINE'
        ]
    },
    '00850-civil-engineering': {
        'name': 'civil-engineering',
        'projects': [
            'MOBILE-CIVIL-SPEC',
            'MOBILE-CIVIL-INSPECTION',
            'MOBILE-CIVIL-SURVEY',
            'MOBILE-CIVIL-CALC',
            'MOBILE-CIVIL-UTILITIES',
            'MOBILE-CIVIL-STRUCTURAL',
            'MOBILE-CIVIL-TRANSPORT'
        ]
    },
    '00860-electrical-engineering': {
        'name': 'electrical-engineering',
        'projects': [
            'MOBILE-ELECTRICAL-SPEC',
            'MOBILE-ELECTRICAL-INSPECTION',
            'MOBILE-ELECTRICAL-SAFETY',
            'MOBILE-ELECTRICAL-CALC',
            'MOBILE-ELECTRICAL-SURVEY',
            'MOBILE-ELECTRICAL-LIGHTING',
            'MOBILE-ELECTRICAL-LOWVOLTAGE'
        ]
    }
}

def create_issue_frontmatter(issue_id, title, phase, priority, company, agent, discipline, project, dependencies=None, toolsets=None):
    """Create YAML frontmatter for an issue"""
    deps = dependencies or []
    tools = toolsets or ['file_tools', 'code_execution']

    frontmatter = f"""id: {issue_id}
title: {title}
phase: {phase}
status: open
priority: {priority}
company: {company}
agent: {agent}
discipline: {discipline}
project: {project}
platform: mobile
parent_issue: none
dependencies: {deps}
toolsets: {tools}
max_iterations: 50"""

    return frontmatter

def create_issue_content(issue_id, title, description, problem, changes, testing=None, skills=None, criteria=None):
    """Create the markdown content for an issue"""
    content = f"""# {issue_id}: {title}

## Description

{description}

## Problem

{problem}

## Required Changes

{changes}

"""
    if testing:
        content += f"""## Testing Strategy

{testing}

"""
    if skills:
        content += f"""## Required Skills

{skills}

"""
    if criteria:
        content += f"""## Acceptance Criteria

{criteria}
"""
    return content

def generate_procurement_issues():
    """Generate issues for procurement discipline"""
    discipline = '01900-procurement'
    discipline_name = 'procurement'

    # MOBILE-PROC-ORDER issues
    project = 'MOBILE-PROC-ORDER'
    issues_dir = f"docs-paperclip/disciplines/{discipline}/projects/mobile/{project}/issues"
    os.makedirs(issues_dir, exist_ok=True)

    # Issue 1: Redux State Management
    frontmatter = create_issue_frontmatter(
        'MOBILE-PROC-001', 'Create procurementSlice.ts for Redux State Management',
        '1 — Foundation', 'Critical', 'mobileforge-ai', 'mobileforge-ai-frontend-engineer',
        discipline, project
    )
    content = create_issue_content(
        'MOBILE-PROC-001', 'Create procurementSlice.ts for Redux State Management',
        'Create the Redux slice for procurement state management in the mobile app managing purchase orders, supplier selection, offline queue, and related procurement data.',
        'No procurement Redux slice exists. PurchaseOrderScreen.tsx uses in-memory state (useState, useReducer) which doesn\'t persist or support offline operations.',
        """Create `store/slices/procurementSlice.ts` with:
1. Purchase order state (orders, currentOrder, loading, error)
2. Supplier state (suppliers, selectedSupplier, supplierSearch)
3. Offline queue state (offlineQueue, isSyncing, lastSyncTime)
4. Reducers: createOrder, updateOrder, selectSupplier, loadSuppliers, addToOfflineQueue, syncOnline, clearError
5. Async thunks: fetchSuppliersAsync, saveOrderAsync, syncOfflineQueueAsync""",
        """- Unit test all reducers
- Unit test async thunks with mocked API
- Integration test with SQLite database
- Test offline queue behavior""",
        """- `mobile-development` (MobileForge)
- `redux-state-management` (MobileForge)
- `typescript` (DevForge)""",
        """- [ ] procurementSlice.ts created with all state types
- [ ] All reducers implemented and typed
- [ ] Async thunks implemented for API/DB operations
- [ ] Offline queue reducer handles pending operations
- [ ] Unit tests pass for all reducers
- [ ] Slice exported from store/slices/index.ts"""
    )

    with open(f"{issues_dir}/MOBILE-PROC-001-redux-state-management.md", 'w') as f:
        f.write(f"---\n{frontmatter}---\n\n{content}")

    # Issue 2: SQLite Database Integration
    frontmatter = create_issue_frontmatter(
        'MOBILE-PROC-002', 'Integrate PurchaseOrderScreen with SQLite Database',
        '1 — Foundation', 'Critical', 'mobileforge-ai', 'mobileforge-ai-backend-engineer',
        discipline, project, ['MOBILE-PROC-001']
    )
    content = create_issue_content(
        'MOBILE-PROC-002', 'Integrate PurchaseOrderScreen with SQLite Database',
        'Replace in-memory state management in PurchaseOrderScreen.tsx with SQLite database integration for persistent local storage.',
        'PurchaseOrderScreen.tsx (589 lines) currently uses in-memory state. Orders are lost on app restart and offline operations are not supported.',
        """1. Create procurement tables in services/database.ts:
   - `purchase_orders` (id, order_number, supplier_id, items, status, created_at, updated_at)
   - `purchase_order_items` (id, order_id, item_name, quantity, unit_price, total)
2. Create CRUD operations in services/procurementService.ts
3. Replace useState/useReducer with redux-thunk integration using SQLite
4. Implement load/save operations
5. Add error handling for database operations""",
        None,
        """- `mobile-development` (MobileForge)
- `database-integration` (InfraForge)
- `sqlite` (InfraForge)""",
        """- [ ] purchase_orders table created in SQLite
- [ ] purchase_order_items table created in SQLite
- [ ] CRUD operations in procurementService.ts
- [ ] PurchaseOrderScreen loads from SQLite on mount
- [ ] PurchaseOrderScreen saves to SQLite on submit
- [ ] Error handling for all database operations
- [ ] No more in-memory state for orders"""
    )

    with open(f"{issues_dir}/MOBILE-PROC-002-sqlite-database-integration.md", 'w') as f:
        f.write(f"---\n{frontmatter}---\n\n{content}")

    print(f"Generated procurement issues for {project}")

def main():
    """Main generation function"""
    print("=== Mobile Project Issue Generation ===")

    # Generate procurement issues (as example)
    generate_procurement_issues()

    print("=== Generation complete ===")
    print("Note: This is a template - extend for all disciplines and projects")

if __name__ == "__main__":
    main()
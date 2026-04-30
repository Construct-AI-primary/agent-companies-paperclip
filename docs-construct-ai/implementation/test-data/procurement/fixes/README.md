---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Test Data Fixes and Maintenance Scripts

This directory contains scripts for fixing and maintaining existing test data, addressing issues discovered during development and testing.

## Available Fixes

### Supplier Organization ID Fix
**File:** `fix_suppliers_organization_id.js`

**Purpose:** Updates approved suppliers that are missing organization_id values to have the correct organization context.

**Problem Solved:**
- Suppliers with `approval_status = 'approved'` but `organization_id = null`
- CreateOrderModal couldn't load suppliers due to missing organization context
- RLS policies blocked access to organization-less suppliers

**Usage:**
```bash
# Dry run (recommended first)
node fix_suppliers_organization_id.js --dry-run

# Production run
node fix_suppliers_organization_id.js

# Verbose output
node fix_suppliers_organization_id.js --verbose
```

**Results:** All approved suppliers now have proper organization_id for CreateOrderModal functionality.

## Adding New Fixes

### Template Structure
```javascript
#!/usr/bin/env node

/**
 * [Fix Name] - [Brief Description]
 *
 * Purpose: [Detailed explanation of what this fixes]
 * Tables: [Tables affected]
 * Dependencies: [Required data/setup]
 * Environment: Supabase with RLS
 * Re-runnable: Yes (idempotent)
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load environment from server/.env.dev
dotenv.config({ path: './server/.env.dev' });

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94',
  delayMs: 200,
  dryRun: process.argv.includes('--dry-run'),
  verbose: process.argv.includes('--verbose')
};

// Include standard validation, progress tracking, and error handling
// ... implementation ...
```

### Naming Convention
- `fix_[table]_[issue].js` - For table-specific fixes
- `fix_[workflow]_[problem].js` - For workflow-specific issues
- `migrate_[old]_[new].js` - For data migration fixes

### Documentation Requirements
- Clear problem description
- Step-by-step reproduction steps
- Expected results after fix
- Re-runnable safety (idempotent operations)

## Maintenance Guidelines

### Before Running Fixes
1. **Backup current data** if making destructive changes
2. **Run dry-run first** to validate scope of changes
3. **Check dependencies** - ensure required data exists
4. **Verify environment** - confirm correct organization context

### After Running Fixes
1. **Verify results** - confirm fix worked as expected
2. **Test functionality** - ensure affected features work
3. **Update documentation** - document the fix and its impact
4. **Clean up scripts** - move to archive if no longer needed

### Safety Measures
- **Always include dry-run mode**
- **Rate limiting** to prevent API throttling
- **Progress tracking** for long-running operations
- **Error recovery** with rollback capabilities
- **Organization scoping** for multi-tenant safety

This fixes directory ensures test data integrity and provides quick solutions for common data issues discovered during development.
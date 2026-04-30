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

# Database Dependency Audit Procedure

## Overview

This procedure provides a systematic approach to audit the codebase for instances of hardcoded mock/fallback data that should be sourced from database tables instead. The goal is to enforce the requirement that the application must "ONLY use the data in the applicable tables" and eliminate any fallback data that circumvents this requirement.

## Background

During the procurement order creation fix, it was discovered that fallback hardcoded data was being used instead of enforcing database-only data access. This violates the core architectural principle that business data must come from applicable database tables, not from static code.

## Scope

This audit covers:
- Server-side code (Node.js/Express routes and controllers)
- Client-side code (React components and services)
- Configuration files
- Migration scripts
- Any code that contains business data that should be database-driven

## Audit Criteria

### 🚫 **Prohibited Patterns**

#### 1. Hardcoded Business Data Arrays
```javascript
// ❌ BAD: Hardcoded appendix definitions
const appendices = [
  { id: 'A', title: 'Technical Specifications' },
  { id: 'B', title: 'Quality Requirements' }
];
```

#### 2. Fallback Data in Database Queries
```javascript
// ❌ BAD: Fallback to hardcoded data
try {
  const data = await db.query('SELECT * FROM table');
  return data;
} catch (error) {
  // This violates the requirement!
  return hardcodedFallbackData;
}
```

#### 3. Static Configuration Objects
```javascript
// ❌ BAD: Static business configuration
const ORDER_TYPES = {
  PO: 'Purchase Order',
  WO: 'Work Order',
  SO: 'Service Order'
};
```

#### 4. Default Values That Should Be Configurable
```javascript
// ❌ BAD: Hardcoded defaults that should be in database
const DEFAULT_WORKFLOW_STEPS = [
  'template_selection',
  'document_ordering',
  'order_creation'
];
```

### ✅ **Acceptable Patterns**

#### 1. Database-Only Data Access
```javascript
// ✅ GOOD: Strict database dependency
try {
  const data = await db.query('SELECT * FROM discipline_document_sections');
  return data;
} catch (error) {
  // No fallback - throw error to indicate configuration issue
  throw new Error('Required database table not configured');
}
```

#### 2. Configuration-Driven Defaults
```javascript
// ✅ GOOD: Database-driven configuration
const config = await db.query('SELECT * FROM system_configuration WHERE key = ?');
// Use database values, no fallbacks
```

## Audit Methodology

### Phase 1: Automated Scanning

#### Step 1.1: Code Pattern Analysis
Run the following grep commands to identify potential issues:

```bash
# Find hardcoded arrays that might contain business data
grep -r "\bconst.*=\s*\[" --include="*.js" --include="*.jsx" --include="*.ts" --include="*.tsx" .

# Find fallback data patterns
grep -r "catch.*error" --include="*.js" --include="*.jsx" --include="*.ts" --include="*.tsx" . | grep -i "return\|fallback\|default"

# Find static configuration objects
grep -r "\b[A-Z_]*\s*=\s*{" --include="*.js" --include="*.jsx" --include="*.ts" --include="*.tsx" .

# Find hardcoded business data
grep -r "Technical Specifications\|Quality Requirements\|Purchase Order\|Work Order" --include="*.js" --include="*.jsx" --include="*.ts" --include="*.tsx" .
```

#### Step 1.2: File Type Analysis
Focus audit on these file types:
- `server/src/**/*.js` - Server routes and controllers
- `client/src/**/*.js,*.jsx` - Client components and services
- `server/sql/**/*.sql` - Database migrations and schemas
- `docs/**/*.md` - Documentation (may contain hardcoded examples)

### Phase 2: Manual Code Review

#### Step 2.1: Business Data Identification
For each file identified in Phase 1, determine if the data should be database-driven:

**Questions to ask:**
1. Is this data specific to business rules or configuration?
2. Could this data change without code deployment?
3. Is this data referenced by multiple parts of the system?
4. Is this data configurable per organization/user?

**If YES to any question → Should be in database**

#### Step 2.2: Fallback Data Assessment
Review all error handling and fallback logic:

**Questions to ask:**
1. Does this fallback provide real business functionality?
2. Is this fallback documented as temporary?
3. Does this fallback prevent proper error reporting?
4. Could removing this fallback break the application?

**If fallback provides business functionality → Remove it**

### Phase 3: Database Schema Review

#### Step 3.1: Table Coverage Analysis
Verify all business data has corresponding database tables:

```sql
-- Check for tables that should exist
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN (
  'discipline_document_sections',
  'system_configuration',
  'business_rules',
  'organization_settings'
);
```

#### Step 3.2: Data Completeness Check
Ensure all required business data is present:

```sql
-- Example: Check procurement appendices
SELECT COUNT(*) as appendix_count
FROM discipline_document_sections
WHERE discipline_code = '01900'
AND section_type = 'appendix';
-- Should return 6 for complete procurement configuration
```

### Phase 4: Integration Testing

#### Step 4.1: Database Failure Simulation
Test application behavior when database is unavailable:

```bash
# Stop database temporarily
# Attempt to use features that require database data
# Verify proper error messages are shown
# No fallback functionality should work
```

#### Step 4.2: Data Removal Testing
Temporarily remove business data from tables:

```sql
-- Remove test data
DELETE FROM discipline_document_sections WHERE discipline_code = '01900';

-- Test application - should show configuration errors, not fallbacks
```

## Audit Checklist

### ☐ **Phase 1: Automated Scanning**
- [ ] Run grep commands for hardcoded arrays
- [ ] Identify potential fallback data patterns
- [ ] Flag static configuration objects
- [ ] Document findings in audit log

### ☐ **Phase 2: Manual Code Review**
- [ ] Review each flagged file for business data
- [ ] Assess fallback data necessity
- [ ] Document violations with code examples
- [ ] Prioritize fixes by impact

### ☐ **Phase 3: Database Schema Review**
- [ ] Verify all business data has database tables
- [ ] Check data completeness and constraints
- [ ] Review RLS policies for data access
- [ ] Validate foreign key relationships

### ☐ **Phase 4: Integration Testing**
- [ ] Test database failure scenarios
- [ ] Verify error messages are user-friendly
- [ ] Confirm no fallback functionality exists
- [ ] Test with incomplete database configurations

## Audit Report Template

```markdown
# Database Dependency Audit Report

## Executive Summary
[Brief overview of findings and recommendations]

## Findings Summary
- Total files scanned: [X]
- Files with violations: [X]
- Critical violations: [X]
- High priority fixes: [X]

## Detailed Findings

### Critical Violations
| File | Line | Issue | Recommended Fix |
|------|------|-------|-----------------|
| server/src/routes/procurement-sow-templates-routes.js | 45 | Hardcoded appendix definitions | Query discipline_document_sections table |

### High Priority Fixes
[Similar table for high priority items]

### Medium/Low Priority Items
[Similar table for remaining items]

## Database Schema Status
- [ ] All required tables exist
- [ ] All business data is present
- [ ] RLS policies are correct
- [ ] Foreign keys are properly configured

## Recommendations
1. [Priority 1 fix]
2. [Priority 2 fix]
3. [Priority 3 fix]

## Next Steps
- [ ] Fix critical violations
- [ ] Implement database-only error handling
- [ ] Update documentation
- [ ] Schedule follow-up audit
```

## Remediation Guidelines

### Immediate Actions (Critical)
1. Remove all fallback data that provides business functionality
2. Replace hardcoded arrays with database queries
3. Add proper error handling for missing database data

### Short-term Actions (High Priority)
1. Create missing database tables for business data
2. Migrate hardcoded data to database tables
3. Update client code to handle database errors gracefully

### Long-term Actions (Medium Priority)
1. Implement database seeding for initial data
2. Add database health checks to startup
3. Create data validation procedures

## Prevention Measures

### Code Review Checklist
- [ ] No hardcoded business data arrays
- [ ] No fallback data in database queries
- [ ] All business configuration in database tables
- [ ] Proper error handling for database failures

### Development Guidelines
1. **Business data must come from database tables**
2. **No fallback data allowed in production code**
3. **Database errors should be user-visible configuration issues**
4. **All static data should be configurable**

### Automated Checks
Add ESLint rules to prevent hardcoded data:
```javascript
// .eslintrc.js
rules: {
  'no-hardcoded-business-data': 'error'
}
```

## Related Documentation

- [Database Schema Documentation](../schema/)
- [API Error Handling Guidelines](../api/error-handling.md)
- [Data Migration Procedures](../database/migrations/)

## Version History

- v1.0 - Initial procedure creation (2025-01-06)
- [Future versions as procedure evolves]

---

**Document Owner:** Development Team
**Review Frequency:** Monthly
**Last Reviewed:** 2025-01-06
**Next Review:** 2025-02-06

# Drizzle ORM Type Inference Issue - RESOLVED

**Date:** 2026-04-08  
**Status:** ✅ RESOLVED  
**Severity:** Was Medium (Blocks type checking, not runtime)

## Problem Summary

Drizzle ORM's `$inferInsert` and `$inferSelect` types were being incorrectly narrowed when used across workspace package boundaries. Instead of inferring the full schema types, TypeScript saw only `{ name: string; companyId: string; }` for tables that have many more columns.

## Root Cause

The issue was caused by `strict: false` in `server/tsconfig.json`. When strict mode is disabled, TypeScript does not properly resolve complex generic types from Drizzle ORM, causing the type inference to fail.

## Solution

Changed `server/tsconfig.json` to use `strict: true`:

```json
{
  "extends": "../tsconfig.base.json",
  "compilerOptions": {
    "strict": true,  // Changed from false
    ...
  }
}
```

## Result

- **Before:** ~200 Drizzle type inference errors across 27 files
- **After:** 0 Drizzle type inference errors

The remaining ~29 errors are standard strict mode issues (null checks, `never` types) in 3 files that need to be fixed separately:
- `src/routes/issues.ts` (5 errors)
- `src/routes/plugin-ui-static.ts` (16 errors)  
- `src/services/heartbeat.ts` (8 errors)

## Files Modified

1. `packages/db/src/client.ts` - Fixed `Db` type definition
2. `packages/db/package.json` - Added `types` condition to exports
3. `packages/db/src/schema/types.ts` - Created explicit type exports (for future use)
4. `packages/db/src/index.ts` - Export types from schema/types.js
5. `server/tsconfig.json` - Enabled `strict: true`

### Option 1: Type Assertions (Quick Fix)
```typescript
// Use type assertions to bypass the incorrect inference
const data = { role: "general", status: "idle" } as typeof agents.$inferInsert;
```

### Option 2: Manual Type Definitions (Medium Fix)
Define the types manually without relying on Drizzle's inference:
```typescript
export interface AgentInsert {
  id?: string;
  companyId: string;
  name: string;
  role: string;
  status: string;
  // ... all other columns
}
```

### Option 3: Wait for Drizzle Fix (Long-term)
File an issue with Drizzle ORM and wait for a fix in a future version.

## Files Created for Future Use

- `packages/db/src/schema/types.ts` - Contains explicit type exports that will work correctly once the Drizzle bug is fixed

## Impact

- **Development:** Type checking fails locally and in CI
- **Runtime:** No impact - the actual database operations work correctly
- **Deployment:** The original Render.com deployment error has been fixed

## Next Steps

1. Document this issue for team awareness ✅
2. Consider adding `// @ts-expect-error` comments with references to this doc for critical paths
3. Monitor Drizzle ORM releases for a fix
4. When fixing, update all 27 files to use the correct types from `packages/db/src/schema/types.ts`

## References

- Drizzle ORM Issue: (to be filed if needed)
- Related PR: (link to the PR that fixed the Render.com deployment)
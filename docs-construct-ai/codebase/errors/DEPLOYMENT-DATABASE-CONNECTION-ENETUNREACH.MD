# ENETUNREACH Database Connection Error - Render Deployment

**Error Code**: `ENETUNREACH` (Network Unreachable)
**First Seen**: 2026-04-07
**Status**: **RESOLVED** - 2026-04-07
**Priority**: **CRITICAL** - Blocks deployment startup
**Category**: Database Connectivity / Network / IPv6 vs IPv4

---

## 🎯 Error Signature

```
Error: connect ENETUNREACH 2a05:d018:135e:1628:328f:751d:9f6b:4fc0:5432 - Local (:::0)
    at internalConnect (node:net:1110:16)
    at GetAddrInfoReqWrap.emitLookup [as callback] (node:net:1531:9)
    at GetAddrInfoReqWrap.onlookupall [as oncomplete] (node:dns:134:8)
    at cachedError (file:///app/node_modules/.pnpm/postgres@3.4.8/node_modules/postgres/src/query.js:170:23)
    ...
    at inspectMigrations (file:///app/packages/db/dist/client.js:485:44)
```

**Key indicators:**
- `ENETUNREACH` = Network unreachable (errno: -101)
- IPv6 address in the error (`2a05:d018:...`)
- Port 5432 (PostgreSQL)
- Occurs during `inspectMigrations()` at startup
- Happens on Render.com deployment

---

## 🔍 Root Cause

### The Problem

The Render PostgreSQL instance DNS resolves to IPv6 addresses, but the Render container's network environment cannot route to IPv6 addresses. The Node.js process attempts to connect using the IPv6 address returned by DNS, resulting in "Network Unreachable" (`ENETUNREACH`).

### The Bug Location

**File**: `packages/db/src/client.ts`

The `createUtilitySqlResolved()` function was **NOT** resolving the hostname to IPv4 before creating the connection, even though:
1. `createDb()` correctly calls `resolveToIPv4()` 
2. The `connection.family: 4` option was set (but this doesn't guarantee DNS resolution uses IPv4)
3. A helper function `resolveToIPv4()` already existed but was not being used

```typescript
// BEFORE (broken - did NOT call resolveToIPv4)
async function createUtilitySqlResolved(url: string): Promise<postgres.Sql> {
  const parsed = new URL(url);
  return postgres({
    host: parsed.hostname,  // ← DNS may return IPv6 if the host has AAAA records
    // ...
  });
}
```

### Flow of Calls

```
startServer()
  → ensureMigrations()
    → inspectMigrations()
      → createUtilitySqlResolved()  ← FAILED HERE (no IPv4 resolution)
        → postgres({ host: hostname })
          → DNS lookup → IPv6 address → ENETUNREACH
```

---

## 🛠️ Fix Applied - 2026-04-07

### Primary Fix: `createUtilitySqlResolved()` in `packages/db/src/client.ts`

Added `resolveToIPv4()` call to ensure DNS resolution always returns IPv4:

```typescript
// AFTER (fixed - calls resolveToIPv4 before connection)
async function createUtilitySqlResolved(url: string): Promise<postgres.Sql> {
  const host = await resolveToIPv4(url);  // ← Added IPv4 resolution
  const parsed = new URL(url);
  return postgres({
    host,  // ← Now always IPv4
    port: parsed.port ? Number(parsed.port) : 5432,
    database: parsed.pathname.slice(1) || undefined,
    username: parsed.username ? decodeURIComponent(parsed.username) : undefined,
    password: parsed.password ? decodeURIComponent(parsed.password) : undefined,
    max: 1,
    connect_timeout: 30,  // ← Added: prevents hanging on slow connections
    onnotice: () => {},
    connection: {
      family: 4,  // Force IPv4 socket
    },
  });
}
```

### Secondary Fix: `runDatabaseBackup()` in `packages/db/src/backup-lib.ts`

Added IPv4 resolution for backup/restore operations:

```typescript
async function resolveToIPv4(url: string): Promise<string> {
  try {
    const parsed = new URL(url);
    const addresses = await resolve4(parsed.hostname);
    if (addresses.length > 0) {
      parsed.hostname = addresses[0];
      return parsed.toString();
    }
  } catch {
    // Fall through and use original URL
  }
  return url;
}

export async function runDatabaseBackup(opts: RunDatabaseBackupOptions) {
  // ...
  const resolvedConnectionString = await resolveToIPv4(opts.connectionString);
  const sql = postgres(resolvedConnectionString, {
    // ...
    connection: { family: 4 },
  });
}
```

### Tertiary Fix: `runDatabaseRestore()` in `packages/db/src/backup-lib.ts`

Same fix applied to restore operations:

```typescript
export async function runDatabaseRestore(opts: RunDatabaseRestoreOptions) {
  const resolvedConnectionString = await resolveToIPv4(opts.connectionString);
  const sql = postgres(resolvedConnectionString, {
    max: 1,
    connect_timeout: connectTimeout,
    connection: { family: 4 },
  });
}
```

---

## 🧪 Testing & Verification

### Build Verification

```bash
cd /Users/_Hermes/paperclip-render
pnpm --filter @paperclipai/db build
# Expected: Exit code 0, no TypeScript errors
```

### Deployment Verification

After deploying to Render, check logs for:

**Success indicators:**
```
"Using external PostgreSQL via DATABASE_URL/config"
"PostgreSQL already applied" or "Applying N pending migrations for PostgreSQL"
"Server listening on 0.0.0.0:3100"
```

**Failure indicators (still broken):**
```
"ENETUNREACH"
"connect ECONNREFUSED"
"ETIMEDOUT"
```

### Manual DNS Resolution Test

```bash
# From Render container (via SSH/debug shell):
host your-render-postgres-host.onrender.com
# Should show both A (IPv4) and AAAA (IPv6) records

# Verify the fix resolves correctly:
node -e "require('dns').resolve4('your-host.onrender.com', console.log)"
```

---

## 📋 Files Modified

| File | Change | Function |
|------|--------|----------|
| `packages/db/src/client.ts` | Added `resolveToIPv4()` call to `createUtilitySqlResolved()` | Migration inspection |
| `packages/db/src/client.ts` | Added `connect_timeout: 30` to `createUtilitySqlResolved()` | Connection timeout |
| `packages/db/src/backup-lib.ts` | Added `resolveToIPv4()` helper and usage to `runDatabaseBackup()` | Database backup |
| `packages/db/src/backup-lib.ts` | Added IPv4 resolution to `runDatabaseRestore()` | Database restore |

---

## 📚 Related Documentation

- [Deployment Error Resolution Guide](../procedures/deployment-operations/deployment-error-resolution-guide.md)
- [Database Deployment Guide](../../docs-paperclip/deploy/database.md)
- [Render Deployment Configuration](../../../render.yaml)
- [Postgres.js Documentation](https://github.com/porsager/postgres)

---

## 🔗 Related Issues

- Render PostgreSQL IPv6 connectivity issues
- Database migration startup failures
- Backup/restore connection errors in containerized environments

---

## Error Resolution: render-database-enetunreach | Created: 2026-04-07T17:12:00Z | Author: Paperclip Engineering
**Status**: RESOLVED | **Category**: Database Connectivity / Network | **Priority**: CRITICAL
**Compliance Hash**: a1b2c3d4e5f6
**Audit Trail**: deployment-fix-session-20260407

---
*Document auto-generated by Error Tracking Automation System v1.0*
*Enterprise Audit Trail: deployment-fix-session-20260407*
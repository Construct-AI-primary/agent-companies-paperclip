---
name: supabase-testing-infraforge
description: Supabase connectivity testing, RLS policy validation, database upsert operations, real-time subscription testing
category: infraforge-testing
division: Infrastructure Testing
role: Supabase Testing Specialist
last_updated: 2026-04-05
---

# Supabase Testing Specialist

## Overview

You are the **Supabase Testing Specialist** for InfraForge AI, specializing in testing Supabase connectivity, Row Level Security (RLS) policies, database upsert operations, real-time subscriptions, and query performance. You ensure that the database layer is reliable, secure, and performant for all application operations.

## When to Use

Use this skill when:
1. **Testing database connectivity** — connection established, queries execute, timeouts respected
2. **Validating RLS policies** — users can only access their own data, cross-company isolation enforced
3. **Testing upsert operations** — insert/update operations work correctly across all tables
4. **Testing real-time subscriptions** — Supabase real-time delivers updates to subscribed clients
5. **Validating query performance** — queries return within expected time limits
6. **Executing production testing Phase 1** — tier1, database-upsert-testing documents

**Don't use when:**
- Testing application-level data display (use `browser-ui-testing-qualityforge`)
- Testing authentication flows (use `auth-login-testing-qualityforge`)
- Testing database schema design (use `database-schema-management` shared skill)

## SQL Generation Workflow

When generating complex SQL scripts that involve:
- Schema constraints and foreign key relationships
- Multi-table operations with referential integrity
- Complex subqueries and joins
- Constraint validation requirements

**Route to Database Agent** (`database-infraforge-database-infrastructure`) for validation before execution.

### Workflow Steps:
1. **Nimbus** generates initial SQL based on requirements
2. **Nimbus routes** complex SQL to Database agent for constraint validation
3. **Database agent** validates against `/docs-paperclip/schema/constraints/` files
4. **Database agent** either approves or provides corrections
5. **Final validated SQL** gets executed

### When to Route:
- ✅ Multi-table INSERT/UPDATE operations
- ✅ Foreign key relationship management
- ✅ Unique constraint validation
- ✅ Complex subqueries with dependencies
- ✅ Schema constraint checking

## Core Procedures

### Step 1: Connectivity Testing

**Actions:**
- Verify Supabase client initializes correctly
- Test query execution with valid and invalid queries
- Test connection behavior under various network conditions
- Validate connection pooling behavior

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| CONN-01 | Valid Supabase URL and key | Connection succeeds, health check passes |
| CONN-02 | Invalid API key | Connection fails with auth error |
| CONN-03 | Network disconnected | Connection attempt times out, error logged |
| CONN-04 | Connection recovered after network restore | Reconnection succeeds |
| CONN-05 | Multiple concurrent queries | All queries execute independently |

**Checklist:**
- [ ] Supabase client initializes without error
- [ ] Health check query returns expected result
- [ ] Invalid credentials rejected promptly
- [ ] Connection pool configured and respected
- [ ] Retry logic configured (retries, backoff)
- [ ] Connection errors logged with context

**Test Template:**
```typescript
import { createClient } from '@supabase/supabase-js';

async function testConnectivity(supabaseUrl: string, supabaseKey: string) {
  const supabase = createClient(supabaseUrl, supabaseKey);
  
  // Health check
  const { data, error } = await supabase.from('health_check').select('*').limit(1);
  
  if (error) {
    console.error('Connection failed:', error.message);
    return { success: false, error: error.message };
  }
  
  return { success: true, data };
}
```

### Step 2: RLS Policy Testing

**Actions:**
- Test user access to own data (should succeed)
- Test user access to other user's data (should fail)
- Test cross-company data access (should fail)
- Test admin/service role bypass (should succeed with proper role)
- Test anonymous access (should fail or return limited data per policy)

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| RLS-01 | User queries own company data | Access granted |
| RLS-02 | User queries another company's data | Access denied (403/empty result) |
| RLS-03 | User queries shared public data | Access granted |
| RLS-04 | Service role queries all data | Access granted |
| RLS-05 | INSERT own company data | Success |
| RLS-06 | INSERT another company's data | Access denied |
| RLS-07 | UPDATE own company data | Success |
| RLS-08 | UPDATE another company's data | Access denied |
| RLS-09 | DELETE own company data | Success |
| RLS-10 | DELETE another company's data | Access denied |

**Checklist:**
- [ ] RLS policies enabled on all data tables
- [ ] Company_id column used for company scoping
- [ ] Policies cover SELECT, INSERT, UPDATE, DELETE
- [ ] Admin role has appropriate bypass configured
- [ ] Anonymous role has restricted access
- [ ] Policies tested with Supabase SQL console

### Step 3: Upsert Operation Testing

**Actions:**
- Test upsert on all discipline tables
- Test conflict resolution (ON CONFLICT DO UPDATE)
- Test upsert with partial data (missing optional fields)
- Test upsert with invalid data (constraint violations)

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| UPS-01 | Upsert new record | Record inserted |
| UPS-02 | Upsert existing record with same key | Record updated |
| UPS-03 | Upsert with unique constraint violation | Conflict handled per ON CONFLICT clause |
| UPS-04 | Upsert with foreign key violation | Error returned with FK details |
| UPS-05 | Upsert with NOT NULL violation | Error returned with column name |
| UPS-06 | Upsert with check constraint violation | Error returned with constraint details |
| UPS-07 | Bulk upsert (multiple records) | All inserted/updated atomically |
| UPS-08 | Upsert with RLS enforced | Only company-scoped records affected |

**Checklist:**
- [ ] Upsert operations respect unique constraints
- [ ] Missing optional fields use default values
- [ ] Constraint violations return clear error messages
- [ ] Bulk upserts are atomic (all or nothing)
- [ ] Upsert results reflect correct operation (insert vs update)
- [ ] Returning clause works (returns inserted/updated record)

### Step 4: Real-Time Subscription Testing

**Actions:**
- Test subscription to table changes
- Test subscription filtering
- Test subscription disconnect and reconnect
- Test subscription performance under high change rate

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| RT-01 | Subscribe to INSERT events | New insert triggers event |
| RT-02 | Subscribe to UPDATE events | Record update triggers event |
| RT-03 | Subscribe to DELETE events | Record delete triggers event |
| RT-04 | Subscribe with filter (company_id) | Only company events delivered |
| RT-05 | Disconnect during change | Reconnect delivers missed changes |
| RT-06 | High change rate | All events delivered (may batch) |

**Checklist:**
- [ ] Subscription established successfully
- [ ] Events match filter criteria
- [ ] Latency within SLA (<100ms)
- [ ] Disconnect/reconnect handled
- [ ] Missed changes detected on reconnect
- [ ] Unsubscription cleans up resources

### Step 5: Query Performance Testing

**Actions:**
- Test query response times for common operations
- Test query performance with large datasets
- Identify slow queries and recommend optimizations
- Test index usage

**Test Cases:**
| Test ID | Scenario | Expected Result |
|---------|----------|-----------------|
| PERF-01 | Single record SELECT by ID | <50ms |
| PERF-02 | List query with pagination | <200ms |
| PERF-03 | INSERT single record | <100ms |
| PERF-04 | Upsert single record | <150ms |
| PERF-05 | Bulk INSERT (100 records) | <2s |
| PERF-06 | Complex join query | <500ms |

**Checklist:**
- [ ] All queries meet SLA thresholds
- [ ] Indexes used correctly (EXPLAIN ANALYZE)
- [ ] No full table scans on large tables
- [ ] Query plans consistent (no regression)
- [ ] Connection pool not saturated
- [ ] Slow query log configured

## Production Testing Execution Mapping

| Doc # | Document | Coverage |
|-------|----------|----------|
| 1 | `tier1-testing.md` | **Primary** — DB connectivity, RLS validation |
| 4 | `database-upsert-testing.md` | **Primary** — Upsert operations on all tables |
| 12 | `chatbot-production-testing.md` | Chatbot session persistence |
| 14 | `HITL_Production_Testing_Hermes_Agent.md` | HITL state persistence |

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Connectivity Success | 100% | Connections established |
| RLS Compliance | 100% | Zero cross-company data access |
| Upsert Success Rate | >99% | Upserts completed without error |
| Query SLA Compliance | >95% | Queries within SLA |
| Real-Time Latency | <100ms p95 | Event delivery time |

## Error Handling

### Error 1: RLS Policy Blocks Valid Request
**Resolution:**
1. Check RLS policy definition for the affected table
2. Verify company_id in request matches authenticated user's company
3. Check if policy has been recently changed
4. Test with Supabase SQL console using same credentials

### Error 2: Upsert Fails with Constraint Error
**Resolution:**
1. Check which constraint is violated
2. Verify data matches expected schema
3. Check for race conditions with concurrent requests
4. Review upsert ON CONFLICT clause

## Cross-Team Integration

- **auth-login-testing-qualityforge**: Auth context for RLS testing
- **database-schema-management** (shared): Schema and constraint validation
- **chatbot-integration-testing-promptforge**: Chat session persistence
- **hitl-workflow-testing-qualityforge**: HITL state persistence
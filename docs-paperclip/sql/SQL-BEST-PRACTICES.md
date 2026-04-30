# SQL Best Practices - Type Handling Guide

## Overview

This document outlines best practices for handling UUID vs TEXT comparisons in Paperclip SQL queries to prevent recurring type mismatch errors.

---

## Key Finding: Inconsistent Type Design

The Paperclip database has **inconsistent foreign key types** across tables:

| Table | Column | Type | Lookup Method |
|-------|--------|------|--------------|
| `agents` | `id` | UUID | Direct UUID comparison |
| `agent_api_keys` | `agent_id` | UUID | JOIN with `agents.id` |
| `agent_models` | `agent_id` | TEXT | Use `agents.name` |
| `activity_log` | `agent_id` | UUID | JOIN with `agents.id` |

**Critical Rule**: Always check which table's `agent_id` you're working with before writing SQL.

---

## Standard Patterns

### Pattern 1: Working with `agent_api_keys` (UUID)

```sql
-- CORRECT: agent_api_keys.agent_id is UUID
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id

-- WRONG: Will cause type mismatch error
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id::text
```

### Pattern 2: Working with `agent_models` (TEXT)

```sql
-- CORRECT: agent_models.agent_id is TEXT (agent name)
SELECT * FROM agent_models WHERE agent_id = 'validator-qualityforge'

-- WRONG: Will cause type mismatch error
SELECT * FROM agent_models WHERE agent_id::uuid = 'some-uuid'
```

### Pattern 3: Looking up by agent name

```sql
-- CORRECT: Always use agents.name for name-based lookups
SELECT id FROM agents WHERE name = 'validator-qualityforge'

-- CORRECT: Use name in JOINs
JOIN agent_models am ON a.name = am.agent_id
```

### Pattern 4: Mixed type handling

When you need both UUID and TEXT access:

```sql
-- CORRECT: Use subquery with proper type
SELECT a.id 
FROM agents a
JOIN agent_models am ON a.name = am.agent_id  -- TEXT comparison
JOIN agent_api_keys aak ON a.id = aak.agent_id  -- UUID comparison
WHERE a.name = 'validator-qualityforge'
```

---

## Common Errors and Fixes

### Error 1: `operator does not exist: character varying = uuid`

**Cause**: Comparing TEXT column with UUID value
**Fix**: 
```sql
-- Before (WRONG)
WHERE agent_id = (SELECT id FROM agents WHERE title = 'contentforge-ai-SEOStrategist')

-- After (CORRECT) - check which table
WHERE agent_id = (SELECT id FROM agents WHERE name = 'contentforge-ai-SEOStrategist')::uuid
```

### Error 2: `operator does not exist: uuid = text`

**Cause**: Comparing UUID column with TEXT value
**Fix**:
```sql
-- Before (WRONG)
WHERE agent_id = 'some-agent-name'

-- After (CORRECT) - use agents table
WHERE agent_id = (SELECT id FROM agents WHERE name = 'some-agent-name')
```

### Error 3: JOIN type mismatch

**Cause**: JOINing columns of different types
**Fix**:
```sql
-- Before (WRONG)
JOIN agent_api_keys aak ON am.agent_id = aak.agent_id

-- After (CORRECT) - use agents table as intermediary
JOIN agents a ON a.name = am.agent_id
JOIN agent_api_keys aak ON a.id = aak.agent_id
```

---

## Validation Query: Check Column Types

Run this before writing any SQL:

```sql
-- Check all agent-related columns and their types
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND (
    (table_name = 'agents' AND column_name = 'id')
    OR (table_name LIKE 'agent_%' AND column_name LIKE '%_id')
    OR (column_name IN ('agent_id', 'actor_id', 'entity_id'))
  )
ORDER BY table_name, ordinal_position;
```

---

## SQL Template Checklist

Before running any SQL that touches agents:

- [ ] Check which table you're modifying
- [ ] Identify the type of the foreign key column
- [ ] If `agent_models`: use TEXT (agent name)
- [ ] If `agent_api_keys`: use UUID
- [ ] If `activity_log`: use UUID
- [ ] Always prefer looking up via `agents` table first

---

## Reference: Table Type Summary

### agents
| Column | Type |
|--------|------|
| id | UUID |
| company_id | UUID |
| name | TEXT (agent slug) |
| reports_to | UUID |

### agent_api_keys
| Column | Type |
|--------|------|
| id | UUID |
| agent_id | UUID |
| company_id | UUID |

### agent_models
| Column | Type |
|--------|------|
| id | UUID |
| agent_id | TEXT (agent name) |
| model_id | TEXT |
| company_id | UUID |

### activity_log
| Column | Type |
|--------|------|
| id | UUID |
| agent_id | UUID |
| actor_id | UUID |
| entity_id | UUID |
| company_id | UUID |

---

**Last Updated**: 2026-04-25
**Version**: 1.0

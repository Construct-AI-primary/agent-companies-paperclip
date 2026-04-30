# Agent Models Table Schema

## Overview
The `agent_models` table stores AI model assignments for agents in the Paperclip ecosystem.

## Table Structure

### Core Fields
```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
agent_id TEXT NOT NULL
model_id TEXT NOT NULL
assignment_type TEXT NOT NULL DEFAULT 'primary'
priority INTEGER NOT NULL DEFAULT 1
temperature NUMERIC
max_tokens INTEGER
assigned_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
assigned_by TEXT
reason TEXT
is_active BOOLEAN DEFAULT true
```

### Column Details

| Column | Type | Required | Default | Notes |
|--------|------|----------|---------|-------|
| id | uuid | YES | gen_random_uuid() | Primary key |
| agent_id | text | YES | - | References agents.name (not id) |
| model_id | text | YES | - | OpenRouter model identifier (e.g., z-ai/glm-4-flash) |
| assignment_type | text | YES | 'primary' | 'primary', 'fallback', 'experimental' |
| priority | integer | YES | 1 | Lower = higher priority |
| temperature | numeric | NO | NULL | 0.0 - 2.0 range |
| max_tokens | integer | NO | NULL | Max response tokens |
| assigned_at | timestamptz | YES | NOW() | Auto-generated |
| assigned_by | text | NO | NULL | 'system' or agent name |
| reason | text | NO | NULL | Assignment justification |
| is_active | boolean | YES | true | Active status |

## Unique Constraints

### Primary Constraint: (agent_id, model_id)
```sql
-- UNIQUE constraint on agent_id + model_id
-- This means you CANNOT insert duplicate (agent_id, model_id) combinations
-- But you CAN have multiple assignment_types for the same agent with different model_ids
```

### Example Valid Inserts
```sql
-- Insert primary model
INSERT INTO agent_models (agent_id, model_id, assignment_type, priority, ...)
VALUES ('my-agent', 'z-ai/glm-4-flash', 'primary', 1, ...);

-- Insert fallback model (different model_id)
INSERT INTO agent_models (agent_id, model_id, assignment_type, priority, ...)
VALUES ('my-agent', 'google/gemini-2.0-flash', 'fallback', 2, ...);
```

### Example INVALID Insert (will fail)
```sql
-- Cannot insert same model twice for same agent
INSERT INTO agent_models (agent_id, model_id, assignment_type, ...)
VALUES ('my-agent', 'z-ai/glm-4-flash', 'primary', 1, ...);
-- ERROR: duplicate key value violates unique constraint
```

## ON CONFLICT Patterns

### Correct Pattern (using agent_id, model_id)
```sql
INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority, temperature, max_tokens,
  assigned_at, assigned_by, reason, is_active
) VALUES (
  'paperclipforge-ai-org-research-folder-creator',
  'z-ai/glm-4-flash',
  'primary',
  1,
  0.7,
  8192,
  NOW(),
  'system',
  'Research and documentation tasks',
  true
) ON CONFLICT (agent_id, model_id) DO NOTHING;
```

### Alternative: Using DO UPDATE
```sql
INSERT INTO agent_models (
  agent_id, model_id, assignment_type, priority, temperature, max_tokens,
  assigned_at, assigned_by, reason, is_active
) VALUES (
  'paperclipforge-ai-org-research-folder-creator',
  'z-ai/glm-4-flash',
  'primary',
  1,
  0.7,
  8192,
  NOW(),
  'system',
  'Research and documentation tasks',
  true
) ON CONFLICT (agent_id, model_id) DO UPDATE SET
  priority = EXCLUDED.priority,
  temperature = EXCLUDED.temperature,
  max_tokens = EXCLUDED.max_tokens,
  assigned_at = NOW(),
  is_active = EXCLUDED.is_active;
```

## Query Examples

### Get all models for an agent
```sql
SELECT agent_id, model_id, assignment_type, priority, is_active
FROM agent_models
WHERE agent_id = 'my-agent'
ORDER BY priority;
```

### Get active primary model
```sql
SELECT model_id
FROM agent_models
WHERE agent_id = 'my-agent'
  AND assignment_type = 'primary'
  AND is_active = true
ORDER BY priority
LIMIT 1;
```

### Update model assignment
```sql
UPDATE agent_models
SET temperature = 0.7,
    max_tokens = 8192,
    assigned_at = NOW()
WHERE agent_id = 'my-agent'
  AND model_id = 'z-ai/glm-4-flash'
  AND assignment_type = 'primary';
```

### Deactivate a model
```sql
UPDATE agent_models
SET is_active = false
WHERE agent_id = 'my-agent'
  AND model_id = 'old-model-id';
```

## Common Errors

### Error: 42P10 - No unique or exclusion constraint matching ON CONFLICT
```
ERROR: 42P10: there is no unique or exclusion constraint matching the ON CONFLICT specification
```
**Cause:** The columns specified in ON CONFLICT don't match any unique constraint
**Solution:** Use `ON CONFLICT (agent_id, model_id)` - this matches the actual unique constraint

### Error: 23505 - Duplicate key value
```
ERROR: 23505: duplicate key value violates unique constraint
```
**Cause:** Trying to insert duplicate (agent_id, model_id) combination
**Solution:** Use `ON CONFLICT (agent_id, model_id) DO NOTHING` or `DO UPDATE`

## Relationship to Agents Table

- `agent_models.agent_id` → `agents.name` (references name, NOT id)
- This allows model assignments to be keyed by agent name for readability

---

**Schema Version**: 1.0
**Last Updated**: 2026-04-20
**Related Tables**: agents

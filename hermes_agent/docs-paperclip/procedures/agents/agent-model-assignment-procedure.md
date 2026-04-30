# Agent Model Assignment Procedure

This procedure documents the process for assigning AI models to agents in Paperclip for proper model routing and performance tracking.

## Overview

Every agent in Paperclip must have model assignments in the `agent_models` table to ensure proper AI model routing, cost tracking, and performance optimization. This procedure covers model selection guidelines, assignment SQL, and validation queries.

## Prerequisites

- Agent must already exist in the `agents` table
- Access to the Paperclip database (Supabase SQL Editor or direct PostgreSQL connection)
- Understanding of the `agent_models` table schema

## Database Schema

### Agent Models Table

The `agent_models` table stores model assignments for agents:

```sql
CREATE TABLE agent_models (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  agent_id TEXT NOT NULL,  -- References agents.name (not agents.id)
  model_id TEXT NOT NULL,
  assignment_type TEXT NOT NULL DEFAULT 'primary',  -- 'primary', 'fallback', 'specialized'
  priority INTEGER NOT NULL DEFAULT 1,
  temperature DECIMAL(3,2),
  max_tokens INTEGER,
  assigned_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  assigned_by TEXT NOT NULL,
  reason TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);
```

**Important Notes:**
- `agent_id` references `agents.name` (not `agents.id`)
- `assignment_type` can be 'primary', 'fallback', or 'specialized'
- `priority` determines order when multiple models are available
- `is_active` controls whether the assignment is currently used

## Model Selection Guidelines

Select the appropriate GLM model based on the agent's primary task complexity and requirements:

| Task Complexity | GLM Model Selected | Reasoning |
|----------------|-------------------|-----------|
| Very Simple Tasks | GLM-3-Turbo | Most cost-effective for basic queries ($0.30-0.70) |
| General Conversation | GLM-3-Turbo | Cost-effective for chat and simple interactions ($0.30-0.70) |
| Simple Coding | GLM-4-Plus | Good balance for straightforward code ($1.00-2.00) |
| Medium Coding | GLM-4-Plus | Handles API integration, etc. ($1.00-2.00) |
| Complex Coding | GLM-5.1 ⭐ | Advanced reasoning for complex tasks ($1.50-3.00) |
| Expert Coding | Qwen-3.6 ⭐ | Maximum capability for system design ($2.00-4.00) |
| Creative Writing | GLM-4-Plus | Good for content generation ($1.00-2.00) |
| Data Analysis | GLM-5.1 ⭐ | Strong analytical reasoning capabilities ($1.50-3.00) |
| Research & Learning | GLM-5.1 ⭐ | Deep understanding for explanations ($1.50-3.00) |
| Chinese Language | GLM-5.1 ⭐ | Native Chinese language optimization ($1.50-3.00) |

### Model Selection Tips

- **GLM-3-Turbo**: Best for cost-sensitive, simple tasks
- **GLM-4-Plus**: Balanced performance for most coding and content tasks
- **GLM-5.1 ⭐**: Default choice for complex reasoning and general use
- **Qwen-3.6 ⭐**: Specialized for expert-level coding and data analysis

## Procedure Steps

### Step 1: Assess Agent Requirements

Before assigning a model, evaluate the agent's primary tasks:

1. **Review agent capabilities** from the `agents` table
2. **Check agent role and title** for complexity indicators
3. **Consider company specialization** and task requirements
4. **Evaluate cost vs. performance** trade-offs

### Step 2: Select Appropriate Model

Using the guidelines above, select the most appropriate model for the agent's primary task complexity.

### Step 3: Execute Model Assignment

Insert the model assignment into the `agent_models` table:

```sql
-- Add primary model assignment for new agent
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
) VALUES (
  '<agent_name>',  -- Must match agent name exactly
  'anthropic/claude-3.5-sonnet',  -- Default model (see guidelines above for alternatives)
  'primary',
  1,
  0.7,  -- Standard temperature
  4096, -- Standard token limit
  NOW(),
  'system',  -- Or your username
  'Default model assignment for new agent - adjust model based on task complexity',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;
```

### Step 4: Add Fallback Models (Optional)

For production agents, consider adding fallback models:

```sql
-- Add fallback model for reliability
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
) VALUES (
  '<agent_name>',
  'openai/gpt-4o-mini',  -- Cost-effective fallback
  'fallback',
  2,
  0.7,
  4096,
  NOW(),
  'system',
  'Fallback model for reliability when primary model is unavailable',
  true
) ON CONFLICT (agent_id, assignment_type) DO NOTHING;
```

### Step 5: Verify Assignment

Run validation queries to confirm successful assignment:

```sql
-- Check specific agent model assignments
SELECT am.agent_id, am.model_id, am.assignment_type, am.priority, am.is_active
FROM agent_models am
WHERE am.agent_id = '<agent_name>'
ORDER BY am.priority;

-- Verify agent exists and has primary model
SELECT a.name, a.role, a.title, am.model_id, am.assignment_type
FROM agents a
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE a.name = '<agent_name>';
```

## Bulk Assignment Examples

### Assign Models to All Agents in a Company

```sql
-- Assign GLM-4-Plus to all engineers in a company
INSERT INTO agent_models (
  agent_id,
  model_id,
  assignment_type,
  priority,
  temperature,
  max_tokens,
  assigned_at,
  assigned_by,
  reason,
  is_active
)
SELECT
  a.name,
  'anthropic/claude-3.5-sonnet',
  'primary',
  1,
  0.7,
  4096,
  NOW(),
  'system',
  'Bulk assignment for engineering agents',
  true
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'DevForge AI'
  AND a.role = 'engineer'
  AND NOT EXISTS (
    SELECT 1 FROM agent_models am
    WHERE am.agent_id = a.name AND am.assignment_type = 'primary'
  );
```

### Update Existing Assignments

```sql
-- Update model for agents currently using old model
UPDATE agent_models
SET
  model_id = 'anthropic/claude-3.5-sonnet',
  reason = 'Updated to newer model version',
  updated_at = NOW()
WHERE model_id = 'anthropic/claude-3-haiku'
  AND assignment_type = 'primary';
```

## Validation and Monitoring

### Check for Missing Assignments

```sql
-- Find agents without primary model assignments
SELECT a.name, a.company_id, c.name as company_name, a.role, a.title
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_models am ON a.name = am.agent_id AND am.assignment_type = 'primary'
WHERE am.id IS NULL
ORDER BY c.name, a.name;
```

### Monitor Model Usage

```sql
-- Check model usage by agent and company
SELECT
  c.name as company_name,
  a.name as agent_name,
  am.model_id,
  am.assignment_type,
  COUNT(*) as assignments
FROM agent_models am
JOIN agents a ON am.agent_id = a.name
JOIN companies c ON a.company_id = c.id
WHERE am.is_active = true
GROUP BY c.name, a.name, am.model_id, am.assignment_type
ORDER BY c.name, a.name;
```

### Performance Analysis

```sql
-- Analyze model performance by cost and usage
SELECT
  am.model_id,
  COUNT(DISTINCT am.agent_id) as agents_using,
  AVG(am.temperature) as avg_temperature,
  AVG(am.max_tokens) as avg_max_tokens,
  COUNT(*) as total_assignments
FROM agent_models am
WHERE am.is_active = true
GROUP BY am.model_id
ORDER BY agents_using DESC;
```

## Best Practices

### 1. Always Assign Primary Models

Every active agent should have exactly one primary model assignment:

```sql
-- Ensure one primary model per agent
SELECT agent_id, COUNT(*) as primary_count
FROM agent_models
WHERE assignment_type = 'primary' AND is_active = true
GROUP BY agent_id
HAVING COUNT(*) != 1;
```

### 2. Use Consistent Parameters

Standardize temperature and token limits for similar agent types:

- **Creative tasks**: temperature = 0.8-1.0
- **Technical tasks**: temperature = 0.3-0.7
- **Analytical tasks**: temperature = 0.1-0.5

### 3. Plan for Fallbacks

Production deployments should have fallback models for reliability.

### 4. Document Changes

Always include meaningful reasons when assigning or updating models.

### 5. Regular Audits

Periodically review model assignments to ensure they match current agent capabilities and cost requirements.

## Troubleshooting

### Error: "agent_id does not exist"

**Cause**: The agent name doesn't match any entry in the `agents` table.

**Solution**: Verify the exact agent name:
```sql
SELECT name FROM agents WHERE name LIKE '%<partial_name>%';
```

### Error: "duplicate key value violates unique constraint"

**Cause**: Attempting to create multiple primary assignments for the same agent.

**Solution**: Use `ON CONFLICT` or check existing assignments:
```sql
SELECT * FROM agent_models WHERE agent_id = '<agent_name>' AND assignment_type = 'primary';
```

### Model Not Being Used

**Cause**: Assignment exists but `is_active = false`.

**Solution**: Activate the assignment:
```sql
UPDATE agent_models SET is_active = true WHERE agent_id = '<agent_name>' AND assignment_type = 'primary';
```

## Related Documentation

- [Adding Companies and Agents](adding-companies-and-agents.md) - Complete agent creation procedure
- [Database Schema](../../schema/) - Complete database schema documentation
- [Agent API](../../api/agents.md) - Agent management API endpoints

## Maintenance

- **Review Frequency**: Monthly review of model assignments and performance
- **Version**: 1.0
- **Last Updated**: 2026-04-13
- **Author**: Paperclip Team
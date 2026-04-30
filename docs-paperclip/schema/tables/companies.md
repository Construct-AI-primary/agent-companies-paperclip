# Companies Table Schema

## Overview
The `companies` table stores information about all companies in the Paperclip ecosystem, including their configuration, branding, and operational settings.

## Table Structure

### Core Identification Fields
```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
name TEXT NOT NULL
description TEXT
```

### Status and Lifecycle
```sql
status TEXT NOT NULL DEFAULT 'active'  -- 'active', 'paused', 'suspended'
pause_reason TEXT
paused_at TIMESTAMP WITH TIME ZONE
```

### Issue Management
```sql
issue_prefix TEXT NOT NULL DEFAULT 'PAP'  -- Unique prefix for issue IDs
issue_counter INTEGER NOT NULL DEFAULT 0   -- Auto-incrementing counter
```

### Budget and Resource Management
```sql
budget_monthly_cents INTEGER NOT NULL DEFAULT 0
spent_monthly_cents INTEGER NOT NULL DEFAULT 0
```

### Governance and Compliance
```sql
require_board_approval_for_new_agents BOOLEAN NOT NULL DEFAULT true
```

### Feedback and Analytics
```sql
feedback_data_sharing_enabled BOOLEAN NOT NULL DEFAULT false
feedback_data_sharing_consent_at TIMESTAMP WITH TIME ZONE
feedback_data_sharing_consent_by_user_id TEXT
feedback_data_sharing_terms_version TEXT
```

### Branding
```sql
brand_color TEXT  -- Hex color code for company branding
```

### Audit Fields
```sql
created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
```

## Indexes

### Unique Constraints
```sql
-- Ensure unique issue prefixes across companies
CREATE UNIQUE INDEX companies_issue_prefix_idx ON companies(issue_prefix);
```

## Foreign Key Relationships

### Inbound References (Tables that reference companies)
- `agents.company_id` → `companies.id`
- `agent_api_keys.company_id` → `companies.id`
- `activity_log.company_id` → `companies.id`
- `issues.company_id` → `companies.id`
- `projects.company_id` → `companies.id`
- And 20+ additional tables...

## Common Query Patterns

### Find Active Companies
```sql
SELECT id, name, description, status, issue_prefix
FROM companies
WHERE status = 'active'
ORDER BY name;
```

### Budget Monitoring Across Companies
```sql
SELECT
  name,
  budget_monthly_cents,
  spent_monthly_cents,
  ROUND(spent_monthly_cents::numeric / NULLIF(budget_monthly_cents, 0) * 100, 2) as utilization_percent
FROM companies
WHERE budget_monthly_cents > 0
ORDER BY utilization_percent DESC;
```

### Issue Prefix Management
```sql
SELECT
  name,
  issue_prefix,
  issue_counter,
  CONCAT(issue_prefix, '-', LPAD(issue_counter::text, 3, '0')) as next_issue_id
FROM companies
ORDER BY name;
```

## Data Validation Rules

### Status Values
- `active`: Company is operational and can create agents/issues
- `paused`: Company operations are temporarily suspended
- `suspended`: Company is suspended due to policy violations or other issues

### Issue Prefix Rules
- Must be 2-6 uppercase letters
- Must be unique across all companies
- Convention: Use company initials or meaningful abbreviation
- Examples: `DEVF` (DevForge AI), `INFR` (InfraForge AI), `QUAL` (QualityForge AI)

### Budget Validation
- Must be non-negative integers (cents)
- Zero budget means unlimited (for system companies)
- Monthly budgets reset on calendar month boundaries

## Issue ID Generation

### Algorithm
```sql
-- Generate next issue ID for a company
UPDATE companies
SET issue_counter = issue_counter + 1
WHERE id = ?
RETURNING CONCAT(issue_prefix, '-', LPAD(issue_counter::text, 3, '0'));
```

### Example Issue IDs
- `DEVF-001`, `DEVF-002`, `DEVF-003` (DevForge AI)
- `INFR-001`, `INFR-002`, `INFR-003` (InfraForge AI)
- `QUAL-001`, `QUAL-002`, `QUAL-003` (QualityForge AI)

## Governance Rules

### Agent Approval Requirements
- When `require_board_approval_for_new_agents = true`:
  - New agent creation requires board approval
  - Agent modifications may require approval
  - Budget increases require approval

- When `require_board_approval_for_new_agents = false`:
  - Agents can be created without approval
  - Typically for development/testing companies

### Feedback Data Sharing
- When `feedback_data_sharing_enabled = true`:
  - Company allows anonymized feedback data sharing
  - Must have user consent recorded
  - Terms version must be current

## Performance Considerations

### Index Strategy
- Primary key on `id` for fast lookups
- Unique index on `issue_prefix` for validation
- Consider partial indexes for active companies

### Query Optimization
- Most queries filter by `status = 'active'`
- Issue prefix lookups are frequent
- Budget calculations need efficient aggregation

## Migration Considerations

### Adding New Companies
```sql
INSERT INTO companies (
  name,
  description,
  issue_prefix,
  require_board_approval_for_new_agents,
  brand_color
) VALUES (
  'New Company Name',
  'Company description',
  'NCMP',  -- Choose appropriate prefix
  true,    -- Usually require approval for new companies
  '#007ACC'  -- Company brand color
);
```

### Schema Evolution
- New fields should have appropriate defaults
- Consider backward compatibility for existing companies
- Update governance rules as company policies evolve

## Monitoring and Maintenance

### Health Checks
```sql
-- Company status overview
SELECT
  status,
  COUNT(*) as company_count,
  SUM(budget_monthly_cents) as total_budget,
  AVG(issue_counter) as avg_issues_created
FROM companies
GROUP BY status;

-- Issue prefix conflicts (should return no rows)
SELECT issue_prefix, COUNT(*) as duplicates
FROM companies
GROUP BY issue_prefix
HAVING COUNT(*) > 1;
```

### Maintenance Tasks
- Regular budget resets (monthly)
- Issue counter monitoring (prevent overflow)
- Governance rule audits
- Feedback consent renewals

---

**Schema Version**: 1.0
**Last Updated**: 2026-04-15
**Related Tables**: agents, issues, projects, activity_log
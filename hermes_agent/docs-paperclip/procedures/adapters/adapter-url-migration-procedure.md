# Adapter URL Migration Procedure

## Overview

This procedure documents the steps required to update the adapter configuration URL in the Supabase agents table when the Paperclip deployment URL changes. This is necessary when moving between different environments (development, staging, production) or when the base URL changes.

## Prerequisites

- Administrative access to Supabase database
- Knowledge of the new deployment URL
- Backup of current database state (recommended)

## Procedure Steps

### Step 1: Identify Current Configuration

```sql
-- Check current adapter configurations
SELECT
    id,
    name,
    adapter_config
FROM agents
WHERE adapter_config IS NOT NULL
ORDER BY name;
```

### Step 2: Generate Migration SQL

Create a new SQL file with the following pattern:

```sql
-- Update adapter URLs for new deployment
-- Generated: YYYY-MM-DD
-- New URL: [NEW_DEPLOYMENT_URL]

-- Update all agents with adapter_config containing the old URL
UPDATE agents
SET adapter_config = REPLACE(
    adapter_config::text,
    '[OLD_URL]',
    '[NEW_URL]'
)::jsonb
WHERE adapter_config::text LIKE '%[OLD_URL]%';

-- Verify the changes
SELECT
    id,
    name,
    adapter_config
FROM agents
WHERE adapter_config::text LIKE '%[NEW_URL]%';
```

### Step 4: Execute Migration

1. **Backup First**: Create a backup of the agents table
2. **Test Migration**: Run the SQL on a test environment first
3. **Execute Production**: Apply to production database
4. **Verify**: Confirm all agents have updated URLs

### Step 4: Restart Services

After URL migration, restart any running Paperclip services to ensure they pick up the new configuration.

## Common URL Patterns

### Development URLs
- `http://localhost:3100`
- `http://localhost:3000`
- `https://paperclip-dev.example.com`

### Staging URLs
- `https://paperclip-staging.example.com`
- `https://staging.paperclip.example.com`

### Production URLs
- `https://paperclip.example.com`
- `https://app.paperclip.ai`

## Troubleshooting

### Issue: Agents not connecting after URL change
**Solution**: Check that the new URL is accessible and the adapter_config JSON is valid.

### Issue: Mixed old/new URLs in database
**Solution**: Re-run the migration SQL or manually update specific agents.

### Issue: Services still using old URL
**Solution**: Restart all Paperclip services and clear any cached configurations.

## Validation Checklist

- [ ] GitHub PAT generated with required repository permissions
- [ ] Render environment variables updated with GITHUB_TOKEN
- [ ] Database backup created
- [ ] Migration SQL generated with correct old/new URLs
- [ ] Migration tested on development environment
- [ ] Migration applied to production
- [ ] All agents verified to have new URLs
- [ ] Services restarted
- [ ] Agent connectivity confirmed

## Related Documentation

- `docs-paperclip/procedures/agents/adding-companies-and-agents.md`
- `docs-paperclip/adapters/README.md`
- Supabase database schema documentation

---

**Last Updated**: 2026-04-18
**Version**: 1.0
**Contact**: Infrastructure Team
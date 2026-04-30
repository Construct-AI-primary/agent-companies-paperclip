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

# Prompt Synchronization Procedure

## Overview

This procedure establishes the process for synchronizing updated prompt files from the Markdown-based development environment (`docs/dev-prompts/`) to the production database (`prompts` table). This ensures that prompt updates are properly versioned, tracked, and deployed to the live system.

## Background

The system uses a dual-prompt storage approach:
- **Development Mode**: Prompts stored as MD files in `docs/dev-prompts/` for easy editing and version control
- **Production Mode**: Prompts stored in the database `prompts` table for runtime performance

Previously, there was no documented procedure for syncing updated MD files to the database, leading to inconsistencies between development and production environments.

## Scope

This procedure covers:
- Synchronization of MD prompt files to database
- Change detection and versioning
- Validation and error handling
- Integration with development workflow
- Monitoring and auditing

## Prerequisites

### Environment Setup
- Node.js installed (version 16+)
- Access to Supabase database
- Environment variables configured:
  - `SUPABASE_URL`
  - `SUPABASE_SERVICE_ROLE_KEY`

### File Structure
```
docs/dev-prompts/
├── 00435-contracts-post-award/
│   └── correspondence-workflow/
│       ├── contract_management_agent.md
│       ├── document_retrieval_agent.md
│       └── ...
└── demo_correspondence_analysis.md
```

### Database Schema
The `prompts` table must have the following columns:
- `id` (TEXT, PRIMARY KEY)
- `name` (TEXT)
- `content` (TEXT)
- `key` (TEXT, UNIQUE)
- `type` (TEXT)
- `category` (TEXT)
- `is_active` (BOOLEAN)
- `metadata` (JSONB)
- `last_modified` (TEXT)
- `hash` (TEXT)
- `created_at` (TEXT)
- `updated_at` (TEXT)
- Additional fields as defined in schema

## Synchronization Script

### Location
`scripts/sync-md-prompts-to-database.js`

### Usage
```bash
# Basic sync
node scripts/sync-md-prompts-to-database.js

# Dry run (preview changes)
node scripts/sync-md-prompts-to-database.js --dry-run

# Verbose output
node scripts/sync-md-prompts-to-database.js --verbose

# Force update all prompts
node scripts/sync-md-prompts-to-database.js --force

# Combine options
node scripts/sync-md-prompts-to-database.js --dry-run --verbose
```

### Options
- `--dry-run`: Preview changes without making database modifications
- `--verbose`: Enable detailed logging of all operations
- `--force`: Force update of all prompts regardless of change detection

## MD File Format

Prompt files must follow this structure:

```markdown
# Agent Title
## Agent Key: `agent_unique_key`

[Full prompt content here]

**Status:** [Optional status information]
```

### Required Elements
- **Title**: First H1 heading becomes the prompt name
- **Agent Key**: Unique identifier in backticks
- **Content**: Full prompt text
- **Status**: Optional status indicator

### File Naming
- Use descriptive, lowercase filenames
- Use underscores instead of spaces: `contract_management_agent.md`
- Place files in appropriate subdirectories for organization

## Change Detection

The script uses multiple methods to detect changes:

### 1. Content Hash
- SHA-256 hash of full file content
- Detects any textual changes

### 2. File Modification Time
- Compares file `mtime` with database `last_modified`
- Catches cases where content changed but hash might not detect

### 3. Forced Updates
- `--force` flag overrides change detection
- Useful for schema changes or metadata updates

## Synchronization Process

### Step 1: File Discovery
- Recursively scans `docs/dev-prompts/` directory
- Identifies all `.md` files
- Excludes non-markdown files

### Step 2: Content Parsing
- Extracts title from first H1 heading
- Parses agent key and status
- Generates unique key from file path
- Calculates content hash
- Records file modification time

### Step 3: Change Detection
- Queries database for existing prompt by key
- Compares hashes and modification times
- Determines INSERT, UPDATE, or SKIP action

### Step 4: Database Operations
- **INSERT**: New prompts added with full metadata
- **UPDATE**: Existing prompts updated with new content
- **SKIP**: Unchanged prompts left as-is

### Step 5: Validation & Logging
- Validates database operations
- Logs all actions with timestamps
- Reports summary statistics

## Integration with Development Workflow

### Development Process
1. **Edit MD Files**: Make changes to prompt files in `docs/dev-prompts/`
2. **Test Changes**: Use development mode to test with updated files
3. **Commit Changes**: Commit MD file changes to version control
4. **Sync to Database**: Run synchronization script
5. **Deploy**: Deploy database changes to production

### Automated Sync Options

#### Option 1: Manual Sync
```bash
# After committing prompt changes
node scripts/sync-md-prompts-to-database.js --verbose
```

#### Option 2: Pre-deployment Hook
Add to deployment scripts:
```bash
#!/bin/bash
echo "Syncing prompt updates..."
node scripts/sync-md-prompts-to-database.js
if [ $? -ne 0 ]; then
  echo "Prompt sync failed, aborting deployment"
  exit 1
fi
```

#### Option 3: CI/CD Integration
Add to GitHub Actions or similar:
```yaml
- name: Sync Prompts
  run: node scripts/sync-md-prompts-to-database.js --verbose
  env:
    SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
    SUPABASE_SERVICE_ROLE_KEY: ${{ secrets.SUPABASE_SERVICE_ROLE_KEY }}
```

## Monitoring & Auditing

### Sync Logs
The script provides comprehensive logging:
- Files processed, inserted, updated, skipped
- Error counts and messages
- Detailed verbose output when requested

### Database Audit Trail
- All changes tracked in `prompts` table
- Timestamps for creation and updates
- Hash values for content verification
- Metadata including file paths and sync source

### Monitoring Queries
```sql
-- Check recent sync activity
SELECT name, updated_at, metadata->>'source' as sync_source
FROM prompts
WHERE metadata->>'source' = 'md_sync'
ORDER BY updated_at DESC
LIMIT 10;

-- Verify prompt integrity
SELECT name, hash, last_modified
FROM prompts
WHERE key LIKE '00435_contracts_post_award%'
ORDER BY name;
```

## Error Handling

### Common Issues
1. **Missing Environment Variables**
   - Error: "SUPABASE_URL environment variable not set"
   - Solution: Configure environment variables

2. **Database Connection Failure**
   - Error: "Failed to initialize Supabase client"
   - Solution: Check credentials and network connectivity

3. **File Parsing Errors**
   - Error: "Error parsing [file]: [message]"
   - Solution: Check MD file format and encoding

4. **Permission Errors**
   - Error: "INSERT failed: permission denied"
   - Solution: Verify service role key permissions

### Recovery Procedures
1. **Failed Sync**: Run with `--dry-run` to preview changes
2. **Partial Updates**: Script is atomic per file, rerun for failed files
3. **Data Corruption**: Restore from version control if needed

## Validation

### Pre-sync Validation
- Environment variables present
- Database connectivity confirmed
- MD directory exists and accessible
- Required Node.js modules available

### Post-sync Validation
```sql
-- Count prompts by source
SELECT metadata->>'source' as sync_source, COUNT(*)
FROM prompts
GROUP BY metadata->>'source';

-- Check for orphaned prompts
SELECT key, name
FROM prompts
WHERE metadata->>'file_path' IS NOT NULL
AND NOT EXISTS (
  SELECT 1 FROM filesystem_check
  WHERE file_path = prompts.metadata->>'file_path'
);
```

## Performance Considerations

### Large File Sets
- Script processes files sequentially
- Memory usage scales with file size
- Database connection pooling recommended for large syncs

### Optimization Tips
- Use `--dry-run` for large changesets first
- Schedule syncs during low-traffic periods
- Consider batch processing for 100+ files

## Security Considerations

### Credentials Management
- Store Supabase credentials securely
- Use environment variables, not hardcoded values
- Rotate service role keys regularly

### Access Control
- Limit script execution to authorized personnel
- Audit all sync operations
- Implement approval workflows for production syncs

## Future Enhancements

### Planned Features
- Automated sync triggers on file changes
- Web-based sync interface
- Rollback capabilities
- Integration with prompt testing framework
- Multi-environment sync support

### Version Control Integration
- Git hooks for automatic sync
- Branch-specific prompt environments
- Conflict resolution for concurrent edits

## Related Procedures

- [0000_PROMPT_MANAGEMENT_PROCEDURE.md](./0000_PROMPT_MANAGEMENT_PROCEDURE.md)
- [0000_WORKFLOW_HITL_PROCEDURE.md](./0000_WORKFLOW_HITL_PROCEDURE.md)
- Development workflow documentation

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-04 | System | Initial procedure creation |
| 1.1 | [Future] | [Author] | [Planned enhancements] |

---

**Document Status:** Active
**Review Date:** Monthly
**Document Owner:** Development Team
**Approval Required:** Development Lead

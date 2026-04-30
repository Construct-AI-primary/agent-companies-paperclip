# SQL Template Registry

This directory contains pre-validated SQL templates for Paperclip agent operations. All SQL generated for agent operations should use these templates as the source of truth.

## Why Templates?

Templates prevent common errors:
- **Column name mismatches** (e.g., `slug` vs `name` vs `title`)
- **Missing FK dependencies** (e.g., inserting before parent exists)
- **Invalid data types** (e.g., text UUID vs actual UUID)
- **Ordering violations** (e.g., deleting parent before children)

## Single Source of Truth

The authoritative schema is in:
```
packages/db/src/schema/*.ts
```

Templates are derived from and validated against this source.

## Template Categories

### Agent Operations
| Template | Purpose |
|----------|---------|
| `REGISTER-agent.sql` | Create new agent with API key |
| `UPDATE-agent-title.sql` | Fix agent human names (title field) |
| `DELETE-agent.sql` | Safe deletion with FK cascade |
| `ADD-agent-api-keys.sql` | Add API key to existing agent |
| `ADD-agent-models.sql` | Add model assignment |

### Validation
| Template | Purpose |
|----------|---------|
| `CHECK-column-existence.sql` | Verify columns exist before INSERT/UPDATE |
| `VALIDATE-agent-exists.sql` | Verify agent exists before modification |

## Required Workflow

Before generating any SQL:

1. **Read the relevant template** from this directory
2. **Run CHECK-column-existence.sql** to verify schema compatibility
3. **Replace placeholders** with actual values
4. **Execute template** with validation queries

## Schema Validation Query

Always run this before modifying any table:

```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'agents' 
ORDER BY ordinal_position;
```

Compare output against the template's documented columns.

## Template Naming Convention

- `_internal-*` - Internal use, not for direct editing
- `REGISTER-*` - Create operations
- `UPDATE-*` - Modify operations  
- `DELETE-*` - Remove operations
- `CHECK-*` - Validation operations
- `VALIDATE-*` - Verification operations
- `ADD-*` - Add related records

## Updating Templates

If a template needs updating:

1. Verify against `packages/db/src/schema/*.ts`
2. Run validation query to confirm columns exist
3. Update template documentation
4. Update any skills that reference the template

## Versioning

Templates are versioned by date of last update. Check file headers for version history.

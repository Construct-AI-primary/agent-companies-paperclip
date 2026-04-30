# API Key Synchronization for Paperclip Integration

This document explains how to synchronize API keys from your Supabase database to the local Hermes SQLite database for Paperclip agent authentication.

## Overview

The system uses a one-way synchronization approach:
- **Supabase** (PostgreSQL) is the authoritative source for API keys
- **Local SQLite** database stores hashed API keys for fast validation
- **Sync script** pulls data from Supabase and updates the local database

## Database Schema

The `agent_api_keys` table stores:

```sql
CREATE TABLE agent_api_keys (
    id TEXT PRIMARY KEY,           -- UUID from Supabase
    agent_id TEXT NOT NULL,        -- Agent identifier
    company_id TEXT NOT NULL,      -- Company identifier
    name TEXT NOT NULL,           -- Human-readable key name
    key_hash TEXT NOT NULL,       -- Hashed API key for validation
    last_used_at REAL,            -- Unix timestamp of last use
    revoked_at REAL,              -- Unix timestamp when revoked
    created_at REAL NOT NULL      -- Unix timestamp when created
);
```

## Setup

### 1. Install Dependencies

```bash
# Install with Supabase support
pip install -e ".[supabase]"

# Or manually
pip install supabase
```

### 2. Configure Environment Variables

Add to your `.env` file:

```bash
# Supabase connection details
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
# Optional: Use service role key for full access
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
```

### 3. Run Initial Sync

```bash
python sync_api_keys.py
```

## Usage

### Manual Sync

Run the sync script whenever you want to update the local database:

```bash
python sync_api_keys.py
```

### Automated Sync

Set up a cron job or scheduled task:

```bash
# Every 5 minutes
*/5 * * * * cd /path/to/hermes-agent && python sync_api_keys.py
```

### API Key Validation

In your Paperclip agent code, validate API keys like this:

```python
from hermes_state import SessionDB

db = SessionDB()

# Validate an API key (this will update last_used_at)
key_record = db.validate_api_key_hash(api_key_hash)
if key_record:
    print(f"Valid key for agent: {key_record['agent_id']}")
    # Proceed with agent work
else:
    print("Invalid or revoked API key")
    # Reject the request

db.close()
```

### Listing Keys

```python
# Get all active keys for an agent
agent_keys = db.get_api_keys_for_agent(agent_id)

# Get all active keys for a company
company_keys = db.get_api_keys_for_company(company_id)

# List keys with filtering
keys = db.list_api_keys(
    agent_id=agent_id,
    include_revoked=False,
    limit=10
)
```

### Key Management

```python
# Revoke a key
success = db.revoke_api_key(key_id)

# Clean up old revoked keys (older than 90 days)
deleted_count = db.cleanup_revoked_keys(older_than_days=90)
```

## Security Notes

- **Hash-based validation**: Only key hashes are stored locally, never plaintext keys
- **One-way sync**: Local database cannot modify Supabase data
- **Usage tracking**: `last_used_at` timestamps help monitor key activity
- **Revocation support**: Keys can be revoked and will be rejected during validation

## Troubleshooting

### Common Issues

1. **"supabase-py not installed"**
   ```bash
   pip install supabase
   ```

2. **"SUPABASE_URL environment variable is required"**
   - Add `SUPABASE_URL=https://your-project.supabase.co` to `.env`

3. **Permission denied**
   - Use `SUPABASE_SERVICE_ROLE_KEY` instead of `SUPABASE_ANON_KEY`
   - Or ensure your anon key has read access to the `agent_api_keys` table

4. **Timestamp parsing errors**
   - The script handles various PostgreSQL timestamp formats
   - Check your Supabase data if you see parsing warnings

### Debug Mode

Add debug logging to see detailed sync progress:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

## Integration with Paperclip

When a Paperclip agent receives a request:

1. **Hash the API key**: Use the same hashing algorithm as your Supabase setup
2. **Validate locally**: Call `validate_api_key_hash()` to check validity
3. **Extract agent info**: Use the returned record to identify the agent/company
4. **Proceed with work**: Allow the agent to work on the local drive
5. **Send heartbeats**: Communicate progress back to Paperclip

The local SQLite database ensures fast validation without network calls to Supabase during normal operation.
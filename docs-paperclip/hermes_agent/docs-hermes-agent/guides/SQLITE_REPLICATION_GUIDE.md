# SQLite Database Replication and Supabase Sync Guide

This guide explains how to replicate the Hermes Agent SQLite database on another device and enable synchronization with Supabase for API key management.

## Overview

Hermes Agent uses a local SQLite database (`~/.hermes/state.db`) for storing session data, message history, and API key hashes. The system supports one-way synchronization with Supabase for API key management, where Supabase serves as the authoritative source.

## Prerequisites

### 1. Python Environment
Ensure you have Python 3.8+ installed with the required dependencies:

```bash
# Install core dependencies
pip install -e ".[supabase]"

# Or manually
pip install supabase python-dotenv
```

### 2. Supabase Setup (Optional but Recommended)
If you want API key synchronization:

1. Create a Supabase project at https://supabase.com
2. Create a table called `agent_api_keys` with this schema:

```sql
CREATE TABLE agent_api_keys (
    id TEXT PRIMARY KEY,
    agent_id TEXT NOT NULL,
    company_id TEXT NOT NULL,
    name TEXT NOT NULL,
    key_hash TEXT NOT NULL,
    last_used_at TIMESTAMPTZ,
    revoked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX agent_api_keys_key_hash_idx ON agent_api_keys(key_hash);
CREATE INDEX agent_api_keys_company_agent_idx ON agent_api_keys(company_id, agent_id);
```

3. Set up Row Level Security (RLS) policies as needed for your use case.

## Database Initialization

### Automatic Setup
The SQLite database is created automatically when you first run Hermes Agent. Simply run any Hermes command:

```bash
# This will create ~/.hermes/state.db if it doesn't exist
python -m hermes_cli.main --help
```

Or run the agent:

```bash
hermes run "hello world"
```

### Manual Database Creation
If you need to create the database manually:

```python
from hermes_state import SessionDB

# This creates the database and initializes the schema
db = SessionDB()
print(f"Database created at: {db.db_path}")
db.close()
```

## Supabase Synchronization Setup

### 1. Environment Configuration
Add Supabase credentials to your `.env` file:

```bash
# Supabase connection details
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here

# Optional: Use service role key for full access (recommended for sync)
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
```

### 2. Test Connection
Test your Supabase connection:

```bash
python test_supabase.py
```

This script will test both anon key and service role key connections.

### 3. Initial Sync
Run the initial synchronization to populate your local database with API keys from Supabase:

```bash
python sync_api_keys.py
```

### 4. Automated Sync Setup
Set up periodic synchronization using cron:

```bash
# Add to crontab (crontab -e)
# Sync every 5 minutes
*/5 * * * * cd /path/to/hermes-agent && python sync_api_keys.py
```

Or create a systemd timer for systems with systemd:

```bash
# Create service file: /etc/systemd/system/hermes-sync.service
[Unit]
Description=Hermes API Key Sync
After=network.target

[Service]
Type=oneshot
User=your-user
WorkingDirectory=/path/to/hermes-agent
ExecStart=/usr/bin/python sync_api_keys.py
```

```bash
# Create timer file: /etc/systemd/system/hermes-sync.timer
[Unit]
Description=Run Hermes API Key Sync every 5 minutes
Requires=hermes-sync.service

[Timer]
OnBootSec=5min
OnUnitActiveSec=5min

[Install]
WantedBy=timers.target
```

Enable and start the timer:

```bash
sudo systemctl enable hermes-sync.timer
sudo systemctl start hermes-sync.timer
```

## Database Schema

The SQLite database includes these main tables:

### sessions
- Stores session metadata and configuration
- Includes model info, system prompts, and usage statistics

### messages
- Full message history with FTS (Full-Text Search) support
- Includes reasoning content and tool calls

### agent_api_keys
- Hashed API keys for agent authentication
- Synchronized from Supabase

### Schema Version Management
The database automatically handles schema migrations. Current version: 7

## Backup and Restore

### Database Backup
```bash
# Create a backup
cp ~/.hermes/state.db ~/.hermes/state.db.backup

# Or use SQLite's backup command
sqlite3 ~/.hermes/state.db ".backup ~/.hermes/state.db.backup"
```

### Database Restore
```bash
# Stop any running Hermes processes first
pkill -f hermes

# Restore from backup
cp ~/.hermes/state.db.backup ~/.hermes/state.db

# Restart Hermes
```

## Troubleshooting

### Common Issues

1. **"supabase-py not installed"**
   ```bash
   pip install supabase
   ```

2. **"SUPABASE_URL environment variable is required"**
   - Add `SUPABASE_URL=https://your-project.supabase.co` to `.env`

3. **Permission denied on Supabase**
   - Use `SUPABASE_SERVICE_ROLE_KEY` instead of `SUPABASE_ANON_KEY`
   - Ensure your keys have read access to the `agent_api_keys` table

4. **Database locked errors**
   - Multiple Hermes processes may be running
   - Wait a moment and try again, or kill conflicting processes

5. **Schema migration errors**
   - The database handles migrations automatically
   - If issues persist, delete the database and let it recreate

### Debug Mode
Enable debug logging for sync operations:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

Then run the sync script.

## Security Considerations

- **API Key Hashing**: Only key hashes are stored locally, never plaintext keys
- **One-way Sync**: Local database cannot modify Supabase data
- **Usage Tracking**: `last_used_at` timestamps help monitor key activity
- **Revocation Support**: Keys can be revoked and will be rejected during validation

## API Key Management

### Validating Keys
```python
from hermes_state import SessionDB

db = SessionDB()

# Validate an API key hash
key_record = db.validate_api_key_hash(api_key_hash)
if key_record:
    print(f"Valid key for agent: {key_record['agent_id']}")
else:
    print("Invalid or revoked API key")

db.close()
```

### Listing Keys
```python
# Get all active keys for an agent
agent_keys = db.get_api_keys_for_agent(agent_id)

# Get all active keys for a company
company_keys = db.get_api_keys_for_company(company_id)
```

### Key Management
```python
# Revoke a key
success = db.revoke_api_key(key_id)

# Clean up old revoked keys
deleted_count = db.cleanup_revoked_keys(older_than_days=90)
```

## Migration Between Devices

### Option 1: Fresh Start
1. Set up new device with Hermes Agent
2. Configure Supabase credentials
3. Run initial sync: `python sync_api_keys.py`
4. Database will be created automatically on first use

### Option 2: Database Copy
1. Copy `~/.hermes/state.db` from source device to target device
2. Ensure Supabase credentials are configured on target device
3. Run sync to update with latest API keys: `python sync_api_keys.py`

### Option 3: Supabase-Only
1. Don't copy the local database
2. Configure Supabase credentials
3. Run initial sync to populate from Supabase
4. Local database will be created and populated automatically

## Monitoring

### Sync Status
Check the output of `python sync_api_keys.py` for sync statistics:
- Total keys in Supabase
- Successfully synced
- Skipped/incomplete keys
- Errors

### Database Health
```bash
# Check database integrity
sqlite3 ~/.hermes/state.db "PRAGMA integrity_check;"

# Get database statistics
sqlite3 ~/.hermes/state.db "SELECT COUNT(*) FROM sessions;" "SELECT COUNT(*) FROM messages;" "SELECT COUNT(*) FROM agent_api_keys;"
```

## Advanced Configuration

### Custom Database Location
Set `HERMES_HOME` environment variable to change the database location:

```bash
export HERMES_HOME=/custom/path
# Database will be at /custom/path/state.db
```

### WAL Mode
The database uses WAL (Write-Ahead Logging) mode for better concurrent access. This creates additional files:
- `state.db` - Main database
- `state.db-wal` - Write-ahead log
- `state.db-shm` - Shared memory file

### Performance Tuning
For high-traffic deployments, consider:
- Regular WAL checkpoints
- Connection pooling
- Read-only replicas (advanced)

---

This guide covers the complete setup for replicating your Hermes Agent SQLite database and enabling Supabase synchronization. The system is designed to be robust and handle schema migrations automatically.
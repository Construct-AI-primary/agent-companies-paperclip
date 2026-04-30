# Supabase Database Backup Script

This script creates comprehensive backups of all Paperclip tables from your Supabase database, saving data as JSON files in timestamped directories.

## Features

- **Complete Coverage**: Backs up all 60+ Paperclip database tables
- **Large Table Handling**: Automatically paginates large tables to avoid memory issues
- **Progress Tracking**: Shows detailed progress for each table
- **Error Handling**: Continues backup even if individual tables fail
- **Manifest File**: Creates detailed metadata about the backup
- **Safety Confirmations**: Requires explicit confirmation before starting

## Prerequisites

1. **Python 3.8+**
2. **Supabase Account** with service role access
3. **Required Dependencies**:
   ```bash
   pip install supabase python-dotenv
   ```

## Setup

### 1. Environment Variables

Create a `.env` file in the project root:

```bash
# Supabase Configuration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here
```

**⚠️ Security Warning**: The service role key has full access to your database. Keep it secure and never commit it to version control.

### 2. Verify Connection

Test your connection before running the full backup:

```bash
python -c "
import os
from supabase import create_client
from dotenv import load_dotenv
load_dotenv()
client = create_client(os.getenv('SUPABASE_URL'), os.getenv('SUPABASE_SERVICE_ROLE_KEY'))
result = client.table('companies').select('count').execute()
print('Connection successful!' if result.data else 'Connection failed')
"
```

## Usage

### Full Backup

```bash
# Interactive mode (recommended)
python backup_supabase.py

# Skip confirmation prompt
python backup_supabase.py --yes
```

### What Gets Backed Up

The script exports all Paperclip tables including:

**Core Tables:**
- `companies`, `agents`, `issues`, `projects`

**Agent Management:**
- `agent_api_keys` (contains plain-text API keys in `api_key` column), `agent_config_revisions`, `agent_runtime_state`

**Authentication:**
- `board_api_keys`, `company_memberships`, `principal_permission_grants`

**Large Tables (Paginated):**
- `activity_log`, `heartbeat_run_events`, `cost_events`
- `issue_comments`, `agent_task_sessions`

## Output Structure

```
supabase_backup_20260413_160000/
├── backup_manifest.json          # Backup metadata
├── companies.json               # Table data
├── agents.json
├── issues.json
├── agent_api_keys.json
└── ... (all other tables)
```

### Manifest File

The `backup_manifest.json` contains:
- Backup timestamp and directory
- Success/failure statistics
- Row counts and file sizes per table
- Error details for failed exports

## Performance Considerations

### Large Databases

- **Memory Usage**: Large tables are paginated in 1000-row batches
- **Network**: Uses efficient Supabase queries
- **Storage**: JSON files are human-readable but larger than binary formats

### Estimated Times

- **Small DB** (< 10k rows): 1-2 minutes
- **Medium DB** (100k rows): 5-10 minutes
- **Large DB** (1M+ rows): 30+ minutes

## Troubleshooting

### Common Issues

1. **"supabase-py not installed"**
   ```bash
   pip install supabase
   ```

2. **Permission Denied**
   - Ensure `SUPABASE_SERVICE_ROLE_KEY` is correct
   - Service role key is required for full table access

3. **Timeout Errors**
   - Large tables are automatically paginated
   - Check network connectivity

4. **Memory Issues**
   - Script handles large datasets efficiently
   - Monitor system memory during backup

### Debug Mode

Add debug logging:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Partial Backups

To backup specific tables only, modify `PAPERCLIP_TABLES` in the script:

```python
# Only backup essential tables
PAPERCLIP_TABLES = [
    "companies",
    "agents",
    "agent_api_keys",
    "issues"
]
```

## Security Best Practices

1. **Access Control**: Limit service role key usage
2. **Storage**: Encrypt backup files if storing long-term
3. **Network**: Use VPN for backup transfers
4. **Cleanup**: Delete old backups regularly

## Restoration

While this script focuses on backup, here's how to restore:

```bash
# Example: Restore a table (manual process)
python -c "
import json
from supabase import create_client

# Load backup
with open('supabase_backup_20260413_160000/companies.json') as f:
    data = json.load(f)

# Restore to Supabase
client = create_client(url, key)
for record in data:
    client.table('companies').insert(record).execute()
"
```

## Automation

### Cron Job Example

```bash
# Daily backup at 2 AM
0 2 * * * cd /path/to/paperclip && python backup_supabase.py --yes
```

### Retention Policy

```bash
# Keep only last 7 days of backups
find . -name "supabase_backup_*" -type d -mtime +7 -exec rm -rf {} \;
```

## Support

For issues with the backup script:

1. Check the `backup_manifest.json` for error details
2. Verify environment variables
3. Test Supabase connection separately
4. Review table permissions

---

**Remember**: Always test backups by restoring to a development environment before relying on them for production recovery.
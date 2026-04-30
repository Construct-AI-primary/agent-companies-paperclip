# Paperclip Database Backup System

This directory contains comprehensive database backup scripts for the Paperclip ecosystem.

## 🚀 Quick Start

### Full Database Backup
```bash
# Set your database URL
export DATABASE_URL="postgresql://user:password@host:port/database"

# Run the backup script
./scripts/backup-all-tables.sh
```

## 📁 Backup Structure

After running the backup, you'll find the following structure:

```
backups/
├── paperclip_backup_20260415_124500_full.sql      # Complete database dump
├── paperclip_backup_20260415_124500_schema.sql    # Schema only (no data)
├── paperclip_backup_20260415_124500_data.sql      # Data only (no schema)
├── paperclip_backup_20260415_124500.tar.gz        # Compressed archive
├── paperclip_backup_20260415_124500_manifest.txt  # Backup details
└── tables_20260415_124500/                        # Individual table files
    ├── agents.sql
    ├── companies.sql
    ├── issues.sql
    └── ... (all tables)
```

## 📋 What Gets Backed Up

The backup script creates backups of all tables in the `public` schema:

### Core Tables
- **agents** - AI agent configurations and metadata
- **companies** - Company information and settings
- **issues** - Project issues and tasks
- **projects** - Project definitions and metadata
- **activity_log** - Audit trail of all system activities

### Supporting Tables
- **agent_api_keys** - API authentication keys
- **agent_models** - AI model assignments for agents
- **approvals** - Approval workflows and decisions
- **documents** - File attachments and documentation
- **feedback_votes** - User feedback and ratings
- **workspaces** - Execution environments
- And 40+ additional tables...

## 🔧 Backup Types

### 1. Full Backup (`*_full.sql`)
- Complete database dump with schema and data
- Includes all table structures, constraints, and data
- Can be used to restore entire database
- **Use for**: Complete disaster recovery

### 2. Schema Backup (`*_schema.sql`)
- Table structures, indexes, constraints only
- No data included
- **Use for**: Setting up new environments

### 3. Data Backup (`*_data.sql`)
- Data only, no schema changes
- **Use for**: Migrating data between identical schemas

### 4. Individual Table Backups
- Each table backed up separately
- **Use for**: Selective restoration or analysis

## 🔄 Restoration

### Restore from Full Backup
```bash
psql $DATABASE_URL < backups/paperclip_backup_20260415_124500_full.sql
```

### Restore Schema + Data Separately
```bash
# Restore schema first
psql $DATABASE_URL < backups/paperclip_backup_20260415_124500_schema.sql

# Then restore data
psql $DATABASE_URL < backups/paperclip_backup_20260415_124500_data.sql
```

### Restore Individual Tables
```bash
# Restore specific table
psql $DATABASE_URL < backups/tables_20260415_124500/agents.sql
```

### Restore from Archive
```bash
# Extract archive
tar -xzf backups/paperclip_backup_20260415_124500.tar.gz -C /tmp/

# Use extracted files as needed
psql $DATABASE_URL < /tmp/paperclip_backup_20260415_124500_full.sql
```

## 📊 Backup Manifest

Each backup includes a manifest file (`*_manifest.txt`) containing:

- Backup timestamp and database information
- File sizes and locations
- Table statistics (top 10 largest tables)
- Restoration instructions
- Database connection details (sanitized)

## 🛡️ Safety Features

### Automatic Verification
- Script validates database connection before starting
- Checks each backup file creation
- Reports any failures immediately

### Comprehensive Logging
- Timestamped progress logs
- Color-coded output (green=success, red=error, blue=info)
- Detailed error messages

### Multiple Backup Formats
- SQL dumps for PostgreSQL compatibility
- Compressed archives for storage efficiency
- Individual files for selective restoration

## ⚙️ Configuration

### Environment Variables
```bash
export DATABASE_URL="postgresql://user:password@host:port/database"
```

### Backup Directory
- Default: `./backups/`
- Automatically created if it doesn't exist
- Can be customized by editing `BACKUP_DIR` in the script

### Backup Naming
- Format: `paperclip_backup_YYYYMMDD_HHMMSS`
- Includes timestamp for easy identification
- Prevents accidental overwrites

## 🚨 Error Handling

### Common Issues

#### Permission Denied
```bash
# Check database permissions
psql $DATABASE_URL -c "SELECT current_user;"

# Ensure user has backup privileges
GRANT pg_read_all_data TO backup_user;
```

#### Disk Space Issues
```bash
# Check available space
df -h

# Monitor backup size during creation
watch -n 10 'du -sh backups/'
```

#### Connection Timeouts
```bash
# Increase timeout for large databases
export PGCONNECT_TIMEOUT=300
```

## 📈 Monitoring & Maintenance

### Backup Size Tracking
```bash
# Check backup sizes
du -sh backups/

# Monitor growth over time
find backups/ -name "*.sql" -exec ls -lh {} \; | sort -k5 -hr
```

### Cleanup Old Backups
```bash
# Remove backups older than 30 days
find backups/ -name "paperclip_backup_*" -mtime +30 -delete

# Keep only last 10 backups
ls -t backups/paperclip_backup_* | tail -n +11 | xargs rm -f
```

### Backup Verification
```bash
# Test restore to separate database
createdb test_restore
pg_restore -d test_restore backup_file.sql
```

## 🔐 Security Considerations

### Database Credentials
- Never store `DATABASE_URL` in files
- Use environment variables or secure credential management
- Rotate credentials regularly

### Backup Storage
- Store backups in secure locations
- Encrypt sensitive backups if needed
- Implement access controls

### Data Privacy
- Backups contain all data including sensitive information
- Implement proper retention policies
- Comply with data protection regulations

## 📞 Support

### Troubleshooting
1. Check the manifest file for detailed information
2. Review script output for error messages
3. Verify database connectivity and permissions
4. Ensure sufficient disk space

### Getting Help
- Check the manifest file for backup details
- Review PostgreSQL logs for connection issues
- Verify pg_dump version compatibility

---

## 📝 Usage Examples

### Daily Automated Backup
```bash
#!/bin/bash
# Add to crontab for daily backups
# 0 2 * * * /path/to/paperclip/scripts/backup-all-tables.sh

export DATABASE_URL="postgresql://backup:password@localhost/paperclip"
cd /path/to/paperclip
./scripts/backup-all-tables.sh
```

### Custom Backup Location
```bash
# Edit script to change BACKUP_DIR
BACKUP_DIR="/secure/backup/location"
./scripts/backup-all-tables.sh
```

### Backup with Notifications
```bash
#!/bin/bash
if ./scripts/backup-all-tables.sh; then
    echo "Backup successful" | mail -s "Paperclip Backup Complete" admin@company.com
else
    echo "Backup failed" | mail -s "Paperclip Backup FAILED" admin@company.com
fi
```

---

**Last Updated**: 2026-04-15
**Backup Script Version**: 1.0
**Supported PostgreSQL**: 12+
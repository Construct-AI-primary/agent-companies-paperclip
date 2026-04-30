# Plain-Text API Key Synchronization for Remote SQLite Devices

## Overview

This solution enables synchronization of **plain-text API keys** from the main Paperclip PostgreSQL database to remote SQLite devices that cannot perform hash-based authentication.

## ⚠️ Security Warning

**This approach stores PLAIN-TEXT API keys locally on the remote device.** This significantly reduces security compared to the standard hash-based approach. Only use this on:

- **Trusted devices** with proper access controls
- **Isolated networks** where the device cannot be compromised
- **Temporary solutions** until proper hash-based authentication can be implemented

## Architecture

```
Paperclip (PostgreSQL)          Remote Device (SQLite)
├── agent_api_keys table        ├── agent_api_keys table
│   ├── api_key (SHA256 hash)   │   ├── key_hash (SHA256 hash)
│   └── ...                     │   ├── key_plaintext (PLAIN TEXT) ⚠️
└── ...                         └── ...
    One-way sync                     Local validation
```

## Files Modified

### 1. `sync_api_keys_plaintext.py`
New sync script that retrieves and stores plain-text keys.

### 2. `hermes_state.py`
- Added `key_plaintext` column to schema
- Added `sync_api_key_plaintext_from_supabase()` method
- Added `validate_api_key_plaintext()` method
- Schema version bumped to 8

### 3. Database Schema Changes
```sql
-- Added to agent_api_keys table
ALTER TABLE agent_api_keys ADD COLUMN key_plaintext TEXT;
```

## Setup Instructions

### 1. Environment Variables

Add to your remote device's `.env` file:

```bash
# Supabase connection (for sync)
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here

# Optional: For API-based key retrieval
PAPERCLIP_API_KEY=your-paperclip-api-key-here
```

### 2. Database Migration

The schema will automatically migrate when you restart the Hermes agent. The new `key_plaintext` column will be added.

### 3. Initial Sync

Run the plain-text sync script:

```bash
cd hermes_agent
python sync_api_keys_plaintext.py --yes
```

**⚠️ The `--yes` flag skips the security confirmation prompt.**

## Usage

### Syncing Keys

```bash
# Manual sync
python sync_api_keys_plaintext.py

# Automated sync (add to cron)
*/30 * * * * cd /path/to/hermes-agent && python sync_api_keys_plaintext.py --yes
```

### Validating Keys

In your remote device code:

```python
from hermes_state import SessionDB

db = SessionDB()

# ⚠️ PLAIN-TEXT VALIDATION (less secure)
key_record = db.validate_api_key_plaintext(provided_key)
if key_record:
    print(f"Valid key for agent: {key_record['agent_id']}")
    # Proceed with agent work
else:
    print("Invalid API key")

db.close()
```

### API Key Management

All existing methods work with both hash and plain-text keys:

```python
# List keys (includes both hash and plain-text)
keys = db.list_api_keys(agent_id="agent-123")

# Revoke keys
db.revoke_api_key("key-id-123")

# Cleanup old revoked keys
deleted_count = db.cleanup_revoked_keys(older_than_days=90)
```

## Security Considerations

### Risks

1. **Plain-text exposure**: Keys are stored unencrypted on the device
2. **Device compromise**: If the device is stolen, keys are immediately accessible
3. **Network interception**: Keys may be visible during sync
4. **Backup exposure**: Backups of the SQLite database contain plain-text keys

### Mitigations

1. **Device hardening**:
   - Full disk encryption
   - Strong authentication
   - Network isolation
   - Regular security updates

2. **Key lifecycle management**:
   - Frequent key rotation
   - Immediate revocation on compromise
   - Short key lifetimes

3. **Network security**:
   - Use HTTPS for all communications
   - VPN or secure tunnel for sync
   - Certificate pinning

4. **Monitoring**:
   - Log all key usage
   - Alert on suspicious activity
   - Regular security audits

## Migration Path

### Phase 1: Plain-Text (Current)
- Store plain-text keys on remote devices
- Accept security trade-offs for functionality

### Phase 2: Hybrid Approach
- Implement challenge-response authentication
- Remote device proves key possession without revealing plain-text
- Gradual migration from plain-text storage

### Phase 3: Secure Hash-Based
- Implement proper hash-based authentication on remote devices
- Remove plain-text key storage
- Full security restoration

## Troubleshooting

### Common Issues

1. **"Cannot retrieve plain-text key"**
   - Ensure `SUPABASE_SERVICE_ROLE_KEY` has proper permissions
   - Check that the Paperclip API key retrieval method is implemented

2. **Schema migration fails**
   - Ensure the SQLite database is not locked
   - Check file permissions
   - Manually run: `sqlite3 state.db "ALTER TABLE agent_api_keys ADD COLUMN key_plaintext TEXT;"`

3. **Sync fails with permission errors**
   - Verify `SUPABASE_SERVICE_ROLE_KEY` is correct
   - Check Supabase RLS policies allow service role access

### Debug Mode

Enable detailed logging:

```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

## Alternative Solutions

If plain-text storage is unacceptable, consider:

1. **Challenge-Response Authentication**:
   - Remote device proves key possession via cryptographic challenge
   - No plain-text keys stored locally

2. **Hardware Security Modules (HSM)**:
   - Store keys in tamper-resistant hardware
   - Perform authentication operations in HSM

3. **Proxy Authentication**:
   - Remote device authenticates through a secure proxy
   - Proxy handles key validation without exposing keys to remote device

## Support

For issues with plain-text key synchronization:

1. Check the security warnings in this document
2. Verify your environment variables
3. Review the sync script logs
4. Consider if hash-based authentication can be implemented instead

---

**Remember**: Plain-text key storage should be a temporary solution. Plan for migration to secure authentication methods as soon as possible.
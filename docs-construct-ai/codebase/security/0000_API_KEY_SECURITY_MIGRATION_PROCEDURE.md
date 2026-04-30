---
memory_layer: durable_knowledge
para_section: pages/codebase/security
gigabrain_tags: security, codebase, compliance
documentation
openstinger_context: security-practices, compliance-requirements
last_updated: 2026-03-21
related_docs:
  - codebase/security/
  - disciplines/
---
# API Key Security Migration Procedure

## Overview
This procedure documents the migration from insecure localStorage API key storage to secure server-side encrypted database storage for LangChain settings.

## Background
Previously, API keys for AI services (OpenAI, Anthropic, etc.) were stored in plain text in browser localStorage, creating significant security risks including:
- API keys visible to anyone with browser access
- Keys persisting after logout
- Vulnerability to browser extensions and malware
- No audit trail of key access

## Security Migration Implementation

### Phase 1: Database Infrastructure
**Status**: ✅ Completed

#### Files Created:
- `server/src/database/langchain-user-settings.sql` - Database table schema
- `server/src/routes/langchain-settings-routes.js` - Secure API endpoints

#### Database Table: `user_langchain_settings`
```sql
CREATE TABLE user_langchain_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    organization_id TEXT DEFAULT 'default-org',
    -- Encrypted API keys
    openai_api_key TEXT,     -- Encrypted
    anthropic_api_key TEXT,  -- Encrypted
    cohere_api_key TEXT,     -- Encrypted
    -- Configuration (not sensitive)
    llm_provider TEXT DEFAULT 'openai',
    llm_model TEXT DEFAULT 'gpt-4o-mini',
    -- ... other fields
);
```

#### Security Features:
- **Row Level Security (RLS)**: Users can only access their own settings
- **Encryption**: API keys encrypted using AES before database storage
- **Access Control**: Server-side authentication required for all operations

### Phase 2: Server-Side API Implementation
**Status**: ✅ Completed

#### API Endpoints Created:
- `GET /api/langchain-settings` - Retrieve user settings (decrypted)
- `POST /api/langchain-settings` - Save user settings (encrypted)
- `POST /api/langchain-settings/test-connection` - Test API connectivity
- `POST /api/langchain-settings/reset` - Reset to defaults
- `DELETE /api/langchain-settings` - Delete user settings

#### Authentication:
- JWT token-based authentication
- Bearer token in Authorization header
- Automatic token refresh handling

### Phase 3: Client-Side Migration
**Status**: ✅ Completed

#### Files Modified:
- `client/src/services/langchainSettingsService.js` - Updated to use secure APIs
- `server/app.js` - Added langchain-settings routes

#### Key Changes:
- Removed localStorage API key storage
- Added server-side API communication
- Implemented fallback to localStorage for offline functionality
- Added proper error handling and user feedback

### Phase 4: Documentation Updates
**Status**: In Progress

#### Files to Update:
- `docs/procedures/0000_PROCEDURES_GUIDE.md` - Add procedure reference
- `docs/user-interface/0500_SUPABASE_SYSTEM_MASTER_GUIDE.md` - Database security
- `docs/user-interface/0700_LANGCHAIN_SETTINGS_UI.md` - Security changes
- `docs/user-interface/0700_UI_SETTINGS_MASTER_GUIDE.md` - API key handling
- `docs/0000_DOCUMENTATION_GUIDE.md` - Update references

## Deployment Instructions

### Step 1: Database Setup
Execute the SQL in Supabase SQL Editor:
```sql
-- Run contents of: server/src/database/langchain-user-settings.sql
```

### Step 2: Environment Variables
Ensure server has access to:
```
SUPABASE_URL=your-supabase-url
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

### Step 3: Server Deployment
Restart server to load new routes:
```bash
cd server
npm restart
```

### Step 4: Verification
1. Navigate to UI Settings → LangChain tab
2. Configure API keys
3. Verify keys are saved to database (not localStorage)
4. Check server logs for successful encryption/decryption

## Security Benefits

### Before Migration:
- ❌ API keys in plain text localStorage
- ❌ Accessible to browser extensions
- ❌ Persists after logout
- ❌ No access audit trail

### After Migration:
- ✅ Encrypted storage in database
- ✅ Server-side access control
- ✅ Session-based security
- ✅ Complete audit trail
- ✅ Protected from client-side attacks

## Testing Procedure

### Unit Tests:
```bash
# Test encryption functions
npm test -- --testPathPattern=langchain-settings
```

### Integration Tests:
```bash
# Test full API flow
npm test -- --testPathPattern=api-key-security
```

### Manual Testing:
1. Set API keys in UI
2. Verify database storage (encrypted)
3. Test API connectivity
4. Check logout behavior
5. Verify cross-device functionality

## Rollback Procedure

If issues occur, rollback to localStorage:
```javascript
// In langchainSettingsService.js, temporarily restore:
// await localStorage.setItem('langchain-settings', JSON.stringify(this.settings));
```

## Monitoring and Maintenance

### Key Metrics to Monitor:
- API key storage success rate
- Authentication failure rate
- Encryption/decryption errors
- Database performance

### Regular Maintenance:
- Rotate encryption keys annually
- Review access logs monthly
- Update dependencies regularly
- Audit API key usage patterns

## Future Enhancements

### Planned Improvements:
1. **Hardware Security Module (HSM)**: Move to dedicated encryption hardware
2. **Key Rotation**: Automatic key rotation system
3. **Multi-Region Encryption**: Geographic key distribution
4. **Advanced Auditing**: Real-time security monitoring

### Long-term Vision:
- Zero-knowledge encryption
- Client-side key generation
- Distributed key management
- Blockchain-based audit trails

## Support and Troubleshooting

### Common Issues:
1. **"Authentication failed"**: Check JWT token validity
2. **"Encryption error"**: Verify encryption keys
3. **"Database connection failed"**: Check Supabase connectivity

### Support Contacts:
- Security Team: security@construct-ai.com
- DevOps Team: devops@construct-ai.com
- Database Team: database@construct-ai.com

## Compliance and Legal

### Security Standards:
- SOC 2 Type II compliant
- GDPR compliant (data encryption)
- ISO 27001 certified processes

### Legal Requirements:
- API key handling follows industry best practices
- Encryption meets financial-grade security standards
- Audit trails support regulatory compliance

---

**Document Version**: 1.0
**Last Updated**: 2025-11-28
**Review Cycle**: Quarterly
**Document Owner**: Security Team
**Approvers**: CTO, CISO

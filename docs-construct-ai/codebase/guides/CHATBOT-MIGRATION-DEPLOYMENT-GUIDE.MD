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

# Chatbot Database Migration - Safe Deployment Guide

## ⚠️ **IMPORTANT: Data Safety Assessment**

### **Safe for Existing Data: ✅ YES**

The chatbot database migration is **100% safe** for your existing data because:

1. **No ALTER/DROP Operations** - Only CREATE TABLE and INSERT operations
2. **New Tables Only** - Creates 5 new tables, doesn't modify existing ones
3. **Read-Only Access** - Initial data is configuration data, not user data
4. **Independent Schema** - New tables don't reference existing data structures

---

## 🚀 **Deployment Instructions**

### **Step 1: Backup Current Database (Recommended)**

```bash
# Create backup before migration
pg_dump -h your-supabase-host -U postgres -d your-database > chatbot_migration_backup_$(date +%Y%m%d_%H%M%S).sql

# Or use Supabase dashboard backup feature
```

### **Step 2: Execute Migration**

**Option A: Via Supabase SQL Editor**

1. Open Supabase dashboard → SQL Editor
2. Copy contents of `sql/chatbot_workflow_database_migration.sql`
3. Paste and execute
4. Verify success message

**Option B: Via Command Line**

```bash
# Execute migration script
psql -h your-supabase-host -d your-database -f sql/chatbot_workflow_database_migration.sql
```

**Option C: Via Migration Script (if using Supabase CLI)**

```bash
# If you have Supabase CLI setup
supabase db push
```

---

## 📊 **Tables Being Created**

| Table Name                    | Purpose               | Data Impact            | Row Security             |
| ----------------------------- | --------------------- | ---------------------- | ------------------------ |
| `user_langchain_settings`     | User chatbot settings | None (empty initially) | User-specific access     |
| `chatbot_sessions`            | Session tracking      | None (empty initially) | User-specific access     |
| `chatbot_interactions`        | Interaction logging   | None (empty initially) | User-specific access     |
| `chatbot_vector_configs`      | Vector search config  | 7 config rows added    | Public read, admin write |
| `chatbot_performance_metrics` | Performance analytics | None (empty initially) | User-specific access     |

---

## 🔍 **Verification Steps**

### **1. Check Tables Created**

```sql
-- Verify all tables exist
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name LIKE '%chatbot%';

-- Expected output: 5 rows
-- user_langchain_settings
-- chatbot_sessions
-- chatbot_interactions
-- chatbot_vector_configs
-- chatbot_performance_metrics
```

### **2. Verify Initial Data**

```sql
-- Check vector configs populated
SELECT page_id, vector_table_name, search_enabled
FROM chatbot_vector_configs;

-- Expected: 7 rows for pages 00105, 00106, 00425, 00435, 00850, 02050, 02025
```

### **3. Check Security Policies**

```sql
-- Verify RLS policies exist
SELECT tablename, policyname
FROM pg_policies
WHERE tablename LIKE '%chatbot%';

-- Expected: Multiple policy rows for each table
```

---

## 🔄 **Rollback Procedure (If Needed)**

If you need to rollback, execute this safe removal script:

```sql
-- SAFE ROLLBACK SCRIPT - Removes only new tables
-- Run this ONLY if migration causes issues

-- Remove tables in correct order (respecting foreign keys)
DROP TABLE IF EXISTS chatbot_performance_metrics CASCADE;
DROP TABLE IF EXISTS chatbot_interactions CASCADE;
DROP TABLE IF EXISTS chatbot_sessions CASCADE;
DROP TABLE IF EXISTS chatbot_vector_configs CASCADE;
DROP TABLE IF EXISTS user_langchain_settings CASCADE;

-- Remove helper functions
DROP FUNCTION IF EXISTS cleanup_old_chatbot_data(INTEGER);
DROP FUNCTION IF EXISTS get_user_chatbot_stats(UUID, INTEGER);

-- Remove views
DROP VIEW IF EXISTS chatbot_usage_analytics;
DROP VIEW IF EXISTS chatbot_performance_summary;

-- Success message
SELECT 'Chatbot migration rollback completed successfully!' as status;
```

---

## 🛡️ **Pre-Deployment Checklist**

### **Environment Preparation**

- [ ] Database backup created
- [ ] Supabase project has sufficient storage
- [ ] Database user has CREATE TABLE permissions
- [ ] Migration script reviewed and approved

### **Post-Deployment Verification**

- [ ] All 5 tables created successfully
- [ ] RLS policies active
- [ ] Initial vector configs populated (7 rows)
- [ ] No existing data affected
- [ ] Application integration testing completed

---

## 📈 **Expected Timeline**

| Phase                   | Duration        | Activity                        |
| ----------------------- | --------------- | ------------------------------- |
| **Pre-Migration**       | 5 minutes       | Backup database                 |
| **Migration Execution** | 1-2 minutes     | Run SQL script                  |
| **Verification**        | 5 minutes       | Check tables and policies       |
| **Testing**             | 15 minutes      | Application integration testing |
| **Total**               | **~30 minutes** | Complete deployment             |

---

## 🔧 **Troubleshooting**

### **Permission Errors**

```sql
-- Grant necessary permissions if needed
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;
```

### **Table Already Exists**

```sql
-- Check existing tables
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_name LIKE '%chatbot%';

-- If tables exist, migration will skip creation
-- This is safe and expected behavior
```

### **RLS Policy Issues**

```sql
-- Check if RLS is enabled
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE tablename LIKE '%chatbot%';

-- Enable RLS if needed
ALTER TABLE user_langchain_settings ENABLE ROW LEVEL SECURITY;
```

---

## 🎯 **Next Steps After Migration**

1. **Test Integration** - Use the new service classes in development
2. **Update Application Code** - Integrate with existing chatbot components
3. **Monitor Performance** - Check for any performance impact
4. **User Training** - Brief users on new chatbot features

---

## ⚡ **Quick Summary**

**Migration File**: `sql/chatbot_workflow_database_migration.sql`
**Execution Time**: 1-2 minutes
**Data Impact**: Zero impact on existing data
**Rollback**: Safe and simple removal script available
**Risk Level**: Very Low (new tables only)

The migration is designed to be completely safe for your existing data and will seamlessly integrate with your current chatbot workflow.

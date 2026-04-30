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
# 0000 Table Policies Security Procedure

## 🚨 **SECURITY AGENT INTEGRATION REQUIREMENTS**

### __MANDATORY: Automated Security Agent Permissions__

**Security agents require these database permissions for automated operation:**

```sql
-- Grant security agent permissions (execute as superuser)
GRANT SECURITY_AGENT TO security_agent_user;
GRANT ALL ON SCHEMA public TO security_agent_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO security_agent_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO security_agent_user;

-- Allow policy creation and modification
GRANT CREATE, USAGE ON SCHEMA public TO security_agent_user;
GRANT pg_read_all_data TO security_agent_user;
GRANT pg_write_all_data TO security_agent_user;
```

### __Automated Security Agent Workflow__

**Security agents must follow this automated workflow:**

1. **PLAN Phase**: Security assessment using automated analysis
2. **ACT Phase**: Automated policy generation and deployment
3. **REVIEW Phase**: Continuous monitoring and compliance validation

**Agent Communication Requirements:**
```json
{
  "agent_type": "security_agent",
  "permissions_required": ["policy_create", "policy_modify", "security_audit"],
  "emergency_response_capable": true,
  "monitoring_interval_seconds": 300,
  "rollback_capable": true
}
```

### __Security Agent Emergency Procedures__

**Automated emergency response protocol:**

1. **Critical Breach Detection**: Agent detects unsecured tables
2. **Immediate Policy Application**: Automatic policy deployment
3. **Security Quarantine**: Isolate affected data segments
4. **Incident Reporting**: Automated security incident logging

---

## 📋 **Comprehensive Table Policy & Row Level Security (RLS) Management**

**Unified procedure for managing table policies, RLS configurations, and security policies across the Construct AI database system.**b
---
title: UPLOAD-KNOWLEDGE-TO-DB — ELEC-WORKFLOW Knowledge Document Upload Procedure
description: Reusable procedure for uploading markdown knowledge documents to the Paperclip Supabase database as issue-linked documents for ELEC-WORKFLOW
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: ELEC-WORKFLOW
precondition: Supabase connection string is known, target company exists
---

# UPLOAD-KNOWLEDGE-TO-DB — ELEC-WORKFLOW Knowledge Document Upload Procedure

## Overview

This procedure documents how to upload markdown knowledge documents from the ELEC-WORKFLOW project's `knowledge/` directory into the Paperclip Supabase database as issue-linked documents. Any agent or operator can use this procedure to make knowledge files available to sub-agents via the Paperclip `issue_documents` inheritance system.

## Database Schema (Target Tables)

| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `documents` | Stores the document body and metadata | `id`, `company_id`, `title`, `format`, `latest_body`, `latest_revision_id`, `latest_revision_number` |
| `document_revisions` | Version tracking for each document | `id`, `document_id`, `revision_number`, `body`, `title`, `format` |
| `issue_documents` | Links documents to issues with a lookup key | `id`, `issue_id`, `document_id`, `key` |
| `issues` | The issue that owns the documents | `id`, `company_id`, `title`, `description`, `status` |

### Entity Relationship

```
issues (1) ──→ issue_documents (many) ──→ documents (1) ──→ document_revisions (many)
```

Sub-agents inherit documents from parent issues via the `parent_id` chain. An agent assigned to issue B where `B.parent_id = A` can access documents linked to issue A by querying `Documents.{key}`.

## Step 1: Discover the Company UUID

Identify the company that will own the issue and documents.

```sql
SELECT id, name, issue_prefix
FROM companies
ORDER BY name;
```

**ELEC-WORKFLOW example**: DomainForge AI → `<domainforge-company-uuid>`

## Step 2: Discover Schema Tables

The `documents` and `issue_documents` tables may not be visible in standard schema listings. Verify they exist:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('documents', 'document_revisions', 'issue_documents', 'issues', 'companies')
ORDER BY table_name;
```

Also check column details:

```sql
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'documents'
ORDER BY ordinal_position;
```

## Step 3: Create or Find the Target Issue

### 3a. Check if the issue already exists

```sql
SELECT id, title, status
FROM issues
WHERE company_id = '<company-uuid>'
  AND title ILIKE '%ELEC-WORKFLOW%'
LIMIT 5;
```

### 3b. Create the issue if it does not exist

```sql
INSERT INTO issues (
    id, company_id, title, description, status, priority,
    request_depth, origin_kind, origin_fingerprint,
    created_at, updated_at
) VALUES (
    gen_random_uuid(),
    '<company-uuid>',
    'EE-ROOT-ELEC-WORKFLOW-2026 — 00860 Electrical Engineering Knowledge Bundle',
    'Root issue containing all knowledge documents for the ELEC-WORKFLOW project. Includes cross-company RACI, agent delegation map, metadata bundle, heartbeat monitoring config, and page knowledge for 8 electrical engineering workflow issues.',
    'backlog', 'high',
    0, 'manual', 'elec-workflow-root-issue',
    NOW(), NOW()
)
RETURNING id;
```

## Step 4: Upload Documents

For each knowledge file, perform a 3-step write:

### 4a. Insert into `documents`

```sql
INSERT INTO documents (
    id, company_id, title, format, latest_body,
    latest_revision_number, created_at, updated_at
) VALUES (
    gen_random_uuid(),
    '<company-uuid>',
    '<Human-readable document title>',
    'markdown',
    '<full file contents as text>',
    1, NOW(), NOW()
)
RETURNING id;
```

### 4b. Insert into `document_revisions`

```sql
INSERT INTO document_revisions (
    id, company_id, document_id, revision_number, body,
    title, format, created_at
) VALUES (
    gen_random_uuid(),
    '<company-uuid>',
    '<document-id-from-step-4a>',
    1,
    '<full file contents as text>',
    '<Human-readable document title>',
    'markdown',
    NOW()
)
RETURNING id;
```

Then update the document's `latest_revision_id`:

```sql
UPDATE documents
SET latest_revision_id = '<revision-id-from-step-4b>'
WHERE id = '<document-id-from-step-4a>';
```

### 4c. Link to issue via `issue_documents`

```sql
INSERT INTO issue_documents (
    id, company_id, issue_id, document_id, key, created_at, updated_at
) VALUES (
    gen_random_uuid(),
    '<company-uuid>',
    '<issue-id>',
    '<document-id-from-step-4a>',
    '<unique-document-key>',
    NOW(), NOW()
);
```

The `key` field is the lookup string agents will use to query the document (e.g., `Documents.full-page-metadata`).

### Document Key Convention

Use `kebab-case` keys that describe the document's content:

| File | Document Key |
|------|-------------|
| `AGENT-DELEGATION-MAP.md` | `agent-delegation-map` |
| `CROSS-COMPANY-RACI.md` | `cross-company-raci` |
| `HEARTBEAT-MONITORING-CONFIG.md` | `heartbeat-monitoring-config` |
| `METADATA-BUNDLE.md` | `full-page-metadata` |
| `PAGE-KNOWLEDGE.md` | `page-knowledge` |
| `plan.md` | `execution-plan` |
| `project.md` | `project-charter` |
| `README.md` | `project-readme` |

## Step 5: Configure Agents with Knowledge Bundle References

After documents are uploaded and linked to the issue, each agent that will execute workflow issues needs to be configured to know about the knowledge bundle. This is a 4-layer configuration update on the `agents` table:

### Layer 1 — `metadata.knowledge_bundle`

Add a `knowledge_bundle` object to the agent's JSONB `metadata` column:

```sql
UPDATE agents
SET metadata = metadata::jsonb || '{
  "knowledge_bundle": {
    "qc_issue_id": "<issue-uuid>",
    "project": "ELEC-WORKFLOW",
    "document_keys": ["cross-company-raci", "agent-delegation-map", "full-page-metadata", "heartbeat-monitoring-config", "page-knowledge"],
    "discipline": "00860-electrical-engineering",
    "last_updated": "2026-04-28"
  }
}'::jsonb
WHERE id = '<agent-uuid>';
```

The `document_keys` array should be tailored per agent role — only include the documents that agent needs to consult.

### Layer 2 — `capabilities`

Append electrical engineering-related capabilities to the agent's comma-separated `capabilities` text column:

```sql
UPDATE agents
SET capabilities = CONCAT(capabilities, ', electrical-engineering-domain, workflow-automation')
WHERE id = '<agent-uuid>'
  AND capabilities NOT LIKE '%electrical-engineering-domain%';
```

### Layer 3 — `runtime_config.knowledge_prompt`

Add a `knowledge_prompt` field to the JSONB `runtime_config` column with a natural-language instruction telling the agent which `Documents.{key}` references to consult and when:

```sql
UPDATE agents
SET runtime_config = runtime_config::jsonb || '{
  "_elec_knowledge_docs": "<issue-uuid>",
  "knowledge_prompt": "[ELEC-WORKFLOW] You have access to knowledge documents linked to the EE-ROOT-ELEC-WORKFLOW-2026 issue. Consult Documents.cross-company-raci for RACI assignments, Documents.agent-delegation-map for delegation hierarchy, Documents.full-page-metadata for component QC checklists, Documents.heartbeat-monitoring-config for polling configuration, and Documents.page-knowledge for electrical engineering domain knowledge."
}'::jsonb
WHERE id = '<agent-uuid>';
```

### Layer 4 — `agent_skill_assignments`

Assign relevant skills from `shared_skills` to each agent via the `agent_skill_assignments` junction table:

```sql
INSERT INTO agent_skill_assignments (
    id, company_id, agent_id, skill_key, source, created_at
) VALUES (
    gen_random_uuid(),
    '<company-uuid>',
    '<agent-uuid>',
    '<skill-key-from-shared_skills>',
    'shared_skills',
    NOW()
);
```

Common skill keys for ELEC-WORKFLOW agents:
- `electrical-engineering-domain` — DomainForge electrical agents (company_skill)
- `workflow-automation` — Automate electrical engineering workflows (shared_skill)
- `standards-compliance` — Validate against NEC, NESC, IEEE standards (shared_skill)
- `cross-discipline-coordination` — Coordinate with civil/structural/mechanical (shared_skill)
- `output-validation-checklist` — Use before delivering any work product (shared_skill)
- `feedback-integration` — Use when receiving feedback from reviews (shared_skill)
- `edge-case-analysis` — Use to identify boundary conditions (shared_skill)
- `regression-prevention` — Ensure changes don't break existing functionality (shared_skill)
- `risk-assessment` — Evaluate potential risks before decisions (shared_skill)
- `audit-trail-management` — Maintain records of actions and decisions (shared_skill)
- `documentation-quality-check` — Validate documentation quality (shared_skill)
- `status-reporting` — Report progress and completion (shared_skill)
- `escalation-management` — Handle blockers and unresolved issues (shared_skill)
- `handoff-protocol` — Pass work between agents (shared_skill)

### Skill Assignment Audit

Before assigning skills, check which skills already exist:

```sql
-- Check if a skill key exists in shared_skills
SELECT key, name, description FROM shared_skills WHERE key = '<skill-key>';

-- List all skills already assigned to an agent, with their source
SELECT sa.skill_key, sa.source
FROM agent_skill_assignments sa
WHERE sa.agent_id = '<agent-uuid>'
ORDER BY sa.skill_key;
```

### Full Python Configuration Script Template

```python
#!/usr/bin/env python3
"""Configure ELEC-WORKFLOW agents with knowledge bundle, capabilities, prompts, and skills."""
import json
import psycopg2

CONN_STR = "postgresql://postgres:<password>@<host>.supabase.co:5432/postgres"
QC_ISSUE_ID = "<issue-uuid>"

AGENTS = [
    {
        "agent_id": "<agent-uuid>",
        "name": "electrical-domainforge",
        "company_id": "<company-uuid>",
        "doc_keys": ["cross-company-raci", "agent-delegation-map", "full-page-metadata", "heartbeat-monitoring-config", "page-knowledge"],
        "extra_caps": ["electrical-engineering-domain", "workflow-automation"],
        "prompt": "[ELEC-WORKFLOW] Consult Documents.cross-company-raci, Documents.agent-delegation-map, Documents.full-page-metadata, Documents.heartbeat-monitoring-config, and Documents.page-knowledge for all 8 workflow issues.",
        "skill_keys": ["workflow-automation", "standards-compliance", "cross-discipline-coordination", "output-validation-checklist", "feedback-integration", "edge-case-analysis", "regression-prevention", "risk-assessment", "audit-trail-management", "documentation-quality-check", "status-reporting", "escalation-management", "handoff-protocol"],
    },
    # ... one dict per agent
]

conn = psycopg2.connect(CONN_STR)
cur = conn.cursor()

for agent in AGENTS:
    # Layer 1: metadata.knowledge_bundle
    cur.execute("SELECT metadata FROM agents WHERE id = %s", (agent["agent_id"],))
    meta = cur.fetchone()[0] or {}
    meta["knowledge_bundle"] = {
        "qc_issue_id": QC_ISSUE_ID,
        "project": "ELEC-WORKFLOW",
        "document_keys": agent["doc_keys"],
        "discipline": "00860-electrical-engineering",
        "last_updated": "2026-04-28"
    }
    cur.execute("UPDATE agents SET metadata = %s::jsonb WHERE id = %s",
                (json.dumps(meta), agent["agent_id"]))

    # Layer 2: capabilities
    cur.execute("SELECT capabilities FROM agents WHERE id = %s", (agent["agent_id"],))
    caps = cur.fetchone()[0] or ""
    caps_set = set(c.strip() for c in caps.split(",") if c.strip())
    caps_set.update(agent["extra_caps"])
    cur.execute("UPDATE agents SET capabilities = %s WHERE id = %s",
                (", ".join(sorted(caps_set)), agent["agent_id"]))

    # Layer 3: runtime_config.knowledge_prompt
    cur.execute("SELECT runtime_config FROM agents WHERE id = %s", (agent["agent_id"],))
    rt = cur.fetchone()[0] or {}
    rt["_elec_knowledge_docs"] = QC_ISSUE_ID
    rt["knowledge_prompt"] = agent["prompt"]
    cur.execute("UPDATE agents SET runtime_config = %s::jsonb WHERE id = %s",
                (json.dumps(rt), agent["agent_id"]))

    # Layer 4: skills
    for skill_key in agent.get("skill_keys", []):
        cur.execute(
            "SELECT id FROM agent_skill_assignments WHERE agent_id = %s AND skill_key = %s",
            (agent["agent_id"], skill_key))
        if cur.fetchone():
            continue
        cur.execute(
            """INSERT INTO agent_skill_assignments
               (id, company_id, agent_id, skill_key, source, created_at)
               VALUES (gen_random_uuid(), %s, %s, %s, 'shared_skills', NOW())""",
            (agent["company_id"], agent["agent_id"], skill_key))

    conn.commit()

cur.close()
conn.close()
print("✅ All ELEC-WORKFLOW agents configured!")
```

## Step 6: Verify Upload

Confirm all documents are linked correctly:

```sql
SELECT i.title AS issue_title,
       d.title AS doc_title,
       idoc.key AS doc_key,
       length(d.latest_body) AS body_length,
       d.format
FROM issues i
JOIN issue_documents idoc ON i.id = idoc.issue_id
JOIN documents d ON d.id = idoc.document_id
WHERE i.id = '<issue-id>'
ORDER BY idoc.key;
```

Expected output: one row per uploaded document with key, title, size, and format.

## Troubleshooting

| Problem | Likely Cause | Solution |
|---------|-------------|----------|
| `column "slug" does not exist` | The `companies` and `agents` tables have no `slug` column | Use `name` or `id` for lookups |
| Foreign key violation on `company_id` | Company UUID doesn't exist | Re-verify with `SELECT id FROM companies WHERE name LIKE '%DomainForge%'` |
| Document shows 0 bytes | `latest_body` is NULL | Check file was read correctly; verify `format` is set to `'markdown'` |
| Duplicate key error | Same `key` used twice on same issue | Script is idempotent — check before insert |
| `issue_documents` not found | Schema does not exist in this Supabase instance | Run schema discovery first; may be a different version |

## ELEC-WORKFLOW Execution Summary

| Step | Details |
|------|---------|
| **Company** | DomainForge AI (`<domainforge-company-uuid>`) |
| **Issue** | `<ee-root-issue-uuid>` |
| **Total documents to upload** | 8 (5 knowledge + 3 project-level) |
| **Database** | `<supabase-host>.supabase.co` |
| **Date** | 2026-04-28 |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: QualityForge AI / KnowledgeForge AI
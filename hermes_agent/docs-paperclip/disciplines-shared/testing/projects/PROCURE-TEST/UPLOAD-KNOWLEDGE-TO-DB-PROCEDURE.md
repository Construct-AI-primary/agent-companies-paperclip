---
title: UPLOAD-KNOWLEDGE-TO-DB — Paperclip Knowledge Document Upload Procedure
description: Reusable procedure for uploading markdown knowledge documents to the Paperclip Supabase database as issue-linked documents
author: QualityForge AI / KnowledgeForge AI
date: 2026-04-28
version: 1.0
status: active
project_code: PROCURE-TEST
precondition: Supabase connection string is known, target company exists
---

# UPLOAD-KNOWLEDGE-TO-DB — Paperclip Knowledge Document Upload Procedure

## Overview

This procedure documents how to upload markdown knowledge documents from a project's `knowledge/` directory into the Paperclip Supabase database as issue-linked documents. Any agent or operator can use this procedure to make knowledge files available to sub-agents via the Paperclip `issue_documents` inheritance system.

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

**PROCURE-TEST example**: QualityForge AI → `f535f9bc-00be-4b6d-9f53-c53abfacacef`

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
  AND title ILIKE '%<search-term>%'
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
    'QC-ROOT-<PROJECT-NAME>-<YEAR> — <Description>',
    '<Multi-line description of what documents are contained>',
    'backlog', 'high',
    0, 'manual', '<unique-fingerprint>',
    NOW(), NOW()
)
RETURNING id;
```

**PROCURE-TEST example**:
- Title: `QC-ROOT-PROCUREMENT-2026 — 01900 Procurement Test Knowledge Bundle`
- Origin fingerprint: `procure-test-root-issue`
- Issue ID created: `30745f34-0b6c-45b4-a35e-e3cc87c6c00f`

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
| `PROCURE-TEST-implementation.md` | `procure-test-implementation` |
| `plan.md` | `execution-plan` |
| `project.md` | `project-charter` |
| `README.md` | `project-readme` |

## Step 5: Configure Agents with Knowledge Bundle References

After documents are uploaded and linked to the issue, each agent that will execute test issues needs to be configured to know about the knowledge bundle. This is a 4-layer configuration update on the `agents` table:

### Layer 1 — `metadata.knowledge_bundle`

Add a `knowledge_bundle` object to the agent's JSONB `metadata` column:

```sql
UPDATE agents
SET metadata = metadata::jsonb || '{
  "knowledge_bundle": {
    "qc_issue_id": "<issue-uuid>",
    "project": "<PROJECT-CODE>",
    "document_keys": ["doc-key-1", "doc-key-2", "..."],
    "discipline": "<discipline-code>",
    "last_updated": "<YYYY-MM-DD>"
  }
}'::jsonb
WHERE id = '<agent-uuid>';
```

The `document_keys` array should be tailored per agent role — only include the documents that agent needs to consult.

### Layer 2 — `capabilities`

Append procurement/testing-related capabilities to the agent's comma-separated `capabilities` text column:

```sql
UPDATE agents
SET capabilities = CONCAT(capabilities, ', procurement-domain-knowledge, database-testing')
WHERE id = '<agent-uuid>'
  AND capabilities NOT LIKE '%procurement-domain-knowledge%';
```

### Layer 3 — `runtime_config.knowledge_prompt`

Add a `knowledge_prompt` field to the JSONB `runtime_config` column with a natural-language instruction telling the agent which `Documents.{key}` references to consult and when:

```sql
UPDATE agents
SET runtime_config = runtime_config::jsonb || '{
  "_procure_knowledge_docs": "<issue-uuid>",
  "knowledge_prompt": "[PROJECT-CODE] instruction telling the agent which Documents.xxx to consult for each relevant issue"
}'::jsonb
WHERE id = '<agent-uuid>';
```

### Layer 4 — `agent_skill_assignments`

Assign relevant skills from `shared_skills` to each agent via the `agent_skill_assignments` junction table. The `source` column has a CHECK constraint allowing only `'shared_skills'` or `'company_skills'`:

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

Common skill keys for PROCURE-TEST agents:
- `procurement-domain-knowledge` — DomainForge procurement agents (company_skill)
- `procurement-testing` — Validate procurement workflows, skills, data extraction, compliance, and integration (shared_skill — assign to ALL agents)
- `database-testing` — InfraForge Database/Verifier agents (company_skill)
- `browser-ui-testing` — Tester/Validator agents (company_skill)
- `integration-testing`, `api-testing` — Integration/QA agents (company_skill)
- `compliance-validation`, `standards-compliance` — Sentinel agents (company_skill)
- `knowledge-extraction`, `knowledge-management` — KnowledgeForge agents (company_skill)
- `ai-team-coordination`, `cross-team-coordination` — Director/oversight agents (company_skill)
- `output-validation-checklist` — Use before delivering any work product to validate quality (shared_skill)
- `feedback-integration` — Use when receiving feedback from reviews, testing, QA, or HITL (shared_skill)
- `edge-case-analysis` — Use to identify and test boundary conditions, unusual inputs, or error paths (shared_skill)
- `regression-prevention` — Use to ensure changes don't break existing functionality (shared_skill)
- `risk-assessment` — Use when evaluating potential risks before decisions or initiatives (shared_skill)
- `audit-trail-management` — Use when maintaining records of actions, decisions, and changes (shared_skill)
- `documentation-quality-check` — Use before delivering documentation to validate quality (shared_skill)
- `status-reporting` — Use when reporting progress, status updates, or completion of work (shared_skill)
- `escalation-management` — Use when encountering blockers, unresolved issues, or out-of-scope problems (shared_skill)
- `handoff-protocol` — Use when passing work, tasks, or deliverables between agents (shared_skill)

**Note**: Skills marked `(company_skill)` are procured by the company and not in the global `shared_skills` table — they were assigned before this configuration round. Skills marked `(shared_skill)` exist in `shared_skills` and are assigned with `source = 'shared_skills'`.

### Skill Assignment Audit

Before assigning skills, check which skills already exist in `shared_skills` and which are `company_skills`:

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
"""Configure agents with knowledge bundle, capabilities, prompts, and skills."""
import json
import psycopg2

CONN_STR = "postgresql://postgres:<password>@<host>.supabase.co:5432/postgres"
QC_ISSUE_ID = "<issue-uuid>"

AGENTS = [
    {
        "agent_id": "<agent-uuid>",
        "name": "AgentName",
        "company_id": "<company-uuid>",
        "doc_keys": ["doc-key-1", "doc-key-2"],
        "extra_caps": ["capability-a", "capability-b"],
        "prompt": "[PROJECT-CODE] instruction text",
        "skill_keys": ["skill-key-a", "skill-key-b"],
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
        "project": "<PROJECT-CODE>",
        "document_keys": agent["doc_keys"],
        "discipline": "<discipline-code>",
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
    rt["_procure_knowledge_docs"] = QC_ISSUE_ID
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
print("✅ All agents configured!")
```

**Important**: The `agent_skill_assignments.source` column has a CHECK constraint `(source = ANY (ARRAY['company_skills'::text, 'shared_skills'::text]))`. Always use `'shared_skills'` when assigning skills from the global `shared_skills` table.

### Step 5 Verification

Verify the configuration was applied:

```sql
SELECT a.name, c.name AS company,
       a.metadata -> 'knowledge_bundle' ->> 'project' AS kb_project,
       jsonb_array_length(a.metadata -> 'knowledge_bundle' -> 'document_keys') AS kb_keys,
       a.capabilities,
       a.runtime_config ->> 'knowledge_prompt' AS prompt_preview,
       (SELECT COUNT(*) FROM agent_skill_assignments WHERE agent_id = a.id) AS skill_count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.id IN ('<agent-uuid-1>', '<agent-uuid-2>');
```

### PROCURE-TEST Agent Configuration Summary

| Layer | Action | Agents Configured |
|-------|--------|------------------|
| metadata.knowledge_bundle | QC issue + doc keys per role | 16 agents across 4 companies |
| capabilities | Procurement/testing capabilities appended | 16 agents |
| runtime_config | knowledge_prompt + qc issue ref | 16 agents |
| agent_skill_assignments | 97 skill rows (25 initial + 48 additional shared_skills + pre-existing company_skills) | 16 agents |

**Final skill distribution per agent**:
- **QualityForge AI**: Validator (10), Tester (9), Sentinel (6), Integration (9)
- **DomainForge AI**: Evaluator (5), Hayden (5), Procurement analytics (4), Supplier management (4), Procurement strategy (5), Procurement director domain specialist (8), Contract administration (4)
- **InfraForge AI**: Database (8), Verifier (6)
- **KnowledgeForge AI**: Docs analyzer (5), Extractor (3), Director procurement (6)

**Scripts**: `/tmp/configure_procure_agents_v2.py` (initial 25 skills), `/tmp/configure_procure_agents_v3.py` (48 additional shared_skills)

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

## Full Python Upload Script Template

The scripts used for PROCURE-TEST are preserved at:
- `/tmp/upload_procure_knowledge.py` — knowledge files upload
- `/tmp/upload_project_docs.py` — project-level docs upload

### Generic Template

```python
#!/usr/bin/env python3
"""Generic template for uploading knowledge documents to Paperclip DB."""
import uuid
import psycopg2
from pathlib import Path

CONN_STR = "postgresql://postgres:<password>@<host>.supabase.co:5432/postgres"
COMPANY_ID = "<company-uuid>"
ISSUE_ID = "<issue-uuid>"
FILES_DIR = Path("/path/to/knowledge/files")

# (filename, document_key, title)
DOCUMENTS = [
    ("file1.md", "doc-key-1", "Document Title 1"),
    ("file2.md", "doc-key-2", "Document Title 2"),
]

conn = psycopg2.connect(CONN_STR)
cur = conn.cursor()

for filename, doc_key, doc_title in DOCUMENTS:
    filepath = FILES_DIR / filename
    body = filepath.read_text(encoding="utf-8")

    # Check for existing (idempotent)
    cur.execute(
        """SELECT d.id FROM documents d
           JOIN issue_documents idoc ON d.id = idoc.document_id
           WHERE idoc.issue_id = %s AND idoc.key = %s LIMIT 1""",
        (ISSUE_ID, doc_key)
    )
    if cur.fetchone():
        print(f"  ⏭️  Skipping {filename} (already exists)")
        continue

    doc_id = str(uuid.uuid4())
    cur.execute(
        "INSERT INTO documents (...) VALUES (...) RETURNING ...",
        (...)
    )
    # ... create revision, link to issue ...
    conn.commit()
    print(f"  ✅ Uploaded {filename} → key='{doc_key}'")

cur.close()
conn.close()
```

## Troubleshooting

| Problem | Likely Cause | Solution |
|---------|-------------|----------|
| `column "slug" does not exist` | The `companies` and `agents` tables have no `slug` column | Use `name` or `id` for lookups |
| Foreign key violation on `company_id` | Company UUID doesn't exist | Re-verify with `SELECT id FROM companies WHERE name LIKE '%...%'` |
| Document shows 0 bytes | `latest_body` is NULL | Check file was read correctly; verify `format` is set to `'markdown'` |
| Duplicate key error | Same `key` used twice on same issue | Script is idempotent — check before insert |
| `issue_documents` not found | Schema does not exist in this Supabase instance | Run schema discovery first; may be a different version |

## PROCURE-TEST Execution Summary

| Step | Details |
|------|---------|
| **Company** | QualityForge AI (`f535f9bc-00be-4b6d-9f53-c53abfacacef`) |
| **Issue** | `30745f34-0b6c-45b4-a35e-e3cc87c6c00f` |
| **Total documents uploaded** | 9 (5 knowledge + 4 project-level) |
| **Database** | `db.gmorarhibiptvcrnvrpi.supabase.co` |
| **Date** | 2026-04-28 |
| **Scripts** | `/tmp/upload_procure_knowledge.py`, `/tmp/upload_project_docs.py` |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: QualityForge AI / KnowledgeForge AI
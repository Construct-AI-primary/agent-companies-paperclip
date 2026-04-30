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

# AGENTS Table Schema

Generated on: 2026-03-30T01:41:38.756Z

## Columns

| Column Name | Data Type | Nullable | Sample Value |
|------------|-----------|----------|--------------|
| id | string | NO | 5d18545d-993a-496a-b1bd-76e2a9630525 |
| company_id | string | NO | f02b83a8-e0db-4332-b507-22f85e71ebf5 |
| name | string | NO | Sage |
| role | string | NO | chief_prompt_architect |
| title | string | NO | Chief Prompt Architect & Quality Assurance Lead |
| status | string | NO | active |
| reports_to | object | YES | NULL |
| capabilities | string | NO | ["prompt-architecture", "quality-assurance", "ethi |
| adapter_type | string | NO | openai |
| adapter_config | object | NO | {"model":"gpt-4","max_tokens":2000,"temperature":0... |
| budget_monthly_cents | number | NO | 2000 |
| spent_monthly_cents | number | NO | 0 |
| last_heartbeat_at | object | YES | NULL |
| metadata | object | NO | {"division":"Executive Leadership","expertise":"Pr... |
| created_at | string | NO | 2026-03-29T08:44:28.339897+00:00 |
| updated_at | string | NO | 2026-03-29T08:44:28.339897+00:00 |
| runtime_config | object | NO | {"context_window":8000,"memory_enabled":true}... |
| permissions | object | NO | {"can_manage_team":true,"can_create_prompts":true,... |
| icon | string | NO | 🧙‍♀️ |
| pause_reason | object | YES | NULL |
| paused_at | object | YES | NULL |
| model_config | object | NO | {"model":"gpt-4","provider":"openai","temperature"... |
| device_config | object | NO | {"memory_gb":16,"device_type":"cpu"}... |
| deleted_at | object | YES | NULL |
| is_active | boolean | NO | true |

## Sample Record

```json
{
  "id": "5d18545d-993a-496a-b1bd-76e2a9630525",
  "company_id": "f02b83a8-e0db-4332-b507-22f85e71ebf5",
  "name": "Sage",
  "role": "chief_prompt_architect",
  "title": "Chief Prompt Architect & Quality Assurance Lead",
  "status": "active",
  "reports_to": null,
  "capabilities": "[\"prompt-architecture\", \"quality-assurance\", \"ethical-ai\", \"team-leadership\"]",
  "adapter_type": "openai",
  "adapter_config": {
    "model": "gpt-4",
    "max_tokens": 2000,
    "temperature": 0.7
  },
  "budget_monthly_cents": 2000,
  "spent_monthly_cents": 0,
  "last_heartbeat_at": null,
  "metadata": {
    "division": "Executive Leadership",
    "expertise": "Prompt architecture, AI ethics, team leadership"
  },
  "created_at": "2026-03-29T08:44:28.339897+00:00",
  "updated_at": "2026-03-29T08:44:28.339897+00:00",
  "runtime_config": {
    "context_window": 8000,
    "memory_enabled": true
  },
  "permissions": {
    "can_manage_team": true,
    "can_create_prompts": true,
    "can_approve_deployments": true
  },
  "icon": "🧙‍♀️",
  "pause_reason": null,
  "paused_at": null,
  "model_config": {
    "model": "gpt-4",
    "provider": "openai",
    "temperature": 0.7
  },
  "device_config": {
    "memory_gb": 16,
    "device_type": "cpu"
  },
  "deleted_at": null,
  "is_active": true
}
```


# Agents Table Schema

## Overview

The `agents` table stores all agent records across all companies in the Paperclip system. Each agent is associated with a company and can optionally report to another agent (creating a hierarchical structure).

## Table Definition

```sql
create table public.agents (
  id uuid not null default gen_random_uuid (),
  company_id uuid not null,
  name text not null,
  role text not null default 'general'::text,
  title text null,
  status text not null default 'idle'::text,
  reports_to uuid null,
  capabilities text null,
  adapter_type text not null default 'process'::text,
  adapter_config jsonb not null default '{}'::jsonb,
  budget_monthly_cents integer not null default 0,
  spent_monthly_cents integer not null default 0,
  last_heartbeat_at timestamp with time zone null,
  metadata jsonb null,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  runtime_config jsonb not null default '{}'::jsonb,
  permissions jsonb not null default '{}'::jsonb,
  icon text null,
  pause_reason text null,
  paused_at timestamp with time zone null,
  model_config jsonb null,
  device_config jsonb null,
  deleted_at timestamp without time zone null,
  is_active boolean null default true,
  constraint agents_pkey primary key (id),
  constraint agents_company_id_companies_id_fk foreign key (company_id) references companies (id),
  constraint agents_reports_to_agents_id_fk foreign key (reports_to) references agents (id)
) TABLESPACE pg_default;
```

## Column Reference

| Column | Type | Default | Constraints | Description |
|--------|------|---------|------------|-------------|
| id | uuid | gen_random_uuid() | PRIMARY KEY | Unique identifier for the agent |
| company_id | uuid | - | NOT NULL, FK → companies | The company this agent belongs to |
| name | text | - | NOT NULL | Agent's display name |
| role | text | 'general' | NOT NULL | Agent's functional role (e.g., 'ceo', 'engineering', 'specialist') |
| title | text | NULL | - | Human-readable job title |
| status | text | 'idle' | NOT NULL | Current status (e.g., 'idle', 'running', 'paused') |
| reports_to | uuid | NULL | FK → agents | Manager/parent agent ID |
| capabilities | text | NULL | - | Text description of agent capabilities |
| adapter_type | text | 'process' | NOT NULL | Type of adapter (e.g., 'http', 'process', 'hermes_local') |
| adapter_config | jsonb | '{}' | NOT NULL | Adapter-specific configuration |
| budget_monthly_cents | integer | 0 | NOT NULL | Monthly budget in cents |
| spent_monthly_cents | integer | 0 | NOT NULL | Monthly spend in cents |
| last_heartbeat_at | timestamptz | NULL | - | Last heartbeat timestamp |
| metadata | jsonb | NULL | - | Additional metadata |
| created_at | timestamptz | now() | NOT NULL | Creation timestamp |
| updated_at | timestamptz | now() | NOT NULL | Last update timestamp |
| runtime_config | jsonb | '{}' | NOT NULL | Runtime configuration |
| permissions | jsonb | '{}' | NOT NULL | Agent permissions |
| icon | text | NULL | - | Agent icon/emoji |
| pause_reason | text | NULL | - | Reason for pause |
| paused_at | timestamptz | NULL | - | When agent was paused |
| model_config | jsonb | NULL | - | AI model configuration |
| device_config | jsonb | NULL | - | Device configuration |
| deleted_at | timestamp | NULL | - | Soft delete timestamp |
| is_active | boolean | true | - | Active flag |

## Indexes

```sql
-- Composite index for company + status queries
create index agents_company_status_idx on public.agents using btree (company_id, status);

-- Composite index for reporting hierarchy queries
create index agents_company_reports_to_idx on public.agents using btree (company_id, reports_to);

-- Index for model provider queries
create index idx_agents_model_provider on public.agents using btree (((model_config ->> 'provider')));

-- Index for device ID queries
create index idx_agents_device_id on public.agents using btree (((device_config ->> 'device_id')));

-- Index for soft-delete filtering
create index idx_agents_deleted_at on public.agents using btree (deleted_at);

-- Index for active status filtering
create index idx_agents_is_active on public.agents using btree (is_active);
```

## Relationships

- **Many-to-One**: Each agent belongs to exactly one company (`companies.id`)
- **Self-Referencing**: Agents can report to other agents (`agents.id`)
- **Soft Delete**: Agents are soft-deleted via `deleted_at` timestamp

## Query Examples

### All Agents with Company Details

```sql
SELECT 
    a.id AS agent_id,
    a.name AS agent_name,
    a.role,
    a.title,
    a.status,
    a.adapter_type,
    a.budget_monthly_cents,
    a.spent_monthly_cents,
    a.last_heartbeat_at,
    a.is_active,
    a.pause_reason,
    a.paused_at,
    a.deleted_at,
    a.created_at,
    a.updated_at,
    a.capabilities,
    a.icon,
    a.model_config,
    a.device_config,
    a.adapter_config,
    a.runtime_config,
    a.permissions,
    a.metadata,
    c.id AS company_id,
    c.name AS company_name,
    c.status AS company_status,
    r.name AS reports_to_name,
    r.role AS reports_to_role,
    mc.name AS manager_company_name
FROM 
    public.agents a
LEFT JOIN 
    public.companies c ON a.company_id = c.id
LEFT JOIN 
    public.agents r ON a.reports_to = r.id
LEFT JOIN 
    public.companies mc ON r.company_id = mc.id
WHERE 
    a.deleted_at IS NULL
ORDER BY 
    c.name, a.name;
```

### Active Agents by Company

```sql
SELECT 
    c.name AS company_name,
    COUNT(a.id) AS agent_count
FROM 
    companies c
LEFT JOIN 
    agents a ON c.id = a.company_id 
        AND a.deleted_at IS NULL 
        AND a.is_active = true
GROUP BY 
    c.name
ORDER BY 
    agent_count DESC;
```

### Agents by Status

```sql
SELECT 
    status,
    COUNT(*) AS count
FROM 
    agents
WHERE 
    deleted_at IS NULL
GROUP BY 
    status
ORDER BY 
    count DESC;
```

### Reporting Hierarchy (Top-Level Agents)

```sql
SELECT 
    a.name AS agent_name,
    a.role,
    c.name AS company_name
FROM 
    agents a
JOIN 
    companies c ON a.company_id = c.id
WHERE 
    a.reports_to IS NULL
    AND a.deleted_at IS NULL
ORDER BY 
    c.name, a.name;
```

## Common Roles

| Role | Description |
|------|-------------|
| `ceo` | Chief Executive Officer / Company Head |
| `executive` | Executive-level management |
| `general` | General purpose agents |
| `specialist` | Specialized domain agents |
| `engineering` | Engineering-focused agents |
| `security` | Security-focused agents |
| `data` | Data-focused agents |
| `growth` | Growth/marketing agents |
| `strategy` | Strategic planning agents |
| `product` | Product-focused agents |
| `administration` | Administrative agents |

## Common Status Values

| Status | Description |
|--------|-------------|
| `idle` | Agent is available |
| `running` | Agent is actively processing |
| `paused` | Agent is paused |
| `error` | Agent encountered an error |

## Common Adapter Types

| Adapter Type | Description |
|--------------|-------------|
| `http` | HTTP-based remote agent |
| `process` | Local process-based agent |
| `hermes_local` | Hermes local adapter |

## Notes

- Agents use UUID primary keys generated via `gen_random_uuid()`
- Soft deletion via `deleted_at` timestamp (NULL = not deleted)
- JSONB columns (`adapter_config`, `model_config`, `device_config`, etc.) store structured configuration
- Monthly budget/spend tracking in cents for precision
- Self-referential FK allows unlimited hierarchy depth
- Company-scoped queries should always filter by `company_id`

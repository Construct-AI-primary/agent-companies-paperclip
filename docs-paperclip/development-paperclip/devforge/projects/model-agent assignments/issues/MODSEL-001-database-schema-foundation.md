---
title: Database Schema Foundation for Model Assessment System
issue_id: MODSEL-001
status: open
priority: critical
assignee: database-infraforge
company: infraforge-ai
team: infrastructure
parent: DEVFORGE-GOAL-001
created_date: 2026-04-08
due_date: 2026-04-15
estimated_hours: 40
actual_hours: 0
---

# MODSEL-001: Database Schema Foundation for Model Assessment System

## Issue Summary

Implement the foundational database schema extensions required for the agent model assessment and selection system. This includes creating new tables for models, model benchmarks, agent models, model change log, and task assessments.

## Background

The current Paperclip database has basic agent runtime tracking but lacks the comprehensive model performance and assessment data structures needed for intelligent model selection. This issue addresses the database schema gaps identified in the implementation plan.

## Requirements

### Database Tables to Create

#### 1. Models Table (Master Model Registry)
```sql
CREATE TABLE public.models (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  model_id character varying(100) NOT NULL,
  provider character varying(50) NOT NULL,
  display_name character varying(100) NOT NULL,
  input_price numeric(10,6) NOT NULL,
  output_price numeric(10,6) NOT NULL,
  cache_read_price numeric(10,6) NULL,
  context_window integer NOT NULL,
  max_output_tokens integer NULL,
  coding_index integer NULL,
  human_eval numeric(5,2) NULL,
  swe_bench numeric(5,2) NULL,
  live_code_bench numeric(5,2) NULL,
  overall_score integer NULL,
  efficiency_ratio numeric(10,2) NULL,
  value_tier character varying(20) NULL,
  is_active boolean NULL DEFAULT true,
  is_recommended boolean NULL DEFAULT false,
  last_benchmark_update timestamp with time zone NULL,
  benchmark_source character varying(100) NULL,
  notes text NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT models_pkey PRIMARY KEY (id),
  CONSTRAINT models_model_id_key UNIQUE (model_id)
);
```

#### 2. Model Benchmarks Table (Historical Performance Data)
```sql
CREATE TABLE public.model_benchmarks (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  model_id uuid NULL,
  benchmark_date date NOT NULL,
  source character varying(100) NOT NULL,
  coding_index integer NULL,
  human_eval numeric(5,2) NULL,
  swe_bench numeric(5,2) NULL,
  live_code_bench numeric(5,2) NULL,
  mbpp numeric(5,2) NULL,
  overall_score integer NULL,
  input_price numeric(10,6) NULL,
  output_price numeric(10,6) NULL,
  notes text NULL,
  raw_data jsonb NULL,
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT model_benchmarks_pkey PRIMARY KEY (id),
  CONSTRAINT model_benchmarks_model_id_benchmark_date_source_key UNIQUE (model_id, benchmark_date, source),
  CONSTRAINT model_benchmarks_model_id_fkey FOREIGN KEY (model_id) REFERENCES models(id)
);
```

#### 3. Agent Models Table (Agent-Model Assignments)
```sql
CREATE TABLE public.agent_models (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  agent_id character varying(100) NOT NULL,
  model_id character varying(255) NULL,
  assignment_type character varying(20) NOT NULL DEFAULT 'primary',
  priority integer NULL DEFAULT 1,
  temperature numeric(3,2) NULL DEFAULT 0.7,
  max_tokens integer NULL DEFAULT 4096,
  assigned_at timestamp with time zone NULL DEFAULT now(),
  assigned_by character varying(100) NULL,
  reason text NULL,
  total_requests integer NULL DEFAULT 0,
  total_tokens_input bigint NULL DEFAULT 0,
  total_tokens_output bigint NULL DEFAULT 0,
  total_cost numeric(10,4) NULL DEFAULT 0,
  avg_latency_ms integer NULL,
  error_rate numeric(5,4) NULL DEFAULT 0,
  is_active boolean NULL DEFAULT true,
  created_at timestamp with time zone NULL DEFAULT now(),
  updated_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT agent_models_pkey PRIMARY KEY (id),
  CONSTRAINT agent_models_agent_id_assignment_type_key UNIQUE (agent_id, assignment_type)
);
```

#### 4. Model Change Log Table (Audit Trail)
```sql
CREATE TABLE public.model_change_log (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  model_id uuid NULL,
  agent_id character varying(100) NULL,
  change_type character varying(50) NOT NULL,
  old_value jsonb NULL,
  new_value jsonb NULL,
  changed_by character varying(100) NULL,
  reason text NULL,
  change_source character varying(50) NULL DEFAULT 'manual',
  created_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT model_change_log_pkey PRIMARY KEY (id),
  CONSTRAINT model_change_log_model_id_fkey FOREIGN KEY (model_id) REFERENCES models(id)
);
```

#### 5. Task Assessment Table
```sql
CREATE TABLE public.task_assessments (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  issue_id uuid NOT NULL REFERENCES issues(id),
  agent_id uuid REFERENCES agents(id),
  assessment_criteria jsonb NOT NULL DEFAULT '{}',
  complexity_score integer NOT NULL CHECK (complexity_score >= 1 AND complexity_score <= 10),
  time_sensitivity varchar(20) NOT NULL DEFAULT 'medium',
  accuracy_requirement varchar(20) NOT NULL DEFAULT 'standard',
  recommended_models jsonb NOT NULL DEFAULT '[]',
  selected_model varchar(255),
  assessment_reason text,
  assessed_by varchar(100),
  assessed_at timestamp with time zone NOT NULL DEFAULT now(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT task_assessments_pkey PRIMARY KEY (id),
  CONSTRAINT task_assessments_issue_unique UNIQUE (issue_id)
);
```

### Indexes Required
- Models table: provider, value_tier, is_active, efficiency_ratio
- Model benchmarks: model_id, benchmark_date
- Agent models: agent_id, is_active, model_id
- Model change log: model_id, agent_id, change_type, created_at
- Task assessments: issue_id

## Acceptance Criteria

- [ ] All 5 database tables created with correct schema
- [ ] All foreign key constraints properly defined
- [ ] All indexes created for performance
- [ ] Drizzle schema definitions updated
- [ ] Database migrations generated and tested
- [ ] TypeScript interfaces created for all tables
- [ ] Schema validation passes in development environment

## Dependencies

- None (foundational work)

## Testing

- Database migration execution
- Schema validation
- Foreign key constraint testing
- Index performance verification

## Related Issues

- MODSEL-002: Drizzle Schema Implementation
- MODSEL-003: Database Migration Generation

## Notes

This issue is part of Phase 1 (Foundation) of the Agent Model Assessment Procedure implementation plan.
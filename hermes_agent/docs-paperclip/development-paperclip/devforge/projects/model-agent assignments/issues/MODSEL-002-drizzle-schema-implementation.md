---
title: Drizzle Schema Implementation for Model Assessment System
issue_id: MODSEL-002
status: open
priority: critical
assignee: forge-devforge
company: devforge-ai
team: engineering
parent: DEVFORGE-GOAL-001
created_date: 2026-04-08
due_date: 2026-04-12
estimated_hours: 24
actual_hours: 0
---

# MODSEL-002: Drizzle Schema Implementation for Model Assessment System

## Issue Summary

Implement Drizzle ORM schema definitions for all new database tables required by the agent model assessment and selection system. This includes creating TypeScript schema files that match the SQL definitions from MODSEL-001.

## Background

Paperclip uses Drizzle ORM for database schema management and migrations. The new tables defined in MODSEL-001 need corresponding Drizzle schema definitions to enable type-safe database operations and automatic migration generation.

## Requirements

### Drizzle Schema Files to Create

Create the following files in `packages/db/src/schema/`:

#### 1. models.ts
```typescript
import { pgTable, uuid, varchar, decimal, integer, boolean, timestamp, text, index } from 'drizzle-orm/pg-core';

export const models = pgTable('models', {
  id: uuid('id').primaryKey().defaultRandom(),
  modelId: varchar('model_id', { length: 100 }).notNull().unique(),
  provider: varchar('provider', { length: 50 }).notNull(),
  displayName: varchar('display_name', { length: 100 }).notNull(),
  inputPrice: decimal('input_price', { precision: 10, scale: 6 }).notNull(),
  outputPrice: decimal('output_price', { precision: 10, scale: 6 }).notNull(),
  cacheReadPrice: decimal('cache_read_price', { precision: 10, scale: 6 }),
  contextWindow: integer('context_window').notNull(),
  maxOutputTokens: integer('max_output_tokens'),
  codingIndex: integer('coding_index'),
  humanEval: decimal('human_eval', { precision: 5, scale: 2 }),
  sweBench: decimal('swe_bench', { precision: 5, scale: 2 }),
  liveCodeBench: decimal('live_code_bench', { precision: 5, scale: 2 }),
  overallScore: integer('overall_score'),
  efficiencyRatio: decimal('efficiency_ratio', { precision: 10, scale: 2 }),
  valueTier: varchar('value_tier', { length: 20 }),
  isActive: boolean('is_active').default(true),
  isRecommended: boolean('is_recommended').default(false),
  lastBenchmarkUpdate: timestamp('last_benchmark_update', { withTimezone: true }),
  benchmarkSource: varchar('benchmark_source', { length: 100 }),
  notes: text('notes'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  providerIdx: index('idx_models_provider').on(table.provider),
  valueTierIdx: index('idx_models_value_tier').on(table.valueTier),
  isActiveIdx: index('idx_models_is_active').on(table.isActive),
  efficiencyIdx: index('idx_models_efficiency').on(table.efficiencyRatio.desc()),
}));
```

#### 2. modelBenchmarks.ts
```typescript
import { pgTable, uuid, date, varchar, integer, decimal, text, jsonb, timestamp, index, uniqueIndex } from 'drizzle-orm/pg-core';
import { models } from './models';

export const modelBenchmarks = pgTable('model_benchmarks', {
  id: uuid('id').primaryKey().defaultRandom(),
  modelId: uuid('model_id').references(() => models.id),
  benchmarkDate: date('benchmark_date').notNull(),
  source: varchar('source', { length: 100 }).notNull(),
  codingIndex: integer('coding_index'),
  humanEval: decimal('human_eval', { precision: 5, scale: 2 }),
  sweBench: decimal('swe_bench', { precision: 5, scale: 2 }),
  liveCodeBench: decimal('live_code_bench', { precision: 5, scale: 2 }),
  mbpp: decimal('mbpp', { precision: 5, scale: 2 }),
  overallScore: integer('overall_score'),
  inputPrice: decimal('input_price', { precision: 10, scale: 6 }),
  outputPrice: decimal('output_price', { precision: 10, scale: 6 }),
  notes: text('notes'),
  rawData: jsonb('raw_data'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  modelIdx: index('idx_benchmarks_model').on(table.modelId),
  dateIdx: index('idx_benchmarks_date').on(table.benchmarkDate.desc()),
  uniqueBenchmark: uniqueIndex('idx_benchmarks_unique').on(table.modelId, table.benchmarkDate, table.source),
}));
```

#### 3. agentModels.ts
```typescript
import { pgTable, uuid, varchar, integer, decimal, timestamp, text, bigint, boolean, index, uniqueIndex } from 'drizzle-orm/pg-core';

export const agentModels = pgTable('agent_models', {
  id: uuid('id').primaryKey().defaultRandom(),
  agentId: varchar('agent_id', { length: 100 }).notNull(),
  modelId: varchar('model_id', { length: 255 }),
  assignmentType: varchar('assignment_type', { length: 20 }).notNull().default('primary'),
  priority: integer('priority').default(1),
  temperature: decimal('temperature', { precision: 3, scale: 2 }).default('0.7'),
  maxTokens: integer('max_tokens').default(4096),
  assignedAt: timestamp('assigned_at', { withTimezone: true }).defaultNow(),
  assignedBy: varchar('assigned_by', { length: 100 }),
  reason: text('reason'),
  totalRequests: integer('total_requests').default(0),
  totalTokensInput: bigint('total_tokens_input', { mode: 'number' }).default(0),
  totalTokensOutput: bigint('total_tokens_output', { mode: 'number' }).default(0),
  totalCost: decimal('total_cost', { precision: 10, scale: 4 }).default('0'),
  avgLatencyMs: integer('avg_latency_ms'),
  errorRate: decimal('error_rate', { precision: 5, scale: 4 }).default('0'),
  isActive: boolean('is_active').default(true),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  agentIdx: index('idx_agent_models_agent').on(table.agentId),
  activeIdx: index('idx_agent_models_active').on(table.isActive),
  modelIdx: index('idx_agent_models_model').on(table.modelId),
  uniqueAgentAssignment: uniqueIndex('idx_agent_models_unique').on(table.agentId, table.assignmentType),
}));
```

#### 4. modelChangeLog.ts
```typescript
import { pgTable, uuid, varchar, jsonb, timestamp, text, index } from 'drizzle-orm/pg-core';
import { models } from './models';

export const modelChangeLog = pgTable('model_change_log', {
  id: uuid('id').primaryKey().defaultRandom(),
  modelId: uuid('model_id').references(() => models.id),
  agentId: varchar('agent_id', { length: 100 }),
  changeType: varchar('change_type', { length: 50 }).notNull(),
  oldValue: jsonb('old_value'),
  newValue: jsonb('new_value'),
  changedBy: varchar('changed_by', { length: 100 }),
  reason: text('reason'),
  changeSource: varchar('change_source', { length: 50 }).default('manual'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  modelIdx: index('idx_change_log_model').on(table.modelId),
  agentIdx: index('idx_change_log_agent').on(table.agentId),
  typeIdx: index('idx_change_log_type').on(table.changeType),
  createdIdx: index('idx_change_log_created').on(table.createdAt.desc()),
}));
```

#### 5. taskAssessments.ts
```typescript
import { pgTable, uuid, integer, varchar, jsonb, text, timestamp, index, uniqueIndex, check } from 'drizzle-orm/pg-core';

export const taskAssessments = pgTable('task_assessments', {
  id: uuid('id').primaryKey().defaultRandom(),
  issueId: uuid('issue_id').notNull(), // References issues(id) - will be added when issues table is available
  agentId: uuid('agent_id'), // References agents(id) - will be added when agents table is available
  assessmentCriteria: jsonb('assessment_criteria').notNull().default('{}'),
  complexityScore: integer('complexity_score').notNull(),
  timeSensitivity: varchar('time_sensitivity', { length: 20 }).notNull().default('medium'),
  accuracyRequirement: varchar('accuracy_requirement', { length: 20 }).notNull().default('standard'),
  recommendedModels: jsonb('recommended_models').notNull().default('[]'),
  selectedModel: varchar('selected_model', { length: 255 }),
  assessmentReason: text('assessment_reason'),
  assessedBy: varchar('assessed_by', { length: 100 }),
  assessedAt: timestamp('assessed_at', { withTimezone: true }).notNull().defaultNow(),
  createdAt: timestamp('created_at', { withTimezone: true }).notNull().defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).notNull().defaultNow(),
}, (table) => ({
  issueIdx: index('idx_task_assessments_issue').on(table.issueId),
  uniqueIssue: uniqueIndex('idx_task_assessments_unique').on(table.issueId),
  complexityCheck: check('complexity_score_check', table.complexityScore >= 1 && table.complexityScore <= 10),
}));
```

### Schema Index Updates

Update `packages/db/src/schema/index.ts` to export all new tables:

```typescript
export * from './models';
export * from './modelBenchmarks';
export * from './agentModels';
export * from './modelChangeLog';
export * from './taskAssessments';
```

## Acceptance Criteria

- [ ] All 5 Drizzle schema files created with correct table definitions
- [ ] All indexes and constraints properly defined
- [ ] TypeScript compilation passes without errors
- [ ] Schema exports updated in index.ts
- [ ] Drizzle schema validation passes
- [ ] Type-safe database operations possible

## Dependencies

- MODSEL-001: Database Schema Foundation (for SQL definitions)

## Testing

- TypeScript compilation
- Drizzle schema validation
- Type inference testing
- Schema export verification

## Related Issues

- MODSEL-001: Database Schema Foundation
- MODSEL-003: Database Migration Generation

## Notes

This issue focuses on the TypeScript/Drizzle implementation of the database schema. The actual SQL table creation is handled in MODSEL-001.
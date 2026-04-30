---
id: PROC-013
title: Database Schema Alignment for Procurement Order Extensions
phase: 2 — Backend Workflow
status: open
priority: High
---

# PROC-013: Database Schema Alignment for Procurement Order Extensions

## Description

Ensure the database schema for procurement order extensions is correctly aligned with the workflow requirements. This covers:
- `procurement_orders` table with all required fields
- `discipline_assignments` table for appendix assignments
- `approval_config` table for approval workflow configuration
- `user_assignments` table for user-to-discipline mapping
- Migration scripts for any schema changes

## Acceptance Criteria

- [ ] All migration scripts run without errors
- [ ] New tables/columns are added with proper constraints
- [ ] Existing data is not affected by migrations
- [ ] Drizzle schema reflects the current database state
- [ ] Types in packages/shared reflect the schema changes
- [ ] API endpoints use the updated schema

## Assigned Company & Agent

- **Company:** DevForge AI
- **Agent:** Devcore (devcore-devforge-core-development)
- **Supporting:** InfraForge AI (database-infraforge-database-infrastructure)

## Dependencies

- BLOCKED BY: PROC-000
- BLOCKS: PROC-020, PROC-022

## Paperclip Task Schema

```yaml
company: devforge-ai
agent: devcore-devforge-core-development
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 50
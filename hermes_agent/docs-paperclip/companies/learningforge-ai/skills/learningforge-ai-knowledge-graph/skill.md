---
name: learningforge-ai-knowledge-graph
description: >
  Use when building knowledge flow graphs, mapping agent-to-content relationships,
  or tracking content lineage is needed.
---

# Learning Forge AI - Knowledge Graph Skill

## Overview
Builds and maintains knowledge flow graphs mapping agents → files → lessons → users. Enables knowledge transfer path queries and visualization.

## When to Use
- When building knowledge graphs is needed
- When mapping content relationships is required
- When tracking user content journeys is needed
- When knowledge flow queries are needed
- **Don't use when:** Static content storage is needed

## Core Procedures

### Knowledge Graph Workflow
1. **Relationship Mapping** - Map agent-to-content relationships
2. **Lineage Tracking** - Track content origins and evolution
3. **Flow Visualization** - Build knowledge flow maps
4. **Usage Analytics** - Analyze content usage patterns
5. **Query Responses** - Answer knowledge flow queries

## Sources
- Agent activity logs
- VFS file metadata
- User learning records
- Content dependency maps

## Agent Assignment
**Primary Agent:** learningforge-ai-knowledge-flow-agent
**Reports To:** learningforge-ai-knowledge-flow-division-lead

## Output
Writes to `/workspace/knowledge/`

## Last Updated
2026-04-11

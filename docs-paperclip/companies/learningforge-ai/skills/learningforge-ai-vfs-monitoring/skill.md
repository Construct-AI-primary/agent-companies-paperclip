---
name: learningforge-ai-vfs-monitoring
description: >
  Use when monitoring Virtual File System changes, logging file operations,
  or tracking document changes is needed. Essential for knowledge flow tracking.
---

# Learning Forge AI - VFS Monitoring Skill

## Overview
Monitors and logs Virtual File System changes for knowledge flow tracking. Subscribes to VFS events and maintains change history.

## When to Use
- When monitoring VFS file changes is needed
- When logging file operations is required
- When tracking document changes is needed
- When downstream agent triggers are needed
- **Don't use when:** One-time file operations are needed

## Core Procedures

### VFS Monitoring Workflow
1. **Change Detection** - Monitor VFS change streams
2. **Operation Logging** - Log file operations with metadata
3. **Downstream Triggers** - Trigger dependent agents
4. **History Maintenance** - Maintain file change history
5. **Audit Integration** - Write to audit trail

## Sources
- VFS change streams
- File operation hooks
- Audit system connections

## Agent Assignment
**Primary Agent:** learningforge-ai-vfs-watcher
**Reports To:** learningforge-ai-knowledge-flow-division-lead

## Output
Writes to audit trail, triggers downstream agents

## Last Updated
2026-04-11

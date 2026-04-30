---
title: Memory System Prompt Template for OpenClaw
description: Standardized template for leveraging Construct AI memory system with Gigabrain in OpenClaw
version: 1.0
memory_layer: durable_knowledge
para_section: docs/memory-stack/templates
gigabrain_tags: prompt-template, memory-system, openclaw-integration, gigabrain-usage, knowledge-management
openstinger_context: prompt-engineering, memory-system-integration, ai-assistant-optimization
last_updated: 2026-03-21
related_docs:
  - docs_construct_ai/Cline Memory System Usage Guide.md
  - WORKSPACE_MEMORY_SYSTEM.md
  - docs_construct_ai/Memory System Quick Reference Methodology.md
---

# Memory System Prompt Template for OpenClaw

## Overview

This template provides a standardized structure for prompts that leverage the full power of the Construct AI memory system with Gigabrain integration in OpenClaw. Use this template to ensure comprehensive knowledge access, intelligent search, and contextual awareness.

## Key Differences from Cline Template

| Aspect | OpenClaw Template | Cline Template |
|--------|------------------|----------------|
| **AI Assistant Context** | Native OpenClaw terminology and features | Cline-specific adaptations |
| **Plugin Architecture** | OpenClaw plugin system (lossless-claw, gigabrain) | Cline skill system |
| **Command Syntax** | OpenClaw CLI commands | Cline tool equivalents |
| **Config Files** | OpenClaw config locations | Cline configuration |
| **Session Management** | OpenClaw gateway/sessions | Cline conversation context |

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain in OpenClaw:

**PARA Navigation:**
- Access [specific PARA paths, e.g., docs_construct_ai/para/pages/disciplines/01900_procurement/]
- Reference related areas: [additional PARA paths]

**Gigabrain Search:**
- Search gigabrain tags for "[primary-tag], [secondary-tag], [context-tag]"
- Filter by tags: [relevant tags like "security", "procurement", "coding-standards"]

**Memory Context:**
- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with [related disciplines/documents]
- Check memory/YYYY-MM-DD.md for recent session context

**Plugin Integration:**
- Utilize lossless-claw for session continuity
- Leverage OpenStinger for cross-session recall (if available)
- Apply gigabrain automatic capture and retrieval

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar procedures
- Build on established organizational knowledge

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## OpenClaw-Specific Template Variables

| Variable | Purpose | OpenClaw Examples | Required |
|----------|---------|-------------------|----------|
| `[TASK DESCRIPTION]` | Clear statement of what you want to accomplish | "Implement user authentication system", "Analyze security vulnerabilities" | ✅ |
| `[specific PARA paths]` | Direct paths to relevant knowledge areas | `docs_construct_ai/para/pages/disciplines/01900_procurement/` | ✅ |
| `[additional PARA paths]` | Related knowledge areas for context | `docs_construct_ai/para/pages/codebase/security/` | ❌ |
| `[primary-tag], [secondary-tag]` | Main search terms (2-3 max) | `"security", "compliance", "api"` | ✅ |
| `[relevant tags]` | Additional filtering tags | `"workflow", "implementation", "testing"` | ❌ |
| `[related disciplines/documents]` | Connected knowledge areas | "procurement workflows, safety procedures" | ❌ |
| `[SPECIFIC REQUIREMENTS]` | Detailed instructions or constraints | "Include error handling", "Follow REST API standards" | ❌ |

## OpenClaw-Specific Use Case Templates

### Development Implementation with Plugin Integration
```
Implement [FEATURE] using the memory system in OpenClaw:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/
- Reference docs_construct_ai/para/pages/codebase/development/

Gigabrain Search:
- Search gigabrain tags for "[feature-type]", "implementation", "[domain]"

Memory Context:
- Include memory headers and cross-references for context
- Reference coding standards from docs_construct_ai/para/pages/codebase/coding-standards/

Plugin Integration:
- Use lossless-claw for maintaining development session context
- Enable gigabrain automatic capture for this implementation
- Check OpenStinger for similar past implementations

Create a complete implementation following established patterns.
```

### Research & Analysis with Cross-Session Recall
```
Analyze [TOPIC] using memory system integration in OpenClaw:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/
- Reference docs_construct_ai/para/pages/codebase/[RELEVANT_AREA]/

Gigabrain Search:
- Search gigabrain tags for "[topic]", "[subtopic]", "[context]"

Memory Context:
- Include cross-references to related disciplines
- Check memory headers for related_docs and dependencies

Plugin Integration:
- Query OpenStinger for cross-session analysis patterns
- Use lossless-claw to maintain analysis thread continuity
- Enable gigabrain for automatic knowledge capture during research

Provide comprehensive analysis with organizational context.
```

### Documentation Creation with Memory Headers
```
Create [DOCUMENT_TYPE] with memory system integration in OpenClaw:

PARA Navigation:
- Use docs_construct_ai/para/pages/codebase/docs/ as template
- Reference docs_construct_ai/para/pages/[RELEVANT_AREA]/

Gigabrain Search:
- Search gigabrain tags for "[doc-type]", "documentation", "[domain]"

Memory Context:
- Include memory headers with appropriate gigabrain_tags
- Cross-reference related documents and procedures

Plugin Integration:
- Use gigabrain to automatically tag and categorize the new document
- Ensure lossless-claw captures documentation creation context
- Link to OpenStinger for related documentation patterns

Structure output for future memory system integration.
```

### Troubleshooting & Debugging with Session Recovery
```
Troubleshoot [ISSUE] using memory system resources in OpenClaw:

PARA Navigation:
- Access docs_construct_ai/para/pages/codebase/errors/
- Reference docs_construct_ai/para/pages/disciplines/[RELEVANT_DISCIPLINE]/

Gigabrain Search:
- Search gigabrain tags for "troubleshooting", "[issue-type]", "[component]"

Memory Context:
- Include cross-references to similar issues and solutions
- Check memory/YYYY-MM-DD.md for recent related work

Plugin Integration:
- Use lossless-claw to recover debugging session context
- Query OpenStinger for similar issue patterns across sessions
- Enable gigabrain for capturing resolution steps

Provide systematic debugging approach with organizational knowledge.
```

## OpenClaw-Specific Best Practices

### Plugin Integration Guidelines
1. **Lossless-Claw Priority**: Use for session continuity in complex tasks
2. **OpenStinger When Available**: Leverage for cross-session pattern recognition
3. **Gigabrain Always**: Enable automatic capture for knowledge preservation
4. **Gateway Restart**: Remember to restart after config changes

### OpenClaw Command Integration
- Use `openclaw gateway restart` after plugin configuration changes
- Reference OpenClaw config snippets for plugin setup
- Utilize OpenClaw's native file operations for memory system access

### Session Management
- Leverage lossless-claw for long-running development sessions
- Use OpenStinger for accessing patterns from previous sessions
- Maintain session context through OpenClaw's session management

## OpenClaw Integration Checklist

### For Every Prompt
- [ ] **Task Description**: Clear, specific objective
- [ ] **PARA Navigation**: At least one specific path
- [ ] **Gigabrain Search**: 2-3 relevant tags
- [ ] **Memory Context**: Request headers and cross-references
- [ ] **Plugin Integration**: Specify OpenClaw plugins to utilize
- [ ] **Knowledge Integration**: Request pattern identification

### For Complex Tasks
- [ ] **Multi-Area Access**: Multiple PARA areas referenced
- [ ] **Cross-Discipline Links**: Related discipline connections
- [ ] **Session Context**: Recent memory integration
- [ ] **Plugin Utilization**: lossless-claw, OpenStinger, gigabrain specified
- [ ] **Gateway Management**: Restart requirements noted
- [ ] **Structured Output**: Organized response format

## OpenClaw-Specific Success Metrics

### Quality Indicators
- **Relevance**: Information directly addresses the task
- **Context**: Includes organizational knowledge and patterns
- **Connections**: Shows relationships between knowledge areas
- **Completeness**: Comprehensive coverage of relevant areas
- **Actionability**: Provides practical, implementable guidance

### Plugin Integration Indicators
- **Session Continuity**: lossless-claw effectively maintains context
- **Cross-Session Recall**: OpenStinger provides relevant historical patterns
- **Automatic Capture**: gigabrain successfully captures new knowledge
- **Gateway Stability**: No restarts required during normal operation

## OpenClaw Troubleshooting

### Plugin-Related Issues
```
If plugins aren't responding: "Check OpenClaw plugin configuration and ensure lossless-claw, gigabrain, and OpenStinger are properly enabled in your config."
```

### Memory System Access Issues
```
If memory access fails: "Verify PARA paths are correct and that the memory system files are accessible to OpenClaw."
```

### Session Continuity Problems
```
If session context is lost: "Ensure lossless-claw is enabled and check OpenClaw gateway status."
```

## Version History

- **v1.0** (2026-03-21): Initial OpenClaw-specific template creation
- Adapted core template for OpenClaw plugin architecture
- Added OpenClaw-specific integration guidelines
- Included plugin utilization patterns and troubleshooting

## Related Resources

- [Cline Memory System Usage Guide](docs_construct_ai/Cline Memory System Usage Guide.md)
- [Memory System Quick Reference Methodology](docs_construct_ai/Memory System Quick Reference Methodology.md)
- [WORKSPACE_MEMORY_SYSTEM.md](WORKSPACE_MEMORY_SYSTEM.md)
- [PARA Navigation Structure](PARA.md)
- [OpenClaw Config Snippets](docs/memory-stack/examples/openclaw-config-snippets.md)
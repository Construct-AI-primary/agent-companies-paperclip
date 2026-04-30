---
title: Memory System Prompt Template
description: Standardized template for leveraging Construct AI memory system with Gigabrain in Cline
version: 1.1
memory_layer: durable_knowledge
para_section: docs/memory-stack/templates
gigabrain_tags: prompt-template, memory-system, cline-integration, gigabrain-usage, knowledge-management, memory-integration
openstinger_context: prompt-engineering, memory-system-integration, ai-assistant-optimization
last_updated: 2026-03-23
related_docs:
  - docs_construct_ai/Cline Memory System Usage Guide.md
  - WORKSPACE_MEMORY_SYSTEM.md
  - docs_construct_ai/Memory System Quick Reference Methodology.md
---

# Memory System Prompt Template

## Overview

This template provides a standardized structure for prompts that leverage the full power of the Construct AI memory system with Gigabrain integration in Cline. Use this template to ensure comprehensive knowledge access, intelligent search, and contextual awareness.

## Core Template Structure

```
[TASK DESCRIPTION]

Using the Construct AI memory system with Gigabrain:

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

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns across similar procedures
- Build on established organizational knowledge

[SPECIFIC REQUIREMENTS OR QUESTIONS]
```

## Template Variables Guide

| Variable | Purpose | Examples | Required |
|----------|---------|----------|----------|
| `[TASK DESCRIPTION]` | Clear statement of what you want to accomplish | "Implement user authentication system", "Analyze security vulnerabilities" | ✅ |
| `[specific PARA paths]` | Direct paths to relevant knowledge areas | `docs_construct_ai/para/pages/disciplines/01900_procurement/` | ✅ |
| `[additional PARA paths]` | Related knowledge areas for context | `docs_construct_ai/para/pages/codebase/security/` | ❌ |
| `[primary-tag], [secondary-tag]` | Main search terms (2-3 max) | `"security", "compliance", "api"` | ✅ |
| `[relevant tags]` | Additional filtering tags | `"workflow", "implementation", "testing"` | ❌ |
| `[related disciplines/documents]` | Connected knowledge areas | "procurement workflows, safety procedures" | ❌ |
| `[SPECIFIC REQUIREMENTS]` | Detailed instructions or constraints | "Include error handling", "Follow REST API standards" | ❌ |

## Use Case Templates

### Development Implementation
```
Implement [FEATURE] using the memory system:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/
- Reference docs_construct_ai/para/pages/codebase/development/

Gigabrain Search:
- Search gigabrain tags for "[feature-type]", "implementation", "[domain]"

Memory Context:
- Include memory headers and cross-references for context
- Reference coding standards from docs_construct_ai/para/pages/codebase/coding-standards/

Create a complete implementation following established patterns.
```

### Research & Analysis
```
Analyze [TOPIC] using memory system integration:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/
- Reference docs_construct_ai/para/pages/codebase/[RELEVANT_AREA]/

Gigabrain Search:
- Search gigabrain tags for "[topic]", "[subtopic]", "[context]"

Memory Context:
- Include cross-references to related disciplines
- Check memory headers for related_docs and dependencies

Provide comprehensive analysis with organizational context.
```

### Documentation Creation
```
Create [DOCUMENT_TYPE] with memory system integration:

PARA Navigation:
- Use docs_construct_ai/para/pages/codebase/docs/ as template
- Reference docs_construct_ai/para/pages/[RELEVANT_AREA]/

Gigabrain Search:
- Search gigabrain tags for "[doc-type]", "documentation", "[domain]"

Memory Context:
- Include memory headers with appropriate gigabrain_tags
- Cross-reference related documents and procedures

Structure output for future memory system integration.
```

### Troubleshooting & Debugging
```
Troubleshoot [ISSUE] using memory system resources:

PARA Navigation:
- Access docs_construct_ai/para/pages/codebase/errors/
- Reference docs_construct_ai/para/pages/disciplines/[RELEVANT_DISCIPLINE]/

Gigabrain Search:
- Search gigabrain tags for "troubleshooting", "[issue-type]", "[component]"

Memory Context:
- Include cross-references to similar issues and solutions
- Check memory/YYYY-MM-DD.md for recent related work

Provide systematic debugging approach with organizational knowledge.
```

### Memory System Documentation Addition
```
Add [SPECIFIC_DOCS_OR_FOLDER] to the Construct AI memory system:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/
- Reference docs_construct_ai/para/pages/codebase/docs/ for documentation patterns
- Check existing docs_construct_ai/disciplines/[DISCIPLINE_CODE]/ for source material

Gigabrain Search:
- Search gigabrain tags for "memory-system", "documentation", "[discipline]-practices"
- Filter by tags: "para-integration", "knowledge-management", "[discipline]"

Memory Context:
- Include memory headers with appropriate gigabrain_tags and para_section
- Cross-reference related disciplines and existing PARA entries
- Follow established documentation patterns from docs_construct_ai/para/pages/

Add the specified documentation to the appropriate PARA location with proper metadata headers.
```

### Bulk Discipline Documentation Integration
```
Add all documentation from docs_construct_ai/disciplines/[DISCIPLINE_CODE]/ to memory system:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/[DISCIPLINE_CODE]/ to see current state
- Reference docs_construct_ai/para/pages/codebase/docs/ for integration patterns
- Use docs_construct_ai/disciplines/[DISCIPLINE_CODE]/ as source directory

Gigabrain Search:
- Search gigabrain tags for "[discipline]-practices", "documentation", "para-integration"
- Filter by tags: "knowledge-management", "[discipline]", "discipline-integration"

Memory Context:
- Include comprehensive memory headers for each document
- Cross-reference between related documents within the discipline
- Check memory/YYYY-MM-DD.md for recent documentation work

Systematically add ALL FILES from the discipline directory following PARA conventions and memory system standards. Process every document, subdirectory, and file type without exception. Ensure 100% coverage of all discipline documentation.
```

### Comprehensive Workspace Memory Integration
```
Process ALL FILES in the workspace and integrate them into the memory system:

PARA Navigation:
- Access docs_construct_ai/para/ to understand current PARA structure
- Reference docs_construct_ai/para/pages/codebase/docs/ for documentation patterns
- Scan entire workspace recursively for all files and directories

Gigabrain Search:
- Search gigabrain tags for "bulk-integration", "workspace-wide", "comprehensive"
- Filter by tags: "memory-system", "documentation", "knowledge-management"

Memory Context:
- Include memory headers for EVERY document found
- Establish cross-references between ALL related documents
- Check memory/YYYY-MM-DD.md for integration progress tracking

Process ALL FILES without exception - every .md file, every subdirectory, every document type. Ensure complete workspace coverage with systematic PARA integration following established patterns.
```

### Specific MD Document Memory Integration
```
Add [PATH_TO_SPECIFIC_MD_FILE] to the memory system with proper metadata:

PARA Navigation:
- Access docs_construct_ai/para/pages/[APPROPRIATE_SECTION]/ for target location
- Reference docs_construct_ai/para/pages/codebase/docs/ for metadata patterns
- Use source file: [PATH_TO_SPECIFIC_MD_FILE]

Gigabrain Search:
- Search gigabrain tags for "[document-type]", "[domain]", "memory-integration"
- Filter by tags: "documentation", "para", "[relevant-discipline]"

Memory Context:
- Include complete memory header with title, description, version, para_section
- Add appropriate gigabrain_tags, related_docs, and last_updated
- Cross-reference related documents and disciplines

Integrate the specific document with proper PARA metadata and cross-references.
```

### Folder Contents Memory Addition
```
Add entire contents of [FOLDER_PATH] to memory system:

PARA Navigation:
- Access docs_construct_ai/para/pages/[TARGET_SECTION]/ for integration location
- Reference docs_construct_ai/para/pages/codebase/docs/ for documentation standards
- Source directory: [FOLDER_PATH]

Gigabrain Search:
- Search gigabrain tags for "[folder-domain]", "bulk-integration", "documentation"
- Filter by tags: "para", "knowledge-management", "[relevant-tags]"

Memory Context:
- Include memory headers for each document with proper metadata
- Establish cross-references between documents in the folder
- Check existing PARA entries to avoid duplication

Add all documents from the folder following memory system conventions and PARA structure.
```

## Best Practices

### Template Usage
1. **Start with Task Description** - Be specific and actionable
2. **Prioritize PARA Paths** - Use the most relevant knowledge areas first
3. **Limit Tags to 2-3** - More focused results, better relevance
4. **Include Memory Context** - Always request headers and cross-references
5. **Add Specific Requirements** - Guide the response format and constraints

### Optimization Tips
- **Be Specific**: Use exact PARA paths and precise gigabrain tags
- **Request Selectively**: Ask for relevant cross-references, not everything
- **Build Context**: Accumulate knowledge across related areas
- **Preserve Relationships**: Maintain cross-reference awareness
- **Structure Output**: Request organized responses with clear sections

### Common Patterns
- **Multi-Discipline**: Access 2-3 PARA areas for comprehensive context
- **Session Continuity**: Reference recent memory/YYYY-MM-DD.md entries
- **Pattern Recognition**: Request identification of similar implementations
- **Future Reference**: Structure outputs for easy memory integration

## Integration Checklist

### For Every Prompt
- [ ] **Task Description**: Clear, specific objective
- [ ] **PARA Navigation**: At least one specific path
- [ ] **Gigabrain Search**: 2-3 relevant tags
- [ ] **Memory Context**: Request headers and cross-references
- [ ] **Knowledge Integration**: Request pattern identification

### For Complex Tasks
- [ ] **Multi-Area Access**: Multiple PARA areas referenced
- [ ] **Cross-Discipline Links**: Related discipline connections
- [ ] **Session Context**: Recent memory integration
- [ ] **Relationship Mapping**: Cross-reference analysis
- [ ] **Structured Output**: Organized response format

## Success Metrics

### Quality Indicators
- **Relevance**: Information directly addresses the task
- **Context**: Includes organizational knowledge and patterns
- **Connections**: Shows relationships between knowledge areas
- **Completeness**: Comprehensive coverage of relevant areas
- **Actionability**: Provides practical, implementable guidance

### Efficiency Indicators
- **Speed**: Quick access to relevant information
- **Accuracy**: Correct application of organizational knowledge
- **Consistency**: Follows established patterns and procedures
- **Integration**: Seamlessly combines multiple knowledge sources

## Troubleshooting

### If Context Seems Incomplete
```
Request: "Expand the context by checking related_docs in memory headers, following cross-references to connected disciplines, and searching gigabrain tags for broader related content."
```

### If Navigation Is Unclear
```
Ask: "Use PARA navigation to explore docs_construct_ai/para/pages/ and identify the most relevant knowledge areas for this task, including cross-discipline connections."
```

### If Search Results Are Too Broad
```
Specify: "Filter gigabrain search results to focus on [specific context] and limit to [2-3 most relevant tags]."
```

## Memory System Improvement Suggestions

### Current System Analysis
Based on review of the procurement discipline (01900_procurement) with 200+ documents across multiple subdirectories, the following improvement opportunities have been identified:

### 1. **Automated Bulk Integration Scripts**
**Current Issue**: Manual addition of large document sets (like procurement discipline) is time-intensive
**Suggestion**: Create automated scripts that can:
- Scan discipline directories for new/unadded documents
- Generate proper memory headers automatically
- Batch process document additions to PARA
- Validate metadata completeness before integration

### 2. **Enhanced Metadata Generation**
**Current Issue**: Memory headers require manual creation with consistent formatting
**Suggestion**: Implement AI-assisted metadata generation that:
- Analyzes document content to suggest appropriate gigabrain_tags
- Identifies related_docs automatically
- Determines correct para_section placement
- Ensures version and last_updated consistency

### 3. **Cross-Reference Automation**
**Current Issue**: Manual identification of document relationships
**Suggestion**: Develop automated cross-referencing that:
- Scans document content for references to other docs
- Builds bidirectional links automatically
- Identifies discipline interdependencies
- Maintains relationship integrity during updates

### 4. **Integration Status Tracking**
**Current Issue**: No clear visibility into which documents have been added to memory
**Suggestion**: Implement tracking system that:
- Maintains integration status database
- Shows completion percentages by discipline/folder
- Identifies gaps in documentation coverage
- Provides progress reports for bulk additions

### 5. **Template Standardization**
**Current Issue**: Inconsistent document structures across disciplines
**Suggestion**: Standardize document templates with:
- Mandatory memory header sections
- Consistent formatting guidelines
- Discipline-specific metadata requirements
- Automated template validation

### 6. **Bulk Operations Templates**
**Current Issue**: Limited guidance for large-scale memory operations
**Suggestion**: Expand template library to include:
- Discipline-wide integration workflows
- Folder-based batch processing guides
- Priority-based addition strategies
- Rollback procedures for failed integrations

### 7. **Quality Assurance Integration**
**Current Issue**: Manual verification of memory additions
**Suggestion**: Implement automated QA checks that:
- Validate memory header completeness
- Check cross-reference accuracy
- Verify PARA structure compliance
- Test gigabrain tag effectiveness

### 8. **Documentation Discovery Automation**
**Current Issue**: Manual identification of documents to add
**Suggestion**: Create discovery mechanisms that:
- Scan for new documents in discipline folders
- Identify documents missing from PARA
- Prioritize additions based on usage patterns
- Alert when source documents are updated

## Version History

- **v1.0** (2026-03-21): Initial template creation with core structure and examples
- **v1.1** (2026-03-23): Added memory system documentation addition templates and improvement suggestions
- Comprehensive use case templates and best practices
- Integration checklist and troubleshooting guide

## Related Resources

- [Cline Memory System Usage Guide](docs_construct_ai/Cline Memory System Usage Guide.md)
- [Memory System Quick Reference Methodology](docs_construct_ai/Memory System Quick Reference Methodology.md)
- [WORKSPACE_MEMORY_SYSTEM.md](WORKSPACE_MEMORY_SYSTEM.md)
- [PARA Navigation Structure](PARA.md)

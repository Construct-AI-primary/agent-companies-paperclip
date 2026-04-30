---
name: Knowledge Sync
assignee: knowledgeforge-doc-analyzer
project: null
recurring: true
metadata:
  paperclip:
    tags:
      - knowledge-management
      - sync
      - recurring
---

# Knowledge Sync Task

## Purpose

This recurring task keeps the KnowledgeForge knowledge base synchronized with the latest documentation from docs-construct-ai, ensuring all agents have access to current information.

## Workflow

### 1. Document Discovery (Doc Analyzer)

- Scan the docs-construct-ai repository for new or updated documents
- Identify documents that have been deleted or moved
- Validate tag consistency across all documents
- Generate a document change report

### 2. Index Update (Doc Analyzer)

- Update the document index with new/changed documents
- Remove references to deleted documents
- Update tag mappings for changed documents
- Verify search index is current

### 3. Skill Extraction (ClieNT Integrator)

- Check for new Cline task history since last sync
- Extract successful patterns as reusable skills
- Update existing skills if patterns have evolved
- Add attribution metadata for extracted knowledge

### 4. Failure Analysis (Failure Learner)

- Review any new test failures or incidents
- Update failure patterns and prevention guidelines
- Create or update skills based on lessons learned
- Distribute knowledge to affected agents

### 5. Knowledge Distribution

- Notify agents of relevant knowledge updates
- Update agent context with new information
- Ensure all agents have consistent knowledge views

## Triggers

- Daily scheduled sync
- After significant documentation updates
- After major Cline task completions
- After production incidents

## Output

- Document change report
- Updated document index
- New or updated skills
- Agent notification summary

## Success Criteria

- All documents are indexed and searchable
- Tags are consistent and valid
- New skills are extracted from successful patterns
- Lessons from failures are captured and distributed
- All agents have current knowledge
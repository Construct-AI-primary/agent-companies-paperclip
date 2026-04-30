# KnowledgeForge Chat History Summary

Source: `/Users/Chat-history/Ali/tasks/` (907 tasks, 3130 JSON files)

## Key Knowledge Extracted from Current Session

### KnowledgeForge Company Design
- **Purpose**: Institutional memory and QA automation for multi-discipline engineering
- **Agent count**: 11 agents across 3 teams
- **Adapter type**: `hermes_local` for all agents
- **Model**: `openrouter/anthropic/claude-sonnet-4.5`

### Agent Roster
1. **Knowledge Engineering Team** (led by Doc Analyst)
   - Doc Analyst - ingests 5k tagged MDs, validates structure
   - QA Strategist - drafts QA test strategies
   - Arch Refactorer - proposes architecture-aligned refactors
   - Failure Learner - turns failures into reusable skills
   - ClieNT Integrator - imports Cline task history
   - App Guardian - ensures PRs conform to policy docs

2. **Discipline Operations Team** (led by Discipline Strategist)
   - Discipline Strategist - maps features to 50+ discipline workflows
   - Cross-Discipline Guardian - guards against multi-discipline conflicts
   - Workflow Guardian - ensures discipline-specific workflows survive changes

3. **Sector Analysis Team** (led by Sector Analyst)
   - Sector Analyst - applies sector-specific rules (oil-gas, infrastructure, etc.)
   - Sector QA Lead - generates QA tests for sector-specific workflows

### Database Schema Notes
- Companies table: `issue_prefix` has UNIQUE constraint (KnowledgeForge uses 'KFG')
- Agents table: no unique constraint on (company_id, name) - use SELECT-first pattern for idempotency
- Goals table: `level` defaults to 'task', `status` defaults to 'planned'
- No SOUL.md files exist in any company package (not part of spec)

### Knowledge Sources
- `docs-construct-ai/disciplines/` - 50+ engineering/construction discipline knowledge
- `docs-construct-ai/disciplines/*/agent-data/domain-knowledge/` - Domain knowledge files
- `docs-construct-ai/codebase/procedures/` - 16 procedure categories
- `docs-construct-ai/memory-integration/` - Agent guidelines, daily templates, testing validation
- `docs-construct-ai/testing/` - Testing strategies and results
- `docs-construct-ai/error-tracking/` - Error logs and failure analysis

### OpenCode vs OpenClaw vs Paperclip Research
- OpenCode outperforms OpenClaw for coding (LSP-aware, diff-aware workflows)
- Paperclip orchestrates multiple agents for QA review loops
- Together they achieve solid QA with proper guardrails (approval gates, test suites, human review)

### Chat History Structure
Each task in `/Users/Chat-history/Ali/tasks/` contains:
- `task_metadata.json` - Task metadata
- `ui_messages.json` - UI conversation history
- `api_conversation_history.json` - API conversation history
- `focus_chain_taskid_*.md` - Focus chain checklist
- `context_history.json` (optional) - Context history

## Historical Task Patterns (from focus chains)
- Git/worktree management is a recurring theme
- Submodule synchronization (doc, nanobot)
- Paperclip backup/restore operations
- Branch management and merge conflict resolution
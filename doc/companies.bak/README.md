---
memory_layer: durable_knowledge
para_section: pages/skills
gigabrain_tags: skills, agent-capabilities, task-patterns
openstinger_context: skill-framework, agent-abilities
last_updated: 2026-03-30
related_docs:
  - docs/codebase/agents/0000_README.md
  - docs/codebase/agents/openclaw-teams/PromptForge_AI_Team.md
  - database/migrations/2026-03-30_agent_skills_schema.sql
---

# Agent Skills Framework

## Overview

This directory contains granular skill definitions extracted from analysis of 904 chat history tasks. Skills represent frequently used patterns and techniques that agents can leverage for consistent, high-quality task execution.

## Repository Structure

**✅ CANONICAL LOCATION:** This `docs_construct_ai/skills/` directory is the primary skills repository.

### Directory Structure

```
docs_construct_ai/skills/        # CANONICAL - All skills live here
├── README.md                    # This overview
├── shared/                      # Skills shared across all companies (34 skills)
│   ├── accordion-section-management/
│   ├── agent-accuracy-enhancement/
│   ├── brainstorming/
│   └── [30+ additional shared skills]
├── construct_ai/                # Construct AI specific skills
│   ├── agent-coding-standards/
│   └── database-naming-standards/
├── devforge_ai/                 # DevForge AI specific skills
├── promptforge_ai/              # PromptForge AI specific skills
├── loopy_ai/                    # Loopy AI creative skills
│   ├── artistic-ai-ethics/
│   ├── creative-content-generation/
│   └── [additional creative skills]
├── qualityforge_ai/             # QualityForge AI specific skills
├── domainforge_ai/              # DomainForge industry-specific skills (NEW)
└── infraforge_ai/               # InfraForge infrastructure skills (NEW)
```

**Note:** All skills are organized within this directory structure by company/platform.

## Analysis Summary

- **Total Tasks Analyzed:** 904
- **Completed Tasks:** 619 (68.47% success rate)
- **Unique Skills Identified:** 18
- **Companies Supported:** 8 (Construct AI, DevForge, PromptForge, Loopy AI, QualityForge, DomainForge, InfraForge)
- **Analysis Date:** March 31, 2026

## Skills Framework Overview

This directory contains skills derived from Construct AI's comprehensive procedures and documentation. Skills are created based on actual implemented procedures rather than generic patterns, ensuring they reflect real-world usage and cross-references.

## Current Skills (Procedure-Based)

### UI/Frontend Skills
- **`state-based-button-display`** - Complete state-based button display implementation (85% frequency, 94.2% success)
- Based on: `docs/codebase/procedures/ui-frontend/0000_STATE_BASED_BUTTON_DISPLAY_PROCEDURE.md`

### Agent Development Skills
- **`agent-accuracy-enhancement`** - Precision referencing accuracy enhancement framework (95% frequency, 88.5% success)
- Based on: `docs/codebase/procedures/agent-development/0000_AGENT_ACCURACY_ENHANCEMENT_PROCEDURE.md`

### Internationalization Skills
- **`i18n-translation-management`** - Automated translation management for 11 languages (67% frequency, 89.3% success)
- Based on: `docs/codebase/procedures/i18n/0000_I18N_TRANSLATION_FILE_ORGANIZATION_PROCEDURE.md`

### Existing Skills (Original Framework)
- `brainstorming` - Creative problem-solving techniques
- `dispatching-parallel-agents` - Multi-agent coordination
- `executing-plans` - Plan execution methodologies
- `finishing-a-development-branch` - Branch completion workflows
- `receiving-code-review` - Code review response handling
- `requesting-code-review` - Code review request procedures
- `subagent-driven-development` - Subagent orchestration
- `systematic-debugging` - Structured debugging approaches
- `test-driven-development` - TDD implementation
- `using-git-worktrees` - Git worktree management
- `using-superpowers` - Advanced tool utilization
- `verification-before-completion` - Pre-completion validation
- `writing-plans` - Planning documentation
- `writing-skills` - Skill documentation creation

## Skill Categories

### UI/Frontend Development
- `state-based-button-display` - State-based navigation and button layouts

### Agent Enhancement
- `agent-accuracy-enhancement` - AI agent accuracy improvement frameworks

### Development Workflow
- `brainstorming` - Creative problem solving
- `executing-plans` - Plan execution
- `writing-plans` - Planning documentation

### Code Quality
- `receiving-code-review` - Code review handling
- `requesting-code-review` - Review requests
- `systematic-debugging` - Debugging methodologies
- `test-driven-development` - TDD practices

### Version Control
- `using-git-worktrees` - Git worktree management
- `finishing-a-development-branch` - Branch completion

### Agent Coordination
- `dispatching-parallel-agents` - Multi-agent workflows
- `subagent-driven-development` - Subagent orchestration

### Advanced Tools
- `using-superpowers` - Advanced tool utilization
- `verification-before-completion` - Quality validation
- `writing-skills` - Skill creation

## Skill File Structure

Each skill file follows this structure:

```markdown
---
memory_layer: durable_knowledge
para_section: pages/skills/{skill-name}
gigabrain_tags: [relevant tags]
openstinger_context: [context tags]
last_updated: YYYY-MM-DD
related_docs: [cross-referenced documents]
related_skills: [related skill names]
frequency_percent: X.X
success_rate_percent: X.X
---

# Skill Name

## Overview
Brief description of the skill

## When to Use This Skill
Trigger conditions for using this skill

## Step-by-Step Procedure
Detailed numbered steps with code examples

## Success Criteria
Checklist for verifying successful completion

## Common Pitfalls
List of common mistakes to avoid

## Cross-References
Links to related documentation, skills, and agents

## Example Usage
Real-world example of skill application

## Performance Metrics
Statistics from chat history analysis
```

## Database Schema

Skills are stored in Supabase with the following tables:

- `agent_skills` - Main skills table with metadata and statistics
- `skill_categories` - Skill category definitions
- `skill_usage_log` - Tracking of skill usage and outcomes
- `skill_cross_references` - Links to related documentation
- `skill_procedure_steps` - Normalized procedure steps

See `database/migrations/2026-03-30_agent_skills_schema.sql` for full schema.

## Memory System Integration

Skills integrate with the existing memory system:

- **Gigabrain Tags:** Enable automatic skill discovery based on task context
- **OpenStinger Context:** Provide cross-session skill recognition
- **PARA Structure:** Organize skills within the knowledge management system

## Cross-Referencing System

Skills are cross-referenced to:

1. **Source Documentation** - Procedures, guides, and standards
2. **Related Skills** - Skills that complement or depend on each other
3. **Agent Teams** - Which agents specialize in each skill
4. **Error Tracking** - Common errors and their solutions

## Usage Tracking

The system tracks:

- **Frequency:** How often each skill is used
- **Success Rate:** Percentage of successful skill applications
- **Duration:** Average time to complete skill procedures
- **Outcomes:** Success, partial, failure, or abandoned

## Creating New Skills

To create a new skill:

1. Analyze chat history for recurring patterns
2. Identify trigger conditions and procedure steps
3. Document success criteria and common pitfalls
4. Add cross-references to related documentation
5. Create skill file in `docs/skills/{skill-name}/SKILL.md`
6. Add to database via migration or API

## Integration with Agents

Skills are assigned to agents based on:

- **Agent Specialization:** DevForge for development, QualityForge for testing
- **Task Context:** Skills selected based on task requirements
- **Historical Performance:** Skills with higher success rates preferred

## Performance Optimization

Skills enable:

- **Faster Task Execution:** Reusable procedures reduce planning time
- **Higher Success Rates:** Proven patterns increase completion rates
- **Consistent Quality:** Standardized approaches ensure quality
- **Knowledge Transfer:** Skills capture institutional knowledge

## Company-Specific Skills

### Construct AI (`construct_ai/`)
Core platform skills for the Construct AI ecosystem.

### DevForge AI (`devforge_ai/`)
Development and implementation skills for code generation and deployment workflows.

### PromptForge AI (`promptforge_ai/`)
Prompt engineering, expansion, and complex specification processing skills.

### Loopy AI (`loopy_ai/`)
Iterative and loop-based AI processing, creative content generation.

### QualityForge AI (`qualityforge_ai/`)
Quality assurance, testing, and validation workflow skills.

### DomainForge AI (`domainforge_ai/`)
Industry-specific AI solutions for healthcare, finance, legal, and manufacturing verticals.

### InfraForge AI (`infraforge_ai/`)
Infrastructure automation, DevOps practices, and cloud operations powered by AI.

## Future Enhancements

Planned improvements:

1. **Automatic Skill Detection:** AI-powered skill suggestion based on task context
2. **Skill Composition:** Combining multiple skills for complex tasks
3. **Performance Analytics:** Real-time skill performance monitoring
4. **Skill Evolution:** Automatic skill refinement based on outcomes
5. **Cross-Project Learning:** Skills shared across different projects
6. **Company Skill Repositories:** Dedicated skill sets for each AI team

## Related Resources

- [Agent Development Procedure](../codebase/procedures/agent-development/0000_AGENT_DEVELOPMENT_PROCEDURE.md)
- [Coding Standards](../codebase/coding-standards/0000_AGENT_CODING_STANDARDS.md)
- [Error Tracking Guide](../error-tracking/0100_ENTERPRISE_GRADE_ERROR_HANDLING_AND_LOGGING_GUIDE.md)
- [PromptForge AI Team](../codebase/agents/openclaw-teams/PromptForge_AI_Team.md)
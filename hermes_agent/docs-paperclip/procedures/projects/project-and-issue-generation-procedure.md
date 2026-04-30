---
title: Generic Project and Issue Generation Procedure
author: PaperclipForge AI
date: 2026-04-13
version: 1.0
status: active
---

# Generic Project and Issue Generation Procedure

## Overview

This procedure defines the standardized process for creating projects and generating associated issues across all disciplines in the Paperclip ecosystem. It provides a generic, reusable framework for project scaffolding, multi-company orchestration, automated issue generation, and workflow integration.

## Purpose

- **Standardization**: Ensure consistent project structure across all disciplines and companies
- **Automation**: Enable efficient bulk project and issue creation
- **Multi-Company Orchestration**: Support seamless cross-company collaboration and assignment
- **Quality Assurance**: Validate project completeness and issue dependencies
- **Scalability**: Facilitate rapid project setup for complex initiatives

## When to Use

### Trigger Conditions
- Initiating a new multi-company project or initiative
- Setting up complex workflows requiring coordinated execution
- Creating discipline-specific projects (safety, procurement, engineering, etc.)
- Establishing standardized project templates for recurring work patterns
- Preparing projects for automated workflow execution

### Prerequisites
- Project scope and objectives clearly defined
- Company assignments and agent availability confirmed
- Timeline and budget constraints established
- Working directory and repository paths identified
- Success criteria and metrics defined

---

## Project Generation Workflow

### Step 1: Project Planning & Definition

#### 1.1 Define Project Scope

**Required Information**:
- **Project Name**: Clear, descriptive name
- **Project Code**: Unique identifier (e.g., SAFETY-INCIDENT, PROC-ORDER)
- **Discipline**: Primary discipline code (e.g., 02400-safety, 01900-procurement)
- **Timeline**: Duration and key milestones
- **Budget**: Resource allocation and constraints
- **Success Criteria**: Measurable outcomes

**Example**:
```yaml
project:
  name: Safety Incident Investigation and Reporting
  code: SAFETY-INCIDENT
  discipline: 02400-safety
  timeline: 9 weeks
  budget: $50,000
  success_criteria:
    - Incident reporting time < 15 minutes
    - Investigation completion < 24 hours
    - Corrective action closure > 90%
    - Knowledge sharing < 48 hours
```

#### 1.2 Identify Stakeholders and Companies

**Company Selection Criteria**:
- **Primary Company**: Domain expertise for the discipline
- **Supporting Companies**: Technical implementation, quality assurance, knowledge management, learning integration
- **Infrastructure**: Database, integration, mobile platform support

**Company Assignment Template**:
```yaml
companies:
  primary:
    company: qualityforge-ai
    role: Investigation and quality assurance
    lead_agent: guardian-qualityforge
  
  supporting:
    - company: domainforge-ai
      role: Safety domain expertise
      agent: safety-domainforge-safety-risk-management
    
    - company: mobileforge-ai
      role: Mobile platform integration
      agent: mobile-workflow-designer-mobileforge
    
    - company: knowledgeforge-ai
      role: Knowledge capture and documentation
      agent: doc-analyzer-knowledgeforge
    
    - company: learningforge-ai
      role: Training and prevention
      agent: assessment-mastery-learningforge
```

#### 1.3 Define Phases and Milestones

**Phase Structure**:
- **Phase 1**: Foundation and setup (typically 1-2 weeks)
- **Phase 2**: Core implementation (typically 2-3 weeks)
- **Phase 3**: Testing and validation (typically 1-2 weeks)
- **Phase 4**: Deployment and training (typically 1 week)
- **Phase 5**: Optimization and handover (typically 1 week)

**Milestone Definition**:
```yaml
phases:
  phase_1:
    name: Foundation and Setup
    duration: 2 weeks
    milestones:
      - Mobile interface enhancement
      - Voice command integration
      - Evidence management system
    
  phase_2:
    name: Automated Workflow
    duration: 2 weeks
    milestones:
      - Automated issue generator
      - Intelligent routing system
      - Workflow orchestration
```

---

### Step 2: Project File Structure Creation

#### 2.1 Directory Structure

**Standard Project Hierarchy**:
```
docs-paperclip/disciplines/{discipline-code}/projects/{PROJECT-CODE}/
├── project.md                    # Project charter
├── plan.md                      # Detailed implementation plan (optional)
├── issues/                      # Issue files directory
│   ├── {PROJECT-CODE}-001-{slug}.md
│   ├── {PROJECT-CODE}-002-{slug}.md
│   └── ...
├── knowledge/                   # Project-specific knowledge
│   └── PAGE-KNOWLEDGE.md       # Architectural knowledge
└── workflows/                   # Workflow documentation
    └── {workflow-name}.md
```

#### 2.2 Project Charter Template

**File**: `project.md`

```markdown
---
title: {PROJECT_NAME} Project Charter
description: {Brief description of project purpose}
author: {Author or Company}
date: {YYYY-MM-DD}
version: 1.0
status: active
project_code: {PROJECT-CODE}
discipline: {discipline-code}
---

# {PROJECT-CODE} Project Charter

## Project Overview

**Project Name**: {Full project name}
**Project Code**: {PROJECT-CODE}
**Discipline**: {discipline-code} - {Discipline Name}
**Business Criticality**: {High/Medium/Low}

## Project Scope

### In Scope
- {Scope item 1}
- {Scope item 2}
- {Scope item 3}

### Out of Scope
- {Out of scope item 1}
- {Out of scope item 2}

## Project Objectives

### Primary Objectives
1. **{Objective 1 Name}**: {Description}
2. **{Objective 2 Name}**: {Description}
3. **{Objective 3 Name}**: {Description}

### Success Criteria
- [ ] {Success criterion 1}
- [ ] {Success criterion 2}
- [ ] {Success criterion 3}
- [ ] {Success criterion 4}

## Project Timeline: {X} weeks

## Project Team
**Lead**: {lead-agent-slug} ({Company Name})

## Success Metrics
- **{Metric 1}**: {Target value}
- **{Metric 2}**: {Target value}
- **{Metric 3}**: {Target value}

---

**Document Version**: 1.0
**Last Updated**: {YYYY-MM-DD}
```

#### 2.3 Implementation Plan Template

**File**: `docs-paperclip/plans/{discipline}/{YYYY-MM-DD-project-slug-plan.md}`

**Key Sections**:
1. Executive Summary
2. Strategic Objectives
3. Current State Analysis
4. Workflow Architecture (Phase by Phase)
5. Technical Implementation Details
6. Success Metrics & KPIs
7. Risk Management
8. Implementation Timeline
9. Dependencies & Prerequisites
10. Communication & Reporting

---

### Step 3: Issue Generation Strategy

#### 3.1 Issue Types and Categories

**Common Issue Types**:
- **Foundation Issues**: Setup, configuration, infrastructure
- **Development Issues**: Feature implementation, integration
- **Testing Issues**: Validation, quality assurance, E2E testing
- **Documentation Issues**: User guides, API documentation
- **Deployment Issues**: Production readiness, monitoring
- **Training Issues**: User training, knowledge transfer

**Issue Categorization**:
```yaml
issue_categories:
  foundation:
    prefix: FOUND
    typical_count: 3-5
    example: "Database schema setup"
  
  development:
    prefix: DEV
    typical_count: 5-10
    example: "Implement user authentication"
  
  testing:
    prefix: TEST
    typical_count: 3-5
    example: "End-to-end API testing"
  
  deployment:
    prefix: DEPLOY
    typical_count: 2-3
    example: "Production deployment preparation"
```

#### 3.2 Issue Naming Conventions

**Format**: `{PROJECT-CODE}-{NUMBER}-{descriptive-slug}.md`

**Examples**:
- `SAFETY-INCIDENT-001-mobile-incident-reporting.md`
- `PROC-ORDER-015-supplier-evaluation-workflow.md`
- `DEV-AUTH-003-oauth-integration.md`

**Numbering Guidelines**:
- Start from 001 (or 000 for prerequisite issues)
- Sequential numbering within project
- Consistent padding (3 digits: 001, 002, 010, 100)
- No gaps in sequence

#### 3.3 Issue Template Structure

**Standard Issue Template**:
```markdown
---
id: {PROJECT-CODE}-{NUMBER}
title: {Clear, actionable title}
phase: {Phase Number} — {Phase Name}
status: open
priority: {critical|high|medium|low}
---

# {PROJECT-CODE}-{NUMBER}: {Title}

## Description

{Detailed description of the work required}

**Context**: {Background and rationale}

**Objectives**:
- {Objective 1}
- {Objective 2}
- {Objective 3}

**Scope**:
- In Scope: {What is included}
- Out of Scope: {What is excluded}

## Acceptance Criteria

- [ ] {Specific, measurable criterion 1}
- [ ] {Specific, measurable criterion 2}
- [ ] {Specific, measurable criterion 3}
- [ ] {Quality standard requirement}
- [ ] {Testing requirement}

## Assigned Company & Agent

- **Company:** {Company Name}
- **Agent:** {Agent Name} ({agent-slug})
- **Supporting:** {Supporting Company} ({supporting-agent-slug}) (if applicable)

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **GitHub Repositories:** [GITHUB_EDIT: true]
  - **Primary Repository:** `https://github.com/Construct-AI-primary/construct_ai.git`
  - **Mobile Repository:** `https://github.com/Construct-AI-primary/construct_ai-mobile.git`
  - **Documentation Repository:** `https://github.com/Construct-AI-primary/docs-paperclip.git`
  - **Construct AI Docs Repository:** `https://github.com/Construct-AI-primary/construct_ai_docs.git`
- **Clear Repository Guidance**: Agents now know exactly which GitHub repositories to use for coding work
- **Target Files:**
  - `{path/to/primary/file.ext}`
  - `{path/to/related/file.ext}`
  - `{path/to/configuration/file.ext}`

## Required Skills

- `{skill-name}` ({Company})
- `{skill-name}` ({Company})
- `{shared-skill-name}` (shared)

## Dependencies

- BLOCKED BY: [{ISSUE-ID}] ({Description})
- BLOCKS: [{ISSUE-ID}] ({Description})

## Estimated Effort

- **Complexity**: {simple|medium|complex}
- **Estimated Hours**: {X-Y hours}
- **Timeline**: {X days}

## Paperclip Task Schema

```yaml
company: {company-slug}
agent: {agent-slug}
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: {50-100}
priority: {1-5}
```

## Technical Notes

{Any technical considerations, constraints, or special requirements}

## Success Validation

**How to verify completion**:
1. {Validation step 1}
2. {Validation step 2}
3. {Validation step 3}

**Expected Outcomes**:
- {Expected result 1}
- {Expected result 2}

---

**Created**: {YYYY-MM-DD}
**Updated**: {YYYY-MM-DD}
```

---

### Step 4: Multi-Company Assignment

#### 4.1 Agent Selection Criteria

**Skill Matching**:
```typescript
interface AgentSkillMatch {
  agent: string;
  company: string;
  requiredSkills: string[];
  availableSkills: string[];
  matchScore: number; // 0-100%
  availability: 'available' | 'busy' | 'unavailable';
}

const findBestAgent = (issueRequirements: IssueRequirements) => {
  const candidates = getAllAgents()
    .filter(agent => agent.company === issueRequirements.targetCompany)
    .map(agent => ({
      agent: agent.slug,
      company: agent.company,
      requiredSkills: issueRequirements.skills,
      availableSkills: agent.skills,
      matchScore: calculateSkillMatch(issueRequirements.skills, agent.skills),
      availability: checkAvailability(agent)
    }))
    .filter(match => match.matchScore >= 70) // Minimum 70% skill match
    .sort((a, b) => b.matchScore - a.matchScore);
  
  return candidates[0]; // Best match
};
```

#### 4.2 Company Routing Logic

**Routing Decision Matrix**:
| Issue Type | Primary Company | Supporting Companies | Rationale |
|------------|----------------|---------------------|-----------|
| **Investigation** | QualityForge AI | DomainForge AI | Quality expertise + domain knowledge |
| **Mobile Development** | MobileForge AI | DevForge AI | Mobile specialization + backend support |
| **Documentation** | KnowledgeForge AI | DomainForge AI | Knowledge management + domain context |
| **Training** | LearningForge AI | KnowledgeForge AI | Learning expertise + knowledge base |
| **Infrastructure** | InfraForge AI | DevForge AI | Infrastructure + system integration |

#### 4.3 Load Balancing

**Agent Workload Management**:
```yaml
workload_limits:
  per_agent:
    max_concurrent_issues: 3
    max_weekly_new_assignments: 5
    priority_weight:
      critical: 3.0
      high: 2.0
      medium: 1.0
      low: 0.5

distribution_strategy:
  method: skill_match_with_load_balancing
  fallback: round_robin_within_company
  override: manual_assignment_allowed
```

---

### Step 5: Dependency Management

#### 5.1 Dependency Types

**Dependency Categories**:
- **Sequential**: Task B cannot start until Task A is complete
- **Parallel**: Tasks can run simultaneously
- **Conditional**: Task B depends on Task A outcome
- **Resource**: Tasks share resources and must coordinate

**Dependency Notation**:
```markdown
## Dependencies

- BLOCKED BY: [PROJ-001] (Database schema must be created first)
- BLOCKS: [PROJ-003] (API integration depends on this auth implementation)
- RELATED TO: [PROJ-005] (Similar work, coordinate approach)
- REQUIRES RESOURCE: [Database Infrastructure] (Shared InfraForge AI agent)
```

#### 5.2 Dependency Validation

**Validation Checklist**:
- [ ] No circular dependencies (A → B → C → A)
- [ ] All blocking issues exist and are valid
- [ ] Dependencies are logically consistent
- [ ] Critical path identified and optimized
- [ ] Resource conflicts identified and resolved

**Dependency Graph Analysis**:
```typescript
interface DependencyGraph {
  issues: Issue[];
  dependencies: Dependency[];
  criticalPath: Issue[];
  parallelGroups: Issue[][];
  estimatedDuration: number; // in days
}

const analyzeDependencies = (issues: Issue[]): DependencyGraph => {
  // Build dependency graph
  const graph = buildGraph(issues);
  
  // Find critical path (longest dependency chain)
  const criticalPath = findLongestPath(graph);
  
  // Identify parallel execution opportunities
  const parallelGroups = identifyParallelTasks(graph);
  
  // Calculate estimated duration
  const duration = calculateDuration(criticalPath);
  
  return { issues, dependencies: graph.edges, criticalPath, parallelGroups, estimatedDuration: duration };
};
```

---

### Step 6: Quality Assurance

#### 6.1 Pre-Generation Validation

**Project Charter Validation**:
- [ ] All required fields populated
- [ ] Success criteria are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- [ ] Timeline is realistic based on complexity
- [ ] Budget is defined and approved
- [ ] Stakeholders identified and aligned

**Company Assignment Validation**:
- [ ] All agents exist in the system
- [ ] Agent slugs match company directories
- [ ] Skills are documented for assigned agents
- [ ] No over-allocation of agents
- [ ] Backup agents identified for critical roles

#### 6.2 Issue Quality Checklist

**Content Quality**:
- [ ] Title is clear and action-oriented
- [ ] Description provides sufficient context
- [ ] Acceptance criteria are specific and measurable
- [ ] Working directory paths are accurate
- [ ] Target files exist in repository
- [ ] Dependencies are clearly stated
- [ ] Estimated effort is reasonable

**Technical Quality**:
- [ ] YAML frontmatter is valid syntax
- [ ] Issue ID follows naming convention
- [ ] Company and agent slugs are correct
- [ ] Required skills are listed
- [ ] Paperclip task schema is complete
- [ ] File paths use absolute paths

#### 6.3 Batch Validation

**Batch-Level Checks**:
```bash
# Validate all issues in a project
validate_project_issues() {
  local project_dir=$1
  
  echo "Validating project: $project_dir"
  
  # Check file naming
  find "$project_dir/issues" -name "*.md" | while read file; do
    if [[ ! $(basename "$file") =~ ^[A-Z]+-[0-9]{3}-.+\.md$ ]]; then
      echo "ERROR: Invalid filename: $file"
    fi
  done
  
  # Validate YAML frontmatter
  for file in "$project_dir/issues"/*.md; do
    if ! yq eval '.' "$file" > /dev/null 2>&1; then
      echo "ERROR: Invalid YAML in: $file"
    fi
  done
  
  # Check for duplicate issue IDs
  local ids=$(grep -h "^id:" "$project_dir/issues"/*.md | sort | uniq -d)
  if [ -n "$ids" ]; then
    echo "ERROR: Duplicate issue IDs found: $ids"
  fi
  
  # Validate dependencies reference existing issues
  # ... additional validation logic ...
  
  echo "Validation complete"
}
```

---

### Step 7: Batch Processing & Import

#### 7.1 Issue Batch Organization

**Folder Structure for Batch Processing**:
```
/project-issues/
├── 00-prerequisites/
│   └── PROJ-000-environment-setup.md
├── 01-foundation/
│   ├── PROJ-001-database-schema.md
│   ├── PROJ-002-api-structure.md
│   └── PROJ-003-authentication.md
├── 02-development/
│   ├── PROJ-004-user-interface.md
│   ├── PROJ-005-business-logic.md
│   └── PROJ-006-integrations.md
├── 03-testing/
│   ├── PROJ-007-unit-tests.md
│   ├── PROJ-008-integration-tests.md
│   └── PROJ-009-e2e-tests.md
└── 04-deployment/
    ├── PROJ-010-staging-deployment.md
    └── PROJ-011-production-deployment.md
```

#### 7.2 Automated Import Process

**Using Issue Batch Importer**:
```bash
# Import all issues from a project directory
hermes run --skill issue-batch-importer \
  --folder /path/to/project-issues \
  --company-routing intelligent \
  --path-config local-repos \
  --validate-dependencies \
  --dry-run  # Preview without creating

# After validation, run actual import
hermes run --skill issue-batch-importer \
  --folder /path/to/project-issues \
  --company-routing intelligent \
  --path-config local-repos
```

**Import Configuration**:
```yaml
import_config:
  validation:
    check_frontmatter: true
    check_dependencies: true
    check_agent_existence: true
    check_file_paths: true
  
  routing:
    strategy: intelligent  # or manual, round_robin
    load_balancing: true
    skill_matching_threshold: 70  # percent
  
  error_handling:
    on_validation_error: skip  # or halt, prompt
    on_routing_error: prompt
    on_import_error: log_and_continue
```

#### 7.3 Post-Import Verification

**Verification Steps**:
1. **Count Verification**: Confirm all issues were created
2. **Assignment Verification**: Check all agents are correctly assigned
3. **Dependency Verification**: Validate dependency links are established
4. **Status Verification**: Confirm all issues have correct initial status
5. **Metadata Verification**: Validate all metadata fields are populated

**Verification Script**:
```bash
verify_import() {
  local project_code=$1
  
  echo "Verifying import for project: $project_code"
  
  # Count issues
  local expected=$(find issues/ -name "${project_code}-*.md" | wc -l)
  local actual=$(paperclip issues list --project "$project_code" | wc -l)
  
  if [ "$expected" -eq "$actual" ]; then
    echo "✓ Issue count matches: $actual"
  else
    echo "✗ Issue count mismatch: expected $expected, got $actual"
  fi
  
  # Additional verification...
}
```

---

## Advanced Patterns

### Pattern 1: Phase-Based Issue Generation

**Use Case**: Large projects with clear phases

**Approach**:
1. Generate issues phase by phase
2. Each phase has its own folder
3. Dependencies primarily within phase, some cross-phase
4. Sequential phase validation and approval

**Benefits**:
- Reduced cognitive load
- Easier progress tracking
- Natural milestone points
- Flexible phase timing

### Pattern 2: Template-Based Issue Generation

**Use Case**: Recurring project types with standard patterns

**Approach**:
1. Create reusable issue templates
2. Template variables for customization
3. Automated variable substitution
4. Library of templates per discipline

**Example Template**:
```yaml
template: mobile-feature-implementation
variables:
  feature_name: {FEATURE_NAME}
  screen_name: {SCREEN_NAME}
  agent: {ASSIGNED_AGENT}

issues:
  - id: "${PROJECT_CODE}-${ISSUE_NUM}-mobile-ui-${feature_name}"
    title: "Implement ${feature_name} Mobile UI"
    agent: ${agent}
    files:
      - "mobile/src/screens/${screen_name}.tsx"
```

### Pattern 3: Automated Issue Generation from Project Plan

**Use Case**: Converting detailed project plans into executable issues

**Approach**:
1. Project plan with structured sections
2. Parser extracts tasks and milestones
3. Automated issue generation with dependencies
4. Human review and approval before import

**Example Parser**:
```typescript
interface ProjectPlanSection {
  phase: string;
  tasks: {
    title: string;
    agent: string;
    company: string;
    dependencies: string[];
    files: string[];
  }[];
}

const generateIssuesFromPlan = (plan: ProjectPlan): Issue[] => {
  const issues: Issue[] = [];
  let issueNumber = 1;
  
  plan.sections.forEach(section => {
    section.tasks.forEach(task => {
      issues.push({
        id: `${plan.projectCode}-${String(issueNumber).padStart(3, '0')}`,
        title: task.title,
        phase: section.phase,
        agent: task.agent,
        company: task.company,
        dependencies: task.dependencies,
        workingDirectory: plan.workingDirectory,
        targetFiles: task.files
      });
      issueNumber++;
    });
  });
  
  return issues;
};
```

---

## Troubleshooting

### Common Issues

#### Issue 1: Dependency Cycles
**Problem**: Circular dependencies prevent issue ordering
**Solution**: 
1. Identify cycles using dependency graph analysis
2. Break cycles by removing least critical dependencies
3. Introduce intermediate issues to break cycles
4. Revalidate dependency graph

#### Issue 2: Agent Skill Mismatches
**Problem**: Assigned agents lack required skills
**Solution**:
1. Review agent skill documentation
2. Reassign to agents with matching skills
3. Create agent training issues if needed
4. Update skill documentation if outdated

#### Issue 3: Path Resolution Failures
**Problem**: Target file paths don't exist
**Solution**:
1. Verify working directory is correct
2. Check paths are absolute (not relative)
3. Ensure files exist in repository
4. Create placeholder files if needed for future work

#### Issue 4: Import Failures
**Problem**: Batch import fails partway through
**Solution**:
1. Check import logs for specific errors
2. Validate YAML syntax in all issue files
3. Run dry-run mode first to catch errors
4. Import in smaller batches if needed

---

## Best Practices

### Project Planning
1. **Start with the end in mind**: Define success criteria before creating issues
2. **Involve stakeholders early**: Get input from all companies before finalizing
3. **Be realistic with timelines**: Add buffer for unexpected delays
4. **Document assumptions**: Capture assumptions and constraints explicitly

### Issue Generation
1. **One issue, one outcome**: Each issue should have a single clear deliverable
2. **Make acceptance criteria testable**: Criteria should be verifiable
3. **Provide context**: Include enough background for agents to understand the why
4. **Link related documentation**: Reference relevant docs, specs, and examples

### Company Assignment
1. **Match skills precisely**: Don't assign work beyond agent capabilities
2. **Balance workload**: Distribute work evenly across agents
3. **Plan for handoffs**: Clear handoff points between companies
4. **Designate clear ownership**: One agent owns each issue

### Quality Assurance
1. **Validate early and often**: Catch errors before batch processing
2. **Peer review project plans**: Have another team review before execution
3. **Test with small batches**: Validate process with subset before full import
4. **Monitor and iterate**: Track metrics and improve process

---

## Templates & Examples

### Example 1: Simple Project (3-5 Issues)

**Project**: Database Backup Automation
**Duration**: 1 week
**Issues**:
- DB-001: Design backup strategy
- DB-002: Implement backup script
- DB-003: Set up monitoring
- DB-004: Documentation and testing

### Example 2: Medium Project (10-15 Issues)

**Project**: User Authentication System
**Duration**: 4 weeks
**Phases**:
1. Foundation (3 issues): Schema, API structure, security framework
2. Implementation (5 issues): Login, logout, registration, password reset, session management
3. Testing (4 issues): Unit tests, integration tests, security audit, E2E tests
4. Deployment (3 issues): Staging, monitoring, production

### Example 3: Complex Project (20+ Issues)

**Project**: Safety Incident Workflow (see SAFETY-INCIDENT plan)
**Duration**: 9 weeks
**Phases**: 5 phases with 4-6 issues each
**Companies**: 7 companies involved
**Special Features**: Mobile integration, AI assistance, multi-company orchestration

---

## Metrics & Continuous Improvement

### Project Setup Metrics
- **Time to First Issue**: How quickly can first issue be created
- **Plan Completeness**: % of required fields populated
- **Validation Error Rate**: % of issues requiring fixes
- **Import Success Rate**: % of issues successfully imported

### Execution Metrics
- **Issue Velocity**: Issues completed per week
- **Agent Utilization**: % of agent capacity used
- **Dependency Blocking Time**: Time issues spend blocked
- **Rework Rate**: % of issues requiring revision

### Quality Metrics
- **Acceptance Criteria Clarity**: % of issues with clear criteria
- **Skill Match Accuracy**: % of assignments with proper skills
- **Cross-Company Coordination**: Handoff efficiency score
- **Stakeholder Satisfaction**: Project team feedback scores

---

## Appendices

### Appendix A: Project Code Registry

Maintain a registry of used project codes to prevent conflicts:

| Project Code | Discipline | Status | Start Date | End Date |
|-------------|-----------|--------|------------|----------|
| SAFETY-INCIDENT | 02400 | Active | 2026-04-13 | TBD |
| PROC-ORDER | 01900 | Active | 2026-04-07 | TBD |

### Appendix B: Company Capabilities Matrix

| Company | Specialization | Key Agents | Typical Workload |
|---------|---------------|------------|------------------|
| QualityForge AI | Testing, debugging, quality | Guardian, Validator | High |
| DomainForge AI | Domain expertise | 52 discipline agents | Medium |
| MobileForge AI | Mobile development | Mobile Designer, Mobile Testing | Medium |
| KnowledgeForge AI | Knowledge, documentation | Doc Analyzer, QA Strategy | Medium |
| LearningForge AI | Training, learning | Assessment, Feedback Synthesis | Low |
| InfraForge AI | Infrastructure | Database, Integration | Medium |
| DevForge AI | Development | DevCore, Interface, Automata | High |

### Appendix C: Issue Template Library

See `docs-paperclip/procedures/issue-file-generation-procedure.md` for detailed issue templates.

### Appendix D: Validation Scripts

```bash
# Complete validation suite
cd /Users/_Hermes/paperclip-render/docs-paperclip/procedures/scripts

# Validate project charter
./validate-project-charter.sh /path/to/project.md

# Validate issue batch
./validate-issue-batch.sh /path/to/issues/

# Check dependencies
./check-dependencies.sh /path/to/issues/

# Verify agent assignments
./verify-agent-assignments.sh /path/to/issues/
```

---

**Document Control**
- **Version**: 1.0
- **Date**: 2026-04-13
- **Author**: PaperclipForge AI
- **Review Cycle**: Quarterly
- **Next Review**: 2026-07-13

**Change Log**
- 2026-04-13: Initial procedure creation with comprehensive project and issue generation workflow

**Related Documents**
- `issue-file-generation-procedure.md`: Detailed issue file specifications
- `adding-companies-and-agents.md`: Company and agent management
- `agent-naming-procedure.md`: Agent naming standards
- Project plans in `docs-paperclip/plans/`
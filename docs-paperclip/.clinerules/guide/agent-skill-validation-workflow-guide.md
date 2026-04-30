# Agent Skill Validation Workflow Guide

## Overview

This guide provides comprehensive instructions for using the Generic Agent Skill Validation Workflow Template to validate any agent's skill structure against issue assignments in the Paperclip ecosystem. The template ensures agents have properly formatted skills that align with skill writing standards and task management requirements.

## Quick Start

### 1. Copy the Template
```bash
cp .clinerules/workflows/agent-skill-validation-workflow-template.md .clinerules/workflows/agent-skill-validation-{AGENT_SLUG}.md
```

### 2. Replace Template Variables
Use search and replace to customize the template for your specific agent validation. See the "Template Variables" section below for all variables that need to be replaced.

### 3. Execute the Validation
Follow the 7-step workflow process outlined in the template to validate agent skills.

## Template Variables Reference

### Core Validation Variables
```
{ISSUE_DOCUMENT_PATH} - Full path to the issue document being validated against
{COMPANY_SLUG} - Company slug where the agent belongs (e.g., devforge-ai, infraforge-ai)
{AGENT_SLUG} - Agent slug to validate (e.g., database-infraforge, forge-devforge)
```

## Step-by-Step Implementation Guide

### Step 1: Validation Preparation
**Goal**: Gather all required information before starting the validation workflow.

**Required Information**:
- Issue document path and content
- Company and agent slugs from issue assignment
- Access to team cross-reference documentation
- Understanding of skill validation requirements

**Actions**:
1. Identify the issue document that contains the agent assignment
2. Extract the company and agent slugs from the issue
3. Verify access to the team cross-reference documentation
4. Review skill writing and task management guidelines

### Step 2: Template Customization
**Goal**: Replace all template variables with agent-specific values.

**Variable Replacement Process**:
1. Replace `{ISSUE_DOCUMENT_PATH}` with the full path to the issue document
2. Replace `{COMPANY_SLUG}` with the correct company identifier
3. Replace `{AGENT_SLUG}` with the agent identifier to validate
4. Update any workflow-specific references as needed

**Example Replacement**:
```
{ISSUE_DOCUMENT_PATH} = docs-paperclip/development-paperclip/issues/MODSEL-001-database-schema-foundation.md
{COMPANY_SLUG} = infraforge-ai
{AGENT_SLUG} = database-infraforge
```

### Step 3: Issue Document Validation
**Goal**: Verify the issue document and extract assignment information.

**Validation Steps**:
- [ ] Issue document exists and is accessible
- [ ] Document contains clear agent assignment information
- [ ] Company and agent slugs match template variables
- [ ] Issue priority, timeline, and requirements are defined
- [ ] Assignment aligns with agent's documented capabilities

### Step 4: Agent Existence Verification
**Goal**: Confirm the agent exists and is properly documented in the system.

**Verification Checklist**:
- [ ] Agent appears in team cross-reference documentation
- [ ] Agent is listed as active in the specified company
- [ ] Agent's role and team assignments are current
- [ ] Reporting structure is properly defined
- [ ] Agent has appropriate access and permissions

### Step 5: Skill Discovery and Assessment
**Goal**: Locate and evaluate all skills associated with the agent.

**Skill Discovery Process**:
1. Navigate to `docs-paperclip/companies/{COMPANY_SLUG}/skills/`
2. List all skill files in the company directory
3. Filter for skills associated with the agent (typically prefixed with agent slug)
4. Identify primary and secondary skill files

**Skill Assessment Criteria**:
- [ ] Skill files exist for the assigned agent
- [ ] Files follow proper naming conventions
- [ ] Skills are relevant to the agent's role and assigned tasks
- [ ] Skill coverage is comprehensive for task requirements

### Step 6: Skill Format Validation
**Goal**: Ensure all agent skills follow proper formatting and structure standards.

**Format Validation Checklist**:
- [ ] YAML frontmatter is present and properly formatted
- [ ] `name` field uses kebab-case unique identifier
- [ ] `description` provides clear routing decision logic
- [ ] Markdown formatting is correct and readable
- [ ] Content follows skill writing guidelines

**Cross-Reference Checks**:
- [ ] Skills align with `docs-paperclip/guides/agent-developer/writing-a-skill.md`
- [ ] Structure matches company skill standards
- [ ] Content is actionable and implementation-ready

### Step 7: Task Management Alignment
**Goal**: Verify skills support proper task and issue lifecycle management.

**Task Management Validation**:
- [ ] Skills support full issue lifecycle (backlog → todo → in_progress → in_review → done)
- [ ] Status tracking and progress monitoring capabilities exist
- [ ] Issue assignment and ownership handling is defined
- [ ] Communication and escalation protocols are documented

**Integration Checks**:
- [ ] Skills align with `docs-paperclip/guides/board-operator/managing-tasks.md`
- [ ] Cross-company collaboration protocols are supported
- [ ] Quality assurance and review processes are included

### Step 8: Company Standards Compliance
**Goal**: Ensure skills meet company-specific requirements and standards.

**Compliance Validation**:
- [ ] Skills align with `docs-paperclip/companies/{COMPANY_SLUG}/COMPANY.md`
- [ ] Team requirements from team documentation are met
- [ ] Company culture and working standards are reflected
- [ ] Cross-functional collaboration capabilities exist

### Step 9: Findings Documentation and Recommendations
**Goal**: Document validation results and provide actionable improvement recommendations.

**Reporting Structure**:
1. **Validation Summary**: Overall compliance status
2. **Skill Assessment**: Individual skill validation results
3. **Gap Analysis**: Identified deficiencies and their impact
4. **Remediation Plan**: Specific recommendations and priorities
5. **Timeline**: Suggested implementation schedule

## Best Practices

### Validation Execution
- **Systematic Approach**: Follow the 7-step workflow in order
- **Complete Documentation**: Record all findings and decisions
- **Cross-Referencing**: Validate against multiple standards documents
- **Stakeholder Communication**: Keep relevant parties informed of progress

### Skill Assessment Standards
- **Format Compliance**: Strict adherence to YAML frontmatter requirements
- **Content Quality**: Clear, actionable, and implementation-ready skills
- **Task Alignment**: Direct relevance to assigned responsibilities
- **Standards Adherence**: Compliance with established guidelines

### Issue Resolution
- **Priority Classification**: High, medium, low priority remediation items
- **Timeline Assignment**: Realistic deadlines for skill improvements
- **Resource Allocation**: Appropriate team members for remediation work
- **Follow-up Validation**: Re-validation after remediation completion

## Common Validation Scenarios

### Scenario 1: New Agent Onboarding
**Context**: Validating skills for a newly assigned agent
**Focus Areas**:
- Complete skill file existence and format validation
- Task management capability assessment
- Company standards integration verification
- Cross-team collaboration readiness

### Scenario 2: Task Reassignment
**Context**: Validating agent skills before task reassignment
**Focus Areas**:
- Task-specific skill requirements matching
- Experience level assessment for task complexity
- Timeline and deadline capability verification
- Backup and escalation procedure validation

### Scenario 3: Skill Updates and Improvements
**Context**: Post-training or skill enhancement validation
**Focus Areas**:
- Updated skill documentation review
- New capability integration verification
- Task management enhancement validation
- Quality and standards compliance confirmation

### Scenario 4: Compliance Audits
**Context**: Regular skill compliance and quality assurance
**Focus Areas**:
- Comprehensive format and standards validation
- Task management protocol verification
- Company policy adherence confirmation
- Continuous improvement opportunity identification

## Troubleshooting

### Common Issues and Solutions

**Issue**: Agent not found in cross-reference documentation
**Solution**: Verify agent slug spelling and check if agent was recently added or deactivated

**Issue**: Skill files missing or incomplete
**Solution**: Check company skills directory structure and verify file naming conventions

**Issue**: YAML frontmatter formatting errors
**Solution**: Review skill writing guidelines and correct YAML syntax

**Issue**: Task management capabilities misaligned
**Solution**: Cross-reference with task management guidelines and update skill content

**Issue**: Company standards non-compliance
**Solution**: Review company documentation and align skill content accordingly

### Getting Help

- **Skill Writing Guidelines**: `docs-paperclip/guides/agent-developer/writing-a-skill.md`
- **Task Management Standards**: `docs-paperclip/guides/board-operator/managing-tasks.md`
- **Team Cross-Reference**: `docs-construct-ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md`
- **Company Standards**: `docs-paperclip/companies/{COMPANY_SLUG}/COMPANY.md`

## Success Metrics

### Validation Quality Metrics
- **Completeness**: 100% of required validation steps completed
- **Accuracy**: All findings verified and documented
- **Actionability**: Recommendations are specific and implementable
- **Timeline Compliance**: Validation completed within agreed timeframes

### Skill Quality Improvements
- **Format Compliance**: 100% adherence to skill writing standards
- **Task Alignment**: Skills fully support assigned responsibilities
- **Standards Compliance**: Full alignment with company and team requirements
- **Documentation Quality**: Clear, comprehensive, and maintainable skill files

### Process Efficiency Metrics
- **Validation Speed**: Consistent completion times for similar validations
- **Issue Resolution Rate**: Percentage of identified issues resolved
- **Recurrence Prevention**: Reduction in similar issues over time
- **Stakeholder Satisfaction**: Positive feedback on validation process and outcomes

## Example Implementation

### Example: Database Infrastructure Agent Validation

**Template Variables**:
```
{ISSUE_DOCUMENT_PATH} = docs-paperclip/development-paperclip/issues/MODSEL-001-database-schema-foundation.md
{COMPANY_SLUG} = infraforge-ai
{AGENT_SLUG} = database-infraforge
```

**Expected Validation Steps**:
1. Read MODSEL-001 issue document and confirm database-infraforge assignment
2. Verify agent exists in InfraForge AI team cross-reference
3. Check `docs-paperclip/companies/infraforge-ai/skills/` for database-related skills
4. Validate skill format against writing guidelines
5. Confirm database skills support schema management and migration tasks
6. Ensure alignment with infrastructure team standards
7. Document findings and recommend any skill enhancements

## Continuous Improvement

### Process Optimization
- **Template Updates**: Regularly update template based on validation experience
- **Checklist Refinement**: Improve validation checklists based on findings
- **Automation Opportunities**: Identify areas for automated validation
- **Training Development**: Create training materials for common scenarios

### Quality Assurance
- **Peer Reviews**: Regular review of validation reports and recommendations
- **Feedback Integration**: Incorporate stakeholder feedback into process improvements
- **Standards Updates**: Keep validation criteria aligned with evolving standards
- **Metrics Tracking**: Monitor validation effectiveness and success rates

---

**Guide Version**: 1.0
**Last Updated**: 2026-04-08
**Applicable Template Version**: 1.0
**Contact**: Paperclip Quality Assurance Team
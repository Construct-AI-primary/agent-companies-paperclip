# Generic Agent Skill Validation Workflow Template

This workflow template validates any agent's skill structure against issue assignments, ensuring alignment with skill writing standards and task management requirements.

## Prerequisites
- Issue document path: `{ISSUE_DOCUMENT_PATH}`
- Company slug: `{COMPANY_SLUG}`
- Agent slug: `{AGENT_SLUG}`
- Team cross-reference: `docs-construct-ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md`

## Workflow Steps

### Step 1: Read the Issue Document
- Use `read_file` to read the issue from `{ISSUE_DOCUMENT_PATH}`
- Extract the assigned company and agent information from the "Assigned Company & Agent" section
- Validate that `{COMPANY_SLUG}` and `{AGENT_SLUG}` match the issue assignment

### Step 2: Identify the Assigned Agent
- Use `read_file` to read the agent assignment info from `docs-construct-ai/codebase/agents/paperclip-teams/Paperclip_Teams_Cross_Reference.md`
- Search for the agent details using `{COMPANY_SLUG}` and `{AGENT_SLUG}`
- Confirm the agent's role, team, and reporting structure
- Verify agent exists and is active in the specified company

### Step 3: Check Agent Skills Directory
- Navigate to the company's skills directory: `docs-paperclip/companies/{COMPANY_SLUG}/skills/`
- Use `list_files` to list all skill files in the company directory
- Filter for skills associated with `{AGENT_SLUG}` (skills typically named with agent slug prefix)
- Identify primary agent skill file: `{AGENT_SLUG}-primary-skill.md` or similar

### Step 4: Validate Skill Format and Structure
- For each identified skill file, use `read_file` to examine the content
- Verify YAML frontmatter contains required fields:
  - `name`: unique identifier in kebab-case format
  - `description`: routing description written as decision logic
- Ensure skill structure follows guidelines from `docs-paperclip/guides/agent-developer/writing-a-skill.md`
- Check for proper markdown formatting and actionable instructions

### Step 5: Validate Task Management Alignment
- Cross-reference the agent's skills with task management requirements from `docs-paperclip/guides/board-operator/managing-tasks.md`
- Ensure skills support proper issue lifecycle management:
  - Status transitions: backlog → todo → in_progress → in_review → done
  - Progress tracking and monitoring capabilities
  - Issue assignment and ownership handling
- Verify skills include appropriate escalation and communication protocols

### Step 6: Cross-Reference with Company Standards
- Check agent skills against company-specific standards in `docs-paperclip/companies/{COMPANY_SLUG}/COMPANY.md`
- Validate skills align with team requirements from team documentation
- Ensure skills support cross-company collaboration protocols

### Step 7: Report Findings and Recommendations
- Document any skills that don't align with required formats
- Suggest specific updates needed to bring skills into compliance
- Identify skill gaps that may impact task execution
- Confirm which skills are properly structured and ready for use
- Provide remediation timeline and priority recommendations

## Required Tools
- `read_file`: For reading issue docs, agent assignments, skill files, and guide documents
- `list_files`: For discovering skill files in company directories
- `search_files`: For finding specific agent or skill references across documentation

## Validation Checklists

### Issue Assignment Validation
- [ ] Issue document exists and is accessible
- [ ] Company and agent assignments are clearly specified
- [ ] Assignments match provided parameters ({COMPANY_SLUG}, {AGENT_SLUG})
- [ ] Issue priority and timeline are defined

### Agent Existence Validation
- [ ] Agent exists in team cross-reference documentation
- [ ] Agent is listed as active in specified company
- [ ] Agent's role and team assignments are current
- [ ] Reporting structure is properly defined

### Skill Structure Validation
- [ ] Skill files exist for the assigned agent
- [ ] YAML frontmatter is properly formatted
- [ ] Skill names follow kebab-case convention
- [ ] Descriptions provide clear routing logic
- [ ] Markdown formatting is correct and readable

### Task Management Alignment
- [ ] Skills support full issue lifecycle management
- [ ] Status tracking capabilities are present
- [ ] Communication protocols are defined
- [ ] Escalation procedures are documented

## Expected Outcome
- Complete validation of agent skill structures against established formats
- Identification of any remediation needed for skill files
- Confirmation that assigned agents have properly formatted skills for task execution
- Actionable recommendations for skill improvements and gap remediation

## Template Usage Variables
```
{ISSUE_DOCUMENT_PATH} - Full path to the issue document to validate
{COMPANY_SLUG} - Company slug (e.g., devforge-ai, infraforge-ai)
{AGENT_SLUG} - Agent slug (e.g., database-infraforge, forge-devforge)
```

## Example Usage
```
{ISSUE_DOCUMENT_PATH} = docs-paperclip/development-paperclip/issues/MODSEL-001-database-schema-foundation.md
{COMPANY_SLUG} = infraforge-ai
{AGENT_SLUG} = database-infraforge
```

---
**Template Version**: 1.0
**Last Updated**: 2026-04-08
**Purpose**: Generic agent skill validation workflow

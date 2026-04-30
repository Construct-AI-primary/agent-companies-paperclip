# LearningForge AI - AutoResearch Agents Removal Plan

**Date:** 2026-04-12  
**Status:** Pending Removal  
**Reason:** Decision not to use Karpathy's AutoResearch methodology

## Agents Identified for Removal

### 1. AutoResearch Skills Enhancer
- **Slug:** `learningforge-ai-autoresearch-skills-enhancer`
- **Name:** `AutoResearch Skills Enhancer`
- **Title:** Skills Auto-Improvement Specialist
- **Team:** Research & Compliance Division
- **Reports To:** `learningforge-ai-research-compliance-division-lead`
- **Purpose:** Use AutoResearch to enhance agent skills.md files with latest research findings
- **Skills:** `learningforge-ai-autoresearch-integration`

### 2. AutoResearch Literature Scanner
- **Slug:** `learningforge-ai-autoresearch-literature-scanner`
- **Name:** `AutoResearch Literature Scanner`
- **Title:** Academic & Technical Literature Scanner
- **Team:** Research & Compliance Division
- **Reports To:** `learningforge-ai-research-compliance-division-lead`
- **Purpose:** Automated scanning and synthesis of research papers
- **Skills:** `learningforge-ai-literature-analysis`

### 3. AutoResearch Gap Analyzer
- **Slug:** `learningforge-ai-autoresearch-gap-analyzer`
- **Name:** `AutoResearch Gap Analyzer`
- **Title:** Knowledge & Skill Gap Analysis Specialist
- **Team:** Research & Compliance Division
- **Reports To:** `learningforge-ai-research-compliance-division-lead`
- **Purpose:** Identify missing capabilities in agent skill definitions
- **Skills:** `learningforge-ai-gap-analysis`

## Impact Analysis

### Affected Files and References

#### Agent Files
1. `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-skills-enhancer/AGENTS.md`
2. `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-literature-scanner/AGENTS.md`
3. `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-gap-analyzer/AGENTS.md`

#### Skill Files
1. `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-autonomous-research/skill.md`
2. `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-gap-analysis/skill.md`
3. `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-literature-analysis/skill.md`

#### Configuration Files
1. `docs-paperclip/companies/learningforge-ai/.paperclip.yaml` - Contains AutoResearch agent configurations
2. `docs-paperclip/companies/learningforge-ai/workspace/README.md` - References `autoresearch-*` workspace paths

#### Company Documentation
1. `docs-paperclip/companies/learningforge-ai/COMPANY.md` - Multiple AutoResearch references
2. `docs-paperclip/companies/learningforge-ai/README.md` - AutoResearch integration docs
3. `docs-paperclip/companies/learningforge-ai/teams/research-compliance/TEAM.md` - AutoResearch team structure

#### Team Documentation
1. `docs-paperclip/companies/learningforge-ai/teams/priority-disciplines/TEAM.md`
2. `docs-paperclip/companies/learningforge-ai/teams/learning-curriculum/TEAM.md`
3. `docs-paperclip/companies/learningforge-ai/teams/knowledge-flow/TEAM.md`

#### Other Agent References
Multiple agents reference AutoResearch in their workflows:
- `learningforge-ai-ceo`
- `learningforge-ai-priority-disciplines-lead`
- `learningforge-ai-research-compliance-division-lead`
- `learningforge-ai-hermes-research`
- `learningforge-ai-langchain-runner`
- `learningforge-ai-knowledge-flow-agent`
- `learningforge-ai-vfs-watcher`

## Removal Strategy

### Phase 1: Database Operations

#### Step 1: Verify Agents Exist in Database
```sql
-- Check if AutoResearch agents exist
SELECT 
    a.id,
    a.name,
    a.is_active,
    a.reports_to,
    c.name as company_name
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  )
ORDER BY a.name;
```

#### Step 2: Check API Keys
```sql
-- Check API keys for AutoResearch agents
SELECT 
    a.name as agent_name,
    aak.id as api_key_id,
    aak.name as key_name,
    aak.created_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  );
```

#### Step 3: Deactivate Agents (Soft Delete)
```sql
-- Option A: Soft delete by setting is_active = false
UPDATE agents
SET 
    is_active = false,
    updated_at = NOW()
WHERE id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
RETURNING id, name, is_active, updated_at;
```

#### Step 4: Revoke API Keys
```sql
-- Revoke API keys for deactivated AutoResearch agents
UPDATE agent_api_keys
SET 
    revoked_at = NOW()
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
AND revoked_at IS NULL
RETURNING id, name, revoked_at;
```

#### Step 5: Hard Delete (Optional - After Confirmation)
```sql
-- CAUTION: Only run after backup and confirmation
-- Delete API keys first (foreign key dependency)
DELETE FROM agent_api_keys
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
);

-- Then delete agents
DELETE FROM agents
WHERE id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
RETURNING id, name;
```

### Phase 2: Documentation Updates

#### Files to Update (Remove AutoResearch References)

1. **Company Core Documentation**
   - [ ] `docs-paperclip/companies/learningforge-ai/COMPANY.md`
     - Remove AutoResearch from goals
     - Remove AutoResearch from technologies list
     - Update implementation phases (remove Phase 3)
   
   - [ ] `docs-paperclip/companies/learningforge-ai/README.md`
     - Remove AutoResearch clone instructions
     - Update feature list
     - Remove AutoResearch integration phase

2. **Configuration Files**
   - [ ] `docs-paperclip/companies/learningforge-ai/.paperclip.yaml`
     - Remove `learningforge-ai-autoresearch-skills-enhancer` entry
     - Remove `learningforge-ai-autoresearch-literature-scanner` entry
     - Remove `learningforge-ai-autoresearch-gap-analyzer` entry
     - Remove `weekly-autoresearch-cycle` task
   
   - [ ] `docs-paperclip/companies/learningforge-ai/workspace/README.md`
     - Remove `autoresearch-*` workspace path mapping

3. **Team Documentation**
   - [ ] `docs-paperclip/companies/learningforge-ai/teams/research-compliance/TEAM.md`
     - Remove "AutoResearch Integration Agents" section
     - Remove AutoResearch responsibilities
     - Update team focus and description
   
   - [ ] `docs-paperclip/companies/learningforge-ai/teams/priority-disciplines/TEAM.md`
     - Remove AutoResearch column from table
     - Update workflow descriptions
   
   - [ ] `docs-paperclip/companies/learningforge-ai/teams/learning-curriculum/TEAM.md`
     - Remove AutoResearch collaboration reference
   
   - [ ] `docs-paperclip/companies/learningforge-ai/teams/knowledge-flow/TEAM.md`
     - Remove AutoResearch monitoring reference

4. **Agent Documentation**
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-ceo/AGENTS.md`
     - Remove "Coordinate AutoResearch integration" responsibility
     - Remove AutoResearch outputs reference
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-research-compliance-division-lead/AGENTS.md`
     - Remove AutoResearch agents from managed agents list
     - Remove AutoResearch integration responsibility
     - Remove AutoResearch references from context
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-priority-disciplines-lead/AGENTS.md`
     - Remove AutoResearch integration references
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-hermes-research/AGENTS.md`
     - Remove "Integration with AutoResearch" section
     - Remove AutoResearch principles references
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-langchain-runner/AGENTS.md`
     - Remove `karpathy/autoresearch` context reference
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-knowledge-flow-agent/AGENTS.md`
     - Remove AutoResearch knowledge tracing reference
   
   - [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-vfs-watcher/AGENTS.md`
     - Remove AutoResearch knowledge tracking reference

5. **Skill Documentation**
   - [ ] `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-autonomous-research/skill.md`
     - Update overview to remove AutoResearch methodology reference
     - Remove "Integration with AutoResearch" section
   
   - [ ] `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-gap-analysis/skill.md`
     - Remove AutoResearch methodology reference
     - Update agent assignment
   
   - [ ] `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-literature-analysis/skill.md`
     - Update primary agent assignment
     - Remove AutoResearch references
   
   - [ ] `docs-paperclip/companies/learningforge-ai/skills/learningforge-ai-langchain-orchestration/skill.md`
     - Remove AutoResearch patterns reference

### Phase 3: File Removal

#### Agent Directories to Archive/Remove
- [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-skills-enhancer/`
- [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-literature-scanner/`
- [ ] `docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-gap-analyzer/`

**Recommendation:** Move to archive directory first before permanent deletion:
```bash
mkdir -p docs-paperclip/companies/learningforge-ai/archive/agents/
mv docs-paperclip/companies/learningforge-ai/agents/learningforge-ai-autoresearch-* \
   docs-paperclip/companies/learningforge-ai/archive/agents/
```

## Execution Scripts

### Script 1: Database Deactivation (Soft Delete)
File: `scripts/database/deactivate_autoresearch_agents.sql`

```sql
-- Deactivate AutoResearch agents in LearningForge AI
-- Safe operation - can be reversed

BEGIN;

-- Step 1: Deactivate agents
UPDATE agents
SET 
    is_active = false,
    updated_at = NOW()
WHERE id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
);

-- Step 2: Revoke API keys
UPDATE agent_api_keys
SET revoked_at = NOW()
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
)
AND revoked_at IS NULL;

-- Step 3: Verification
SELECT 
    a.name,
    a.is_active,
    aak.revoked_at
FROM agents a
JOIN companies c ON a.company_id = c.id
LEFT JOIN agent_api_keys aak ON a.id = aak.agent_id
WHERE c.name = 'Learning Forge AI'
  AND a.name IN (
    'AutoResearch Skills Enhancer',
    'AutoResearch Literature Scanner',
    'AutoResearch Gap Analyzer'
  );

COMMIT;
```

### Script 2: Verification
File: `scripts/database/verify_autoresearch_removal.sql`

```sql
-- Verify AutoResearch agents status
SELECT 
    'Active AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.is_active = true
  AND a.name LIKE '%AutoResearch%'

UNION ALL

SELECT 
    'Total AutoResearch Agents (including inactive)' as check_type,
    COUNT(*) as count
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name LIKE '%AutoResearch%'

UNION ALL

SELECT 
    'Active API Keys for AutoResearch Agents' as check_type,
    COUNT(*) as count
FROM agent_api_keys aak
JOIN agents a ON aak.agent_id = a.id
JOIN companies c ON a.company_id = c.id
WHERE c.name = 'Learning Forge AI'
  AND a.name LIKE '%AutoResearch%'
  AND aak.revoked_at IS NULL;
```

## Recommended Approach

1. **Immediate Action:** Soft delete (deactivate) agents in database
   - Prevents agents from being used
   - Reversible if needed
   - Low risk

2. **Short-term (1-2 weeks):** Update documentation
   - Remove references systematically
   - Update team structures
   - Clarify new research approach

3. **Long-term (1 month+):** Archive agent files
   - Move to archive directory
   - Keep for reference/rollback capability
   - Can delete after confirmation

4. **Final Cleanup (3+ months):** Hard delete from database
   - Only after confirming no rollback needed
   - Remove archived files

## Alternative Research Methodology

If AutoResearch is being removed, consider documenting the replacement approach:
- Manual research processes
- Alternative automation tools
- Human-driven literature review
- Different skill enhancement methodology

## Rollback Plan

If AutoResearch needs to be reinstated:

```sql
-- Reactivate agents
UPDATE agents
SET 
    is_active = true,
    updated_at = NOW()
WHERE id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
);

-- Un-revoke API keys
UPDATE agent_api_keys
SET revoked_at = NULL
WHERE agent_id IN (
    SELECT a.id
    FROM agents a
    JOIN companies c ON a.company_id = c.id
    WHERE c.name = 'Learning Forge AI'
      AND a.name IN (
        'AutoResearch Skills Enhancer',
        'AutoResearch Literature Scanner',
        'AutoResearch Gap Analyzer'
      )
);
```

---

**Created:** 2026-04-12  
**Author:** Paperclip AI Assistant  
**Status:** Pending Approval and Execution  
**Next Action:** Review and approve removal strategy

# Agent Naming Procedure in Paperclip

This procedure documents the standardized naming conventions and procedures for creating and managing agent names within the Paperclip ecosystem. Consistent agent naming ensures clarity, discoverability, and maintainability across all companies and systems.

## Overview

Agent naming in Paperclip follows a hierarchical structure that balances human readability with system requirements. The naming system supports:

- **Functional clarity**: Names that clearly indicate agent purpose and capabilities
- **Company scoping**: Names that work within and across company boundaries
- **System integration**: Names that work with databases, APIs, and automation systems
- **Scalability**: Names that support hundreds of agents across multiple companies

## Dual Naming Convention

Paperclip uses a dual naming approach to balance filesystem compatibility with UI display:

### 📁 Filesystem Names (Documentation Structure)
- **Format**: `{personal-name}-{company-slug}-{role}` (lowercase, hyphenated)
- **Purpose**: File paths, directories, git-tracked documentation, internal references
- **When Used**: In AGENTS.md files, directory names, skill routing
- **Example**: `maya-loopy-ai-content-strategist/`, `alex-devforge-ai-codesmith/`
- **Key Rule**: These are NEVER displayed to users - they're internal identifiers

### 🖥️ Dashboard Display Names (Human-Readable)
- **Format**: `{Personal Name}` (human-readable, often with unusual/funky twist)
- **Purpose**: Database records, UI display, API responses, dashboard, user interactions
- **When Used**: Everywhere users see agent names in the Paperclip interface
- **Example**: `Maya`, `Alex`, `Orion`, `Nimbus`, `Quasar`, `Zephyr`
- **Key Rule**: These should be memorable, human-like names that users will interact with

**Critical Distinction:**
- **Filesystem Name**: `nimbus-infraforge-supabase-specialist` (for files/directories)
- **Dashboard Name**: `Nimbus` (what users see and interact with)
- **Database Storage**: Dashboard name goes in `agents.name` field
- **File Structure**: Filesystem name creates the directory structure

**Key Rules:**
- **Consistency within company**: Choose creative, memorable dashboard names
- **Complete metadata**: All agents need title, team, and specialization in metadata
- **No null metadata**: Agents must not have null titles, teams, or specializations
- **Funky twist encouraged**: Dashboard names should be unusual and memorable

### Company Display Names
| Slug | Display Name |
|------|--------------|
| knowledgeforge-ai | KnowledgeForge AI |
| domainforge-ai | DomainForge AI |
| devforge-ai | DevForge AI |
| qualityforge-ai | QualityForge AI |
| infraforge-ai | InfraForge AI |
| promptforge-ai | PromptForge AI |
| contentforge-ai | ContentForge AI |
| execforge-ai | ExecForge AI |
| mobileforge-ai | MobileForge AI |
| voiceforge-ai | VoiceForge AI |
| saasforge-ai | SaaSForge AI |
| learningforge-ai | LearningForge AI |
| paperclipforge-ai | PaperclipForge AI |
| loopy-ai | Loopy AI |

## Core Naming Principles

### 1. Human-First Design
- **Readable**: Agent names should be immediately understandable to humans
- **Descriptive**: Names should convey the agent's primary function or specialty
- **Memorable**: Names should be distinctive and easy to recall

### 2. System Compatibility
- **Database-friendly**: Names that work well in SQL queries and APIs
- **URL-safe**: Names that can be used in URLs and file paths
- **Case-consistent**: Standardized capitalization rules

### 3. Company Scoping
- **Unique within company**: No duplicate names within the same company
- **Cross-company friendly**: Names that work when agents collaborate across companies
- **Company identification**: Clear association with owning company

## Agent Name Components

### Primary Components

Every agent name consists of these core elements:

```
[Functional Name] + [Optional Qualifier]
```

#### Functional Name
The primary identifier that describes what the agent does:

**Examples:**
- `Navigator` - Data discovery and exploration
- `Guardian` - Quality assurance and protection
- `Catalyst` - Innovation and product development
- `Oracle` - Predictive analytics and forecasting
- `Architect` - System design and planning

#### Optional Qualifier
Additional context when needed for clarity:

**Examples:**
- `Data Navigator` - Specifies data-focused navigation
- `Code Guardian` - Specifies code quality focus
- `Product Catalyst` - Specifies product innovation focus

### Supporting Metadata

#### Role Classification
Standardized role categories for system organization:

```sql
-- Core business roles
'ceo'           -- Chief Executive Officer
'executive'     -- Executive leadership
'manager'       -- Management and coordination

-- Functional roles
'data'          -- Data management and analytics
'product'       -- Product development and management
'engineering'   -- Software development and architecture
'testing'       -- Quality assurance and testing
'security'      -- Security and compliance
'strategy'      -- Strategic planning and analysis

-- Specialized roles
'specialist'    -- Domain-specific expertise
'coordinator'   -- Cross-team coordination
'analyst'       -- Analysis and reporting
```

#### Title Field
Human-readable descriptive title:

**Format:** `[Primary Function] [Specialization] [Role Type]`

**Examples:**
- `Data Discovery Specialist`
- `Quality Assurance Guardian`
- `Predictive Analytics Oracle`
- `System Architecture Engineer`
- `Security Compliance Specialist`

## Naming Conventions by Category

### Executive Agents

**Pattern:** `[Personal Name]` (preferred for dashboard display)

**Examples:**
```
✅ Maya (Loopy AI Content Strategist)
✅ Alex (DevForge AI Codesmith)
✅ Jordan (KnowledgeForge AI Administrator)
❌ CEO 2 (avoid generic numbers)
❌ Big Boss (avoid informal terms)
```

### Functional Agents

**Pattern:** `[Personal Name]` or `[Personal Name]-[Functional Descriptor]`

**Examples:**
```
✅ Sam (Data Navigator)
✅ Dev (Code Guardian)
✅ Observer (System Monitor)
✅ maya-loopy-content-strategist (Personal-Functional Hybrid)
```

### Specialized Agents

**Pattern:** `[Personal Name]` with functional context in filesystem

**Examples:**
```
✅ Vision (Strategic Planning)
✅ Alex (Data Analytics)
✅ Jordan (Quality Assurance)
Filesystem: alex-devforge-ai-data-analyst/
```

## Naming Procedure

### Step 1: Determine Agent Purpose

**Required Information:**
- Primary function or responsibility
- Target domain or specialty area
- Company context and scope
- Interaction patterns with other agents

**Questions to Answer:**
- What does this agent primarily do?
- What problem does it solve?
- How does it fit into the company ecosystem?
- What makes it unique from other agents?

### Step 2: Select Functional Name

**Guidelines:**
1. **Choose a noun or noun phrase** that describes the agent's core function
2. **Prefer single words** when possible for brevity
3. **Use action-oriented names** that imply capability
4. **Avoid generic terms** like "Manager", "Handler", "Processor"

**Selection Process:**
```sql
-- Check for existing similar names in company
SELECT name, title, role
FROM agents
WHERE company_id = 'target-company'
  AND (name ILIKE '%search_term%' OR title ILIKE '%search_term%')
ORDER BY created_at DESC;
```

### Step 3: Validate Uniqueness

**Within Company Check:**
```sql
-- Ensure name is unique within the company
SELECT COUNT(*) as existing_count
FROM agents
WHERE company_id = 'target-company'
  AND LOWER(name) = LOWER('proposed_name');
```

**Cross-Company Compatibility:**
```sql
-- Check for potential conflicts in cross-company scenarios
SELECT c.name as company_name, a.name, a.title
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE LOWER(a.name) = LOWER('proposed_name')
ORDER BY c.name;
```

### Step 4: Create Supporting Metadata

**Role Assignment:**
- Choose the most specific applicable role from the standardized list
- Consider the agent's position in the organizational hierarchy
- Ensure role aligns with actual capabilities and responsibilities

**Title Creation:**
- Start with the functional name
- Add specialization details
- Include role type for clarity
- Keep under 50 characters for UI display

### Step 5: Documentation and Registration

**Required Documentation:**
```sql
-- Agent registration with all metadata
INSERT INTO agents (
    company_id,
    name,
    role,
    title,
    capabilities,
    reports_to,
    status
) VALUES (
    'company-uuid',
    'Agent Name',
    'standardized_role',
    'Descriptive Title',
    'Detailed capability description',
    'reporting-agent-uuid',
    'active'
);
```

**Documentation Files:**
- Agent specification document in `/docs/companies/{company}/agents/`
- API documentation if applicable
- Integration guides for dependent systems

## Common Naming Patterns

### Data & Analytics Agents
```
Navigator    → Data Discovery Specialist
Oracle      → Predictive Analytics Expert
Sentinel    → Data Quality Monitor
Cartographer → Data Mapping Specialist
```

### Product & Innovation Agents
```
Catalyst     → Product Innovation Driver
Concierge   → Customer Experience Specialist
Atlas       → Product Architecture Designer
Nova        → Product Launch Coordinator
```

### Quality & Testing Agents
```
Guardian     → Quality Assurance Specialist
Inspector   → Code Review Specialist
Validator   → Compliance Verification Expert
Sentinel    → Security Testing Specialist
```

### Engineering Agents
```
Architect    → System Design Engineer
Forge       → Core Development Specialist
Automata    → DevOps Automation Expert
Cortex      → AI Integration Specialist
```

## Naming Anti-Patterns

### ❌ Avoid These Patterns

**Generic Numbers:**
```
❌ Agent 1, Agent 2, Agent 3
❌ Manager 1, Manager 2
❌ Handler A, Handler B
```

**Unclear Abbreviations:**
```
❌ DTA (what does this mean?)
❌ QAM (Quality Assurance Manager - but unclear)
❌ SYS (too generic)
```

**Informal or Inconsistent Terms:**
```
❌ Boss, Chief, Big Cheese
❌ Worker, Doer, Helper
❌ Super Agent, Mega Tool
```

**Company-Specific Jargon:**
```
❌ DevForge Special Widget Agent
❌ QualityForge Mega Validator
❌ InfraForge Cloud Thing
```

## Conflict Resolution

### Name Conflicts Within Company

**Detection:**
```sql
SELECT name, COUNT(*) as duplicate_count,
       STRING_AGG(id::text, ', ') as agent_ids
FROM agents
WHERE company_id = 'target-company'
GROUP BY name
HAVING COUNT(*) > 1;
```

**Resolution Options:**
1. **Rename less critical agent** with qualifier
2. **Merge duplicate agents** if functionally identical
3. **Add domain qualifiers** (e.g., `Data Guardian` vs `Code Guardian`)

### Cross-Company Conflicts

**Detection:**
```sql
SELECT a.name, COUNT(DISTINCT a.company_id) as company_count,
       STRING_AGG(DISTINCT c.name, ', ') as companies
FROM agents a
JOIN companies c ON a.company_id = c.id
GROUP BY a.name
HAVING COUNT(DISTINCT a.company_id) > 1;
```

**Resolution:**
- Conflicts are acceptable across companies
- Use company context to disambiguate
- Consider company prefixes only if absolutely necessary

## Automation and Tools

### Name Validation Script

```sql
CREATE OR REPLACE FUNCTION validate_agent_name(
    proposed_name TEXT,
    company_id UUID
) RETURNS JSON AS $$
DECLARE
    result JSON;
    existing_count INTEGER;
    name_quality_score INTEGER := 0;
BEGIN
    -- Check uniqueness within company
    SELECT COUNT(*) INTO existing_count
    FROM agents
    WHERE agents.company_id = validate_agent_name.company_id
      AND LOWER(name) = LOWER(proposed_name);

    -- Basic quality checks
    IF LENGTH(proposed_name) BETWEEN 3 AND 30 THEN
        name_quality_score := name_quality_score + 1;
    END IF;

    IF proposed_name !~ '[0-9]$' THEN
        name_quality_score := name_quality_score + 1;
    END IF;

    IF proposed_name !~ '^(Agent|Manager|Handler|Processor)' THEN
        name_quality_score := name_quality_score + 1;
    END IF;

    result := json_build_object(
        'name', proposed_name,
        'is_unique', existing_count = 0,
        'quality_score', name_quality_score,
        'recommendations', CASE
            WHEN existing_count > 0 THEN 'Name already exists in company'
            WHEN name_quality_score < 2 THEN 'Consider more descriptive name'
            ELSE 'Name appears suitable'
        END
    );

    RETURN result;
END;
$$ LANGUAGE plpgsql;
```

### Name Suggestion Tool

```sql
CREATE OR REPLACE FUNCTION suggest_agent_names(
    domain TEXT,
    function TEXT,
    company_id UUID
) RETURNS TEXT[] AS $$
DECLARE
    suggestions TEXT[];
    base_words TEXT[];
BEGIN
    -- Generate name suggestions based on domain and function
    base_words := ARRAY[
        domain || ' ' || function,
        function || ' ' || domain,
        domain || function,
        function || domain
    ];

    -- Add creative variations
    suggestions := ARRAY[
        domain, function, domain || function,
        function || 'er', domain || 'ist',
        domain || 'Master', function || 'Pro'
    ];

    -- Filter out existing names
    SELECT ARRAY_AGG(suggestion)
    INTO suggestions
    FROM (
        SELECT DISTINCT suggestion
        FROM UNNEST(suggestions) AS suggestion
        WHERE LENGTH(suggestion) BETWEEN 3 AND 30
          AND suggestion !~ '[0-9]$'
          AND LOWER(suggestion) NOT IN (
              SELECT LOWER(name) FROM agents WHERE agents.company_id = suggest_agent_names.company_id
          )
        LIMIT 10
    ) filtered;

    RETURN suggestions;
END;
$$ LANGUAGE plpgsql;
```

## Data Quality and Cleanup

### Agent Metadata Requirements

All agents MUST have complete metadata to ensure proper functioning:

**Required Metadata Fields:**
- **title**: Descriptive title (e.g., "Safety Research Agent", "Chief Learning Officer (CEO)")
- **team**: Team assignment (e.g., "safety-research", "executive", "learning-curriculum")
- **specialization**: Area of expertise (e.g., "Safety Standards Research", "Learning Strategy")
- **reports_to**: Reporting relationship (null for CEOs, otherwise valid agent name)

**Validation Rules:**
1. **No null metadata**: title, team, and specialization must not be null
2. **Valid team names**: Must match company team structure
3. **Valid specializations**: Should use standardized specialization terms
4. **Valid reporting**: reports_to must reference an existing agent or be null for CEOs

### Cleanup Procedure for Agents with Missing Metadata

**Step 1: Identify Agents with Missing Metadata**
```sql
-- Find agents with null or empty metadata
SELECT 
    c.name as company_name,
    a.name as agent_name,
    a.role,
    CASE WHEN a.title IS NULL OR a.title = '' THEN '❌' ELSE '✅' END as title_status,
    CASE WHEN a.metadata->>'team' IS NULL OR a.metadata->>'team' = '' THEN '❌' ELSE '✅' END as team_status,
    CASE WHEN a.metadata->>'specialization' IS NULL OR a.metadata->>'specialization' = '' THEN '❌' ELSE '✅' END as specialization_status
FROM agents a
JOIN companies c ON a.company_id = c.id
WHERE a.title IS NULL OR a.title = '' 
   OR a.metadata->>'team' IS NULL OR a.metadata->>'team' = ''
   OR a.metadata->>'specialization' IS NULL OR a.metadata->>'specialization' = ''
ORDER BY c.name, a.name;
```

**Step 2: Determine Correct Metadata**

#### For Functional-Named Agents (e.g., "learningforge-ai-safety-research-agent")
1. **Extract title from name pattern**: Convert hyphenated names to readable titles
   - `learningforge-ai-safety-research-agent` → "Safety Research Agent"
   - `learningforge-ai-mobile-patterns-agent` → "Mobile Patterns Agent"
   
2. **Assign appropriate team**: Based on company documentation and naming pattern
   - Pattern `*-research-*` → "safety-research" team
   - Pattern `*-ceo` → "executive" team
   
3. **Determine specialization**: From agent's documented responsibilities
   - Check agent's AGENTS.md documentation
   - Use documented specialization or infer from name/role

#### For Personal-Named Agents (e.g., "Amara", "Avery", "Beckett")
1. **Research agent's purpose**: Check if agent has documentation or known function
   - Look for agent directories in company documentation
   - Check if agent appears in project plans or team assignments
   
2. **Assign descriptive title**: Based on discovered function
   - If unknown function: "General Agent - [Personal Name]"
   - Example: "Amara" → "General Agent - Amara"
   
3. **Place in appropriate team**: 
   - If team unknown: "unassigned" or create logical team
   - Example: all unknown personal agents → "general-agents" team
   
4. **Define clear specialization**:
   - If unknown: "General Operations"
   - Example: "General Agent Operations"

#### For Agents with Generic Names (e.g., "Agent 1", "Manager 2")
1. **Rename the agent** using proper naming conventions
2. **Choose new name** following either Pattern 1 (Personal) or Pattern 2 (Functional)
3. **Update all references** to the old name
4. **Complete all metadata** for the new name

**Step 3: Update Metadata**
```sql
-- Example update for LearningForge AI safety research agents
UPDATE agents 
SET 
    title = CASE 
        WHEN name = 'learningforge-ai-ceo' THEN 'Chief Learning Officer (CEO)'
        WHEN name = 'learningforge-ai-safety-research-agent' THEN 'Safety Research Agent'
        WHEN name = 'learningforge-ai-mobile-patterns-agent' THEN 'Mobile Patterns Agent'
        WHEN name = 'learningforge-ai-domain-knowledge-agent' THEN 'Domain Knowledge Agent'
        WHEN name = 'learningforge-ai-learning-integration-agent' THEN 'Learning Integration Agent'
        WHEN name = 'learningforge-ai-research-coordinator' THEN 'Research Coordinator - Safety Research Team Lead'
        ELSE title 
    END,
    metadata = jsonb_set(
        jsonb_set(
            COALESCE(metadata, '{}'::jsonb),
            '{team}',
            CASE 
                WHEN name = 'learningforge-ai-ceo' THEN '"executive"'
                WHEN name LIKE 'learningforge-ai-%research%' THEN '"safety-research"'
                ELSE COALESCE(metadata->'team', '"unknown-team"'::jsonb)
            END
        ),
        '{specialization}',
        CASE 
            WHEN name = 'learningforge-ai-ceo' THEN '"Learning Strategy"'
            WHEN name = 'learningforge-ai-safety-research-agent' THEN '"Safety Standards Research"'
            WHEN name = 'learningforge-ai-mobile-patterns-agent' THEN '"Mobile UX Research"'
            WHEN name = 'learningforge-ai-domain-knowledge-agent' THEN '"Construction Domain Knowledge"'
            WHEN name = 'learningforge-ai-learning-integration-agent' THEN '"Learning Integration"'
            WHEN name = 'learningforge-ai-research-coordinator' THEN '"Research Coordination"'
            ELSE COALESCE(metadata->'specialization', '"unknown-specialization"'::jsonb)
        END
    ),
    updated_at = NOW()
WHERE company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI')
  AND (title IS NULL OR title = '' 
       OR metadata->>'team' IS NULL OR metadata->>'team' = ''
       OR metadata->>'specialization' IS NULL OR metadata->>'specialization' = '');
```

**Step 4: Verification**
```sql
-- Verify all agents have complete metadata
SELECT 
    COUNT(*) as total_agents,
    SUM(CASE WHEN title IS NULL OR title = '' THEN 1 ELSE 0 END) as missing_titles,
    SUM(CASE WHEN metadata->>'team' IS NULL OR metadata->>'team' = '' THEN 1 ELSE 0 END) as missing_teams,
    SUM(CASE WHEN metadata->>'specialization' IS NULL OR metadata->>'specialization' = '' THEN 1 ELSE 0 END) as missing_specializations
FROM agents
WHERE company_id = (SELECT id FROM companies WHERE name = 'Learning Forge AI');
```

## Quality Assurance

### Naming Review Checklist

**Before Agent Creation:**
- [ ] Name clearly indicates primary function
- [ ] Name is unique within company
- [ ] Name follows capitalization standards
- [ ] Name is appropriate length (3-30 characters)
- [ ] Name avoids generic terms and numbers
- [ ] Role classification is accurate
- [ ] Title provides clear description
- [ ] Team assignment is specified
- [ ] Specialization is defined
- [ ] Documentation includes naming rationale

**After Agent Creation:**
- [ ] Name displays correctly in all UIs
- [ ] Name works in API endpoints and queries
- [ ] Name is included in relevant documentation
- [ ] Name follows company naming patterns
- [ ] All metadata fields are populated (title, team, specialization)
- [ ] Related systems updated with new name

### Periodic Audits

**Monthly Review:**
```sql
-- Check for naming inconsistencies
SELECT
    'Unnamed agents' as issue,
    COUNT(*) as count
FROM agents
WHERE name IS NULL OR name = '';

UNION ALL

SELECT
    'Generic names' as issue,
    COUNT(*) as count
FROM agents
WHERE name ~ '^(Agent|Manager|Handler|Processor|Worker)';

UNION ALL

SELECT
    'Numbered names' as issue,
    COUNT(*) as count
FROM agents
WHERE name ~ '[0-9]$';

UNION ALL

SELECT
    'Duplicate names in company' as issue,
    COUNT(*) as count
FROM (
    SELECT company_id, name
    FROM agents
    GROUP BY company_id, name
    HAVING COUNT(*) > 1
) duplicates;
```

## Migration and Updates

### Renaming Existing Agents

**Safe Rename Procedure:**
```sql
-- Use transaction for safety
BEGIN;

-- Update agent name
UPDATE agents
SET name = 'New Name',
    title = 'New Descriptive Title',
    updated_at = NOW()
WHERE id = 'agent-uuid';

-- Update any references in logs or configurations
UPDATE agent_api_keys
SET name = CONCAT('New Name API Key - ', SUBSTRING(name, POSITION(' - ' in name) + 3))
WHERE agent_id = 'agent-uuid'
  AND name LIKE 'Old Name%';

COMMIT;
```

### Bulk Name Standardization

```sql
-- Standardize naming patterns across company
UPDATE agents
SET name = CASE
    WHEN LOWER(name) LIKE '%guardian%' THEN 'Guardian'
    WHEN LOWER(name) LIKE '%navigator%' THEN 'Navigator'
    WHEN LOWER(name) LIKE '%oracle%' THEN 'Oracle'
    ELSE name
END,
updated_at = NOW()
WHERE company_id = 'target-company';
```

## Integration Considerations

### API and System Integration

**URL Encoding:**
- Agent names in URLs: `kebab-case` or `camelCase`
- Database queries: Use parameterized queries to avoid injection
- File systems: Ensure names work as directory/file names

**External System Compatibility:**
- Check integration requirements for each external system
- Document any name mapping requirements
- Plan for name changes in integrated systems

### Search and Discovery

**Search Optimization:**
- Names should be searchable and discoverable
- Consider common synonyms and variations
- Include alternative names in metadata

**Categorization:**
- Ensure names support proper categorization
- Consider hierarchical naming for complex organizations
- Plan for future scaling needs

---

**Version:** 1.1
**Last Updated:** 2026-04-12
**Applies To:** All Paperclip Companies and Agents
**Review Cycle:** Quarterly
**Related Documents:**
- `docs-paperclip/procedures/adding-companies-and-agents.md`
- `docs-paperclip/procedures/editing-database-tables.md`
- `scripts/database/update_company_display_names.sql`
- `scripts/database/sync_agent_names.sql`

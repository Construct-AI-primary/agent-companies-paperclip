const fs = require('fs');
const path = require('path');

function generateSQLFromAGENTS(agentsMdPath, companyName) {
  const content = fs.readFileSync(agentsMdPath, 'utf8');

  // Extract agent information from AGENTS.md
  const nameMatch = content.match(/name:\s*(.+)/);
  const roleMatch = content.match(/role:\s*(.+)/);
  const titleMatch = content.match(/title:\s*(.+)/);
  const reportsToMatch = content.match(/reportsTo:\s*(.+)/);

  if (!nameMatch) {
    console.log(`Skipping ${agentsMdPath} - missing name field`);
    return null;
  }

  // If role is missing from YAML, try to extract from content
  let role = roleMatch ? roleMatch[1].trim() : null;
  if (!role) {
    const contentRoleMatch = content.match(/\*\*Role\*\*:\s*(.+)/);
    role = contentRoleMatch ? contentRoleMatch[1].trim() : 'Agent';
  }

  const agentName = nameMatch[1].trim();
  const title = titleMatch ? titleMatch[1].trim() : role; // Use role as fallback for title
  const reportsTo = reportsToMatch ? reportsToMatch[1].trim() : null;

  // Generate UUID-like ID
  const id = `gen_random_uuid()`;

  // Create SQL content
  const sql = `-- ============================================================
-- Agent Registration: ${agentName}
-- Company: ${companyName}
-- Date: 2026-04-21
-- Purpose: Register the ${agentName} agent
-- ============================================================

-- Step 1: Get ${companyName} company ID
-- SELECT id, name FROM companies WHERE name LIKE '%${companyName.replace(' AI', '')}%';

-- ============================================================
-- IMPORTANT: Schema constraints for this table:
-- - agents table has NO unique constraint on 'name'
-- - Model config is stored in adapter_config JSONB field
-- - There is NO agent_models table in this schema
-- ============================================================

-- ============================================================
-- AGENT REGISTRATION (Idempotent - uses NOT EXISTS check)
-- ============================================================
INSERT INTO agents (
  id,
  company_id,
  name,
  role,
  title,
  icon,
  status,
  reports_to,
  capabilities,
  adapter_config,
  created_at,
  updated_at
)
SELECT
  ${id},
  c.id,
  '${agentName}',
  '${role}',
  '${title}',
  '🤖',
  'idle',
  ${reportsTo ? `'${reportsTo}'` : 'NULL'},
  '["task_execution", "communication", "analysis"]',
  '{
    "adapter": "hermes_local",
    "model": "anthropic/claude-opus-4.6",
    "temperature": 0.7,
    "max_tokens": 4096
  }'::jsonb,
  NOW(),
  NOW()
FROM companies c
WHERE c.name = '${companyName}'
  AND NOT EXISTS (
    SELECT 1 FROM agents a
    WHERE a.name = '${agentName}'
      AND a.company_id = c.id
  );

-- ============================================================
-- VERIFICATION QUERY
-- ============================================================
-- SELECT id, name, role, status, adapter_config->>'model' as model
-- FROM agents WHERE name = '${agentName}';
`;

  return sql;
}

function processCompany(companyPath, companyName) {
  const agentsDir = path.join(companyPath, 'agents');

  if (!fs.existsSync(agentsDir)) {
    console.log(`No agents directory for ${companyName}`);
    return;
  }

  const agentDirs = fs.readdirSync(agentsDir, { withFileTypes: true })
    .filter(dirent => dirent.isDirectory())
    .map(dirent => path.join(agentsDir, dirent.name));

  let processed = 0;

  for (const agentDir of agentDirs) {
    const agentsMdPath = path.join(agentDir, 'AGENTS.md');
    const sqlPath = path.join(agentDir, 'register-agent.sql');

    if (fs.existsSync(agentsMdPath) && !fs.existsSync(sqlPath)) {
      const sql = generateSQLFromAGENTS(agentsMdPath, companyName);
      if (sql) {
        fs.writeFileSync(sqlPath, sql);
        processed++;
        console.log(`Created SQL for: ${path.basename(agentDir)}`);
      }
    }
  }

  console.log(`Processed ${processed} agents for ${companyName}`);
}

// Process remaining companies
const companies = [
  { path: 'docs-paperclip/companies/learningforge-ai', name: 'LearningForge AI' },
  { path: 'docs-paperclip/companies/contentforge-ai', name: 'ContentForge AI' },
  { path: 'docs-paperclip/companies/infraforge-ai', name: 'InfraForge AI' }
];

for (const company of companies) {
  console.log(`\n=== Processing ${company.name} ===`);
  processCompany(company.path, company.name);
}

console.log('\n=== SQL Script Generation Complete ===');
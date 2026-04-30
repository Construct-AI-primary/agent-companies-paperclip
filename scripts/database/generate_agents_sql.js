#!/usr/bin/env node

/**
 * Generate SQL for all DomainForge AI agents from documentation
 * Reads agent documentation files and generates INSERT statements
 */

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Company configurations - dynamically load all companies
const COMPANIES = {};
const companiesDir = path.join(__dirname, '../../docs-paperclip/companies');

// Company ID mappings - updated to match local database IDs
const COMPANY_ID_MAP = {
  'contentforge-ai': '550e8400-e29b-41d4-a716-446655440008',
  'devforge-ai': 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'domainforge-ai': '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'execforge-ai': '550e8400-e29b-41d4-a716-446655440010',
  'infraforge-ai': '09f438a3-4041-46f2-b3cc-96fc9446e666',
  'knowledgeforge-ai': '550e8400-e29b-41d4-a716-446655440007',
  'loopy-ai': '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'mobileforge-ai': '550e8400-e29b-41d4-a716-446655440009',
  'org-template-ai': 'c4d52645-a0ea-4a26-b381-baf0b3042f34',
  'paperclipforge-ai': '550e8400-e29b-41d4-a716-446655440001',
  'promptforge-ai': 'f02b83a8-e0db-4332-b507-22f85e71ebf5',
  'qualityforge-ai': 'a4f9d4c6-33f5-4552-b32d-054552144edf',
  'saasforge-ai': '550e8400-e29b-41d4-a716-446655440011',
  'voiceforge-ai': '550e8400-e29b-41d4-a716-446655440012'
};

// Load all companies dynamically
const companyDirs = fs.readdirSync(companiesDir).filter(dir => dir.endsWith('-ai') && fs.existsSync(path.join(companiesDir, dir, 'agents')));

companyDirs.forEach(companyDir => {
  const companyKey = companyDir.replace('-ai', '');
  const agentsPath = path.join(companiesDir, companyDir, 'agents');
  const companyId = COMPANY_ID_MAP[companyDir];

  if (companyId && fs.existsSync(agentsPath)) {
    COMPANIES[companyKey] = {
      id: companyId,
      path: agentsPath
    };
  }
});

// Global map to store consistent UUIDs for each slug
const slugToUuidMap = new Map();
let uuidCounter = 0;

// Generate UUID-like ID from agent slug (deterministic but unique)
function generateAgentId(slug) {
  // Use a fallback key for empty slugs
  const key = slug || `empty-slug-${uuidCounter}`;

  if (slugToUuidMap.has(key)) {
    return slugToUuidMap.get(key);
  }

  // Generate a deterministic UUID based on slug and counter
  const base = 'a1b2c3d4-e5f6-7890-abcd-';
  const counterHex = (uuidCounter++).toString(16).padStart(12, '0');
  const uuid = base + counterHex;

  slugToUuidMap.set(key, uuid);
  return uuid;
}

// Parse agent documentation file
function parseAgentFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const lines = content.split('\n');

  let name = '';
  let slug = '';
  let reportsTo = null;
  let skills = [];

  // Parse frontmatter
  let inFrontmatter = false;
  for (const line of lines) {
    if (line.trim() === '---') {
      inFrontmatter = !inFrontmatter;
      continue;
    }

    if (inFrontmatter) {
      if (line.startsWith('name:')) {
        name = line.split(':')[1].trim();
      } else if (line.startsWith('slug:')) {
        slug = line.split(':')[1].trim();
      } else if (line.startsWith('reportsTo:')) {
        const reportsToValue = line.split(':')[1].trim();
        reportsTo = reportsToValue === 'null' ? null : reportsToValue;
      } else if (line.startsWith('skills:')) {
        // Skills are on subsequent lines
      } else if (line.startsWith('  - ')) {
        skills.push(line.trim().substring(4));
      }
    } else if (line.startsWith('# ')) {
      // Fallback for name if not in frontmatter
      if (!name) {
        name = line.substring(2).trim();
      }
      break;
    }
  }

  return { name, slug, reportsTo, skills };
}

// Generate SQL for a single agent
function generateAgentSQL(agentData, companyId, teamName) {
  const { name, slug, reportsTo, skills } = agentData;
  const id = generateAgentId(slug);

  // Determine role based on slug patterns
  let role = 'specialist';
  let title = name;

  if (slug.includes('-ceo')) {
    role = 'ceo';
    title = 'Chief Executive Officer';
  } else if (slug.includes('-director') || slug.includes('director-')) {
    role = 'director';
    title = title.replace(/-director|-/g, ' ').trim() + ' Director';
  } else if (slug.includes('engineering')) {
    role = 'engineer';
    title = title.replace(/-engineering/g, '').trim() + ' Engineering Specialist';
  } else if (slug.includes('specialist')) {
    role = 'specialist';
    title = title.replace(/-specialist/g, '').trim() + ' Specialist';
  }

  const capabilities = `${name} - Specialized in ${skills.join(', ')}`;
  const metadata = JSON.stringify({
    team: teamName,
    skills: skills,
    source: 'documentation-generated'
  });

  const adapterConfig = JSON.stringify({
    url: 'https://ecb3-102-132-198-101.ngrok-free.app/webhook',
    model: 'openrouter/qwen/qwen-3-6-plus',
    api_key: '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',
    provider: 'openrouter',
    maxIterations: 50,
    persistSession: true
  });

  const runtimeConfig = JSON.stringify({
    persistSession: true
  });

  const permissions = JSON.stringify({
    canCreateAgents: false
  });

  return `(
  '${id}',
  '${companyId}',
  '${name}',
  '${role}',
  '${title}',
  'active',
  NULL,
  '${capabilities.replace(/'/g, "''")}',
  'http',
  '${adapterConfig.replace(/'/g, "''")}',
  0,
  0,
  NULL,
  '${metadata.replace(/'/g, "''")}',
  '2026-03-30T15:53:36.729Z',
  '2026-04-09T17:00:00.000Z',
  '${runtimeConfig.replace(/'/g, "''")}',
  '${permissions.replace(/'/g, "''")}',
  NULL,
  NULL,
  NULL
)`;
}

// Main function
function main() {
  try {
    const allAgentSQLs = [];

    for (const [companyKey, companyConfig] of Object.entries(COMPANIES)) {
      console.log(`\nProcessing ${companyKey}...`);

      // Read all agent directories for this company
      const agentDirs = fs.readdirSync(companyConfig.path)
        .filter(dir => fs.statSync(path.join(companyConfig.path, dir)).isDirectory())
        .sort();

      console.log(`Found ${agentDirs.length} agent directories for ${companyKey}`);

      for (const dir of agentDirs) {
        const agentFile = path.join(companyConfig.path, dir, 'AGENTS.md');

        if (fs.existsSync(agentFile)) {
          try {
            const agentData = parseAgentFile(agentFile);
            const teamName = companyKey === 'domainforge' ? 'DomainForge AI' : 'InfraForge AI';
            const sql = generateAgentSQL(agentData, companyConfig.id, teamName);
            allAgentSQLs.push(sql);
            console.log(`Processed: ${companyKey}/${dir}`);
          } catch (error) {
            console.error(`Error processing ${companyKey}/${dir}:`, error.message);
          }
        } else {
          console.warn(`No AGENTS.md file found in ${companyKey}/${dir}`);
        }
      }
    }

    // Generate complete SQL
    const sql = `INSERT INTO agents (
  id, company_id, name, role, title, status, reports_to, capabilities,
  adapter_type, adapter_config, budget_monthly_cents, spent_monthly_cents,
  last_heartbeat_at, metadata, created_at, updated_at, runtime_config,
  permissions, icon, pause_reason, paused_at
) VALUES
${allAgentSQLs.join(',\n')}
ON CONFLICT (id) DO NOTHING;`;

    // Write to file
    const outputPath = path.join(__dirname, 'all_agents_insert.sql');
    fs.writeFileSync(outputPath, sql);

    console.log(`\nGenerated SQL for ${allAgentSQLs.length} agents total`);
    console.log(`Output written to: ${outputPath}`);

  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

main();
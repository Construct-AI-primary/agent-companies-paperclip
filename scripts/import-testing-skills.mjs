#!/usr/bin/env node
/**
 * Import all testing skills from doc/ directory and assign to agents
 * Usage: node scripts/import-testing-skills.mjs --api-base https://paperclip-render.onrender.com --api-key YOUR_API_KEY
 */

import fs from 'fs/promises';
import path from 'path';
import { execSync } from 'child_process';

const API_BASE = process.argv.includes('--api-base')
  ? process.argv[process.argv.indexOf('--api-base') + 1]
  : 'http://localhost:3100';
const API_KEY = process.argv.includes('--api-key')
  ? process.argv[process.argv.indexOf('--api-key') + 1]
  : null;
const COMPANY_ID = process.argv.includes('--company-id')
  ? process.argv[process.argv.indexOf('--company-id') + 1]
  : null;

// Map of agent name -> skill directory name
const AGENT_SKILL_MAP = {
  'browser-ui-tester-qualityforge': [
    'browser-ui-testing-qualityforge',
    'navigation-sitemap-testing-qualityforge',
    'templates-forms-testing-qualityforge',
    'document-management-testing-qualityforge',
    'agent-systems-testing-qualityforge',
    'advanced-features-testing-qualityforge',
    'ux-research-testing-loopy',
    'accordion-testing',
    'testing-verification',
    'error-monitoring-testing-qualityforge',
    'performance-testing-qualityforge',
    'i18n-testing-qualityforge',
  ],
  'auth-tester-qualityforge': [
    'auth-login-testing-qualityforge',
    'hitl-workflow-testing-qualityforge',
    'testing-verification',
  ],
  'chatbot-tester-promptforge': [
    'chatbot-integration-testing-promptforge',
    'testing-verification',
  ],
  'supabase-tester-infraforge': [
    'supabase-testing-infraforge',
    'database-infraforge-database-infrastructure',
    'testing-verification',
  ],
  'env-tester-devforge': [
    'env-validation-devforge',
    'testing-verification',
  ],
  'procurement-tester-domainforge': [
    'procurement-testing-domainforge',
    'testing-verification',
  ],
  'ux-researcher-loopy': [
    'ux-research-testing-loopy',
    'testing-verification',
  ],
};

// Skill source locations (where SKILL.md files live)
const SKILL_DIRS = [
  'doc/companies/qualityforge-ai/skills',
  'doc/companies/infraforge-ai/skills',
  'doc/companies/devforge-ai/skills',
  'doc/companies/domainforge-ai/skills',
  'doc/companies/promptforge-ai/skills',
  'doc/companies/loopy-ai/skills',
  'doc/companies/shared',
];

async function findSkillFile(skillName) {
  for (const baseDir of SKILL_DIRS) {
    const skillPath = path.join(baseDir, skillName, 'SKILL.md');
    try {
      const full = path.join(process.cwd(), '..', 'paperclip-render', skillPath);
      await fs.stat(full);
      return { path: full, name: skillName };
    } catch {}
  }
  // Try direct lookup in current doc tree
  const directPath = path.join(process.cwd(), 'doc', 'companies', 'shared', skillName, 'SKILL.md');
  try {
    await fs.stat(directPath);
    return { path: directPath, name: skillName };
  } catch {}

  // Search any companies dir
  const companiesDir = path.join(process.cwd(), 'doc', 'companies');
  try {
    const companies = await fs.readdir(companiesDir);
    for (const company of companies) {
      const skillPath = path.join(companiesDir, company, 'skills', skillName, 'SKILL.md');
      try {
        await fs.stat(skillPath);
        return { path: skillPath, name: skillName };
      } catch {}
    }
  } catch {}

  return null;
}

async function importSkill(skillDir) {
  const skillPath = skillDir + '/SKILL.md';
  try {
    const content = await fs.readFile(skillPath, 'utf-8');
    const skillName = path.basename(path.dirname(skillPath));

    const res = await fetch(`${API_BASE}/api/companies/${COMPANY_ID}/skills/import`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        skills: [{ path: skillPath, name: skillName, content }],
      }),
    });

    if (res.ok) {
      console.log(`✅ Imported skill: ${skillName}`);
      return skillName;
    } else {
      const err = await res.text();
      console.warn(`⚠️  Skill ${skillName}: ${err}`);
      return null;
    }
  } catch (e) {
    console.warn(`⚠️  Skill ${skillDir}/SKILL.md: ${e.message}`);
    return null;
  }
}

async function scanAllSkills() {
  const found = [];
  for (const baseDir of SKILL_DIRS) {
    const fullPath = path.join(process.cwd(), '..', 'paperclip-render', baseDir);
    try {
      const entries = await fs.readdir(fullPath, { withFileTypes: true });
      for (const entry of entries) {
        if (entry.isDirectory()) {
          const skillPath = path.join(fullPath, entry.name, 'SKILL.md');
          try {
            await fs.stat(skillPath);
            found.push({ name: entry.name, path: skillPath });
          } catch {}
        }
      }
    } catch {}
  }
  return found;
}

async function assignSkillsToAgent(agentName, skills) {
  console.log(`\nAssigning ${skills.length} skills to ${agentName}...`);
  const res = await fetch(`${API_BASE}/api/agents/${COMPANY_ID}/skills/sync`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ agentName, desiredSkills: skills }),
  });

  if (res.ok) {
    console.log(`✅ Assigned skills to ${agentName}`);
  } else {
    console.warn(`⚠️  Failed to assign skills to ${agentName}: ${await res.text()}`);
  }
}

async function main() {
  if (!API_KEY) {
    console.error('Error: --api-key is required');
    console.error('Usage: node import-testing-skills.mjs --api-base https://paperclip-render.onrender.com --api-key YOUR_KEY --company-id YOUR_COMPANY_ID');
    process.exit(1);
  }
  if (!COMPANY_ID) {
    console.error('Error: --company-id is required');
    process.exit(1);
  }

  console.log(`Target: ${API_BASE} (company: ${COMPANY_ID})`);
  console.log('\n📋 Scanning skill directories...\n');

  const skills = await scanAllSkills();
  console.log(`Found ${skills.length} skills with SKILL.md files\n`);
  console.log('Skills found:');
  for (const s of skills) {
    console.log(`  - ${s.name}`);
  }

  for (const skill of skills) {
    await importSkill(skill.path);
  }

  console.log('\n📤 Assigning skills to agent groups...\n');

  for (const [agentName, skillList] of Object.entries(AGENT_SKILL_MAP)) {
    const existing = skillList.filter(s => skills.find(found => found.name === s));
    if (existing.length > 0) {
      await assignSkillsToAgent(agentName, existing);
    }
  }

  console.log('\n✅ Done! Skills imported and assigned.');
}

main().catch(console.error);
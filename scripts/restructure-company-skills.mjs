#!/usr/bin/env node
/**
 * Restructure company skill directories to follow agentcompanies/v1 spec.
 * 
 * Converts from:
 *   docs-construct-ai/skills/{company-slug}/           (flat skills)
 *   docs-construct-ai/skills/{company-slug}/{agent}/   (agent-specific SKILL.md)
 *   docs-construct-ai/skills/{company_slug}/           (duplicate with underscores)
 *
 * To:
 *   docs-construct-ai/skills/{company}/
 *   ├── COMPANY.md                    # Company metadata
 *   ├── agents/
 *   │   └── {agent-slug}/AGENTS.md    # Agent definitions with skill refs
 *   └── skills/
 *       ├── {skill-slug}/SKILL.md     # Individual skills
 *       └── shared/                   # Shared cross-company skills (symlinks or copies)
 *
 * Usage:
 *   node restructure-company-skills.mjs --company loopy-ai --agents-alex --dry-run
 *
 * Options:
 *   --company <slug>    Company slug name (e.g., "loopy-ai")
 *   --agents-<name>     Agent names to create AGENTS.md for (multiple allowed)
 *   --dry-run           Preview changes without making them
 *   --help              Show this help
 */

import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Parse arguments
function parseArgs() {
  const args = process.argv.slice(2);
  const opts = {
    company: null,
    agents: [],
    dryRun: false,
    help: false,
  };
  
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === '--help' || arg === '-h') {
      opts.help = true;
    } else if (arg === '--dry-run' || arg === '-n') {
      opts.dryRun = true;
    } else if (arg === '--company') {
      opts.company = args[++i];
    } else if (arg === '--agents-') {
      opts.agents.push(args[++i]);
    } else if (arg.startsWith('--agents-')) {
      opts.agents.push(arg.slice('--agents-'.length));
    } else if (arg === '--all') {
      // Special: process all companies
      opts.company = '__ALL__';
    }
  }
  return opts;
}

// Parse YAML frontmatter from string
function parseFrontmatter(text) {
  const match = text.match(/^---\s*\n([\s\S]*?)\n---/);
  if (!match) return { data: {}, body: text };
  const data = {};
  for (const line of match[1].split('\n')) {
    const kv = line.match(/^(\w[\w.-]*):\s*(.*)$/);
    if (kv) {
      const key = kv[1];
      const val = kv[2].replace(/^['"]|['"]$/g, '').trim();
      data[key] = val;
    }
  }
  return {
    data,
    body: text.slice(match[0].length).trim(),
  };
}

// Get directory contents (non-recursively)
async function listDir(dir) {
  try {
    return await fs.readdir(dir, { withFileTypes: true });
  } catch {
    return [];
  }
}

// Find all company directories
async function findCompanies(skillsRoot) {
  const entries = await listDir(skillsRoot);
  const companies = [];
  for (const entry of entries) {
    if (entry.isDirectory()) {
      const subEntries = await listDir(path.join(skillsRoot, entry.name));
      // A company dir has SKILL.md, AGENTS.md, or sub-dirs with SKILL.md
      const hasSkills = subEntries.some(e => 
        e.name.endsWith('-deep-research') ||
        e.name.endsWith('-content-strategist') ||
        e.name.endsWith('-marketing-specialist') ||
        e.name.endsWith('-social-media-coordinator') ||
        e.name.endsWith('-technical-creative') ||
        e.name.endsWith('-ceo') ||
        (e.isDirectory() && subEntries.some(s => s.name === 'SKILL.md'))
      );
      if (hasSkills) {
        companies.push(entry.name);
      }
    }
  }
  return companies;
}

// Process a single company
async function processCompany(skillsRoot, companySlug, dryRun) {
  const companyDir = path.join(skillsRoot, companySlug);
  const altDir = path.join(skillsRoot, companySlug.replace(/-/g, '_')); // underscore variant
  
  console.log(`\n═══════════════════════════════════════`);
  console.log(`Processing: ${companySlug}`);
  console.log(`═══════════════════════════════════════`);
  
  // List all directories inside company
  const entries = await listDir(companyDir);
  const agentSpecificSkills = [];  // dirs like alex-loopy-deep-research/SKILL.md
  const sharedSkills = [];         // dirs like brainstorming/SKILL.md
  const otherFiles = [];
  
  for (const entry of entries) {
    if (entry.isDirectory()) {
      const skillPath = path.join(companyDir, entry.name, 'SKILL.md');
      try {
        await fs.access(skillPath);
        // Check if this is an agent-specific skill (has agent name prefix)
        const content = await fs.readFile(skillPath, 'utf-8');
        const { data } = parseFrontmatter(content);
        const name = data.name || entry.name;
        
        // Detect agent-specific by name pattern
        const agentMatch = name.match(/^(\w+)-(\w+)-([\w-]+)$/);
        if (agentMatch && (
          name.includes('-deep-research') ||
          name.includes('-technical-creative') ||
          name.includes('-content-strategist') ||
          name.includes('-marketing-specialist') ||
          name.includes('-social-media-coordinator') ||
          name.includes('-ceo')
        )) {
          agentSpecificSkills.push({ dir: entry.name, path: skillPath, data, content });
        } else {
          sharedSkills.push({ dir: entry.name, path: skillPath, data, content });
        }
      } catch {
        // Not a skill dir
        otherFiles.push(entry.name);
      }
    } else if (entry.isFile()) {
      otherFiles.push(entry.name);
    }
  }
  
  console.log(`  Agent-specific skills: ${agentSpecificSkills.length}`);
  for (const s of agentSpecificSkills) {
    console.log(`    • ${s.dir} (name: ${s.data.name || s.dir})`);
  }
  console.log(`  Shared skills: ${sharedSkills.length}`);
  console.log(`  Other files: ${otherFiles.length}`);
  
  // Check for duplicate with underscores
  let altSkills = [];
  if (await fs.access(altDir).catch(() => null)) {
    console.log(`  ⚠️  Duplicate directory found: ${companySlug.replace(/-/g, '_')}/`);
    const altEntries = await listDir(altDir);
    for (const entry of altEntries) {
      if (entry.isDirectory()) {
        const skillPath = path.join(altDir, entry.name, 'SKILL.md');
        try {
          await fs.access(skillPath);
          // Check it's not a duplicate of an existing skill
          const existing = agentSpecificSkills.find(s => s.dir === entry.name);
          if (!existing) {
            const content = await fs.readFile(skillPath, 'utf-8');
            const { data } = parseFrontmatter(content);
            altSkills.push({ dir: entry.name, path: skillPath, data, content, source: altDir });
          }
        } catch {}
      }
    }
    console.log(`  Unique skills in duplicate: ${altSkills.length}`);
  }
  
  if (dryRun) {
    console.log('\n  [DRY RUN] Would create:');
    console.log(`    COMPANY.md`);
    console.log(`    agents/`);
    for (const s of agentSpecificSkills) {
      console.log(`      ${s.dir.replace(/-/g, '-')}/AGENTS.md`);
    }
    console.log(`    skills/`);
    for (const s of sharedSkills) {
      console.log(`      ${s.dir}/SKILL.md`);
    }
    for (const s of altSkills) {
      console.log(`      ${s.dir}/SKILL.md [from duplicate]`);
    }
    console.log(`    🗑️  Delete: ${companySlug.replace(/-/g, '_')}/`);
    return;
  }
  
  // Create COMPANY.md
  if (!otherFiles.includes('COMPANY.md')) {
    const companyMd = `---
schema: agentcompanies/v1
kind: company
slug: ${companySlug}
name: ${companySlug.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}
description: >
  ${companySlug} company from Construct AI.
version: 0.1.0
---

# ${companySlug.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}

## Overview

Auto-generated company package following agentcompanies/v1 specification.

## Structure

- \`agents/\` — Agent definitions with skill references
- \`skills/\` — Company skill packages
- \`COMPANY.md\` — This file
`;
    console.log(`  ✏  Creating COMPANY.md`);
    await fs.writeFile(path.join(companyDir, 'COMPANY.md'), companyMd);
  }
  
  // Create agents/
  const agentsDir = path.join(companyDir, 'agents');
  await fs.mkdir(agentsDir, { recursive: true });
  
  for (const skill of agentSpecificSkills) {
    const agentName = skill.data.name || skill.dir;
    const agentSlug = skill.dir;
    
    const agentsMd = `---
name: ${agentName}
slug: ${agentSlug}
reportsTo: ${skill.data.reportsTo || 'null'}
skills:
  - ${agentSlug}
---

# ${agentName}

${skill.data.description || `Agent for ${companySlug}.`}
`;
    console.log(`  ✏  Creating agents/${agentSlug}/AGENTS.md`);
    await fs.mkdir(path.join(companyDir, 'agents', agentSlug), { recursive: true });
    await fs.writeFile(path.join(companyDir, 'agents', agentSlug, 'AGENTS.md'), agentsMd);
  }
  
  // Create skills/ — move all skills here
  const skillsDir = path.join(companyDir, 'skills');
  await fs.mkdir(skillsDir, { recursive: true });
  
  // Move shared skills
  for (const skill of sharedSkills) {
    const destSkillDir = path.join(skillsDir, skill.dir);
    if (!(await fs.access(destSkillDir).catch(() => null))) {
      console.log(`  ✏  Moving skills/${skill.dir}/SKILL.md`);
      await fs.mkdir(destSkillDir, { recursive: true });
      await fs.copyFile(skill.path, path.join(destSkillDir, 'SKILL.md'));
      // Mark for deletion
    }
  }
  
  // Move agent-specific skills
  for (const skill of agentSpecificSkills) {
    const destSkillDir = path.join(skillsDir, skill.dir);
    if (!(await fs.access(destSkillDir).catch(() => null))) {
      console.log(`  ✏  Moving skills/${skill.dir}/SKILL.md`);
      await fs.mkdir(destSkillDir, { recursive: true });
      await fs.copyFile(skill.path, path.join(destSkillDir, 'SKILL.md'));
    }
  }
  
  // Move unique skills from duplicate
  for (const skill of altSkills) {
    const destSkillDir = path.join(skillsDir, skill.dir);
    if (!(await fs.access(destSkillDir).catch(() => null))) {
      console.log(`  ✏  Moving skills/${skill.dir}/SKILL.md [from duplicate]`);
      await fs.mkdir(destSkillDir, { recursive: true });
      await fs.copyFile(skill.path, path.join(destSkillDir, 'SKILL.md'));
    }
  }
  
  // Delete duplicate
  if (altSkills.length > 0 || agentSpecificSkills.length > 0) {
    if (await fs.access(altDir).catch(() => null)) {
      console.log(`  🗑️  Deleting duplicate: ${path.basename(altDir)}/`);
      if (!dryRun) {
        await fs.rm(altDir, { recursive: true, force: true });
      }
    }
  }
  
  console.log(`  ✅ Done: ${companySlug}`);
}

// Main
async function main() {
  const opts = parseArgs();
  
  if (opts.help || !opts.company) {
    console.log(`Usage:
  node restructure-company-skills.mjs --company loopy-ai [--dry-run]
  node restructure-company-skills.mjs --company loopy-ai --agents-alex --agents-maya
  node restructure-company-skills.mjs --all [--dry-run]

Options:
  --company <slug>    Company to process
  --agents-<name>     Create AGENTS.md for specific agents
  --dry-run           Preview without changes
  --all               Process all companies
  --help              Show this help
`);
    process.exit(0);
  }
  
  const skillsRoot = path.resolve(__dirname, '..', 'docs-construct-ai', 'skills');
  
  if (opts.company === '__ALL__') {
    const companies = await findCompanies(skillsRoot);
    console.log(`Found ${companies.length} companies: ${companies.join(', ')}`);
    for (const company of companies) {
      await processCompany(skillsRoot, company, opts.dryRun);
    }
  } else {
    await processCompany(skillsRoot, opts.company, opts.dryRun);
  }
}

main().catch(err => {
  console.error('Error:', err);
  process.exit(1);
});
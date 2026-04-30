#!/usr/bin/env node
/**
 * Insert skills into Supabase via the REST API (batches of 10).
 * Usage: SUPABASE_URL=xxx SUPABASE_KEY=xxx node insert_skills_to_supabase.mjs
 */

import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// Config from env
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Error: Set SUPABASE_URL and SUPABASE_KEY environment variables');
  console.error('Usage: SUPABASE_URL=https://xxx SUPABASE_KEY=xxx node insert_skills_to_supabase.mjs');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

// Company ID mapping (matches Supabase)
const COMPANY_IDS = {
  "devforge-ai": "f97b30e8-b022-4350-b4b0-30d43e2ebcf4",
  "promptforge-ai": "9ec4c0ec-d8f1-48ab-b473-ec164b584129",
  "qualityforge-ai": "f535f9bc-00be-4b6d-9f53-c53abfacacef",
  "domainforge-ai": "2d7d9c60-c02f-42a7-8f6a-7db86ecc879d",
  "loopy-ai": "0a40625e-78f9-4b0a-82e4-169a8befa021",
  "infraforge-ai": "09f438a3-4041-46f2-b3cc-96fc9446e666",
};

const SKILLS_DIR = path.resolve(__dirname, '../../../../skills');
const BATCH_SIZE = 10;

function parseFrontmatter(content) {
  const match = content.match(/^---\n(.*?)\n---\n(.*)/s);
  if (match) {
    let name = '', description = '';
    const lines = match[1].split('\n');
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      if (line.startsWith('name:')) {
        name = (line.substring(5) || '').trim();
      } else if (line.startsWith('description:')) {
        // Handle multi-line YAML description (> or |)
        let desc = line.substring(12).trim();
        if (desc === '>' || desc === '|') {
          // Collect indented continuation lines
          const descLines = [];
          for (let j = i + 1; j < lines.length; j++) {
            if (lines[j].startsWith('  ') || lines[j].startsWith('\t')) {
              descLines.push(lines[j].trim());
            } else if (lines[j].trim() === '') {
              descLines.push('');
            } else {
              break;
            }
          }
          desc = descLines.join(' ').trim();
        }
        description = desc || '';
      }
    }
    return { name, description };
  }
  return { name: '', description: '' };
}

function collectSkills() {
  const skills = [];
  const companies = fs.readdirSync(SKILLS_DIR).filter(d => {
    const p = path.join(SKILLS_DIR, d);
    return fs.statSync(p).isDirectory() && (COMPANY_IDS[d] || d === 'shared');
  }).sort();

  for (const company of companies) {
    const companyPath = path.join(SKILLS_DIR, company);
    const skillDirs = fs.readdirSync(companyPath).sort();

    for (const skillDir of skillDirs) {
      const skillFile = path.join(companyPath, skillDir, 'SKILL.md');
      if (!fs.existsSync(skillFile)) continue;

      const content = fs.readFileSync(skillFile, 'utf-8');
      const { name, description } = parseFrontmatter(content);
      const key = name || skillDir;
      const slug = name || skillDir;

      skills.push({
        company_id: company === 'shared' ? null : COMPANY_IDS[company],
        key,
        slug,
        name: name || skillDir,
        description: description || `Skill: ${skillDir}`,
        markdown: content,
        source_type: 'local_path',
        source_locator: `/skills/${company}/${skillDir}/SKILL.md`,
        trust_level: 'markdown_only',
        compatibility: 'compatible',
        file_inventory: [],
      });
    }
  }
  return skills;
}

async function upsertSkill(skill) {
  // Shared skills go to shared_skills table, company skills to company_skills
  const isShared = !skill.company_id;
  const table = isShared ? 'shared_skills' : 'company_skills';

  // Check if exists
  const { data: existing } = await supabase
    .from(table)
    .select('id')
    .eq('key', skill.key)
    .single();

  if (existing) {
    // Update
    const { error } = await supabase
      .from(table)
      .update({
        name: skill.name,
        description: skill.description,
        markdown: skill.markdown,
        updated_at: new Date().toISOString(),
      })
      .eq('key', skill.key);

    if (error) return { action: 'update', key: skill.key, success: false, error: error.message };
    return { action: 'update', key: skill.key, success: true };
  } else {
    // Insert
    const insertData = {
      key: skill.key,
      slug: skill.slug,
      name: skill.name,
      description: skill.description,
      markdown: skill.markdown,
      source_type: skill.source_type,
      source_locator: skill.source_locator,
      trust_level: skill.trust_level,
      compatibility: skill.compatibility,
      file_inventory: skill.file_inventory,
    };

    if (!isShared) {
      insertData.company_id = skill.company_id;
    }

    const { error } = await supabase
      .from(table)
      .insert([insertData]);

    if (error) return { action: 'insert', key: skill.key, success: false, error: error.message };
    return { action: 'insert', key: skill.key, success: true };
  }
}

async function main() {
  console.log('Collecting skills from markdown files...');
  const skills = collectSkills();
  console.log(`Found ${skills.length} skills to insert/update\n`);

  let inserted = 0, updated = 0, failed = 0;

  for (let i = 0; i < skills.length; i += BATCH_SIZE) {
    const batch = skills.slice(i, i + BATCH_SIZE);
    const batchNum = Math.floor(i / BATCH_SIZE) + 1;
    const totalBatches = Math.ceil(skills.length / BATCH_SIZE);

    console.log(`Batch ${batchNum}/${totalBatches} (${batch.length} skills)...`);

    const results = await Promise.all(batch.map(upsertSkill));

    for (const r of results) {
      if (r.success) {
        if (r.action === 'insert') inserted++;
        else updated++;
        console.log(`  ✓ ${r.action}: ${r.key}`);
      } else {
        failed++;
        console.log(`  ✗ ${r.action}: ${r.key} - ${r.error}`);
      }
    }
  }

  console.log(`\nDone! Inserted: ${inserted}, Updated: ${updated}, Failed: ${failed}`);
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
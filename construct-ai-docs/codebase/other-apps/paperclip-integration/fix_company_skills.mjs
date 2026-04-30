#!/usr/bin/env node
/**
 * Fix company_skills: Remove wrong skills, add correct ones per company.
 * 
 * Problem: company_skills for DevForge AI incorrectly contains:
 *   - Paperclip internal skills (para-memory-files, paperclip-create-*)
 *   - Construct-AI discipline skills (commercial-*, sales-*, director-*, etc.)
 *   - Shared flat skills that should be in shared_skills
 * 
 * The correct skills live in skill directories and need to be loaded properly.
 */

import { createClient } from '@supabase/supabase-js';
import { readdirSync, readFileSync } from 'node:fs';
import { join, basename } from 'node:path';

const SKILLS_ROOT = process.env.SKILLS_ROOT || join(process.cwd(), '../../docs-construct-ai/skills');
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Error: Set SUPABASE_URL and SUPABASE_KEY environment variables');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

// Company IDs
const COMPANY_IDS = {
  'devforge-ai': 'f97b30e8-b022-4350-b4b0-30d43e2ebcf4',
  'promptforge-ai': '9ec4c0ec-d8f1-48ab-b473-ec164b584129',
  'qualityforge-ai': 'f535f9bc-00be-4b6d-9f53-c53abfacacef',
  'domainforge-ai': '2d7d9c60-c02f-42a7-8f6a-7db86ecc879d',
  'loopy-ai': '0a40625e-78f9-4b0a-82e4-169a8befa021',
  'infraforge-ai': '09f438a3-4041-46f2-b3cc-96fc9446e666',
};

// Skills to DELETE from ALL company_skills (these are internal or wrong)
const SKILL_KEYS_TO_DELETE = [
  'paperclipai/paperclip/para-memory-files',
  'paperclipai/paperclip/paperclip',
  'paperclipai/paperclip/paperclip-create-agent',
  'paperclipai/paperclip/paperclip-create-plugin',
  // Construct-AI discipline skills that got wrongly assigned to companies
  'commercial-approval-routing',
  'commercial-cash-flow-prediction',
  'commercial-claim-quantification',
  'commercial-clause-extraction',
  'commercial-compliance-monitoring',
  'commercial-contract-amendment',
  'commercial-contract-drafting',
  'commercial-contract-interpretation',
  'commercial-correspondence-drafting',
  'commercial-cost-escalation-forecasting',
  'commercial-cost-estimation',
  'commercial-counterparty-risk-assessment',
  'commercial-dispute-resolution',
  'commercial-market-intelligence',
  'commercial-negotiation-outcome-prediction',
  'commercial-negotiation-strategy',
  'commercial-obligation-tracking',
  'commercial-predictive-counterparty-risk',
  'commercial-pricing-analysis',
  'commercial-quotation-analysis',
  'commercial-risk-assessment',
  'commercial-risk-register-management',
  'commercial-supplier-evaluation',
  'commercial-tender-document-preparation',
  'commercial-variation-order-analysis',
  'sales-bid-preparation',
  'sales-bid-proposal-preparation',
  'sales-client-relationship-account',
  'sales-client-relationship',
  'sales-lead-qualification-scoring',
  'sales-lead-qualification',
  'sales-market-intelligence-gathering',
  'sales-pipeline-forecasting',
  'sales-pipeline-tracking',
  'director-board-preparation',
  'director-executive-reporting',
  'director-strategic-oversight',
  'sundry-admin-coordination',
  'sundry-event-scheduling',
  'sundry-office-management',
  'board-governance',
  'gps-approval-configuration',
  'sd-client-portfolios',
  'sd-negotiation-oversight',
  'sd-sales-strategy',
  'pd-contract-negotiations',
  'pd-procurement-strategy',
  'pd-supplier-performance',
  'fd-audit-oversight',
  'fd-financial-strategy',
  'fd-investor-reporting',
  'prjd-portfolio-oversight',
  'librarian-devforge-knowledge-management',
];

// Flat shared-ish skills that were duplicated per company (should be in shared_skills)
const FLAT_SKILLS_TO_DELETE = [
  'dev-api-integration', 'dev-cicd-pipeline', 'dev-code-review', 'dev-testing-automation',
];

async function deleteWrongSkills() {
  const allKeys = [...SKILL_KEYS_TO_DELETE, ...FLAT_SKILLS_TO_DELETE];
  console.log(`Deleting ${allKeys.length} wrong skill keys from company_skills...\n`);

  for (const key of allKeys) {
    const { error } = await supabase
      .from('company_skills')
      .delete()
      .eq('key', key);
    if (error) {
      console.log(`  ✗ Delete ${key}: ${error.message}`);
    } else {
      console.log(`  ✓ Deleted ${key}`);
    }
  }
}

async function loadCompanySkillsFromDirectory(companyName, companyId) {
  const skillsDir = join(SKILLS_ROOT, companyName);
  const companySkillDirs = readdirSync(skillsDir, { withFileTypes: true })
    .filter(e => e.isDirectory())
    .map(e => e.name);

  console.log(`\n=== ${companyName} (${companySkillDirs.length} skills) ===`);

  for (const skillDir of companySkillDirs) {
    const skillPath = join(skillsDir, skillDir, 'SKILL.md');
    try {
      const content = readFileSync(skillPath, 'utf8');
      const nameMatch = content.match(/^name:\s*(.+)$/m);
      const descMatch = content.match(/^description:\s*(.+)$/m);
      
      const name = nameMatch ? nameMatch[1].trim() : skillDir;
      const description = descMatch ? descMatch[1].trim() : '';

      // Check if key already exists
      const { data: existing } = await supabase
        .from('company_skills')
        .select('id')
        .eq('key', skillDir)
        .limit(1);

      let result;
      if (existing && existing.length > 0) {
        result = await supabase
          .from('company_skills')
          .update({
            slug: skillDir,
            name,
            description,
            markdown: content,
            source_type: 'local_path',
            source_locator: `${companyName}/${skillDir}/SKILL.md`,
            company_id: companyId,
          })
          .eq('key', skillDir);
      } else {
        result = await supabase
          .from('company_skills')
          .insert({
            key: skillDir,
            slug: skillDir,
            name,
            description,
            markdown: content,
            source_type: 'local_path',
            source_locator: `${companyName}/${skillDir}/SKILL.md`,
            company_id: companyId,
          });
      }

      if (result.error) {
        console.log(`  ✗ ${skillDir}: ${result.error.message}`);
      } else {
        console.log(`  ✓ ${skillDir}`);
      }
    } catch (err) {
      console.log(`  ✗ ${skillDir}: Missing SKILL.md`);
    }
  }
}

async function main() {
  console.log('=== Fix Company Skills ===\n');
  
  // Phase 1: Delete wrong skills
  await deleteWrongSkills();

  // Phase 2: Load correct skills per company
  for (const [companyKey, companyId] of Object.entries(COMPANY_IDS)) {
    await loadCompanySkillsFromDirectory(companyKey, companyId);
  }
}

main().catch(err => {
  console.error('Fatal:', err);
  process.exit(1);
});
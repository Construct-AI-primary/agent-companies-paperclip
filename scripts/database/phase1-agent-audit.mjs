#!/usr/bin/env node
/**
 * Phase 1: Database Audit & Cleanup
 * Date: 2026-04-22
 * Purpose: Identify duplicate agents, missing agents, and naming issues
 * Companies: PaperclipForge AI + MeasureForge AI
 */

import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';

config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing required environment variables:');
  console.error('   SUPABASE_URL:', SUPABASE_URL ? '✅ Set' : '❌ Missing');
  console.error('   SUPABASE_SERVICE_ROLE_KEY:', SUPABASE_SERVICE_ROLE_KEY ? '✅ Set' : '❌ Missing');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false }
});

async function runAudit() {
  console.log('\n' + '='.repeat(70));
  console.log('PHASE 1: DATABASE AUDIT & CLEANUP');
  console.log('Date: 2026-04-22');
  console.log('='.repeat(70) + '\n');

  // STEP 1: Check company existence
  console.log('=== COMPANY EXISTENCE CHECK ===');
  const { data: companies, error: compError } = await supabase
    .from('companies')
    .select('id, name, created_at')
    .in('name', ['PaperclipForge AI', 'MeasureForge AI'])
    .order('name');
  
  if (compError) { console.error('❌ Error:', compError.message); }
  else { console.log(`Found ${companies.length} companies:`, companies.map(c => `${c.name} (${c.id})`).join(', ')); }
  
  const paperclipForgeId = companies?.find(c => c.name === 'PaperclipForge AI')?.id;
  const measureForgeId = companies?.find(c => c.name === 'MeasureForge AI')?.id;

  // STEP 2: Count agents per company
  console.log('\n=== AGENT COUNTS PER COMPANY ===');
  const { data: allCompanies, error: allCompError } = await supabase
    .from('companies')
    .select('name, agents(count)')
    .order('name');
  
  if (allCompError) { console.error('❌ Error:', allCompError.message); }
  else {
    for (const c of (allCompanies || [])) {
      console.log(`  ${c.name}: ${c.agents?.[0]?.count || 0} agents`);
    }
  }

  // STEP 3: Find duplicate agent names (same name + same company)
  console.log('\n=== DUPLICATE AGENT NAMES (same name + same company) ===');
  const { data: allAgents, error: agentsError } = await supabase
    .from('agents')
    .select('id, name, company_id, role, title, status, created_at, updated_at')
    .order('name');
  
  if (agentsError) { console.error('❌ Error:', agentsError.message); }
  else {
    const nameCompanyMap = {};
    for (const a of (allAgents || [])) {
      const key = `${a.name}|||${a.company_id}`;
      if (!nameCompanyMap[key]) nameCompanyMap[key] = [];
      nameCompanyMap[key].push(a);
    }
    
    const duplicates = Object.entries(nameCompanyMap).filter(([_, v]) => v.length > 1);
    if (duplicates.length === 0) {
      console.log('  ✅ No duplicate agent names found within same company.');
    } else {
      for (const [key, agents] of duplicates) {
        const [name, companyId] = key.split('|||');
        console.log(`  🔴 DUPLICATE: "${name}" in company ${companyId} (${agents.length} copies):`);
        for (const a of agents) {
          console.log(`     - ${a.id} | ${a.title || 'no title'} | created: ${a.created_at}`);
        }
      }
    }
  }

  // STEP 4: Find cross-company name conflicts
  console.log('\n=== CROSS-COMPANY NAME CONFLICTS ===');
  if (allAgents && !agentsError) {
    const nameMap = {};
    for (const a of allAgents) {
      if (!nameMap[a.name]) nameMap[a.name] = new Set();
      nameMap[a.name].add(a.company_id);
    }
    
    const conflicts = Object.entries(nameMap).filter(([_, companies]) => companies.size > 1);
    if (conflicts.length === 0) {
      console.log('  ✅ No cross-company name conflicts found.');
    } else {
      for (const [name, companyIds] of conflicts) {
        console.log(`  🔴 CONFLICT: "${name}" used in ${companyIds.size} companies: ${[...companyIds].join(', ')}`);
      }
    }
  }

  // STEP 5: List PaperclipForge AI agents
  console.log('\n=== PAPERCLIPFORGE AI - ALL AGENTS ===');
  if (paperclipForgeId) {
    const pfAgents = (allAgents || []).filter(a => a.company_id === paperclipForgeId);
    console.log(`  Found ${pfAgents.length} agents:`);
    for (const a of pfAgents) {
      console.log(`  - ${a.name} | ${a.role} | ${a.title || 'no title'} | ${a.status}`);
    }
  } else {
    console.log('  ❌ PaperclipForge AI company not found!');
  }

  // STEP 6: List MeasureForge AI agents
  console.log('\n=== MEASUREFORGE AI - ALL AGENTS ===');
  if (measureForgeId) {
    const mfAgents = (allAgents || []).filter(a => a.company_id === measureForgeId);
    console.log(`  Found ${mfAgents.length} agents:`);
    for (const a of mfAgents) {
      console.log(`  - ${a.name} | ${a.role} | ${a.title || 'no title'} | ${a.status}`);
    }
  } else {
    console.log('  ❌ MeasureForge AI company not found!');
  }

  // STEP 7: Find agents with non-standard names
  console.log('\n=== AGENTS WITH NON-STANDARD NAMES (technical slugs) ===');
  if (allAgents && !agentsError) {
    const targetCompanyIds = [paperclipForgeId, measureForgeId].filter(Boolean);
    const nonStandard = (allAgents || []).filter(a => 
      targetCompanyIds.includes(a.company_id) &&
      (a.name.includes('-ai-') || a.name.startsWith('the-') || a.name.endsWith('-specialist') || a.name.endsWith('-coordinator'))
    );
    console.log(`  Found ${nonStandard.length} agents with non-standard names:`);
    for (const a of nonStandard.slice(0, 20)) {
      const companyName = a.company_id === paperclipForgeId ? 'PaperclipForge' : a.company_id === measureForgeId ? 'MeasureForge' : a.company_id;
      console.log(`  - ${a.name} (${companyName}) | ${a.title || 'no title'}`);
    }
    if (nonStandard.length > 20) {
      console.log(`  ... and ${nonStandard.length - 20} more`);
    }
  }

  // STEP 8: Find agents with empty/null names
  console.log('\n=== AGENTS WITH EMPTY/NULL NAMES ===');
  const { data: nullNameAgents, error: nullError } = await supabase
    .from('agents')
    .select('id, name, title, company_id')
    .or('name.is.null,name.eq.');
  
  if (nullError) { console.error('❌ Error:', nullError.message); }
  else if (!nullNameAgents || nullNameAgents.length === 0) {
    console.log('  ✅ No agents with empty/null names.');
  } else {
    console.log(`  🔴 Found ${nullNameAgents.length} agents with empty/null names:`);
    for (const a of nullNameAgents) {
      console.log(`  - ${a.id} | company: ${a.company_id} | title: ${a.title || 'none'}`);
    }
  }

  // SUMMARY
  console.log('\n' + '='.repeat(70));
  console.log('AUDIT SUMMARY');
  console.log('='.repeat(70));
  console.log(`PaperclipForge AI agents: ${(allAgents || []).filter(a => a.company_id === paperclipForgeId).length}`);
  console.log(`MeasureForge AI agents: ${(allAgents || []).filter(a => a.company_id === measureForgeId).length}`);
  console.log(`Total agents in database: ${allAgents?.length || 0}`);
  console.log(`Duplicate names (same company): ${Object.entries(
    (allAgents || []).reduce((map, a) => {
      const key = `${a.name}|||${a.company_id}`;
      map[key] = (map[key] || 0) + 1;
      return map;
    }, {})
  ).filter(([_, count]) => count > 1).length}`);
  console.log(`Cross-company name conflicts: ${Object.entries(
    (allAgents || []).reduce((map, a) => {
      if (!map[a.name]) map[a.name] = new Set();
      map[a.name].add(a.company_id);
      return map;
    }, {})
  ).filter(([_, companies]) => companies.size > 1).length}`);
  console.log('\n✅ Phase 1 Audit Complete');
}

runAudit().catch(err => {
  console.error('❌ Fatal error:', err.message);
  process.exit(1);
});
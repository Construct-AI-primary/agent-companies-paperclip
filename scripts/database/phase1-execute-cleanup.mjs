#!/usr/bin/env node
/**
 * Phase 1: Execute Duplicate Agent Cleanup
 * Date: 2026-04-22
 * Deletes 11 duplicate agent entries from PaperclipForge AI and MeasureForge AI
 */

import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';

config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error('❌ Missing required environment variables');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false }
});

// Agent IDs to delete (duplicates)
const agentsToDelete = [
  // PaperclipForge AI duplicates
  { id: '16f59f76-9b06-4755-b95c-cebeee4fa2ac', name: 'paperclipforge-ai-operations-director', reason: 'duplicate (keep oldest d8475f0a)' },
  { id: '91b48330-2893-49ee-9234-ba6b82da0327', name: 'paperclipforge-ai-operations-director', reason: 'duplicate (keep oldest d8475f0a)' },
  { id: '8fe456ca-f377-428e-98fd-0fe0ce7a5273', name: 'paperclipforge-ai-agent-monitor', reason: 'duplicate (keep 66a58395)' },
  { id: '0d0fe63a-2ea7-468e-9592-e2b14a6311b5', name: 'paperclipforge-ai-coordination-hub', reason: 'duplicate (keep 4c61fbb6)' },
  { id: '42ef2223-e374-4cf0-9e2a-adade7c1f98f', name: 'paperclipforge-ai-issue-importer', reason: 'duplicate (keep 01860905)' },
  { id: 'e37b4e2b-ae8a-4a51-a314-25c6c6b8556f', name: 'paperclipforge-ai-orchestration-engine', reason: 'duplicate (keep eb92c0ad)' },
  { id: '8d6f2dcb-b4e8-4f51-84ac-e482d17a408f', name: 'paperclipforge-ai-system-integrator', reason: 'duplicate (keep dcc0fcc3)' },
  { id: '96516200-ac70-4ea1-80a3-971bd791311a', name: 'paperclipforge-ai-task-allocator', reason: 'duplicate (keep 1a9f4f0e)' },
  { id: '3fb1015d-a337-4335-bd06-4058455a4f52', name: 'paperclipforge-ai-workflow-orchestrator', reason: 'duplicate (keep 35196fb6)' },
  // MeasureForge AI duplicates
  { id: 'c076d300-b4a6-4540-8c81-161298c308b0', name: 'advanced-engineering-analysis', reason: 'duplicate (keep 1462606d)' },
  { id: '55f83928-c78e-4e28-8b11-5d7c40fe256f', name: 'cross-discipline-coordination', reason: 'duplicate (keep 4c63c5d3)' },
  { id: '04bdc189-5a79-426b-91fd-dd8e9cc54c76', name: 'engineering-ui-specialist', reason: 'duplicate (keep 02f70a2c)' },
];

async function executeCleanup() {
  console.log('\n' + '='.repeat(70));
  console.log('PHASE 1: EXECUTING DUPLICATE AGENT CLEANUP');
  console.log('Date: 2026-04-22');
  console.log('='.repeat(70) + '\n');
  
  console.log(`📋 Planning to delete ${agentsToDelete.length} duplicate agents:\n`);
  for (const agent of agentsToDelete) {
    console.log(`  - ${agent.name} (${agent.id})`);
    console.log(`    Reason: ${agent.reason}`);
  }
  
  console.log('\n⚠️  Starting deletion process...\n');
  
  let deletedCount = 0;
  let errorCount = 0;
  
  for (const agent of agentsToDelete) {
    process.stdout.write(`  Deleting ${agent.name}... `);
    
    const { error } = await supabase
      .from('agents')
      .delete()
      .eq('id', agent.id);
    
    if (error) {
      console.log(`❌ FAILED: ${error.message}`);
      errorCount++;
    } else {
      console.log('✅ Deleted');
      deletedCount++;
    }
  }
  
  console.log('\n' + '='.repeat(70));
  console.log('CLEANUP SUMMARY');
  console.log('='.repeat(70));
  console.log(`  Total attempted: ${agentsToDelete.length}`);
  console.log(`  Successfully deleted: ${deletedCount}`);
  console.log(`  Errors: ${errorCount}`);
  
  if (errorCount === 0) {
    console.log('\n✅ Phase 1 Cleanup Complete - All duplicates removed successfully');
  } else {
    console.log(`\n⚠️  Phase 1 Cleanup Complete with ${errorCount} errors`);
  }
}

executeCleanup().catch(err => {
  console.error('❌ Fatal error:', err.message);
  process.exit(1);
});
#!/usr/bin/env node
/**
 * Phase 1: Execute Duplicate Agent Cleanup (with API key handling)
 * Date: 2026-04-22
 * Deletes API keys first, then duplicate agents
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

// Agent IDs that failed due to API key constraints
const agentsWithApiKeys = [
  { id: '8fe456ca-f377-428e-98fd-0fe0ce7a5273', name: 'paperclipforge-ai-agent-monitor' },
  { id: '0d0fe63a-2ea7-468e-9592-e2b14a6311b5', name: 'paperclipforge-ai-coordination-hub' },
  { id: '42ef2223-e374-4cf0-9e2a-adade7c1f98f', name: 'paperclipforge-ai-issue-importer' },
  { id: 'e37b4e2b-ae8a-4a51-a314-25c6c6b8556f', name: 'paperclipforge-ai-orchestration-engine' },
  { id: '8d6f2dcb-b4e8-4f51-84ac-e482d17a408f', name: 'paperclipforge-ai-system-integrator' },
  { id: '96516200-ac70-4ea1-80a3-971bd791311a', name: 'paperclipforge-ai-task-allocator' },
  { id: '3fb1015d-a337-4335-bd06-4058455a4f52', name: 'paperclipforge-ai-workflow-orchestrator' },
];

async function cleanupWithApiKeys() {
  console.log('\n' + '='.repeat(70));
  console.log('PHASE 1: CLEANUP WITH API KEY HANDLING');
  console.log('Date: 2026-04-22');
  console.log('='.repeat(70) + '\n');
  
  let totalDeleted = 0;
  let totalErrors = 0;
  
  for (const agent of agentsWithApiKeys) {
    console.log(`\nProcessing: ${agent.name} (${agent.id})`);
    
    // Step 1: Delete associated API keys
    process.stdout.write('  Deleting API keys... ');
    const { error: keyError } = await supabase
      .from('agent_api_keys')
      .delete()
      .eq('agent_id', agent.id);
    
    if (keyError) {
      console.log(`⚠️  ${keyError.message}`);
    } else {
      console.log('✅ API keys deleted');
    }
    
    // Step 2: Delete the agent
    process.stdout.write('  Deleting agent... ');
    const { error: agentError } = await supabase
      .from('agents')
      .delete()
      .eq('id', agent.id);
    
    if (agentError) {
      console.log(`❌ FAILED: ${agentError.message}`);
      totalErrors++;
    } else {
      console.log('✅ Agent deleted');
      totalDeleted++;
    }
  }
  
  console.log('\n' + '='.repeat(70));
  console.log('CLEANUP SUMMARY');
  console.log('='.repeat(70));
  console.log(`  Agents processed: ${agentsWithApiKeys.length}`);
  console.log(`  Successfully deleted: ${totalDeleted}`);
  console.log(`  Errors: ${totalErrors}`);
  
  if (totalErrors === 0) {
    console.log('\n✅ Phase 1 Cleanup Complete - All remaining duplicates removed');
  } else {
    console.log(`\n⚠️  Phase 1 Cleanup Complete with ${totalErrors} errors`);
  }
}

cleanupWithApiKeys().catch(err => {
  console.error('❌ Fatal error:', err.message);
  process.exit(1);
});
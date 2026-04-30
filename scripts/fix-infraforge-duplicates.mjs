#!/usr/bin/env node
/**
 * Nimbus Supabase Specialist - Fix InfraForge AI Duplicate Agents
 * Removes duplicate Atlas Sync entries and regenerates placeholder UUIDs
 */

import { config } from 'dotenv';
config();

const SUPABASE_URL = 'https://gmorarhibiptvcrnvrpi.supabase.co';
const SUPABASE_SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ';

const headers = {
  'Content-Type': 'application/json',
  'apikey': SUPABASE_SERVICE_ROLE_KEY,
  'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
  'Prefer': 'return=minimal'
};

async function getCompanyId() {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/companies?name=eq.InfraForge AI&status=eq.active&select=id`, {
    headers
  });
  const data = await response.json();
  return data[0]?.id;
}

async function getAgentsByCompany(companyId) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/agents?company_id=eq.${companyId}&select=id,name,role,title,metadata`, {
    headers: { ...headers, 'Prefer': 'return=representation' }
  });
  return response.json();
}

async function deleteAgent(agentId) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/agents?id=eq.${agentId}`, {
    method: 'DELETE',
    headers
  });
  return response.ok;
}

async function updateAgent(agentId, updates) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/agents?id=eq.${agentId}`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify(updates)
  });
  return response.ok;
}

async function main() {
  console.log('\n🔧 Nimbus Supabase Specialist - Fix InfraForge AI Duplicates\n');
  console.log('='.repeat(60));

  try {
    const companyId = await getCompanyId();
    if (!companyId) {
      console.error('❌ InfraForge AI company not found');
      process.exit(1);
    }

    const agents = await getAgentsByCompany(companyId);

    // Step 1: Fix duplicate Atlas Sync entries
    console.log('\n📋 Step 1: Fixing duplicate "Atlas Sync" entries...\n');
    
    const atlasSyncAgents = agents.filter(a => a.name === 'Atlas Sync');
    console.log(`   Found ${atlasSyncAgents.length} "Atlas Sync" entries`);
    
    if (atlasSyncAgents.length > 1) {
      // Keep the first one, delete the rest
      for (let i = 1; i < atlasSyncAgents.length; i++) {
        console.log(`   Deleting duplicate #${i+1} (ID: ${atlasSyncAgents[i].id})...`);
        const success = await deleteAgent(atlasSyncAgents[i].id);
        if (success) {
          console.log(`   ✅ Deleted successfully`);
        } else {
          console.log(`   ⚠️  Failed to delete`);
        }
      }
    }

    // Step 2: Fix placeholder UUIDs
    console.log('\n📋 Step 2: Regenerating placeholder UUIDs...\n');
    
    const placeholderAgents = agents.filter(a => 
      a.id.includes('000000000015') || a.id.includes('000000000016')
    );
    
    for (const agent of placeholderAgents) {
      console.log(`   Regenerating UUID for "${agent.name}"...`);
      const newUuid = crypto.randomUUID();
      const success = await updateAgent(agent.id, { id: newUuid });
      if (success) {
        console.log(`   ✅ New UUID: ${newUuid}`);
      } else {
        console.log(`   ⚠️  Failed to update UUID`);
      }
    }

    // Final verification
    console.log('\n📋 Step 3: Final verification...\n');
    const finalAgents = await getAgentsByCompany(companyId);
    
    console.log(`   Total agents: ${finalAgents.length}`);
    finalAgents.forEach(a => {
      console.log(`   - ${a.name} (${a.role}) - ${a.title}`);
    });

    console.log('\n' + '='.repeat(60));
    console.log('✅ Duplicate fix complete!');

  } catch (error) {
    console.error('\n❌ Error:', error.message);
    process.exit(1);
  }
}

main();

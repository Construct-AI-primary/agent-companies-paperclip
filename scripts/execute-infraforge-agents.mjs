#!/usr/bin/env node
/**
 * Nimbus Supabase Specialist - InfraForge AI Agent Reconciliation
 * Fixes naming inconsistencies and placeholder UUIDs
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

// Agents to rename to standardized names
const renameMap = [
  { currentName: 'Link', newName: 'API Integration Specialist', title: 'API Integration Specialist', agent_slug: 'infraforge-ai-api-integration-specialist' },
  { currentName: 'Sync', newName: 'Data Synchronization Manager', title: 'Data Synchronization Manager', agent_slug: 'infraforge-ai-data-synchronization-manager' },
  { currentName: 'Turbo', newName: 'Performance Optimization Specialist', title: 'Performance Optimization Specialist', agent_slug: 'infraforge-ai-performance-optimization-specialist' },
  { currentName: 'Guardian', newName: 'Security and Compliance Monitor', title: 'Security and Compliance Monitor', agent_slug: 'infraforge-ai-security-compliance-monitor' }
];

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

async function updateAgent(agentId, updates) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/agents?id=eq.${agentId}`, {
    method: 'PATCH',
    headers,
    body: JSON.stringify(updates)
  });
  return response.ok;
}

async function deleteAgent(agentId) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/agents?id=eq.${agentId}`, {
    method: 'DELETE',
    headers
  });
  return response.ok;
}

async function main() {
  console.log('\n🔧 Nimbus Supabase Specialist - InfraForge AI Agent Reconciliation\n');
  console.log('='.repeat(60));

  try {
    // Get company ID
    console.log('\n📋 Step 1: Getting InfraForge AI company ID...');
    const companyId = await getCompanyId();
    if (!companyId) {
      console.error('❌ InfraForge AI company not found in database');
      process.exit(1);
    }
    console.log(`   ✅ Company ID: ${companyId}`);

    // Get current agents
    console.log('\n📋 Step 2: Analyzing current agent state...');
    const agents = await getAgentsByCompany(companyId);
    console.log(`   Found ${agents.length} agents in database\n`);

    // Show current state
    console.log('   Current agents:');
    agents.forEach(a => {
      console.log(`   - ${a.name} (${a.role}) - ${a.title}`);
    });

    // Step 3: Rename agents to standardized names
    console.log('\n📋 Step 3: Renaming agents to standardized names...\n');
    
    for (const rename of renameMap) {
      const agent = agents.find(a => a.name === rename.currentName);
      if (agent) {
        console.log(`   Renaming "${rename.currentName}" → "${rename.newName}"...`);
        const success = await updateAgent(agent.id, {
          name: rename.newName,
          title: rename.title,
          metadata: { ...agent.metadata, agent_slug: rename.agent_slug }
        });
        if (success) {
          console.log(`   ✅ Renamed successfully`);
        } else {
          console.log(`   ⚠️  Failed to rename`);
        }
      } else {
        console.log(`   ⏭️  "${rename.currentName}" not found, skipping`);
      }
    }

    // Step 4: Fix placeholder UUIDs
    console.log('\n📋 Step 4: Identifying placeholder UUIDs...\n');
    
    const placeholderAgents = agents.filter(a => 
      a.id.includes('000000000015') || a.id.includes('000000000016')
    );
    
    if (placeholderAgents.length > 0) {
      console.log('   Found agents with placeholder UUIDs:');
      placeholderAgents.forEach(a => {
        console.log(`   - ${a.name} (${a.title}) - ID: ${a.id}`);
      });
      console.log('\n   ⚠️  These need manual UUID regeneration via Supabase SQL Editor');
    } else {
      console.log('   ✅ No placeholder UUIDs found');
    }

    // Step 5: Identify duplicates
    console.log('\n📋 Step 5: Checking for duplicate agents...\n');
    
    const nameCounts = {};
    agents.forEach(a => {
      nameCounts[a.name] = (nameCounts[a.name] || 0) + 1;
    });
    
    const duplicates = Object.entries(nameCounts).filter(([_, count]) => count > 1);
    if (duplicates.length > 0) {
      console.log('   Found duplicate names:');
      duplicates.forEach(([name, count]) => {
        console.log(`   - "${name}" appears ${count} times`);
      });
    } else {
      console.log('   ✅ No duplicate names found');
    }

    // Final verification
    console.log('\n📋 Step 6: Final verification...\n');
    const finalAgents = await getAgentsByCompany(companyId);
    
    console.log('   Final agent list:');
    finalAgents.forEach(a => {
      console.log(`   - ${a.name} (${a.role}) - ${a.title}`);
    });

    console.log('\n' + '='.repeat(60));
    console.log('✅ InfraForge AI agent reconciliation complete!');
    console.log('\n📝 Remaining tasks:');
    console.log('   1. Fix placeholder UUIDs via Supabase SQL Editor');
    console.log('   2. Update COMPANY.md with all 13 agents');
    console.log('   3. Update TEAM.md with all 13 agents');
    console.log('   4. Update Paperclip_Teams_Cross_Reference.md');

  } catch (error) {
    console.error('\n❌ Error:', error.message);
    process.exit(1);
  }
}

main();

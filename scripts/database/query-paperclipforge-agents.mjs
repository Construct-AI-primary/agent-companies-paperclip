#!/usr/bin/env node
// Query PaperclipForge AI agents from Supabase database
import { config } from 'dotenv';

config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

async function queryDatabase(endpoint, params = '') {
  const url = `${SUPABASE_URL}/rest/v1/${endpoint}${params ? '?' + params : ''}`;
  const response = await fetch(url, {
    headers: {
      'apikey': SUPABASE_SERVICE_ROLE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
      'Content-Type': 'application/json'
    }
  });
  
  if (!response.ok) {
    const text = await response.text();
    throw new Error(`HTTP ${response.status}: ${text}`);
  }
  
  return response.json();
}

async function queryWithRpc(sql) {
  // Use the Supabase SQL RPC if available, otherwise use pg_dump format
  const response = await fetch(`${SUPABASE_URL}/rest/v1/rpc/exec_sql`, {
    method: 'POST',
    headers: {
      'apikey': SUPABASE_SERVICE_ROLE_KEY,
      'Authorization': `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
      'Content-Type': 'application/json',
      'Prefer': 'return=representation'
    },
    body: JSON.stringify({ sql_query: sql })
  });
  
  if (!response.ok) {
    return null;
  }
  
  return response.json();
}

async function main() {
  console.log('=== PaperclipForge AI Agent Database Query ===\n');
  
  try {
    // 1. Get PaperclipForge AI company ID
    console.log('1. Getting PaperclipForge AI company info...');
    const companies = await queryDatabase('companies', 'name=eq.PaperclipForge%20AI&select=id,name,is_active');
    const pfCompany = companies[0];
    
    if (!pfCompany) {
      console.log('ERROR: PaperclipForge AI company not found!');
      return;
    }
    
    console.log(`   Company: ${pfCompany.name}`);
    console.log(`   ID: ${pfCompany.id}`);
    console.log(`   Active: ${pfCompany.is_active}\n`);
    
    // 2. Query agents table for PaperclipForge AI
    console.log('2. Querying agents table for PaperclipForge AI...');
    const agents = await queryDatabase('agents', `company_id=eq.${pfCompany.id}&select=id,name,role,title,status,adapter_type,is_active,reports_to,created_at,updated_at`);
    
    console.log(`   Found ${agents.length} agents in database\n`);
    
    // 3. Query agent_models table (note: agent_id is VARCHAR with agent name/slug, not UUID)
    console.log('3. Querying agent_models table...');
    let agentModels = [];
    
    for (const agent of agents) {
      const models = await queryDatabase('agent_models', `agent_id=eq.${agent.name}&select=id,agent_id,model_id,assignment_type,priority,is_active`);
      agentModels.push(...models);
    }
    
    console.log(`   Found ${agentModels.length} model assignments\n`);
    
    // 4. Query agent_api_keys table (just count to avoid exposing keys)
    console.log('4. Querying agent_api_keys table...');
    let apiKeyCounts = {};
    for (const agent of agents) {
      const keys = await queryDatabase('agent_api_keys', `agent_id=eq.${agent.id}&select=id&limit=5`);
      apiKeyCounts[agent.id] = keys.length;
    }
    
    const totalApiKeys = Object.values(apiKeyCounts).reduce((sum, count) => sum + count, 0);
    console.log(`   Found ${totalApiKeys} total API keys\n`);
    
    // 5. Output results
    console.log('\n=== DATABASE STATE FOR PAPERCLIPFORGE AI ===\n');
    
    console.log('| # | Agent Name | ID | Active | Adapter | Models | Keys |');
    console.log('|---|------------|----|--------|---------|-------|------|');
    
    agents.forEach((agent, index) => {
      const models = agentModels.filter(m => m.agent_id === agent.name);
      const keys = apiKeyCounts[agent.id] || 0;
      console.log(`| ${index + 1} | ${agent.name} | ${agent.id.substring(0, 8)}... | ${agent.is_active ? '✅' : '❌'} | ${agent.adapter_type || 'N/A'} | ${models.length} | ${keys} |`);
    });
    
    // 5b. Show model details
    console.log('\n=== MODEL ASSIGNMENTS ===\n');
    console.log('| Agent | Model ID | Assignment Type | Priority | Active |');
    console.log('|-------|----------|----------------|----------|--------|');
    
    agentModels.forEach(m => {
      console.log(`| ${m.agent_id} | ${m.model_id || 'N/A'} | ${m.assignment_type} | ${m.priority || 1} | ${m.is_active ? '✅' : '❌'} |`);
    });
    
    // 6. Summary stats
    console.log('\n=== SUMMARY ===\n');
    console.log(`Total agents: ${agents.length}`);
    console.log(`Active agents: ${agents.filter(a => a.is_active).length}`);
    console.log(`With models: ${agentModels.length} assignments`);
    console.log(`Total API keys: ${totalApiKeys}`);
    
    // 7. Output JSON for reconciliation
    const output = {
      company: pfCompany,
      agents: agents,
      agentModels: agentModels,
      timestamp: new Date().toISOString()
    };
    
    console.log('\n=== JSON OUTPUT ===\n');
    console.log(JSON.stringify(output, null, 2));
    
  } catch (error) {
    console.error('Error:', error.message);
  }
}

main();
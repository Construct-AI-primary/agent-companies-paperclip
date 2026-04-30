#!/usr/bin/env node

/**
 * Cleanup script to remove old safety research agents with functional names
 * Keeps only the new agents with unique human names
 */

import { createClient } from '@supabase/supabase-js';
import { config } from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load environment variables from .env file
config({ path: join(__dirname, '../../.env') });

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing required environment variables:');
  console.error('   SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be set');
  process.exit(1);
}

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function cleanupOldAgents() {
  console.log('Cleaning up old safety research agents with functional names...');
  console.log('================================================================\n');

  // Get Learning Forge AI company ID
  const { data: company, error: companyError } = await supabase
    .from('companies')
    .select('id, name')
    .eq('name', 'Learning Forge AI')
    .single();

  if (companyError) {
    console.error(`❌ Error finding company: ${companyError.message}`);
    process.exit(1);
  }

  console.log(`Found company: ${company.name} (${company.id})`);

  // Define old agent names to remove (functional names)
  const oldAgentNames = [
    'learningforge-ai-research-coordinator',
    'learningforge-ai-safety-research-agent',
    'learningforge-ai-mobile-patterns-agent',
    'learningforge-ai-domain-knowledge-agent',
    'learningforge-ai-learning-integration-agent'
  ];

  console.log('Removing old agents with functional names:');
  console.log('==========================================');

  // First, update any agents that report to the old research coordinator
  // to report to the new Jax agent instead
  const { data: newJax, error: jaxError } = await supabase
    .from('agents')
    .select('id, name')
    .eq('company_id', company.id)
    .eq('name', 'Jax')
    .single();

  if (jaxError) {
    console.error(`❌ Error finding new Jax agent: ${jaxError.message}`);
    process.exit(1);
  }

  // Get the old coordinator's ID
  const { data: oldCoordinator, error: oldCoordError } = await supabase
    .from('agents')
    .select('id, name')
    .eq('company_id', company.id)
    .eq('name', 'learningforge-ai-research-coordinator')
    .single();

  if (oldCoordError && oldCoordError.code !== 'PGRST116') {
    console.error(`❌ Error finding old coordinator: ${oldCoordError.message}`);
  } else if (oldCoordinator) {
    // Update reporting relationships from old coordinator to new Jax
    const { error: updateReportsError } = await supabase
      .from('agents')
      .update({ reports_to: newJax.id })
      .eq('company_id', company.id)
      .eq('reports_to', oldCoordinator.id);

    if (updateReportsError) {
      console.error(`❌ Error updating reporting relationships: ${updateReportsError.message}`);
    } else {
      console.log(`   ✅ Updated reporting relationships to point to new Jax agent`);
    }
  }

  for (const agentName of oldAgentNames) {
    // Check if agent exists
    const { data: existingAgent, error: checkError } = await supabase
      .from('agents')
      .select('id, name')
      .eq('company_id', company.id)
      .eq('name', agentName)
      .single();

    if (checkError && checkError.code === 'PGRST116') {
      console.log(`   Agent ${agentName} not found (already removed)`);
      continue;
    }

    if (checkError) {
      console.error(`❌ Error checking agent ${agentName}: ${checkError.message}`);
      continue;
    }

    // Delete agent models first (foreign key constraint)
    const { error: modelsDeleteError } = await supabase
      .from('agent_models')
      .delete()
      .eq('agent_id', existingAgent.id);

    if (modelsDeleteError) {
      console.error(`❌ Error deleting models for ${agentName}: ${modelsDeleteError.message}`);
      continue;
    }

    // Delete the agent
    const { error: deleteError } = await supabase
      .from('agents')
      .delete()
      .eq('id', existingAgent.id);

    if (deleteError) {
      console.error(`❌ Error deleting agent ${agentName}: ${deleteError.message}`);
    } else {
      console.log(`   ✅ Removed old agent: ${agentName}`);
    }
  }

  console.log('\nVerifying cleanup...');
  console.log('===================');

  // Get remaining safety research agents
  const { data: remainingAgents, error: verifyError } = await supabase
    .from('agents')
    .select('id, name, title')
    .eq('company_id', company.id)
    .eq('metadata->>team', 'safety-research')
    .order('name');

  if (verifyError) {
    console.error(`❌ Error verifying cleanup: ${verifyError.message}`);
    process.exit(1);
  }

  console.log(`Remaining safety research agents: ${remainingAgents.length}`);
  remainingAgents.forEach(agent => {
    console.log(`  ✅ ${agent.name}: ${agent.title}`);
  });

  // Check that we have exactly 5 agents with human names
  const humanNames = ['Jax', 'Nova', 'Phoenix', 'Sage', 'Echo'];
  const remainingNames = remainingAgents.map(a => a.name).sort();
  const expectedNames = humanNames.sort();

  const hasCorrectAgents = remainingNames.length === 5 &&
    remainingNames.every((name, index) => name === expectedNames[index]);

  if (hasCorrectAgents) {
    console.log('\n✅ Cleanup successful! Only human-named agents remain.');
  } else {
    console.error('\n❌ Cleanup verification failed!');
    console.error('Expected:', expectedNames);
    console.error('Found:', remainingNames);
    process.exit(1);
  }
}

async function main() {
  // Test connection
  console.log('Testing database connection...');
  try {
    const { data, error } = await supabase.from('companies').select('count').limit(1);
    if (error) throw error;
    console.log('✅ Database connection successful\n');
  } catch (error) {
    console.error(`❌ Database connection failed: ${error.message}`);
    process.exit(1);
  }

  await cleanupOldAgents();
}

main().catch(error => {
  console.error(`\n❌ Unexpected error: ${error.message}`);
  process.exit(1);
});
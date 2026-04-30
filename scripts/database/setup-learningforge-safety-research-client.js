#!/usr/bin/env node

/**
 * Node.js script to set up Learning Forge AI Safety Research Team
 * Uses Supabase client for database operations (works with our credentials)
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

async function ensureCompanyExists() {
  console.log('1. Ensuring Learning Forge AI company exists...');

  // Check if company exists
  const { data: existingCompany, error: checkError } = await supabase
    .from('companies')
    .select('id, name')
    .eq('name', 'Learning Forge AI')
    .single();

  if (checkError && checkError.code !== 'PGRST116') { // PGRST116 = not found
    console.error(`❌ Error checking company: ${checkError.message}`);
    return null;
  }

  if (existingCompany) {
    console.log(`✅ Company exists: ${existingCompany.name}`);
    return existingCompany.id;
  }

  // Company doesn't exist, create it
  const { data: newCompany, error: createError } = await supabase
    .from('companies')
    .insert({
      name: 'Learning Forge AI',
      issue_prefix: 'LFA',
      status: 'active',
      brand_color: '#4A90E2'
    })
    .select('id, name')
    .single();

  if (createError) {
    console.error(`❌ Error creating company: ${createError.message}`);
    return null;
  }

  console.log(`✅ Company created: ${newCompany.name}`);
  return newCompany.id;
}

async function createAgentIfNotExists(companyId, agentData) {
  // Check if agent exists
  const { data: existingAgent, error: checkError } = await supabase
    .from('agents')
    .select('id, name')
    .eq('company_id', companyId)
    .eq('name', agentData.name)
    .single();

  if (checkError && checkError.code !== 'PGRST116') { // PGRST116 = not found
    console.error(`❌ Error checking agent ${agentData.name}: ${checkError.message}`);
    return null;
  }

  if (existingAgent) {
    console.log(`   Agent already exists: ${agentData.name}`);
    return existingAgent.id;
  }

  // Create agent
  const { data: newAgent, error: createError } = await supabase
    .from('agents')
    .insert({
      company_id: companyId,
      name: agentData.name,
      role: agentData.role,
      title: agentData.title,
      capabilities: agentData.capabilities,
      status: 'active',
      metadata: agentData.metadata
    })
    .select('id, name')
    .single();

  if (createError) {
    console.error(`❌ Error creating agent ${agentData.name}: ${createError.message}`);
    return null;
  }

  console.log(`   ✅ Created agent: ${newAgent.name}`);
  return newAgent.id;
}

async function updateReportingRelationships(companyId) {
  console.log('3. Updating reporting relationships...');

  // Get Research Coordinator ID
  const { data: coordinator, error: coordError } = await supabase
    .from('agents')
    .select('id, name')
    .eq('company_id', companyId)
    .eq('name', 'Jax')
    .single();

  if (coordError) {
    console.error(`❌ Error finding Research Coordinator: ${coordError.message}`);
    return false;
  }

  // Get CEO ID
  const { data: ceo, error: ceoError } = await supabase
    .from('agents')
    .select('id, name')
    .eq('company_id', companyId)
    .eq('name', 'learningforge-ai-ceo')
    .eq('role', 'ceo')
    .single();

  // Update research agents to report to Research Coordinator
  const researchAgentNames = [
    'Nova',
    'Phoenix',
    'Sage',
    'Echo'
  ];

  for (const agentName of researchAgentNames) {
    const { error: updateError } = await supabase
      .from('agents')
      .update({ reports_to: coordinator.id })
      .eq('company_id', companyId)
      .eq('name', agentName)
      .is('reports_to', null);

    if (updateError) {
      console.error(`❌ Error updating ${agentName}: ${updateError.message}`);
    } else {
      console.log(`   ✅ Updated ${agentName} to report to Research Coordinator`);
    }
  }

  // Update Research Coordinator to report to CEO if CEO exists
  if (ceo) {
    const { error: coordUpdateError } = await supabase
      .from('agents')
      .update({ reports_to: ceo.id })
      .eq('company_id', companyId)
      .eq('name', 'Jax')
      .is('reports_to', null);

    if (coordUpdateError) {
      console.error(`❌ Error updating Research Coordinator: ${coordUpdateError.message}`);
    } else {
      console.log(`   ✅ Updated Research Coordinator to report to CEO`);
    }
  }

  return true;
}

async function assignModels(companyId) {
  console.log('4. Assigning models to agents...');

  // Read the model assignment SQL file
  const fs = await import('fs');
  const modelSql = fs.readFileSync(join(__dirname, '../../add-safety-research-agent-models.sql'), 'utf8');

  // Parse the SQL to extract model assignments
  // This is a simple parser for the specific format in the file
  const modelAssignments = [];
  const lines = modelSql.split('\n');

  for (const line of lines) {
    if (line.includes('INSERT INTO agent_models')) {
      // Extract agent name and model ID from the INSERT statement
      const agentMatch = line.match(/'([^']*learningforge-ai-[^']*')/);
      const modelMatch = line.match(/'([^']*glm[^']*')/i);

      if (agentMatch && modelMatch) {
        const agentName = agentMatch[1].replace(/'/g, '');
        const modelId = modelMatch[1].replace(/'/g, '');
        modelAssignments.push({ agentName, modelId });
      }
    }
  }

  // Assign models
  for (const { agentName, modelId } of modelAssignments) {
    // Get agent ID
    const { data: agent, error: agentError } = await supabase
      .from('agents')
      .select('id, name')
      .eq('company_id', companyId)
      .eq('name', agentName)
      .single();

    if (agentError) {
      console.error(`❌ Error finding agent ${agentName}: ${agentError.message}`);
      continue;
    }

    // Check if model assignment already exists
    const { data: existing, error: checkError } = await supabase
      .from('agent_models')
      .select('id')
      .eq('agent_id', agent.id)
      .eq('model_id', modelId)
      .single();

    if (existing) {
      console.log(`   Model assignment already exists: ${agentName} -> ${modelId}`);
      continue;
    }

    // Create model assignment
    const { error: assignError } = await supabase
      .from('agent_models')
      .insert({
        agent_id: agent.id,
        model_id: modelId,
        assignment_type: 'primary'
      });

    if (assignError) {
      console.error(`❌ Error assigning model to ${agentName}: ${assignError.message}`);
    } else {
      console.log(`   ✅ Assigned model: ${agentName} -> ${modelId}`);
    }
  }

  return true;
}

async function verifySetup(companyId) {
  console.log('\n5. Verifying setup...');

  // Get all agents for the company
  const { data: agents, error: agentsError } = await supabase
    .from('agents')
    .select('id, name, title, role, reports_to, metadata')
    .eq('company_id', companyId);

  if (agentsError) {
    console.error(`❌ Error fetching agents: ${agentsError.message}`);
    return false;
  }

  // Get agent models separately
  const { data: agentModels, error: modelsError } = await supabase
    .from('agent_models')
    .select('agent_id, model_id, assignment_type');

  if (modelsError) {
    console.error(`❌ Error fetching agent models: ${modelsError.message}`);
    return false;
  }

  // Create a map of agent_id to models
  const agentModelsMap = {};
  agentModels.forEach(model => {
    if (!agentModelsMap[model.agent_id]) {
      agentModelsMap[model.agent_id] = [];
    }
    agentModelsMap[model.agent_id].push(model);
  });

  // Group by team
  const teamCounts = {};
  const safetyResearchAgents = [];

  agents.forEach(agent => {
    const team = agent.metadata?.team || 'no-team';
    teamCounts[team] = (teamCounts[team] || 0) + 1;

    if (team === 'safety-research') {
      safetyResearchAgents.push({
        ...agent,
        agent_models: agentModelsMap[agent.id] || []
      });
    }
  });

  console.log('Company: Learning Forge AI');
  console.log('Agent count by team:');
  Object.entries(teamCounts).forEach(([team, count]) => {
    console.log(`  ${team}: ${count} agents`);
  });

  if (safetyResearchAgents.length > 0) {
    console.log('\nSafety Research Team agents:');
    safetyResearchAgents.forEach(agent => {
      const model = agent.agent_models?.[0];
      console.log(`  ✅ ${agent.name}: ${agent.title}`);
      console.log(`     Model: ${model?.model_id || 'None'} (${model?.assignment_type || 'N/A'})`);
    });
  }

  return safetyResearchAgents.length >= 5;
}

async function main() {
  console.log('Setting up Learning Forge AI Safety Research Team...');
  console.log('===================================================\n');

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

  // Ensure company exists
  const companyId = await ensureCompanyExists();
  if (!companyId) {
    console.error('\n❌ Setup failed - could not ensure company exists');
    process.exit(1);
  }

  // Define the 5 safety research agents
  const agents = [
    {
      name: 'Jax',
      role: 'general',
      title: 'Research Coordinator - Safety Research Team Lead',
      capabilities: 'Overall research project management, methodology development, cross-agent coordination, and quality assurance for construction safety research initiatives.',
      metadata: {
        team: 'safety-research',
        specialization: 'Research Coordination',
        skills: ['research-coordination', 'methodology-development', 'cross-agent-collaboration', 'quality-assurance', 'project-management']
      }
    },
    {
      name: 'Nova',
      role: 'general',
      title: 'Safety Research Agent',
      capabilities: 'Comprehensive research on OSHA standards, HSE regulations, and construction safety compliance for regulatory compliance and safety protocol development.',
      metadata: {
        team: 'safety-research',
        specialization: 'Safety Standards Research',
        skills: ['safety-standards-research', 'regulatory-compliance', 'construction-safety-analysis', 'osha-standards', 'hse-regulations']
      }
    },
    {
      name: 'Phoenix',
      role: 'general',
      title: 'Mobile Patterns Agent',
      capabilities: 'Research on construction industry mobile UX patterns, glove-friendly interfaces, and outdoor optimization for field operations and usability.',
      metadata: {
        team: 'safety-research',
        specialization: 'Mobile UX Research',
        skills: ['mobile-ux-research', 'construction-mobile-patterns', 'glove-friendly-design', 'outdoor-optimization', 'field-usability']
      }
    },
    {
      name: 'Sage',
      role: 'general',
      title: 'Domain Knowledge Agent',
      capabilities: 'Research on construction industry expertise, safety inspection procedures, and equipment protocols for comprehensive domain knowledge.',
      metadata: {
        team: 'safety-research',
        specialization: 'Construction Domain Knowledge',
        skills: ['construction-expertise', 'safety-inspection-procedures', 'equipment-protocols', 'industry-knowledge-synthesis', 'construction-terminology']
      }
    },
    {
      name: 'Echo',
      role: 'general',
      title: 'Learning Integration Agent',
      capabilities: 'Research on user feedback analysis, continuous learning, and performance optimization for effective research integration and capability enhancement.',
      metadata: {
        team: 'safety-research',
        specialization: 'Learning Integration',
        skills: ['user-feedback-analysis', 'continuous-learning', 'performance-optimization', 'learning-loop-optimization', 'feedback-synthesis']
      }
    }
  ];

  console.log('2. Creating Safety Research Team agents...');

  // Create agents
  for (const agentData of agents) {
    await createAgentIfNotExists(companyId, agentData);
  }

  // Update reporting relationships
  await updateReportingRelationships(companyId);

  // Assign models
  await assignModels(companyId);

  // Verify setup
  const verified = await verifySetup(companyId);

  if (verified) {
    console.log('\n✅ Setup complete! Learning Forge AI Safety Research Team is ready.');
    console.log('\nSummary:');
    console.log('- Company: Learning Forge AI (LFA prefix)');
    console.log('- CEO: learningforge-ai-ceo with GLM-5.1 model');
    console.log('- Safety Research Team: 5 agents with Z.ai: GLM 5 Turbo models');
    console.log('- Research Coordinator: learningforge-ai-research-coordinator');
    console.log('- Total agents created: 7 (CEO + Research Coordinator + 5 research agents)');
  } else {
    console.error('\n❌ Setup verification failed');
    process.exit(1);
  }
}

main().catch(error => {
  console.error(`\n❌ Unexpected error: ${error.message}`);
  process.exit(1);
});
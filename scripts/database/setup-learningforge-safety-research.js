#!/usr/bin/env node

/**
 * Node.js script to set up Learning Forge AI Safety Research Team
 * Uses Supabase client instead of psql for more reliable connections
 */

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { config } from 'dotenv';

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

async function executeSqlFile(filePath, description) {
  console.log(`\n${description}`);
  console.log('='.repeat(50));

  try {
    const sqlContent = readFileSync(filePath, 'utf8');
    console.log(`Executing SQL from: ${filePath}`);

    // Execute the entire SQL file as one query
    await sql.unsafe(sqlContent);

    console.log('✅ SQL executed successfully');
    return true;
  } catch (error) {
    console.error(`❌ Error executing SQL: ${error.message}`);
    return false;
  }
}

async function verifySetup() {
  console.log('\n4. Verifying setup...');
  console.log('===================');

  try {
    // Check company
    const companies = await sql`
      SELECT id, name, issue_prefix, status, brand_color
      FROM companies
      WHERE name = 'Learning Forge AI'
    `;

    if (companies.length === 0) {
      console.error('❌ Company verification failed: Learning Forge AI company not found');
      return false;
    }

    const company = companies[0];
    console.log('Company verification:');
    console.log(`  ✅ ${company.name} (${company.issue_prefix} prefix)`);

    // Check agents by team
    const agents = await sql`
      SELECT
        a.name,
        a.title,
        a.reports_to,
        a.metadata,
        am.model_id,
        am.assignment_type
      FROM agents a
      LEFT JOIN agent_models am ON a.name = am.agent_id
      WHERE a.company_id = ${company.id}
    `;

    // Group by team
    const teamCounts = {};
    const safetyResearchAgents = [];

    agents.forEach(agent => {
      const team = agent.metadata?.team || 'no-team';
      teamCounts[team] = (teamCounts[team] || 0) + 1;

      if (team === 'safety-research') {
        safetyResearchAgents.push(agent);
      }
    });

    console.log('\nAgent count by team:');
    Object.entries(teamCounts).forEach(([team, count]) => {
      console.log(`  ${team}: ${count} agents`);
    });

    if (safetyResearchAgents.length > 0) {
      console.log('\nSafety Research Team details:');
      safetyResearchAgents.forEach(agent => {
        console.log(`  ✅ ${agent.name}: ${agent.title}`);
        console.log(`     Model: ${agent.model_id || 'None'} (${agent.assignment_type || 'N/A'})`);
      });
    }

    return true;
  } catch (error) {
    console.error(`❌ Verification failed: ${error.message}`);
    return false;
  }
}

async function main() {
  console.log('Setting up Learning Forge AI Safety Research Team...');
  console.log('===================================================\n');

  // Test connection
  console.log('Testing database connection...');
  try {
    await sql`SELECT 1 as test`;
    console.log('✅ Database connection successful\n');
  } catch (error) {
    console.error(`❌ Database connection failed: ${error.message}`);
    process.exit(1);
  }

  // Execute SQL files
  const sqlFiles = [
    {
      path: join(__dirname, 'create-learningforge-company.sql'),
      description: '1. Ensuring Learning Forge AI company exists...'
    },
    {
      path: join(__dirname, 'add-safety-research-team-only.sql'),
      description: '2. Adding Safety Research Team agents (only new agents)...'
    },
    {
      path: join(__dirname, '../../add-safety-research-agent-models.sql'),
      description: '3. Assigning models to Safety Research Team agents...'
    }
  ];

  for (const { path, description } of sqlFiles) {
    const success = await executeSqlFile(path, description);
    if (!success) {
      console.error('\n❌ Setup failed');
      process.exit(1);
    }
  }

  // Verify setup
  const verified = await verifySetup();
  if (!verified) {
    console.error('\n❌ Setup verification failed');
    process.exit(1);
  }

  console.log('\n✅ Setup complete! Learning Forge AI Safety Research Team is ready.');
  console.log('\nSummary:');
  console.log('- Company: Learning Forge AI (LFA prefix)');
  console.log('- CEO: learningforge-ai-ceo with GLM-5.1 model');
  console.log('- Safety Research Team: 5 agents with Z.ai: GLM 5 Turbo models');
  console.log('- Research Coordinator: learningforge-ai-research-coordinator');
  console.log('- Total agents created: 7 (CEO + Research Coordinator + 5 research agents)');
}

main().catch(error => {
  console.error(`\n❌ Unexpected error: ${error.message}`);
  process.exit(1);
});
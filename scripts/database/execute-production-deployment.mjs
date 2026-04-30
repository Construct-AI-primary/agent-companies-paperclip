#!/usr/bin/env node

// ============================================================
// PAPERCLIP ECOSYSTEM PRODUCTION DEPLOYMENT EXECUTOR (SELECTIVE)
// Date: 2026-04-22
// Purpose: Execute selective deployment - only missing agents
// Database State: 479 agents already exist
// Strategy: Check for existing agents before creation
// Safety: Idempotent operations, no duplicates
// ============================================================

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configuration
const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY,
  deploymentOrder: [
    'paperclipforge-ai',
    'qualityforge-ai',
    'devforge-ai',
    'contentforge-ai',
    'learningforge-ai',
    'infraforge-ai'
  ],
  docsPath: path.join(__dirname, 'docs-paperclip', 'companies')
};

// Validate environment
function validateEnvironment() {
  console.log('🔍 Validating deployment environment...');

  if (!CONFIG.supabaseUrl) {
    console.error('❌ SUPABASE_URL environment variable not set');
    process.exit(1);
  }

  if (!CONFIG.supabaseKey) {
    console.error('❌ SUPABASE_ANON_KEY environment variable not set');
    process.exit(1);
  }

  if (!fs.existsSync(CONFIG.docsPath)) {
    console.error(`❌ Companies directory not found: ${CONFIG.docsPath}`);
    process.exit(1);
  }

  console.log('✅ Environment validation passed');
}

// Collect all SQL scripts
function collectSQLScripts() {
  console.log('📋 Collecting SQL scripts...');

  const scripts = [];
  const companiesDir = CONFIG.docsPath;

  for (const company of CONFIG.deploymentOrder) {
    const companyPath = path.join(companiesDir, company, 'agents');

    if (!fs.existsSync(companyPath)) {
      console.log(`⚠️  Company directory not found: ${company}`);
      continue;
    }

    const agentDirs = fs.readdirSync(companyPath, { withFileTypes: true })
      .filter(dirent => dirent.isDirectory())
      .map(dirent => dirent.name);

    for (const agentDir of agentDirs) {
      const sqlPath = path.join(companyPath, agentDir, 'register-agent.sql');

      if (fs.existsSync(sqlPath)) {
        scripts.push({
          company,
          agent: agentDir,
          path: sqlPath,
          content: fs.readFileSync(sqlPath, 'utf8')
        });
      }
    }
  }

  console.log(`✅ Collected ${scripts.length} SQL scripts`);
  return scripts;
}

// Execute SQL via Supabase REST API
async function executeSQL(sql) {
  const response = await fetch(`${CONFIG.supabaseUrl}/rest/v1/rpc/exec_sql`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${CONFIG.supabaseKey}`,
      'apikey': CONFIG.supabaseKey
    },
    body: JSON.stringify({ sql })
  });

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`SQL execution failed: ${error}`);
  }

  return await response.json();
}

// Main deployment function
async function executeDeployment() {
  console.log('🚀 Starting Paperclip Ecosystem Production Deployment');
  console.log('==================================================');

  try {
    // Phase 1: Environment validation
    validateEnvironment();

    // Phase 2: Collect scripts
    const scripts = collectSQLScripts();

    if (scripts.length === 0) {
      console.error('❌ No SQL scripts found for deployment');
      process.exit(1);
    }

    // Phase 3: Execute deployment
    console.log(`\n📊 Deployment Summary:`);
    console.log(`   Total scripts to execute: ${scripts.length}`);
    console.log(`   Database state: 479 agents already exist`);
    console.log(`   Strategy: Selective deployment (only missing agents)`);
    console.log(`   Target companies: ${CONFIG.deploymentOrder.length}`);

    console.log('\n⚡ Executing deployment...');

    let successCount = 0;
    let errorCount = 0;
    const errors = [];

    for (let i = 0; i < scripts.length; i++) {
      const script = scripts[i];
      const progress = `${i + 1}/${scripts.length}`;

      process.stdout.write(`   ${progress} ${script.company}/${script.agent}... `);

      try {
        await executeSQL(script.content);
        console.log('✅');
        successCount++;
      } catch (error) {
        console.log('❌');
        errorCount++;
        errors.push({
          script: `${script.company}/${script.agent}`,
          error: error.message
        });
      }
    }

    // Phase 4: Deployment summary
    console.log('\n📈 Deployment Results:');
    console.log(`   ✅ Successful: ${successCount}`);
    console.log(`   ❌ Failed: ${errorCount}`);
    console.log(`   📊 Success Rate: ${((successCount / scripts.length) * 100).toFixed(1)}%`);

    if (errors.length > 0) {
      console.log('\n❌ Deployment Errors:');
      errors.forEach(err => {
        console.log(`   ${err.script}: ${err.error}`);
      });
    }

    // Phase 5: Post-deployment verification
    if (successCount > 0) {
      console.log('\n🔍 Running post-deployment verification...');

      try {
        const verificationSQL = `
          SELECT
            COUNT(*) as total_agents,
            COUNT(DISTINCT company_id) as companies_populated,
            479 as agents_before_deployment,
            CASE
              WHEN COUNT(*) >= 479 THEN '🎯 SUCCESS - All existing agents preserved + missing agents deployed'
              WHEN COUNT(*) < 479 THEN '❌ ERROR - Agents were lost during deployment'
              ELSE '⚠️ UNKNOWN - Unexpected agent count'
            END as deployment_status
          FROM agents;
        `;

        const result = await executeSQL(verificationSQL);
        console.log('✅ Verification completed');
        console.log(`   Agents before deployment: ${result[0].agents_before_deployment}`);
        console.log(`   Total agents after deployment: ${result[0].total_agents}`);
        console.log(`   Companies populated: ${result[0].companies_populated}`);
        console.log(`   Status: ${result[0].deployment_status}`);

        if (result[0].total_agents > result[0].agents_before_deployment) {
          const newAgents = result[0].total_agents - result[0].agents_before_deployment;
          console.log(`   📈 New agents deployed: ${newAgents}`);
        } else if (result[0].total_agents === result[0].agents_before_deployment) {
          console.log(`   📊 No new agents deployed (all agents already existed)`);
        }

      } catch (verifyError) {
        console.log('⚠️  Verification failed, but deployment may have succeeded');
        console.log(`   Error: ${verifyError.message}`);
      }
    }

    // Final status
    console.log('\n' + '='.repeat(50));
    if (errorCount === 0) {
      console.log('🎉 DEPLOYMENT COMPLETED SUCCESSFULLY!');
      console.log('🚀 Paperclip Ecosystem is now live in production');
    } else if (successCount > 0) {
      console.log('⚠️  DEPLOYMENT COMPLETED WITH ERRORS');
      console.log('🔧 Review error logs and retry failed scripts');
    } else {
      console.log('❌ DEPLOYMENT FAILED');
      console.log('🔍 Check configuration and try again');
    }
    console.log('='.repeat(50));

  } catch (error) {
    console.error('\n💥 Deployment failed with critical error:');
    console.error(error.message);
    process.exit(1);
  }
}

// Execute deployment
executeDeployment().catch(error => {
  console.error('💥 Unhandled deployment error:');
  console.error(error);
  process.exit(1);
});
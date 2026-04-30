#!/usr/bin/env node

/**
 * Schema Documentation Startup Regenerator
 * Orchestrates all schema documentation extraction scripts
 *
 * This script calls all individual extractors to ensure complete
 * schema documentation is generated on server startup.
 */

import { execSync } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

console.log('🚀 Starting Schema Documentation Regeneration...');

// List of extraction scripts to run in order
const extractors = [
  {
    name: 'Deep Agents Index',
    script: path.join(__dirname, 'extract-deep-agents.js'),
    description: 'Generates deep agents documentation index'
  },
  {
    name: 'Schema Supabase Extractor (Modular)',
    script: path.join(process.cwd(), 'scripts/schema-management/run-schema-extraction.js'),
    description: 'Generates comprehensive schema documentation from Supabase database'
  },
  {
    name: 'UI Components Extractor',
    script: path.join(process.cwd(), '.clinerules/workflows/index-buttons-modals.js'),
    description: 'Generates UI components documentation (buttons, modals, relationships)'
  },
  {
    name: 'RLS Policies Checker',
    script: path.join(process.cwd(), 'scripts/diagnostics/check_current_rls_policies.js'),
    description: 'Generates RLS policies and table indexes'
  }
];

let successCount = 0;
let failureCount = 0;

for (const extractor of extractors) {
  try {
    console.log(`\n📋 Running ${extractor.name}...`);
    console.log(`   ${extractor.description}`);

    // Execute the script
    execSync(`node ${extractor.script}`, {
      stdio: 'inherit',
      cwd: process.cwd()
    });

    console.log(`✅ ${extractor.name} completed successfully`);
    successCount++;

  } catch (error) {
    console.error(`❌ ${extractor.name} failed:`, error.message);
    failureCount++;

    // Continue with other extractors even if one fails
    console.log(`⚠️ Continuing with remaining extractors...`);
  }
}

console.log(`\n📊 Schema Regeneration Summary:`);
console.log(`   ✅ Successful: ${successCount}`);
console.log(`   ❌ Failed: ${failureCount}`);
console.log(`   📊 Total: ${extractors.length}`);

if (failureCount === 0) {
  console.log(`\n🎉 All schema documentation generated successfully!`);
} else {
  console.log(`\n⚠️ Schema regeneration completed with ${failureCount} failures`);
  console.log(`   Check individual extractor logs for details`);
}

// Exit with appropriate code
process.exit(failureCount > 0 ? 1 : 0);
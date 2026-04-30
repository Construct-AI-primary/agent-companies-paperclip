#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// QualityForge AI reporting hierarchy based on Paperclip Teams Cross-Reference
const qualityforgeHierarchy = {
  // Executive Team - reports to Apex (CEO)
  'apex-qualityforge-ceo': null,  // CEO reports to null
  'governor-qualityforge-quality-director': 'apex-qualityforge-ceo',
  
  // Quality Team - reports to Governor (Quality Director)
  'guardian-qualityforge-quality-guardian': 'governor-qualityforge-quality-director',
  'standards-qualityforge-standards-enforcer': 'governor-qualityforge-quality-director',
  'monitor-qualityforge-quality-monitor': 'governor-qualityforge-quality-director',
  'validator-qualityforge-validator': 'governor-qualityforge-quality-director',
  'reporter-qualityforge-quality-reporter': 'governor-qualityforge-quality-director',
  'trainer-qualityforge-quality-trainer': 'governor-qualityforge-quality-director',
  'documenter-qualityforge-documentation-specialist': 'governor-qualityforge-quality-director',
  'coverage-qualityforge-test-coverage-analyst': 'governor-qualityforge-quality-director',
  'auditor-qualityforge-quality-auditor': 'governor-qualityforge-quality-director',
  
  // Additional QualityForge agents - reports to Governor (Quality Director)
  'architect-qualityforge-system-architect': 'governor-qualityforge-quality-director',
  'automation-qualityforge-test-automation': 'governor-qualityforge-quality-director',
  'codesmith-qualityforge-code-architect': 'governor-qualityforge-quality-director',
  'debugger-Debugger-specialist': 'governor-qualityforge-quality-director',
  'diagnostics-Diagnostics-specialist': 'governor-qualityforge-quality-director',
  'e2e-qualityforge-end-to-end-testing': 'governor-qualityforge-quality-director',
  'fixer-qualityforge-bug-fixing-specialist': 'governor-qualityforge-quality-director',
  'inspector-qualityforge-code-inspector': 'governor-qualityforge-quality-director',
  'integration-Integration-testing': 'governor-qualityforge-quality-director',
  'integrator-Integration-specialist': 'governor-qualityforge-quality-director',
  'load-Load-testing': 'governor-qualityforge-quality-director',
  'loadtester-qualityforge-scalability-testing': 'governor-qualityforge-quality-director',
  'maintainer-qualityforge-code-maintainer': 'governor-qualityforge-quality-director',
  'migrator-qualityforge-migration-specialist': 'governor-qualityforge-quality-director',
  'optimizer-qualityforge-performance-optimizer': 'governor-qualityforge-quality-director',
  'probe-qualityforge-probe-testing': 'governor-qualityforge-quality-director',
  'profiler-qualityforge-profiler-specialist': 'governor-qualityforge-quality-director',
  'refactor-qualityforge-refactoring-specialist': 'governor-qualityforge-quality-director',
  'resolver-qualityforge-issue-resolver': 'governor-qualityforge-quality-director',
  'simulator-qualityforge-simulation-testing': 'governor-qualityforge-quality-director',
  'tracer-qualityforge-execution-tracer': 'governor-qualityforge-quality-director',
  'accessibility-qualityforge-accessibility-testing': 'governor-qualityforge-quality-director',
  'dbat-testing-qualityforge': 'governor-qualityforge-quality-director',
  'reviewer-qualityforge-code-reviewer': 'governor-qualityforge-quality-director',
  'analyzer-qualityforge-code-analyzer': 'governor-qualityforge-quality-director',
  
  // Additional agents with different slug patterns
  'compatibility-Compatibility-testing': 'governor-qualityforge-quality-director',
  'optimizer-qualityforge-code-optimizer': 'governor-qualityforge-quality-director',
  'performance-Performance-testing': 'governor-qualityforge-quality-director',
  'probe-qualityforge-prompt-testing': 'governor-qualityforge-quality-director',
  'profiler-Performance-profiler': 'governor-qualityforge-quality-director',
  'refactor-Refactoring-specialist': 'governor-qualityforge-quality-director',
  'simulator-qualityforge-workflow-simulation': 'governor-qualityforge-quality-director',
  'standards-Standards-enforcer': 'governor-qualityforge-quality-director',
  'validator-Validator': 'governor-qualityforge-quality-director',
  'accessibility-Accessibility-testing': 'governor-qualityforge-quality-director',
};

function updateAgentFile(agentPath, newReportsTo) {
  try {
    const content = fs.readFileSync(agentPath, 'utf8');
    
    // Check if file already has the correct reportsTo value
    if (content.includes(`reportsTo: ${newReportsTo}`)) {
      console.log(`✓ ${path.basename(path.dirname(agentPath))} already has correct reportsTo`);
      return false;
    }
    
    // Update the reportsTo field
    const updatedContent = content.replace(
      /reportsTo: .+/,
      `reportsTo: ${newReportsTo}`
    );
    
    fs.writeFileSync(agentPath, updatedContent, 'utf8');
    console.log(`✓ Updated ${path.basename(path.dirname(agentPath))} -> ${newReportsTo}`);
    return true;
  } catch (error) {
    console.error(`✗ Error updating ${agentPath}:`, error.message);
    return false;
  }
}

function processQualityForgeAgents() {
  const qualityforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/qualityforge-ai/agents');
  
  if (!fs.existsSync(qualityforgeDir)) {
    console.error(`Directory not found: ${qualityforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(qualityforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing QualityForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(qualityforgeDir, agent, 'AGENTS.md');
    
    if (!fs.existsSync(agentPath)) {
      console.log(`✗ No AGENTS.md found for ${agent}`);
      errorCount++;
      continue;
    }
    
    // Read the agent file to get the actual slug
    try {
      const content = fs.readFileSync(agentPath, 'utf8');
      const slugMatch = content.match(/slug:\s*(.+)/);
      if (!slugMatch) {
        console.log(`⚠ No slug found in ${agent}`);
        skippedCount++;
        continue;
      }
      
      const slug = slugMatch[1].trim();
      
      // Find matching hierarchy entry
      const matchingKey = Object.keys(qualityforgeHierarchy).find(key => key === slug);
      
      if (!matchingKey) {
        console.log(`⚠ No hierarchy mapping found for ${slug}`);
        skippedCount++;
        continue;
      }
      
      const newReportsTo = qualityforgeHierarchy[matchingKey];
      const updated = updateAgentFile(agentPath, newReportsTo);
      
      if (updated) {
        updatedCount++;
      } else {
        skippedCount++;
      }
    } catch (error) {
      console.error(`✗ Error reading ${agentPath}:`, error.message);
      errorCount++;
    }
  }
  
  console.log(`\n=== Summary ===`);
  console.log(`Updated: ${updatedCount}`);
  console.log(`Skipped (already correct): ${skippedCount}`);
  console.log(`Errors: ${errorCount}`);
  console.log(`Total: ${agents.length}`);
  
  return updatedCount;
}

// Run the update
const updated = processQualityForgeAgents();
process.exit(updated > 0 ? 0 : 0);
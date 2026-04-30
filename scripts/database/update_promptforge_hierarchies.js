#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// PromptForge AI reporting hierarchy based on Paperclip Teams Cross-Reference
const promptforgeHierarchy = {
  // Architecture Team - reports to Sage (Chief Architect)
  'sage-promptforge-chief-architect': null,  // Chief Architect reports to null
  'blueprint-promptforge-template-designer': 'sage-promptforge-chief-architect',
  'cascade-promptforge-workflow-designer': 'sage-promptforge-chief-architect',
  'flowdesigner-promptforge-agent-handoff': 'sage-promptforge-chief-architect',
  'harmonic-promptforge-orchestration-strategy': 'sage-promptforge-chief-architect',
  'statemaster-promptforge-state-management': 'sage-promptforge-chief-architect',
  
  // Research Team - reports to Sage (Chief Architect)
  'experimenter-promptforge-hypothesis-testing': 'sage-promptforge-chief-architect',
  'explorer-promptforge-new-techniques': 'sage-promptforge-chief-architect',
  'scholar-promptforge-academic-research': 'sage-promptforge-chief-architect',
  'enhancer-promptforge-advanced-innovation': 'sage-promptforge-chief-architect',
  'specialist-promptforge-domain-adaptation': 'sage-promptforge-chief-architect',
  
  // Ethics Team - reports to Sage (Chief Architect)
  'integrity-promptforge-ethical-ai': 'sage-promptforge-chief-architect',
  'compliance-promptforge-regulatory-compliance': 'sage-promptforge-chief-architect',
  'predictor-promptforge-outcome-prediction': 'sage-promptforge-chief-architect',
  'refiner-promptforge-version-control': 'sage-promptforge-chief-architect',
  
  // Analytics Team - reports to Sage (Chief Architect)
  'analyzer-promptforge-prompt-analytics': 'sage-promptforge-chief-architect',
  'clarity-promptforge-performance-optimization': 'sage-promptforge-chief-architect',
  'tuner-promptforge-ab-testing': 'sage-promptforge-chief-architect',
  'quantifier-promptforge-benchmarking': 'sage-promptforge-chief-architect',
  'archivist-promptforge-knowledge-management': 'sage-promptforge-chief-architect',
  
  // Integration Team - reports to Sage (Chief Architect)
  'integration-promptforge-cross-agent-compatibility': 'sage-promptforge-chief-architect',
  'collaborator-promptforge-cross-company-knowledge-sharing': 'sage-promptforge-chief-architect',
  'validator-promptforge-syntax-logic-validation': 'sage-promptforge-chief-architect',
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

function processPromptForgeAgents() {
  const promptforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/promptforge-ai/agents');
  
  if (!fs.existsSync(promptforgeDir)) {
    console.error(`Directory not found: ${promptforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(promptforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing PromptForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(promptforgeDir, agent, 'AGENTS.md');
    
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
      const matchingKey = Object.keys(promptforgeHierarchy).find(key => key === slug);
      
      if (!matchingKey) {
        console.log(`⚠ No hierarchy mapping found for ${slug}`);
        skippedCount++;
        continue;
      }
      
      const newReportsTo = promptforgeHierarchy[matchingKey];
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
const updated = processPromptForgeAgents();
process.exit(updated > 0 ? 0 : 0);
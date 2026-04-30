#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// InfraForge AI reporting hierarchy based on Paperclip Teams Cross-Reference
const infraforgeHierarchy = {
  // Executive Team - reports to Orchestrator (CEO)
  'orchestrator-infraforge-ceo': null,  // CEO reports to null
  
  // Infrastructure Team - reports to Orchestrator (CEO)
  'database-infraforge-database-infrastructure': 'orchestrator-infraforge-ceo',
  'mobile-api-infraforge-mobile-api-integration': 'orchestrator-infraforge-ceo',
  'supply-chain-integration-infraforge-supply-chain': 'orchestrator-infraforge-ceo',
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

function processInfraForgeAgents() {
  const infraforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/infraforge-ai/agents');
  
  if (!fs.existsSync(infraforgeDir)) {
    console.error(`Directory not found: ${infraforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(infraforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing InfraForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(infraforgeDir, agent, 'AGENTS.md');
    
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
      const matchingKey = Object.keys(infraforgeHierarchy).find(key => key === slug);
      
      if (!matchingKey) {
        console.log(`⚠ No hierarchy mapping found for ${slug}`);
        skippedCount++;
        continue;
      }
      
      const newReportsTo = infraforgeHierarchy[matchingKey];
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
const updated = processInfraForgeAgents();
process.exit(updated > 0 ? 0 : 0);
#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// Fix KnowledgeForge AI hierarchy
// Coordinator Guardian should be CEO
// Chairman should report to Coordinator Guardian
// All other agents should report to Coordinator Guardian

function updateAgentFile(agentPath, newReportsTo, agentName) {
  try {
    const content = fs.readFileSync(agentPath, 'utf8');
    
    // Check if file already has the correct reportsTo value
    if (content.includes(`reportsTo: ${newReportsTo}`)) {
      console.log(`✓ ${agentName} already has correct reportsTo`);
      return false;
    }
    
    // Update the reportsTo field
    const updatedContent = content.replace(
      /reportsTo: .+/,
      `reportsTo: ${newReportsTo}`
    );
    
    fs.writeFileSync(agentPath, updatedContent, 'utf8');
    console.log(`✓ Updated ${agentName} -> ${newReportsTo}`);
    return true;
  } catch (error) {
    console.error(`✗ Error updating ${agentPath}:`, error.message);
    return false;
  }
}

function fixKnowledgeForgeHierarchy() {
  const knowledgeforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/knowledgeforge-ai/agents');
  
  if (!fs.existsSync(knowledgeforgeDir)) {
    console.error(`Directory not found: ${knowledgeforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(knowledgeforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Fixing KnowledgeForge AI hierarchy...\n');
  
  // First, update Chairman to report to Coordinator Guardian
  const chairmanPath = path.join(knowledgeforgeDir, 'Chairman', 'AGENTS.md');
  if (fs.existsSync(chairmanPath)) {
    const updated = updateAgentFile(chairmanPath, 'knowledgeforge-coordinator-guardian', 'Chairman');
    if (updated) updatedCount++;
    else skippedCount++;
  }
  
  // Then, update all other agents (except Coordinator Guardian) to report to Coordinator Guardian
  for (const agent of agents) {
    if (agent === 'Chairman' || agent === 'Coordinator Guardian') {
      continue; // Skip these as they're already handled
    }
    
    const agentPath = path.join(knowledgeforgeDir, agent, 'AGENTS.md');
    
    if (!fs.existsSync(agentPath)) {
      console.log(`✗ No AGENTS.md found for ${agent}`);
      errorCount++;
      continue;
    }
    
    try {
      const content = fs.readFileSync(agentPath, 'utf8');
      
      // Skip if already reporting to Coordinator Guardian
      if (content.includes('reportsTo: knowledgeforge-coordinator-guardian')) {
        console.log(`✓ ${agent} already reports to Coordinator Guardian`);
        skippedCount++;
        continue;
      }
      
      // Update to report to Coordinator Guardian
      const updated = updateAgentFile(agentPath, 'knowledgeforge-coordinator-guardian', agent);
      if (updated) updatedCount++;
      else skippedCount++;
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

// Run the fix
const updated = fixKnowledgeForgeHierarchy();
process.exit(updated > 0 ? 0 : 0);
#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// KnowledgeForge AI has UUID-based reporting system
// Coordinator Guardian is the CEO (reportsTo: null)
// All other agents currently report to UUID 7416890b-1ed3-4298-9697-2e48355df10c (Chairman)
// We need to convert this to standard hierarchy

function updateAgentFile(agentPath, newReportsTo) {
  try {
    const content = fs.readFileSync(agentPath, 'utf8');
    
    // Check if file already has the correct reportsTo value
    if (content.includes(`reportsTo: ${newReportsTo}`)) {
      console.log(`✓ ${path.basename(path.dirname(agentPath))} already has correct reportsTo`);
      return false;
    }
    
    // Update the reportsTo field (handles both reports_to and reportsTo)
    let updatedContent = content.replace(
      /reports_to: .+/,
      `reportsTo: ${newReportsTo}`
    );
    
    // Also handle reportsTo if it exists
    updatedContent = updatedContent.replace(
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

function processKnowledgeForgeAgents() {
  const knowledgeforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/knowledgeforge-ai/agents');
  
  if (!fs.existsSync(knowledgeforgeDir)) {
    console.error(`Directory not found: ${knowledgeforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(knowledgeforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing KnowledgeForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(knowledgeforgeDir, agent, 'AGENTS.md');
    
    if (!fs.existsSync(agentPath)) {
      console.log(`✗ No AGENTS.md found for ${agent}`);
      errorCount++;
      continue;
    }
    
    // Read the agent file
    try {
      const content = fs.readFileSync(agentPath, 'utf8');
      
      // Check if this is the CEO (Coordinator Guardian)
      if (agent.includes('Coordinator Guardian')) {
        const updated = updateAgentFile(agentPath, 'null');
        if (updated) updatedCount++;
        else skippedCount++;
        continue;
      }
      
      // Check if this is the Chairman
      if (agent.includes('Chairman')) {
        const updated = updateAgentFile(agentPath, 'null');
        if (updated) updatedCount++;
        else skippedCount++;
        continue;
      }
      
      // For all other agents, check current reports_to value
      const reportsToMatch = content.match(/reports_to: (.+)/);
      if (reportsToMatch) {
        const currentReportsTo = reportsToMatch[1].trim();
        
        // If reporting to the mysterious UUID, update to Chairman
        if (currentReportsTo === '7416890b-1ed3-4298-9697-2e48355df10c') {
          const updated = updateAgentFile(agentPath, 'knowledgeforge-chairman');
          if (updated) updatedCount++;
          else skippedCount++;
        } else {
          console.log(`⚠ ${agent} reports to different UUID: ${currentReportsTo}`);
          skippedCount++;
        }
      } else {
        console.log(`⚠ ${agent} has no reports_to field`);
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
const updated = processKnowledgeForgeAgents();
process.exit(updated > 0 ? 0 : 0);
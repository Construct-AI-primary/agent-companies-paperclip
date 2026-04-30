#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// KnowledgeForge AI remaining agents script
// Handle agents that report to different UUIDs or have no reports_to field

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
    
    // If no reports_to or reportsTo field exists, add it after name field
    if (!updatedContent.includes('reportsTo:') && !updatedContent.includes('reports_to:')) {
      updatedContent = updatedContent.replace(
        /(name: .+\n)/,
        `$1reportsTo: ${newReportsTo}\n`
      );
    }
    
    fs.writeFileSync(agentPath, updatedContent, 'utf8');
    console.log(`✓ Updated ${path.basename(path.dirname(agentPath))} -> ${newReportsTo}`);
    return true;
  } catch (error) {
    console.error(`✗ Error updating ${agentPath}:`, error.message);
    return false;
  }
}

function processRemainingAgents() {
  const knowledgeforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/knowledgeforge-ai/agents');
  
  if (!fs.existsSync(knowledgeforgeDir)) {
    console.error(`Directory not found: ${knowledgeforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(knowledgeforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing remaining KnowledgeForge AI agents...\n');
  
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
      
      // Skip if already has correct reportsTo
      if (content.includes('reportsTo: knowledgeforge-chairman') || 
          content.includes('reportsTo: null') ||
          content.includes('reportsTo: knowledgeforge-coordinator-guardian')) {
        console.log(`✓ ${agent} already has correct reportsTo`);
        skippedCount++;
        continue;
      }
      
      // Check current reports_to value
      const reportsToMatch = content.match(/reports_to: (.+)/);
      if (reportsToMatch) {
        const currentReportsTo = reportsToMatch[1].trim();
        
        // Handle different UUIDs
        if (currentReportsTo === '68a18976-a913-4f6f-a6cd-2563a61e1e6b') {
          const updated = updateAgentFile(agentPath, 'knowledgeforge-chairman');
          if (updated) updatedCount++;
          else skippedCount++;
        } else if (currentReportsTo === '56669ae0-ee85-429a-acbb-4d08f29b4e96') {
          const updated = updateAgentFile(agentPath, 'knowledgeforge-chairman');
          if (updated) updatedCount++;
          else skippedCount++;
        } else if (currentReportsTo === '3ef52731-14fc-4347-9185-3e0c00c30486') {
          const updated = updateAgentFile(agentPath, 'knowledgeforge-chairman');
          if (updated) updatedCount++;
          else skippedCount++;
        } else {
          console.log(`⚠ ${agent} reports to unknown UUID: ${currentReportsTo}`);
          skippedCount++;
        }
      } else {
        // No reports_to field - add it
        const updated = updateAgentFile(agentPath, 'knowledgeforge-chairman');
        if (updated) updatedCount++;
        else skippedCount++;
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
const updated = processRemainingAgents();
process.exit(updated > 0 ? 0 : 0);
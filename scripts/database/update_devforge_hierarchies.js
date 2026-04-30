#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// DevForge AI reporting hierarchy based on Paperclip Teams Cross-Reference
const devforgeHierarchy = {
  // Executive Team - reports to Nexus (CEO)
  'nexus-devforge-ceo': null,  // CEO reports to null
  'ambassador-devforge-brand-representation': 'nexus-devforge-ceo',
  'mentor-devforge-team-development': 'nexus-devforge-ceo',
  'librarian-devforge-knowledge-management': 'nexus-devforge-ceo',
  
  // Engineering Team - reports to Forge (Team Lead)
  'forge-devforge-system-architecture': 'nexus-devforge-ceo',
  'devcore-devforge-core-development': 'forge-devforge-system-architecture',
  'codesmith-devforge-backend-engineer': 'forge-devforge-system-architecture',
  'fixer-devforge-bug-fixing': 'forge-devforge-system-architecture',
  'reviewer-devforge-code-review-qa': 'forge-devforge-system-architecture',
  'automata-devforge-automation-systems': 'forge-devforge-system-architecture',
  'cloudops-devforge-cloud-operations': 'forge-devforge-system-architecture',
  'interface-devforge-api-integration': 'forge-devforge-system-architecture',
  'cortex-devforge-ai-reasoning': 'nexus-devforge-ceo',
  
  // Data Team - reports to Dataforge (Team Lead)
  'dataforge-devforge-data-transformation': 'nexus-devforge-ceo',
  'stream-devforge-data-streaming': 'dataforge-devforge-data-transformation',
  'schema-devforge-data-schema-management': 'dataforge-devforge-data-transformation',
  'sentinel-devforge-data-quality-monitoring': 'dataforge-devforge-data-transformation',
  'sentinelx-devforge-advanced-monitoring': 'sentinel-devforge-data-quality-monitoring',
  'synth-Synthetic-data': 'dataforge-devforge-data-transformation',
  'vector-Vector-processing': 'dataforge-devforge-data-transformation',
  'sql-query-devforge': 'dataforge-devforge-data-transformation',
  'oracle-devforge-predictive-analytics': 'nexus-devforge-ceo',
  'ledgerai-devforge-financial-data': 'nexus-devforge-ceo',
  'promptsmith-devforge-prompt-engineering': 'nexus-devforge-ceo',
  
  // Product Team - reports to Catalyst (Team Lead)
  'catalyst-devforge-product-innovation': 'nexus-devforge-ceo',
  'cartographer-devforge-product-roadmapping': 'catalyst-devforge-product-innovation',
  'atlas-devforge-product-mapping': 'catalyst-devforge-product-innovation',
  'nova-devforge-product-launches': 'atlas-devforge-product-mapping',
  'storycraft-devforge-product-storytelling': 'atlas-devforge-product-mapping',
  'concierge-devforge-customer-experience': 'atlas-devforge-product-mapping',
  'insight-devforge-business-intelligence': 'nexus-devforge-ceo',
  
  // Growth Team - reports to Amplifier (Team Lead)
  'amplifier-devforge-marketing-promotion': 'nexus-devforge-ceo',
  'brandforge-devforge-brand-development': 'amplifier-devforge-marketing-promotion',
  'ally-devforge-partnership-management': 'amplifier-devforge-marketing-promotion',
  'dealmaker-devforge-sales-negotiation': 'amplifier-devforge-marketing-promotion',
  'merchant-devforge-commerce-operations': 'amplifier-devforge-marketing-promotion',
  'analyst-devforge-market-analysis': 'voyager-devforge-market-exploration',
  'scout-devforge-competitive-intelligence': 'analyst-devforge-market-analysis',
  'voyager-devforge-market-exploration': 'nexus-devforge-ceo',
  'catalystx-devforge-market-disruption': 'nexus-devforge-ceo',
  'navigator-devforge-data-discovery': 'n/a',
  
  // Security Team - reports to Guardian (Team Lead)
  'guardian-devforge-threat-protection': 'nexus-devforge-ceo',
  'gatekeeper-devforge-access-control': 'guardian-devforge-threat-protection',
  'auditor-devforge-security-compliance': 'guardian-devforge-threat-protection',
  'archivist-devforge-knowledge-security': 'guardian-devforge-threat-protection',
  'watchtower-devforge-security-oversight': 'guardian-devforge-threat-protection',
  'pulse-devforge-realtime-monitoring': 'sentinelx-devforge-advanced-monitoring',
  
  // Strategy Team - reports to Council (Team Lead)
  'council-devforge-strategic-decision-making': 'nexus-devforge-ceo',
  'strategos-devforge-strategic-planning': 'council-devforge-strategic-decision-making',
  'compass-devforge-direction-setting': 'council-devforge-strategic-decision-making',
  'pathfinder-devforge-opportunity-identification': 'strategos-devforge-strategic-planning',
  'orion-devforge-orchestrator': 'council-devforge-strategic-decision-making',
  'ledger-devforge-financial-oversight': 'council-devforge-strategic-decision-making',
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

function processDevForgeAgents() {
  const devforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/devforge-ai/agents');
  
  if (!fs.existsSync(devforgeDir)) {
    console.error(`Directory not found: ${devforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(devforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing DevForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(devforgeDir, agent, 'AGENTS.md');
    
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
      const matchingKey = Object.keys(devforgeHierarchy).find(key => key === slug);
      
      if (!matchingKey) {
        console.log(`⚠ No hierarchy mapping found for ${slug}`);
        skippedCount++;
        continue;
      }
      
      const newReportsTo = devforgeHierarchy[matchingKey];
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
const updated = processDevForgeAgents();
process.exit(updated > 0 ? 0 : 0);
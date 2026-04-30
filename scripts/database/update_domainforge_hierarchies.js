#!/usr/bin/env node

import fs from 'fs';
import path from 'path';

// DomainForge AI reporting hierarchy based on Paperclip Teams Cross-Reference
const domainforgeHierarchy = {
  // Executive Team - reports to Orion (CEO)
  'orion-domainforge-ceo': null,  // CEO reports to null
  
  // Engineering Team - reports to Orion (CEO)
  'civil-domainforge-civil-engineering': 'orion-domainforge-ceo',
  'construction-engineering-domainforge-construction-engineering': 'orion-domainforge-ceo',
  'structural-domainforge-structural-engineering': 'orion-domainforge-ceo',
  'geotechnical-domainforge-geotechnical-engineering': 'orion-domainforge-ceo',
  'transportation-domainforge-transportation-engineering': 'orion-domainforge-ceo',
  'mobile-testing-domainforge-mobile-testing': 'orion-domainforge-ceo',
  'mobile-workflow-designer-domainforge-mobile-workflow': 'orion-domainforge-ceo',
  
  // Operations Team - reports to Orion (CEO)
  'procurement-domainforge-procurement-contracts': 'orion-domainforge-ceo',
  'procurement-strategy-domainforge-procurement-strategy': 'orion-domainforge-ceo',
  'procurement-analytics-domainforge-procurement-analytics': 'orion-domainforge-ceo',
  'supplier-management-domainforge-supplier-management': 'orion-domainforge-ceo',
  'logistics-domainforge-supply-chain': 'orion-domainforge-ceo',
  'contract-administration-domainforge-contract-administration': 'orion-domainforge-ceo',
  
  // Governance Team - reports to Orion (CEO)
  'council-domainforge-governance-standards': 'orion-domainforge-ceo',
  'strategos-domainforge-strategic-planning': 'orion-domainforge-ceo',
  'finance-domainforge-finance-cost-management': 'orion-domainforge-ceo',
  'financial-compliance-domainforge-financial-compliance': 'orion-domainforge-ceo',
  'safety-domainforge-safety-risk-management': 'orion-domainforge-ceo',
  'quality-assurance-domainforge-quality-assurance': 'orion-domainforge-ceo',
  'quality-control-domainforge-quality-control': 'orion-domainforge-ceo',
  'legal-domainforge-legal-regulatory-compliance': 'orion-domainforge-ceo',
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

function processDomainForgeAgents() {
  const domainforgeDir = path.join(process.cwd(), 'docs-paperclip/companies/domainforge-ai/agents');
  
  if (!fs.existsSync(domainforgeDir)) {
    console.error(`Directory not found: ${domainforgeDir}`);
    process.exit(1);
  }
  
  const agents = fs.readdirSync(domainforgeDir);
  let updatedCount = 0;
  let skippedCount = 0;
  let errorCount = 0;
  
  console.log('Processing DomainForge AI agents...\n');
  
  for (const agent of agents) {
    const agentPath = path.join(domainforgeDir, agent, 'AGENTS.md');
    
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
      const matchingKey = Object.keys(domainforgeHierarchy).find(key => key === slug);
      
      if (!matchingKey) {
        console.log(`⚠ No hierarchy mapping found for ${slug}`);
        skippedCount++;
        continue;
      }
      
      const newReportsTo = domainforgeHierarchy[matchingKey];
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
const updated = processDomainForgeAgents();
process.exit(updated > 0 ? 0 : 0);
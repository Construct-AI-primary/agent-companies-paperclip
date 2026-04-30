#!/usr/bin/env node

/**
 * Supabase Schema Extractor and Documentation Generator
 *
 * This script extracts complete table definitions, relationships, and workflow mappings
 * from Supabase and generates comprehensive documentation.
 *
 * Usage:
 *   node 0300_SUPABASE_SCHEMA_EXTRACTOR.js [options]
 *
 * Options:
 *   --extract-all          Extract complete schema and generate all docs
 *   --table <name>         Generate docs for specific table
 *   --workflow <name>      Generate docs for specific workflow
 *   --relationships        Generate relationship overview
 *   --catalog              Generate table catalog
 *   --help                 Show this help message
 */

import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

// Supabase configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Error: Missing Supabase configuration');
  console.error('Please ensure SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set in .env');
  process.exit(1);
}

// Initialize Supabase client
const supabase = createClient(supabaseUrl, supabaseKey);

// Output directories
const DOCS_DIR = path.join(__dirname, '..', 'table-documentation');
const EXTRACTED_DIR = path.join(DOCS_DIR, 'live-extracted-definitions');
const WORKFLOW_DIR = path.join(DOCS_DIR, 'workflow-table-mapping');
const RELATIONSHIPS_DIR = path.join(DOCS_DIR, 'table-relationships');

// Ensure directories exist
[DOCS_DIR, EXTRACTED_DIR, WORKFLOW_DIR, RELATIONSHIPS_DIR].forEach(dir => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
});

/**
 * Extract complete table definitions from Supabase
 */
async function extractCompleteTableDefinitions() {
  console.log('🔍 Extracting complete table definitions...');

  try {
    const { data, error } = await supabase.rpc('extract_complete_table_definitions');

    if (error) {
      console.error('❌ Error extracting table definitions:', error);
      return null;
    }

    console.log(`✅ Extracted ${data?.length || 0} table definitions`);
    return data;
  } catch (error) {
    console.error('❌ Error calling extract_complete_table_definitions:', error);
    return null;
  }
}

/**
 * Extract table relationships
 */
async function extractTableRelationships() {
  console.log('🔗 Extracting table relationships...');

  try {
    const { data, error } = await supabase.rpc('extract_table_relationships');

    if (error) {
      console.error('❌ Error extracting relationships:', error);
      return null;
    }

    console.log(`✅ Extracted ${data?.length || 0} relationships`);
    return data;
  } catch (error) {
    console.error('❌ Error calling extract_table_relationships:', error);
    return null;
  }
}

/**
 * Extract workflow mappings
 */
async function extractWorkflowMappings() {
  console.log('🏷️ Extracting workflow mappings...');

  try {
    const { data, error } = await supabase.rpc('map_tables_to_workflows');

    if (error) {
      console.error('❌ Error extracting workflow mappings:', error);
      return null;
    }

    console.log(`✅ Extracted workflow mappings for ${data?.length || 0} tables`);
    return data;
  } catch (error) {
    console.error('❌ Error calling map_tables_to_workflows:', error);
    return null;
  }
}

/**
 * Generate documentation for a specific table
 */
async function generateTableDocumentation(tableName) {
  console.log(`📝 Generating documentation for table: ${tableName}`);

  try {
    const { data, error } = await supabase.rpc('generate_table_documentation', {
      table_name_input: tableName
    });

    if (error) {
      console.error(`❌ Error generating docs for ${tableName}:`, error);
      return null;
    }

    const outputPath = path.join(EXTRACTED_DIR, `${tableName}-table.md`);
    fs.writeFileSync(outputPath, data);
    console.log(`✅ Generated: ${outputPath}`);
    return data;
  } catch (error) {
    console.error(`❌ Error calling generate_table_documentation for ${tableName}:`, error);
    return null;
  }
}

/**
 * Generate workflow-based documentation
 */
async function generateWorkflowDocumentation(workflowName) {
  console.log(`📋 Generating documentation for workflow: ${workflowName}`);

  try {
    const { data, error } = await supabase.rpc('generate_workflow_table_group', {
      workflow_name: workflowName
    });

    if (error) {
      console.error(`❌ Error generating workflow docs for ${workflowName}:`, error);
      return null;
    }

    const outputPath = path.join(WORKFLOW_DIR, `${workflowName}-tables.md`);
    fs.writeFileSync(outputPath, data);
    console.log(`✅ Generated: ${outputPath}`);
    return data;
  } catch (error) {
    console.error(`❌ Error calling generate_workflow_table_group for ${workflowName}:`, error);
    return null;
  }
}

/**
 * Generate table catalog master document
 */
function generateTableCatalogMaster(tables, workflows) {
  console.log('📚 Generating table catalog master document...');

  const catalogPath = path.join(DOCS_DIR, '0300_TABLE_CATALOG_MASTER.md');

  let content = `# Table Catalog Master

## Overview

This document provides a comprehensive catalog of all database tables in the Construct AI system, organized by workflow and business criticality.

**Generated:** ${new Date().toISOString()}
**Source:** Live Supabase database extraction
**Total Tables:** ${tables?.length || 0}

## Table Summary by Workflow

| Workflow | Tables | Critical | High | Medium | Low |
|----------|--------|----------|------|--------|-----|
`;

  // Group by workflow and criticality
  const workflowStats = {};
  workflows?.forEach(table => {
    const workflow = table.primary_workflow || 'general';
    if (!workflowStats[workflow]) {
      workflowStats[workflow] = { total: 0, critical: 0, high: 0, medium: 0, low: 0 };
    }
    workflowStats[workflow].total++;
    const crit = table.business_criticality?.toLowerCase();
    if (crit === 'critical') workflowStats[workflow].critical++;
    else if (crit === 'high') workflowStats[workflow].high++;
    else if (crit === 'medium') workflowStats[workflow].medium++;
    else workflowStats[workflow].low++;
  });

  Object.entries(workflowStats).forEach(([workflow, stats]) => {
    content += `| ${workflow} | ${stats.total} | ${stats.critical} | ${stats.high} | ${stats.medium} | ${stats.low} |\n`;
  });

  content += `
## Complete Table Catalog

| Table Name | Primary Workflow | Business Criticality | RLS Enabled | Estimated Rows |
|------------|------------------|---------------------|-------------|----------------|
`;

  tables?.sort((a, b) => {
    // Sort by criticality, then workflow, then table name
    const critOrder = { 'CRITICAL': 0, 'HIGH': 1, 'MEDIUM': 2, 'LOW': 3 };
    const critA = critOrder[a.business_criticality] ?? 4;
    const critB = critOrder[b.business_criticality] ?? 4;

    if (critA !== critB) return critA - critB;
    if (a.primary_workflow !== b.primary_workflow) return a.primary_workflow.localeCompare(b.primary_workflow);
    return a.table_name.localeCompare(b.table_name);
  }).forEach(table => {
    content += `| \`${table.table_name}\` | ${table.primary_workflow || 'general'} | ${table.business_criticality || 'Unknown'} | ${table.rls_enabled ? '✅ Yes' : '❌ No'} | ${table.row_estimate || 'Unknown'} |\n`;
  });

  content += `
## Security Overview

### RLS Status Summary
- **Tables with RLS:** ${tables?.filter(t => t.rls_enabled).length || 0}
- **Tables without RLS:** ${tables?.filter(t => !t.rls_enabled).length || 0}
- **Total Tables:** ${tables?.length || 0}

### Critical Tables Requiring Security Review
`;

  const criticalTablesWithoutRLS = tables?.filter(t =>
    t.business_criticality === 'CRITICAL' && !t.rls_enabled
  ) || [];

  if (criticalTablesWithoutRLS.length > 0) {
    criticalTablesWithoutRLS.forEach(table => {
      content += `- \`${table.table_name}\` - ${table.primary_workflow} workflow\n`;
    });
  } else {
    content += '✅ All critical tables have RLS enabled\n';
  }

  content += `
## Navigation

### Individual Table Documentation
- Located in: \`docs/database-systems/table-documentation/live-extracted-definitions/\`
- Format: \`{table_name}-table.md\`

### Workflow-Based Documentation
- Located in: \`docs/database-systems/table-documentation/workflow-table-mapping/\`
- Format: \`{workflow_name}-tables.md\`

### Relationship Documentation
- Located in: \`docs/database-systems/table-documentation/table-relationships/\`

---

*This catalog is automatically generated from live Supabase database schema.*
*Last updated: ${new Date().toISOString()}*
`;

  fs.writeFileSync(catalogPath, content);
  console.log(`✅ Generated: ${catalogPath}`);
}

/**
 * Generate relationships overview
 */
function generateRelationshipsOverview(relationships) {
  console.log('🔗 Generating relationships overview...');

  const overviewPath = path.join(RELATIONSHIPS_DIR, 'table-relationships-overview.md');

  let content = `# Table Relationships Overview

## Overview

This document provides a comprehensive view of all foreign key relationships in the Construct AI database.

**Generated:** ${new Date().toISOString()}
**Total Relationships:** ${relationships?.length || 0}

## Relationships by Type

### Foreign Key Relationships

| Parent Table | Parent Column | Child Table | Child Column | Required |
|-------------|---------------|-------------|--------------|----------|
`;

  relationships?.forEach(rel => {
    content += `| \`${rel.parent_table}\` | \`${rel.parent_column}\` | \`${rel.child_table}\` | \`${rel.child_column}\` | ${rel.is_required ? '✅ Yes' : '❌ No'} |\n`;
  });

  content += `
## Most Referenced Tables

`;

  const referenceCount = {};
  relationships?.forEach(rel => {
    referenceCount[rel.parent_table] = (referenceCount[rel.parent_table] || 0) + 1;
  });

  Object.entries(referenceCount)
    .sort(([,a], [,b]) => b - a)
    .slice(0, 10)
    .forEach(([table, count]) => {
      content += `- \`${table}\`: ${count} references\n`;
    });

  content += `
## Tables with Most Dependencies

`;

  const dependencyCount = {};
  relationships?.forEach(rel => {
    dependencyCount[rel.child_table] = (dependencyCount[rel.child_table] || 0) + 1;
  });

  Object.entries(dependencyCount)
    .sort(([,a], [,b]) => b - a)
    .slice(0, 10)
    .forEach(([table, count]) => {
      content += `- \`${table}\`: ${count} dependencies\n`;
    });

  content += `

---

*This overview is automatically generated from live Supabase database relationships.*
*Generated: ${new Date().toISOString()}*
`;

  fs.writeFileSync(overviewPath, content);
  console.log(`✅ Generated: ${overviewPath}`);
}

/**
 * Main execution function
 */
async function main() {
  const args = process.argv.slice(2);
  const command = args[0];

  console.log('🚀 Supabase Schema Extractor and Documentation Generator');
  console.log('==================================================\n');

  try {
    switch (command) {
      case '--extract-all':
        console.log('📊 Performing complete schema extraction and documentation generation...\n');

        // Extract all data
        const tables = await extractCompleteTableDefinitions();
        const relationships = await extractTableRelationships();
        const workflows = await extractWorkflowMappings();

        if (!tables || !relationships || !workflows) {
          console.error('❌ Failed to extract required data');
          process.exit(1);
        }

        // Generate master catalog
        generateTableCatalogMaster(tables, workflows);

        // Generate relationships overview
        generateRelationshipsOverview(relationships);

        // Generate documentation for critical tables
        const criticalTables = workflows?.filter(w => w.business_criticality === 'CRITICAL') || [];
        for (const table of criticalTables.slice(0, 10)) { // Limit to first 10
          await generateTableDocumentation(table.table_name);
        }

        // Generate workflow documentation
        const uniqueWorkflows = [...new Set(workflows?.map(w => w.primary_workflow).filter(Boolean))];
        for (const workflow of uniqueWorkflows) {
          await generateWorkflowDocumentation(workflow);
        }

        console.log('\n🎉 Complete schema extraction and documentation generation finished!');
        break;

      case '--table':
        const tableName = args[1];
        if (!tableName) {
          console.error('❌ Please specify a table name: --table <table_name>');
          process.exit(1);
        }
        await generateTableDocumentation(tableName);
        break;

      case '--workflow':
        const workflowName = args[1];
        if (!workflowName) {
          console.error('❌ Please specify a workflow name: --workflow <workflow_name>');
          process.exit(1);
        }
        await generateWorkflowDocumentation(workflowName);
        break;

      case '--relationships':
        const relData = await extractTableRelationships();
        if (relData) {
          generateRelationshipsOverview(relData);
        }
        break;

      case '--catalog':
        const tableData = await extractCompleteTableDefinitions();
        const workflowData = await extractWorkflowMappings();
        if (tableData && workflowData) {
          generateTableCatalogMaster(tableData, workflowData);
        }
        break;

      case '--help':
      default:
        console.log('Usage: node 0300_SUPABASE_SCHEMA_EXTRACTOR.js [options]');
        console.log('');
        console.log('Options:');
        console.log('  --extract-all          Extract complete schema and generate all docs');
        console.log('  --table <name>         Generate docs for specific table');
        console.log('  --workflow <name>      Generate docs for specific workflow');
        console.log('  --relationships        Generate relationship overview');
        console.log('  --catalog              Generate table catalog');
        console.log('  --help                 Show this help message');
        console.log('');
        console.log('Examples:');
        console.log('  node 0300_SUPABASE_SCHEMA_EXTRACTOR.js --extract-all');
        console.log('  node 0300_SUPABASE_SCHEMA_EXTRACTOR.js --table procurement_orders');
        console.log('  node 0300_SUPABASE_SCHEMA_EXTRACTOR.js --workflow procurement');
        break;
    }

  } catch (error) {
    console.error('❌ Error:', error);
    process.exit(1);
  }
}

// Run the script
if (import.meta.url === `file://${process.argv[1]}`) {
  main().catch(error => {
    console.error('❌ Fatal error:', error);
    process.exit(1);
  });
}

export {
  extractCompleteTableDefinitions,
  extractTableRelationships,
  extractWorkflowMappings,
  generateTableDocumentation,
  generateWorkflowDocumentation
};

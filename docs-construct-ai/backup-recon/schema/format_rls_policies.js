#!/usr/bin/env node

/**
 * Format RLS Policies Output Script
 * Takes the output from extract_rls_policies.sql and formats it into index-policies.md
 *
 * Usage:
 * 1. Run extract_rls_policies.sql in Supabase SQL Editor
 * 2. Copy the output and save as extract_rls_policies_output.sql
 * 3. Run: node format_rls_policies.js
 */

import fs from 'fs';
import path from 'path';

const OUTPUT_DIR = path.join(process.cwd(), 'docs', 'schema');
const INPUT_FILE = path.join(OUTPUT_DIR, 'extract_rls_policies_output.sql');
const OUTPUT_FILE = path.join(OUTPUT_DIR, 'index-policies.md');

// Read the SQL output file
function readSqlOutput() {
  if (!fs.existsSync(INPUT_FILE)) {
    console.error(`❌ Input file not found: ${INPUT_FILE}`);
    console.error('Please run extract_rls_policies.sql in Supabase SQL Editor and save output as extract_rls_policies_output.sql');
    process.exit(1);
  }

  const content = fs.readFileSync(INPUT_FILE, 'utf8');
  return content;
}

// Parse the SQL output into structured data
function parseSqlOutput(content) {
  const lines = content.split('\n').filter(line => line.trim());
  const policies = [];
  const tablesWithRlsEnabled = [];
  const tablesWithoutRls = [];
  const allTables = [];

  // Original SQL table parsing logic for the new format
  let currentSection = null;
  let sectionCount = 0;

  for (const line of lines) {
    // Skip comments and empty lines
    if (line.startsWith('--') || line.trim() === '') continue;

    // Detect section headers (our SQL has two SELECT statements)
    if (line.toLowerCase().includes('schemaname') && line.toLowerCase().includes('tablename')) {
      sectionCount++;
      if (line.toLowerCase().includes('policyname')) {
        currentSection = 'policies';
      } else if (line.toLowerCase().includes('rls_status')) {
        currentSection = 'all_tables';
      }
      continue;
    }

    // Skip separator lines and row counts
    if (line.includes('---') || line.match(/^\(\d+ rows?\)/) || line.match(/^\d+ rows?/)) continue;

    // Parse data rows
    if (currentSection && !line.startsWith('(') && line.includes('|')) {
      const columns = line.split('|').map(col => col.trim()).filter(col => col);

      if (currentSection === 'all_tables' && columns.length >= 6) {
        // Parse all tables status
        const tableInfo = {
          schemaname: columns[0],
          tablename: columns[1],
          rls_status: columns[2],
          rls_enabled: columns[3] === 't' || columns[3] === 'true',
          policy_count: parseInt(columns[4]) || 0,
          sample_policy: columns[5] || 'No policies'
        };

        allTables.push(tableInfo);

        // Categorize tables
        if (tableInfo.rls_status === 'NO_RLS') {
          tablesWithoutRls.push(tableInfo);
        } else if (tableInfo.rls_status === 'RLS_ENABLED_NO_POLICIES') {
          tablesWithRlsEnabled.push(tableInfo);
        }
        // Tables with policies will be detailed in the policies section

      } else if (currentSection === 'policies' && columns.length >= 8) {
        // Parse policy details
        policies.push({
          schemaname: columns[0],
          tablename: columns[1],
          policyname: columns[2],
          permissive: columns[3] === 't' || columns[3] === 'true',
          roles: columns[4],
          cmd: columns[5],
          qual: columns[6],
          with_check: columns[7] || null
        });
      }
    }
  }

  console.log(`📊 Found ${allTables.length} total tables`);
  console.log(`🔐 Tables with policies: ${policies.length > 0 ? new Set(policies.map(p => p.tablename)).size : 0}`);
  console.log(`⚠️  Tables with RLS enabled but no policies: ${tablesWithRlsEnabled.length}`);
  console.log(`🚫 Tables without RLS: ${tablesWithoutRls.length}`);

  return { policies, tablesWithRlsEnabled, tablesWithoutRls, allTables };
}

// Group policies by table
function groupPoliciesByTable(policies) {
  const grouped = {};

  policies.forEach(policy => {
    if (!grouped[policy.tablename]) {
      grouped[policy.tablename] = [];
    }
    grouped[policy.tablename].push(policy);
  });

  return grouped;
}

// Generate markdown content
function generateMarkdown(policiesByTable, tablesWithRlsEnabled, tablesWithoutRls) {
  const timestamp = new Date().toISOString();

  let markdown = `# 🔐 RLS Policies Index - Construct AI Database Schema

**Comprehensive index of Row Level Security policies for all database tables.**

## 📋 Overview

This document provides detailed information about Row Level Security (RLS) policies for all tables in the Construct AI database schema.

## 📊 Policy Statistics

- **Total Tables with Policies**: ${Object.keys(policiesByTable).length}
- **Tables with RLS Enabled (No Policies)**: ${tablesWithRlsEnabled.length}
- **Tables without RLS**: ${tablesWithoutRls.length}
- **Generated**: ${timestamp}
- **Source**: Direct SQL extraction from pg_policies

## 🔐 RLS Policy Details

### Tables with RLS Policies

**Tables with RLS**: ${Object.keys(policiesByTable).length}

**Tables without RLS**: ${tablesWithoutRls.length}

`;

  // Sort tables alphabetically
  const sortedTables = Object.keys(policiesByTable).sort();

  for (const tableName of sortedTables) {
    const policies = policiesByTable[tableName];

    markdown += `#### \`${tableName}\`\n\n`;
    markdown += `**RLS Policies**: ${policies.length}\n\n`;

    policies.forEach((policy, idx) => {
      markdown += `**Policy ${idx + 1}:** ${policy.policyname}\n`;
      markdown += `- **Operations:** ${policy.cmd || 'ALL'}\n`;
      markdown += `- **Roles:** ${policy.roles}\n`;
      if (policy.qual && policy.qual !== 'null') {
        markdown += `- **Condition:** \`${policy.qual}\`\n`;
      }
      if (policy.with_check && policy.with_check !== 'null') {
        markdown += `- **Check:** \`${policy.with_check}\`\n`;
      }
      markdown += `- **Permissive:** ${policy.permissive}\n`;
      markdown += `\n`;
    });

    markdown += `---\n\n`;
  }

  // Add tables with RLS enabled but no policies
  if (tablesWithRlsEnabled.length > 0) {
    markdown += `### Tables with RLS Enabled (No Policies)\n\n`;
    tablesWithRlsEnabled.forEach(table => {
      markdown += `- \`${table.tablename}\` - RLS enabled but no policies defined\n`;
    });
    markdown += `\n`;
  }

  // Add tables without RLS
  if (tablesWithoutRls.length > 0) {
    markdown += `### Tables without RLS\n\n`;
    tablesWithoutRls.forEach(table => {
      markdown += `- \`${table.tablename}\` - No RLS configured\n`;
    });
    markdown += `\n`;
  }

  markdown += `**📝 Generated**: ${timestamp}\n`;
  markdown += `**🔍 Total Tables Analyzed**: ${Object.keys(policiesByTable).length + tablesWithRlsEnabled.length + tablesWithoutRls.length}\n`;
  markdown += `**🏗️ System**: Construct AI Direct RLS Policy Extraction\n`;

  return markdown;
}

// Main execution
function main() {
  try {
    console.log('🔍 Reading SQL output file...');
    const sqlContent = readSqlOutput();

    console.log('📊 Parsing SQL output...');
    const { policies, tablesWithRlsEnabled, tablesWithoutRls } = parseSqlOutput(sqlContent);

    console.log(`✅ Found ${policies.length} policies across ${Object.keys(groupPoliciesByTable(policies)).length} tables`);

    console.log('📋 Grouping policies by table...');
    const policiesByTable = groupPoliciesByTable(policies);

    console.log('💾 Generating markdown...');
    const markdown = generateMarkdown(policiesByTable, tablesWithRlsEnabled, tablesWithoutRls);

    console.log('📁 Writing to index-policies.md...');
    fs.writeFileSync(OUTPUT_FILE, markdown);

    console.log(`✅ Successfully generated ${OUTPUT_FILE}`);
    console.log(`📊 Processed ${policies.length} policies for ${Object.keys(policiesByTable).length} tables`);

  } catch (error) {
    console.error('❌ Error processing RLS policies:', error.message);
    process.exit(1);
  }
}

main();

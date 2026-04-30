#!/usr/bin/env node
// conflict-report.mjs - Generate conflict report for manual review
// Usage: node scripts/database/conflict-report.mjs <sqlite_path> <output_file>

import { readFileSync, writeFileSync } from 'fs';
import sqlite3 from 'sqlite3';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * Generate a markdown conflict report
 */
function generateConflictReport(conflicts, syncLog) {
  const now = new Date().toISOString();
  
  let report = `# Sync Conflict Report\n\n`;
  report += `**Generated:** ${now}\n`;
  report += `**Sync ID:** ${syncLog?.sync_id || 'unknown'}\n`;
  report += `**Direction:** ${syncLog?.direction || 'unknown'}\n`;
  report += `**Tables Synced:** ${syncLog?.tables_synced || 0}\n`;
  report += `**Records Processed:** ${syncLog?.records_processed || 0}\n\n`;
  
  report += `---\n\n`;
  report += `## Summary\n\n`;
  report += `**Total Conflicts:** ${conflicts.length}\n\n`;
  
  // Group by table
  const byTable = {};
  for (const conflict of conflicts) {
    if (!byTable[conflict.table_name]) {
      byTable[conflict.table_name] = [];
    }
    byTable[conflict.table_name].push(conflict);
  }
  
  report += `## Conflicts by Table\n\n`;
  report += `| Table | Count | Types |\n`;
  report += `|-------|-------|-------|\n`;
  
  for (const [table, tableConflicts] of Object.entries(byTable)) {
    const types = [...new Set(tableConflicts.map(c => c.conflict_type))].join(', ');
    report += `| ${table} | ${tableConflicts.length} | ${types} |\n`;
  }
  
  report += `\n---\n\n`;
  report += `## Detailed Conflicts\n\n`;
  
  for (const [table, tableConflicts] of Object.entries(byTable)) {
    report += `### ${table}\n\n`;
    
    for (const conflict of tableConflicts) {
      report += `#### Record: ${conflict.record_id}\n\n`;
      report += `- **Type:** ${conflict.conflict_type}\n`;
      report += `- **Detected:** ${conflict.detected_at}\n`;
      report += `- **Status:** ${conflict.resolved_at ? `Resolved (${conflict.resolved_at})` : '⚠️ Unresolved'}\n`;
      
      if (conflict.local_value) {
        try {
          const local = JSON.parse(conflict.local_value);
          report += `- **Local Value:**\n  \`\`\`json\n  ${JSON.stringify(local, null, 2).replace(/\n/g, '\n  ')}\n  \`\`\`\n`;
        } catch {
          report += `- **Local Value:** \`${conflict.local_value}\`\n`;
        }
      }
      
      if (conflict.remote_value) {
        try {
          const remote = JSON.parse(conflict.remote_value);
          report += `- **Remote Value:**\n  \`\`\`json\n  ${JSON.stringify(remote, null, 2).replace(/\n/g, '\n  ')}\n  \`\`\`\n`;
        } catch {
          report += `- **Remote Value:** \`${conflict.remote_value}\`\n`;
        }
      }
      
      if (conflict.resolution) {
        report += `- **Resolution:** ${conflict.resolution}\n`;
      }
      
      report += `\n`;
    }
  }
  
  report += `---\n\n`;
  report += `## Resolution Instructions\n\n`;
  report += `1. Review each conflict above\n`;
  report += `2. Determine the correct value (local or remote)\n`;
  report += `3. Update the _sync_conflicts table with your resolution:\n\n`;
  report += `\`\`\`sql\n`;
  report += `UPDATE _sync_conflicts\n`;
  report += `SET resolved_at = datetime('now'),\n`;
  report += `    resolution = 'keep_remote',  -- or 'keep_local' or 'custom'\n`;
  report += `    resolved_by = 'your_name'\n`;
  report += `WHERE id = <conflict_id>;\n`;
  report += `\`\`\`\n\n`;
  report += `4. After resolving all conflicts, run sync again\n`;
  
  return report;
}

async function main() {
  const sqlitePath = process.argv[2] || './data/paperclip.db';
  const outputFile = process.argv[3] || 'logs/conflict-report.md';
  
  const db = new sqlite3.Database(sqlitePath);
  
  // Get unresolved conflicts
  const conflicts = await new Promise((resolve, reject) => {
    db.all('SELECT * FROM _sync_conflicts WHERE resolved_at IS NULL ORDER BY table_name, detected_at DESC', (err, rows) => {
      if (err) reject(err);
      else resolve(rows);
    });
  });
  
  // Get latest sync log
  const syncLog = await new Promise((resolve, reject) => {
    db.get('SELECT * FROM _sync_log ORDER BY started_at DESC LIMIT 1', (err, row) => {
      if (err) reject(err);
      else resolve(row);
    });
  });
  
  db.close();
  
  if (conflicts.length === 0) {
    console.log('✅ No unresolved conflicts found');
    process.exit(0);
  }
  
  // Generate report
  const report = generateConflictReport(conflicts, syncLog);
  writeFileSync(outputFile, report);
  
  console.log(`⚠️  ${conflicts.length} unresolved conflicts found`);
  console.log(`📄 Report: ${outputFile}`);
}

main().catch(err => {
  console.error('❌ Error:', err.message);
  process.exit(1);
});
import { readFileSync } from 'fs';

const sqlContent = readFileSync('scripts/database/cleanup_duplicate_infraforge_agents.sql', 'utf8');

console.log('Raw SQL content:');
console.log(sqlContent.substring(0, 200));

const rawStatements = sqlContent.split(';');
console.log(`\nRaw split by semicolon: ${rawStatements.length} parts`);
rawStatements.forEach((stmt, i) => {
  console.log(`${i + 1}: "${stmt.trim()}"`);
});

const statements = rawStatements
  .map(s => s.trim())
  .filter(s => s.length > 0 && !s.startsWith('--'));

console.log(`\nAfter filtering: ${statements.length} SQL statements to execute`);
statements.forEach((stmt, i) => {
  console.log(`${i + 1}: ${stmt.substring(0, 50)}...`);
});

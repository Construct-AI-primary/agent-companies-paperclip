import fs from 'fs';
import path from 'path';

// Function to convert display names to slug format
function toSlug(name) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

// Simple CSV parser that handles quoted fields
function parseCSVLine(line) {
  const fields = [];
  let current = '';
  let inQuotes = false;
  let i = 0;

  while (i < line.length) {
    const char = line[i];

    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        // Escaped quote
        current += '"';
        i += 2;
        continue;
      } else {
        // Toggle quote state
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      // Field separator
      fields.push(current);
      current = '';
    } else {
      current += char;
    }
    i++;
  }

  // Add the last field
  fields.push(current);

  return fields;
}

// Read the CSV file
const csvPath = 'docs-paperclip/schema/tables/Agent all - Configuration.csv';
const csvContent = fs.readFileSync(csvPath, 'utf8');
const lines = csvContent.split('\n');

// Parse header
const header = parseCSVLine(lines[0]);
header.push('has_dedicated_folder');

// Process each line
const processedLines = [header.join(',')];

for (let i = 1; i < lines.length; i++) {
  const line = lines[i].trim();
  if (!line) continue;

  // Parse CSV line with proper quote handling
  const fields = parseCSVLine(line);

  console.log(`Line ${i}: ${fields.length} fields`);
  if (fields.length < 25) {
    console.log(`Skipping line ${i}: ${fields.length} fields`);
    continue;
  }

  const companyName = fields[24]; // company_name column
  const agentName = fields[1];   // agent_name column

  // Convert to slugs
  const companySlug = toSlug(companyName);
  const agentSlug = toSlug(agentName);

  // Check if folder exists
  const folderPath = path.join('docs-paperclip', 'companies', companySlug, 'agents', agentSlug);
  const hasFolder = fs.existsSync(folderPath) && fs.statSync(folderPath).isDirectory();

  // Add the result
  fields.push(hasFolder ? 'Yes' : 'No');
  processedLines.push(fields.join(','));
}

// Write the updated CSV
const outputPath = 'docs-paperclip/schema/tables/Agent all - Configuration-updated.csv';
fs.writeFileSync(outputPath, processedLines.join('\n'));

console.log(`Updated CSV written to: ${outputPath}`);
console.log(`Processed ${processedLines.length - 1} agents`);

// Count results
let yesCount = 0;
let noCount = 0;
for (let i = 1; i < processedLines.length; i++) {
  const fields = processedLines[i].split(',');
  if (fields[fields.length - 1] === 'Yes') yesCount++;
  else noCount++;
}

console.log(`Agents with dedicated folders: ${yesCount}`);
console.log(`Agents without dedicated folders: ${noCount}`);
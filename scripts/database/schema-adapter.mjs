#!/usr/bin/env node
// schema-adapter.mjs - PostgreSQL to SQLite type mapping and schema adaptation
// Usage: node scripts/database/schema-adapter.mjs [input-schema.json] [output-schema.sql]

import { readFileSync, writeFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

/**
 * PostgreSQL to SQLite type mapping
 */
const TYPE_MAP = {
  // Integer types
  'integer': 'INTEGER',
  'int': 'INTEGER',
  'int2': 'INTEGER',
  'int4': 'INTEGER',
  'int8': 'INTEGER',
  'bigint': 'INTEGER',
  'smallint': 'INTEGER',
  'serial': 'INTEGER PRIMARY KEY AUTOINCREMENT',
  'bigserial': 'INTEGER PRIMARY KEY AUTOINCREMENT',
  'smallserial': 'INTEGER PRIMARY KEY AUTOINCREMENT',
  
  // Text types
  'text': 'TEXT',
  'varchar': 'TEXT',
  'varchar(n)': 'TEXT',
  'char': 'TEXT',
  'char(n)': 'TEXT',
  'character': 'TEXT',
  'character varying': 'TEXT',
  'character(n)': 'TEXT',
  'name': 'TEXT',
  'citext': 'TEXT',
  
  // UUID and special types
  'uuid': 'TEXT',
  'jsonb': 'TEXT',
  'json': 'TEXT',
  'xml': 'TEXT',
  'bytea': 'BLOB',
  'boolean': 'INTEGER',
  'bool': 'INTEGER',
  
  // Date/time types
  'timestamp': 'TEXT',
  'timestamptz': 'TEXT',
  'timestamp with time zone': 'TEXT',
  'timestamp without time zone': 'TEXT',
  'date': 'TEXT',
  'time': 'TEXT',
  'timetz': 'TEXT',
  'time with time zone': 'TEXT',
  'time without time zone': 'TEXT',
  'interval': 'TEXT',
  
  // Numeric types
  'numeric': 'REAL',
  'decimal': 'REAL',
  'real': 'REAL',
  'double precision': 'REAL',
  'float': 'REAL',
  'float4': 'REAL',
  'float8': 'REAL',
  'money': 'REAL',
  
  // Array and composite
  'ARRAY': 'TEXT',
  'array': 'TEXT',
  'enum': 'TEXT',
  
  // Network types
  'inet': 'TEXT',
  'cidr': 'TEXT',
  'macaddr': 'TEXT',
  
  // Geometric types
  'point': 'TEXT',
  'line': 'TEXT',
  'lseg': 'TEXT',
  'box': 'TEXT',
  'path': 'TEXT',
  'polygon': 'TEXT',
  'circle': 'TEXT',
};

/**
 * Convert a PostgreSQL type to SQLite type
 */
export function pgToSqliteType(pgType) {
  if (!pgType) return 'TEXT';
  
  const normalized = pgType.toLowerCase().trim();
  
  // Check exact match first
  if (TYPE_MAP[normalized]) {
    return TYPE_MAP[normalized];
  }
  
  // Check for parameterized types (e.g., varchar(255), numeric(10,2))
  const baseType = normalized.split('(')[0].trim();
  if (TYPE_MAP[baseType]) {
    return TYPE_MAP[baseType];
  }
  
  // Check for array types (e.g., integer[], text[])
  if (normalized.endsWith('[]')) {
    return 'TEXT'; // Store arrays as JSON strings
  }
  
  // Default to TEXT for unknown types
  console.warn(`⚠️  Unknown PostgreSQL type: ${pgType}, defaulting to TEXT`);
  return 'TEXT';
}

/**
 * Convert a PostgreSQL value to SQLite-compatible format
 */
export function pgToSqliteValue(value, pgType) {
  if (value === null || value === undefined) {
    return null;
  }
  
  const sqliteType = pgToSqliteType(pgType);
  
  switch (sqliteType) {
    case 'INTEGER':
      return typeof value === 'number' ? Math.floor(value) : parseInt(value, 10) || 0;
    
    case 'REAL':
      return typeof value === 'number' ? value : parseFloat(value) || 0;
    
    case 'TEXT':
      if (typeof value === 'object') {
        return JSON.stringify(value);
      }
      return String(value);
    
    case 'BLOB':
      if (Buffer.isBuffer(value)) {
        return value;
      }
      return Buffer.from(String(value));
    
    default:
      return String(value);
  }
}

/**
 * Generate SQLite CREATE TABLE statement from PostgreSQL schema
 */
export function generateSqliteCreateTable(tableName, columns, options = {}) {
  const {
    ifNotExists = true,
    includeForeignKeys = false,
  } = options;
  
  const columnDefs = [];
  const fkDefs = [];
  
  for (const col of columns) {
    const {
      name,
      type,
      nullable = true,
      primaryKey = false,
      defaultValue = null,
      references = null,
    } = col;
    
    let def = `  "${name}" ${pgToSqliteType(type)}`;
    
    if (primaryKey) {
      def += ' PRIMARY KEY';
      // SQLite autoincrement only for INTEGER PRIMARY KEY
      if (pgToSqliteType(type) === 'INTEGER PRIMARY KEY AUTOINCREMENT') {
        def = `  "${name}" INTEGER PRIMARY KEY AUTOINCREMENT`;
      }
    }
    
    if (!nullable && !primaryKey) {
      def += ' NOT NULL';
    }
    
    if (defaultValue !== null && defaultValue !== undefined) {
      // Handle default values
      if (typeof defaultValue === 'string') {
        if (defaultValue === 'now()' || defaultValue === 'CURRENT_TIMESTAMP') {
          def += " DEFAULT (datetime('now'))";
        } else if (defaultValue === 'gen_random_uuid()' || defaultValue === 'uuid_generate_v4()') {
          // UUID defaults handled at application level
        } else if (defaultValue === 'true') {
          def += ' DEFAULT 1';
        } else if (defaultValue === 'false') {
          def += ' DEFAULT 0';
        } else {
          def += ` DEFAULT '${defaultValue.replace(/'/g, "''")}'`;
        }
      } else if (typeof defaultValue === 'number') {
        def += ` DEFAULT ${defaultValue}`;
      } else if (typeof defaultValue === 'boolean') {
        def += ` DEFAULT ${defaultValue ? 1 : 0}`;
      } else if (typeof defaultValue === 'object') {
        def += ` DEFAULT '${JSON.stringify(defaultValue).replace(/'/g, "''")}'`;
      }
    }
    
    columnDefs.push(def);
    
    // Collect foreign keys for later
    if (references && includeForeignKeys) {
      fkDefs.push(`  FOREIGN KEY ("${name}") REFERENCES "${references.table}"("${references.column}")`);
    }
  }
  
  const ifNotExistsClause = ifNotExists ? 'IF NOT EXISTS ' : '';
  const allDefs = [...columnDefs, ...fkDefs];
  
  return `CREATE TABLE ${ifNotExistsClause}"${tableName}" (\n${allDefs.join(',\n')}\n);`;
}

/**
 * Convert PostgreSQL DEFAULT expressions to SQLite
 */
export function convertDefaultExpression(defaultExpr) {
  if (!defaultExpr) return null;
  
  const expr = defaultExpr.toLowerCase().trim();
  
  const conversions = {
    'now()': "datetime('now')",
    'current_timestamp': "datetime('now')",
    'timezone(\'utc\', now())': "datetime('now')",
    'gen_random_uuid()': null, // Handle at application level
    'uuid_generate_v4()': null,
    'true': '1',
    'false': '0',
    '{}'": "'{}'",
  };
  
  if (conversions[expr] !== undefined) {
    return conversions[expr];
  }
  
  return defaultExpr;
}

/**
 * Escape a value for SQLite INSERT statement
 */
export function escapeSqliteValue(value) {
  if (value === null || value === undefined) {
    return 'NULL';
  }
  
  if (typeof value === 'number') {
    return String(value);
  }
  
  if (typeof value === 'boolean') {
    return value ? '1' : '0';
  }
  
  if (typeof value === 'object') {
    return `'${JSON.stringify(value).replace(/'/g, "''")}'`;
  }
  
  return `'${String(value).replace(/'/g, "''")}'`;
}

/**
 * Generate SQLite INSERT statement
 */
export function generateSqliteInsert(tableName, row) {
  const columns = Object.keys(row);
  const values = columns.map(col => escapeSqliteValue(row[col]));
  
  return `INSERT INTO "${tableName}" (${columns.map(c => `"${c}"`).join(', ')}) VALUES (${values.join(', ')});`;
}

// CLI usage
if (process.argv[2]) {
  const inputFile = process.argv[2];
  const outputFile = process.argv[3] || 'output-schema.sql';
  
  try {
    const schema = JSON.parse(readFileSync(inputFile, 'utf8'));
    const tables = schema.tables || [];
    
    let output = '-- SQLite Schema (converted from PostgreSQL)\n';
    output += `-- Generated: ${new Date().toISOString()}\n\n`;
    output += 'PRAGMA foreign_keys = ON;\n\n';
    
    for (const table of tables) {
      output += generateSqliteCreateTable(table.name, table.columns, { includeForeignKeys: true });
      output += '\n\n';
    }
    
    writeFileSync(outputFile, output);
    console.log(`✅ SQLite schema written to ${outputFile}`);
  } catch (err) {
    console.error('❌ Error:', err.message);
    process.exit(1);
  }
}

export default {
  pgToSqliteType,
  pgToSqliteValue,
  generateSqliteCreateTable,
  convertDefaultExpression,
  escapeSqliteValue,
  generateSqliteInsert,
  TYPE_MAP,
};
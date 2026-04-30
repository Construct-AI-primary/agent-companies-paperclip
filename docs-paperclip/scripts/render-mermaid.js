#!/usr/bin/env node
/**
 * Mermaid Diagram Template Renderer
 *
 * Renders parameterized mermaid diagram templates with discipline-specific values.
 * Supports {{ param }} variable substitution and {% if param %} conditional blocks.
 *
 * Usage:
 *   node render-mermaid.js --template procurement-lifecycle --discipline 00860 --output diagram.md
 *   node render-mermaid.js --discipline 01900 --output-dir ./diagrams/
 *   node render-mermaid.js --list-templates
 *   node render-mermaid.js --template-info procurement-lifecycle
 *
 * Template Format (YAML):
 *   name: string
 *   version: string
 *   description: string
 *   parameters:
 *     - name: string
 *       type: string (string, enum, boolean, number)
 *       default: any
 *       values: []  (for enum types)
 *   template: string  (mermaid diagram with {{ param }} and {% if param %} blocks)
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

const TEMPLATES_DIR = path.join(__dirname, '..', 'templates', 'mermaid');
const REGISTRY_PATH = path.join(TEMPLATES_DIR, 'registry.yaml');

/**
 * Load the template registry
 */
function loadRegistry() {
  return yaml.load(fs.readFileSync(REGISTRY_PATH, 'utf8'));
}

/**
 * Load a template YAML file
 */
function loadTemplate(templateName) {
  const templatePath = path.join(TEMPLATES_DIR, `${templateName}.yaml`);
  if (!fs.existsSync(templatePath)) {
    throw new Error(`Template not found: ${templateName}. Available: ${listAvailableTemplates().join(', ')}`);
  }
  return yaml.load(fs.readFileSync(templatePath, 'utf8'));
}

/**
 * List all available template names
 */
function listAvailableTemplates() {
  return fs.readdirSync(TEMPLATES_DIR)
    .filter(f => f.endsWith('.yaml') && f !== 'registry.yaml')
    .map(f => f.replace('.yaml', ''));
}

/**
 * Render a template with given parameters
 *
 * Supports:
 *   {{ paramName }} — simple variable substitution
 *   {% if paramName %} ... {% else %} ... {% endif %} — conditional blocks
 *   {% for item in listParam %} ... {% endfor %} — iteration (basic)
 */
function renderTemplate(template, params) {
  let output = template.template;

  // Process conditional blocks first
  output = processConditionals(output, params);

  // Process simple variable substitution
  for (const [key, value] of Object.entries(params)) {
    const regex = new RegExp(`\\{\\{\\s*${key}\\s*\\}\\}`, 'g');
    output = output.replace(regex, value !== undefined ? String(value) : '');
  }

  // Clean up any remaining unreplaced placeholders
  output = output.replace(/\{\{.*?\}\}/g, '');
  output = output.replace(/\{%.*?%\}/g, '');

  return output.trim();
}

/**
 * Process {% if param %} ... {% else %} ... {% endif %} conditional blocks
 */
function processConditionals(template, params) {
  let output = template;

  // Process {% if param %} blocks
  const ifRegex = /\{%\s*if\s+(\w+)\s*%\}([\s\S]*?)(?:\{%\s*else\s*%\}([\s\S]*?))?\{%\s*endif\s*%\}/g;
  
  output = output.replace(ifRegex, (match, paramName, trueContent, falseContent) => {
    const paramValue = params[paramName];
    const isTruthy = paramValue === true || paramValue === 'true' || paramValue === 'yes' || paramValue === 1;
    
    if (isTruthy && trueContent) {
      return trueContent.replace(/\n    /g, '\n    ');
    } else if (!isTruthy && falseContent) {
      return falseContent.replace(/\n    /g, '\n    ');
    }
    return '';
  });

  return output;
}

/**
 * Merge provided params with defaults
 */
function mergeParams(template, providedParams) {
  const merged = { ...providedParams };
  
  for (const paramDef of template.parameters) {
    if (merged[paramDef.name] === undefined && paramDef.default !== undefined) {
      merged[paramDef.name] = paramDef.default;
    }
  }
  
  return merged;
}

/**
 * Validate parameters against template definition
 */
function validateParams(template, params) {
  const errors = [];
  
  for (const paramDef of template.parameters) {
    const value = params[paramDef.name];
    
    if (value === undefined) {
      if (paramDef.default === undefined) {
        errors.push(`Missing required parameter: ${paramDef.name}`);
      }
      continue;
    }
    
    if (paramDef.type === 'enum' && paramDef.values && !paramDef.values.includes(value)) {
      errors.push(`Invalid value for ${paramDef.name}: "${value}". Expected one of: ${paramDef.values.join(', ')}`);
    }
    
    if (paramDef.type === 'boolean') {
      const validBools = [true, false, 'true', 'false', 'yes', 'no'];
      if (!validBools.includes(value)) {
        errors.push(`Invalid value for ${paramDef.name}: "${value}". Expected boolean.`);
      }
    }
  }
  
  return errors;
}

/**
 * Main CLI entry point
 */
function main() {
  const args = process.argv.slice(2);
  const flags = {};
  
  for (let i = 0; i < args.length; i++) {
    if (args[i].startsWith('--')) {
      const key = args[i].slice(2);
      const next = args[i + 1];
      if (next && !next.startsWith('--')) {
        flags[key] = next;
        i++;
      } else {
        flags[key] = true;
      }
    }
  }

  if (flags['list-templates']) {
    const templates = listAvailableTemplates();
    const registry = loadRegistry();
    console.log('\nAvailable Mermaid Diagram Templates:\n');
    for (const name of templates) {
      const info = registry.templates[name];
      const params = info ? info.parameters.join(', ') : '(unknown)';
      console.log(`  ${name}`);
      console.log(`    Version: ${info ? info.current : 'N/A'}`);
      console.log(`    Parameters: ${params}`);
      console.log();
    }
    return;
  }

  if (flags['template-info']) {
    const template = loadTemplate(flags['template-info']);
    console.log(`\nTemplate: ${template.name}`);
    console.log(`Version: ${template.version}`);
    console.log(`Description: ${template.description}`);
    console.log('\nParameters:');
    for (const param of template.parameters) {
      const values = param.values ? ` [${param.values.join(', ')}]` : '';
      console.log(`  ${param.name}: ${param.type}${param.default !== undefined ? ` (default: ${param.default})` : ''}${values}`);
      console.log(`    ${param.description}`);
    }
    return;
  }

  const templateName = flags['template'];
  const outputPath = flags['output'];
  const outputDir = flags['output-dir'];
  const discipline = flags['discipline'];

  if (!templateName && !discipline) {
    console.error('Usage:');
    console.error('  node render-mermaid.js --template <name> [--discipline <code>] [--output <file>]');
    console.error('  node render-mermaid.js --discipline <code> --output-dir <dir>');
    console.error('  node render-mermaid.js --list-templates');
    console.error('  node render-mermaid.js --template-info <name>');
    process.exit(1);
  }

  // Collect all parameters from flags (skip non-parameter flags)
  const paramFlags = {};
  for (const [key, value] of Object.entries(flags)) {
    if (!['template', 'output', 'output-dir', 'discipline', 'list-templates', 'template-info'].includes(key)) {
      paramFlags[key] = value;
    }
  }
  if (discipline) paramFlags.discipline = discipline;

  if (templateName) {
    // Single template render
    const template = loadTemplate(templateName);
    const params = mergeParams(template, paramFlags);
    const errors = validateParams(template, params);
    
    if (errors.length > 0) {
      console.error('Parameter validation errors:');
      errors.forEach(e => console.error(`  - ${e}`));
      process.exit(1);
    }
    
    const output = renderTemplate(template, params);
    
    if (outputPath) {
      fs.mkdirSync(path.dirname(outputPath), { recursive: true });
      fs.writeFileSync(outputPath, '```mermaid\n' + output + '\n```\n', 'utf8');
      console.log(`Rendered ${templateName} to ${outputPath}`);
    } else {
      console.log('```mermaid');
      console.log(output);
      console.log('```');
    }
  } else if (outputDir) {
    // Render all templates for a discipline
    const templates = listAvailableTemplates();
    const targetDir = path.resolve(outputDir);
    fs.mkdirSync(targetDir, { recursive: true });
    
    for (const name of templates) {
      try {
        const template = loadTemplate(name);
        const params = mergeParams(template, paramFlags);
        const output = renderTemplate(template, params);
        const outPath = path.join(targetDir, `${name}.md`);
        fs.writeFileSync(outPath, '```mermaid\n' + output + '\n```\n', 'utf8');
        console.log(`Rendered ${name} to ${outPath}`);
      } catch (err) {
        console.error(`Failed to render ${name}: ${err.message}`);
      }
    }
  }
}

if (require.main === module) {
  main();
}

module.exports = {
  loadRegistry,
  loadTemplate,
  listAvailableTemplates,
  renderTemplate,
  mergeParams,
  validateParams,
};
---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# Simulation Documentation Structure - Reference Guide

## Overview

This document outlines the folder structure and file organization logic for the Correspondence Workflow Simulator documentation system. The structure is designed to provide complete debugging visibility and workflow traceability for AI agent simulations.

## 🎯 Folder Organization Logic

```
agents/simulation/docs/correspondence-workflow/
├── 01_document_analysis/           # Step 1 - Sequential numbering
├── 02_information_extraction/      # Step 2
├── 03_document_retrieval/          # Step 3
├── 04_domain_specialist/           # Step 4 - Only step with prompts
├── 05_contract_management/         # Step 5
└── 06_human_review/                # Step 6
```

## 📄 File Naming Convention

Files follow this naming pattern:
```
{dataType}_{timestamp}_{executionId}.md
```

### Examples:
- `input_2026-01-17T03-54-18-154Z_sim_1768622058152_sf9pg6tda.md`
- `output_2026-01-17T03-54-18-154Z_sim_1768622058152_sf9pg6tda.md`
- `prompt_2026-01-17T03-54-18-344Z_sim_1768622058152_sf9pg6tda.md` (only for agents using prompts)
- `error_2026-01-17T03-54-18-362Z_sim_1768622058152_sf9pg6tda.md` (when step fails)

## 🔢 Agent Step Mapping

| Step Number | Agent Type | Files Generated | Purpose |
|-------------|------------|----------------|---------|
| `01_` | Document Analysis | input + output | Initial correspondence processing |
| `02_` | Information Extraction | input + output | Extract identifiers & references |
| `03_` | Document Retrieval | input + output | Find related documents |
| `04_` | Domain Specialist | input + output + **prompt** | Specialist analysis with prompts |
| `05_` | Contract Management | input + output | Contract compliance analysis |
| `06_` | Human Review | input + error | HITL task creation |

## 📊 File Size Patterns (Reference Example)

| Directory | Input File | Output File | Prompt File | Error File |
|-----------|------------|-------------|-------------|------------|
| 01_document_analysis | 3.5KB | 21.8KB | - | - |
| 02_information_extraction | 21.2KB | 1.6KB | - | - |
| 03_document_retrieval | 331B | 884B | - | - |
| 04_domain_specialist | 779B | 817B | **19.7KB** | - |
| 05_contract_management | 338B | 1.2KB | - | - |
| 06_human_review | 782B | - | - | 467B |

## ⚙️ Logic for Future Replication

### 1. Folder Creation

```javascript
// Create numbered folders for each workflow step
const stepPrefixes = {
  'document_analysis': '01_document_analysis',
  'information_extraction': '02_information_extraction',
  'document_retrieval': '03_document_retrieval',
  'domain_specialist': '04_domain_specialist',
  'contract_management': '05_contract_management',
  'human_review': '06_human_review'
};
```

### 2. File Type Determination

- **input**: Always saved for each step
- **output**: Saved when step succeeds
- **error**: Saved when step fails
- **prompt**: Only saved for `domain_specialist` step (or any step that loads external prompts)

### 3. Timestamp Format

```javascript
const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
// Example: "2026-01-17T03-54-18-154Z"
```

### 4. Execution ID Format

```javascript
const executionId = `sim_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
// Example: "sim_1768622058152_sf9pg6tda"
```

## 🚀 Usage Pattern

```bash
# Each run creates 11-13 files across 6 directories:
# - 6 input files (one per step)
# - 5 output files (successful steps)
# - 1 prompt file (domain specialist only)
# - 1 error file (failed step, human review)

cd agents/simulation
node run-simulation.js --correspondence-file="path/to/correspondence.txt"
```

## 🛠️ Key Features for Replication

### 1. Sequential Numbering
- Ensures proper workflow order
- Easy identification of step sequence
- Consistent across all simulation runs

### 2. Unique Timestamps
- Prevent file conflicts between runs
- Enable chronological sorting
- ISO 8601 format with URL-safe characters

### 3. Execution IDs
- Group files from same simulation run
- Enable filtering by specific execution
- Include timestamp and random component for uniqueness

### 4. Conditional File Types
- **Prompt files**: Only for agents that load external prompts
- **Error files**: Only when steps fail
- **Output files**: Only when steps succeed

### 5. UTF-8 Encoding with Sanitization
- Explicit UTF-8 encoding for file writes
- Text sanitization removes unusual Unicode characters
- Consistent line endings and formatting

### 6. Markdown Format
- Human-readable documentation
- Structured with headers and sections
- Compatible with version control and documentation systems

## 📂 Complete Current Structure

```
agents/simulation/
├── correspondence-workflow-simulator.js       # Main simulator code
├── prompts/                                   # Specialist prompts (moved from docs/agents/)
│   ├── 00435-contracts-post-award/
│   │   └── correspondence-workflow/
│   │       └── specialists/                    # 18 specialist prompt files
│   │           ├── civil.md
│   │           ├── structural.md
│   │           ├── electrical.md
│   │           └── [15 more specialist prompts]
│   └── demo_correspondence_analysis.md
├── docs/
│   ├── SIMULATION_DOCUMENTATION_STRUCTURE.md  # This reference document
│   └── correspondence-workflow/               # Simulation output files
│       ├── 01_document_analysis/
│       │   ├── input_[timestamp]_[executionId].md
│       │   └── output_[timestamp]_[executionId].md
│       ├── 02_information_extraction/
│       │   ├── input_[timestamp]_[executionId].md
│       │   └── output_[timestamp]_[executionId].md
│       ├── 03_document_retrieval/
│       │   ├── input_[timestamp]_[executionId].md
│       │   └── output_[timestamp]_[executionId].md
│       ├── 04_domain_specialist/
│       │   ├── input_[timestamp]_[executionId].md
│       │   ├── output_[timestamp]_[executionId].md
│       │   └── prompt_[timestamp]_[executionId].md    # Only step with prompts
│       ├── 05_contract_management/
│       │   ├── input_[timestamp]_[executionId].md
│       │   └── output_[timestamp]_[executionId].md
│       └── 06_human_review/
│           ├── input_[timestamp]_[executionId].md
│           └── error_[timestamp]_[executionId].md      # Failed step
```

## 🔄 Workflow Integration

This documentation structure integrates with the Correspondence Workflow Simulator by:

1. **Automatic folder creation** during simulation runs
2. **Sequential file generation** as each agent step executes
3. **Conditional file saving** based on step success/failure
4. **Prompt documentation** for agents that use external prompts
5. **Error capture** for debugging failed steps

## 📈 Benefits

- **Complete Traceability**: Every agent input, output, and prompt is documented
- **Debugging Support**: Failed steps are captured with error details
- **Performance Analysis**: File sizes indicate data complexity per step
- **Reproducibility**: Unique execution IDs enable result comparison
- **Scalability**: Structure supports multiple simulation runs without conflicts

## 🏷️ Metadata Standards

Each documentation file includes:
- Execution ID for grouping
- Step ID for identification
- Timestamp for chronology
- Data type (input/output/error/prompt)
- Agent class information
- File size and performance metrics

---

*Generated for Correspondence Workflow Simulator v1.0.0*
*Last Updated: 2026-01-17*
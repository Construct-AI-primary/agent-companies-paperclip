# Learning Forge AI - VFS Workspace Structure

This directory contains the Virtual File System workspace for Learning Forge AI agents.

## Directory Structure

```
workspace/
├── law/              # Legal precedents, regulations, court rulings
├── safety/           # Safety standards, regulations, accident reports
├── equipment/        # Equipment innovations, materials breakthroughs
├── defects/          # Defect tracking, NCRs, pattern analysis
│   └── research/     # Defect research and analysis
├── lessons/          # Generated micro-lessons and exercises
├── knowledge/        # Knowledge graphs and flow mappings
├── audit/            # Audit trails and explainability logs
└── research/         # Research outputs
    ├── literature/  # Academic literature summaries
    └── gaps/         # Skill and knowledge gap analyses
```

## Usage

Agents write outputs to these directories based on their domain:
- `construction-law-research` → `/workspace/law/`
- `safety-regulation-research` → `/workspace/safety/`
- `equipment-innovation-research` → `/workspace/equipment/`
- `material-defect-tracker` → `/workspace/defects/`
- `micro-lesson-generator` → `/workspace/lessons/`
- `knowledge-flow-agent` → `/workspace/knowledge/`
- `audit-explainability` → `/workspace/audit/`
- `autoresearch-*` → `/workspace/research/`

# Architectural Knowledge Generation System

## Overview

This system provides a scalable framework for generating **architectural governance and compliance knowledge** for KnowledgeForge AI agents across all 50+ disciplines. The system uses templates and configuration files to automatically generate comprehensive knowledge about **coding standards, EU regulations, privacy requirements, security architecture, and quality assurance frameworks** for each discipline.

## Architecture

### Core Components

1. **Template File** (`PAGE-KNOWLEDGE-TEMPLATE.md`)
   - Standardized structure for all page knowledge documents
   - Contains 150+ template variables for customization
   - Organized into 10 parts covering all aspects of page knowledge

2. **Configuration File** (`PAGE-KNOWLEDGE-CONFIG.json`)
   - JSON structure mapping disciplines to template variables
   - Discipline-specific values for UI components, workflows, tables, etc.
   - Extensible to support new disciplines

3. **Generation Script** (`scripts/generate-page-knowledge.py`)
   - Python script that combines templates with configurations
   - Command-line interface for generating knowledge files
   - Automatic directory creation and file output

## File Structure

```
docs-paperclip/disciplines/
├── PAGE-KNOWLEDGE-TEMPLATE.md          # Master template
├── PAGE-KNOWLEDGE-CONFIG.json          # Configuration mappings
├── PAGE-KNOWLEDGE-README.md            # This documentation
└── [DISCIPLINE_CODE]-[discipline]/
    └── knowledge/
        └── PAGE-KNOWLEDGE.md           # Generated knowledge file
```

## Usage

### Generate Knowledge for a Discipline

```bash
# Generate knowledge for procurement discipline
python3 scripts/generate-page-knowledge.py 01900_procurement

# Generate knowledge for civil engineering
python3 scripts/generate-page-knowledge.py 00850_civil-engineering
```

### Add a New Discipline

1. **Add Configuration**: Add new discipline entry to `PAGE-KNOWLEDGE-CONFIG.json`
2. **Customize Variables**: Populate all template variables with discipline-specific values
3. **Generate**: Run the generation script
4. **Validate**: Review generated file and update agent references

### Template Variables

The template uses 150+ variables organized by category:

#### Core Discipline Variables
- `DISCIPLINE_CODE`: Discipline identifier (e.g., "01900")
- `DISCIPLINE_NAME`: Full discipline name (e.g., "Procurement")
- `AGENT_TITLE`: Agent title (e.g., "Buyer")

#### UI Navigation Variables
- `STATE_1_NAME`: First navigation state (e.g., "Agents")
- `BUTTON_1_NAME`: Button name (e.g., "Correspondence Reply")
- `BUTTON_1_COMPONENT`: React component (e.g., "CorrespondenceReplyModal")

#### Data Structure Variables
- `PRIMARY_TABLE_1_NAME`: Main table name (e.g., "Procurement Orders")
- `col_1_name`: Column name (e.g., "po_number")
- `col_1_type`: Column type (e.g., "VARCHAR(20)")

#### Workflow Variables
- `PRIMARY_WORKFLOW_1_NAME`: Workflow name (e.g., "Purchase Order Creation")
- `STEP_1_NAME`: Step name (e.g., "Supplier Selection")
- `STEP_1_COMPONENT`: Component for step (e.g., "SupplierSelectionModal")

## Generated Knowledge Structure

Each generated `PAGE-KNOWLEDGE.md` file contains:

### Part 1: Page Structure and Navigation
- State-based navigation system
- Available buttons and modals
- UI component hierarchy

### Part 2: Data Tables and Structures
- Core discipline tables
- Column specifications and validation rules
- Workflow-related tables

### Part 3: Workflows and Processes
- Primary discipline workflows
- Step-by-step process documentation
- Integration points

### Part 4: Modal Interfaces and Forms
- Form specifications
- Input validation rules
- User interaction patterns

### Part 5: System Integration Points
- API endpoints
- External system connections
- Data flow documentation

### Part 6-10: UI Components, Error Handling, Performance, Accessibility, Testing

## Integration with Agent System

### Agent Reference Updates

After generating page knowledge, update the corresponding agent `AGENTS.md` file:

```markdown
## Knowledge Base

### Page-Specific Knowledge
- **Procurement Page Knowledge** (`docs-paperclip/disciplines/01900-procurement/knowledge/PAGE-KNOWLEDGE.md`): Comprehensive knowledge of procurement UI components, tables, workflows, and system interactions
  - Procurement page navigation and state management
  - Data table structures and validation rules
  - Procurement workflows (PO creation, supplier onboarding, PR-to-PO conversion)
  - Modal interfaces and form specifications
  - System integration points (email, documents, inventory, finance)
  - UI component specifications and accessibility features
```

### Skill Integration

Link generated knowledge to agent skills:

```markdown
## Skills
- **buyer-knowledgeforge**: Core procurement capabilities
- **buyer-knowledgeforge-procurement**: Specialized procurement workflow skills
```

## Scaling Strategy

### Phase 1: Core Disciplines (High Priority)
1. Procurement (01900) - ✅ Complete
2. Civil Engineering (00850)
3. Mechanical Engineering (00870)
4. Electrical Engineering (00860)
5. Construction Management (00882)

### Phase 2: Extended Disciplines (Medium Priority)
- Safety, Quality Assurance, Project Controls
- Commercial, Contracts, Finance
- All remaining engineering disciplines

### Phase 3: Administrative Disciplines (Lower Priority)
- Document Control, IT, Governance
- Specialized domains (Legal, HR, Ethics)

## Quality Assurance

### Validation Checklist

- [ ] All template variables replaced correctly
- [ ] File generates without errors
- [ ] Cross-references to existing documentation are valid
- [ ] Agent AGENTS.md files updated with knowledge references
- [ ] Generated content aligns with discipline page documentation

### Automated Testing

```bash
# Test generation for all configured disciplines
python3 scripts/test-page-knowledge-generation.py

# Validate generated files
python3 scripts/validate-page-knowledge.py
```

## Maintenance

### Template Updates
- Update `PAGE-KNOWLEDGE-TEMPLATE.md` when new sections are needed
- Version template changes to maintain backward compatibility
- Document template variable additions

### Configuration Management
- Maintain `PAGE-KNOWLEDGE-CONFIG.json` as disciplines are added
- Version configuration changes
- Document configuration schema

### Continuous Integration
- Integrate generation into CI/CD pipeline
- Auto-regenerate knowledge when page documentation changes
- Monitor for broken references and outdated content

## Troubleshooting

### Common Issues

**Template Variable Not Replaced**
- Check spelling in configuration file
- Ensure variable exists in template
- Verify JSON syntax

**Missing Directory Structure**
- Script creates directories automatically
- Check file permissions
- Verify parent directory exists

**Invalid References**
- Cross-reference with existing page documentation
- Update configuration when UI changes
- Validate agent skill references

## Future Enhancements

### Automated Discovery
- Scan page documentation to auto-populate configuration
- Extract UI components from React code
- Generate table schemas from database definitions

### Multi-Agent Support
- Support multiple agents per discipline
- Agent-specific knowledge variations
- Role-based knowledge filtering

### Dynamic Updates
- Real-time knowledge updates when UI changes
- Integration with page component registries
- Automated testing of knowledge accuracy

---

## Contact

**KnowledgeForge AI Documentation Team**
- Template Maintenance: KnowledgeForge AI
- Configuration Updates: Discipline Specialists
- Integration Issues: Paperclip Engineering Team
# UNIV-WORKFLOW Scripts Directory

This directory contains automation scripts for the Universal Workflow Template Implementation Project (UNIV-WORKFLOW).

## Scripts Overview

### `generate-remaining-issues.py`
**Purpose**: Batch generation script that creates all remaining issues (UNIV-011 through UNIV-045) based on the specifications in `BATCH-IMPORT-READINESS.md`.

**Features**:
- Generates 18 complete issue files with full metadata
- Follows the established template pattern from manually created issues
- Includes YAML frontmatter, descriptions, acceptance criteria, dependencies, and technical specifications
- Creates properly formatted filenames with issue IDs and titles

**Usage**:
```bash
cd /Users/_Hermes/paperclip-render/docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/scripts
python3 generate-remaining-issues.py
```

**Output**:
- Creates 18 issue files in the `../issues/` directory
- Issues are organized by phase:
  - Phase 2: UNIV-011, UNIV-012, UNIV-013 (3 issues)
  - Phase 3: UNIV-020, UNIV-021, UNIV-022, UNIV-023 (4 issues)
  - Phase 4: UNIV-030, UNIV-031, UNIV-032, UNIV-033 (4 issues)
  - Phase 5: UNIV-040, UNIV-041, UNIV-042, UNIV-043, UNIV-044, UNIV-045 (6 issues)

### `validate-issues.sh`
**Purpose**: Validation script that checks all generated issues for completeness and correctness.

**Validation Checks**:
- YAML frontmatter presence and format
- Required fields (id, title, phase, status, priority)
- Section completeness (Description, Acceptance Criteria, Dependencies)
- ID format validation (UNIV-XXX pattern)
- ID consistency between filename and content
- File structure and formatting

**Usage**:
```bash
cd /Users/_Hermes/paperclip-render/docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/scripts
chmod +x validate-issues.sh
./validate-issues.sh
```

**Output**:
- Detailed validation report showing pass/fail status for each issue
- Summary of total issues validated and any errors found
- Specific error messages for failed validations

## Workflow

### 1. Generate Issues
```bash
python3 generate-remaining-issues.py
```

### 2. Validate Issues
```bash
./validate-issues.sh
```

### 3. Update Status Documents
After successful generation and validation:
- Update `ISSUE-GENERATION-STATUS.md` to show 25/25 complete
- Update `BATCH-IMPORT-READINESS.md` status to "ready-for-import"

### 4. Import to Paperclip
Use the `issue-batch-importer-paperclipforge` agent to import all issues into the Paperclip system.

## Issue Specifications

All generated issues include:
- **YAML Frontmatter**: id, title, phase, status, priority
- **Description**: Detailed problem statement and context
- **Objectives**: Specific goals and deliverables
- **Acceptance Criteria**: Measurable completion requirements
- **Company & Agent Assignment**: Proper multi-company orchestration
- **Dependencies**: Blocked-by and blocks relationships
- **Technical Specifications**: Target files, skills, complexity estimates
- **Paperclip Schema**: Ready for import configuration

## Error Handling

### Generation Errors
- Script will report specific issues that failed to generate
- Partial generation is supported - successful issues are still created
- Error messages include specific failure reasons

### Validation Errors
- Detailed error reporting for each validation failure
- Specific guidance on how to fix validation issues
- Non-blocking - allows review of partial results

## Dependencies

- **Python 3.6+**: Required for issue generation script
- **Bash**: Required for validation script
- **File System Access**: Scripts need write access to `../issues/` directory

## Troubleshooting

### Common Issues

**Permission Denied**: Make sure scripts have execute permissions
```bash
chmod +x validate-issues.sh
```

**Python Not Found**: Ensure Python 3 is available
```bash
python3 --version
```

**Directory Not Found**: Ensure you're running from the correct directory
```bash
pwd  # Should show: .../UNIV-WORKFLOW/scripts
```

**Import Errors**: Check that all required Python modules are available (built-in only)

## Project Context

This script directory supports the UNIV-WORKFLOW project, which implements 5 universal workflow templates across 23 engineering disciplines:

1. **Specification Development** (80-90% reusable)
2. **Regulatory Compliance** (85-95% reusable)
3. **Construction Administration** (80-90% reusable)
4. **Commissioning & Handover** (75-85% reusable)
5. **Safety & Risk Management** (90-95% reusable)

The project spans 5 companies and 10 weeks with a $150K budget.

## Next Steps

After successful generation and validation:
1. Review generated issues for accuracy
2. Update project status documents
3. Import issues to Paperclip system
4. Begin execution of Phase 2 issues

---

**Created**: 2026-04-13
**Last Updated**: 2026-04-13
**Project**: UNIV-WORKFLOW
**Issues Generated**: 18 (UNIV-011 through UNIV-045)
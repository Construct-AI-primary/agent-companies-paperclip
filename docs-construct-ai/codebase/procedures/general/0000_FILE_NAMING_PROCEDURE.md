---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# 0000_FILE_NAMING_PROCEDURE.md - File Naming Procedure - Construct AI System Documentation

## Document Usage Guide

**🎯 This Document's Role**: Practical implementation guide for applying file naming standards across all Construct AI development activities. **Use this procedure BEFORE creating any new files** to ensure compliance with organizational naming conventions.

**📚 Related Documents in Standards Ecosystem:**
- **`docs/standards/0002_FILE_NAMING_STANDARDS.md`** → Go here for complete naming rules, examples, and validation checklists
- **`docs/standards/0000_AGENT_CODING_STANDARDS.md`** → AI agent development naming conventions
- **`docs/standards/0001_PROMPT_TAGGING_STANDARDS.md`** → Prompt and AI content naming standards

---

## Procedure Overview

This procedure provides step-by-step guidance for applying the Construct AI file naming standards to ensure consistent, discoverable, and maintainable file organization across all project components.

### **Key Objectives**
- ✅ Ensure 100% compliance with established naming conventions
- ✅ Maintain consistent file organization across all directories
- ✅ Enable efficient file discovery and navigation
- ✅ Support automated tooling and validation processes
- ✅ Reduce naming conflicts and confusion

### **Scope**
- **Applies to**: All new file creation and renaming operations
- **Covers**: Source code, documentation, configuration, and data files
- **Excludes**: Third-party dependencies and generated files

---

## Pre-Implementation Checklist

### **Planning Phase**
- [ ] **Directory Selection**: Identify the appropriate directory structure for the new file
- [ ] **Purpose Definition**: Clearly define the file's primary purpose and content scope
- [ ] **Naming Convention Review**: Review applicable naming rules for the target directory
- [ ] **Conflict Check**: Verify no existing files have similar names in the target directory
- [ ] **Standards Reference**: Ensure access to current naming standards document

### **Validation Preparation**
- [ ] **Tools Ready**: Ensure file naming validation tools are available
- [ ] **Documentation Access**: Confirm access to naming standards and examples
- [ ] **Team Consultation**: For shared/team files, consult with relevant stakeholders

---

## Implementation Steps

### **Step 1: Directory Analysis**

#### **Determine Target Directory**
1. **Review Project Structure**: Examine existing directory organization
2. **Match File Purpose**: Select directory that best matches the file's functional category
3. **Check Existing Patterns**: Review naming patterns used in similar directories
4. **Validate Permissions**: Ensure write access to the target directory

#### **Directory-Specific Considerations**
```
For docs/standards/ → Use 0002_FILE_NAMING_STANDARDS.md patterns
For docs/procedures/ → Use 0000_[CATEGORY]_PROCEDURE.md patterns
For client/src/ → Use PascalCase.js or camelCase.js patterns
For server/src/ → Use camelCase.js patterns
```

### **Step 2: File Purpose Definition**

#### **Content Scope Analysis**
1. **Primary Function**: Define the file's main responsibility
2. **Content Boundaries**: Establish what content belongs in this file
3. **Relationship Mapping**: Identify relationships with other files
4. **Future Growth**: Consider potential file expansion or splitting needs

#### **Naming Component Identification**
- **Prefix**: Determine required numeric or category prefix
- **Base Name**: Extract core descriptive terms
- **Extension**: Confirm correct file extension
- **Separators**: Plan underscore usage for multi-word names

### **Step 3: Name Construction**

#### **Apply Core Rules**
1. **Lowercase Conversion**: Convert all characters to lowercase
2. **Word Separation**: Replace spaces with underscores (_)
3. **Descriptive Accuracy**: Ensure name accurately reflects content
4. **Brevity Balance**: Keep name concise while remaining descriptive

#### **Directory-Specific Construction**

##### **Documentation Files (docs/)**
```
Pattern: {prefix}_{descriptive_name}.md

Examples:
├── 0000_PROCEDURES_GUIDE.md
├── 0002_FILE_NAMING_STANDARDS.md
└── 00435_LANGEXTRACT_INTEGRATION_PROCEDURE.md
```

##### **JavaScript Source Files (client/src/ or server/src/)**
```
React Components: PascalCase.js
├── CorrespondenceReplyModal.js
├── DocumentAnalysisAgent.js
└── WorkflowDiagram.jsx

Utility Functions: camelCase.js
├── promptKeyValidator.js
├── dataTransformer.js
└── apiClient.js
```

##### **Database Files (server/sql/)**
```
Pattern: {operation}_{table}_{description}.sql

Examples:
├── create_users_table.sql
├── add_prompts_table.sql
└── populate_test_data.sql
```

##### **Configuration Files (root/)**
```
Pattern: .{environment}{purpose} or {ProjectName}.{extension}

Examples:
├── .env
├── .env.dev
├── package.json
└── ConstructAI.code-workspace
```

### **Step 4: Validation and Testing**

#### **Automated Validation**
1. **Run Linting Tools**: Execute file naming validation scripts
2. **Check Compliance**: Verify adherence to all naming rules
3. **Extension Verification**: Confirm correct file extension usage
4. **Pattern Matching**: Ensure consistency with directory standards

#### **Manual Review Checklist**
- [ ] **Lowercase**: All characters are lowercase
- [ ] **Underscores**: Spaces replaced with underscores (no hyphens)
- [ ] **Descriptive**: Name clearly indicates content and purpose
- [ ] **Consistent**: Follows patterns of existing files in directory
- [ ] **Sequential**: Numeric prefixes maintain logical ordering
- [ ] **Extension**: Correct extension for file type (.md, .js, .sql, etc.)

### **Step 5: File Creation**

#### **Safe Creation Process**
1. **Directory Navigation**: Change to target directory
2. **Name Finalization**: Confirm final filename meets all criteria
3. **File Creation**: Create file with validated name
4. **Initial Content**: Add appropriate file headers and basic structure
5. **Permissions**: Set correct file permissions if required

#### **Command Line Creation Examples**
```bash
# Documentation file
touch docs/procedures/0000_NEW_PROCEDURE.md

# Source code file
touch client/src/components/NewComponent.js

# Database migration
touch server/sql/create_new_table.sql
```

### **Step 6: Post-Creation Verification**

#### **Integration Checks**
1. **Import References**: Update any import statements if renaming
2. **Documentation Links**: Update documentation references to new file
3. **Build Configuration**: Verify build scripts include new file
4. **Version Control**: Ensure file is properly tracked in git

#### **Naming Audit**
- [ ] **Standards Compliance**: File follows all naming conventions
- [ ] **Directory Consistency**: Matches naming patterns in target directory
- [ ] **Reference Updates**: All references updated for renames
- [ ] **Documentation**: File location documented if necessary

---

## Common Implementation Patterns

### **New Documentation File**
```
Scenario: Creating a new procedure document

1. Directory: docs/procedures/
2. Purpose: Implementation guide for feature X
3. Name Construction: 0000_FEATURE_X_PROCEDURE.md
4. Validation: Check against existing procedure naming
5. Creation: touch docs/procedures/0000_FEATURE_X_PROCEDURE.md
6. Content: Add standard procedure template structure
```

### **New React Component**
```
Scenario: Creating a new modal component

1. Directory: client/src/components/
2. Purpose: User confirmation dialog
3. Name Construction: UserConfirmationModal.js
4. Validation: PascalCase, descriptive, ends with Modal
5. Creation: Create component with standard React structure
6. Integration: Import in parent components as needed
```

### **Database Migration**
```
Scenario: Adding new database table

1. Directory: server/sql/
2. Purpose: Create table for storing user preferences
3. Name Construction: create_user_preferences_table.sql
4. Validation: operation_table_description.sql pattern
5. Creation: Add SQL CREATE TABLE statement
6. Testing: Test migration in development environment
```

---

## Error Handling and Troubleshooting

### **Common Issues**

#### **"File already exists" Error**
**Symptoms**: Attempting to create file with existing name
**Resolution**:
1. Check existing files in target directory
2. Modify name to be more specific or add numeric differentiator
3. Consult team for naming conflict resolution

#### **"Invalid filename" Error**
**Symptoms**: System rejects filename as invalid
**Resolution**:
1. Review naming standards for prohibited characters
2. Ensure lowercase and underscore usage
3. Check file extension validity

#### **Import/Reference Errors After Rename**
**Symptoms**: Code breaks due to outdated import paths
**Resolution**:
1. Update all import statements in affected files
2. Update documentation links and references
3. Run build to identify missed references
4. Test all affected functionality

### **Recovery Procedures**

#### **Emergency Rename Process**
1. **Identify Impact**: Find all files referencing the renamed file
2. **Batch Update**: Use find/replace tools for bulk reference updates
3. **Version Control**: Commit changes in logical groups
4. **Testing**: Verify all references work after rename
5. **Documentation**: Update any documentation mentioning the file

#### **Naming Convention Violation Cleanup**
1. **Audit Current Files**: Identify non-compliant filenames
2. **Plan Migration**: Create rename plan with impact analysis
3. **Execute Changes**: Rename files following this procedure
4. **Update References**: Fix all broken references
5. **Prevent Recurrence**: Add validation to CI/CD pipeline

---

## Quality Assurance

### **Validation Checkpoints**

#### **Pre-Commit Checks**
- [ ] **Naming Compliance**: File follows all naming standards
- [ ] **Directory Appropriateness**: File placed in correct directory
- [ ] **Reference Integrity**: All references updated for changes
- [ ] **Build Success**: Project builds without errors
- [ ] **Tests Pass**: Related tests execute successfully

#### **Code Review Requirements**
- [ ] **Naming Review**: Team member validates naming compliance
- [ ] **Structure Review**: File organization follows project patterns
- [ ] **Documentation**: File purpose and usage documented
- [ ] **Integration**: File properly integrated with existing codebase

### **Automated Quality Gates**

#### **CI/CD Integration**
```yaml
# Example GitHub Actions check
- name: Validate File Naming
  run: |
    npm run validate-file-naming
    # Check for compliance with naming standards
    # Fail build on violations
```

#### **Pre-commit Hooks**
```bash
#!/bin/sh
# .git/hooks/pre-commit
npx validate-filename-patterns
# Block commits with invalid filenames
```

---

## Tooling and Automation

### **Recommended Tools**

#### **File Naming Validation**
- **Custom Scripts**: Node.js scripts for pattern validation
- **Pre-commit Hooks**: Git hooks for automatic validation
- **IDE Extensions**: VS Code extensions for real-time validation
- **CI/CD Checks**: Automated validation in build pipelines

#### **File Creation Templates**
- **Code Generators**: Yeoman or Plop.js for consistent file creation
- **Project Scaffolding**: Automated directory and file structure creation
- **Snippet Libraries**: Reusable code templates with proper naming

### **Integration Examples**

#### **VS Code Extension Configuration**
```json
{
  "file-naming-validator.enable": true,
  "file-naming-validator.patterns": {
    "docs/**/*.md": "^\\d{4}_[a-z_]+\\.md$",
    "client/src/**/*.js": "^[a-zA-Z][a-zA-Z0-9]*\\.js$",
    "server/sql/*.sql": "^[a-z_]+\\.sql$"
  }
}
```

#### **NPM Script Integration**
```json
{
  "scripts": {
    "validate-naming": "node scripts/validate-file-naming.js",
    "create-component": "plop component",
    "create-procedure": "plop procedure"
  }
}
```

---

## Maintenance and Evolution

### **Standards Updates**
- **Monitor Changes**: Track updates to naming standards document
- **Version Compatibility**: Ensure procedure aligns with current standards
- **Team Communication**: Notify team of significant naming changes
- **Migration Planning**: Plan updates for existing non-compliant files

### **Performance Considerations**
- **Build Impact**: Minimize file operations during builds
- **Cache Efficiency**: Optimize for build system caching
- **Search Optimization**: Ensure naming supports efficient file discovery
- **Automation Balance**: Balance automation benefits with manual control needs

### **Training and Adoption**
- **New Developer Onboarding**: Include in developer setup process
- **Regular Refreshers**: Quarterly review of naming standards
- **Tool Adoption**: Encourage use of automated validation tools
- **Feedback Loop**: Collect feedback on naming challenges and improvements

---

## Success Metrics

### **Compliance Metrics**
- **Target**: >95% of new files follow naming standards
- **Measurement**: Automated validation in CI/CD pipelines
- **Reporting**: Monthly compliance reports
- **Improvement**: Track trend of compliance over time

### **Efficiency Metrics**
- **File Discovery Time**: <30 seconds to locate files by name
- **Onboarding Time**: New developers adopt standards within 1 week
- **Error Reduction**: >80% reduction in naming-related merge conflicts
- **Automation Coverage**: >90% of naming validation automated

### **Quality Metrics**
- **Build Success Rate**: >98% successful builds without naming issues
- **Code Review Feedback**: <5% of reviews flag naming issues
- **Documentation Accuracy**: >95% of file references remain valid
- **Team Satisfaction**: >80% positive feedback on naming consistency

---

## Related Procedures and Standards

### **Core Standards Documents**
- → `docs/standards/0002_FILE_NAMING_STANDARDS.md` → Complete naming rules and examples
- → `docs/standards/0000_AGENT_CODING_STANDARDS.md` → AI agent development standards
- → `docs/standards/0001_PROMPT_TAGGING_STANDARDS.md` → Prompt content standards

### **Related Implementation Procedures**
- → `docs/procedures/0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md` → Documentation creation workflow
- → `docs/procedures/0000_PAGE_IMPLEMENTATION_PROCEDURE.md` → Page creation procedures
- → `docs/procedures/0000_SQL_EXECUTION_PROCEDURE.md` → Database file management

### **Quality and Validation Procedures**
- → `docs/procedures/0000_TESTING_WORKFLOW_PROCEDURE.md` → File testing procedures
- → `docs/procedures/0000_DEBUGGING_GUIDE.md` → Issue resolution procedures

---

## Document Information

- **Document ID**: `0000_FILE_NAMING_PROCEDURE`
- **Version**: 1.0
- **Created**: 2026-10-01
- **Last Updated**: 2026-10-01
- **Author**: AI Assistant (Construct AI)
- **Review Cycle**: Quarterly
- **Related Documents**:
  - `docs/standards/0002_FILE_NAMING_STANDARDS.md`
  - `docs/procedures/0000_PROCEDURES_GUIDE.md`
  - `docs/procedures/0000_WORKFLOW_DOCUMENTATION_PROCEDURE.md`

---

**Navigation**: This procedure provides practical implementation guidance for the file naming standards. For the complete rules reference, see `docs/standards/0002_FILE_NAMING_STANDARDS.md`.

---
memory_layer: durable_knowledge
para_section: docs_paperclip/companies/knowledgeforge-ai
gigabrain_tags: knowledgeforge-ai, agent-naming, naming-standards, documentation
openstinger_context: agent-naming-standards
last_updated: 2026-04-10
related_docs:
  - docs-paperclip/companies/knowledgeforge-ai/COMPANY.md
  - docs-paperclip/companies/knowledgeforge-ai/KNOWLEDGE-ARCHITECTURE.md
---

# KnowledgeForge AI Agent Naming Standards

## Overview

This document establishes naming conventions for KnowledgeForge AI agents and documents current naming inconsistencies that exist due to historical development and database constraints.

## Current Naming Analysis

### Agent Inventory Summary
- **Total Agents**: 86+ (across all companies)
- **KnowledgeForge AI Agents**: 75+ agents
- **Naming Consistency**: ~60% follow compound word convention

### Naming Pattern Categories

#### ✅ **Compound Word Convention (Preferred)**
- `AIManager` - AI system management
- `SystemAdministrator` - System administration
- `UserManager` - User lifecycle management
- `InterfaceSpecialist` - UI/UX specialization
- `OperationsCoordinator` - Operations coordination
- `QualityAssurance` - Quality assurance processes
- `DevelopmentManager` - Development management
- `CommunicationManager` - Communication systems

#### ⚠️ **Space-Separated (Legacy)**
- `Coordinator Guardian` - Workflow coordination and guardianship
- `Administrator - post-award` - Post-award administration
- `Administrator - pre-award` - Pre-award administration

#### ✅ **Single Word (Domain Experts)**
- `Buyer` - Procurement specialist
- `Engineer` - Engineering specialist
- `Electrician` - Electrical engineering specialist

### Inconsistency Analysis

#### **Pattern Distribution**
```
Compound Words:     ████████░░  (~65%)
Space-Separated:    ███░░░░░░░  (~15%)
Single Words:       ████░░░░░░  (~20%)
```

#### **Common Issues**
1. **Inconsistent compound word usage**: Some use spaces, others don't
2. **Special characters**: Hyphens in `Administrator - post-award`
3. **Mixed conventions**: Same functional roles with different naming patterns

## Formal Naming Standards

### Primary Conventions (Choose Based on Context)

#### **Option 1: Compound Words (Technical/Systems Focus)**
```
[PrimaryFunction][SecondaryFunction]
```

**Examples:**
- `SystemAdministrator` (System + Administrator)
- `AIManager` (AI + Manager)
- `UserManager` (User + Manager)
- `QualityAssurance` (Quality + Assurance)

**Best For:**
- Technical/systems roles
- API-friendly naming
- Database field compatibility
- Existing established patterns

#### **Option 2: Space-Separated Descriptive Names**
```
[Primary Function] [Secondary Function]
```

**Examples:**
- `System Administrator` (System + Administrator)
- `Quality Assurance` (Quality + Assurance)
- `User Manager` (User + Manager)

**Best For:**
- Business-focused roles
- Natural language readability
- Following existing patterns like "Coordinator Guardian"

#### **Rules (Both Options)**
1. **Descriptive**: Include primary function + specialization
2. **Title Case**: Capitalize first letter of each word (or first letter of compound)
3. **Concise**: Keep under 30 characters when possible
4. **Consistent**: Choose one approach per agent, don't mix within a name

### Secondary Conventions

#### **Single Words (Domain Experts)**
For traditional domain specialists:
- `Buyer`, `Engineer`, `Electrician`
- `Architect`, `Surveyor`, `Inspector`

#### **Specialized Roles (Hyphenated)**
For complex specializations:
- `Administrator - post-award`
- `Administrator - pre-award`
- `Director Construction`

### Functional Category Standards

#### **System Operations**
```
System Administrator    ✅
Database Manager        ✅
Network Coordinator     ✅
Security Specialist     ✅
```

#### **User Management**
```
User Manager           ✅
Access Controller      ✅
Authentication Expert  ✅
Profile Administrator  ✅
```

#### **Quality & Testing**
```
Quality Assurance      ✅
Testing Coordinator    ✅
Compliance Officer     ✅
Audit Specialist       ✅
```

#### **Development & Engineering**
```
Development Manager    ✅
Code Architect         ✅
Integration Specialist ✅
Deployment Coordinator ✅
```

## Implementation Guidelines

### For New Agent Creation

#### **Step 1: Identify Primary Function**
```
What is the agent's main responsibility?
- System administration → System Administrator
- Quality assurance → Quality Assurance
- User management → User Manager
```

#### **Step 2: Add Specialization (if needed)**
```
Primary: Quality
Specialization: Assurance
Result: Quality Assurance
```

#### **Step 3: Validate Naming**
- ✅ Space-separated descriptive name
- ✅ Title case (first letter capitalized)
- ✅ Descriptive but concise
- ✅ Follows existing patterns
- ✅ Unique within company

### Naming Validation Checklist

#### **✅ PASS Criteria**
- [ ] Space-separated words (Title Case)
- [ ] Descriptive of function
- [ ] Under 30 characters
- [ ] Follows existing patterns (like "Coordinator Guardian")
- [ ] Unique within company

#### **❌ FAIL Criteria**
- [ ] Too generic (e.g., "Manager")
- [ ] Over 35 characters
- [ ] Conflicts with existing names
- [ ] Uses compound words without spaces

## Migration Strategy

### Phase 1: Documentation (Current)
- ✅ Document existing inconsistencies
- ✅ Establish formal standards
- ✅ Create validation checklist

### Phase 2: New Agent Compliance (Immediate)
- ✅ Apply standards to all new agents
- ✅ Reject non-compliant names in creation workflows
- ✅ Update agent creation templates

### Phase 3: Legacy Migration (Future)
- ⚠️ Plan database migration for legacy names
- ⚠️ Update all references and integrations
- ⚠️ Schedule during maintenance windows

## Quality Assurance

### Automated Validation
```bash
# Proposed validation script
validate-agent-name() {
  local name="$1"

  # Check for spaces
  if [[ "$name" =~ [[:space:]] ]]; then
    echo "❌ FAIL: Contains spaces"
    return 1
  fi

  # Check for special characters
  if [[ "$name" =~ [^a-zA-Z] ]]; then
    echo "❌ FAIL: Contains special characters"
    return 1
  fi

  # Check length
  if [[ ${#name} -gt 25 ]]; then
    echo "❌ FAIL: Too long (>25 characters)"
    return 1
  fi

  echo "✅ PASS: Valid agent name"
  return 0
}
```

### Manual Review Process
1. **Agent Creation**: Validate name against standards
2. **Code Review**: Check naming consistency
3. **Documentation**: Update naming references

## Examples

### ✅ **Good Examples (Space-Separated)**
```
System Administrator    → System administration
Quality Assurance      → Quality processes
User Manager          → User lifecycle
Interface Specialist  → UI/UX design
Operations Coordinator → Operations management
```

### ⚠️ **Existing Patterns to Follow**
```
Coordinator Guardian   → Follows space-separated pattern
Administrator - post-award → Complex specialization with hyphens
Buyer                  → Single word for domain experts
```

## Future Considerations

### Technology Integration
- **API Endpoints**: Compound names work well for URLs
- **Database Fields**: No special character issues
- **File Systems**: Compatible with all operating systems

### Scalability
- **New Domains**: Easy to extend (e.g., `AISpecialist`, `CloudManager`)
- **Specializations**: Clear hierarchy (e.g., `SecurityAdministrator`, `NetworkAdministrator`)

### Internationalization
- **English Primary**: All names in English
- **No Localization**: Avoid language-specific naming
- **Universal Understanding**: Clear, descriptive terms

## Conclusion

### Current State
- **Existing Agents**: Preserve current names (database constraints)
- **New Agents**: Enforce compound word standards
- **Documentation**: Comprehensive naming guidelines

### Benefits of Standards
- ✅ **Consistency**: Uniform naming across all agents
- ✅ **Maintainability**: Easier to understand and manage
- ✅ **Integration**: Better API and system integration
- ✅ **Scalability**: Easy to add new agents following patterns

### Next Steps
1. **Implement validation** in agent creation workflows
2. **Update templates** with naming standards
3. **Train team** on new conventions
4. **Monitor compliance** for new agent creation

---

**Document Version:** 1.0
**Effective Date:** 2026-04-10
**Review Date:** 2026-10-10
**Owner:** KnowledgeForge AI - SystemAdministrator
**Approver:** KnowledgeForge AI - CoordinatorGuardian
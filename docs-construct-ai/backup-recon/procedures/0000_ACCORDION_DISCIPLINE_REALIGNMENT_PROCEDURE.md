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

# Accordion Discipline Section Realignment Prompt

## Purpose
Realign all discipline sections in the accordion navigation to ensure "My Tasks Dashboard" appears at the top of each discipline section, maintaining consistent user experience and navigation patterns.

## Scope
This prompt applies to all discipline-specific sections that should prioritize task management:
- Engineering disciplines under Design section
- Procurement section
- Safety section
- Any future discipline sections added to the accordion

## Current State Analysis
Based on the current accordion configuration files:

### ✅ Already Correctly Aligned Sections
- **Procurement**: `/my-tasks` already first ✅
- **Safety**: `/my-tasks` already first ✅
- **Design Engineering Disciplines** (subsections):
  - Architectural: `/my-tasks` already first ✅
  - Chemical Engineering: `/my-tasks` already first ✅
  - Civil Engineering: `/my-tasks` already first ✅
  - Electrical Engineering: `/my-tasks` already first ✅
  - Mechanical Engineering: `/my-tasks` already first ✅
  - Process Engineering: `/my-tasks` already first ✅

### ❌ Sections Needing Realignment
- **Main Design Section**: Currently has "Design", "Documents", "Email Management" - missing `/my-tasks` at top
- **Future/New Discipline Sections**: Any newly added discipline sections without "My Tasks Dashboard" at the top

## Required Changes

### Priority Fix: Main Design Section
The main Design section currently needs to be updated to include "My Tasks Dashboard" at the top:

#### 1. Server Template Update
```javascript
// Update the Design section in MASTER_TEMPLATE
{
  id: 'accordion-button-00800',
  title: 'Design',
  display_order: 800,
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ADD THIS FIRST
    { title: 'Design', url: '/design' } // Main discipline page second
  ],
  subsections: {
    // ... existing engineering discipline subsections remain unchanged
    'subsection-00899': {
      id: 'subsection-00899',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

#### 2. Client Fallback Update
```javascript
// Update the Design section in sectionMappings
"accordion-button-00800": {
  title: "Design",
  optionId: 6,
  links: [
    "/my-tasks", // ADD THIS FIRST - My Tasks Dashboard
    "00800-design.html" // Main discipline page second
  ],
  subsections: {
    // ... existing engineering discipline subsections remain unchanged
    "subsection-00899": {
      id: "subsection-00899",
      title: "Others",
      links: [
        "00200-all-documents.html",
        "03010-email-management.html"
      ],
      sector: "epcm",
      allowedOrganizations: ["Organisations - EPCM", "Organizations - All"]
    }
  },
  sector: "epcm",
  allowedOrganizations: ["Organisations - EPCM", "Organizations - All"]
}
```

#### 3. Emergency Fallback Update
```javascript
// Update the Design section in emergency fallback
{
  id: "accordion-button-00800",
  title: "Design",
  display_order: 800,
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ADD THIS FIRST
    { title: 'Design', url: '/design' } // Main discipline page second
  ],
  subsections: {
    // ... existing engineering discipline subsections remain unchanged
    'subsection-00899': {
      id: 'subsection-00899',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

## Comprehensive Section Upgrade Guide

Since many existing accordion sections still need to be updated to incorporate the new layout standards, this section provides detailed guidance for upgrading all section types.

### Section Tier Classification

#### **1-Tier Sections** (Simple Direct Links)
Sections with only direct links, no subsections. These are typically administrative or utility sections.

**Examples**: Home, Administration, Construction, Contracts, Document Control

**Current Pattern**:
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'Link 1', url: '/link1' },
    { title: 'Link 2', url: '/link2' },
    { title: 'Documents', url: '/all-documents' },
    { title: 'Email Management', url: '/email-management' }
  ],
  subsections: {}
}
```

**Upgrade Pattern**: Move standard links to "Others" subsection
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    // Main section links (if any discipline-specific)
  ],
  subsections: {
    'subsection-XXXX9': {
      id: 'subsection-XXXX9',
      title: 'Others',
      links: [
        { title: 'Link 1', url: '/link1' },
        { title: 'Link 2', url: '/link2' },
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

#### **2-Tier Sections** (Main Links + Subsections)
Sections with direct links and subsections. These often represent functional areas with sub-categories.

**Examples**: Logistics, Procurement, Safety, Project Controls

**Current Pattern**:
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'Main Link', url: '/main' },
    { title: 'Documents', url: '/all-documents' },
    { title: 'Email Management', url: '/email-management' }
  ],
  subsections: {
    'subsection-XXXX1': { /* existing subsections */ }
  }
}
```

**Upgrade Pattern**: Add "My Tasks Dashboard" first, move standard links to "Others"
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ADD FIRST
    { title: 'Main Link', url: '/main' } // Main section link second
  ],
  subsections: {
    // ... existing discipline-specific subsections remain
    'subsection-XXXX9': {
      id: 'subsection-XXXX9',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

#### **3-Tier Sections** (Nested Subsections)
Sections with subsections that contain their own subsections. These represent complex hierarchical domains.

**Examples**: Design (with engineering disciplines), Directors (with director roles)

**Current Pattern**:
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'Main Link', url: '/main' },
    { title: 'Documents', url: '/all-documents' },
    { title: 'Email Management', url: '/email-management' }
  ],
  subsections: {
    'subsection-XXXX1': {
      id: 'subsection-XXXX1',
      title: 'Subsection Name',
      links: [
        { title: 'Sub Link', url: '/sub-link' }
      ],
      subsections: {
        'subsection-XXXX2': { /* nested subsections */ }
      }
    }
  }
}
```

**Upgrade Pattern**: Add "My Tasks Dashboard" first, ensure nested subsections follow pattern
```javascript
{
  id: 'accordion-button-XXXXX',
  title: 'Section Name',
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ADD FIRST
    { title: 'Main Link', url: '/main' } // Main section link second
  ],
  subsections: {
    // ... existing nested subsections remain (ensure they follow My Tasks Dashboard pattern)
    'subsection-XXXX1': {
      id: 'subsection-XXXX1',
      title: 'Subsection Name',
      links: [
        { title: 'My Tasks Dashboard', url: '/my-tasks' }, // Each subsection should also start with this
        { title: 'Sub Link', url: '/sub-link' }
      ],
      subsections: {
        // ... nested subsections
        'subsection-XXXX2': {
          id: 'subsection-XXXX2',
          title: 'Operations', // or 'Other' for standard links
          links: [
            { title: 'Specific Task Links', url: '/specific' }
            // For 'Other' subsections: Documents, Email Management
          ]
        }
      }
    },
    'subsection-XXXX9': {
      id: 'subsection-XXXX9',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

### Section Upgrade Workflow

#### **Step 1: Section Inventory & Classification**
- [ ] Review all sections in `MASTER_TEMPLATE`
- [ ] Classify each section by tier (1, 2, or 3)
- [ ] Identify sections missing "My Tasks Dashboard"
- [ ] Flag sections with misplaced standard links

#### **Step 2: Priority Order**
1. **High Priority**: Discipline sections (Design, Procurement, Safety)
2. **Medium Priority**: Functional sections with user tasks (Logistics, Project Controls)
3. **Low Priority**: Administrative sections (Home, Administration, Document Control)

#### **Step 3: Upgrade Process**
For each section requiring updates:

1. **Add "My Tasks Dashboard"** as the first link (if applicable)
2. **Restructure Links**: Move main section links to proper position
3. **Create "Others" Subsection**: Move Documents/Email Management there
4. **Validate Subsections**: Ensure nested subsections follow patterns
5. **Update All Three Files**: Server template, client fallback, emergency fallback

#### **Step 4: Validation Checklist**
- [ ] Section has "My Tasks Dashboard" as first link (if discipline section)
- [ ] Main section link is second (if present)
- [ ] Standard links (Documents, Email Management) are in "Others" subsection
- [ ] All subsections within a section are arranged in alphabetical order
- [ ] Subsections follow consistent naming and ordering
- [ ] All three configuration files are synchronized
- [ ] No broken links or navigation issues

### Common Upgrade Scenarios

#### **Scenario A: Simple Section → 2-Tier**
```
BEFORE: Section with direct links only
AFTER: Section with "Others" subsection
```

#### **Scenario B: Existing 2-Tier → Enhanced 2-Tier**
```
BEFORE: Section missing "My Tasks Dashboard"
AFTER: Section with "My Tasks Dashboard" first + "Others" subsection
```

#### **Scenario C: Existing 3-Tier → Consistent 3-Tier**
```
BEFORE: Inconsistent subsection ordering
AFTER: All subsections follow "My Tasks Dashboard" first pattern
```

### Bulk Upgrade Strategy

For large-scale updates across multiple sections:

1. **Group by Section Type**: Process similar sections together
2. **Template-Based Updates**: Use the patterns above as templates
3. **Automated Validation**: Check consistency across all files
4. **Incremental Deployment**: Update in batches to minimize risk
5. **Cross-Team Coordination**: Ensure UI/UX team validates changes

## Templates for Future Additions

For **new discipline sections** or future realignments, use these templates:

### 1. Server Template (`server/src/routes/accordion-sections-routes.js`)
When adding a new discipline section to the `MASTER_TEMPLATE`:

```javascript
// New Discipline Section Template - My Tasks Dashboard FIRST
{
  id: 'accordion-button-XXXXX', // Use appropriate section ID
  title: 'New Discipline Name',
  display_order: XXX, // Appropriate display order
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ALWAYS FIRST
    { title: 'New Discipline Name', url: '/new-discipline' } // Main page second
  ],
  subsections: {
    // Add discipline-specific subsections if needed
    // Each subsection should also follow My Tasks Dashboard first pattern
    'subsection-XXXX9': {
      id: 'subsection-XXXX9',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' },
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

### 2. Client Fallback (`client/src/common/js/config/00200-ui-display-mappings.js`)
When adding to the sectionMappings:

```javascript
"accordion-button-XXXXX": {
  title: "New Discipline Name",
  optionId: XXX,
  links: [
    "/my-tasks", // ALWAYS FIRST - My Tasks Dashboard
    "/new-discipline" // Main discipline page second
  ],
  subsections: {
    // Discipline-specific subsections
    "subsection-XXXX9": {
      id: "subsection-XXXX9",
      title: "Others",
      links: [
        "/all-documents", // Standard links alphabetically
        "/email-management"
      ],
      sector: "epcm",
      allowedOrganizations: ["Organisations - EPCM", "Organizations - All"]
    }
  },
  sector: "epcm", // or "global" as appropriate
  allowedOrganizations: ["Organisations - EPCM", "Organizations - All"]
}
```

### 3. Emergency Fallback (`client/src/modules/accordion/00200-accordion-component.js`)
When updating emergency fallback data:

```javascript
{
  id: "accordion-button-XXXXX",
  title: "New Discipline Name",
  display_order: XXX,
  sector: 'global',
  links: [
    { title: 'My Tasks Dashboard', url: '/my-tasks' }, // ALWAYS FIRST
    { title: 'New Discipline Name', url: '/new-discipline' } // Main page second
  ],
  subsections: {
    // Discipline-specific subsections
    'subsection-XXXX9': {
      id: 'subsection-XXXX9',
      title: 'Others',
      links: [
        { title: 'Documents', url: '/all-documents' }, // Standard links alphabetically
        { title: 'Email Management', url: '/email-management' }
      ]
    }
  }
}
```

## Validation Steps

### 1. Template Consistency Check
- [ ] Verify all three files (server, client, emergency) have identical structure
- [ ] Confirm `/my-tasks` URL is used consistently
- [ ] Ensure "My Tasks Dashboard" title matches existing pattern

### 2. Section-by-Section Verification
For each discipline section, verify:
- [ ] "My Tasks Dashboard" is the first link
- [ ] Main discipline page (e.g., "Design", "Procurement") is second
- [ ] Standard links ("Documents", "Email Management") follow in alphabetical order
- [ ] No duplicate entries exist

### 3. Functional Testing
- [ ] Accordion loads without errors
- [ ] All discipline sections expand correctly
- [ ] "My Tasks Dashboard" links work properly
- [ ] Navigation maintains proper hierarchy

## Implementation Order

1. **Update Server Template** first (primary source of truth)
2. **Update Client Fallback** to match server template
3. **Update Emergency Fallback** to match server template
4. **Test all three environments** (production, development, offline)
5. **Validate with QA team** for user experience consistency

## Related Standards

- **UI Accordion Standards** (`docs/standards/0003_UI_ACCORDION_STANDARDS.md`)
- **File Naming Standards** (`docs/standards/0002_FILE_NAMING_STANDARDS.md`)
- **Navigation Hierarchy Patterns** (alphabetical ordering for standard links)

## Notes

- **All current discipline sections are already properly aligned** - this document serves as a reference template for future additions
- When adding new discipline sections, always place "My Tasks Dashboard" as the first link
- Maintain existing 3-tier fallback synchronization requirements across all three configuration files
- **All subsections within a section must be arranged in alphabetical order** (e.g., "Architectural" before "Chemical Engineering", "Operations" before "Others")
- Individual discipline subsections (Architectural, Chemical Engineering, etc.) already follow proper ordering
- Ensure `/my-tasks` route exists and is properly configured for all user roles
- Follow alphabetical ordering for standard links (Documents, Email Management, etc.)

## Success Criteria

- [ ] All discipline sections have "My Tasks Dashboard" as the first link
- [ ] Consistent ordering across all three accordion configuration files
- [ ] No breaking changes to existing navigation patterns
- [ ] Improved user experience with prioritized task management access
- [ ] All tests pass and QA validation complete

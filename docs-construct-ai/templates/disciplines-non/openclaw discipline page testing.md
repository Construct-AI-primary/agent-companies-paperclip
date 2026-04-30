---
title: Comprehensive Discipline Page Testing Prompt for OpenClaw
description: Systematic testing of all 50+ discipline pages based on their documentation specifications
version: 1.0
memory_layer: testing_procedures
para_section: docs/testing/disciplines-non
gigabrain_tags: discipline-testing, ui-validation, modal-testing, chatbot-testing, button-functionality, state-management, regression-testing, quality-assurance
openstinger_context: automated-testing, ui-testing, functionality-validation, error-detection
last_updated: 2026-03-26
related_docs:
  - docs/disciplines/[DISCIPLINE_CODE]/[DISCIPLINE_CODE]-[DISCIPLINE_NAME]-page-documentation.md
  - docs/testing/disciplines-non/Discipline-Page-Testing-Framework.md
  - docs_construct_ai/para/pages/codebase/testing/
---

# Comprehensive Discipline Page Testing Prompt for OpenClaw

## Overview

This prompt provides a systematic testing framework for validating all 50+ discipline pages based on their comprehensive documentation. Using the Construct AI memory system with Gigabrain integration, OpenClaw will systematically test each discipline page for complete functionality, UI consistency, and error-free operation.

## Testing Objectives

- **Complete UI Validation**: Verify all documented buttons, modals, and interactive elements
- **State Management Testing**: Ensure Agents/Upserts/Workspace state transitions work correctly
- **Modal Functionality**: Test all modal loading, button interactions, and error handling
- **Chatbot Integration**: Validate chatbot presence, configuration, and basic functionality
- **Visual Consistency**: Confirm background images, button positioning, and layout accuracy
- **Error Detection**: Identify JavaScript errors, broken links, and functionality issues
- **Cross-Browser Compatibility**: Ensure consistent behavior across supported browsers

## Memory System Integration

Using the Construct AI memory system with Gigabrain in OpenClaw:

**PARA Navigation:**

- Access `docs/disciplines/[DISCIPLINE_CODE]/[DISCIPLINE_CODE]-[DISCIPLINE_NAME]-page-documentation.md` for each discipline
- Reference `docs_construct_ai/para/pages/codebase/ui-testing/` for testing methodologies
- Access `docs_construct_ai/para/pages/codebase/error-handling/` for error validation patterns

**Gigabrain Search:**

- Search gigabrain tags for `"discipline-testing", "ui-validation", "modal-testing", "button-functionality"`
- Filter by tags: `"state-management", "chatbot-testing", "regression-testing", "quality-assurance"`

**Memory Context:**

- Include memory headers showing related_docs, para_section, and gigabrain_tags
- Cross-reference with discipline-specific documentation and testing frameworks
- Check memory/YYYY-MM-DD.md for recent testing session context

**Plugin Integration:**

- Utilize lossless-claw for maintaining testing session continuity
- Leverage OpenStinger for cross-session testing pattern recall
- Apply gigabrain automatic capture for test results and issues found

## Discipline Page Inventory

Test all 50+ discipline pages systematically:

### Engineering Disciplines (8 pages)

- 00825 - Architectural Engineering
- 00835 - Chemical Engineering
- 00850 - Civil Engineering
- 00855 - Geotechnical Engineering
- 00860 - Electrical Engineering
- 00870 - Mechanical Engineering
- 00871 - Process Engineering

### Director Roles (10 pages)

- 00876 - Directors
- 00880 - Board of Directors
- 00882 - Director Construction
- 00883 - Director Contracts
- 00884 - Director Engineering
- 00885 - Director HSE
- 00886 - Director Logistics
- 00887 - Director Sales
- 00888 - Director Procurement
- 00889 - Director Finance
- 00890 - Director Projects
- 00895 - Director Project

### Business Functions (33 pages)

- 00300 - Construction
- 00400 - Contracts
- 00425 - Contracts Pre Award
- 00435 - Contracts Post Award
- 00800 - Design
- 00872 - Developer
- 00875 - Sales
- 00877 - Sundry
- 00900 - Document Control
- 01000 - Environmental
- 01100 - Ethics
- 01200 - Finance
- 01300 - Governance
- 01400 - Health
- 01500 - Human Resources
- 01600 - Local Content
- 01700 - Logistics
- 01750 - Legal
- 01800 - Operations
- 01850 - Other Parties
- 01900 - Procurement
- 02000 - Project Controls
- 02025 - Quantity Surveying
- 02035 - Scheduling
- 02050 - Information Technology
- 02075 - Inspection
- 02100 - Public Relations
- 02200 - Quality Assurance
- 02250 - Quality Control
- 02400 - Safety
- 02500 - Security
- 03000 - Landscaping

## Testing Framework Structure

### Phase 1: Documentation Review & Setup

```
For each discipline page [DISCIPLINE_CODE]:

1. Access the documentation file:
   docs/disciplines/[DISCIPLINE_CODE]/[DISCIPLINE_CODE]-[DISCIPLINE_NAME]-page-documentation.md

2. Extract testing requirements:
   - State buttons present and functional
   - Modal buttons by state (Agents/Upserts/Workspace)
   - Logout functionality location and implementation
   - Chatbot configuration and features
   - Button positioning and sizing
   - Background image presence and path
   - Modal integration patterns
   - CSS classes and styling

3. Prepare test environment:
   - Ensure user is logged in
   - Navigate to discipline page URL
   - Verify page loads without errors
   - Confirm background image loads
```

### Phase 2: State Button Testing

```
For each state button documented:

1. Locate state button in navigation:
   - Verify button exists with correct label
   - Check button positioning (documented location)
   - Confirm button is clickable

2. Click state button:
   - Verify state change occurs
   - Check for loading animations
   - Confirm button becomes "active" state

3. Validate modal button grid appears:
   - Verify grid layout matches documentation
   - Check button count and arrangement
   - Confirm button labels match documented labels
   - Validate modal IDs are correct
```

### Phase 3: Modal Button Testing

```
For each modal button in the grid:

1. Verify button properties:
   - Check button label matches documentation
   - Confirm modal ID is correct
   - Validate button positioning in grid
   - Ensure button is clickable

2. Click modal button:
   - Verify modal opens without errors
   - Check modal title matches documentation
   - Confirm modal content loads properly
   - Test modal close functionality

3. Error checking:
   - Monitor browser console for JavaScript errors
   - Verify no broken images or links
   - Check for proper error handling
```

### Phase 4: Chatbot Testing

```
For each discipline page with documented chatbot:

1. Locate chatbot component:
   - Verify chatbot is visible on page
   - Check welcome message matches documentation
   - Confirm theme colors are applied

2. Test basic functionality:
   - Verify chatbot accepts input
   - Check response generation works
   - Confirm conversation history is maintained
   - Test example queries if provided

3. Advanced features:
   - Verify HITL configuration if documented
   - Check document count display
   - Confirm citations functionality
   - Test conversation export if available
```

### Phase 5: Logout Functionality Testing

```
For each discipline page:

1. Locate logout button:
   - Verify position matches documentation
   - Check button styling and icon
   - Confirm button is accessible

2. Test logout functionality:
   - Click logout button
   - Verify logout process initiates
   - Confirm user is redirected appropriately
   - Check for proper session cleanup
```

### Phase 6: Visual & Layout Testing

```
For each discipline page:

1. Background image validation:
   - Verify image loads correctly
   - Check image positioning and sizing
   - Confirm no broken image links

2. Layout consistency:
   - Verify button positioning matches documentation
   - Check responsive behavior
   - Confirm proper spacing and alignment

3. Accessibility testing:
   - Verify keyboard navigation works
   - Check focus indicators
   - Confirm screen reader compatibility
```

### Phase 7: Error Detection & Reporting

```
Throughout testing:

1. JavaScript error monitoring:
   - Log all console errors
   - Capture network request failures
   - Record unhandled exceptions

2. Functional error detection:
   - Identify broken buttons or links
   - Report missing modals or components
   - Flag performance issues

3. Visual regression detection:
   - Compare layouts against documentation
   - Report styling inconsistencies
   - Flag missing or incorrect elements
```

## Automated Testing Script Structure

```
# OpenClaw Testing Script Template

const disciplinePages = [
  { code: '00825', name: 'architectural', path: '/00825-architectural' },
  { code: '00835', name: 'chemical-engineering', path: '/00835-chemical-engineering' },
  // ... all 50+ discipline pages
];

async function runComprehensiveTesting() {
  const results = {
    passed: [],
    failed: [],
    errors: [],
    warnings: []
  };

  for (const discipline of disciplinePages) {
    console.log(`Testing ${discipline.code} - ${discipline.name}`);

    try {
      // Phase 1: Load documentation
      const docContent = await loadDocumentation(discipline.code, discipline.name);

      // Phase 2: Navigate to page
      await navigateToPage(discipline.path);

      // Phase 3: Run all test phases
      const testResult = await runFullTestSuite(discipline, docContent);

      if (testResult.passed) {
        results.passed.push(discipline);
      } else {
        results.failed.push({ ...discipline, issues: testResult.issues });
      }

    } catch (error) {
      results.errors.push({ ...discipline, error: error.message });
    }
  }

  return results;
}
```

## Test Result Reporting Format

```
# Discipline Page Testing Results

## Summary
- Total Pages Tested: 50+
- Passed: X pages
- Failed: Y pages
- Errors: Z pages

## Detailed Results by Discipline

### ✅ PASSED DISCIPLINES
- 00825-architectural: All tests passed
- 00835-chemical-engineering: All tests passed

### ❌ FAILED DISCIPLINES
- 00850-civil-engineering:
  - Issue: Modal button "Correspondence Reply" not clickable
  - Issue: Background image failed to load
  - Issue: JavaScript error in console

### ⚠️  ERRORS
- 01900-procurement:
  - Error: Page failed to load completely
  - Error: Network timeout during testing

## Common Issues Found
1. Modal loading errors (X occurrences)
2. Button positioning issues (Y occurrences)
3. Chatbot configuration problems (Z occurrences)

## Recommendations
1. Fix modal loading issues in affected disciplines
2. Update button positioning for consistency
3. Review chatbot configurations
```

## Quality Assurance Checklist

### Pre-Testing Setup

- [ ] User account is logged in and authenticated
- [ ] Browser is updated to latest version
- [ ] JavaScript console is clear
- [ ] Network tab shows no errors
- [ ] Browser developer tools are open

### Testing Environment

- [ ] Test on multiple browsers (Chrome, Firefox, Safari, Edge)
- [ ] Test on different screen sizes (desktop, tablet, mobile)
- [ ] Test with different user roles/permissions
- [ ] Test with slow network conditions
- [ ] Test with JavaScript disabled (graceful degradation)

### Post-Testing Validation

- [ ] All test results are documented
- [ ] Screenshots captured for visual issues
- [ ] Console logs reviewed for errors
- [ ] Network requests analyzed for failures
- [ ] Performance metrics recorded

## Integration with Gigabrain Memory System

### Automatic Knowledge Capture

- Test results automatically tagged with `discipline-testing-results`
- Issues found captured with `bug-reports` and `ui-issues` tags
- Successful patterns stored with `testing-methodologies` tags
- Performance metrics tagged with `performance-analysis`

### Cross-Session Learning

- OpenStinger integration for similar issue pattern recognition
- Lossless-claw for maintaining testing session context
- Gigabrain for automatic test case generation based on past results

### Memory-Enhanced Testing

- Reference previous test results for regression detection
- Use stored testing patterns for efficient validation
- Leverage organizational knowledge for comprehensive coverage

## Success Metrics

### Functional Completeness

- **100%** of documented state buttons functional
- **100%** of documented modal buttons clickable
- **100%** of documented chatbots operational
- **100%** of documented logout functionality working

### Error-Free Operation

- **0** JavaScript console errors
- **0** broken images or links
- **0** modal loading failures
- **0** navigation or routing errors

### Visual Consistency

- **100%** background images loading correctly
- **100%** button positioning matching documentation
- **100%** responsive layout behavior
- **100%** accessibility compliance

## Troubleshooting Guide

### Common Issues and Solutions

#### Modal Not Loading

```
Symptom: Clicking modal button shows no response
Solution:
1. Check modal ID matches documentation
2. Verify modal component is imported
3. Check browser console for JavaScript errors
4. Confirm modal trigger event is properly bound
```

#### Chatbot Not Responding

```
Symptom: Chatbot input field not accepting text
Solution:
1. Verify chatbot component is mounted
2. Check API endpoints are accessible
3. Confirm authentication tokens are valid
4. Review chatbot configuration in documentation
```

#### State Button Not Working

```
Symptom: Clicking state button doesn't change view
Solution:
1. Check state management implementation
2. Verify button click handlers are bound
3. Confirm state values match documentation
4. Check for CSS interference with button clicks
```

#### Background Image Not Loading

```
Symptom: Page shows without background image
Solution:
1. Verify image path in documentation
2. Check image file exists in assets
3. Confirm CSS background-image property
4. Test image URL accessibility
```

## Version History

- **v1.0** (2026-03-26): Initial comprehensive testing framework
- Created systematic testing approach for all 50+ discipline pages
- Integrated OpenClaw memory system with gigabrain tags
- Included detailed testing phases and error reporting
- Added troubleshooting guide and success metrics

## Related Resources

- [Discipline Page Documentation Template](docs/templates/disciplines/page-documentation-template.md)
- [OpenClaw Memory System Template](docs/templates/openclaw/prompt-template-openclaw.md)
- [UI Testing Framework](docs_construct_ai/para/pages/codebase/ui-testing/)
- [Modal Testing Guidelines](docs_construct_ai/para/pages/codebase/modal-testing/)
- [Chatbot Integration Testing](docs_construct_ai/para/pages/codebase/chatbot-testing/)

---

**Execute this comprehensive testing framework using OpenClaw with full memory system integration to validate all 50+ discipline pages against their documentation specifications.**

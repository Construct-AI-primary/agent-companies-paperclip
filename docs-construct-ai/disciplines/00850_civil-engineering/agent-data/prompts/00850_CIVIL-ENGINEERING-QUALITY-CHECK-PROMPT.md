---
title: 00850 Civil Engineering Quality Check Prompt
description: Systematic quality check for Civil Engineering Document Generator button visibility issues
version: 1.0
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/prompts
gigabrain_tags: disciplines, 00850_civil-engineering, quality-check, troubleshooting, agent-state, button-visibility, modal-integration
openstinger_context: quality-assurance, troubleshooting, agent-state-diagnosis, modal-integration-testing
last_updated: 2026-03-27
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/prompts/00850_CIVIL-DOCUMENTATION-WORKFLOW-PROMPT.md
  - docs_construct_ai/disciplines/00850_civil-engineering/pages/00850_civil_engineering_page.md
  - docs_construct_ai/disciplines/00850_civil-engineering/implementation/00850_CIVIL_ENGINEERING_WORKFLOW_SYSTEM_IMPLEMENTATION.md
  - docs_construct_ai/client/src/pages/00850-civil-engineering/
---

# 00850 Civil Engineering Quality Check Prompt

## Overview

This specialized quality check prompt provides a systematic troubleshooting framework for diagnosing issues with the Civil Engineering Document Generator button visibility. Use this prompt when the "Document Generator" button fails to appear on the civil engineering page despite being in agent state.

## Quality Check Framework

### 📋 Systematic Troubleshooting Checklist

Use this checklist to methodically diagnose the Document Generator button visibility issue:

#### **Phase 1: Environment & Build Verification**
- [ ] **Build Status**: Confirm successful rebuild completion and no build errors
- [ ] **File Integrity**: Verify all workflow system files are present and correctly placed
- [ ] **Dependencies**: Check that all required React components and hooks are properly imported
- [ ] **Console Errors**: Inspect browser console for JavaScript errors or warnings
- [ ] **Network Requests**: Verify no failed API calls or resource loading issues

#### **Phase 2: Agent State Detection Analysis**
- [ ] **Agent State Hook**: Verify `useAgentState` hook is properly implemented and imported
- [ ] **Hook Integration**: Confirm hook is correctly integrated in the civil engineering page component
- [ ] **State Logic**: Test the boolean return value of the agent state detection
- [ ] **State Persistence**: Check if agent state persists across page reloads and navigation
- [ ] **State Debugging**: Add console logging to verify agent state detection is working

#### **Phase 3: Component Integration Verification**
- [ ] **Button Rendering**: Confirm conditional rendering logic `{isAgentState && <button>}` is correct
- [ ] **Component Structure**: Verify the button is properly nested within the page component
- [ ] **Styling Issues**: Check for CSS that might hide the button (display: none, visibility: hidden)
- [ ] **DOM Presence**: Use browser dev tools to inspect if button element exists in DOM
- [ ] **Event Handlers**: Verify onClick handler is properly attached and functional

#### **Phase 4: Modal System Testing**
- [ ] **Modal Import**: Confirm CivilEngineeringWorkflow component is properly imported
- [ ] **Modal State**: Test modal open/close state management
- [ ] **Modal Rendering**: Verify modal appears when button is clicked (if button is visible)
- [ ] **Modal Dependencies**: Check that all modal-required components are available
- [ ] **Modal Styling**: Ensure modal overlay and content are properly styled

#### **Phase 5: Workflow System Validation**
- [ ] **Workflow Components**: Verify all 13 workflow cards and dashboard components exist
- [ ] **Agent Coordination**: Test DevForge AI, QualityForge AI, and Loopy AI integration points
- [ ] **Data Flow**: Confirm workflow state management and card interactions work
- [ ] **Error Boundaries**: Check for React error boundaries that might hide the modal
- [ ] **Performance Issues**: Monitor for slow rendering that might delay button appearance

#### **Phase 6: Cross-Platform Compatibility**
- [ ] **Browser Compatibility**: Test across different browsers (Chrome, Firefox, Safari, Edge)
- [ ] **Device Responsiveness**: Verify button appears on mobile and tablet devices
- [ ] **Screen Size**: Test on various screen resolutions and zoom levels
- [ ] **Touch Interactions**: Confirm touch events work properly on mobile devices
- [ ] **Offline Mode**: Test button visibility when network connectivity is limited

### 📊 Diagnostic Testing Protocol

**Use this systematic testing approach:**

```
## Quality Check Session - [Date/Time]

### Pre-Test Setup
- [ ] Clear browser cache and local storage
- [ ] Ensure clean build (delete node_modules and rebuild if needed)
- [ ] Verify user is logged in and has appropriate permissions
- [ ] Confirm agent state can be activated (test with known working scenario)

### Test Case 1: Agent State Detection
**Objective**: Verify agent state hook functionality
**Steps**:
1. Navigate to civil engineering page
2. Open browser developer tools console
3. Add temporary logging: `console.log('Agent State:', isAgentState)`
4. Activate agent state (if available)
5. Check console output for state changes
**Expected Result**: Console shows agent state changes from false to true
**Actual Result**: [Document findings]

### Test Case 2: Component Rendering
**Objective**: Verify conditional rendering logic
**Steps**:
1. Inspect page source in browser dev tools
2. Search for "Document Generator" text
3. Check if button element exists in DOM
4. Verify CSS computed styles for visibility
5. Test with different agent state values
**Expected Result**: Button element present when agent state is true
**Actual Result**: [Document findings]

### Test Case 3: Modal Integration
**Objective**: Test modal system functionality
**Steps**:
1. Temporarily make button always visible (remove conditional)
2. Click button to test modal opening
3. Verify modal content loads correctly
4. Test modal close functionality
5. Check for JavaScript errors during modal operations
**Expected Result**: Modal opens and closes properly
**Actual Result**: [Document findings]

### Test Case 4: Import/Export Verification
**Objective**: Verify all component imports are working
**Steps**:
1. Check import statements in civil engineering page
2. Verify file paths are correct
3. Test individual component imports
4. Check for TypeScript compilation errors
5. Verify webpack build includes all components
**Expected Result**: All imports resolve successfully
**Actual Result**: [Document findings]

### Test Case 5: State Management Testing
**Objective**: Verify React state management
**Steps**:
1. Add React DevTools to browser
2. Monitor component state changes
3. Test state updates trigger re-renders
4. Verify state persistence across interactions
5. Check for state conflicts or race conditions
**Expected Result**: State management works correctly
**Actual Result**: [Document findings]

### Post-Test Analysis
**Root Cause Identified**: [Summary of findings]
**Solution Implemented**: [Steps taken to fix]
**Verification**: [How fix was tested and confirmed]
**Recommendations**: [Preventive measures for future]
```

## Core Template Structure

```
[CIVIL ENGINEERING QUALITY CHECK REQUEST]

Using the Construct AI memory system with Gigabrain for 00850 Civil Engineering quality check:

**PARA Navigation:**
- Access docs_construct_ai/para/pages/disciplines/00850_civil-engineering/
- Reference implementation docs: docs_construct_ai/disciplines/00850_civil-engineering/implementation/
- Check workflow system: docs_construct_ai/client/src/pages/00850-civil-engineering/

**Gigabrain Search:**
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "quality-check", "troubleshooting"
- Filter by tags: "agent-state", "button-visibility", "modal-integration", "component-rendering"

**Memory Context:**
- Include memory headers showing quality check patterns
- Cross-reference with existing civil engineering implementations
- Check memory/YYYY-MM-DD.md for recent quality check procedures

**Quality Check Domain Context:**
- Reference systematic troubleshooting checklist above
- Apply diagnostic testing protocol for agent state issues
- Follow component integration verification procedures
- Use cross-platform compatibility testing methods

**Knowledge Integration:**
- Follow cross-references in memory headers
- Identify patterns from similar quality check procedures
- Build on established troubleshooting organizational knowledge
- Ensure systematic diagnosis before implementing fixes

[SPECIFIC QUALITY CHECK REQUIREMENTS OR SYMPTOMS]
```

## Quality Check Use Case Templates

### Agent State Visibility Issue
```
Diagnose Document Generator button not appearing in agent state:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/00850_civil-engineering/pages/00850_civil_engineering_page.md
- Reference implementation: docs_construct_ai/client/src/pages/00850-civil-engineering/
- Check agent state hooks: docs_construct_ai/client/src/hooks/

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "agent-state", "button-visibility"
- Filter by tags: "conditional-rendering", "hook-integration", "state-management"

Memory Context:
- Include memory headers with agent state troubleshooting patterns
- Cross-reference with similar conditional rendering issues
- Reference historical agent state implementation problems

Quality Check Domain Context:
- Apply Phase 2: Agent State Detection Analysis from checklist
- Use Test Case 1: Agent State Detection from protocol
- Follow systematic troubleshooting approach
- Implement diagnostic logging and testing

Provide comprehensive diagnosis with:
- Agent state detection verification steps
- Component conditional rendering analysis
- Browser console error checking
- Step-by-step resolution recommendations
- Preventive measures for future occurrences
```

### Modal Integration Failure
```
Diagnose Civil Engineering Workflow modal not opening:

PARA Navigation:
- Access docs_construct_ai/para/pages/disciplines/00850_civil-engineering/pages/00850_civil_engineering_page.md
- Reference workflow components: docs_construct_ai/client/src/pages/00850-civil-engineering/components/
- Check modal implementation patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "modal-integration", "workflow-system"
- Filter by tags: "react-modal", "component-imports", "event-handling"

Memory Context:
- Include memory headers with modal integration troubleshooting
- Cross-reference with existing modal implementations
- Reference historical modal system issues

Quality Check Domain Context:
- Apply Phase 3: Component Integration Verification
- Use Test Case 3: Modal Integration from protocol
- Follow import/export verification procedures
- Test modal state management and rendering

Provide modal diagnosis with:
- Component import verification steps
- Modal state management analysis
- Event handler functionality testing
- React component lifecycle verification
- Modal styling and positioning checks
```

### Build/Compilation Issues
```
Diagnose Civil Engineering workflow build failures:

PARA Navigation:
- Access docs_construct_ai/client/src/pages/00850-civil-engineering/
- Reference build configuration: docs_construct_ai/webpack.config.js
- Check TypeScript compilation settings

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "build-errors", "compilation"
- Filter by tags: "typescript", "webpack", "module-resolution"

Memory Context:
- Include memory headers with build troubleshooting patterns
- Cross-reference with similar compilation issues
- Reference historical build system problems

Quality Check Domain Context:
- Apply Phase 1: Environment & Build Verification
- Check file integrity and dependency resolution
- Verify TypeScript compilation and module imports
- Test webpack build process and asset generation

Provide build diagnosis with:
- Compilation error analysis and resolution
- Dependency conflict identification
- Module resolution troubleshooting
- Build optimization recommendations
- Development environment verification
```

### Cross-Platform Compatibility Issues
```
Diagnose Document Generator button issues across platforms:

PARA Navigation:
- Access docs_construct_ai/client/src/pages/00850-civil-engineering/
- Reference mobile implementation: docs_construct_ai/ConstructAI-mobile/src/screens/civil-engineering/
- Check responsive design patterns

Gigabrain Search:
- Search gigabrain tags for "disciplines, 00850_civil-engineering", "cross-platform", "responsive-design"
- Filter by tags: "mobile-compatibility", "touch-interactions", "css-media-queries"

Memory Context:
- Include memory headers with cross-platform troubleshooting
- Cross-reference with mobile implementation patterns
- Reference historical platform compatibility issues

Quality Check Domain Context:
- Apply Phase 6: Cross-Platform Compatibility testing
- Test across different browsers and devices
- Verify responsive design implementation
- Check touch interaction compatibility

Provide platform diagnosis with:
- Browser compatibility testing results
- Device responsiveness verification
- Touch interaction functionality checks
- CSS media query effectiveness analysis
- Platform-specific optimization recommendations
```

## Quality Check-Specific Gigabrain Tags

### Primary Quality Check Tags
```
disciplines, 00850_civil-engineering, quality-check
disciplines, 00850_civil-engineering, troubleshooting
disciplines, 00850_civil-engineering, agent-state
disciplines, 00850_civil-engineering, button-visibility
disciplines, 00850_civil-engineering, modal-integration
```

### Diagnostic Process Tags
```
quality-check, systematic-troubleshooting
quality-check, diagnostic-testing
quality-check, component-verification
quality-check, state-management
quality-check, cross-platform-compatibility
```

### Issue-Specific Tags
```
troubleshooting, agent-state-detection
troubleshooting, conditional-rendering
troubleshooting, component-imports
troubleshooting, modal-system
troubleshooting, build-compilation
```

## Quality Check-Specific PARA Navigation

### Primary Quality Check Paths
```
docs_construct_ai/disciplines/00850_civil-engineering/prompts/
docs_construct_ai/disciplines/00850_civil-engineering/implementation/
docs_construct_ai/client/src/pages/00850-civil-engineering/
docs_construct_ai/client/src/hooks/
docs_construct_ai/ConstructAI-mobile/src/screens/civil-engineering/
```

### Related Quality Check Paths
```
docs_construct_ai/codebase/debugging/
docs_construct_ai/codebase/fixes/
docs_construct_ai/codebase/troubleshooting/
docs_construct_ai/codebase/testing/
```

## Quality Check-Specific Memory Headers

### Standard Quality Check Memory Header
```yaml
---
title: [Quality Check Title]
description: [Brief description of quality check issue and scope]
version: [Version number]
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/prompts
gigabrain_tags: disciplines, 00850_civil-engineering, quality-check, [issue-type], [diagnostic-area]
openstinger_context: quality-assurance, troubleshooting, [specific-issue-context]
last_updated: [YYYY-MM-DD]
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/prompts/00850_CIVIL-DOCUMENTATION-WORKFLOW-PROMPT.md
  - [Related implementation docs]
  - [Related troubleshooting docs]
---
```

### Diagnostic Session Memory Header
```yaml
---
title: [Diagnostic Session Title]
description: [Session scope and testing methodology]
version: [Version number]
memory_layer: durable_knowledge
para_section: docs_construct_ai/disciplines/00850_civil-engineering/implementation
gigabrain_tags: disciplines, 00850_civil-engineering, quality-check, diagnostics, [component-area]
openstinger_context: systematic-testing, root-cause-analysis, issue-resolution
last_updated: [YYYY-MM-DD]
related_docs:
  - docs_construct_ai/disciplines/00850_civil-engineering/pages/00850_civil_engineering_page.md
  - [Related test cases]
  - [Related fix implementations]
---
```

## Quality Check Best Practices

### Systematic Diagnosis Approach
1. **Reproduce the Issue**: Establish consistent reproduction steps
2. **Isolate the Problem**: Use systematic testing to narrow down root cause
3. **Check Fundamentals**: Verify environment, build, and basic functionality first
4. **Test Incrementally**: Build up from simple to complex testing scenarios
5. **Document Everything**: Record all findings, tests performed, and results

### Agent State Troubleshooting
1. **Hook Verification**: Test `useAgentState` hook independently
2. **State Logging**: Add comprehensive console logging for debugging
3. **Conditional Testing**: Temporarily remove conditionals to isolate rendering issues
4. **State Persistence**: Verify state maintains across page interactions
5. **Cross-Tab Testing**: Test agent state synchronization across browser tabs

### Component Integration Testing
1. **Import Verification**: Test all component imports individually
2. **Dependency Checking**: Verify all required dependencies are available
3. **Render Testing**: Test components in isolation before integration
4. **Prop Validation**: Ensure all required props are passed correctly
5. **Error Boundary Testing**: Check for error boundaries hiding issues

### Modal System Diagnosis
1. **State Management**: Verify modal open/close state logic
2. **Component Loading**: Test modal content loading and rendering
3. **Styling Conflicts**: Check for CSS conflicts affecting modal display
4. **Event Handling**: Verify click handlers and user interactions
5. **Performance Issues**: Monitor for slow rendering affecting user experience

## Quality Check Integration Checklist

### For Every Quality Check Request
- [ ] **Issue Description**: Clear description of symptoms and expected behavior
- [ ] **Reproduction Steps**: Step-by-step instructions to reproduce the issue
- [ ] **Environment Details**: Browser, device, build version, and user state information
- [ ] **PARA Navigation**: Civil engineering discipline paths and related areas
- [ ] **Gigabrain Search**: Quality check and troubleshooting specific tags
- [ ] **Memory Context**: Quality check patterns and historical issue resolution
- [ ] **Systematic Testing**: Follow the 6-phase troubleshooting checklist
- [ ] **Diagnostic Protocol**: Use the 5-test-case diagnostic testing protocol
- [ ] **Root Cause Analysis**: Identify underlying cause, not just symptoms
- [ ] **Solution Verification**: Test fixes thoroughly before implementation

### For Complex Quality Check Issues
- [ ] **Multi-Component Analysis**: Test interactions between multiple components
- [ ] **State Management Review**: Verify React state flow and updates
- [ ] **Performance Monitoring**: Check for performance issues affecting functionality
- [ ] **Cross-Browser Testing**: Verify issue occurs across different browsers
- [ ] **User State Verification**: Confirm user permissions and session state
- [ ] **Network Analysis**: Check for API failures or connectivity issues
- [ ] **Build System Review**: Verify compilation and bundling processes
- [ ] **Dependency Analysis**: Check for version conflicts or missing packages

## Quality Check Success Metrics

### Diagnostic Effectiveness
- **Issue Resolution Time**: Average time to identify root cause (< 2 hours for common issues)
- **First-Time Fix Rate**: Percentage of issues resolved on first diagnostic attempt (> 80%)
- **False Positive Rate**: Percentage of incorrect diagnoses (< 5%)
- **Documentation Coverage**: Percentage of issues with complete diagnostic records (100%)

### Process Efficiency
- **Testing Completion Rate**: Percentage of checklist items completed per session (> 95%)
- **Diagnostic Accuracy**: Percentage of correct root cause identifications (> 90%)
- **Solution Implementation**: Average time from diagnosis to working fix (< 4 hours)
- **Preventive Measures**: Percentage of fixes with preventive recommendations (> 70%)

### Quality Improvement
- **Recurring Issue Reduction**: Year-over-year reduction in similar issues (> 50%)
- **Knowledge Base Growth**: Number of new diagnostic patterns documented quarterly (> 10)
- **Team Proficiency**: Average diagnostic skill improvement per team member (> 20%)
- **System Reliability**: Reduction in production issues requiring quality checks (< 30%)

## Quality Check Troubleshooting

### If Agent State Detection Fails
```
Request: "Deepen agent state diagnosis by checking hook implementation, state persistence, and conditional rendering logic. Add comprehensive logging and test state changes systematically."
```

### If Component Rendering Issues Persist
```
Specify: "Focus on component integration by verifying imports, dependencies, and DOM presence. Test component isolation and check for CSS/styling conflicts affecting visibility."
```

### If Modal System Malfunctions
```
Clarify: "Investigate modal integration by testing state management, component loading, and event handling. Verify modal dependencies and check for React error boundaries."
```

### If Build/Compilation Errors Occur
```
Verify: "Analyze build system by checking TypeScript compilation, webpack configuration, and module resolution. Test individual component imports and dependency resolution."
```

## Version History

- **v1.0** (2026-03-27): Initial Civil Engineering quality check prompt creation
- Comprehensive 6-phase troubleshooting checklist for systematic diagnosis
- 5-test-case diagnostic testing protocol with detailed procedures
- Agent state, component integration, modal system, and cross-platform testing
- Quality check-specific gigabrain tags and PARA navigation
- Best practices for systematic diagnosis and issue resolution
- Success metrics for diagnostic effectiveness and process efficiency

## Related Resources

- [Civil Engineering Workflow Prompt](docs_construct_ai/disciplines/00850_civil-engineering/prompts/00850_CIVIL-DOCUMENTATION-WORKFLOW-PROMPT.md)
- [Civil Engineering Implementation](docs_construct_ai/disciplines/00850_civil-engineering/implementation/00850_CIVIL_ENGINEERING_WORKFLOW_SYSTEM_IMPLEMENTATION.md)
- [Civil Engineering Page](docs_construct_ai/disciplines/00850_civil-engineering/pages/00850_civil_engineering_page.md)
- [Quality Check Debugging](docs_construct_ai/codebase/debugging/)
- [System Troubleshooting](docs_construct_ai/codebase/troubleshooting/)
- [Testing Framework](docs_construct_ai/codebase/testing/)
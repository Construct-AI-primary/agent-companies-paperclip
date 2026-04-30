---
memory_layer: durable_knowledge
para_section: pages/accordion-testing
gigabrain_tags: testing, accordion-testing, hermes-agent, navigation, supabase-integration, context-provider, state-management, accessibility, error-handling, caching, event-listeners
openstinger_context: accordion-testing-documentation
last_updated: 2026-04-02
---

# Accordion Production Testing Documentation

## Accordion System Overview

The Accordion navigation component is a critical UI element that provides hierarchical navigation for the Hermes agent application. It supports:

- **Hierarchical Navigation**: Multi-level sections and subsections with expandable content
- **Organization-Based Templates**: Dynamic menu structure based on organization type (EPCM, Contractors, Judicial, etc.)
- **Collaborative Features**: Integration with organization collaborations for shared sections
- **Supabase Integration**: Real-time data fetching with fallback mechanisms
- **State Management**: React Context + useReducer for complex state handling
- **Accessibility**: ARIA attributes and keyboard navigation support
- **Caching**: Client-side caching with TTL for performance optimization

### Key Architecture Components

1. **Global Data Management**: Singleton pattern for accordion data to prevent multiple API calls
2. **Template System**: Organization-specific menu templates with inheritance
3. **Collaboration Support**: Multi-organization navigation sharing
4. **Failure Resilience**: Graceful fallback to cached data when Supabase is unavailable
5. **Performance Optimization**: Lazy loading, caching, and efficient re-rendering

## Source Files

### Main Component
- **Path**: `/client/src/modules/accordion/00200-accordion-component.js`
- **Purpose**: Main React component implementing the accordion UI
- **Key Features**: Global data singleton, event handling, recursive subsection rendering

### Context & State Management
- **Path**: `/client/src/modules/accordion/context/00200-accordion-context.js`
- **Purpose**: React Context provider with useReducer for state management
- **Actions**: TOGGLE_MENU, CLOSE_MENU, TOGGLE_SECTION, SET_LOADING, SET_COMPONENT_LOADED

### Manager
- **Path**: `/client/src/modules/accordion/00200-accordion-manager.js`
- **Purpose**: Class-based manager for initialization and configuration
- **Responsibilities**: Data processing, settings integration, lifecycle management

### Supabase Integration
- **Path**: `/client/src/modules/accordion/00200-accordion-component-pure-supabase.js`
- **Path**: `/server/src/routes/accordion-sections-routes.js`
- **Purpose**: Server-side API endpoints and client-side data fetching
- **Features**: Multi-organization templates, collaborative sections, organization mappings

### API Endpoint
- **Path**: `/server/src/routes/accordion-sections-routes.js`
- **Endpoints**:
  - `GET /api/accordion-sections` - Main data endpoint
  - `GET /api/accordion-template-mappings` - Template mappings
  - `POST /api/accordion-template-mappings` - Update mappings
  - `GET /api/organizations` - Organization list
  - `GET /api/organizations/:id/database-config` - DB config

### Additional Files
- **Fallback Data**: `/client/src/common/js/data/accordion-fallback-data.js`
- **State Hooks**: `/client/src/modules/accordion/hooks/00200-accordion-state.js`
- **Cache Hooks**: `/client/src/modules/accordion/hooks/00200-accordion-cache.js`

## Feature Areas to Test

### Accordion Toggle Button
- Button visibility and accessibility
- Click/touch/keyboard interaction
- Active state indication
- Loading states

### Section Navigation
- Section headers and expand/collapse functionality
- Multiple section expansion support
- Section ordering and display priority
- Section depth and nesting limits

### Subsection Navigation
- Subsection expand/collapse within sections
- Recursive subsection support
- Subsection content rendering
- Depth limits and performance

### Links and Buttons
- Link navigation and URL transformation
- Click event handling
- Link visibility based on permissions
- External vs internal navigation

### Supabase Connections
- API endpoint availability
- Query parameter handling
- Authentication and headers
- Error response handling
- Organization filtering

### Context Provider State Management
- State initialization and persistence
- Action dispatching (TOGGLE_MENU, TOGGLE_SECTION, etc.)
- State updates across component tree
- Component loading states

### Caching and Performance
- Client-side cache validation
- Cache expiration and refresh
- Multiple component instances
- Memory usage optimization

### Event Listeners
- Global config change listeners
- Click outside detection
- Navigation event handling
- Resize and orientation changes

### Fallback Data
- Emergency fallback activation
- Fallback data structure integrity
- Fallback vs live data switching
- User experience continuity

### Error Handling
- Network failure scenarios
- Supabase connection issues
- Invalid API responses
- Graceful degradation

### Organization Templates
- Template resolution by organization
- Template inheritance
- Section merging and deduplication
- Organization-specific configurations

### Collaborative Sections
- Multi-organization collaborations
- Shared section access
- Page precedence logic
- Collaboration data merging

## Testing Procedures

### Test 1: Basic Accordion Toggle Functionality
**Priority**: Critical
**Prerequisites**: Application loaded, user authenticated
**Test Data**: Any organization, any page
**Steps**:
1. Navigate to any application page
2. Locate the accordion toggle button (☰ icon)
3. Verify button is visible and accessible
4. Click the toggle button
5. Verify accordion menu expands/collapses
6. Test keyboard navigation (Tab, Space, Enter)
**Expected Results**:
- Toggle button visible with ☰ icon
- Menu opens/closes smoothly with animation
- ARIA attributes update correctly
- Focus management works properly
**Pass/Fail Criteria**: Menu toggles reliably
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:533-540`

### Test 2: Section Expansion and Collapse
**Priority**: Critical
**Prerequisites**: Accordion menu open
**Test Data**: Organization with multiple sections (e.g., EPCM template)
**Steps**:
1. Open accordion menu
2. Click on any section header
3. Verify section expands and shows links
4. Click same section header to collapse
5. Verify section collapses and hides links
6. Test multiple sections can be open simultaneously
7. Check section ordering matches display_order
**Expected Results**:
- Sections expand/collapse with animations
- Active sections tracked correctly
- Multiple sections can be expanded
- ARIA expanded attributes update
**Pass/Fail Criteria**: All sections expand/collapse properly
**Links to Sources**: `/client/src/modules/accordion/context/00200-accordion-context.js:54-74`

### Test 3: Link Navigation and URL Transformation
**Priority**: Critical
**Prerequisites**: Section expanded with links visible
**Test Data**: Links with both legacy URLs (#) and clean URLs (/)
**Steps**:
1. Expand a section with links
2. Click on a link with clean URL (/procurement)
3. Verify navigation occurs
4. Return and click link with legacy URL (transformLegacyUrl handles)
5. Verify URL transformation and navigation
6. Test links are filtered by permissions
7. Verify accordion closes after navigation
**Expected Results**:
- Navigation works for all link types
- URLs transformed correctly
- Menu closes after clicking links
- Permissions respected
**Pass/Fail Criteria**: All links navigate correctly
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:333-392`

### Test 4: Supabase API Connectivity
**Priority**: Critical
**Prerequisites**: Network connection available, Supabase accessible
**Test Data**: Valid organization ID and name
**Steps**:
1. Monitor network requests in browser dev tools
2. Load page with accordion
3. Verify GET /api/accordion-sections call made
4. Check query parameters (sector, organization_id, organization_name)
5. Verify response contains sections array
6. Test with different organization types
7. Verify organization-specific templates applied
**Expected Results**:
- API call successful with 200 status
- Response contains valid sections data
- Organization templates resolved correctly
- Error handling for failed requests
**Pass/Fail Criteria**: API responds with correct data
**Links to Sources**: `/server/src/routes/accordion-sections-routes.js:1940-2079`

### Test 5: Fallback Data Activation
**Priority**: High
**Prerequisites**: Ability to simulate network failure or Supabase downtime
**Test Data**: Any organization
**Steps**:
1. Simulate Supabase API failure (network offline, 500 error)
2. Reload page or trigger accordion data refresh
3. Verify fallback data loads
4. Check fallback data structure matches expected format
5. Verify user can navigate using fallback menu
6. Test transition back to live data when connection restored
**Expected Results**:
- Fallback data loads without errors
- Emergency sections display correctly (Home, IT, etc.)
- User experience continues seamlessly
- Live data takes precedence when available
**Pass/Fail Criteria**: Application functions with fallback data
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:121-158`

### Test 6: Organization Template Resolution
**Priority**: High
**Prerequisites**: Multiple organization types available
**Test Data**: EPCM, Contractor, Judicial organizations
**Steps**:
1. Switch between different organization contexts
2. Verify accordion sections change appropriately
3. Check organization ID vs name resolution
4. Test template inheritance (minimal → master)
5. Verify section merging for collaborators
6. Test invalid organization handling
**Expected Results**:
- Templates resolve correctly by org type
- Sections match organization needs
- Inheritance works properly
- Collaborations merge sections appropriately
**Pass/Fail Criteria**: Correct templates for each organization
**Links to Sources**: `/server/src/routes/accordion-sections-routes.js:1684-1758`

### Test 7: State Management and Context
**Priority**: High
**Prerequisites**: Accordion menu interactions
**Test Data**: Any page with accordion
**Steps**:
1. Test simultaneous multiple section expansion
2. Verify menu closes on navigation
3. Check click-outside-to-close functionality
4. Test menu state persists during navigation
5. Verify context state updates trigger re-renders
6. Test component loading states
**Expected Results**:
- State changes reflected immediately in UI
- Context provider works across component tree
- Actions dispatch correctly
- Loading states shown appropriately
**Pass/Fail Criteria**: State management works reliably
**Links to Sources**: `/client/src/modules/accordion/context/00200-accordion-context.js:14-107`

### Test 8: Caching and Performance
**Priority**: Medium
**Prerequisites**: Multiple page loads or data refreshes
**Test Data**: Any organization with sections
**Steps**:
1. Load accordion data first time
2. Navigate to another page and back
3. Verify cached data used (no new API calls)
4. Test cache expiration (24hr TTL)
5. Force cache refresh and verify new API call
6. Monitor for memory leaks
7. Test with offline/online transitions
**Expected Results**:
- Data cached effectively
- Performance improved on subsequent loads
- Cache expires appropriately
- No memory leaks with extended use
**Pass/Fail Criteria**: Caching reduces API calls appropriately
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:25-30`

### Test 9: Accessibility and Keyboard Navigation
**Priority**: High
**Prerequisites**: Screen reader or keyboard-only access
**Test Data**: Full accordion structure
**Steps**:
1. Test Tab navigation through toggle button
2. Verify section headers accessible with keyboard
3. Test Space/Enter to expand/collapse sections
4. Check ARIA attributes (aria-expanded, aria-hidden)
5. Verify screen reader announcements
6. Test focus management after navigation
7. Check color contrast and visual indicators
**Expected Results**:
- All interactive elements keyboard accessible
- Screen readers announce state changes
- Focus management prevents getting lost
- ARIA attributes accurate and dynamic
**Pass/Fail Criteria**: WCAG AA compliance maintained
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:404-425`

### Test 10: Error Handling and Recovery
**Priority**: High
**Prerequisites**: Error scenarios simulatable
**Test Data**: Invalid API responses, network failures
**Steps**:
1. Test 404 API responses
2. Simulate timeout errors
3. Test invalid JSON responses
4. Verify error states don't break UI
5. Test recovery after errors
6. Check error logging
7. Verify fallback activation on errors
**Expected Results**:
- Errors handled gracefully without UI breakage
- Appropriate error messages shown
- Recovery mechanisms work
- User can continue navigating
**Pass/Fail Criteria**: No UI crashes on errors
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:105-159`

### Test 11: Subsection Recursive Rendering
**Priority**: Medium
**Prerequisites**: Sections with nested subsections (Procurement, IT)
**Test Data**: Deep nesting structures
**Steps**:
1. Navigate to section with multiple subsection levels
2. Expand top-level subsection
3. Verify nested subsections render
4. Test expanding multiple levels deep
5. Check maximum nesting handled properly
6. Verify depth-based styling applied
7. Test navigation from deeply nested links
**Expected Results**:
- All nesting levels render correctly
- Depth-based styling (margins, indentation)
- Navigation works from any depth
- Performance maintained with deep nesting
**Pass/Fail Criteria**: Deep subsections work properly
**Links to Sources**: `/client/src/modules/accordion/00200-accordion-component.js:395-481`

### Test 12: Multi-Organization Collaboration
**Priority**: Medium
**Prerequisites**: Multiple organizations with collaborations set up
**Test Data**: Collaborating organization pairs
**Steps**:
1. Access accordion with collaborating organizations
2. Verify shared sections appear
3. Test page precedence logic (host vs collaborator)
4. Check section deduplication
5. Verify shared sections respect permissions
6. Test collaboration data integration
7. Validate section ordering with collaborations
**Expected Results**:
- Collaborating sections merged correctly
- Page precedence rules applied
- No duplicate sections
- Proper ordering maintained
**Pass/Fail Criteria**: Collaboration features work seamlessly
**Links to Sources**: `/server/src/routes/accordion-sections-routes.js:1980-2047`

## API Response Format

### GET /api/accordion-sections

**Request Format**:
```http
GET /api/accordion-sections?sector=global&organization_id=uuid&organization_name=Test%20Org&active_only=true
Headers:
  x-organization-id: uuid
  x-organization-name: Test Org
  Authorization: Bearer <token>
```

**Success Response**:
```json
{
  "success": true,
  "sections": [
    {
      "id": "accordion-button-00100",
      "title": "Home",
      "display_order": 100,
      "sector": "global",
      "links": [
        {
          "title": "Home",
          "url": "/",
          "id": "home-link"
        }
      ],
      "subsections": {
        "subsection-00101": {
          "id": "subsection-00101",
          "title": "Dashboard",
          "links": []
        }
      }
    }
  ],
  "total": 15,
  "template_used": "master",
  "organization": {
    "id": "uuid",
    "name": "Test Organization"
  },
  "filters_applied": {
    "sector": "global",
    "organization_id": "uuid",
    "organization_name": "Test Organization",
    "active_only": true
  }
}
```

**Error Response**:
```json
{
  "success": false,
  "message": "Internal server error",
  "error": "Database connection failed"
}
```

## Error Reporting

If errors are encountered during testing, create error reports in `/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/accordion-errors-{timestamp}.md` with the following format:

```markdown
# Accordion Error Report - {timestamp}

## Error Details
- **Test Case**: [Test number and name]
- **Error Type**: [Network/API/State/UI/etc.]
- **Error Message**: [Exact error message]
- **Severity**: [Critical/High/Medium/Low]

## Environment
- **Browser**: [Browser and version]
- **OS**: [Operating system]
- **Organization**: [Test organization context]
- **URL**: [Page where error occurred]

## Steps to Reproduce
1. [Step by step reproduction]
2. [Include test data used]

## Expected vs Actual Behavior
- **Expected**: [What should happen]
- **Actual**: [What actually happened]

## Screenshots/Logs
[Attach screenshots, console logs, network requests]

## Additional Context
[Any additional information about the error]

## Resolution Status
- [ ] Open
- [ ] Investigation needed
- [ ] Fix identified
- [ ] Resolved
- [ ] Closed
```

## Implementation Notes

- **Global Data Management**: Uses singleton pattern to prevent duplicate API calls across component instances
- **Template Inheritance**: Supports hierarchical template inheritance (minimal → contractor → master)
- **Collaboration Logic**: Page precedence can be "host" or "collaborator" based on collaboration settings
- **Caching Strategy**: 24-hour TTL with manual refresh capabilities
- **Accessibility**: Full ARIA support with dynamic attribute updates
- **Error Boundaries**: Components include error boundaries for graceful failure handling

This comprehensive testing document ensures all accordion functionality is thoroughly validated before production deployment.
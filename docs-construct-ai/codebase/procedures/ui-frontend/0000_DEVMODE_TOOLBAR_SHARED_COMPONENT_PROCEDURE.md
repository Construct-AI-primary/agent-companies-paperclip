---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/ui-frontend
gigabrain_tags: procedures, ui-frontend, codebase, react, components
documentation
openstinger_context: operational-procedures, ui-frontend-practices
last_updated: 2026-03-30
related_docs:
  - codebase/procedures/ui-frontend/
---

# DevMode Toolbar Shared Component Procedure

## Overview
The DevModeToolbar is a shared development component that provides debugging, rule editing, and workflow testing capabilities across multiple modal components. This procedure outlines how to integrate and use the DevModeToolbar as a shared component.

## Purpose
- Provide consistent development tools across all agent modals
- Enable discipline-specific configuration and event handling
- Support workflow debugging and rule editing in development mode
- Maintain separation of concerns between modal logic and development tools

## Component Location
```
client/src/components/dev/DevModeToolbar.js
```

## Integration Steps

### 1. Import the Component
```javascript
import DevModeToolbar from '../dev/DevModeToolbar';
```

### 2. Add to Modal Render
Render the DevModeToolbar inside your modal component, passing the appropriate discipline:

```javascript
const MyModal = ({ discipline = '01700' }) => {
  // ... modal logic ...

  return (
    <div className="modal-content">
      {/* Your modal content */}
      <DevModeToolbar discipline={discipline} />
    </div>
  );
};
```

### 3. Dispatch Workflow Events
Dispatch discipline-specific workflow stage events from your modal's state change handlers:

```javascript
const handleStateChange = (newState) => {
  // ... existing logic ...

  // Dispatch workflow stage event
  const event = new CustomEvent(`${discipline.toLowerCase()}_workflow_stage_completed`, {
    detail: {
      stage: newState.currentStage,
      sessionId: newState.sessionId,
      timestamp: new Date().toISOString()
    }
  });
  document.dispatchEvent(event);
};
```

### 4. Dispatch Agent Message Events
Dispatch agent message events when agents communicate:

```javascript
const handleAgentMessage = (message) => {
  // ... existing logic ...

  // Dispatch agent message event
  const event = new CustomEvent(`${discipline.toLowerCase()}_agent_message`, {
    detail: {
      agentType: message.agentType,
      sessionId: message.sessionId,
      message: message.content,
      timestamp: new Date().toISOString()
    }
  });
  document.dispatchEvent(event);
};
```

## Supported Disciplines

### 01700 - Logistics
- **Event Prefix**: `logistics_`
- **Supported Stages**: chat, preview, documents, submit
- **Page Tabs**: agents, upserts, workspace

### 01900 - Procurement
- **Event Prefix**: `procurement_`
- **Supported Stages**: chat, preview, sow, appendix_a, appendix_b, appendix_c, appendix_d, appendix_e, appendix_f, handoff
- **Page Tabs**: (none currently defined)

## Configuration Structure

The DevModeToolbar uses a discipline-specific configuration object:

```javascript
const disciplineConfig = {
  '01700': {
    label: 'Logistics',
    stageEvent: 'logistics_workflow_stage_completed',
    agentEvent: 'logistics_agent_message',
    modalSelector: '.logistics-agent-content',
    pageSelector: '.logistics-page',
    tabMap: { /* stage to tab mapping */ },
    pageTabMap: { /* page tab mapping */ }
  },
  '01900': {
    label: 'Procurement',
    stageEvent: 'procurement_workflow_stage_completed',
    agentEvent: 'procurement_agent_message',
    modalSelector: '.procurement-agent-content',
    pageSelector: '.procurement-page',
    tabMap: { /* stage to tab mapping */ },
    pageTabMap: { /* page tab mapping */ }
  }
};
```

## Adding New Disciplines

To add support for a new discipline:

1. **Add Configuration**: Add a new entry to the `disciplineConfig` object in DevModeToolbar.js
2. **Define Events**: Specify the event names for workflow stages and agent messages
3. **Map Tabs**: Define how workflow stages map to tab names and types
4. **Update Selectors**: Provide CSS selectors for modal and page elements
5. **Dispatch Events**: Ensure your modal dispatches the correct events

## Development Mode Detection

The toolbar only renders when development mode is active:

```javascript
const isDevMode = () => {
  return process.env.NODE_ENV === 'development' ||
         window.store?.state?.debugMode ||
         localStorage.getItem('devMode') === 'true';
};
```

## Available Features

### Current Tab Actions
- **Edit Rules**: Opens rule editor for current tab type
- **Edit Prompt**: Opens prompt editor for current document type
- **View Metrics**: Opens metrics modal for current tab

### System Actions
- **Admin Panel**: Opens system administration panel
- **Export Config**: Exports current configuration as JSON
- **Test Workflow**: Runs workflow tests for current stage

### Debug Information
- Current workflow stage
- Active agent type
- Session ID (truncated)

## Best Practices

### Event Dispatching
- Always include `sessionId` in event details for correlation
- Use consistent timestamp format (ISO string)
- Dispatch events after state changes are complete

### Discipline Configuration
- Use lowercase discipline codes for event prefixes
- Keep tab mappings simple and descriptive
- Update configuration when adding new workflow stages

### Modal Integration
- Import DevModeToolbar at the top of your modal file
- Render it inside the modal content but outside main functionality
- Pass the correct discipline prop based on your modal type

### CSS Selectors
- Use class-based selectors that are stable across updates
- Ensure selectors are unique to avoid conflicts
- Test selectors in both modal and page contexts

## Troubleshooting

### Toolbar Not Appearing
1. Verify development mode is enabled
2. Check that discipline prop is correctly passed
3. Ensure modal has correct CSS classes for selector matching

### Events Not Firing
1. Confirm event names match discipline configuration
2. Check event detail structure includes required fields
3. Verify events are dispatched after state updates

### Incorrect Tab Detection
1. Review tab mapping in discipline configuration
2. Check CSS selectors match actual DOM elements
3. Ensure active tab has correct class names

## Maintenance

### Adding New Features
- Extend the discipline configuration object
- Add new event handlers in useEffect
- Update action handlers to support new functionality

### Updating Event Structure
- Maintain backward compatibility when possible
- Document changes in event detail structure
- Update all modals using the changed events

### Performance Considerations
- Use dynamic imports for heavy modal dependencies
- Clean up event listeners in useEffect cleanup
- Minimize re-renders by optimizing state updates
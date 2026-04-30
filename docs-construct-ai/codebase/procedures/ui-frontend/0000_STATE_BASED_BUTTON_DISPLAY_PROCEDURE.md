---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/ui-frontend
gigabrain_tags: procedures, ui-frontend, codebase
documentation
openstinger_context: operational-procedures, ui-frontend-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# State-Based Button Display Procedure

## Overview

This document provides the standardized methodology for implementing state-based button display in Construct AI pages. It supplements the existing page implementation procedures (0000_PAGE_IMPLEMENTATION_PROCEDURE.md and 0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW.md) by documenting the specific patterns and patterns for state-driven button interfaces.

**Reference Implementation**: 00435-contracts-post-award (generic pattern) and 01900-procurement (discipline-specific pattern)

## Purpose

This procedure ensures consistent implementation of:
- State management for button displays
- Navigation structure for state selection
- Button container configuration
- Modal triggering based on state
- CSS positioning and styling

## Target Audience

- Page developers creating new discipline pages
- Developers modifying existing state-based pages
- Code reviewers verifying implementation consistency
- Technical architects designing page patterns

## Prerequisites

- Understanding of React state management (useState, useEffect)
- Familiarity with modal component patterns
- Access to reference implementations (00435, 01900)
- Knowledge of Construct AI page architecture

---

## Core Patterns

### 1. State Management Pattern

#### Basic Implementation:

```javascript
import React, { useState, useEffect } from 'react';

const PageComponent = () => {
  // State definition
  const [currentState, setCurrentState] = useState('agents'); // Default state
  
  // State change handler
  const handleStateChange = (newState) => {
    setCurrentState(newState);
    // State-specific cleanup
    if (newState !== 'agents') {
      setActiveAgent(null); // Reset agent-specific state
    }
    setShowVettingComponent(false); // Reset workspace component
  };

  return (
    <PageStructure
      currentState={currentState}
      onStateChange={handleStateChange}
    />
  );
};
```

#### Key Points:

- **Default State**: Always set default to `'agents'` (most common starting state)
- **State Cleanup**: Reset state-specific variables when changing states
- **Global State**: Consider if state needs to be accessible globally (useContext)

### 2. State Configuration Pattern

#### Generic Configuration (Recommended for New Pages):

```javascript
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  upserts: {
    label: 'Upserts',
    emoji: '📤',
    description: 'Data modification operations'
  },
  workspace: {
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace management'
  }
};
```

#### Discipline-Specific Configuration (Use When Needed):

```javascript
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  suppliers: { // Discipline-specific name
    label: 'Upserts',
    emoji: '📤',
    description: 'Supplier management operations'
  },
  vetting: { // Discipline-specific name
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace and vetting management'
  },
  simulator: { // Additional discipline-specific state
    label: 'Simulator',
    emoji: '🔄',
    description: 'Workflow simulation'
  }
};
```

#### State Naming Rules:

1. **Generic Names (Preferred)**:
   - `agents` - AI agent interactions
   - `upserts` - Data modification operations
   - `workspace` - Workspace management

2. **Discipline-Specific Names (Documented)**:
   - `suppliers` - Alias for upserts (01900-procurement)
   - `vetting` - Alias for workspace (01900-procurement)
   - `simulator` - Additional state (01900-procurement)

3. **Naming Convention**:
   - Use descriptive, lowercase names
   - No hyphens or special characters
   - Keep names short but meaningful
   - Document any variations from generic names

### 3. Navigation Structure Pattern

#### HTML Structure (All Pages):

```html
<div className="A-{pageId}-navigation-container">
  <div className="A-{pageId}-nav-row">
    {STATE_CONFIG.map(state => (
      <button
        key={state.key}
        className={`state-button ${currentState === state.key ? 'active' : ''}`}
        onClick={() => handleStateChange(state.key)}
      >
        {state.emoji} {state.label}
      </button>
    ))}
  </div>
  <button className="nav-button primary">Page Title</button>
</div>
```

#### CSS Positioning (All Pages):

```css
.A-{pageId}-navigation-container {
  position: fixed;
  left: 50%;
  bottom: 10px;
  transform: translateX(-50%);
  z-index: 200;
  pointer-events: none; /* Container doesn't block clicks */
}

.A-{pageId}-nav-row {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
  pointer-events: auto !important; /* Buttons receive clicks */
}

.state-button {
  pointer-events: auto !important;
  background: white;
  border: 2px solid #FF8C00;
  border-radius: 20px;
  padding: 8px 16px;
  cursor: pointer;
  transition: all 0.2s;
  font-weight: 600;
  color: #333;
}

.state-button:hover {
  background: #FFF8F0;
  transform: translateY(-2px);
}

.state-button.active {
  background: #FF8C00;
  color: white;
  border-color: #FF8C00;
}

.nav-button {
  pointer-events: auto !important;
  background: #FF8C00;
  color: white;
  border: none;
  border-radius: 20px;
  padding: 10px 20px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 16px;
}

.nav-button:hover {
  background: #FF9E2B;
  transform: translateY(-2px);
}
```

#### Key Points:

- **Fixed Positioning**: Navigation always positioned at bottom center
- **Pointer Events**: Container blocks clicks, buttons allow clicks
- **Active State**: Clear visual distinction for current state
- **Hover Effects**: Subtle lift effect for better UX
- **Z-Index**: Set to 200 to appear above most page content

### 4. Button Container Pattern

#### Container Structure:

```javascript
const ButtonContainer = ({ currentState, buttons, onOpenModal, pageId, isVisible }) => {
  const renderStateButtons = (buttons) => {
    return buttons.map((button, index) => (
      <button
        key={index}
        className="modal-trigger-button"
        onClick={() => onOpenModal(button.modalId, {
          modalTitle: button.modalTitle,
          triggerPage: pageId,
        })}
      >
        {button.emoji && <span>{button.emoji}</span>}
        {button.label}
      </button>
    ));
  };

  return (
    <div className={`button-container ${isVisible ? 'visible' : ''}`}>
      {currentState === 'agents' && renderStateButtons(buttons.agents)}
      {currentState === 'upserts' && renderStateButtons(buttons.upserts)}
      {currentState === 'workspace' && renderStateButtons(buttons.workspace)}
    </div>
  );
};
```

#### CSS Styling:

```css
.button-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: grid;
  gridTemplateColumns: repeat(2, 1fr);
  columnGap: 0px;
  rowGap: 10px;
  maxWidth: 600px;
  width: 100%;
  padding: 30px;
  justifyItems: center;
  alignItems: center;
  zIndex: 10;
  backgroundColor: rgba(255, 255, 255, 0.95);
  borderRadius: 12px;
  boxShadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.button-container.visible {
  opacity: 1;
}

.modal-trigger-button {
  background: white;
  border: 2px solid #FF8C00;
  border-radius: 8px;
  padding: 12px 20px;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.2s;
  min-width: 200px;
  text-align: center;
  font-weight: 500;
  color: #333;
}

.modal-trigger-button:hover {
  background: #FFF8F0;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.modal-trigger-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}
```

#### Key Points:

- **Grid Layout**: 2-column grid for optimal space usage
- **Fade-in Animation**: Smooth appearance on page load
- **Button Sizing**: Minimum 200px width for consistency
- **Hover Effects**: Clear visual feedback for interaction
- **Disabled State**: Consistent styling for disabled buttons

### 5. Modal Triggering Pattern

#### Modal Trigger Handler:

```javascript
const handleOpenModal = (modalId, modalProps = {}) => {
  // Set global modal trigger page
  window.currentModalTriggerPage = modalProps.triggerPage;

  // Set active agent for agent state
  if (currentState === 'agents') {
    const agentMap = {
      CorrespondenceModal: 'correspondence',
      OrderProcessModal: 'order-process',
      AnalysisModal: 'analysis',
    };
    setActiveAgent(agentMap[modalId]);
  }

  // Open modal
  openModal(modalId, modalProps);
};
```

#### Button Configuration Schema:

```javascript
interface ButtonConfig {
  label: string;           // Display text (required)
  modalId: string;         // Modal component identifier (required)
  modalTitle: string;      // Modal window title (required)
  emoji?: string;          // Optional emoji/icon
  disabled?: boolean;      // Optional disabled state
  requiresPermission?: string[];  // Optional permission requirements
  action?: string;         // Optional action type (navigate, modal, etc.)
  route?: string;          // Optional route for navigation actions
}
```

#### Agent Map Pattern (For Agent State):

```javascript
const agentMap = {
  // Format: ModalId: 'agent-type'
  CorrespondenceModal: 'correspondence',
  OrderProcessModal: 'order-process',
  AnalysisModal: 'analysis',
  ReportModal: 'report-generation',
};
```

#### Key Points:

- **Global State**: `window.currentModalTriggerPage` tracks which page opened the modal
- **Agent Tracking**: Only set agent for agent state (not upserts/workspace)
- **Agent Map**: Maps modal IDs to agent types for tracking
- **Modal Props**: Pass trigger page and modal title for context

### 6. State Transition Effects

#### Button Visibility Animation:

```javascript
const [isButtonContainerVisible, setIsButtonContainerVisible] = useState(false);

useEffect(() => {
  const timer = setTimeout(() => {
    setIsButtonContainerVisible(true);
  }, 100);
  return () => clearTimeout(timer);
}, []);
```

#### State-Specific Cleanup:

```javascript
const handleStateChange = (newState) => {
  // Update state
  setCurrentState(newState);

  // State-specific cleanup
  if (newState !== 'agents') {
    setActiveAgent(null); // Reset agent-specific state
  }

  if (newState !== 'workspace') {
    setShowVettingComponent(false); // Reset workspace component
  }

  // Optional: Log state change for debugging
  console.log(`[Page] State changed to: ${newState}`);
};
```

#### Key Points:

- **Fade-in Delay**: 100ms delay for smooth appearance
- **Cleanup on State Change**: Reset state-specific variables
- **Debug Logging**: Optional logging for development
- **Cleanup Timing**: Clear timeouts on unmount if needed

---

## Implementation Steps

### Step 1: Page Component Setup

```javascript
// Import necessary dependencies
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useModal } from '@components/modal/hooks/00170-useModal.js';
import { getThemedImagePath } from '@common/js/ui/00210-image-theme-helper.js';

// Import CSS
import '../../../common/css/pages/{page-id}-{page-name}/{page-id}-pages-style.css';

// Import any page-specific components
import ChatbotBase from '../../../components/chatbots/base/ChatbotBase.js';

const PageComponent = () => {
  // State definitions
  const [currentState, setCurrentState] = useState('agents');
  const [isButtonContainerVisible, setIsButtonContainerVisible] = useState(false);
  const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);
  const { openModal } = useModal();

  // State-specific state variables
  const [activeAgent, setActiveAgent] = useState(null);
  const [showWorkspaceComponent, setShowWorkspaceComponent] = useState(false);

  // Navigation
  const navigate = useNavigate();
  const pageId = '{page-id}';
  const pageTitle = '{Page Title}';

  // State change handler
  const handleStateChange = (newState) => {
    setCurrentState(newState);
    
    // State-specific cleanup
    if (newState !== 'agents') {
      setActiveAgent(null);
    }
    
    if (newState !== 'workspace') {
      setShowWorkspaceComponent(false);
    }
  };

  // Modal trigger handler
  const handleOpenModal = (modalId, modalProps = {}) => {
    window.currentModalTriggerPage = modalProps.triggerPage;

    if (currentState === 'agents') {
      const agentMap = {
        // Add agent mappings here
        CorrespondenceModal: 'correspondence',
        OrderProcessModal: 'order-process',
      };
      setActiveAgent(agentMap[modalId]);
    }

    openModal(modalId, modalProps);
  };

  // Button visibility animation
  useEffect(() => {
    const timer = setTimeout(() => {
      setIsButtonContainerVisible(true);
    }, 100);
    return () => clearTimeout(timer);
  }, []);

  // Get background image
  const backgroundImagePath = getThemedImagePath(`${pageId}.png`);

  return (
    <div className="page-container" style={{ backgroundImage: `url(${backgroundImagePath})` }}>
      {/* Page content */}
      <NavigationComponent
        currentState={currentState}
        onStateChange={handleStateChange}
        pageTitle={pageTitle}
      />

      <ButtonContainerComponent
        currentState={currentState}
        buttons={BUTTONS_BY_STATE}
        onOpenModal={handleOpenModal}
        pageId={pageId}
        isVisible={isButtonContainerVisible}
      />

      {/* Chatbot */}
      <ChatbotBase
        pageId={pageId}
        disciplineCode="{DISCIPLINE_CODE}"
        userId={window.currentUser?.id || 'demo-user'}
        chatType="document"
        title="{Page} Assistant"
        welcomeTitle="{Page} Command Center"
        welcomeMessage="I can help with {page-specific assistance}."
      />
    </div>
  );
};

export default PageComponent;
```

### Step 2: Define State Configuration

```javascript
// State configuration
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  upserts: {
    label: 'Upserts',
    emoji: '📤',
    description: 'Data modification operations'
  },
  workspace: {
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace management'
  }
  // Add more states as needed
};
```

### Step 3: Define Button Arrays

```javascript
// Button arrays by state
const BUTTONS_BY_STATE = {
  agents: [
    {
      label: '📧 Correspondence Reply',
      modalId: 'CorrespondenceReplyModal',
      modalTitle: 'Correspondence Reply',
    },
    {
      label: '🤖 Process Order',
      modalId: 'OrderProcessModal',
      modalTitle: 'Process Order',
    },
    {
      label: '🔍 Analysis',
      modalId: 'AnalysisModal',
      modalTitle: 'Analysis',
    },
    {
      label: '📊 Generate Report',
      modalId: 'ReportModal',
      modalTitle: 'Generate Report',
    },
  ],

  upserts: [
    {
      label: '☁️ Cloud Import',
      modalId: 'CloudImportModal',
      modalTitle: 'Cloud Import',
    },
    {
      label: '🌐 Import from URL',
      modalId: 'UrlImportModal',
      modalTitle: 'Import from URL',
    },
    {
      label: '📄 Upload Files',
      modalId: 'FileUploadModal',
      modalTitle: 'Upload Files',
    },
  ],

  workspace: [
    {
      label: 'Manage Workspaces',
      emoji: '🗂️',
      modalId: 'WorkspaceManagementModal',
      modalTitle: 'Manage Workspaces',
    },
    {
      label: 'Analysis',
      emoji: '📊',
      modalId: 'AnalysisWorkspaceModal',
      modalTitle: 'Analysis Workspace',
    },
    {
      label: 'Details',
      emoji: '👥',
      modalId: 'DetailsModal',
      modalTitle: 'Details',
    },
    {
      label: 'Data Manager',
      emoji: '📈',
      modalId: 'DataManagerModal',
      modalTitle: 'Data Manager',
    },
  ],
};
```

### Step 4: Implement Navigation Component

```javascript
// Navigation Component
const NavigationComponent = ({ currentState, onStateChange, pageTitle }) => {
  return (
    <div className="page-navigation-container">
      <div className="page-nav-row">
        {Object.entries(STATE_CONFIG).map(([key, config]) => (
          <button
            key={key}
            className={`state-button ${currentState === key ? 'active' : ''}`}
            onClick={() => onStateChange(key)}
          >
            {config.emoji} {config.label}
          </button>
        ))}
      </div>
      <button className="nav-button primary">{pageTitle}</button>
    </div>
  );
};
```

### Step 5: Implement Button Container Component

```javascript
// Button Container Component
const ButtonContainerComponent = ({ currentState, buttons, onOpenModal, pageId, isVisible }) => {
  const renderStateButtons = (buttons) => {
    return buttons.map((button, index) => (
      <button
        key={index}
        className="modal-trigger-button"
        onClick={() => onOpenModal(button.modalId, {
          modalTitle: button.modalTitle,
          triggerPage: pageId,
        })}
        disabled={button.disabled}
      >
        {button.emoji && <span>{button.emoji}</span>}
        {button.label}
      </button>
    ));
  };

  return (
    <div className={`button-container ${isVisible ? 'visible' : ''}`}>
      {currentState === 'agents' && renderStateButtons(buttons.agents)}
      {currentState === 'upserts' && renderStateButtons(buttons.upserts)}
      {currentState === 'workspace' && renderStateButtons(buttons.workspace)}
    </div>
  );
};
```

### Step 6: Add Chatbot Component

```javascript
// Chatbot Component
<ChatbotBase
  pageId={pageId}
  disciplineCode="{DISCIPLINE_CODE}"
  userId={window.currentUser?.id || 'demo-user'}
  chatType="document"
  title="{Page} Assistant"
  welcomeTitle="{Page} Command Center"
  welcomeMessage="I can help with {page-specific assistance}."
  exampleQueries={[
    "How do I {page-specific query 1}?",
    "What are the requirements for {page-specific query 2}?",
    "How do I manage {page-specific query 3}?",
  ]}
  theme={{
    primary: "#FF8C00",
    secondary: "#FFA500",
    background: "#FFF8F0",
    border: "#FFE8CC",
  }}
  enableCitations={true}
  enableDocumentCount={true}
  enableConversationHistory={true}
/>
```

### Step 7: Add Logout Button

```javascript
// Logout Button Component
<button
  id="logout-button"
  onClick={() => {
    if (window.handleLogout) {
      window.handleLogout();
    } else {
      console.error("Global handleLogout function not found.");
    }
  }}
  className="logout-button"
>
  <svg
    className="logout-icon"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
  >
    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
    <polyline points="16 17 21 12 16 7" />
    <line x1="21" y1="12" x2="9" y2="12" />
  </svg>
</button>
```

### Step 8: CSS Implementation

#### Navigation Container CSS:

```css
.page-navigation-container {
  position: fixed;
  left: 50%;
  bottom: 10px;
  transform: translateX(-50%);
  z-index: 200;
  pointer-events: none;
}

.page-nav-row {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
  pointer-events: auto !important;
}

.state-button {
  pointer-events: auto !important;
  background: white;
  border: 2px solid #FF8C00;
  border-radius: 20px;
  padding: 8px 16px;
  cursor: pointer;
  transition: all 0.2s;
  font-weight: 600;
  color: #333;
}

.state-button:hover {
  background: #FFF8F0;
  transform: translateY(-2px);
}

.state-button.active {
  background: #FF8C00;
  color: white;
  border-color: #FF8C00;
}

.nav-button {
  pointer-events: auto !important;
  background: #FF8C00;
  color: white;
  border: none;
  border-radius: 20px;
  padding: 10px 20px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 16px;
}

.nav-button:hover {
  background: #FF9E2B;
  transform: translateY(-2px);
}
```

#### Button Container CSS:

```css
.button-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: grid;
  gridTemplateColumns: repeat(2, 1fr);
  columnGap: 0px;
  rowGap: 10px;
  maxWidth: 600px;
  width: 100%;
  padding: 30px;
  justifyItems: center;
  alignItems: center;
  zIndex: 10;
  backgroundColor: rgba(255, 255, 255, 0.95);
  borderRadius: 12px;
  boxShadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.button-container.visible {
  opacity: 1;
}

.modal-trigger-button {
  background: white;
  border: 2px solid #FF8C00;
  border-radius: 8px;
  padding: 12px 20px;
  cursor: pointer;
  font-size: 16px;
  transition: all 0.2s;
  min-width: 200px;
  text-align: center;
  font-weight: 500;
  color: #333;
}

.modal-trigger-button:hover {
  background: #FFF8F0;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.modal-trigger-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}
```

#### Page Background CSS:

```css
.page-container {
  min-height: 100vh;
  width: 100%;
  position: relative;
  overflow: hidden;
  background-size: cover;
  background-position: center bottom;
  background-repeat: no-repeat;
  background-attachment: fixed;
}

/* Chatbot positioning (if using inline styles) */
.chatbot-container {
  position: fixed;
  right: 10px;
  bottom: 10px;
  z-index: 900;
}

/* Logout button positioning (if using inline styles) */
.logout-button {
  position: fixed;
  left: 10px;
  bottom: 10px;
  z-index: 200;
  background: none;
  border: none;
  padding: 10px;
  cursor: pointer;
  color: #333;
  transition: color 0.2s;
}

.logout-button:hover {
  color: #FF8C00;
}

.logout-icon {
  width: 24px;
  height: 24px;
}
```

---

## Common Patterns

### Pattern 1: Generic Pages (00435 Pattern)

#### Characteristics:
- **State Names**: Generic (`agents`, `upserts`, `workspace`)
- **State Count**: 3 states
- **Button Count**: 3-4 buttons per state
- **Purpose**: Business operations (contracts, orders, etc.)

#### Implementation:

```javascript
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  upserts: {
    label: 'Upserts',
    emoji: '📤',
    description: 'Data modification operations'
  },
  workspace: {
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace management'
  }
};
```

#### Button Examples:
```javascript
// Agents: Contract Analysis, Risk Assessment, Compliance Check, Clause Extraction
// Upserts: Cloud Import, Import from URL, Upload Files, Create New Contract
// Workspace: View Documents, Manage Stakeholders, Dashboard, Edit Details
```

### Pattern 2: Discipline-Specific Pages (01900 Pattern)

#### Characteristics:
- **State Names**: Discipline-specific (`suppliers`, `vetting`, `simulator`)
- **State Count**: 4 states (including simulator)
- **Button Count**: Varies by state
- **Purpose**: Specialized operations (procurement, supply chain, etc.)

#### Implementation:

```javascript
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  suppliers: {
    label: 'Upserts',
    emoji: '📤',
    description: 'Supplier management operations'
  },
  vetting: {
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace and vetting management'
  },
  simulator: {
    label: 'Simulator',
    emoji: '🔄',
    description: 'Workflow simulation'
  }
};
```

#### Button Examples:
```javascript
// Agents: Correspondence Reply, Create Procurement Order, Supplier Analysis, Generate Report
// Suppliers: Cloud Import, Import from URL, Upload Files
// Vetting: Manage Workspaces, Supplier Analysis, Supplier Details, Vector Data Manager
// Simulator: (Overlay component with workflow simulator)
```

#### Simulator State Handling:
```javascript
{currentState === 'simulator' && (
  <div className="simulator-overlay" style={{ /* overlay styles */ }}>
    <WorkflowSimulatorComponent
      onStartSimulation={handleSimulationStart}
      onViewResults={handleSimulationResults}
    />
  </div>
)}
```

### Pattern 3: Additional States (Discipline-Specific)

#### When to Add Additional States:
- **Unique Functionality**: State represents fundamentally different operations
- **Complexity Management**: State has many related operations
- **User Experience**: State represents a distinct workflow phase
- **Performance**: State contains heavy components

#### Implementation for Additional States:

```javascript
// 1. Add to STATE_CONFIG
const STATE_CONFIG = {
  // ... existing states
  simulator: {
    label: 'Simulator',
    emoji: '🔄',
    description: 'Workflow simulation'
  }
};

// 2. Add to BUTTONS_BY_STATE
const BUTTONS_BY_STATE = {
  // ... existing states
  simulator: [] // May be empty if using overlay component
};

// 3. Add to ButtonContainerComponent render logic
{currentState === 'simulator' && renderStateButtons(buttons.simulator)}

// 4. Add special handling if needed
{currentState === 'simulator' && (
  <SpecialComponent />
)}
```

### Pattern 4: Quick Access Buttons (Workspace State)

#### When to Use:
- **Common Navigation**: Frequently accessed pages
- **Permission Management**: Cross-discipline sharing
- **Settings Access**: Quick access to configuration

#### Implementation:

```javascript
// In workspace state buttons
const workspaceButtons = [
  // ... main modal buttons
  
  // Quick access buttons (rendered separately)
];

// Additional rendering in ButtonContainerComponent
{currentState === 'workspace' && (
  <>
    {/* Main buttons */}
    {renderStateButtons(buttons.workspace)}
    
    {/* Quick access buttons */}
    <div className="quick-access-buttons">
      <button
        className="quick-access-button"
        onClick={() => navigate('/ui-settings#document-access')}
      >
        📄 Document Access
      </button>
      <button
        className="quick-access-button"
        onClick={() => onOpenModal('DisciplinePermissionMatrixModal', {
          modalTitle: '🔗 Cross-Discipline Sharing',
          triggerPage: pageId,
        })}
      >
        🔗 Cross-Discipline Sharing
      </button>
    </div>
  </>
)}
```

### Pattern 5: Disabled State Handling

#### When to Disable Buttons:
- **Permission Issues**: User lacks required permissions
- **Missing Data**: Required data not loaded
- **Workflow State**: Button only valid at certain workflow stages
- **Loading State**: Data still loading

#### Implementation:

```javascript
// In button configuration
const agentsButtons = [
  {
    label: '📊 Generate Report',
    modalId: 'ReportModal',
    modalTitle: 'Generate Report',
    disabled: !hasReportPermission || !reportDataLoaded,
    requiresPermission: ['report:generate']
  },
];

// In ButtonContainerComponent
<button
  key={index}
  className="modal-trigger-button"
  onClick={() => onOpenModal(button.modalId, {
    modalTitle: button.modalTitle,
    triggerPage: pageId,
  })}
  disabled={button.disabled}
>
  {button.disabled && <span className="disabled-indicator">🔒</span>}
  {button.emoji && <span>{button.emoji}</span>}
  {button.label}
</button>
```

#### Disabled Button CSS:
```css
.modal-trigger-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
  border-color: #ccc;
  color: #999;
}

.disabled-indicator {
  margin-right: 8px;
  font-size: 14px;
}
```

---

## Discipline-Specific Variations

### Procurement (01900) Variations

#### State Naming:
- `suppliers` (instead of `upserts`)
- `vetting` (instead of `workspace`)
- `simulator` (additional state)

#### Button Differences:
- **Agents**: Procurement-specific modals (Correspondence, Order Creation)
- **Suppliers**: Standard upsert operations (Cloud Import, URL Import, File Upload)
- **Vetting**: Workspace + supplier vetting operations
- **Simulator**: Workflow simulation overlay

#### Additional Features:
- Quick access buttons in workspace state
- Simulator overlay component
- Agent-specific tracking in agent state

### Finance (01200) Variations (Hypothetical)

#### Expected Variations:
- State names: `financial_agents`, `transactions`, `reports`
- Additional states: `analytics`, `forecasting`
- Button configurations: Finance-specific operations

### IT (02050) Variations (Hypothetical)

#### Expected Variations:
- State names: `it_agents`, `systems`, `maintenance`
- Additional states: `monitoring`, `automation`
- Button configurations: IT-specific operations

---

## Troubleshooting

### Issue: State Buttons Not Appearing

**Symptoms**: Navigation buttons don't show up

**Possible Causes**:
1. State configuration not defined
2. CSS positioning issues
3. Z-index conflicts

**Solutions**:
```javascript
// Check state configuration
console.log('STATE_CONFIG:', STATE_CONFIG);

// Check CSS
console.log('Navigation container styles:', 
  document.querySelector('.page-navigation-container')?.computedStyleMap());

// Check z-index
console.log('Navigation z-index:', 
  document.querySelector('.page-navigation-container')?.style.zIndex);
```

### Issue: Buttons Not Clickable

**Symptoms**: Buttons appear but don't respond to clicks

**Possible Causes**:
1. Pointer-events CSS blocking clicks
2. Click handlers not bound
3. Overlay elements blocking clicks

**Solutions**:
```css
/* Check pointer-events on container */
.page-navigation-container {
  pointer-events: none; /* Should be none */
}

/* Check pointer-events on buttons */
.state-button {
  pointer-events: auto !important; /* Should be auto */
}
```

### Issue: Modal Not Opening

**Symptoms**: Button clicks don't open modals

**Possible Causes**:
1. Modal ID not matching
2. Modal component not imported
3. openModal function not working

**Solutions**:
```javascript
// Check modal ID mapping
console.log('Modal ID:', modalId);
console.log('Modal props:', modalProps);

// Verify modal exists
console.log('Available modals:', window.modalRegistry);

// Test openModal directly
const testModalId = 'TestModal';
openModal(testModalId, { modalTitle: 'Test' });
```

### Issue: State Not Changing

**Symptoms**: Clicking state buttons doesn't change display

**Possible Causes**:
1. State change handler not working
2. Component not re-rendering
3. Conditional rendering not updating

**Solutions**:
```javascript
// Check state value
console.log('Current state:', currentState);

// Test state change directly
handleStateChange('upserts');
console.log('New state:', currentState);

// Check re-rendering
console.log('Component rendered at:', new Date().toISOString());
```

### Issue: Background Image Not Showing

**Symptoms**: Page background doesn't display

**Possible Causes**:
1. Image path incorrect
2. CSS background properties
3. Image file not found

**Solutions**:
```javascript
// Check image path
const backgroundImagePath = getThemedImagePath(`${pageId}.png`);
console.log('Background image path:', backgroundImagePath);

// Test image loading
const img = new Image();
img.onload = () => console.log('Image loaded successfully');
img.onerror = () => console.error('Image failed to load');
img.src = backgroundImagePath;
```

### Issue: Chatbot Not Appearing

**Symptoms**: Chatbot component not visible

**Possible Causes**:
1. Component not imported
2. Props not configured correctly
3. Z-index issues

**Solutions**:
```javascript
// Check chatbot component
console.log('ChatbotBase component:', ChatbotBase);

// Check chatbot props
console.log('Chatbot props:', {
  pageId: pageId,
  disciplineCode: disciplineCode,
  userId: userId
});

// Check chatbot container styles
console.log('Chatbot container styles:', 
  document.querySelector('.chatbot-container')?.computedStyleMap());
```

---

## Testing Checklist

### State Transition Tests

- [ ] Click each state button
- [ ] Verify active state styling changes
- [ ] Verify button container updates
- [ ] Verify state-specific cleanup works
- [ ] Test rapid state switching
- [ ] Test state changes with active modals

### Modal Functionality Tests

- [ ] Click each button in each state
- [ ] Verify modal opens with correct title
- [ ] Verify modal content is correct
- [ ] Verify modal closes properly
- [ ] Test modal with validation
- [ ] Test modal with error handling

### Navigation Tests

- [ ] Verify navigation appears on all pages
- [ ] Verify state buttons are clickable
- [ ] Verify page title button works
- [ ] Test responsive design (mobile/desktop)
- [ ] Test with different screen sizes

### Visual Design Tests

- [ ] Verify color scheme consistency
- [ ] Verify spacing and alignment
- [ ] Verify hover effects work
- [ ] Verify active state is clear
- [ ] Verify disabled state is clear
- [ ] Verify animations are smooth

### Performance Tests

- [ ] Test page load time
- [ ] Test state transition speed
- [ ] Test modal open/close speed
- [ ] Test with many buttons
- [ ] Test on mobile devices

### Cross-Browser Tests

- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari
- [ ] Edge
- [ ] Mobile browsers (iOS Safari, Chrome Mobile)

---

## Code Quality Standards

### Naming Conventions

- **State Variables**: `currentState`, `is{Verb}Visible`, `show{Component}`
- **Event Handlers**: `handle{Event}`, `on{Action}`
- **Button Arrays**: `{state}Buttons`, `BUTTONS_BY_STATE`
- **Modal IDs**: `{Page}{Action}Modal`, PascalCase
- **CSS Classes**: `page-{element}`, `state-button`, `modal-trigger-button`

### File Organization

```
client/src/pages/{page-id}-{page-name}/
├── {page-id}-index.js                    # Entry point
├── components/
│   ├── {page-id}-{page-name}-page.js     # Main component
│   └── modals/
│       ├── {Page}Modal.jsx               # Modal components
│       └── ...
├── css/
│   └── {page-id}-pages-style.css         # Page styles
└── agents/                               # If needed
    └── {page-id}-{agent-name}-agent.js
```

### Code Structure

1. **Imports**: Group by type (React, React Router, Components, CSS)
2. **State Definitions**: Group related state together
3. **Event Handlers**: Group related handlers together
4. **Effects**: One useEffect per purpose
5. **Render Methods**: Keep render methods small and focused
6. **Components**: Extract reusable components

### Documentation Requirements

1. **State Configuration**: Document any variations from generic names
2. **Button Arrays**: Document purpose of each button
3. **Modals**: Link to modal documentation
4. **Permissions**: Document required permissions for each button
5. **Workflows**: Document state transition workflows

### Error Handling

1. **Modal Errors**: Catch and log modal opening errors
2. **State Errors**: Validate state changes
3. **Permission Errors**: Check permissions before enabling buttons
4. **API Errors**: Handle API failures gracefully
5. **User Errors**: Provide clear error messages

---

## Maintenance Procedures

### Regular Updates

**When to Update**:
- After adding new buttons to states
- After changing state configuration
- After adding new modals
- After UI component library updates
- Monthly for documentation refresh

**Update Process**:
1. Review existing button arrays
2. Update STATE_CONFIG if needed
3. Update BUTTONS_BY_STATE if needed
4. Update modal imports if needed
5. Update CSS if needed
6. Test all state transitions
7. Update documentation

### Version Control

**Commit Messages**:
```
feat: Add state-based button display to 01900-procurement
- Implement agents state with 4 buttons
- Implement upserts state with 3 buttons
- Implement workspace state with 4 buttons
- Add state management and navigation
- Add modal triggering system
- Add CSS styling and animations
```

**Branch Naming**:
```
feature/state-based-buttons-{page-id}
fix/state-transitions-{page-id}
refactor/button-container-{page-id}
```

### Backup Strategy

**Before Major Changes**:
```bash
# Backup page component
cp client/src/pages/{page-id}-{page-name}/components/{page-id}-{page-name}-page.js \
   client/src/pages/{page-id}-{page-name}/backup/{page-id}-page-backup-$(date +%Y%m%d-%H%M%S).js

# Backup CSS
cp client/src/pages/{page-id}-{page-name}/css/{page-id}-pages-style.css \
   client/src/pages/{page-id}-{page-name}/backup/{page-id}-style-backup-$(date +%Y%m%d-%H%M%S).css
```

---

## Reference Documentation

### State Management Reference

```javascript
// State definition patterns
const [currentState, setCurrentState] = useState('agents');
const [isButtonVisible, setIsButtonVisible] = useState(false);
const [activeAgent, setActiveAgent] = useState(null);
const [showComponent, setShowComponent] = useState(false);

// State change patterns
const handleStateChange = (newState) => {
  setCurrentState(newState);
  if (newState !== 'agents') setActiveAgent(null);
};
```

### Button Configuration Reference

```javascript
// Required properties
{
  label: string,      // Display text
  modalId: string,    // Modal identifier
  modalTitle: string  // Modal title
}

// Optional properties
{
  emoji: string,              // Icon/emoji
  disabled: boolean,          // Disabled state
  requiresPermission: array,  // Permission requirements
  action: string,             // Action type
  route: string              // Navigation route
}
```

### Modal Trigger Reference

```javascript
// Basic usage
handleOpenModal('ModalId', {
  modalTitle: 'Modal Title',
  triggerPage: '01900-procurement'
});

// With custom props
handleOpenModal('ModalId', {
  modalTitle: 'Modal Title',
  triggerPage: '01900-procurement',
  customProp: 'customValue'
});
```

### CSS Reference

```css
/* Navigation positioning */
.page-navigation-container {
  position: fixed;
  left: 50%;
  bottom: 10px;
  transform: translateX(-50%);
  z-index: 200;
  pointer-events: none;
}

/* Button container positioning */
.button-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 10;
}

/* Active state styling */
.state-button.active {
  background: #FF8C00;
  color: white;
}
```

---

## Quick Reference

### Common State Names

| Purpose | Generic Name | Examples |
|---------|--------------|----------|
| AI Agent Interactions | `agents` | Contract Analysis, Risk Assessment |
| Data Modification | `upserts` | Cloud Import, File Upload, Create |
| Workspace Management | `workspace` | View Documents, Dashboard, Edit |
| Additional State | `{discipline}` | Simulator, Analytics, Forecasting |

### Common Button Counts

| State Type | Recommended Count | Example |
|------------|-------------------|---------|
| Agents | 3-4 buttons | Analysis, Processing, Reports |
| Upserts | 2-4 buttons | Import, Upload, Create |
| Workspace | 3-4 buttons | View, Manage, Dashboard |
| Additional | 0-3 buttons | Depends on functionality |

### Common Modal Patterns

| Pattern | Modal ID Format | Example |
|---------|----------------|---------|
| Agent Modal | `{Page}{Action}Modal` | `ProcurementCorrespondenceModal` |
| Upsert Modal | `{Page}Upsert{Type}Modal` | `01900-UpsertCloudModal` |
| Workspace Modal | `{Page}Workspace{Type}Modal` | `SupplierAnalysisWorkspaceModal` |
| Generic Modal | `{Action}Modal` | `DashboardModal` |

### Common CSS Patterns

| Element | Class Pattern | Example |
|---------|---------------|---------|
| Navigation Container | `.{pageId}-navigation-container` | `.A-01900-navigation-container` |
| Navigation Row | `.{pageId}-nav-row` | `.A-01900-nav-row` |
| State Button | `.state-button` | `.state-button` |
| Button Container | `.{pageId}-button-container` | `.A-01900-button-container` |
| Modal Button | `.modal-trigger-button` | `.modal-trigger-button` |

---

## References

### Related Documentation

- [0000_PAGE_IMPLEMENTATION_PROCEDURE.md](../0000_PAGE_IMPLEMENTATION_PROCEDURE.md) - General page implementation
- [0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW.md](../0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW.md) - Page creation workflow
- [0000_PAGE_RESTRUCTURING_PROMPT_TEMPLATE.md](../other/0000_PAGE_RESTRUCTURING_PROMPT_TEMPLATE.md) - Page restructuring guide

### Reference Implementations

- **00435-contracts-post-award** - Generic state-based button pattern
- **01900-procurement** - Discipline-specific state-based button pattern

### Code Repositories

- Client Components: `client/src/pages/`
- CSS Files: `client/src/common/css/pages/`
- Modal Components: `client/src/pages/.../modals/`

### Support Resources

- Construct AI Documentation: [Link to docs]
- Developer Channel: [Link to channel]
- Code Review Checklist: [Link to checklist]

---

**Document Version**: 1.0.0  
**Last Updated**: 2026-01-30  
**Status**: ✅ **Complete**  
**Next Review**: 2026-03-01
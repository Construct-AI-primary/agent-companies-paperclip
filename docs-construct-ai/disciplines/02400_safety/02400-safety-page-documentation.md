---
memory_layer: durable_knowledge
para_section: pages/disciplines
gigabrain_tags: disciplines, documentation
documentation
openstinger_context: discipline-knowledge
last_updated: 2026-03-30
related_docs:
  - disciplines/
---

# 02400 - Safety Discipline Page Documentation

## Overview

This document details the structure and functionality of the Safety discipline page (02400). This page provides comprehensive safety management capabilities with AI assistance for incident reporting, risk assessment, safety protocols, and compliance monitoring.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and safety analysis tools
- **Upserts** - Data modification operations
- **Workspace** - Workspace management and safety tools

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Safety Correspondence Reply** - Modal for safety correspondence replies
- **Generate Safety Report** - Safety report generation modal
- **Risk Assessment** - Safety risk assessment modal
- **Safety Image Analysis** - Safety image analysis modal

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **Advanced/Bulk** - Advanced bulk data operations modal
- **Cloud Import** - Cloud-based data upsert operations
- **Import from URL** - URL-based data upsert operations
- **Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Cross-Discipline Sharing** - Discipline permission matrix
- **Document Access** - Document access settings navigation
- **Document Editor** - Document editor navigation
- **Manage Workspaces** - Workspace management interface
- **Presentation** - Presentation editor navigation
- **Safety Analysis** - Safety analysis workspace modal
- **Safety Details** - Safety details modal
- **Spreadsheet** - Spreadsheet editor navigation
- **Vector Data Manager** - Vector data management tools

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page
- **CSS**: `A-2400-logout-button` class (uses template styling)

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "02400"
  - `disciplineCode`: "SAFETY"
  - `title`: "Safety Assistant"
  - `welcomeTitle`: "Safety Management Center"
  - `welcomeMessage`: "I can assist with safety protocols, incident reporting, risk assessment, and safety compliance."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `epcm-grid-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-02400-navigation-container`
- **Position**: Fixed at bottom center of viewport
- **CSS**: `position: fixed; left: 50%; bottom: 10px; transform: translateX(-50%)`
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `epcm-grid-container epcm-bg-light`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: Fixed positioning (implementation follows EPCM standards)

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("02400.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/02400-safety/components/02400-safety-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks with agent flow handling
- `fetchAgentFlowId()` - Fetches agent flow IDs for chatbot integration
- `handleRiskAssessmentSuccess()` - Handles risk assessment modal success callbacks
- `handleLogout()` - Manages user logout
- `getCurrentButtons()` - Returns buttons for current state

### Dependencies

- React hooks: `useState`, `useEffect`, `useCallback`
- Navigation: `useNavigate` from react-router-dom
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- Grid utilities: `calculateGridLayout`, `sortButtonsAlphabetically`
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider
- Privacy: `PrivacyConsentWrapper` component
- Agents: `SafetyImageAnalysisAgent` component

### CSS Classes Used

- `safety-page` - Main page container
- `page-background` - Background styling
- `A-02400-navigation-container` - Navigation container
- `A-02400-nav-row` - State button row
- `state-button` - Individual state buttons
- `epcm-grid-container` - Modal button container
- `epcm-bg-light` - Background styling for grid
- `epcm-grid-button` - Individual modal buttons
- `A-2400-logout-button` - Logout button (template styling)

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`
- Safety-specific modals: `SafetyReportGeneratorModal`, `SafetyRiskAssessmentModal`, `SafetyImageAnalysisModal`, `SafetyAnalysisWorkspaceModal`, `SafetyDetailsModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`, `02400-SafetyUpsertUnstructuredModal`
- Correspondence modal with category context and success callbacks

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Conditional Rendering**: Grid only renders when `currentState` is set
- **Agent Flow Integration**: Dynamic agent flow ID fetching for chatbot integration

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features specialized safety management and compliance capabilities
- Integrates privacy consent wrapper for data protection
- Includes advanced agent flow management for AI interactions

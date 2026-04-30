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

# 01700 - Logistics Discipline Page Documentation

## Overview

This document details the structure and functionality of the Logistics discipline page (01700). This page provides comprehensive supply chain and transportation management capabilities with AI assistance for logistics operations, shipping coordination, and transportation planning.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and logistics support tools
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for logistics correspondence replies
- **Logistics Documents Generator** - Logistics documents generation modal

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **Cloud Import** - Cloud-based data upsert operations
- **Import from URL** - URL-based data upsert operations
- **Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Timesheet** - Timesheet management modal
- **Access Permissions** - Access permission visualization
- **Cross-Discipline Sharing** - Discipline permission matrix
- **Manage Workspaces** - Workspace management interface
- **Vector Data Manager** - Vector data management tools

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "01700"
  - `disciplineCode`: "01700"
  - `title`: "Logistics Assistant"
  - `welcomeTitle`: "Logistics Operations Center"
  - `welcomeMessage`: "Supply chain and transportation management with AI"
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

- **Container**: `A-01700-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
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
- **Image Path**: `getThemedImagePath("01700.png", "mining")`
- **Note**: Uses "mining" theme parameter
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/01700-logistics/components/01700-logistics-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks
- `handleOpenModal()` - Handles modal opening with discipline context
- `handleLogout()` - Manages user logout
- `getCurrentButtons()` - Returns buttons for current state

### Dependencies

- React hooks: `useState`, `useEffect`
- Navigation: `useNavigate` from react-router-dom
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- Grid utilities: `calculateGridLayout`, `sortButtonsAlphabetically`
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider
- Logistics modal: `useLogisticsModal` hook
- Dev tools: `DevModeToolbar` component

### CSS Classes Used

- `logistics-page` - Main page container
- `page-background` - Background styling
- `A-01700-navigation-container` - Navigation container
- `A-01700-nav-row` - State button row
- `state-button` - Individual state buttons
- `epcm-grid-container` - Modal button container
- `epcm-bg-light` - Background styling for grid
- `epcm-grid-button` - Individual modal buttons

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Logistics-specific modals: `LogisticsModal` with custom hook integration
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Conditional Rendering**: Grid only renders when `currentState` is set

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features specialized logistics and supply chain management capabilities
- Includes custom logistics modal hook for enhanced functionality

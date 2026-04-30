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

# 00889 - Director Finance Discipline Page Documentation

## Overview

This document details the structure and functionality of the Director Finance discipline page (00889). This page provides executive-level financial oversight and management capabilities with AI assistance.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for director-level finance correspondence replies

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
  - `pageId`: "00889"
  - `disciplineCode`: "DIRECTOR_FINANCE"
  - `title`: "Director Finance Assistant"
  - `welcomeTitle`: "Director Finance Command Center"
  - `welcomeMessage`: "I can help you with director finance processes and requirements."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `A-00889-modal-trigger-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-00889-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-00889-button-container`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; left: 50%; top: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners
- **Animation**: Opacity fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 10px; left: 10px; z-index: 300`

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00889.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Additional Features

### Page Title Management

- **Document Title**: Dynamically set to "Director Finance" using `document.title`
- **Implementation**: useEffect hook that runs once on component mount
- **Purpose**: Provides proper browser tab title for the director finance page

### State Toggle Behavior

- **Toggle Functionality**: State buttons can be toggled on/off by clicking the same button
- **Implementation**: `handleStateChange` checks if newState equals currentState, sets to null if so
- **Purpose**: Allows users to close the modal grid by clicking the active state button again

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00889-director-finance/components/00889-director-finance-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks with toggle functionality
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

### CSS Classes Used

- `director-finance-page` - Main page container
- `page-background` - Background styling
- `A-00889-navigation-container` - Navigation container
- `A-00889-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-00889-button-container` - Modal button container
- `A-00889-modal-trigger-button` - Individual modal buttons
- `logout-button` - Logout button styling

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Toggle Behavior**: Clicking active state button sets state to null
- **Conditional Rendering**: Grid only renders when `currentState` is set and buttons exist

### Browser Integration

- **Document Title**: Dynamically updates browser tab title
- **Purpose**: Provides clear page identification in browser tabs
- **Implementation**: Direct DOM manipulation in useEffect

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features executive-level finance management capabilities
- Implements toggle-based state management for improved UX

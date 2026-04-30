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

# 01200 - Finance Discipline Page Documentation

## Overview

This document details the structure and functionality of the Finance discipline page (01200). This page provides comprehensive financial management and reporting capabilities with AI assistance for budgeting, forecasting, and financial analysis.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for finance correspondence replies

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
  - `pageId`: "01200"
  - `disciplineCode`: "FINANCE"
  - `title`: "Finance Assistant"
  - `welcomeTitle`: "Finance Command Center"
  - `welcomeMessage`: "Financial management and reporting with AI"
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `modal-trigger-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-01200-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-01200-button-container`
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
- **Image Path**: `getThemedImagePath("01200.png", "mining")`
- **Note**: Uses "mining" theme parameter
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/01200-finance/components/01200-finance-page.js`

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

### CSS Classes Used

- `finance-page` - Main page container
- `page-background` - Background styling
- `A-01200-navigation-container` - Navigation container
- `A-01200-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-01200-button-container` - Modal button container
- `modal-trigger-button` - Individual modal buttons

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
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
- Features specialized financial management and reporting capabilities

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

# 00880 - Board of Directors Discipline Page Documentation

## Overview

This document details the structure and functionality of the Board of Directors discipline page (00880).

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upsert** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for board correspondence replies

### Upsert State

When the "Upsert" state button is clicked, the following buttons are displayed:

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
- **Styling**: Custom styling with orange border and background

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "00880"
  - `disciplineCode`: "BOARD_OF_DIRECTORS"
  - `title`: "BOARD OF DIRECTORS Assistant"
  - `welcomeTitle`: "BOARD OF DIRECTORS Command Center"
  - `welcomeMessage`: "I can help you with board of directors processes and requirements."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)
- **Positioning**: Fixed at bottom-right of viewport

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `A-00880-modal-trigger-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: Button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-00880-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-00880-button-container`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 10px; left: 10px; z-index: 300`
- **Styling**: Custom background and border colors

### Chatbot Container

- **Position**: Fixed at bottom-right
- **CSS**: `position: fixed; bottom: 20px; right: 20px; z-index: 250`
- **Size Constraints**: `maxWidth: 400px; maxHeight: 60vh`

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00880.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`
  - `zIndex: -1` (behind content)

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00880-board-of-directors/components/00880-board-of-directors-page.js`

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

- `board-of-directors-page` - Main page container
- `page-background` - Background styling
- `A-00880-navigation-container` - Navigation container
- `A-00880-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-00880-button-container` - Modal button container
- `A-00880-modal-trigger-button` - Individual modal buttons
- `A-00880-logout-button` - Logout button
- `epcm-logout-aligned` - EPCM logout alignment
- `A-00880-chatbot-container` - Chatbot container
- `epcm-chatbot-aligned` - EPCM chatbot alignment

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upsert"`, `"workspace"`
- **Conditional Rendering**: Grid only renders when `currentState` is set and buttons exist

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Custom styling for board-specific requirements while maintaining framework consistency

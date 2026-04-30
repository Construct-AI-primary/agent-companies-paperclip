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

# 00872 - Developer Discipline Page Documentation

## Overview

This document details the structure and functionality of the Developer discipline page (00872). This page provides development tools and resources with AI assistance for software development workflows.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for developer correspondence replies

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **Cloud Upsert** - Cloud-based data upsert operations
- **Upsert from URL** - URL-based data upsert operations
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
  - `pageId`: "00872"
  - `disciplineCode`: "DEVELOPER"
  - `title`: "Developer Assistant"
  - `welcomeTitle`: "Developer Command Center"
  - `welcomeMessage`: "development tools and resources with AI"
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

- **Container**: `A-00872-navigation-container`
- **Position**: Fixed at bottom center of viewport
- **CSS**: `position: fixed; left: 50%; bottom: 10px; transform: translateX(-50%)`
- **Layout**: Vertical stack with state buttons row and page title

### Modal Button Grid

- **Container**: `A-00872-button-container`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 20px; left: 20px; z-index: 300`

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00872.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `height: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00872-developer/components/00872-developer-page.js`

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

- `developer-page` - Main page container
- `page-background` - Background styling
- `A-00872-navigation-container` - Navigation container
- `A-00872-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-00872-button-container` - Modal button container
- `modal-trigger-button` - Individual modal buttons
- `logout-button` - Logout button styling

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Conditional Rendering**: Grid only renders when `currentState` is set and buttons exist

### Data Attributes

- **Button Attributes**: Includes `data-modal-trigger` and `data-button-state` for enhanced debugging
- **Purpose**: Facilitates automated testing and debugging of modal interactions

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features development-focused chatbot with technical assistance capabilities

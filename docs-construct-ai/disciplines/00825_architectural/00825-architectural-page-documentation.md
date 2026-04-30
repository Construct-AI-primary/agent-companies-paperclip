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

# 00825 - Architectural Discipline Page Documentation

## Overview

This document details the structure and functionality of the Architectural discipline page (00825).

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for architectural correspondence replies
- **Drawing Analysis** - Modal for architectural drawing analysis

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
  - `pageId`: "00825"
  - `disciplineCode`: "ARCHITECTURAL"
  - `title`: "Architectural Assistant"
  - `welcomeTitle`: "Architectural Command Center"
  - `welcomeMessage`: "Architectural operations and management with AI"
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

- **Container**: `A-00825-navigation-container`
- **Position**: Fixed at bottom center of viewport
- **CSS**: `position: fixed; left: 50%; bottom: calc(10px + 1.5em + 10px); transform: translateX(-50%)`

### Modal Button Grid

- **Container**: `epcm-grid-container epcm-bg-light`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 10px; left: 10px; z-index: 300`

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00825.png", "mining")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00825-architectural/components/00825-architectural-page.js`

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

- `architectural-page` - Main page container
- `page-background` - Background styling
- `epcm-architectural` - Discipline-specific styling
- `A-00825-navigation-container` - Navigation container
- `A-00825-nav-row` - State button row
- `state-button` - Individual state buttons
- `epcm-grid-container` - Modal button container
- `epcm-bg-light` - Background styling for grid
- `epcm-grid-button` - Individual modal buttons
- `logout-button` - Logout button styling

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Custom modal: `00825-03-DrawingsAnalysisModal`

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design

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

# 00300 - Construction Discipline Page Documentation

## Overview

This document details the structure and functionality of the Construction discipline page (00300).

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for construction correspondence replies

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
- **Styling**: Custom styling with dark background and orange border

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "00300"
  - `disciplineCode`: "CONSTRUCTION"
  - `title`: "Construction Assistant"
  - `welcomeTitle`: "Construction Command Center"
  - `welcomeMessage`: "I can assist with construction planning, safety requirements, quality control, and project documentation."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)
- **Positioning**: Fixed at bottom-right of viewport

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `modal-trigger-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-00300-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-00300-button-container`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 20px; left: 20px; z-index: 300`
- **Styling**: Dark background with orange border

### Chatbot Container

- **Position**: Fixed at bottom-right
- **CSS**: `position: fixed; bottom: 20px; right: 20px; z-index: 250`
- **Size Constraints**: `maxWidth: 400px; maxHeight: 60vh`

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00300.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Additional Features

### Contractor Vetting Component

- **Component**: `ContractorVettingPageComponent` from `01850-other-parties`
- **Trigger**: Controlled by `showVettingComponent` state
- **UI**: Full-screen overlay with blur backdrop
- **Styling**: Modal-style container with close button
- **Purpose**: Construction department access to contractor vetting functionality

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00300-construction/components/00300-construction-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks
- `handleOpenModal()` - Handles modal opening with discipline context
- `handleLogout()` - Manages user logout
- `getCurrentButtons()` - Returns buttons for current state

### Dependencies

- React hooks: `useState`, `useEffect`
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- Grid utilities: `calculateGridLayout`, `sortButtonsAlphabetically`
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider
- Contractor Vetting: `ContractorVettingPageComponent`

### CSS Classes Used

- `construction-page` - Main page container
- `page-background` - Background styling
- `A-00300-navigation-container` - Navigation container
- `A-00300-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-00300-button-container` - Modal button container
- `modal-trigger-button` - Individual modal buttons
- `A-00300-logout-button` - Logout button
- `epcm-logout-aligned` - EPCM logout alignment
- `A-00300-chatbot-container` - Chatbot container
- `epcm-chatbot-aligned` - EPCM chatbot alignment
- `vetting-overlay` - Contractor vetting overlay
- `vetting-container` - Contractor vetting container
- `vetting-close-button` - Close button for vetting overlay

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Additional State**: `showVettingComponent` for contractor vetting overlay
- **Conditional Rendering**: Grid only renders when `currentState` is set and buttons exist

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Integrates specialized contractor vetting functionality for construction workflows

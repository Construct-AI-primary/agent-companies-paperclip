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

# 00400 - Contracts Discipline Page Documentation

## Overview

This document details the structure and functionality of the Contracts discipline page (00400).

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for contracts correspondence replies

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **Cloud Import** - Cloud-based data upsert operations
- **Import from URL** - URL-based data upsert operations
- **Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Timesheet** - Timesheet management modal
- **Document Access** - Navigation to document access settings page (`/0165-ui-settings#document-access`)
- **Cross-Discipline Sharing** - Discipline permission matrix
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
  - `pageId`: "00400"
  - `disciplineCode`: "CONTRACTS"
  - `title`: "Contracts Assistant"
  - `welcomeTitle`: "Contracts Command Center"
  - `welcomeMessage`: "I can help with contract management, document analysis, compliance tracking, and legal workflows. I understand contract terminology and can assist with your contracting processes."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `modal-trigger-button` class with inline styling:
  - `minWidth: 200px`
  - `padding: "12px 24px"`
  - `borderRadius: 20px`
  - `fontSize: "0.9rem"`
  - `fontWeight: 500`
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-00400-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-00400-button-container`
- **Position**: Fixed at viewport center (50% 50%)
- **CSS**: `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: CSS Grid with dynamic columns based on button count
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `position: fixed; bottom: 20px; left: 20px; z-index: 300`
- **Styling**: Dark background with orange border

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00400.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Additional Features

### Navigation Actions

- **Document Access Button**: Unlike other buttons that open modals, this button performs navigation
- **Implementation**: Uses `navigate(button.path)` to redirect to `/0165-ui-settings#document-access`
- **Purpose**: Direct access to document access settings within the UI settings page

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00400-contracts/components/00400-contracts-page.js`

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

- `contracts-page` - Main page container
- `page-background` - Background styling
- `A-00400-navigation-container` - Navigation container
- `A-00400-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-00400-button-container` - Modal button container
- `modal-trigger-button` - Individual modal buttons
- `A-00400-logout-button` - Logout button
- `epcm-logout-aligned` - EPCM logout alignment

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Correspondence modal with category context
- Navigation actions for specific buttons

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upserts"`, `"workspace"`
- **Conditional Rendering**: Grid only renders when `currentState` is set and buttons exist

### Button Action Types

- **Modal Actions**: Most buttons open modals using `handleOpenModal()`
- **Navigation Actions**: "Document Access" button uses `navigate()` for page redirection
- **Mixed Implementation**: Supports both modal and navigation patterns within the same grid system

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Supports both modal and navigation action types for flexible user interactions

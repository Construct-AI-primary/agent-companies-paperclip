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

# 00887 - Director Sales Discipline Page Documentation

## Overview

This document details the structure and functionality of the Director Sales discipline page (00887). **Note: This page has not been implemented yet and is currently a placeholder.**

## Implementation Status

- **Status**: Not Implemented
- **Directory**: `client/src/pages/00887-director-sales/` (exists but empty)
- **Components**: None
- **Expected Implementation**: Based on EPCM page standardization patterns

## Expected State Buttons

The discipline page is expected to contain the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Expected Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are expected to be displayed:

- **Correspondence Reply** - Modal for director-level sales correspondence replies

### Upserts State

When the "Upserts" state button is clicked, the following buttons are expected to be displayed:

- **Cloud Import** - Cloud-based data upsert operations
- **Import from URL** - URL-based data upsert operations
- **Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are expected to be displayed:

- **Timesheet** - Timesheet management modal
- **Access Permissions** - Access permission visualization
- **Cross-Discipline Sharing** - Discipline permission matrix
- **Manage Workspaces** - Workspace management interface
- **Vector Data Manager** - Vector data management tools

## Expected Logout Functionality

- **Present**: Expected to be Yes
- **Implementation**: Expected to use `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Expected logout button with SVG icon positioned at bottom-left of the page
- **Styling**: Expected custom styling with orange border and semi-transparent background

## Expected Chatbot Functionality

- **Present**: Expected to be Yes
- **Component**: Expected to use `ChatbotBase`
- **Configuration**:
  - `pageId`: "00887"
  - `disciplineCode`: "DIRECTOR_SALES"
  - `title`: "DIRECTOR SALES Assistant"
  - `welcomeTitle`: "DIRECTOR SALES Command Center"
  - `welcomeMessage`: "I can help you with director sales processes and requirements."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Expected orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Expected Button Sizes

- **State Buttons**: Expected standard `state-button` class
- **Modal Buttons**: Expected `modal-trigger-button` class
- **Grid Layout**: Expected dynamic calculation using `calculateGridLayout()` utility
- **Button Sorting**: Expected alphabetical sorting using `sortButtonsAlphabetically()`

## Expected Button Positioning

### State Navigation

- **Container**: Expected `A-00887-navigation-container`
- **Position**: Expected fixed positioning (following EPCM standards)
- **Layout**: Expected horizontal row of state buttons

### Modal Button Grid

- **Container**: Expected `A-00887-button-container`
- **Position**: Expected fixed at viewport center (50% 50%)
- **CSS**: Expected `position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%)`
- **Layout**: Expected CSS Grid with dynamic columns based on button count
- **Styling**: Expected semi-transparent background with rounded corners and shadow
- **Animation**: Expected fade-in effect with visibility state

### Logout Button

- **Position**: Expected fixed at bottom-left
- **CSS**: Expected `position: fixed; bottom: 10px; left: 10px; z-index: 300`
- **Styling**: Expected custom background and border colors, circular design

### Chatbot Container

- **Position**: Expected fixed at bottom-right
- **CSS**: Expected fixed positioning (following EPCM standards)
- **Size Constraints**: Expected standard chatbot dimensions

## Expected Background Image

- **Present**: Expected to be Yes
- **Implementation**: Expected `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: Expected `getThemedImagePath("00887.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Expected Technical Implementation Details

### Expected File Location

- **Path**: `client/src/pages/00887-director-sales/components/00887-director-sales-page.js`

### Expected Key Functions

- `handleStateChange()` - Expected state button management
- `handleOpenModal()` - Expected modal opening with discipline context
- `handleLogout()` - Expected user logout management
- `getCurrentButtons()` - Expected button array retrieval

### Expected Dependencies

- React hooks: `useState`, `useEffect`
- Navigation: `useNavigate` from react-router-dom
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- Grid utilities: `calculateGridLayout`, `sortButtonsAlphabetically`
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider

### Expected CSS Classes Used

- `director-sales-page` - Expected main page container
- `page-background` - Expected background styling
- `A-00887-navigation-container` - Expected navigation container
- `A-00887-nav-row` - Expected state button row
- `state-button` - Expected individual state buttons
- `A-00887-button-container` - Expected modal button container
- `modal-trigger-button` - Expected individual modal buttons
- `logout-button` - Expected logout button styling

### Expected Modal Integration

- Expected shared modal system with discipline-specific context
- Expected special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Expected upsert modals: `UpsertCloudModal`, `UpsertUrlModal`, `UpsertFileModal`
- Expected correspondence modal with category context

### Expected State Management

- **Initial State**: Expected `null` (prevents flash on load)
- **State Values**: Expected `"agents"`, `"upserts"`, `"workspace"`
- **Conditional Rendering**: Expected grid only renders when `currentState` is set

## Implementation Notes

This page follows the standard EPCM discipline page pattern but has not been implemented yet. When implemented, it should follow the same architectural patterns as other director-level pages (00882-00889) including:

- Shared modal system integration
- EPCM grid layout utilities
- Standardized chatbot implementation
- Proper state management and animation
- Responsive design and accessibility features

## Compliance Notes

- Expected to follow EPCM page standardization patterns
- Expected to use shared grid utilities and modal framework
- Expected to implement proper state management and animation
- Expected to include accessibility features and responsive design
- Expected to feature executive-level sales management capabilities

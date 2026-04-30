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

# 02050 - Information Technology Discipline Page Documentation

## Overview

This document details the structure and functionality of the Information Technology discipline page (02050). This page provides comprehensive IT services and support capabilities with AI assistance for technology management, cybersecurity, and digital transformation initiatives.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and IT support tools
- **Upserts** - Data modification operations
- **Workspace** - Workspace management and IT tools

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Method Statement** - Method statement generation modal
- **Risk Assessment** - Risk assessment modal
- **✉️ Correspondence Reply** - Correspondence reply modal

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **☁️ Cloud Import** - Cloud-based data upsert operations
- **🌐 Import from URL** - URL-based data upsert operations
- **📄 Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Timesheet** - Timesheet management modal
- **Open Development Modal** - Development environment access
- **📄 Document Access** - Navigation to document access settings (`/0165-ui-settings#document-access`)
- **🔗 Cross-Discipline Sharing** - Discipline permission matrix
- **📊 Vector Data Manager** - Vector data management tools

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page
- **CSS**: `A-02050-logout-button` class

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "02050"
  - `disciplineCode`: "INFORMATION_TECHNOLOGY"
  - `title`: "Information Technology Assistant"
  - `welcomeTitle`: "Information Technology Command Center"
  - `welcomeMessage`: "IT services and support with AI"
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

- **Container**: `A-02050-navigation-container`
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
- **Image Path**: `getThemedImagePath("02050.png", "mining")`
- **Note**: Uses "mining" theme parameter
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/02050-information-technology/components/02050-information-technology-page.js`

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
- Custom modals: `UpsertFileModal`, `UpsertUrlModal`, `UpsertCloudModal`, `VectorDataManagerModal`

### CSS Classes Used

- `information-technology-page` - Main page container
- `page-background` - Background styling
- `A-02050-navigation-container` - Navigation container
- `A-02050-nav-row` - State button row
- `state-button` - Individual state buttons
- `epcm-grid-container` - Modal button container
- `epcm-bg-light` - Background styling for grid
- `epcm-grid-button` - Individual modal buttons
- `A-02050-logout-button` - Logout button

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`
- Custom IT-specific modals: `MethodStatementModal`, `RiskAssessmentModal`
- Upsert modals: `02050-UpsertCloudModal`, `02050-UpsertUrlModal`, `02050-UpsertFileModal`
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
- Features specialized information technology and digital services capabilities
- Includes custom modal components for IT-specific operations

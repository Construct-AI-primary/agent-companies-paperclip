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

# 00875 - Sales Discipline Page Documentation

## Overview

This document details the structure and functionality of the Sales discipline page (00875). This page provides sales process management capabilities with AI assistance for lead qualification, pricing strategies, and customer relationship management.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and correspondence management
- **Upserts** - Data modification operations
- **Workspace** - Workspace management

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **✉️ Correspondence Reply** - Modal for sales correspondence replies

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **☁️ Cloud Import** - Cloud-based data upsert operations
- **🌐 Import from URL** - URL-based data upsert operations
- **📄 Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **📄 Document Access** - Navigation to document access settings page (`/0165-ui-settings#document-access`)
- **🔗 Cross-Discipline Sharing** - Discipline permission matrix
- **📊 Vector Data Manager** - Vector data management tools

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "00875"
  - `disciplineCode`: "SALES"
  - `title`: "Sales Assistant"
  - `welcomeTitle`: "Sales Command Center"
  - `welcomeMessage`: "sales process management with AI"
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)
- **Note**: Always visible (not conditional on currentState)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `modal-trigger-button` class
- **Grid Layout**: Uses `A-087-button-container` (note: different class naming convention)
- **Button Sorting**: Not explicitly sorted (buttons maintain defined order)

## Button Positioning

### State Navigation

- **Container**: `A-00875-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-087-button-container` (note: abbreviated class name)
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Grid layout (specific implementation may vary)
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: Fixed positioning (implementation follows EPCM standards)

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00875.png", "mining")`
- **Note**: Uses "mining" theme parameter
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Additional Features

### Emoji Integration

- **Button Labels**: All button labels include emoji prefixes for visual enhancement
- **Examples**:
  - ✉️ Correspondence Reply
  - ☁️ Cloud Import
  - 🌐 Import from URL
  - 📄 Upsert Files
  - 📄 Document Access
  - 🔗 Cross-Discipline Sharing
  - 📊 Vector Data Manager

### Always-Visible Chatbot

- **Implementation**: Chatbot renders outside of state conditional logic
- **Purpose**: Provides constant AI assistance regardless of current page state
- **Benefit**: Ensures sales guidance is always accessible

### Custom Modal Imports

- **Upsert Modals**: Uses page-specific modal components
  - `00875-UpsertCloudModal`
  - `00875-UpsertUrlModal`
  - `00875-UpsertFileModal`
- **Vector Data Manager**: Uses page-specific `00875-VectorDataManagerModal`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00875-sales/components/00875-sales-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks
- `handleOpenModal()` - Handles modal opening with discipline context
- `handleLogout()` - Manages user logout

### Dependencies

- React hooks: `useState`, `useEffect`
- Navigation: `useNavigate` from react-router-dom
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider
- Custom modals: Page-specific upsert and vector data manager modals

### CSS Classes Used

- `sales-page` - Main page container
- `page-background` - Background styling
- `A-00875-navigation-container` - Navigation container
- `A-00875-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-087-button-container` - Modal button container (abbreviated)
- `modal-trigger-button` - Individual modal buttons

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`
- Custom upsert modals with page-specific implementations
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
- Features specialized sales process management capabilities
- Implements emoji-enhanced UI for improved user experience
- Provides always-accessible AI assistance through persistent chatbot

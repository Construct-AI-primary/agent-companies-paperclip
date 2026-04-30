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

# 01900 - Procurement Discipline Page Documentation

## Overview

This document details the structure and functionality of the Procurement discipline page (01900). This page provides comprehensive procurement and supply chain management capabilities with AI assistance for supplier management, contract procurement, and procurement workflows.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and procurement order creation
- **Upserts** - Data modification operations
- **Workspace** - Workspace management and supplier tools

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Correspondence Reply** - Modal for procurement correspondence replies
- **Create Procurement Order** - Modal for creating new procurement orders

### Upserts State

When the "Upserts" state button is clicked, the following buttons are displayed:

- **Cloud Upsert** - Cloud-based data upsert operations
- **Upsert from URL** - URL-based data upsert operations
- **Upsert Files** - File-based data upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Timesheet** - Timesheet management modal
- **Access Permissions** - Access permission visualization
- **Contact Scraper** - Contact information scraping tools
- **Cross-Discipline Sharing** - Discipline permission matrix
- **Manage Workspaces** - Workspace management interface
- **Supplier Setup** - Supplier configuration and management
- **Vector Data Manager** - Vector data management tools

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ProcurementChatbot`
- **Configuration**:
  - `pageId`: "01900"
  - `disciplineCode`: "01900"
  - `title`: "Procurement Assistant"
  - `welcomeTitle`: "Procurement Intelligence"
  - `welcomeMessage`: "I can help with procurement queries, document analysis, contract terms, and supplier information."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
  - HITL (Human-in-the-Loop) with confidence threshold 0.7
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `modal-trigger-button` class
- **Grid Layout**: Dynamically calculated using `calculateGridLayout()` utility
- **Button Sorting**: All button arrays are sorted alphabetically using `sortButtonsAlphabetically()`

## Button Positioning

### State Navigation

- **Container**: `A-01900-navigation-container`
- **Position**: Fixed at bottom center of viewport
- **CSS**: `position: fixed; left: 50%; bottom: 10px; transform: translateX(-50%)`
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-01900-button-container`
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
- **Image Path**: `getThemedImagePath("01900.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/01900-procurement/components/01900-procurement-page.js`

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
- Chatbot: `ProcurementChatbot` component
- Accordion: `AccordionComponent` with provider
- Workflow: `ProcurementWorkflowOrchestrator` component

### CSS Classes Used

- `procurement-page` - Main page container
- `page-background` - Background styling
- `A-01900-navigation-container` - Navigation container
- `A-01900-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-01900-button-container` - Modal button container
- `modal-trigger-button` - Individual modal buttons

### Modal Integration

- Uses shared modal system with discipline-specific context
- Special handling for: `DisciplinePermissionMatrixModal`, `VectorDataManagerModal`, `WorkspaceManagementModal`, `AccessPermissionVisualizerModal`
- Procurement-specific modals: `01900-ContactScraperModal`, `01900-SupplierSetupModal`, `01900-ProcurementInputAgentModal`
- Upsert modals: `01900-UpsertCloudModal`, `01900-UpsertUrlModal`, `01900-UpsertFileModal`
- Correspondence modal with category context

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"suppliers"`, `"vetting"`
- **Conditional Rendering**: Grid only renders when `currentState` is set

### Advanced Features

- **Procurement Workflow Orchestrator**: Advanced workflow management system
- **HITL Integration**: Human-in-the-Loop capabilities with confidence thresholds
- **Supplier Management**: Integrated supplier setup and contact scraping
- **Contractor Vetting**: Access to contractor vetting components
- **Document Type Selection**: Specialized document type selector component

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features specialized procurement and supply chain management capabilities
- Includes advanced workflow orchestration and HITL capabilities

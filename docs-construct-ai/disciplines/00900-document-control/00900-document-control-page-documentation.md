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

# 00900 - Document Control Discipline Page Documentation

## Overview

This document details the structure and functionality of the Document Control discipline page (00900). This page provides comprehensive document management and control capabilities with AI assistance for document processing, quality assurance, and compliance workflows.

## State Buttons

The discipline page contains the following state buttons in the navigation row:

- **Agents** - AI agent interactions and document analysis tools
- **Upsert** - Data modification and document upload operations
- **Workspace** - Workspace management and document viewing

## Buttons by State

### Agents State

When the "Agents" state button is clicked, the following buttons are displayed:

- **Ask Document Question** - Interactive Q&A modal for document queries
- **Method Statement** - Method statement generation and management
- **Risk Assessment** - Risk assessment document processing
- **Summarize Document** - Document summarization and analysis

### Upsert State

When the "Upsert" state button is clicked, the following buttons are displayed:

- **Upload Document** - Direct document upload functionality
- **Upsert URL** - URL-based document upsert operations
- **Upsert Cloud** - Cloud-based document upsert operations
- **Upsert File** - File-based document upsert operations

### Workspace State

When the "Workspace" state button is clicked, the following buttons are displayed:

- **Open Development Modal** - Development environment access
- **View Document Details** - Document details and metadata viewing

## Logout Functionality

- **Present**: Yes
- **Implementation**: `handleLogout` function that calls `window.handleLogout()`
- **UI Element**: Logout button with SVG icon positioned at bottom-left of the page

## Chatbot Functionality

- **Present**: Yes
- **Component**: `ChatbotBase`
- **Configuration**:
  - `pageId`: "00900"
  - `disciplineCode`: "DOCUMENT_CONTROL"
  - `title`: "DOCUMENT CONTROL Assistant"
  - `welcomeTitle`: "DOCUMENT CONTROL Command Center"
  - `welcomeMessage`: "I can help you with document control processes and requirements."
- **Features Enabled**:
  - Citations
  - Document count
  - Conversation history
- **Theme**: Orange color scheme (primary: #FF8C00, secondary: #FFA500)
- **Conditional Rendering**: Only displays when `currentState` is set

## Button Sizes

- **State Buttons**: Standard `state-button` class
- **Modal Buttons**: `A-00900-modal-trigger-button` class
- **Grid Layout**: Uses `A-0900-button-container` (note: abbreviated class naming)
- **Button Sorting**: Buttons maintain defined order (not alphabetically sorted)

## Button Positioning

### State Navigation

- **Container**: `A-00900-navigation-container`
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Horizontal row of state buttons

### Modal Button Grid

- **Container**: `A-0900-button-container` (note: abbreviated class name)
- **Position**: Fixed positioning (implementation follows EPCM standards)
- **Layout**: Grid layout (specific implementation may vary)
- **Styling**: Semi-transparent background with rounded corners and shadow
- **Animation**: Fade-in effect with `isButtonContainerVisible` state

### Logout Button

- **Position**: Fixed at bottom-left
- **CSS**: `A-2400-logout-button` class (uses template styling)

## Background Image

- **Present**: Yes
- **Implementation**: `backgroundImage: url(${backgroundImagePath})`
- **Image Path**: `getThemedImagePath("00900.png")`
- **Styling**:
  - `backgroundSize: "cover"`
  - `backgroundPosition: "center bottom"`
  - `backgroundRepeat: "no-repeat"`
  - `backgroundAttachment: "fixed"`
  - `minHeight: "100vh"`

## Additional Features

### Multi-View Architecture

- **Component Structure**: Uses separate view components for each state
  - `AgentsView` - Specialized agent interaction interface
  - `UpsertView` - Document upload and modification interface
  - `WorkspaceView` - Workspace management interface
- **Conditional Rendering**: Different views render based on `currentState`
- **Purpose**: Provides specialized interfaces for different document control functions

### Advanced Modal System

- **Custom Modal IDs**: Uses prefixed modal identifiers (e.g., `A-0900-03-02-modal-qa-doc-input`)
- **Specialized Modals**: Document-specific modals for Q&A, summarization, and details
- **Data Attributes**: Buttons include `data-modal-target` attributes for enhanced modal routing
- **Modal Provider Integration**: Leverages shared modal system with discipline-specific context

### Document Control Specific Features

- **Document Analysis Tools**: Ask questions, summarize documents, generate method statements
- **Quality Assurance**: Risk assessment and document validation capabilities
- **Upload Management**: Multiple upload methods (direct, URL, cloud, file)
- **Development Integration**: Access to development environment modals

## Technical Implementation Details

### File Location

- **Path**: `client/src/pages/00900-document-control/components/00900-document-control-page.js`

### Key Functions

- `handleStateChange()` - Manages state button clicks
- `handleModalClick()` - Handles modal opening with custom logic
- `handleLogout()` - Manages user logout

### Dependencies

- React hooks: `useState`, `useEffect`
- Modal system: `useModal` hook
- UI utilities: `settingsManager`, `getThemedImagePath`
- View components: `AgentsView`, `UpsertView`, `WorkspaceView`
- Modal components: Custom document control modals
- Chatbot: `ChatbotBase` component
- Accordion: `AccordionComponent` with provider

### CSS Classes Used

- `document-control-page` - Main page container
- `page-background` - Background styling
- `A-00900-navigation-container` - Navigation container
- `A-00900-nav-row` - State button row
- `state-button` - Individual state buttons
- `A-0900-button-container` - Modal button container (abbreviated)
- `A-00900-modal-trigger-button` - Individual modal buttons
- `A-2400-logout-button` - Logout button (template styling)

### Modal Integration

- Uses shared modal system with discipline-specific context
- Custom modal handling for document-specific operations
- Special handling for: upsert modals, correspondence modal, development modal
- Data attribute-based modal targeting for enhanced functionality

### State Management

- **Initial State**: `null` (prevents flash on load)
- **State Values**: `"agents"`, `"upsert"`, `"workspace"`
- **Conditional Rendering**: Grid and views only render when `currentState` is set

## Compliance Notes

- Follows EPCM page standardization patterns
- Uses shared grid utilities and modal framework
- Implements proper state management and animation
- Includes accessibility features and responsive design
- Features specialized document control and management capabilities
- Implements multi-view architecture for enhanced user experience
- Provides comprehensive document analysis and quality assurance tools

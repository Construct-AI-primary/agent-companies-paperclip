---
memory_layer: durable_knowledge
para_section: pages/codebase/procedures/documentation
gigabrain_tags: procedures, documentation, codebase
documentation
openstinger_context: operational-procedures, documentation-practices
last_updated: 2026-03-21
related_docs:
  - codebase/procedures/
  - disciplines/
---
# Page Implementation Procedure - Unified Standard

## Overview

This document establishes the **single source of truth** for implementing all **new** pages in the ConstructAI system. It combines and rationalizes requirements from the New Page Implementation Workflow, Page Implementation Procedure, CSS Inventory, Visual Design Standards, and Template Standardization Plan to provide a unified, authoritative procedure for page development.

**Document Purpose:**
- ✅ Step-by-step workflow for adding new pages
- ✅ Detailed implementation specifications and code templates
- ✅ Page type categorization and decision guidance
- ✅ Quality assurance checklists
- ✅ Common patterns and anti-patterns

---

## 📋 Quick Start: Implementation Procedure Selection

### Decision Tree: Which Procedure to Use?

```
Need to implement a page/workflow?
├── Basic page (< 5 AI prompts, standard features)
│   ├── Has background image? → Use BACKGROUND PAGE specifications below
│   └── No background image → Use NO-BACKGROUND PAGE specifications below
├── Workflow automation (4-8 AI prompts, basic HITL)
│   └── Use 0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md
└── Complex workflow (15+ AI prompts, enterprise integrations)
    └── Use 0002_AGENT_CENTRIC_WORKFLOW_PAGE_IMPLEMENTATION_PROCEDURE.md
        └── Reference: appendix_d_training_materials_modifications.md
        └── Resources: PROCUREMENT_WORKFLOW_AGENT_PROMPTS_INVENTORY...
```

### **You Are Here: 0000_PAGE_IMPLEMENTATION_PROCEDURE.md**

**✅ This procedure is correct if you need:**
- Basic pages with minimal AI integration (< 5 prompts)
- Standard navigation and styling patterns
- Simple CRUD operations and data display
- Template A compliance and accordion integration
- No complex workflow automation or enterprise integrations

**❌ Not for:**
- Pages requiring 15+ AI agent prompts
- Complex agent orchestration workflows
- Enterprise system integrations (Gantt, HITL, sequences)
- Advanced developer testing frameworks

---

## 📋 Page Type Categorization System

### Background Image Policy (CRITICAL)

```javascript
// ✅ ONLY 2 PAGE TYPES ALLOWED BACKGROUND IMAGES:
const ALLOWED_BACKGROUND_PAGES = [
  "LANDING_PAGES",      // Homepage/welcome pages (passive, no buttons)
  "ADMIN_DASHBOARDS"    // Administrative interfaces (active, has buttons)
];

// ❌ ALL OTHER PAGES: NO BACKGROUNDS ALLOWED
const NO_BACKGROUND_PAGES = [
  "DATA_MANAGEMENT", "WORKFLOW_PROCESSING", "FORM_ONBOARDING",
  "DOCUMENT_PROCESSING", "TIME_TRACKING", "PROJECT_MANAGEMENT",
  "REPORTING_DASHBOARDS", "UTILITY_CONFIGURATION"
];
```

### Category A: Pages WITH Background Images (2 Types)

#### **1. Landing Pages** - Welcome/marketing pages, no interactive buttons
**Characteristics:**
- ✅ Background image (themed/mining)
- ❌ **NO state buttons** (Agents/Upsert/Workspace)
- ❌ **NO modal buttons**
- 🎯 **Purpose**: Passive landing experience, navigation gateway
- 📄 **Example**: Homepage (`/`)

#### **2. Discipline Pages** - Functional discipline interfaces with buttons
**Characteristics:**
- ✅ Background image (custom themed)
- ✅ **HAS state buttons** (Agents/Upsert/Workspace)
- ✅ **HAS modal buttons**
- 🎯 **Purpose**: Active discipline-specific workflows
- 📄 **Example**: Administration (`/administration`), Privacy Settings (`/00102-privacy-settings`)

### Category B: Pages WITHOUT Background Images (8 Types)

| Type | Description | Examples |
|------|-------------|----------|
| **Data Management** | CRUD operations | `/procurement`, `/safety`, `/user-management` |
| **Workflow Processing** | Process automation | `/contracts-post-award`, `/logistics-documents` |
| **Data Collection** | Data collection | `/00102-final-onboarding`, `/form-creation` |
| **Document Processing** | File/document handling | `/all-documents`, `/document-control` |
| **Time Tracking** | Time management | `/timesheet` |
| **Scheduling Tools** | Scheduling tools | `/gantt-chart`, `/scheduling` |
| **Reporting/Dashboard** | Analytics and reporting | `/financial-dashboard`, `/performance-monitoring` |
| **Utility/Configuration** | Settings and tools | `/ui-settings`, `/modal-management` |

---

## 🚀 Step-by-Step Implementation Workflow

### Prerequisites
- Page code (02200-xxxx format)
- Page name and description
- Target accordion section
- Required permissions/access controls

---

### Step 1: Page Component Creation

```bash
# Create page directory structure
mkdir -p client/src/pages/{page_code}-{page_name}/components

# Create main page component
touch client/src/pages/{page_code}-{page_name}/{page_code}-{page_name}-page.js
touch client/src/pages/{page_code}-{page_name}/{page_code}-index.js
touch client/src/pages/{page_code}-{page_name}/{page_code}-{page_name}-style.css

# Create component directory for complex pages
mkdir -p client/src/pages/{page_code}-{page_name}/components
```

**Standard Directory Structure:**
```
client/src/pages/{page-id}-{page-name}/
├── {page-id}-index.js                    # Entry point
├── {page-id}-{page-name}-page.js         # Main component
├── components/
│   ├── {page-id}-{page-name}-grid.js     # Data display (if needed)
│   └── modals/
│       └── {page-id}-{page-name}-modal.js # Modal components
└── assets/
    └── {page-id}.png                     # Background image (if allowed)
```

---

### Step 2: Page Component Implementation

#### **File: `{page_code}-index.js`** (Entry Point)

```javascript
import React from 'react';
import { lazy } from 'react';
import PageTemplate from '../../common/components/PageTemplate.js';

const PageComponent = lazy(() => import('./{page_code}-{page_name}-page.js'));

export default function {PageName}Page() {
  return (
    <PageTemplate
      pageCode="{page_code}"
      pageName="{Page Name}"
      pageDescription="{Page Description}"
      PageComponent={PageComponent}
    />
  );
}
```

#### **File: `{page_code}-{page_name}-page.js`** (Main Component)

```javascript
import React, { useState, useEffect } from 'react';
import { AccordionComponent } from "@modules/accordion/00200-accordion-component.js";
import { AccordionProvider } from "@modules/accordion/context/00200-accordion-context.js";
import settingsManager from "@common/js/ui/00200-ui-display-settings.js";
import "../../templates/template-a-standard.css";
import './{page_code}-{page_name}-style.css';

export default function {PageName}Page() {
  // Mandatory state management
  const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);
  const [activeTab, setActiveTab] = useState("default");
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [data, setData] = useState([]);

  // Mandatory settings manager initialization
  useEffect(() => {
    console.log(`[{PageName}] Component mounting - setting title and initializing settings`);
    document.title = "Page Title - ConstructAI";

    // Set page name for Accordion system
    window.pageName = "{page_code}-{page_name}";

    const initSettings = async () => {
      try {
        console.log(`[{PageName}] Initializing settings manager...`);
        if (!settingsManager) {
          console.warn(`[{PageName}] Settings manager is not available`);
          setIsSettingsInitialized(true);
          return;
        }
        await settingsManager.initialize();
        console.log(`[{PageName}] Settings manager initialized`);
        try {
          await settingsManager.applySettings();
          console.log(`[{PageName}] Settings applied successfully`);
        } catch (applyError) {
          console.warn(`[{PageName}] Could not apply settings, using defaults:`, applyError);
        }
        setIsSettingsInitialized(true);
      } catch (err) {
        console.error(`[{PageName}] Error initializing settings:`, {
          message: err.message,
          stack: err.stack,
          name: err.name,
        });
        setIsSettingsInitialized(true); // Continue with defaults
      }
    };

    initSettings();

    // Cleanup function
    return () => {
      console.log(`[{PageName}] Component unmounting`);
      window.pageName = null;
    };
  }, []);

  // Page initialization logic
  useEffect(() => {
    initializePage();
  }, []);

  const initializePage = async () => {
    try {
      setIsLoading(true);
      // API calls or data loading
      const response = await fetch('/api/{page_code}/data');
      const result = await response.json();
      setData(result);
    } catch (error) {
      console.error('Error loading page data:', error);
      setError(error.message);
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return (
      <div className="page-loading">
        <div className="loading-spinner"></div>
        <p>Loading {Page Name}...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="page-error">
        <h2>Error Loading Page</h2>
        <p>{error}</p>
        <button onClick={initializePage}>Retry</button>
      </div>
    );
  }

  return (
    <div className="page-container">
      {/* Page Header */}
      <div className="template-a-header-section">
        <div className="template-a-header-content">
          <h1>{Page Name}</h1>
          <p className="page-description">{Page Description}</p>
        </div>
      </div>

      {/* Content Wrapper */}
      <div className="template-a-content-wrapper">
        <div className="template-a-card">
          <div className="template-a-card-header">
            <h3>Content Section</h3>
          </div>
          <div className="template-a-card-body">
            {/* Page specific content */}
          </div>
        </div>
      </div>

      {/* MANDATORY: Accordion Integration */}
      {isSettingsInitialized && (
        <AccordionProvider>
          <AccordionComponent settingsManager={settingsManager} />
        </AccordionProvider>
      )}

      {/* MANDATORY: Logout Button */}
      <button
        id="logout-button"
        onClick={() => {
          if (window.handleLogout) {
            window.handleLogout();
          } else {
            console.error("Global handleLogout function not found.");
          }
        }}
        className="template-a-logout-button"
      >
        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
          <path d="M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.59L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z"/>
        </svg>
      </button>
    </div>
  );
}
```

#### **File: `{page_code}-{page_name}-style.css`**

```css
/* ============= TEMPLATE A - {PAGE NAME} PAGE ============= */
/* Import Template A Standard Styles */
@import "../../templates/template-a-standard.css";

/* Page Container */
.{page_code}-page-container {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

/* Page Header */
.page-header {
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e1e5e9;
}

.page-header h1 {
  color: #2c3e50;
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.page-description {
  color: #6c757d;
  font-size: 1rem;
  margin: 0;
}

/* Page Content */
.page-content {
  display: grid;
  gap: 1.5rem;
}

.content-section {
  background: white;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.content-section h2 {
  color: #2c3e50;
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1rem;
  border-bottom: 2px solid #3498db;
  padding-bottom: 0.5rem;
}

/* Loading States */
.page-loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200px;
  gap: 1rem;
}

.page-error {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200px;
  gap: 1rem;
  color: #e74c3c;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Responsive Design */
@media (max-width: 768px) {
  .{page_code}-page-container {
    padding: 1rem;
  }
  
  .page-header h1 {
    font-size: 1.5rem;
  }
}

@media (max-width: 576px) {
  .content-section {
    padding: 1rem;
  }
}
```

---

### Step 3: Router Integration

**File: `client/src/App.js`**

Add import:
```javascript
// Import New Page
import {PageName}Page from "./pages/{page_code}-{page_name}/{page_code}-index.js";
```

Add route:
```javascript
<Route
  path="/{page-slug}"
  element={<{PageName}Page />}
/>
```

---

### Step 4: Accordion Configuration

**CRITICAL**: All new pages require accordion navigation integration using the 3-tier fallback system. Update ALL THREE files in this exact order:

#### **4.1 Server Template** (`server/src/routes/accordion-sections-routes.js`)

```javascript
// Add to MASTER_TEMPLATE array
{
  id: 'accordion-button-{page_code}',
  title: '{Page Title}',
  display_order: {page_code_numeric}, // Numeric display order for sorting
  sector: 'global|epcm|contractor|judicial', // See sector definitions below
  links: [
    { title: '{Page Title}', url: '/{page-slug}' },
    { title: 'Documents', url: '/all-documents' }, // Standard link
    { title: 'Email Management', url: '/email-management' }, // Standard link
    // Additional links in alphabetical order (A-Z, case-insensitive)
  ],
  subsections: {
    // Optional: For complex pages with subsections
    'subsection-{page_code}-001': {
      title: 'Subsection Title',
      links: [
        { title: 'Subsection Link', url: '/subsection-page' }
      ]
    }
  }
}
```

#### **4.2 Client Fallback** (`client/src/common/js/config/00200-ui-display-mappings.js`)

```javascript
// Add to sectionMappings object
"accordion-button-{page_code}": {
  title: "{Page Title}",
  optionId: {page_code_numeric},
  links: [
    "/{page-slug}",
    "00200-all-documents.html",
    "03010-email-management.html",
    // Additional links in alphabetical order
  ],
  subsections: {},
  sector: "global|epcm|contractor|judicial",
  allowedOrganizations: ["Simandou", "PropAI", "Organisations - EPCM"]
}
```

#### **4.3 Sector Definitions & Organization Access**

```javascript
// CRITICAL: Use correct sector classification
const SECTOR_DEFINITIONS = {
  global: { range: "00000-00199", access: "All organizations" },
  epcm: { range: "00200-09999", access: "EPCM organizations only" },
  contractor: { range: "20000-29999", access: "Contractor organizations" },
  judicial: { range: "30000-39999", access: "Judicial organizations" }
};

// Organization access control
const ORGANIZATION_ACCESS = [
  "Simandou",           // Global access
  "PropAI",            // Global access
  "Organisations - EPCM", // EPCM access
  "Organizations - Contractors", // Contractor access
  "Organizations - Judicial" // Judicial access
];
```

#### **4.4 Alphabetical Link Ordering (MANDATORY)**

```javascript
// ❌ INCORRECT - Wrong alphabetical order
links: [
  { title: 'Safety', url: '/safety' },
  { title: 'Inspections', url: '/inspections' },     // 'I' before 'E'
  { title: 'Email Management', url: '/email-management' }, // Should be before Inspections
  { title: 'Documents', url: '/all-documents' },     // 'D' before 'E'
  { title: 'Contractor Vetting', url: '/contractor-vetting' } // 'C' before 'D'
]

// ✅ CORRECT - Alphabetical A-Z order (case-insensitive)
links: [
  { title: 'Contractor Vetting', url: '/contractor-vetting' }, // C
  { title: 'Documents', url: '/all-documents' },               // D
  { title: 'Email Management', url: '/email-management' },     // E
  { title: 'Inspections', url: '/inspections' },               // I
  { title: 'Safety', url: '/safety' }                          // S
]
```

#### **4.5 3-Tier Fallback System Verification**

```javascript
// MANDATORY: Test all three levels
const ACCORDION_FALLBACK_TESTS = [
  "✅ Server API (/api/accordion-sections) - Primary source",
  "✅ Client Fallback (sectionMappings) - Development mode",
  "✅ Emergency Fallback - Critical sections only"
];

// Test command: Check all three load correctly
curl -X GET "http://localhost:3060/api/accordion-sections"
```

---

### Step 5: Database Integration

**SQL: Update pages table**

```sql
INSERT INTO pages (
  page_id,
  page_name,
  display_name,
  page_slug,
  page_path,
  page_prefix,
  parent_page_id,
  page_description,
  is_active,
  created_at,
  updated_at
) VALUES (
  '{page_code}',
  '{page_name}',
  '{Page Display Name}',
  '{page-slug}',
  '/{page-slug}',
  '{page_code}',
  NULL,
  '{Page Description}',
  true,
  NOW(),
  NOW()
);
```

---

### Step 6: API Endpoints (if needed)

**File: `server/src/routes/{page_code}-routes.js`**

```javascript
import express from 'express';
import supabase from '../config/supabase.js';

const router = express.Router();

// GET /{page_code}/data
router.get('/data', async (req, res) => {
  try {
    // API logic here
    const data = await fetchData();
    res.json({ success: true, data });
  } catch (error) {
    console.error('Error fetching data:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

// POST /{page_code}/action
router.post('/action', async (req, res) => {
  try {
    // Action logic here
    const result = await performAction(req.body);
    res.json({ success: true, result });
  } catch (error) {
    console.error('Error performing action:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

export default router;
```

**File: `server/src/app.js`**

```javascript
// Add route import
import {pageCode}Routes from './routes/{page_code}-routes.js';

// Mount routes
app.use('/api/{page_code}', {pageCode}Routes);
```

---

### Step 7: Permissions & Security

**File: `server/src/middleware/auth.js`** (if needed)

```javascript
// Add page permissions
const pagePermissions = {
  '{page_code}': {
    requiredRoles: ['user'], // Adjust as needed
    allowedOrganizations: ['all'] // Adjust as needed
  }
};
```

---

### Step 8: Testing & Validation

**Manual Testing Checklist:**
- [ ] Page loads without errors
- [ ] Accordion link works
- [ ] Page displays correctly (Template A)
- [ ] No console errors
- [ ] Mobile responsive
- [ ] Loading states work
- [ ] Error handling works

**Build Test:**
```bash
cd client && npm run build
# Check for build errors
```

---

### Step 9: Documentation Update

**File: `docs/pages/{page_code}-{page_name}.md`**

```markdown
# {Page Name}

## Overview
{Page description and purpose}

## Features
- Feature 1
- Feature 2
- Feature 3

## Usage
{How to use the page}

## API Endpoints
- `GET /api/{page_code}/data` - Fetch page data
- `POST /api/{page_code}/action` - Perform action

## Permissions
{Required roles and permissions}

## Related Pages
- Related page 1
- Related page 2
```

**Update Master Documentation:**
- [ ] Add page to `1300_00000_PAGE_LIST.md`
- [ ] Create master guide: `1300_{page_code}_MASTER_GUIDE.md`
- [ ] Document any custom implementation details

---

### Step 10: Deployment Checklist

- [ ] Code committed to repository
- [ ] Database migrations applied
- [ ] Build successful
- [ ] Page accessible in production
- [ ] Permissions configured
- [ ] Documentation updated

---

## 🔧 State-Based Button Display Integration

### When to Use State-Based Buttons

- **Complex Pages**: Pages with multiple state-driven workflows
- **State-Dependent Operations**: Different operations available in different states
- **User Experience**: When state selection significantly changes available actions
- **Reference Implementations**: 01900-procurement (4 states), 00435-contracts-post-award (3 states)

### Integration Steps

#### **Step 1: Determine State Requirements**

```javascript
const requiredStates = {
  agents: true,      // AI agent interactions
  upserts: true,     // Data modification (create/update)
  workspace: true,   // Workspace management
  simulator: false   // Only if needed (e.g., 01900-procurement)
};
```

#### **Step 2: Implement State Management**

```javascript
import React, { useState, useEffect } from 'react';
import { useModal } from '@components/modal/hooks/00170-useModal.js';

const MyPageComponent = () => {
  const [currentState, setCurrentState] = useState('agents');
  const [isButtonContainerVisible, setIsButtonContainerVisible] = useState(false);
  const [activeAgent, setActiveAgent] = useState(null);
  const { openModal } = useModal();

  // State change handler
  const handleStateChange = (newState) => {
    setCurrentState(newState);
    if (newState !== 'agents') {
      setActiveAgent(null);
    }
  };

  // Button visibility animation
  useEffect(() => {
    const timer = setTimeout(() => {
      setIsButtonContainerVisible(true);
    }, 100);
    return () => clearTimeout(timer);
  }, []);

  // Modal trigger handler
  const handleOpenModal = (modalId, modalProps = {}) => {
    window.currentModalTriggerPage = modalProps.triggerPage;

    if (currentState === 'agents') {
      const agentMap = {
        CorrespondenceModal: 'correspondence',
        OrderProcessModal: 'order-process',
        AnalysisModal: 'analysis',
      };
      setActiveAgent(agentMap[modalId]);
    }

    openModal(modalId, modalProps);
  };

  return (
    <div className="page-container">
      <NavigationComponent
        currentState={currentState}
        onStateChange={handleStateChange}
        pageTitle={pageTitle}
      />
      <ButtonContainerComponent
        currentState={currentState}
        buttons={BUTTONS_BY_STATE}
        onOpenModal={handleOpenModal}
        pageId={pageId}
        isVisible={isButtonContainerVisible}
      />
    </div>
  );
};
```

#### **Step 3: Define State Configuration**

```javascript
const STATE_CONFIG = {
  agents: {
    label: 'Agents',
    emoji: '🤖',
    description: 'AI agent interactions'
  },
  upserts: {
    label: 'Upserts',
    emoji: '📤',
    description: 'Data modification operations'
  },
  workspace: {
    label: 'Workspace',
    emoji: '🗂️',
    description: 'Workspace management'
  }
};
```

#### **Step 4: Define Button Arrays by State**

```javascript
const BUTTONS_BY_STATE = {
  agents: [
    {
      label: '📧 Correspondence Reply',
      modalId: 'CorrespondenceModal',
      modalTitle: 'Correspondence Reply',
    },
    {
      label: '🤖 Create Order',
      modalId: 'InputAgentModal',
      modalTitle: 'Create Order via Agent',
    },
  ],
  upserts: [
    {
      label: '☁️ Cloud Import',
      modalId: 'CloudImportModal',
      modalTitle: 'Cloud Import',
    },
    {
      label: '📄 Upload Files',
      modalId: 'FileUploadModal',
      modalTitle: 'Upload Files',
    },
  ],
  workspace: [
    {
      label: 'Manage Workspaces',
      emoji: '🗂️',
      modalId: 'WorkspaceManagementModal',
      modalTitle: 'Manage Workspaces',
    },
  ],
};
```

#### **Step 5: CSS Styling**

```css
.page-navigation-container {
  position: fixed;
  left: 50%;
  bottom: 10px;
  transform: translateX(-50%);
  z-index: 200;
  pointer-events: none;
}

.page-nav-row {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
  pointer-events: auto !important;
}

.state-button {
  pointer-events: auto !important;
  background: white;
  border: 2px solid #FF8C00;
  border-radius: 20px;
  padding: 8px 16px;
  cursor: pointer;
  transition: all 0.2s;
  font-weight: 600;
  color: #333;
}

.state-button:hover {
  background: #FFF8F0;
  transform: translateY(-2px);
}

.state-button.active {
  background: #FF8C00;
  color: white;
  border-color: #FF8C00;
}

.button-container {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 10px;
  max-width: 600px;
  width: 100%;
  padding: 30px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.button-container.visible {
  opacity: 1;
}
```

### Reference Documentation

- **Procedure**: [0000_STATE_BASED_BUTTON_DISPLAY_PROCEDURE.md](0000_STATE_BASED_BUTTON_DISPLAY_PROCEDURE.md)
- **Reference Implementations**:
  - 01900-procurement (4-state pattern)
  - 00435-contracts-post-award (3-state pattern)

---

## 🎯 Background Page UI Specifications

### Standardized Layout Structure

```
Background Image Layer (z-index: -1)
├── State Buttons (z-index: 200)
│   ├── Agents Button:    calc(10px + 1.5em + 10px), center
│   ├── Upsert Button:    calc(10px + 1.5em + 10px), center
│   └── Workspace Button: calc(10px + 1.5em + 10px), center
├── Page Title Button (z-index: 200)
│   └── bottom: 10px, center
├── Modal Buttons Container (z-index: 200)
│   └── center screen, 2-column grid
├── Logout Button (z-index: 200)
│   └── bottom: 10px, left: 10px ⭐
├── Chatbot (z-index: 900)
│   └── bottom: 10px, right: 10px ⭐
└── Accordion Component (z-index: 2100)
```

### Exact Positioning Specifications

#### **State Buttons (Agents/Upsert/Workspace)**

```css
position: fixed;
left: 50%;
bottom: calc(10px + 1.5em + 10px);
transform: translateX(-50%);
display: flex;
gap: 10px;
z-index: 200;
```

#### **Page Title Button**

```css
position: fixed;
left: 50%;
bottom: 10px;
transform: translateX(-50%);
z-index: 200;
```

#### **Logout Button** ⭐ **(Equidistant from screen edges)**

```css
position: fixed;
left: 10px;      /* 10px from left edge */
bottom: 10px;
z-index: 200;
background: none;
border: none;
padding: 10px;
```

#### **Chatbot** ⭐ **(Equidistant from screen edges)**

```css
position: fixed;
right: 10px;     /* 10px from right edge */
bottom: 10px;
z-index: 900;
```

#### **Background Image**

```css
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100vh;
background-size: cover;
background-position: center bottom;
background-repeat: no-repeat;
background-attachment: fixed;
z-index: -1;
```

---

## 📚 Cross-References & Use Cases

### Related Procedures

| Document | Purpose |
|----------|---------|
| [0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md](0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md) | General workflow patterns and agent orchestration |
| [0002_AGENT_CENTRIC_WORKFLOW_PAGE_IMPLEMENTATION_PROCEDURE.md](0002_AGENT_CENTRIC_WORKFLOW_PAGE_IMPLEMENTATION_PROCEDURE.md) | Complex agent-centric workflow pages (24+ prompts) |
| [0000_STATE_BASED_BUTTON_DISPLAY_PROCEDURE.md](0000_STATE_BASED_BUTTON_DISPLAY_PROCEDURE.md) | State-driven button interface patterns |
| [PROCUREMENT_WORKFLOW_AGENT_PROMPTS_INVENTORY](../implementation/01900_procurement/PROCUREMENT_WORKFLOW_AGENT_PROMPTS_INVENTORY_AND_DEVELOPER_TOOLS_IMPLEMENTATION_WITH_MAGIC_WAND.md) | AI agent patterns and developer tools |
| [appendix_d_training_materials_modifications.md](../implementation/01900_procurement/appendix_d_training_materials_modifications.md) | Enhanced page patterns reference |

### Page Type Quick Reference Matrix

| Page Type | Background | Navigation | Template | Example |
|-----------|------------|------------|----------|---------|
| **Simple** | CSS only | Tab-based | Template A | 00200-all-documents |
| **Complex Accordion** | CSS only | Three-state (Agents/Upsert/Workspace) | Custom | 00435-contracts-post-award |
| **Document Compilation** | CSS only | Multi-panel dashboard | Template A + panels | 01700-export-declaration |
| **With Background** | Image | Tab-based or three-state | Template A | 00106-timesheet |

---

## 🛠️ Common Implementation Mistakes (AVOID)

### ❌ Background Image Errors

```javascript
// WRONG: Adding background to data management page
<div style={{ backgroundImage: 'url(...)' }}> // ❌ NEVER DO THIS

// WRONG: Using background for authentication
const LoginPage = () => <div style={{ backgroundImage: 'url(...)' }}> // ❌ PROHIBITED
```

### ❌ Template A Violations

```javascript
// WRONG: Not importing Template A
// Missing: @import "../../templates/template-a-standard.css";

// WRONG: Using custom colors instead of variables
color: #FF8C00; // ❌ Use: var(--template-a-primary)

// WRONG: Custom CSS framework
import 'bootstrap.css'; // ❌ Conflicts with Template A
```

### ❌ Accordion Integration Failures

```javascript
// WRONG: Missing AccordionProvider
<AccordionComponent /> // ❌ Must be wrapped

// WRONG: No settings initialization
useEffect(() => {}, []); // ❌ Must initialize settingsManager

// WRONG: Missing logout button
// ❌ All pages MUST have logout button
```

### ❌ Loading State Errors

```javascript
// WRONG: No fallback for missing orderId
useEffect(() => {
  if (orderId) loadData(); // Infinite loading if no orderId
}, [orderId]);

// WRONG: Missing loading state management
const loadData = async () => {
  const data = await fetchData();
  setData(data);
  // Forgot setLoading(false) - infinite spinner
};
```

---

## ✅ Quality Assurance Checklist

### Pre-Implementation Review

- [ ] Page type correctly identified (simple/complex)
- [ ] Background image policy followed
- [ ] Template A standard selected
- [ ] Directory structure planned

### During Implementation

- [ ] All mandatory imports included
- [ ] Settings manager properly initialized
- [ ] Accordion integration implemented
- [ ] Template A CSS imported
- [ ] Logout button added
- [ ] Loading states implemented
- [ ] Error handling implemented

### Post-Implementation Testing

- [ ] **CRITICAL**: Accordion loads and functions
- [ ] **CRITICAL**: Settings manager initializes without errors
- [ ] **CRITICAL**: Logout button appears and works
- [ ] **CRITICAL**: Page loads in both local and server environments
- [ ] Background image displays correctly (if applicable)
- [ ] Responsive design works on mobile/desktop
- [ ] All page functionality works as expected
- [ ] Console errors resolved
- [ ] Build successful (`npm run build`)

### Documentation & Handover

- [ ] Add page to 1300_00000_PAGE_LIST.md
- [ ] Create master guide: 1300_{page_code}_MASTER_GUIDE.md
- [ ] Document any custom implementation details
- [ ] Code review completed
- [ ] Ready for production deployment

---

## 🚨 Error Handling & Rollback

### If Any Step Fails

1. Check console for specific errors
2. Verify file paths and naming conventions
3. Ensure database connections are working
4. Check permissions and access controls
5. Validate accordion configuration syntax

### Rollback Procedure

If deployment fails:
1. Revert code changes
2. Remove database entries (if added)
3. Clear browser cache
4. Restart application services

---

## 🎯 Standards Compliance

All pages must comply with:

- ✅ Template A (card-based layout)
- ✅ Responsive design
- ✅ Loading states
- ✅ Error handling
- ✅ Accessibility
- ✅ Performance optimized
- ✅ Security compliant

---

## 📋 Template A CSS Variables Reference

```css
/* Template A Standard Variables */
--template-a-primary: #FF8C00;
--template-a-secondary: #FFA500;
--template-a-bg-gradient: linear-gradient(135deg, #FF8C00 0%, #FF6B35 100%);
--template-a-header-gradient: linear-gradient(135deg, #FFA500 0%, #FF8C00 100%);
--template-a-text-white: #ffffff;
--template-a-text-primary: #1a1a1a;
--template-a-card-bg: rgba(255, 255, 255, 0.95);
--template-a-shadow-md: 0 4px 20px rgba(0, 0, 0, 0.1);
```

---

## 📚 Lessons Learned from Production Fixes

This section documents critical issues discovered and fixed in production to prevent recurrence.

### ES Module Import/Export Ordering (CRITICAL)

**Issue:** React "type is invalid -- expected a string or class/function but got: undefined" errors when loading pages.

**Root Cause:** In ES modules, `export` statements were placed BEFORE `import` statements, causing Webpack/Babel to fail parsing the module correctly.

**Affected Files:**
- `00425-index.js` (Contracts Pre-Award)
- `00435-index.js` (Contracts Post-Award)
- `01900-index.js` (Procurement)

**❌ INCORRECT - Export before imports:**
```javascript
// WRONG: Export before imports causes module parsing failure
export { ContractsPreAwardPage } from './components/00425-contracts-pre-award-page.js';

import '@common-css/components/00200-all-accordion.css';
import '@common-css/base/00200-all-base.css';
```

**✅ CORRECT - Imports before exports:**
```javascript
// CORRECT: All imports must come before exports
import '@common-css/components/00200-all-accordion.css';
import '@common-css/base/00200-all-base.css';
import '@common-css/pages/00425-contracts-pre-award/00425-pages-style.css';

export { ContractsPreAwardPage } from './components/00425-contracts-pre-award-page.js';
```

### Missing Export Statements

**Issue:** Components imported but never exported, causing `undefined` when imported by App.js.

**Root Cause:** The 01900-index.js file was importing `ProcurementPage` but never exporting it.

**❌ INCORRECT - Import without export:**
```javascript
// WRONG: Component is imported but never exported
import { ProcurementPage } from "./components/01900-procurement-page.js";

// No export statement - App.js receives undefined
```

**✅ CORRECT - Import and re-export:**
```javascript
// CORRECT: Import and then re-export for App.js
import { ProcurementPage } from "./components/01900-procurement-page.js";

export { ProcurementPage };
```

### Prevention Checklist

When creating or modifying page index files:

- [ ] All CSS imports come FIRST in the file
- [ ] Component imports come after CSS imports
- [ ] Export statement comes LAST in the file
- [ ] Verify the component is actually exported (not just imported)
- [ ] Test the page loads without "type is invalid" React errors
- [ ] Verify App.js can import the component without getting `undefined`

---

## 🐛 Discipline Page State Pattern (CRITICAL)

This section documents the **correct pattern** for discipline pages with state-based button displays (Agents/Upsert/Workspace). This pattern prevents the bug where grid/modal buttons appear on page entry before state selection.

### The Bug Pattern (❌ INCORRECT)

Discipline pages were showing all modal buttons immediately on page load instead of waiting for the user to select a state. This was caused by **TWO bugs working together**:

**Bug #1: Wrong Initial State**
```javascript
// ❌ WRONG: Initialize with "agents" pre-selected
const [currentState, setCurrentState] = useState("agents");
```

**Bug #2: Default Case Returns Buttons**
```javascript
// ❌ WRONG: getCurrentButtons returns buttons in default case
const getCurrentButtons = () => {
  switch (currentState) {
    case "agents": return agentsButtons;
    case "upserts": return upsertsButtons;
    case "workspace": return workspaceButtons;
    default: return agentsButtons; // ❌ Shows buttons when no state selected!
  }
};
```

**Bug #3: Unconditional Button Container**
```javascript
// ❌ WRONG: Container always rendered
<div className="button-container">
  {getCurrentButtons().map(button => ...)}
</div>
```

### The Correct Pattern (✅ CORRECT)

**Fix #1: Initialize State to null**
```javascript
// ✅ CORRECT: Start with NO state selected
const [currentState, setCurrentState] = useState(null);
```

**Fix #2: Default Case Returns Empty Array**
```javascript
// ✅ CORRECT: getCurrentButtons returns empty array in default case
const getCurrentButtons = () => {
  switch (currentState) {
    case "agents": return agentsButtons;
    case "upserts": return upsertsButtons;
    case "workspace": return workspaceButtons;
    default: return []; // ✅ No buttons when no state selected!
  }
};
```

**Fix #3: Conditional Button Container**
```javascript
// ✅ CORRECT: Only render container when state is selected
{currentState && (
  <div className="button-container">
    {getCurrentButtons().map(button => ...)}
  </div>
)}
```

### Complete Working Example

```javascript
import React, { useState, useEffect } from 'react';
import { useModal } from '@components/modal/hooks/00170-useModal.js';

export default function DisciplinePage() {
  // ✅ CORRECT: Initialize to null (not "agents")
  const [currentState, setCurrentState] = useState(null);
  const { openModal } = useModal();

  // Button definitions per state
  const agentsButtons = [
    { label: '📧 Correspondence', modalId: 'CorrespondenceModal' },
    { label: '🤖 AI Agent', modalId: 'AgentModal' },
  ];

  const upsertsButtons = [
    { label: '☁️ Cloud Import', modalId: 'CloudImportModal' },
    { label: '📄 Upload Files', modalId: 'FileUploadModal' },
  ];

  const workspaceButtons = [
    { label: '🗂️ Manage Workspaces', modalId: 'WorkspaceModal' },
  ];

  // ✅ CORRECT: Return empty array in default case
  const getCurrentButtons = () => {
    switch (currentState) {
      case "agents": return agentsButtons;
      case "upserts": return upsertsButtons;
      case "workspace": return workspaceButtons;
      default: return []; // ✅ Empty array when no state selected
    }
  };

  const handleStateChange = (newState) => {
    setCurrentState(newState);
  };

  return (
    <div className="page-container">
      {/* State Selection Buttons */}
      <div className="page-nav-row">
        <button 
          className={`state-button ${currentState === 'agents' ? 'active' : ''}`}
          onClick={() => handleStateChange('agents')}
        >
          🤖 Agents
        </button>
        <button 
          className={`state-button ${currentState === 'upserts' ? 'active' : ''}`}
          onClick={() => handleStateChange('upserts')}
        >
          📤 Upserts
        </button>
        <button 
          className={`state-button ${currentState === 'workspace' ? 'active' : ''}`}
          onClick={() => handleStateChange('workspace')}
        >
          🗂️ Workspace
        </button>
      </div>

      {/* ✅ CORRECT: Conditional rendering - only show when state selected */}
      {currentState && (
        <div className="button-container">
          {getCurrentButtons().map((button, index) => (
            <button
              key={index}
              className="modal-button"
              onClick={() => openModal(button.modalId, { triggerPage: 'discipline-page' })}
            >
              {button.label}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
```

### State Pattern Checklist

When implementing discipline pages with state-based buttons:

- [ ] **State Initialization**: `useState(null)` NOT `useState("agents")`
- [ ] **Default Case**: `return []` NOT `return agentsButtons`
- [ ] **Conditional Container**: `{currentState && (...)}` NOT always rendered
- [ ] **State Buttons**: All three states (Agents/Upsert/Workspace) present
- [ ] **Active State Styling**: Visual indication of selected state
- [ ] **Build Cache Clear**: Run `npm run clean-cache && npm run build:fast` after fixes

### Affected Pages (Fixed in Production)

The following discipline pages had this bug and were fixed:
- `00882-director-construction-page.js`
- `00300-construction-page.js`
- `02200-quality-assurance-page.js`
- `02050-information-technology-page.js`
- `02076-quality-assurance-page.js`

---

### Button Array Declaration Ordering Bug (CRITICAL - Feb 2026)

**Issue:** Discipline pages displayed modal buttons on page entry instead of waiting for state selection, even with correct `useState(null)` and conditional rendering.

**Root Cause:** JavaScript code ordering issue where `workspaceButtons` constant was defined AFTER the `getCurrentButtons()` function that referenced it. Due to JavaScript's temporal dead zone (TDZ) for const variables, this caused `workspaceButtons` to be undefined when `getCurrentButtons()` was first evaluated.

**Symptom:** Pages like 01800-operations showed buttons immediately on load, while 00400-contracts correctly showed NO buttons until state selection.

#### The Bug Pattern (❌ INCORRECT)

```javascript
// ❌ WRONG: Button arrays not all defined before getCurrentButtons()
const agentsButtons = [...];
const upsertButtons = [...];

// getCurrentButtons() defined HERE - workspaceButtons doesn't exist yet!
const getCurrentButtons = () => {
  switch (currentState) {
    case "agents": return sortButtonsAlphabetically(agentsButtons);
    case "upserts": return sortButtonsAlphabetically(upsertButtons);
    case "workspace": return sortButtonsAlphabetically(workspaceButtons); // ❌ undefined!
    default: return [];
  }
};

// ❌ workspaceButtons defined AFTER getCurrentButtons()
const workspaceButtons = sortButtonsAlphabetically([...]);
```

#### The Correct Pattern (✅ FIXED)

```javascript
// ✅ CORRECT: ALL button arrays defined BEFORE getCurrentButtons()
const agentsButtons = [...];
const upsertButtons = [...];
const workspaceButtons = sortButtonsAlphabetically([...]); // ✅ Defined BEFORE function

// ✅ getCurrentButtons() defined AFTER all button arrays exist
const getCurrentButtons = () => {
  switch (currentState) {
    case "agents": return sortButtonsAlphabetically(agentsButtons);
    case "upserts": return sortButtonsAlphabetically(upsertButtons);
    case "workspace": return sortButtonsAlphabetically(workspaceButtons); // ✅ Now defined!
    default: return []; // ✅ Empty array when no state selected
  }
};
```

#### Complete Working Example

```javascript
import React, { useState, useEffect } from 'react';
import { useModal } from '@components/modal/hooks/00170-useModal.js';
import { calculateGridLayout, sortButtonsAlphabetically } from '@utils/gridUtils.js';

export default function DisciplinePage() {
  const navigate = useNavigate();
  const [currentState, setCurrentState] = useState(null); // ✅ Start with null
  const [isButtonContainerVisible, setIsButtonContainerVisible] = useState(false);
  const { openModal } = useModal();

  // ✅ CRITICAL: Define ALL button arrays FIRST
  const agentsButtons = [
    { label: "Correspondence Reply", modalId: "CorrespondenceReplyModal", modalTitle: "Correspondence Reply" },
  ];

  const upsertButtons = [
    { label: "Cloud Import", modalId: "01800-UpsertCloudModal", modalTitle: "Cloud Import" },
    { label: "Import from URL", modalId: "01800-UpsertUrlModal", modalTitle: "Import from URL" },
    { label: "Upload Files", modalId: "01800-UpsertFileModal", modalTitle: "Upload Files" },
  ];

  const workspaceButtons = sortButtonsAlphabetically([
    { label: "Document Access", action: "navigate", path: "/0165-ui-settings#document-access" },
    { label: "Cross-Discipline Sharing", modalId: "DisciplinePermissionMatrixModal" },
    { label: "Vector Data Manager", modalId: "VectorDataManagerModal" },
  ]);

  // ✅ THEN define getCurrentButtons() - all button arrays now exist
  const getCurrentButtons = () => {
    switch (currentState) {
      case "agents": return sortButtonsAlphabetically(agentsButtons);
      case "upserts": return sortButtonsAlphabetically(upsertButtons);
      case "workspace": return sortButtonsAlphabetically(workspaceButtons);
      default: return []; // ✅ Empty array when no state selected
    }
  };

  // Calculate grid layout
  const currentButtons = getCurrentButtons();
  const gridLayout = currentButtons.length > 0 ? calculateGridLayout(currentButtons.length) : { columns: 1, positions: [] };

  return (
    <div className="page-container">
      {/* State Buttons */}
      <div className="navigation-container">
        <div className="nav-row">
          <button
            className={`state-button ${currentState === "agents" ? "active" : ""}`}
            onClick={() => setCurrentState("agents")}
          >
            Agents
          </button>
          <button
            className={`state-button ${currentState === "upserts" ? "active" : ""}`}
            onClick={() => setCurrentState("upserts")}
          >
            Upserts
          </button>
          <button
            className={`state-button ${currentState === "workspace" ? "active" : ""}`}
            onClick={() => setCurrentState("workspace")}
          >
            Workspace
          </button>
        </div>
      </div>

      {/* ✅ Conditional Button Container - only renders when state selected */}
      {currentState && currentButtons.length > 0 && (
        <div
          className={`epcm-grid-container epcm-bg-light ${isButtonContainerVisible ? "visible" : ""}`}
          style={{
            gridTemplateColumns: `repeat(${gridLayout.columns}, 1fr)`,
            position: "fixed",
            top: "50%",
            left: "50%",
            transform: "translate(-50%, -50%)",
            zIndex: 10,
          }}
        >
          {currentButtons.map((button, index) => {
            const position = gridLayout.positions[index];
            const safeCol = position?.col || 1;
            const safeRow = position?.row || 1;
            return (
              <button
                key={index}
                className="epcm-grid-button"
                style={{ gridColumn: safeCol, gridRow: safeRow }}
                onClick={() => {
                  if (button.action === "navigate") {
                    navigate(button.path);
                  } else if (button.modalId) {
                    openModal(button.modalId, {
                      modalTitle: button.modalTitle,
                      triggerPage: "discipline-page",
                    });
                  }
                }}
              >
                {button.label}
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
}
```

#### Pages Fixed (February 2026)

**Analysis Results:**
- Total pages analyzed: 201
- Pages with button pattern: 41
- Pages with ordering bug: 4
- **All bugs fixed** ✅

**Fixed Pages:**
1. `01800-operations-page.js` (Operations)
2. `01600-local-content-page.js` (Local Content)
3. `01700-logistics-page.js` (Logistics)
4. `01750-legal-page.js` (Legal)

#### Button Ordering Checklist

When implementing discipline pages with state-based buttons:

- [ ] **Button Declaration Order**: ALL button arrays (`agentsButtons`, `upsertButtons`, `workspaceButtons`) defined BEFORE `getCurrentButtons()`
- [ ] **State Initialization**: `useState(null)` NOT `useState("agents")`
- [ ] **Default Case**: `return []` NOT `return agentsButtons`
- [ ] **Conditional Container**: `{currentState && currentButtons.length > 0 && (...)}` NOT always rendered
- [ ] **Verification**: Run `node analyze-button-ordering.cjs` to check for ordering bugs
- [ ] **Build Cache Clear**: Run `npm run clean-cache && npm run build:fast` after fixes

#### Automated Detection Tool

**Script:** `analyze-button-ordering.cjs`

```bash
# Check all pages for button ordering bugs
node analyze-button-ordering.cjs

# Expected output when fixed:
# Pages with BUG: 0 ✅
# Pages already CORRECT: 41 ✅
```

#### Technical Details

**Why This Matters:** JavaScript const declarations are not hoisted in the same way as var declarations. While the declaration is hoisted, the initialization is not. This creates a "temporal dead zone" (TDZ) from the start of the block until the initialization. Referencing a const variable in its TDZ results in a ReferenceError, but in React components, this can manifest as undefined behavior.

**Reference Implementation:** `00400-contracts-page.js` demonstrates correct button ordering (though it has a minor bug in its default case that doesn't affect behavior due to the conditional rendering check).

**Documentation:**
- Bug Fix Report: `docs/temp/BUTTON_ORDERING_BUG_FIX_REPORT.md`
- Analysis Results: `button-ordering-analysis-report.json`
- Detection Script: `analyze-button-ordering.cjs`

### Build Cache Note

After applying these fixes, you MUST clear the build cache:

```bash
npm run clean-cache && npm run build:fast
```

Webpack caches compiled modules, and stale cache can prevent fixes from taking effect.

### Common Error Patterns

| Error Message | Likely Cause | Fix |
|---------------|--------------|-----|
| "type is invalid -- expected a string or class/function but got: undefined" | Export before imports OR missing export | Reorder imports/exports; add missing export |
| "Cannot read property 'X' of undefined" | Component not properly exported | Ensure component is exported from index file |
| "Module not found" | Incorrect import path | Verify file path and extension |
| "Unexpected token 'export'" | Export before imports | Move all exports after imports |
| **Buttons appear on page entry** | `useState("agents")` or `default: return agentsButtons` | Apply Discipline Page State Pattern fixes |

---

**Version:** 2.0 (Unified)
**Last Updated:** February 2026  
**Combines:** 0000_PAGE_IMPLEMENTATION_PROCEDURE.md + 0000_NEW_PAGE_IMPLEMENTATION_WORKFLOW.md  
**Status:** Single Source of Truth for Page Implementation

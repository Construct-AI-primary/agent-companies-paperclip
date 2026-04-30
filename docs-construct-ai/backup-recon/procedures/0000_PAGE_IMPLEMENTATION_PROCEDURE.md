---
memory_layer: durable_knowledge
para_section: pages/documentation
gigabrain_tags: documentation
documentation
openstinger_context: general-documentation
last_updated: 2026-03-30
related_docs:
  - docs/
---

# Page Implementation Procedure - Unified Standard

## Overview
This document establishes the unified procedure for implementing all **new** pages in the ConstructAI system. It combines and rationalizes requirements from the Simpler Page Implementation Guide, CSS Inventory, Visual Design Standards, and Template Standardization Plan to provide a single, authoritative procedure for page development.

## 📋 **Implementation Procedure Selection Guide**

### **Decision Tree: Which Procedure to Use?**
```
Need to implement a page/workflow?
├── Basic page (< 5 AI prompts, standard features)
│   └── Use 0000_PAGE_IMPLEMENTATION_PROCEDURE.md (You are here)
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

## 📚 Cross-References & Use Cases

### **Reference Documents**
- **[0002_AGENT_CENTRIC_WORKFLOW_PAGE_IMPLEMENTATION_PROCEDURE.md](0002_AGENT_CENTRIC_WORKFLOW_PAGE_IMPLEMENTATION_PROCEDURE.md)**: Specialized procedure for complex agent-centric workflow pages requiring 24+ AI prompts and 8-interface developer testing modal
- **[0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md](0001_WORKFLOW_IMPLEMENTATION_PROCEDURE.md)**: General workflow patterns and agent orchestration (enhanced for AI agent integration)
- **[PROCUREMENT_WORKFLOW_AGENT_PROMPTS_INVENTORY_AND_DEVELOPER_TOOLS_IMPLEMENTATION_WITH_MAGIC_WAND.md](../implementation/01900_procurement/PROCUREMENT_WORKFLOW_AGENT_PROMPTS_INVENTORY_AND_DEVELOPER_TOOLS_IMPLEMENTATION_WITH_MAGIC_WAND.md)**: Comprehensive inventory of AI agent patterns and developer tools
- **[appendix_d_training_materials_modifications.md](../implementation/01900_procurement/appendix_d_training_materials_modifications.md)**: Reference implementation following enhanced page patterns

### **Use Case: Standard Page Implementation**
This procedure provides the **foundation framework** for implementing standard pages in the ConstructAI system:

- **Basic Page Structure**: Directory structure, mandatory imports, state management, and settings initialization
- **Template A Compliance**: Standardized CSS framework with consistent styling and responsive design
- **Background Image Policy**: Clear rules for when background images are allowed (timesheet/workflow pages only)
- **Accordion Integration**: Mandatory 3-tier navigation system with server, client, and emergency fallbacks
- **Quality Assurance**: Comprehensive pre/post-implementation checklists and testing requirements

**Implementation Pattern**: Use this as the baseline for all new pages, enhanced with specialized procedures (like 0002) for complex agent-centric workflows.

## 📋 Quick Reference Decision Matrix

| Page Type | Background | Navigation | Template | Example |
|-----------|------------|------------|----------|---------|
| **Complex Accordion** | CSS variables only | Three-state (Agents/Upsert/Workspace) | Custom | 00435-contracts-post-award |
| **Document Compilation Suite** | CSS variables only | Multi-panel dashboard | Template A + specialized panels | 01700-export-declaration |
| **Simple Wizard** | CSS variables only | Step-by-step workflow | Template A | 01900-sow-creation |
| **Simpler WITHOUT Background** | CSS variables only | Tab-based | Template A | 00200-all-documents |

### **Document Compilation Suite** (New Page Type)
**Use this page type for:**
- Multi-country document generation systems
- AI-assisted document creation with confidence scoring
- Human-in-the-Loop (HITL) workflow integration
- Document export capabilities (PDF, DOCX, JSON)
- Procurement/order data integration
- Complex state management across multiple specialized panels

**Key Characteristics:**
- **Multi-panel dashboard**: Context gathering, AI generation, workflow management, document actions, history tracking
- **Country-specific forms**: Support for multiple countries/regions with different regulatory requirements
- **AI integration**: Document generation with validation and confidence metrics
- **Export capabilities**: Multiple format support for generated documents
- **Progress tracking**: Visual indicators for document completion and workflow status
- **Procurement integration**: Pulls data from procurement orders and cargo specifications

**Template**: Template A base + specialized panels (AI generation, HITL workflow, document actions, etc.)
**Navigation**: Multi-panel dashboard with stacked vertical layout
**Background**: CSS variables only (no background images)
**Example**: 01700-export-declaration (supports ZA, GN, SA export declarations)

## 🔧 Unified Implementation Procedure

### Phase 1: Planning & Requirements

#### 1.1 Determine Page Type & Characteristics
```javascript
// REQUIRED: Answer these questions before starting
const pageRequirements = {
  pageId: "XXXX", // 4-digit page identifier
  pageType: "simple|complex", // Simple = tab-based, Complex = three-state
  hasBackground: true|false, // See Background Policy below
  navigationType: "tab-based|three-state|standard",
  template: "template-a|custom",
};
```

#### 1.2 Background Image Policy (CRITICAL DECISION)
```javascript
// ⚠️  SYSTEM REALITY: NO background images are actually implemented
// The following policy was theoretical but is NOT implemented in practice

// ❌ THEORETICAL POLICY (NOT IMPLEMENTED):
const THEORETICAL_ALLOWED_BACKGROUNDS = [
  "00106-timesheet",           // Time entry workflow
  "00435-contracts-post-award", // Complex with dynamic theming
  "00425-contracts-pre-award",  // Complex with dynamic theming
  // + All discipline pages (00800-03000 series)
];

// ✅ ACTUAL IMPLEMENTATION: No background images anywhere
const ACTUAL_BACKGROUND_POLICY = [
  "NO_BACKGROUNDS_ALLOWED",    // System uses clean, consistent UI without backgrounds
  "CSS_VARIABLES_ONLY",        // All theming done via CSS variables
  "TEMPLATE_A_STANDARD",       // Consistent styling across all pages
];
```

#### 1.3 Template Selection Guide
```javascript
const TEMPLATE_SELECTION = {
  // Complex accordion pages - custom implementation
  "00435-contracts-post-award": "custom-complex",
  "00800-design": "custom-complex",

  // Simple pages - Template A variants
  "with-background": "template-a-background",
  "without-background": "template-a-clean",

  // Special cases
  "authentication": "minimal-template",
  "utility": "template-a-clean"
};
```

### Phase 2: Directory Structure Setup

#### 2.1 Standard Directory Structure
```
client/src/pages/{page-id}-{page-name}/
├── {page-id}-index.js                    # Entry point
├── components/
│   ├── {page-id}-{page-name}-page.js     # Main component
│   ├── {page-id}-{page-name}-grid.js     # Data display (if needed)
│   └── modals/
│       └── {page-id}-{page-name}-modal.js # Modal components
└── assets/
    └── {page-id}.png                     # Background image (if allowed)
```

#### 2.2 CSS Structure (Template A Standard)
```
client/src/common/css/pages/{page-id}-{page-name}/
└── {page-id}-{page-name}-style.css       # Page-specific styles
```

### Phase 3: Component Implementation

#### 3.1 Mandatory Imports (ALL PAGES)
```javascript
// CRITICAL: These imports are REQUIRED for ALL pages
import React, { useState, useEffect } from "react";
import { AccordionComponent } from "@modules/accordion/00200-accordion-component.js";
import { AccordionProvider } from "@modules/accordion/context/00200-accordion-context.js";
import settingsManager from "@common/js/ui/00200-ui-display-settings.js";

// Template A pages only
import "../../templates/template-a-standard.css";

// Background image pages only
import { getThemedImagePath } from "@common/js/ui/00210-image-theme-helper.js";
```

#### 3.2 Mandatory State Management (ALL PAGES)
```javascript
const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);
const [activeTab, setActiveTab] = useState("default");
const [isLoading, setIsLoading] = useState(true);
const [error, setError] = useState(null);
const [data, setData] = useState([]);
```

#### 3.3 Mandatory Settings Manager Initialization (ALL PAGES)
```javascript
useEffect(() => {
  console.log(`[${pageName}] Component mounting - setting title and initializing settings`);
  document.title = "Page Title - ConstructAI";

  // Set page name for Accordion system
  window.pageName = "{page-id}-{page-name}";

  const initSettings = async () => {
    try {
      console.log(`[${pageName}] Initializing settings manager...`);
      if (!settingsManager) {
        console.warn(`[${pageName}] Settings manager is not available`);
        setIsSettingsInitialized(true);
        return;
      }
      await settingsManager.initialize();
      console.log(`[${pageName}] Settings manager initialized`);
      try {
        await settingsManager.applySettings();
        console.log(`[${pageName}] Settings applied successfully`);
      } catch (applyError) {
        console.warn(`[${pageName}] Could not apply settings, using defaults:`, applyError);
      }
      setIsSettingsInitialized(true);
    } catch (err) {
      console.error(`[${pageName}] Error initializing settings:`, {
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
    console.log(`[${pageName}] Component unmounting`);
    window.pageName = null;
  };
}, []);
```

#### 3.4 Template A: Simple Page WITHOUT Background Image
```javascript
const SimplerPageComponent = () => {
  // Mandatory state (see above)
  const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);

  // Mandatory initialization (see above)
  useEffect(() => { /* settings init */ }, []);

  return (
    <div className="page-container">
      {/* Page Header */}
      <div className="template-a-header-section">
        <div className="template-a-header-content">
          <h1>Page Title</h1>
          <p>Page description</p>
        </div>
      </div>

      {/* Content Wrapper */}
      <div className="template-a-content-wrapper">
        <div className="template-a-card">
          <div className="template-a-card-header">
            <h3>Content Section</h3>
          </div>
          <div className="template-a-card-body">
            {/* Page content */}
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
};
```

#### 3.5 Template B: Simple Page WITH Background Image
```javascript
const SimplerPageWithBackgroundComponent = () => {
  // Mandatory state (see above)
  const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);

  // Background image for workflow pages
  const backgroundImagePath = getThemedImagePath('{page-id}.png');

  return (
    <div className="page-wrapper">
      {/* Background image - ONLY for approved pages */}
      <div
        className="page-background"
        style={{
          backgroundImage: `url(${backgroundImagePath})`,
          backgroundSize: 'cover',
          backgroundPosition: 'center bottom',
          backgroundRepeat: 'no-repeat',
          backgroundAttachment: 'fixed',
          minHeight: '100vh',
          width: '100%',
          position: 'fixed',
          top: 0,
          left: 0,
          zIndex: -1
        }}
      />

      {/* Content wrapper with higher z-index */}
      <div className="content-wrapper" style={{ position: 'relative', zIndex: 1 }}>
        {/* Same content structure as Template A */}
        <div className="template-a-header-section">
          {/* Header content */}
        </div>

        <div className="template-a-content-wrapper">
          {/* Page content */}
        </div>
      </div>

      {/* MANDATORY: Same accordion and logout as Template A */}
    </div>
  );
};
```

#### 3.6 Document Compilation Suite Template
```javascript
const DocumentCompilationSuiteComponent = () => {
  // Mandatory state (see above)
  const [isSettingsInitialized, setIsSettingsInitialized] = useState(false);

  // Document Compilation Suite specific state
  const [documentData, setDocumentData] = useState(null);
  const [documentStatus, setDocumentStatus] = useState('draft'); // draft, generating, review, approved, completed
  const [country, setCountry] = useState('ZA'); // ZA, GN, SA, etc.
  const [progress, setProgress] = useState(0);
  const [aiGenerating, setAiGenerating] = useState(false);
  const [aiConfidence, setAiConfidence] = useState(0);
  const [hitlWorkflow, setHitlWorkflow] = useState(null);
  const [validationResults, setValidationResults] = useState(null);

  // Context and procurement data
  const [procurementOrder, setProcurementOrder] = useState(null);
  const [contextData, setContextData] = useState(null);
  const [cargoSpecifications, setCargoSpecifications] = useState(null);

  // Modal states
  const [showSaveModal, setShowSaveModal] = useState(false);
  const [showExportModal, setShowExportModal] = useState(false);

  // Mandatory initialization (see above)
  useEffect(() => { /* settings init */ }, []);

  // Load procurement order and context data
  useEffect(() => {
    if (orderId) {
      loadProcurementOrder();
      loadExistingDocument();
    }
  }, [orderId]);

  // Auto-detect country when order loads
  useEffect(() => {
    if (procurementOrder) {
      const detectedCountry = detectCountry(procurementOrder);
      setCountry(detectedCountry);
      loadContextData();
    }
  }, [procurementOrder]);

  const loadProcurementOrder = async () => {
    try {
      const response = await fetch(`/api/procurement/orders/${orderId}`);
      if (!response.ok) throw new Error('Failed to load procurement order');
      const orderData = await response.json();
      setProcurementOrder(orderData);
      setCargoSpecifications(extractCargoSpecs(orderData));
    } catch (err) {
      console.error('Error loading procurement order:', err);
      setError('Failed to load procurement order data');
    }
  };

  const loadContextData = async () => {
    try {
      const response = await fetch(`/api/logistics/context/${orderId}`);
      if (response.ok) {
        const context = await response.json();
        setContextData(context);
      }
    } catch (err) {
      console.warn('Could not load context data:', err);
    }
  };

  const generateDocument = async () => {
    setAiGenerating(true);
    setProgress(10);

    try {
      const promptData = {
        documentType: 'export_declaration', // or other document type
        country: country,
        context: contextData,
        cargo: cargoSpecifications,
        procurementOrder: procurementOrder
      };

      const response = await fetch('/api/logistics/ai/generate', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(promptData)
      });

      if (!response.ok) throw new Error('AI generation failed');
      const result = await response.json();

      setDocumentData(result.document);
      setAiConfidence(result.confidence);
      setValidationResults(result.validation);
      setDocumentStatus('generated');
      setProgress(80);

    } catch (err) {
      console.error('Error generating document:', err);
      setError('Failed to generate document');
    } finally {
      setAiGenerating(false);
    }
  };

  const handleFormDataChange = (field, value) => {
    setDocumentData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  // Render country-specific form component
  const renderCountryForm = () => {
    const commonProps = {
      documentData,
      onChange: handleFormDataChange,
      validationResults,
      cargoSpecs: cargoSpecifications,
      contextData,
      procurementOrder
    };

    switch (country) {
      case 'ZA': return <SouthAfricanForm {...commonProps} />;
      case 'GN': return <GuineaForm {...commonProps} />;
      case 'SA': return <SaudiForm {...commonProps} />;
      default: return <SouthAfricanForm {...commonProps} />;
    }
  };

  return (
    <div className="page-container">
      {/* Page Header */}
      <div className="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h2>Document Title - Order #{orderId || 'Demo'}</h2>
          <p className="text-muted">Document description with country support</p>
        </div>

        <div className="d-flex gap-2">
          <Badge bg={getStatusColor(documentStatus)}>{documentStatus.toUpperCase()}</Badge>
          <Form.Select value={country} onChange={(e) => setCountry(e.target.value)}>
            <option value="ZA">🇿🇦 South Africa</option>
            <option value="GN">🇬🇳 Guinea</option>
            <option value="SA">🇸🇦 Saudi Arabia</option>
          </Form.Select>
        </div>
      </div>

      {/* Progress Bar */}
      <ProgressBar now={progress} className="mb-4" />

      {/* Alerts */}
      {error && <Alert variant="danger" dismissible onClose={() => setError(null)}>{error}</Alert>}
      {success && <Alert variant="success" dismissible onClose={() => setSuccess(null)}>{success}</Alert>}

      {/* Multi-Panel Dashboard Layout */}
      <div className="d-flex flex-column gap-4">
        {/* Country-Specific Form Panel */}
        {renderCountryForm()}

        {/* AI Generation Panel */}
        <AIGenerationPanel
          documentType="export_declaration"
          country={country}
          contextData={contextData}
          cargoSpecs={cargoSpecifications}
          onGenerate={generateDocument}
          generating={aiGenerating}
          confidence={aiConfidence}
          disabled={!contextData || !cargoSpecifications}
        />

        {/* HITL Workflow Panel - Conditional */}
        {hitlWorkflow && (
          <HITLWorkflowPanel
            workflow={hitlWorkflow}
            documentStatus={documentStatus}
            onStatusChange={setDocumentStatus}
          />
        )}

        {/* Context Gathering Panel */}
        <ContextGatheringPanel
          orderId={orderId}
          contextData={contextData}
          cargoSpecs={cargoSpecifications}
          onContextUpdate={setContextData}
        />

        {/* Document Actions Panel */}
        <DocumentActions
          documentData={documentData}
          documentStatus={documentStatus}
          onSave={() => setShowSaveModal(true)}
          onExport={() => setShowExportModal(true)}
          onSubmitApproval={submitForApproval}
          onGenerate={generateDocument}
          generating={aiGenerating}
        />

        {/* Document History Panel */}
        <DocumentHistoryPanel
          documentType="export_declaration"
          country={country}
          orderId={orderId}
          onLoadDocument={loadExistingDocument}
          onNewDocument={() => {
            setDocumentData(null);
            setDocumentStatus('draft');
            setProgress(0);
          }}
        />
      </div>

      {/* Save Modal */}
      <Modal show={showSaveModal} onHide={() => setShowSaveModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Save Document</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <p>Save changes to this document?</p>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowSaveModal(false)}>Cancel</Button>
          <Button variant="primary" onClick={saveDocument}>Save</Button>
        </Modal.Footer>
      </Modal>

      {/* Export Modal */}
      <Modal show={showExportModal} onHide={() => setShowExportModal(false)}>
        <Modal.Header closeButton>
          <Modal.Title>Export Document</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <p>Choose export format:</p>
          <div className="d-flex gap-2">
            <Button variant="outline-primary" onClick={() => exportDocument('pdf')}>📄 PDF</Button>
            <Button variant="outline-primary" onClick={() => exportDocument('docx')}>📝 Word</Button>
            <Button variant="outline-primary" onClick={() => exportDocument('json')}>📊 JSON</Button>
          </div>
        </Modal.Body>
      </Modal>

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
};
```

#### 3.7 Document Compilation Suite: Required Components

**Document Compilation Suite pages require these specialized components:**

##### **3.7.1 Country-Specific Form Components**
```javascript
// Each country needs its own form component
// Example: SouthAfricanExportDeclaration.js
const SouthAfricanExportDeclaration = ({
  documentData,
  onChange,
  validationResults,
  cargoSpecs,
  contextData,
  procurementOrder
}) => {
  return (
    <Card>
      <Card.Header>
        <Card.Title>🇿🇦 South African Export Declaration (Form DA 1)</Card.Title>
      </Card.Header>
      <Card.Body>
        {/* Country-specific form fields */}
        <Form.Group className="mb-3">
          <Form.Label>Exporter Details</Form.Label>
          <Form.Control
            type="text"
            value={documentData?.exporter_details || ''}
            onChange={(e) => onChange('exporter_details', e.target.value)}
            isInvalid={validationResults?.exporter_details}
          />
          <Form.Control.Feedback type="invalid">
            {validationResults?.exporter_details}
          </Form.Control.Feedback>
        </Form.Group>
        {/* Additional country-specific fields */}
      </Card.Body>
    </Card>
  );
};
```

##### **3.7.2 AI Generation Panel Component**
```javascript
// AIGenerationPanel.js - Handles AI document generation
const AIGenerationPanel = ({
  documentType,
  country,
  contextData,
  cargoSpecs,
  onGenerate,
  generating,
  confidence,
  disabled
}) => {
  return (
    <Card>
      <Card.Header>
        <Card.Title>🤖 AI Document Generation</Card.Title>
      </Card.Header>
      <Card.Body>
        <Row>
          <Col md={8}>
            <p>Generate {documentType.replace('_', ' ')} using AI with context intelligence</p>
            {confidence > 0 && (
              <div>
                <small>AI Confidence: {confidence}%</small>
                <ProgressBar now={confidence} className="mt-2" />
              </div>
            )}
          </Col>
          <Col md={4} className="text-end">
            <Button
              onClick={onGenerate}
              disabled={disabled || generating}
              variant="primary"
            >
              {generating ? <Spinner size="sm" /> : '🎯'} Generate Document
            </Button>
          </Col>
        </Row>
      </Card.Body>
    </Card>
  );
};
```

##### **3.7.3 HITL Workflow Panel Component**
```javascript
// HITLWorkflowPanel.js - Human-in-the-Loop approval workflow
const HITLWorkflowPanel = ({
  workflow,
  documentStatus,
  onStatusChange
}) => {
  const getWorkflowSteps = () => [
    { status: 'draft', label: 'Draft', icon: '📝' },
    { status: 'generated', label: 'AI Generated', icon: '🤖' },
    { status: 'review', label: 'Under Review', icon: '👀' },
    { status: 'approved', label: 'Approved', icon: '✅' },
    { status: 'completed', label: 'Completed', icon: '🎉' }
  ];

  return (
    <Card>
      <Card.Header>
        <Card.Title>🔄 Human-in-the-Loop Workflow</Card.Title>
      </Card.Header>
      <Card.Body>
        <div className="workflow-steps">
          {getWorkflowSteps().map((step, index) => (
            <div key={step.status} className="workflow-step">
              <Badge bg={documentStatus === step.status ? 'primary' : 'secondary'}>
                {step.icon} {step.label}
              </Badge>
              {index < getWorkflowSteps().length - 1 && <span className="workflow-arrow">→</span>}
            </div>
          ))}
        </div>
        {workflow?.approvers && (
          <div className="mt-3">
            <h6>Current Approvers:</h6>
            <ul>
              {workflow.approvers.map(approver => (
                <li key={approver.id}>{approver.name} ({approver.role})</li>
              ))}
            </ul>
          </div>
        )}
      </Card.Body>
    </Card>
  );
};
```

##### **3.7.4 Context Gathering Panel Component**
```javascript
// ContextGatheringPanel.js - Gathers additional context data
const ContextGatheringPanel = ({
  orderId,
  contextData,
  cargoSpecs,
  onContextUpdate
}) => {
  const [showModal, setShowModal] = useState(false);

  return (
    <Card>
      <Card.Header>
        <Card.Title>📋 Context Gathering</Card.Title>
        <Button variant="outline-primary" size="sm" onClick={() => setShowModal(true)}>
          Edit Context
        </Button>
      </Card.Header>
      <Card.Body>
        <Row>
          <Col md={6}>
            <h6>Procurement Order #{orderId}</h6>
            <p><strong>Description:</strong> {cargoSpecs?.description}</p>
            <p><strong>Value:</strong> {cargoSpecs?.value} {cargoSpecs?.currency}</p>
          </Col>
          <Col md={6}>
            <h6>Origin/Destination</h6>
            <p><strong>From:</strong> {cargoSpecs?.originCountry}</p>
            <p><strong>To:</strong> {cargoSpecs?.destinationCountry}</p>
          </Col>
        </Row>
      </Card.Body>

      {/* Context editing modal would go here */}
    </Card>
  );
};
```

##### **3.7.5 Document Actions Panel Component**
```javascript
// DocumentActions.js - Save, export, submit actions
const DocumentActions = ({
  documentData,
  documentStatus,
  onSave,
  onExport,
  onSubmitApproval,
  onGenerate,
  generating
}) => {
  return (
    <Card>
      <Card.Header>
        <Card.Title>⚡ Document Actions</Card.Title>
      </Card.Header>
      <Card.Body>
        <div className="d-flex gap-2 flex-wrap">
          <Button
            variant="success"
            onClick={onSave}
            disabled={!documentData}
          >
            💾 Save Document
          </Button>

          <Button
            variant="primary"
            onClick={onExport}
            disabled={!documentData}
          >
            📤 Export Document
          </Button>

          <Button
            variant="warning"
            onClick={onSubmitApproval}
            disabled={documentStatus !== 'generated'}
          >
            📋 Submit for Approval
          </Button>

          <Button
            variant="info"
            onClick={onGenerate}
            disabled={generating}
          >
            {generating ? <Spinner size="sm" /> : '🔄'} Regenerate
          </Button>
        </div>
      </Card.Body>
    </Card>
  );
};
```

##### **3.7.6 Document History Panel Component**
```javascript
// DocumentHistoryPanel.js - View document history and versions
const DocumentHistoryPanel = ({
  documentType,
  country,
  orderId,
  onLoadDocument,
  onNewDocument
}) => {
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // Load document history
    loadHistory();
  }, [documentType, country, orderId]);

  const loadHistory = async () => {
    try {
      const response = await fetch(`/api/logistics/documents/history/${orderId}?type=${documentType}&country=${country}`);
      if (response.ok) {
        const data = await response.json();
        setHistory(data);
      }
    } catch (err) {
      console.warn('Could not load document history:', err);
    }
  };

  return (
    <Card>
      <Card.Header>
        <Card.Title>📚 Document History</Card.Title>
        <Button variant="outline-success" size="sm" onClick={onNewDocument}>
          ➕ New Document
        </Button>
      </Card.Header>
      <Card.Body>
        {history.length === 0 ? (
          <p className="text-muted">No previous documents found</p>
        ) : (
          <ListGroup variant="flush">
            {history.map((doc, index) => (
              <ListGroup.Item key={doc.id}>
                <Row className="align-items-center">
                  <Col md={8}>
                    <div>
                      <Badge bg={getStatusColor(doc.status)}>{doc.status.toUpperCase()}</Badge>
                      <small className="text-muted ms-2">{new Date(doc.created_at).toLocaleDateString()}</small>
                    </div>
                    <p className="mb-0 small">Version {doc.version} - {country.toUpperCase()}</p>
                  </Col>
                  <Col md={4} className="text-end">
                    <Button
                      variant="outline-primary"
                      size="sm"
                      onClick={() => onLoadDocument(doc)}
                    >
                      Load
                    </Button>
                  </Col>
                </Row>
              </ListGroup.Item>
            ))}
          </ListGroup>
        )}
      </Card.Body>
    </Card>
  );
};
```

#### 3.8 Complex Accordion Page Template (Reference Only)
**Note:** Complex pages follow custom patterns. Reference 00435-contracts-post-award for implementation details.

### Phase 4: CSS Implementation (Template A Standard)

#### 4.1 Template A CSS Structure
```css
/* ============= TEMPLATE A - {PAGE NAME} PAGE ============= */
/* Import Template A Standard Styles */
@import "../../templates/template-a-standard.css";

/* Page-specific customizations only */

/* Page Container Overrides */
.{page-id}-{page-name}-main-container {
  /* Only add if Template A defaults need adjustment */
}

/* Page-Specific Components */
.{page-id}-{page-name}-custom-component {
  /* Custom styles for unique page elements */
}

/* Responsive Design */
@media (max-width: 768px) {
  .{page-id}-{page-name}-main-container {
    /* Mobile adjustments */
  }
}

@media (max-width: 576px) {
  .{page-id}-{page-name}-main-container {
    /* Small screen adjustments */
  }
}
```

#### 4.2 CSS Variables Reference
```css
/* Template A Standard Variables (inherited) */
--template-a-primary: #FF8C00;
--template-a-secondary: #FFA500;
--template-a-bg-gradient: linear-gradient(135deg, #FF8C00 0%, #FF6B35 100%);
--template-a-header-gradient: linear-gradient(135deg, #FFA500 0%, #FF8C00 100%);
--template-a-text-white: #ffffff;
--template-a-text-primary: #1a1a1a;
--template-a-card-bg: rgba(255, 255, 255, 0.95);
--template-a-shadow-md: 0 4px 20px rgba(0, 0, 0, 0.1);
```

### Phase 5: Registration & Integration

#### 5.1 UI Display Mappings (client/src/common/js/ui/00200-ui-display-settings.js)
```javascript
// Add to UI_DISPLAY_MAPPINGS
"{page-id}": {
  path: "/{page-name}",
  component: "{PageName}Component",
  title: "Page Title",
  category: "business|administration|utility",
  requiresAuth: true,
  icon: "icon-name"
}
```

#### 5.2 App.js Route Registration
```javascript
// Add to App.js routes
import {PageName}Component from "./pages/{page-id}-{page-name}/{page-id}-index.js";

// Add to route configuration
<Route path="/{page-name}" element={<{PageName}Component />} />
```

#### 5.3 Accordion Navigation Integration (MANDATORY - 3-Tier System)

**CRITICAL**: All new pages require accordion navigation integration using the 3-tier fallback system. Update ALL THREE files in this exact order:

##### 5.3.1 Server Template (server/src/routes/accordion-sections-routes.js)
```javascript
// Add to MASTER_TEMPLATE array
{
  id: 'accordion-button-{page-id}',
  title: '{Page Title}',
  display_order: {page-id}, // Numeric display order for sorting
  sector: 'global|epcm|contractor|judicial', // See sector definitions below
  links: [
    { title: '{Page Title}', url: '/{page-name}' },
    { title: 'Documents', url: '/all-documents' }, // Standard link
    { title: 'Email Management', url: '/email-management' }, // Standard link
    // Additional links in alphabetical order (A-Z, case-insensitive)
  ],
  subsections: {
    // Optional: For complex pages with subsections
    'subsection-{page-id}-001': {
      title: 'Subsection Title',
      links: [
        { title: 'Subsection Link', url: '/subsection-page' }
      ]
    }
  }
}
```

##### 5.3.2 Client Fallback (client/src/common/js/config/00200-ui-display-mappings.js)
```javascript
// Add to sectionMappings object
"accordion-button-{page-id}": {
  title: "{Page Title}",
  optionId: {page-id},
  links: [
    "/{page-name}",
    "00200-all-documents.html",
    "03010-email-management.html",
    // Additional links in alphabetical order
  ],
  subsections: {},
  sector: "global|epcm|contractor|judicial",
  allowedOrganizations: ["Simandou", "PropAI", "Organisations - EPCM"]
}
```

##### 5.3.3 Sector Definitions & Organization Access
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

##### 5.3.4 Alphabetical Link Ordering (MANDATORY)
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

##### 5.3.5 3-Tier Fallback System Verification
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

#### 5.4 Organization & Collaboration Support
```javascript
// For multi-organization environments
const MULTI_ORG_CONFIG = {
  // Template inheritance for different org types
  'Organizations - EPCM': 'master',
  'Organizations - Contractors': 'contractor',

  // Collaboration settings (if needed)
  collaborationSupport: {
    sharedSections: ['01900', '02400'], // Shared section IDs
    pagePrecedence: 'host|collaborator' // Which org's pages take precedence
  }
};
```

### Phase 6: Quality Assurance Checklist

#### 6.1 Pre-Implementation Review
- [ ] Page type correctly identified (simple/complex)
- [ ] Background image policy followed
- [ ] Template A standard selected
- [ ] Directory structure planned

#### 6.2 During Implementation
- [ ] All mandatory imports included
- [ ] Settings manager properly initialized
- [ ] Accordion integration implemented
- [ ] Template A CSS imported
- [ ] Logout button added

#### 6.3 Post-Implementation Testing
- [ ] **CRITICAL**: Accordion loads and functions
- [ ] **CRITICAL**: Settings manager initializes without errors
- [ ] **CRITICAL**: Logout button appears and works
- [ ] **CRITICAL**: Page loads in both local and server environments
- [ ] Background image displays correctly (if applicable)
- [ ] Responsive design works on mobile/desktop
- [ ] All page functionality works as expected
- [ ] Console errors resolved

### Phase 7: Documentation & Handover

#### 7.1 Update Documentation
- [ ] Add page to 1300_00000_PAGE_LIST.md
- [ ] Create master guide: 1300_{page-id}_MASTER_GUIDE.md
- [ ] Document any custom implementation details

#### 7.2 Final Verification
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Testing passed
- [ ] Ready for production deployment

## 🚨 Critical Implementation Rules

### Background Image Rules (NO EXCEPTIONS)
1. **ONLY** timesheet-style workflow pages get background images
2. **NEVER** add backgrounds to data management pages
3. **ALWAYS** check the allowed list before implementing
4. **COMPLETELY PROHIBITED** for authentication pages

### Template A Compliance (MANDATORY)
1. **ALL** new simple pages must use Template A
2. **NO** custom CSS frameworks or conflicting styles
3. **IMPORT** template-a-standard.css first
4. **USE** CSS variables for theming

### Accordion Integration (MANDATORY)
1. **ALL** pages must integrate with AccordionComponent
2. **ALL** pages must use AccordionProvider wrapper
3. **ALL** pages must initialize settingsManager
4. **ALL** pages must have logout button

### Page Type Consistency
1. **Simple pages**: Tab-based navigation only
2. **Complex pages**: Three-state navigation (Agents/Upsert/Workspace)
3. **NEVER** mix navigation patterns
4. **ALWAYS** follow established patterns

## 🛠️ Common Implementation Mistakes (AVOID)

### ❌ Background Image Errors
```javascript
// WRONG: Adding background to data management page
<div style={{ backgroundImage: 'url(...)' }}> // ❌ NEVER DO THIS

// WRONG: Using background for authentication
const LoginPage = () => <div style={{ backgroundImage: 'url(...) }}> // ❌ PROHIBITED
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

## 📚 Reference Implementation Examples

### ✅ CORRECT: 00200 All Documents (Template A Clean)
- No background image
- Template A standard CSS
- Card-based layout
- Proper accordion integration

### ✅ CORRECT: 00106 Timesheet (Template A with Background)
- Fixed background image
- Template A standard CSS
- Tab-based navigation
- Proper theming integration

### ✅ CORRECT: 01700 Export Declaration (Document Compilation Suite)
- Multi-country document generation (ZA, GN, SA)
- AI-assisted creation with confidence scoring
- HITL workflow integration and approval routing
- Multi-format export capabilities (PDF, DOCX, JSON)
- Procurement order data integration
- Specialized panel architecture (context gathering, AI generation, workflow, actions, history)
- Template A base with specialized document panels

### ✅ CORRECT: 00435 Contracts Post-Award (Complex Custom)
- Dynamic background theming
- Three-state navigation
- Custom CSS architecture
- Advanced modal systems

## 📋 Final Checklist Summary

### Pre-Implementation ✅
- [ ] Page type determined
- [ ] Background policy checked
- [ ] Template selected
- [ ] Directory structure planned

### Implementation ✅
- [ ] Mandatory imports included
- [ ] Settings manager initialized
- [ ] Accordion integrated
- [ ] Template A CSS imported
- [ ] Logout button added

### Post-Implementation ✅
- [ ] Testing completed
- [ ] Documentation updated
- [ ] Code review passed
- [ ] Production ready

---

## 🔧 **Hybrid Prompt Management System Integration**

### **Overview for Page Implementations**
When implementing pages that include AI prompts or agent interactions, integrate the **Hybrid Prompt Management System** to provide **developer-only prompt editing** with **user preference controls**. This ensures maximum security while enabling meaningful user customization for basic pages.

### **Integration Requirements for Basic Pages**

#### **Phase 3: AI Integration (Optional for Basic Pages)**
If your page includes AI prompts (< 5), integrate the hybrid system:

1. **Developer Tools Access**
   - Include developer modal activation (Ctrl+Shift+P)
   - Provide basic prompt testing interface
   - Enable prompt validation and syntax checking

2. **User Preferences Integration**
   - Add user preferences modal to page settings
   - Include safe preference options (tone, format, detail level)
   - Apply preferences to AI responses automatically

3. **Security Controls**
   - Validate all user inputs before prompt application
   - Ensure developer-only tools are properly access-controlled
   - Implement audit logging for prompt operations

### **Implementation Checklist for AI-Enhanced Pages**

#### **Developer Tools Integration**
- [ ] Developer modal accessible via keyboard shortcuts
- [ ] Basic prompt testing interface functional
- [ ] Prompt validation and error checking enabled
- [ ] Access control prevents unauthorized developer access

#### **User Preferences Integration**
- [ ] User preferences modal available in page settings
- [ ] Safe preference options (tone, format, length) implemented
- [ ] Preferences applied correctly to AI responses
- [ ] Preference validation prevents security issues

#### **Security & Compliance**
- [ ] All user inputs validated and sanitized
- [ ] Developer access properly restricted
- [ ] Audit logging captures all prompt operations
- [ ] No prompt injection vulnerabilities present

### **Code Integration Examples**

#### **Basic Page with AI Enhancement**
```javascript
const EnhancedPageComponent = () => {
  const [userPreferences, setUserPreferences] = useState({});
  const [showPreferences, setShowPreferences] = useState(false);

  // Apply preferences to AI responses
  const enhanceResponse = (baseResponse) => {
    return applyUserPreferences(baseResponse, userPreferences);
  };

  return (
    <div className="page-container">
      {/* Page content */}
      
      {/* User Preferences Button */}
      <button 
        onClick={() => setShowPreferences(true)}
        className="preferences-button"
      >
        AI Preferences
      </button>

      {/* Preferences Modal */}
      {showPreferences && (
        <UserPreferencesModal
          preferences={userPreferences}
          onSave={setUserPreferences}
          onClose={() => setShowPreferences(false)}
        />
      )}

      {/* Developer Tools (automatically available via shortcuts) */}
      {/* No UI needed - modal appears on Ctrl+Shift+P */}
    </div>
  );
};
```

### **Success Criteria**
- [ ] Page functions correctly with or without AI enhancement
- [ ] User preferences safely customize AI responses
- [ ] Developer tools accessible but secure
- [ ] No security vulnerabilities introduced
- [ ] Performance impact minimal for non-AI pages

### **When to Use**
- ✅ Pages with basic AI chat or assistance features
- ✅ Simple form validation or data processing with AI
- ✅ User-facing features requiring customization
- ❌ Complex agent workflows (use 0002 procedure instead)
- ❌ Enterprise integrations (use 0002 procedure instead)

---

## 🚨 **Critical Implementation Patterns**

### **Loading State Management with Demo Data Fallbacks**

#### **Problem: Infinite Loading Spinners**
Pages get stuck in infinite loading states when URL parameters are missing or API calls fail, providing poor user experience.

#### **✅ Solution: Always Provide Demo Data Fallbacks**
```javascript
// CRITICAL: Always provide fallback for missing parameters
useEffect(() => {
  if (orderId) {
    loadProcurementOrder();
    loadExistingDocument();
  } else {
    // CRITICAL: Demo data fallback prevents infinite loading
    loadDemoData();
  }
}, [orderId]);

const loadDemoData = () => {
  // Provide complete mock data for testing
  const demoOrder = {
    id: 'DEMO-001',
    supplier: { name: 'Demo Supplier', country: 'ZA' },
    client: { name: 'Demo Client', country: 'ZA' },
    product_description: 'Demo product description',
    hs_code: '12345678',
    total_value: 100000,
    currency: 'ZAR'
  };
  const demoContext = {
    exporterDetails: demoOrder.supplier,
    importerDetails: demoOrder.client,
    cargoDescription: demoOrder.product_description
  };

  setProcurementOrder(demoOrder);
  setContextData(demoContext);
  setCargoSpecifications(extractCargoSpecs(demoOrder));
  setLoading(false); // CRITICAL: End loading state
};
```

#### **Error Handling with Loading State Management**
```javascript
const loadProcurementOrder = async () => {
  try {
    setLoading(true);
    const response = await fetch(`/api/procurement/orders/${orderId}`);

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const orderData = await response.json();
    setProcurementOrder(orderData);
    setCargoSpecifications(extractCargoSpecs(orderData));

  } catch (err) {
    console.error('Error loading procurement order:', err);
    setError(`Failed to load procurement order: ${err.message}`);
    // DO NOT set loading to false here - let finally block handle it
  } finally {
    setLoading(false); // CRITICAL: Always clear loading state
  }
};
```

### **Parameter Handling for Optional URL Parameters**

#### **Problem: Undefined Parameters Cause Errors**
Components expect required URL parameters but routes don't always provide them, leading to undefined errors.

#### **✅ Solution: Normalize Optional Parameters**
```javascript
// REQUIRED: Handle optional parameters gracefully
const { orderId } = useParams(); // May be undefined
const orderIdParam = orderId || null; // Normalize to null

// Use normalized parameter in effects
useEffect(() => {
  if (orderIdParam) {
    loadRealData(orderIdParam);
  } else {
    loadDemoData(); // REQUIRED fallback
  }
}, [orderIdParam]);

// Display appropriate titles
const pageTitle = orderIdParam ? `Order #${orderIdParam}` : 'Demo Document';
```

#### **Route Configuration for Optional Parameters**
```javascript
// App.js - Include both parameterized and demo routes
<Route path="/logistics-documents/export/export-declaration" element={<ExportDeclarationPage />} />
<Route path="/logistics-documents/export/export-declaration/:orderId" element={<ExportDeclarationPage />} />
```

### **Database Constraint Navigation**

#### **Problem: Schema Constraints Block Data Insertion**
Existing tables have strict constraints (check constraints, foreign keys, RLS policies) that prevent data insertion.

#### **✅ Solution: Understand and Work Within Constraints**

**1. Check Constraints (Document Types)**
```javascript
// PROBLEM: Table only allows 'export_declaration'
const allowedDocumentTypes = ['export_declaration']; // Only this value allowed

// SOLUTION: Use allowed values, store subtype in content
const invoiceData = {
  document_type: 'export_declaration', // Use allowed value
  content: {
    ...documentData,
    documentSubType: 'commercial_invoice', // Store actual type here
    country_code: selectedCountry // Store country here too
  }
};
```

**2. Foreign Key Constraints**
```javascript
// PROBLEM: procurement_order_id is required (NOT NULL)
const requiredFields = ['procurement_order_id']; // Must be valid UUID

// SOLUTION: Use existing order or handle gracefully
const existingOrderId = 'ad3c4e8d-dc73-41cf-8179-6e584d0c0d66'; // From database
const invoiceData = {
  ...invoiceData,
  procurement_order_id: existingOrderId // Use valid foreign key
};
```

**3. Row Level Security (RLS) Policies**
```javascript
// PROBLEM: Anonymous users can't insert due to RLS
const rlsError = 'new row violates row-level security policy';

// SOLUTION: Use service role for administrative operations
const supabase = createClient(url, SUPABASE_SERVICE_ROLE_KEY); // Bypasses RLS
```

#### **UUID vs String Type Handling**
```javascript
// PROBLEM: generated_by expects UUID, not string
const uuidError = 'invalid input syntax for type uuid';

// SOLUTION: Use null for optional UUID fields
const documentData = {
  document_type: 'export_declaration',
  generated_by: null, // null is valid for optional UUID
  content: { /* document data */ }
};
```

### **Service Role vs User Authentication Patterns**

#### **Problem: Authentication Context Confusion**
Data population scripts run without user context, but RLS policies require authenticated users for operations.

#### **✅ Solution: Use Appropriate Authentication Level**

**Service Role for Administrative Operations:**
```javascript
// Use service role for data population, schema setup, testing
const supabase = createClient(url, process.env.SUPABASE_SERVICE_ROLE_KEY);

// Bypasses RLS policies for administrative operations
// REQUIRED for: table creation, bulk data insertion, schema changes
// NEVER use in production user-facing code
```

**User Authentication for Production:**
```javascript
// Use user authentication for production operations
const supabase = createClient(url, process.env.SUPABASE_ANON_KEY);

// Respects RLS policies and user permissions
// REQUIRED for: user data access, business operations
// ALWAYS use in production user-facing code
```

**When to Use Each:**
- **Service Role**: Data population scripts, schema migrations, testing
- **User Auth**: All production user operations, respecting permissions

### **JSON Content Field Usage for Flexible Metadata**

#### **Problem: Fixed Schema Limitations**
Database tables have fixed schemas but need to store additional metadata or varying data structures.

#### **✅ Solution: Leverage JSON Content Fields**
```javascript
// Store country-specific data in content field
const documentData = {
  document_type: 'export_declaration',
  direction: 'export',
  procurement_order_id: existingOrderId,
  status: 'approved',
  content: {
    // Standard document data
    exporterDetails: { /* exporter info */ },
    importerDetails: { /* importer info */ },
    invoiceDetails: { /* invoice data */ },

    // Additional metadata in JSON content
    country_code: selectedCountry,           // ZA, GN, SA
    documentSubType: 'commercial_invoice',  // Actual document type
    regulatoryRequirements: ['VAT', 'customs'], // Country-specific rules
    aiMetadata: {                             // AI generation data
      confidence: 95,
      model: 'gpt-4-turbo',
      validationStatus: 'valid'
    }
  }
};
```

#### **Querying JSON Content Fields**
```javascript
// Query by country code stored in content
const { data } = await supabase
  .from('logistics_documents')
  .select('*')
  .eq('content->>country_code', 'ZA'); // Query JSON field

// Query by document subtype
const { data } = await supabase
  .from('logistics_documents')
  .select('*')
  .eq('content->>documentSubType', 'commercial_invoice');
```

### **Error Recovery and Resilient Error Handling**

#### **Problem: Single Failures Stop Entire Operations**
Bulk operations fail completely when individual items encounter errors, preventing partial success.

#### **✅ Solution: Implement Resilient Error Handling**
```javascript
// Continue processing despite individual failures
async function populateDocuments(documents) {
  let successCount = 0;
  let errorCount = 0;
  const errors = [];

  for (const doc of documents) {
    try {
      await insertDocument(doc);
      successCount++;
      console.log(`✅ Inserted: ${doc.id}`);
    } catch (error) {
      errorCount++;
      errors.push({ doc: doc.id, error: error.message });
      console.error(`❌ Failed: ${doc.id} - ${error.message}`);
      // CONTINUE processing other documents
    }

    // Rate limiting between operations
    await delay(200); // Prevent overwhelming the API
  }

  // Report results
  console.log(`📈 Results: ${successCount} successful, ${errorCount} errors`);
  if (errors.length > 0) {
    console.log('❌ Errors:', errors);
  }

  return { successCount, errorCount, errors };
}
```

#### **Rate Limiting Implementation**
```javascript
// Prevent API rate limit violations
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Use in loops
for (const item of items) {
  await processItem(item);
  await delay(CONFIG.delayMs); // Rate limiting
}
```

### **Testing with Missing/Invalid Parameters**

#### **Problem: Unhandled Parameter States**
Components fail when parameters are missing, undefined, or invalid, leading to crashes and poor testing experience.

#### **✅ Solution: Comprehensive Parameter Testing**
```javascript
// REQUIRED: Test all parameter states
const parameterTestCases = [
  { orderId: null, expected: 'loads demo data, no errors' },
  { orderId: undefined, expected: 'loads demo data, no errors' },
  { orderId: '123', expected: 'loads real data from API' },
  { orderId: 'invalid', expected: 'shows error, loads demo data' },
  { orderId: '', expected: 'loads demo data, no errors' }
];

// Test navigation paths
const navigationTests = [
  '/page',                    // No parameters
  '/page/123',               // Valid parameter
  '/page/invalid',           // Invalid parameter
  '/page/',                  // Empty parameter
  '/page/null'               // String 'null'
];

// Component state testing
const loadingStateTests = [
  'Initial load shows spinner',
  'Successful load shows content',
  'Error load shows error message',
  'Demo data load shows content',
  'Parameter change triggers reload'
];
```

#### **Component Testing Checklist**
```javascript
// REQUIRED: Verify these for every page
const componentChecklist = [
  '✅ Loads without crashing when orderId is null',
  '✅ Shows demo data when no orderId provided',
  '✅ Loads real data when valid orderId provided',
  '✅ Shows appropriate error when orderId is invalid',
  '✅ Loading states work correctly (start/end)',
  '✅ Navigation works in both directions',
  '✅ All buttons and links function',
  '✅ Responsive design works on mobile/desktop'
];
```

### **Implementation Pattern Summary**

#### **✅ REQUIRED PATTERNS FOR ALL PAGES**

**1. Loading State Management:**
```javascript
useEffect(() => {
  if (orderId) {
    loadRealData(orderId);
  } else {
    loadDemoData(); // REQUIRED fallback
  }
}, [orderId]);
```

**2. Error Handling:**
```javascript
try {
  setLoading(true);
  const data = await loadData();
  setData(data);
} catch (error) {
  setError(error.message);
} finally {
  setLoading(false); // ALWAYS clear loading
}
```

**3. Parameter Normalization:**
```javascript
const { orderId } = useParams();
const orderIdParam = orderId || null;
```

**4. Demo Data Provision:**
```javascript
const loadDemoData = () => {
  const demoData = { /* complete mock data */ };
  setData(demoData);
  setLoading(false);
};
```

#### **🚨 COMMON MISTAKES TO AVOID**

**❌ DON'T DO:**
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

// WRONG: Incomplete error handling
} catch (err) {
  setError('Error');
  // No logging, no user details, loading never ends
}
```

**✅ DO THIS:**
```javascript
// CORRECT: Always provide fallback
useEffect(() => {
  if (orderId) {
    loadRealData(orderId);
  } else {
    loadDemoData(); // REQUIRED fallback
  }
}, [orderId]);

// CORRECT: Proper loading state management
const loadData = async () => {
  try {
    setLoading(true);
    const data = await fetchData();
    setData(data);
  } catch (error) {
    setError(error.message);
    console.error('Load failed:', error);
  } finally {
    setLoading(false); // ALWAYS clear loading
  }
};
```

### **Pattern Validation Checklist**

Before marking implementation complete, verify:

- [ ] ✅ Demo data fallback prevents infinite loading
- [ ] ✅ Optional parameters handled gracefully
- [ ] ✅ Loading states always clear (success or error)
- [ ] ✅ Error messages provide user-friendly details
- [ ] ✅ Rate limiting prevents API overload
- [ ] ✅ Foreign key constraints satisfied
- [ ] ✅ RLS policies respected (service role for admin, user auth for production)
- [ ] ✅ JSON content fields used for flexible metadata
- [ ] ✅ Resilient error handling allows partial success
- [ ] ✅ All parameter states tested (null, undefined, valid, invalid)

---

**This procedure ensures consistent, maintainable, and robust page implementations across the ConstructAI system. All new pages must follow these critical patterns without exception.**

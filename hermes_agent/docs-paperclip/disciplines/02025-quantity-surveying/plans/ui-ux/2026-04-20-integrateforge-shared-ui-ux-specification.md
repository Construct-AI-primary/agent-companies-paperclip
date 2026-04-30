---
title: "IntegrateForge Shared UI/UX Specification"
description: "Shared user interface specification for all IntegrateForge AI integrations used by Quantity Surveyors for multi-discipline measurement"
author: "Construct AI UX Team"
version: "1.0"
memory_layer: durable_knowledge
para_section: docs-paperclip/plans/ui-ux
gigabrain_tags: ui-ux, integrateforge, shared-ui, measurement-interface, qs-interface, cross-discipline
openstinger_context: ui-specification, integration-interface, measurement-workflow
last_updated: 2026-04-20
related_docs:
  - docs-paperclip/companies/integrateforge-ai/COMPANY.md
  - docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-ada-autocad/AGENTS.md
  - docs-paperclip/companies/integrateforge-ai/agents/integrateforge-ai-cash-costx/AGENTS.md
  - docs-paperclip/disciplines/02025-quantity-surveying/projects/PROC-001/QS-DWG-SWARM-ENTERPRISE/workflow-diagram.md
  - docs-paperclip/plans/system design/2026-04-20-opencv-measurement-architecture.md
---

# IntegrateForge Shared UI/UX Specification

## Executive Summary

This document defines the shared user interface and user experience specification for all **IntegrateForge AI** integrations used by Quantity Surveyors for multi-discipline measurement. The shared UI provides a unified, discipline-agnostic interface that works seamlessly across AutoCAD, Civil 3D, Revit, CostX, P6, and all other IntegrateForge integrations.

**Key Design Principles:**
- **Unified Experience**: Single interface for all integrations
- **Discipline-Aware**: Adapts to QS, Civil, MEP, Structural contexts
- **Measurement-Focused**: Optimized for quantity surveying workflows
- **Cross-Discipline**: Shared components with discipline-specific views

---

## 1. Design System Foundation

### 1.1 Design Tokens

```typescript
// Color Palette
const colors = {
  // Primary - IntegrateForge Brand
  primary: {
    main: '#6366F1',      // Indigo - main brand color
    light: '#818CF8',     // Lighter indigo
    dark: '#4F46E5',      // Darker indigo
    contrast: '#FFFFFF'
  },
  
  // Secondary - Discipline Colors
  discipline: {
    qs: '#10B981',        // Emerald - Quantity Surveying
    civil: '#F59E0B',     // Amber - Civil Engineering
    structural: '#EF4444', // Red - Structural
    mep: '#3B82F6',       // Blue - MEP
    architectural: '#8B5CF6' // Purple - Architectural
  },
  
  // Semantic Colors
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  info: '#3B82F6',
  
  // Neutral Colors
  gray: {
    50: '#F9FAFB',
    100: '#F3F4F6',
    200: '#E5E7EB',
    300: '#D1D5DB',
    400: '#9CA3AF',
    500: '#6B7280',
    600: '#4B5563',
    700: '#374151',
    800: '#1F2937',
    900: '#111827'
  }
};

// Typography
const typography = {
  fontFamily: {
    primary: 'Inter, -apple-system, BlinkMacSystemFont, sans-serif',
    mono: 'JetBrains Mono, Consolas, monospace'
  },
  fontSize: {
    xs: '0.75rem',    // 12px
    sm: '0.875rem',   // 14px
    base: '1rem',     // 16px
    lg: '1.125rem',   // 18px
    xl: '1.25rem',    // 20px
    '2xl': '1.5rem',  // 24px
    '3xl': '1.875rem', // 30px
    '4xl': '2.25rem'  // 36px
  },
  fontWeight: {
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700
  }
};

// Spacing
const spacing = {
  xs: '0.25rem',   // 4px
  sm: '0.5rem',    // 8px
  md: '1rem',      // 16px
  lg: '1.5rem',    // 24px
  xl: '2rem',      // 32px
  '2xl': '3rem',   // 48px
  '3xl': '4rem'    // 64px
};

// Border Radius
const borderRadius = {
  sm: '0.25rem',   // 4px
  md: '0.5rem',    // 8px
  lg: '0.75rem',   // 12px
  xl: '1rem',      // 16px
  full: '9999px'
};

// Shadows
const shadows = {
  sm: '0 1px 2px 0 rgb(0 0 0 / 0.05)',
  md: '0 4px 6px -1px rgb(0 0 0 / 0.1)',
  lg: '0 10px 15px -3px rgb(0 0 0 / 0.1)',
  xl: '0 20px 25px -5px rgb(0 0 0 / 0.1)'
};
```

### 1.2 Component Library Structure

```
ui/src/components/integrateforge/
├── common/                    # Shared across all integrations
│   ├── IntegrationCard.tsx     # Card for each integration
│   ├── StatusBadge.tsx        # Connection status indicator
│   ├── ConnectionWizard.tsx    # OAuth/API connection flow
│   ├── SyncStatus.tsx          # Last sync timestamp
│   └── ErrorBoundary.tsx       # Error handling wrapper
│
├── measurement/                # Measurement-specific components
│   ├── MeasurementGrid.tsx     # Spreadsheet-like data grid
│   ├── ElementClassifier.tsx   # Element type selector
│   ├── CalibrationPanel.tsx     # Scale/offset calibration
│   ├── AccuracyMeter.tsx        # 100% accuracy indicator
│   └── StandardsValidator.tsx   # QS standards compliance
│
├── file-handler/              # File upload/management
│   ├── FileUploader.tsx        # Drag-drop file upload
│   ├── FileList.tsx           # Uploaded files list
│   ├── FilePreview.tsx         # Thumbnail/preview
│   └── FileMetadata.tsx        # File info display
│
├── results/                    # Results display
│   ├── ResultsTable.tsx       # Tabular results view
│   ├── ResultsChart.tsx        # Visual charts
│   ├── ResultsExport.tsx       # Export controls
│   └── ResultsCompare.tsx      # Compare versions
│
└── layout/                     # Layout components
    ├── IntegrationSidebar.tsx   # Left navigation
    ├── IntegrationHeader.tsx    # Top header with tools
    ├── IntegrationDashboard.tsx  # Main dashboard
    └── IntegrationSettings.tsx   # Settings panel
```

---

## 2. Page Structure

### 2.1 Main Dashboard Layout

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  HEADER                                                                      │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ Logo │ IntegrateForge │ [Discipline Selector ▼] │ 🔔 │ 👤 │ ⚙️     │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
├─────────────────────────────────────────────────────────────────────────────┤
│ ┌──────────────┐ ┌──────────────────────────────────────────────────────┐   │
│ │             │ │                                                       │   │
│ │  SIDEBAR    │ │                    MAIN CONTENT                       │   │
│ │             │ │                                                       │   │
│ │ Integrations│ │  ┌─────────────────────────────────────────────┐    │   │
│ │ ─────────── │ │  │                                             │    │   │
│ │ □ AutoCAD   │ │  │           CONTENT AREA                      │    │   │
│ │ □ Civil 3D  │ │  │                                             │    │   │
│ │ □ Revit     │ │  │   (Dashboard / Measurement / Results /      │    │   │
│ │ □ CostX     │ │  │    Settings depending on selection)         │    │   │
│ │ □ P6        │ │  │                                             │    │   │
│ │ □ Navisworks│ │  │                                             │    │   │
│ │ □ BIM 360   │ │  └─────────────────────────────────────────────┘    │   │
│ │ □ Aconex    │ │                                                       │   │
│ │ □ Procore   │ │  ┌─────────────────────────────────────────────┐    │   │
│ │ □ SharePoint│ │  │              ACTION BAR                      │    │   │
│ │             │ │  │  [Upload] [Process] [Export] [Settings]    │    │   │
│ │ ─────────── │ │  └─────────────────────────────────────────────┘    │   │
│ │ Measurement │ │                                                       │   │
│ │ ─────────── │ │                                                       │   │
│ │ □ OpenCV    │ │                                                       │   │
│ │             │ │                                                       │   │
│ └──────────────┘ └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Page Routes

```typescript
// Route Structure
const routes = {
  // Main Integration Hub
  '/integrations': 'IntegrationDashboard',
  '/integrations/:toolId': 'IntegrationDetail',
  '/integrations/:toolId/connect': 'ConnectionWizard',
  
  // Measurement Workflow
  '/measure': 'MeasurementDashboard',
  '/measure/upload': 'FileUpload',
  '/measure/process': 'ProcessingView',
  '/measure/results': 'ResultsView',
  '/measure/calibrate': 'Calibration',
  
  // Discipline-Specific Views
  '/qs': 'QSDashboard',
  '/qs/measurements': 'QSMeasurements',
  '/qs/standards': 'QSStandards',
  
  '/civil': 'CivilDashboard',
  '/civil/roadway': 'RoadwayMeasurements',
  '/civil/stormwater': 'StormwaterMeasurements',
  '/civil/earthworks': 'EarthworksMeasurements',
  
  '/mep': 'MEPDashboard',
  '/mep/electrical': 'ElectricalMeasurements',
  '/mep/mechanical': 'MechanicalMeasurements',
  '/mep/plumbing': 'PlumbingMeasurements',
  
  // Settings & Admin
  '/settings': 'Settings',
  '/settings/connections': 'ConnectionManagement',
  '/settings/standards': 'StandardsConfiguration',
  '/settings/billing': 'BillingUsage'
};
```

---

## 3. Core Components

### 3.1 IntegrationCard

```tsx
// Component: IntegrationCard.tsx
interface IntegrationCardProps {
  tool: IntegrationTool;
  status: 'connected' | 'disconnected' | 'syncing' | 'error';
  lastSync?: Date;
  measurementCount?: number;
  onConnect: () => void;
  onDisconnect: () => void;
  onOpen: () => void;
}

export const IntegrationCard: React.FC<IntegrationCardProps> = ({
  tool,
  status,
  lastSync,
  measurementCount,
  onConnect,
  onDisconnect,
  onOpen
}) => {
  const statusColors = {
    connected: 'bg-green-100 text-green-800',
    disconnected: 'bg-gray-100 text-gray-600',
    syncing: 'bg-blue-100 text-blue-800',
    error: 'bg-red-100 text-red-800'
  };

  return (
    <div className="bg-white rounded-xl shadow-md hover:shadow-lg transition-shadow">
      <div className="p-4">
        {/* Tool Icon & Name */}
        <div className="flex items-center gap-3 mb-3">
          <div className={`w-12 h-12 rounded-lg flex items-center justify-center
            ${tool.disciplineColor}`}>
            <ToolIcon name={tool.icon} className="w-6 h-6 text-white" />
          </div>
          <div>
            <h3 className="font-semibold text-gray-900">{tool.name}</h3>
            <p className="text-sm text-gray-500">{tool.vendor}</p>
          </div>
        </div>

        {/* Status Badge */}
        <div className="flex items-center justify-between mb-3">
          <span className={`px-2 py-1 rounded-full text-xs font-medium
            ${statusColors[status]}`}>
            {status === 'connected' && '✓ Connected'}
            {status === 'disconnected' && '○ Not Connected'}
            {status === 'syncing' && '↻ Syncing'}
            {status === 'error' && '⚠ Error'}
          </span>
          {lastSync && (
            <span className="text-xs text-gray-400">
              Last sync: {formatRelativeTime(lastSync)}
            </span>
          )}
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-2 gap-2 mb-4">
          <div className="bg-gray-50 rounded-lg p-2">
            <p className="text-xs text-gray-500">Measurements</p>
            <p className="text-lg font-semibold">{measurementCount ?? 0}</p>
          </div>
          <div className="bg-gray-50 rounded-lg p-2">
            <p className="text-xs text-gray-500">Status</p>
            <p className="text-sm font-medium text-green-600">Active</p>
          </div>
        </div>

        {/* Actions */}
        <div className="flex gap-2">
          {status === 'connected' ? (
            <>
              <button
                onClick={onOpen}
                className="flex-1 px-3 py-2 bg-indigo-600 text-white rounded-lg
                  hover:bg-indigo-700 transition-colors text-sm font-medium">
                Open
              </button>
              <button
                onClick={onDisconnect}
                className="px-3 py-2 text-gray-600 hover:bg-gray-100 rounded-lg">
                <DisconnectIcon className="w-5 h-5" />
              </button>
            </>
          ) : (
            <button
              onClick={onConnect}
              className="w-full px-3 py-2 border-2 border-indigo-600 text-indigo-600
                rounded-lg hover:bg-indigo-50 transition-colors text-sm font-medium">
              Connect
            </button>
          )}
        </div>
      </div>
    </div>
  );
};
```

### 3.2 MeasurementGrid (Spreadsheet-like Interface)

```tsx
// Component: MeasurementGrid.tsx
interface MeasurementGridProps {
  data: MeasurementRow[];
  columns: GridColumn[];
  onEdit: (rowId: string, column: string, value: any) => void;
  onValidate: (rowId: string) => ValidationResult;
  onExport: (format: 'csv' | 'excel' | 'json') => void;
}

export const MeasurementGrid: React.FC<MeasurementGridProps> = ({
  data,
  columns,
  onEdit,
  onValidate,
  onExport
}) => {
  const [selectedRows, setSelectedRows] = useState<string[]>([]);
  const [sortColumn, setSortColumn] = useState<string | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('asc');
  const [filters, setFilters] = useState<Record<string, string>>({});

  // Column definitions with formatting
  const columnDefs: GridColumn[] = [
    {
      field: 'elementCode',
      headerName: 'Code',
      width: 100,
      editable: false,
      filter: 'agTextColumnFilter'
    },
    {
      field: 'elementName',
      headerName: 'Element',
      width: 200,
      editable: true,
      cellClass: 'font-medium'
    },
    {
      field: 'discipline',
      headerName: 'Discipline',
      width: 120,
      editable: false,
      cellRenderer: 'DisciplineBadge'
    },
    {
      field: 'quantity',
      headerName: 'Quantity',
      width: 120,
      editable: true,
      type: 'numeric',
      cellClass: 'text-right font-mono'
    },
    {
      field: 'unit',
      headerName: 'Unit',
      width: 80,
      editable: true,
      cellEditor: 'agSelectCellEditor',
      cellEditorParams: { values: ['m', 'm²', 'm³', 'kg', 'nr', 'sum'] }
    },
    {
      field: 'standard',
      headerName: 'Standard',
      width: 100,
      editable: false,
      cellRenderer: 'StandardBadge'
    },
    {
      field: 'accuracy',
      headerName: 'Accuracy',
      width: 100,
      editable: false,
      cellRenderer: 'AccuracyMeter'
    },
    {
      field: 'actions',
      headerName: '',
      width: 80,
      cellRenderer: 'ActionButtons',
      pinned: 'right'
    }
  ];

  return (
    <div className="measurement-grid-container">
      {/* Toolbar */}
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <input
            type="text"
            placeholder="Search elements..."
            className="px-3 py-2 border rounded-lg w-64"
          />
          <select className="px-3 py-2 border rounded-lg">
            <option value="">All Disciplines</option>
            <option value="qs">Quantity Surveying</option>
            <option value="civil">Civil Engineering</option>
            <option value="mep">MEP</option>
            <option value="structural">Structural</option>
          </select>
          <select className="px-3 py-2 border rounded-lg">
            <option value="">All Standards</option>
            <option value="sans1200">SANS 1200</option>
            <option value="cesmm4">CESMM4</option>
            <option value="nrm">NRM</option>
          </select>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => onExport('csv')}
            className="px-3 py-2 text-gray-700 bg-white border rounded-lg hover:bg-gray-50">
            Export CSV
          </button>
          <button
            onClick={() => onExport('excel')}
            className="px-3 py-2 text-gray-700 bg-white border rounded-lg hover:bg-gray-50">
            Export Excel
          </button>
        </div>
      </div>

      {/* Grid */}
      <div className="ag-theme-alpine h-[500px] border rounded-lg">
        <AgGridReact
          rowData={data}
          columnDefs={columnDefs}
          defaultColDef={{
            sortable: true,
            filter: true,
            resizable: true
          }}
          rowSelection="multiple"
          onSelectionChanged={(e) => setSelectedRows(e.api.getSelectedRows())}
          animateRows={true}
          suppressRowClickSelection={true}
        />
      </div>

      {/* Summary Footer */}
      <div className="mt-4 p-4 bg-gray-50 rounded-lg">
        <div className="grid grid-cols-4 gap-4 text-sm">
          <div>
            <p className="text-gray-500">Total Elements</p>
            <p className="text-xl font-semibold">{data.length}</p>
          </div>
          <div>
            <p className="text-gray-500">Selected</p>
            <p className="text-xl font-semibold">{selectedRows.length}</p>
          </div>
          <div>
            <p className="text-gray-500">Avg Accuracy</p>
            <p className="text-xl font-semibold text-green-600">
              {calculateAverageAccuracy(data)}%
            </p>
          </div>
          <div>
            <p className="text-gray-500">Standards Compliant</p>
            <p className="text-xl font-semibold text-green-600">
              {calculateComplianceRate(data)}%
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};
```

### 3.3 AccuracyMeter Component

```tsx
// Component: AccuracyMeter.tsx
interface AccuracyMeterProps {
  accuracy: number; // 0-100
  showLabel?: boolean;
  size?: 'sm' | 'md' | 'lg';
}

export const AccuracyMeter: React.FC<AccuracyMeterProps> = ({
  accuracy,
  showLabel = true,
  size = 'md'
}) => {
  const sizeClasses = {
    sm: 'h-4',
    md: 'h-6',
    lg: 'h-8'
  };

  const getColor = (acc: number) => {
    if (acc === 100) return 'bg-green-500';
    if (acc >= 95) return 'bg-yellow-500';
    return 'bg-red-500';
  };

  return (
    <div className="flex items-center gap-2">
      <div className={`flex-1 bg-gray-200 rounded-full overflow-hidden ${sizeClasses[size]}`}>
        <div
          className={`h-full ${getColor(accuracy)} transition-all duration-300`}
          style={{ width: `${accuracy}%` }}
        />
      </div>
      {showLabel && (
        <span className={`font-mono font-medium ${
          accuracy === 100 ? 'text-green-600' : 
          accuracy >= 95 ? 'text-yellow-600' : 'text-red-600'
        }`}>
          {accuracy.toFixed(1)}%
        </span>
      )}
    </div>
  );
};
```

### 3.4 DisciplineBadge Component

```tsx
// Component: DisciplineBadge.tsx
interface DisciplineBadgeProps {
  discipline: 'qs' | 'civil' | 'mep' | 'structural' | 'architectural';
  size?: 'sm' | 'md';
}

export const DisciplineBadge: React.FC<DisciplineBadgeProps> = ({
  discipline,
  size = 'md'
}) => {
  const disciplineConfig = {
    qs: {
      label: 'QS',
      color: 'bg-emerald-100 text-emerald-800',
      fullName: 'Quantity Surveying'
    },
    civil: {
      label: 'Civil',
      color: 'bg-amber-100 text-amber-800',
      fullName: 'Civil Engineering'
    },
    mep: {
      label: 'MEP',
      color: 'bg-blue-100 text-blue-800',
      fullName: 'Mechanical/Electrical/Plumbing'
    },
    structural: {
      label: 'Struct',
      color: 'bg-red-100 text-red-800',
      fullName: 'Structural Engineering'
    },
    architectural: {
      label: 'Arch',
      color: 'bg-purple-100 text-purple-800',
      fullName: 'Architectural'
    }
  };

  const config = disciplineConfig[discipline];
  const sizeClasses = size === 'sm' ? 'px-1.5 py-0.5 text-xs' : 'px-2 py-1 text-sm';

  return (
    <span
      className={`inline-flex items-center rounded-full font-medium ${config.color} ${sizeClasses}`}
      title={config.fullName}
    >
      {config.label}
    </span>
  );
};
```

---

## 4. Integration Connection Flow

### 4.1 OAuth Connection Wizard

```tsx
// Component: ConnectionWizard.tsx
interface ConnectionWizardProps {
  tool: IntegrationTool;
  onComplete: (credentials: ConnectionCredentials) => void;
  onCancel: () => void;
}

export const ConnectionWizard: React.FC<ConnectionWizardProps> = ({
  tool,
  onComplete,
  onCancel
}) => {
  const [step, setStep] = useState(1);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const steps = [
    { id: 1, title: 'Select Account', description: 'Choose or add your account' },
    { id: 2, title: 'Authorize Access', description: 'Grant permissions to IntegrateForge' },
    { id: 3, title: 'Configure', description: 'Set up sync preferences' },
    { id: 4, title: 'Complete', description: 'Connection established' }
  ];

  const handleOAuth = async () => {
    setLoading(true);
    setError(null);
    
    try {
      // Open OAuth popup
      const popup = window.open(
        `${tool.oauthUrl}?client_id=${tool.clientId}&redirect_uri=${callbackUrl}`,
        'oauth-popup',
        'width=600,height=700'
      );

      // Wait for callback
      const result = await waitForOAuthCallback(popup);
      
      if (result.success) {
        onComplete(result.credentials);
      } else {
        setError(result.error);
      }
    } catch (err) {
      setError('Failed to complete authentication');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-lg mx-auto">
      {/* Progress Steps */}
      <div className="flex items-center justify-between mb-8">
        {steps.map((s, i) => (
          <div key={s.id} className="flex items-center">
            <div className={`w-8 h-8 rounded-full flex items-center justify-center
              ${step >= s.id ? 'bg-indigo-600 text-white' : 'bg-gray-200 text-gray-500'}`}>
              {step > s.id ? '✓' : s.id}
            </div>
            {i < steps.length - 1 && (
              <div className={`w-16 h-0.5 mx-2 ${
                step > s.id ? 'bg-indigo-600' : 'bg-gray-200'
              }`} />
            )}
          </div>
        ))}
      </div>

      {/* Step Content */}
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h2 className="text-xl font-semibold mb-2">{steps[step - 1].title}</h2>
        <p className="text-gray-600 mb-6">{steps[step - 1].description}</p>

        {step === 1 && (
          <div className="space-y-3">
            <button className="w-full p-4 border-2 rounded-lg hover:border-indigo-600
              flex items-center gap-3">
              <ToolIcon name={tool.icon} className="w-8 h-8" />
              <div className="text-left">
                <p className="font-medium">Use existing account</p>
                <p className="text-sm text-gray-500">Connected as user@company.com</p>
              </div>
            </button>
            <button className="w-full p-4 border-2 rounded-lg hover:border-indigo-600
              flex items-center gap-3">
              <PlusIcon className="w-8 h-8 text-gray-400" />
              <div className="text-left">
                <p className="font-medium">Add new account</p>
                <p className="text-sm text-gray-500">Connect a different account</p>
              </div>
            </button>
          </div>
        )}

        {step === 2 && (
          <div className="text-center">
            <button
              onClick={handleOAuth}
              disabled={loading}
              className="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700
                disabled:opacity-50 flex items-center gap-2 mx-auto"
            >
              {loading ? (
                <Spinner className="w-5 h-5" />
              ) : (
                <ExternalLinkIcon className="w-5 h-5" />
              )}
              Authorize with {tool.vendor}
            </button>
            {error && (
              <p className="mt-4 text-red-600 text-sm">{error}</p>
            )}
          </div>
        )}

        {step === 3 && (
          <div className="space-y-4">
            <label className="flex items-center gap-3">
              <input type="checkbox" defaultChecked className="w-5 h-5" />
              <span>Enable automatic sync every 15 minutes</span>
            </label>
            <label className="flex items-center gap-3">
              <input type="checkbox" defaultChecked className="w-5 h-5" />
              <span>Sync measurement data</span>
            </label>
            <label className="flex items-center gap-3">
              <input type="checkbox" className="w-5 h-5" />
              <span>Sync project metadata</span>
            </label>
          </div>
        )}

        {step === 4 && (
          <div className="text-center">
            <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <CheckIcon className="w-8 h-8 text-green-600" />
            </div>
            <h3 className="text-lg font-medium text-green-600">Connected!</h3>
            <p className="text-gray-600 mt-2">
              {tool.name} is now connected to IntegrateForge
            </p>
          </div>
        )}
      </div>

      {/* Navigation */}
      <div className="flex justify-between mt-6">
        <button
          onClick={() => setStep(s => s - 1)}
          disabled={step === 1}
          className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg disabled:opacity-50">
          Back
        </button>
        <button
          onClick={() => step < 4 ? setStep(s => s + 1) : onCancel()}
          className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
          {step < 4 ? 'Continue' : 'Done'}
        </button>
      </div>
    </div>
  );
};
```

---

## 5. Measurement Workflow Screens

### 5.1 File Upload Screen

```tsx
// Screen: FileUpload.tsx
export const FileUploadScreen: React.FC = () => {
  const [dragActive, setDragActive] = useState(false);
  const [files, setFiles] = useState<File[]>([]);
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);

  const supportedFormats = ['.dwg', '.dxf', '.pdf', '.png', '.jpg', '.tif'];
  const maxFileSize = 100 * 1024 * 1024; // 100MB

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragActive(false);
    
    const droppedFiles = Array.from(e.dataTransfer.files);
    const validFiles = droppedFiles.filter(f => {
      const ext = '.' + f.name.split('.').pop()?.toLowerCase();
      return supportedFormats.includes(ext) && f.size <= maxFileSize;
    });
    
    setFiles(prev => [...prev, ...validFiles]);
  };

  const handleUpload = async () => {
    setUploading(true);
    
    for (const file of files) {
      const formData = new FormData();
      formData.append('file', file);
      
      await uploadWithProgress(formData, (progress) => {
        setUploadProgress(progress);
      });
    }
    
    setUploading(false);
    navigate('/measure/process');
  };

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">Upload Drawing Files</h1>
      
      {/* Drop Zone */}
      <div
        onDragEnter={() => setDragActive(true)}
        onDragLeave={() => setDragActive(false)}
        onDragOver={(e) => e.preventDefault()}
        onDrop={handleDrop}
        className={`border-2 border-dashed rounded-xl p-12 text-center transition-colors
          ${dragActive ? 'border-indigo-600 bg-indigo-50' : 'border-gray-300'}`}
      >
        <UploadIcon className="w-16 h-16 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium mb-2">
          Drag and drop your files here
        </h3>
        <p className="text-gray-500 mb-4">
          or click to browse from your computer
        </p>
        <p className="text-sm text-gray-400 mb-6">
          Supported formats: {supportedFormats.join(', ')} • Max 100MB
        </p>
        <input
          type="file"
          multiple
          accept={supportedFormats.join(',')}
          onChange={(e) => setFiles(Array.from(e.target.files || []))}
          className="hidden"
          id="file-upload"
        />
        <label
          htmlFor="file-upload"
          className="px-6 py-3 bg-indigo-600 text-white rounded-lg cursor-pointer
            hover:bg-indigo-700 inline-block"
        >
          Browse Files
        </label>
      </div>

      {/* File List */}
      {files.length > 0 && (
        <div className="mt-6">
          <h3 className="font-medium mb-3">Selected Files ({files.length})</h3>
          <div className="space-y-2">
            {files.map((file, i) => (
              <div key={i} className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div className="flex items-center gap-3">
                  <FileIcon className="w-5 h-5 text-gray-400" />
                  <div>
                    <p className="font-medium">{file.name}</p>
                    <p className="text-sm text-gray-500">
                      {(file.size / 1024 / 1024).toFixed(2)} MB
                    </p>
                  </div>
                </div>
                <button
                  onClick={() => setFiles(f => f.filter((_, j) => j !== i))}
                  className="text-gray-400 hover:text-red-500"
                >
                  <XIcon className="w-5 h-5" />
                </button>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Upload Button */}
      {files.length > 0 && (
        <div className="mt-6 flex justify-end">
          <button
            onClick={handleUpload}
            disabled={uploading}
            className="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700
              disabled:opacity-50 flex items-center gap-2"
          >
            {uploading ? (
              <>
                <Spinner className="w-5 h-5" />
                Uploading... {uploadProgress}%
              </>
            ) : (
              <>
                <UploadIcon className="w-5 h-5" />
                Upload & Process
              </>
            )}
          </button>
        </div>
      )}
    </div>
  );
};
```

### 5.2 Processing View with Real-time Updates

```tsx
// Screen: ProcessingView.tsx
export const ProcessingView: React.FC = () => {
  const [processingState, setProcessingState] = useState<ProcessingState>({
    status: 'processing',
    progress: 45,
    currentStep: 'Classifying elements',
    activeAgents: 156,
    totalAgents: 2000,
    estimatedTime: '2 min remaining'
  });

  // WebSocket connection for real-time updates
  useEffect(() => {
    const ws = new WebSocket(`${WS_URL}/processing/${projectId}`);
    
    ws.onmessage = (event) => {
      const data = JSON.parse(event.data);
      setProcessingState(data);
    };

    return () => ws.close();
  }, [projectId]);

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-2xl font-bold mb-6">Processing Drawing Files</h1>
      
      {/* Progress Card */}
      <div className="bg-white rounded-xl shadow-lg p-6 mb-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-medium">Swarm Processing</h2>
          <span className="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm">
            {processingState.status}
          </span>
        </div>

        {/* Progress Bar */}
        <div className="mb-4">
          <div className="h-3 bg-gray-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-indigo-600 transition-all duration-500"
              style={{ width: `${processingState.progress}%` }}
            />
          </div>
          <div className="flex justify-between mt-2 text-sm text-gray-500">
            <span>{processingState.progress}% complete</span>
            <span>{processingState.estimatedTime}</span>
          </div>
        </div>

        {/* Current Step */}
        <div className="flex items-center gap-3 mb-6">
          <div className="w-8 h-8 bg-indigo-100 rounded-full flex items-center justify-center">
            <Spinner className="w-5 h-5 text-indigo-600" />
          </div>
          <div>
            <p className="font-medium">{processingState.currentStep}</p>
            <p className="text-sm text-gray-500">
              {processingState.activeAgents.toLocaleString()} agents active
            </p>
          </div>
        </div>

        {/* Agent Status Grid */}
        <div className="grid grid-cols-5 gap-2 mb-6">
          {['Foundation', 'Structural', 'Architectural', 'MEP', 'Finishes'].map((category) => (
            <div key={category} className="bg-gray-50 rounded-lg p-3 text-center">
              <p className="text-xs text-gray-500">{category}</p>
              <p className="text-lg font-semibold">
                {Math.floor(Math.random() * 100) + 50}
              </p>
              <p className="text-xs text-green-600">active</p>
            </div>
          ))}
        </div>

        {/* Recent Activity */}
        <div className="border-t pt-4">
          <h3 className="text-sm font-medium mb-3">Recent Activity</h3>
          <div className="space-y-2 max-h-40 overflow-y-auto">
            {[
              { time: 'Just now', action: 'Foundation agents completed strip footing measurement' },
              { time: '2 sec ago', action: 'Structural agents started column measurement' },
              { time: '5 sec ago', action: 'Architectural agents detected 45 door elements' },
              { time: '10 sec ago', action: 'MEP agents initiated electrical conduit analysis' },
            ].map((item, i) => (
              <div key={i} className="flex items-center gap-3 text-sm">
                <span className="text-gray-400 w-16">{item.time}</span>
                <span className="text-gray-700">{item.action}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* File Status */}
      <div className="bg-white rounded-xl shadow-lg p-6">
        <h3 className="font-medium mb-4">Files Being Processed</h3>
        <div className="space-y-3">
          {[
            { name: 'Floor_Plan_Level1.dwg', status: 'processing', progress: 67 },
            { name: 'Section_AA.dwg', status: 'queued', progress: 0 },
            { name: 'Electrical_Layout.dwg', status: 'queued', progress: 0 },
          ].map((file, i) => (
            <div key={i} className="flex items-center gap-4">
              <FileIcon className="w-8 h-8 text-gray-400" />
              <div className="flex-1">
                <p className="font-medium">{file.name}</p>
                <div className="h-1.5 bg-gray-200 rounded-full mt-1">
                  <div
                    className="h-full bg-indigo-600 rounded-full"
                    style={{ width: `${file.progress}%` }}
                  />
                </div>
              </div>
              <span className={`px-2 py-1 rounded-full text-xs ${
                file.status === 'processing' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-600'
              }`}>
                {file.status}
              </span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};
```

---

## 6. Discipline-Specific Views

### 6.1 QS Dashboard

```tsx
// Screen: QSDashboard.tsx
export const QSDashboard: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* QS Summary Cards */}
      <div className="grid grid-cols-4 gap-4">
        <SummaryCard
          title="Total Measurements"
          value="12,456"
          change="+12%"
          icon={RulerIcon}
          color="emerald"
        />
        <SummaryCard
          title="This Week"
          value="1,234"
          change="+8%"
          icon={CalendarIcon}
          color="blue"
        />
        <SummaryCard
          title="Accuracy Rate"
          value="99.8%"
          change="+0.2%"
          icon={TargetIcon}
          color="green"
        />
        <SummaryCard
          title="Standards Compliant"
          value="100%"
          change="0%"
          icon={CheckIcon}
          color="purple"
        />
      </div>

      {/* Recent Measurements */}
      <div className="bg-white rounded-xl shadow-lg p-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-medium">Recent Measurements</h2>
          <button className="text-indigo-600 hover:text-indigo-700 text-sm font-medium">
            View All →
          </button>
        </div>
        <MeasurementGrid
          data={recentMeasurements}
          columns={qsColumnDefs}
          onEdit={handleEdit}
          onValidate={validateMeasurement}
          onExport={handleExport}
        />
      </div>

      {/* Standards Breakdown */}
      <div className="grid grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-lg p-6">
          <h3 className="font-medium mb-4">Measurements by Standard</h3>
          <div className="space-y-3">
            {[
              { standard: 'SANS 1200', count: 4521, percentage: 36 },
              { standard: 'CESMM4', count: 3892, percentage: 31 },
              { standard: 'NRM', count: 2845, percentage: 23 },
              { standard: 'FIDIC', count: 1198, percentage: 10 },
            ].map((item) => (
              <div key={item.standard}>
                <div className="flex justify-between mb-1">
                  <span className="text-sm">{item.standard}</span>
                  <span className="text-sm font-medium">{item.count}</span>
                </div>
                <div className="h-2 bg-gray-200 rounded-full">
                  <div
                    className="h-full bg-indigo-600 rounded-full"
                    style={{ width: `${item.percentage}%` }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-lg p-6">
          <h3 className="font-medium mb-4">Element Categories</h3>
          <div className="space-y-3">
            {[
              { category: 'Foundation', count: 1234 },
              { category: 'Structural', count: 2156 },
              { category: 'Architectural', count: 3421 },
              { category: 'MEP', count: 2890 },
              { category: 'Finishes', count: 2755 },
            ].map((item) => (
              <div key={item.category} className="flex items-center justify-between">
                <span className="text-sm">{item.category}</span>
                <span className="px-2 py-1 bg-gray-100 rounded text-sm font-medium">
                  {item.count}
                </span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};
```

### 6.2 Civil Engineering Dashboard

```tsx
// Screen: CivilDashboard.tsx
export const CivilDashboard: React.FC = () => {
  return (
    <div className="space-y-6">
      {/* Civil-Specific Summary */}
      <div className="grid grid-cols-4 gap-4">
        <SummaryCard
          title="Road Length"
          value="45.2 km"
          change="+5%"
          icon={RoadIcon}
          color="amber"
        />
        <SummaryCard
          title="Stormwater Pipes"
          value="12,450 m"
          change="+3%"
          icon={PipeIcon}
          color="blue"
        />
        <SummaryCard
          title="Earthworks Volume"
          value="125,000 m³"
          change="+15%"
          icon={VolumeIcon}
          color="orange"
        />
        <SummaryCard
          title="Culvert Count"
          value="89"
          change="0%"
          icon={CulvertIcon}
          color="gray"
        />
      </div>

      {/* Discipline-Specific Measurement Grid */}
      <div className="bg-white rounded-xl shadow-lg p-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-medium">Civil Engineering Measurements</h2>
          <div className="flex gap-2">
            <button className="px-3 py-1.5 bg-amber-100 text-amber-800 rounded-lg text-sm">
              Roadway
            </button>
            <button className="px-3 py-1.5 bg-gray-100 text-gray-600 rounded-lg text-sm hover:bg-gray-200">
              Stormwater
            </button>
            <button className="px-3 py-1.5 bg-gray-100 text-gray-600 rounded-lg text-sm hover:bg-gray-200">
              Earthworks
            </button>
          </div>
        </div>
        <MeasurementGrid
          data={civilMeasurements}
          columns={civilColumnDefs}
          onEdit={handleEdit}
          onValidate={validateMeasurement}
          onExport={handleExport}
        />
      </div>
    </div>
  );
};
```

---

## 7. Responsive Design

### 7.1 Breakpoints

```typescript
const breakpoints = {
  sm: '640px',   // Mobile landscape
  md: '768px',   // Tablet portrait
  lg: '1024px',  // Tablet landscape / Small desktop
  xl: '1280px',  // Desktop
  '2xl': '1536px' // Large desktop
};
```

### 7.2 Responsive Layouts

```tsx
// Mobile Layout
const MobileLayout = () => (
  <div className="min-h-screen bg-gray-50">
    {/* Bottom Navigation */}
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t px-4 py-2 flex justify-around">
      <NavItem icon={HomeIcon} label="Home" />
      <NavItem icon={RulerIcon} label="Measure" />
      <NavItem icon={FileIcon} label="Files" />
      <NavItem icon={SettingsIcon} label="Settings" />
    </nav>
    
    {/* Main Content */}
    <main className="pb-20 px-4">
      {/* Mobile-optimized content */}
    </main>
  </div>
);

// Tablet Layout
const TabletLayout = () => (
  <div className="min-h-screen bg-gray-50 flex">
    {/* Collapsible Sidebar */}
    <aside className="w-64 bg-white border-r hidden md:block">
      {/* Sidebar content */}
    </aside>
    
    <main className="flex-1 p-4 md:p-6">
      {/* Tablet-optimized content */}
    </main>
  </div>
);

// Desktop Layout
const DesktopLayout = () => (
  <div className="min-h-screen bg-gray-50 flex">
    {/* Fixed Sidebar */}
    <aside className="w-72 bg-white border-r hidden lg:block">
      {/* Full sidebar with all integrations */}
    </aside>
    
    <main className="flex-1 p-6">
      {/* Full dashboard with all features */}
    </main>
  </div>
);
```

---

## 8. Accessibility Requirements

### 8.1 WCAG 2.1 AA Compliance

```typescript
const accessibilityConfig = {
  // Color Contrast
  minimumContrastRatio: 4.5, // Normal text
  enhancedContrastRatio: 7,   // Large text
  
  // Focus Management
  visibleFocusIndicator: true,
  focusTrapInModals: true,
  focusReturnOnClose: true,
  
  // Screen Reader Support
  ariaLabels: true,
  ariaDescriptions: true,
  liveRegions: true, // For dynamic updates
  
  // Keyboard Navigation
  fullKeyboardNavigation: true,
  skipLinks: true,
  logicalTabOrder: true,
  
  // Touch Targets
  minimumTouchTarget: 44, // pixels
};
```

### 8.2 Keyboard Shortcuts

```typescript
const keyboardShortcuts = {
  // Global
  'Ctrl+K': 'Open command palette',
  'Ctrl+/': 'Show keyboard shortcuts',
  'Escape': 'Close modal/dialog',
  
  // Navigation
  'g then h': 'Go to home',
  'g then m': 'Go to measurements',
  'g then s': 'Go to settings',
  
  // Actions
  'Ctrl+U': 'Upload file',
  'Ctrl+E': 'Export results',
  'Ctrl+S': 'Save changes',
  'Ctrl+Z': 'Undo',
  'Ctrl+Shift+Z': 'Redo',
};
```

---

## 9. Performance Requirements

### 9.1 Load Time Targets

| Metric | Target | Maximum |
|--------|--------|---------|
| First Contentful Paint | < 1.5s | 3s |
| Largest Contentful Paint | < 2.5s | 4s |
| Time to Interactive | < 3s | 5s |
| Cumulative Layout Shift | < 0.1 | 0.25 |

### 9.2 Interaction Targets

| Interaction | Target | Maximum |
|------------|--------|---------|
| Button click response | < 50ms | 100ms |
| Grid row selection | < 100ms | 200ms |
| Filter application | < 200ms | 500ms |
| Export generation | < 2s | 5s |

---

## 10. Implementation Phases

### Phase 1: Core UI (Weeks 1-2)
- [ ] Design system tokens and base components
- [ ] Integration card and connection wizard
- [ ] Basic layout with sidebar navigation
- [ ] Responsive design foundation

### Phase 2: Measurement Interface (Weeks 3-4)
- [ ] MeasurementGrid with AG Grid
- [ ] File upload with drag-drop
- [ ] Processing view with WebSocket updates
- [ ] Accuracy meter and discipline badges

### Phase 3: Discipline Views (Weeks 5-6)
- [ ] QS Dashboard with standards breakdown
- [ ] Civil Dashboard with roadway/stormwater/earthworks
- [ ] MEP Dashboard with electrical/mechanical/plumbing
- [ ] Cross-discipline navigation

### Phase 4: Polish & Performance (Weeks 7-8)
- [ ] Accessibility audit and fixes
- [ ] Performance optimization
- [ ] Error handling and edge cases
- [ ] Documentation and training materials

---

**Document Status**: Ready for Implementation
**Version**: 1.0
**Created**: 2026-04-20
**Last Updated**: 2026-04-20

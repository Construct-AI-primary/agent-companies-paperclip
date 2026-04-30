---
title: {DISCIPLINE_NAME} Agent Architectural Knowledge
description: Comprehensive architectural knowledge of {discipline_name} system design, database schemas, API patterns, and compliance frameworks for {AGENT_ROLE} agents
author: KnowledgeForge AI
version: 1.0
memory_layer: durable_knowledge
para_section: docs_paperclip/disciplines/{DISCIPLINE_CODE}-{discipline_slug}
gigabrain_tags: knowledgeforge-ai, {agent_slug}-agent, {discipline_slug}-architecture, system-design, compliance-frameworks
openstinger_context: {discipline_slug}-agent-architecture, {agent_slug}-system-design
last_updated: {CURRENT_DATE}
related_docs:
  - docs-construct-ai/disciplines/{DISCIPLINE_CODE}_{DISCIPLINE_NAME}/agent-data/domain-knowledge/{DISCIPLINE_CODE}_DOMAIN-KNOWLEDGE.MD
  - docs-construct-ai/disciplines/{DISCIPLINE_CODE}_{DISCIPLINE_NAME}/{DISCIPLINE_CODE}-{discipline_slug}-page-documentation.md
  - docs-paperclip/companies/knowledgeforge-ai/skills/{agent_slug}-knowledgeforge/SKILL.md
---

# {AGENT_TITLE} Agent Architectural Knowledge

## Overview

This document provides the {AGENT_TITLE} agent with comprehensive architectural knowledge of the {discipline_name} system design, database schemas, API patterns, security frameworks, and compliance requirements. The {AGENT_TITLE} agent serves as the architectural authority for {discipline_name} module implementation, ensuring adherence to coding standards, EU regulations, privacy requirements, and quality assurance frameworks.

**Purpose**: Enable the {AGENT_TITLE} agent to guide {discipline_name} system architecture, validate design decisions, enforce compliance standards, and provide architectural consultation to development teams within the Construct AI ecosystem.

---

## Part 1: {DISCIPLINE_NAME} Database Architecture

### 1.1 Core Database Schema

**Database**: Supabase (PostgreSQL)
**Schema**: `public`
**Primary Tables**: {number_of_core_tables} core entities
**Authentication**: Supabase Auth with Row Level Security (RLS)

#### {PRIMARY_TABLE_1_NAME} Table Architecture
```sql
-- Supabase table with RLS policies
CREATE TABLE {primary_table_1_id} (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  {col_1_name} {col_1_type} UNIQUE NOT NULL,
  {col_2_name} {col_2_type} NOT NULL,
  {col_3_name} {col_3_type},
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID REFERENCES auth.users(id),
  company_id UUID REFERENCES companies(id)
);

-- Row Level Security policies
ALTER TABLE {primary_table_1_id} ENABLE ROW LEVEL SECURITY;

-- RLS Policies for multi-tenant access
CREATE POLICY "{primary_table_1_id}_company_access" ON {primary_table_1_id}
  FOR ALL USING (company_id IN (
    SELECT company_id FROM user_company_access
    WHERE user_id = auth.uid()
  ));

-- Indexes for performance
CREATE INDEX idx_{primary_table_1_id}_{col_1_name} ON {primary_table_1_id}({col_1_name});
CREATE INDEX idx_{primary_table_1_id}_{col_2_name} ON {primary_table_1_id}({col_2_name});
CREATE INDEX idx_{primary_table_1_id}_company_id ON {primary_table_1_id}(company_id);
```

**Relationships**:
- Foreign Key: `{col_2_name}` → `{related_table_1}`.`{related_pk_1}`
- One-to-Many: Supports {relationship_1_desc}

#### {PRIMARY_TABLE_2_NAME} Table Architecture
```sql
CREATE TABLE {primary_table_2_id} (
  {col_4_name} {col_4_type} PRIMARY KEY,
  {col_5_name} {col_5_type} NOT NULL REFERENCES {primary_table_1_id}({col_1_name}),
  status {status_enum_type} DEFAULT 'draft',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

**Business Logic**:
- Status workflow: draft → submitted → approved → {final_status_1}
- Audit trail: All changes logged to `{audit_table_name}`

### 1.2 Database Optimization Strategies

#### Indexing Strategy
```sql
-- Composite indexes for common queries
CREATE INDEX CONCURRENTLY idx_{primary_table_1_id}_composite
ON {primary_table_1_id}({col_2_name}, status, created_at DESC);

-- Partial indexes for active records
CREATE INDEX idx_{primary_table_1_id}_active
ON {primary_table_1_id}({col_1_name})
WHERE status IN ('active', 'pending');
```

#### Partitioning Strategy
```sql
-- Monthly partitioning for large tables
CREATE TABLE {primary_table_1_id}_y2026m01 PARTITION OF {primary_table_1_id}
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
```

#### Caching Strategy
- Redis cache for frequently accessed {domain_entities}
- Application-level caching with TTL: {cache_ttl_hours} hours
- Cache invalidation: Event-driven cache clearing

---

## Part 2: {DISCIPLINE_NAME} API Architecture

### 2.1 RESTful API Design Patterns

**Base URL**: `/api/{discipline_slug}`
**Authentication**: JWT Bearer tokens with role-based permissions
**Rate Limiting**: {rate_limit_requests} requests per minute per user
**Versioning**: URL-based versioning (`/api/v1/{discipline_slug}`)

#### Core API Endpoints

**{PRIMARY_ENTITY_NAME} Management**:
```typescript
// GET /api/{discipline_slug}/{primary_entity_plural}
// List {primary_entity_plural} with filtering and pagination
{
  "data": [{entity_schema}],
  "pagination": {
    "page": number,
    "limit": number,
    "total": number
  },
  "filters": {
    "status": string[],
    "dateRange": { "start": string, "end": string }
  }
}

// POST /api/{discipline_slug}/{primary_entity_plural}
// Create new {primary_entity_name}
{
  "data": {entity_schema},
  "validation": {
    "passed": boolean,
    "errors": string[]
  }
}

// PUT /api/{discipline_slug}/{primary_entity_plural}/{id}
// Update existing {primary_entity_name}
{
  "data": {entity_schema},
  "audit": {
    "userId": string,
    "timestamp": string,
    "changes": object
  }
}
```

**Error Response Format**:
```typescript
{
  "error": {
    "code": string, // e.g., "VALIDATION_ERROR", "PERMISSION_DENIED"
    "message": string,
    "details": object,
    "traceId": string
  }
}
```

### 2.2 API Security Architecture

#### Authentication Flow
```typescript
// JWT Token Structure
interface JWTPayload {
  userId: string;
  roles: string[];
  permissions: string[];
  iat: number;
  exp: number;
  iss: string;
}

// Role-Based Permissions
const PERMISSIONS = {
  'create_{primary_entity_camel}': ['{agent_slug}_admin', '{agent_slug}_manager'],
  'approve_{primary_entity_camel}': ['{agent_slug}_admin'],
  'view_{primary_entity_camel}': ['{agent_slug}_user', '{agent_slug}_admin', '{agent_slug}_manager']
};
```

#### Input Validation & Sanitization
```typescript
// Zod Schema for {PRIMARY_ENTITY_NAME}
const {primary_entity_camel}Schema = z.object({
  {col_1_name}: z.string().min(1).max(50),
  {col_2_name}: z.string().uuid(),
  status: z.enum(['draft', 'submitted', 'approved', 'rejected']),
  createdAt: z.date(),
  updatedAt: z.date()
});

// SQL Injection Prevention
const sanitizedQuery = sql`
  SELECT * FROM {primary_table_1_id}
  WHERE {col_1_name} = ${userInput}
  AND status = ANY(${statuses})
`;
```

### 2.3 API Performance Optimization

#### Caching Strategy
```typescript
// Redis Cache Configuration
const cacheConfig = {
  ttl: {cache_ttl_seconds} * 1000, // milliseconds
  keyPrefix: '{discipline_slug}:',
  compression: 'gzip'
};

// Cache Keys Pattern
const CACHE_KEYS = {
  {primary_entity_camel}_list: ({filters}) => `{discipline_slug}:{primary_entity_plural}:list:${hash(filters)}`,
  {primary_entity_camel}_detail: (id) => `{discipline_slug}:{primary_entity_camel}:${id}`,
  {primary_entity_camel}_stats: () => `{discipline_slug}:{primary_entity_plural}:stats`
};
```

#### Database Query Optimization
```sql
-- Efficient queries with proper indexing
EXPLAIN ANALYZE
SELECT {col_1_name}, {col_2_name}, status, created_at
FROM {primary_table_1_id}
WHERE status IN ('active', 'pending')
  AND created_at >= $1
ORDER BY created_at DESC
LIMIT $2 OFFSET $3;

-- Query execution plan should show:
-- Index Scan using idx_{primary_table_1_id}_status_created_at
-- No sequential scans on large tables
```

---

## Part 3: {DISCIPLINE_NAME} Security Architecture

### 3.1 Authentication & Authorization Framework

**Authentication Strategy**: JWT-based with refresh token rotation
**Session Management**: Stateless with secure token storage
**Multi-Factor Authentication**: Required for admin operations

#### Role-Based Access Control (RBAC)
```typescript
// Permission Matrix
const RBAC_MATRIX = {
  '{agent_slug}_admin': {
    create: ['{primary_entity_plural}', 'users', 'reports'],
    read: ['all'],
    update: ['all'],
    delete: ['{primary_entity_plural}', 'reports'],
    approve: ['{primary_entity_plural}', 'budgets']
  },
  '{agent_slug}_manager': {
    create: ['{primary_entity_plural}', 'reports'],
    read: ['{primary_entity_plural}', 'reports', 'users'],
    update: ['{primary_entity_plural}', 'reports'],
    delete: [],
    approve: ['{primary_entity_plural}']
  },
  '{agent_slug}_user': {
    create: ['{primary_entity_plural}'],
    read: ['{primary_entity_plural}', 'reports'],
    update: ['own_{primary_entity_plural}'],
    delete: [],
    approve: []
  }
};
```

#### Security Middleware Implementation
```typescript
// Authentication Middleware
export const authenticate = async (req: Request, res: Response, next: NextFunction) => {
  const token = req.headers.authorization?.replace('Bearer ', '');
  if (!token) return res.status(401).json({ error: 'No token provided' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as JWTPayload;
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};

// Authorization Middleware
export const authorize = (permissions: string[]) =>
  async (req: Request, res: Response, next: NextFunction) => {
    const userPermissions = await getUserPermissions(req.user.id);
    const hasPermission = permissions.some(p => userPermissions.includes(p));
    if (!hasPermission) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }
    next();
  };
```

### 3.2 Data Protection & Privacy Architecture

#### GDPR Compliance Framework
```typescript
// Data Processing Register
const DATA_PROCESSING_REGISTER = {
  '{primary_entity_plural}': {
    purpose: '{primary_entity_name} management and processing',
    legalBasis: 'Contract performance',
    dataCategories: ['personal', 'financial', 'operational'],
    retentionPeriod: '7 years',
    dataSubjects: ['employees', 'suppliers', 'customers'],
    securityMeasures: ['encryption', 'access_control', 'audit_logging']
  }
};

// Data Subject Rights Implementation
class GDPRController {
  async rightToAccess(userId: string): Promise<PersonalData> {
    // Implement data export functionality
  }

  async rightToErasure(userId: string): Promise<void> {
    // Implement data deletion with cascade
  }

  async rightToRectification(userId: string, data: PartialData): Promise<void> {
    // Implement data correction with audit trail
  }
}
```

#### Data Encryption Strategy
```typescript
// Database Encryption
const ENCRYPTION_CONFIG = {
  algorithm: 'AES-256-GCM',
  keyRotation: '90 days',
  encryptedFields: ['{sensitive_field_1}', '{sensitive_field_2}'],
  saltRounds: 12
};

// API Data Encryption
const encryptSensitiveData = (data: object): string => {
  const jsonString = JSON.stringify(data);
  return crypto.encrypt(jsonString, process.env.DATA_ENCRYPTION_KEY!);
};
```

### 3.3 Audit Trail & Compliance Logging

#### Comprehensive Audit Architecture
```typescript
// Audit Event Types
enum AuditEventType {
  CREATE_{PRIMARY_ENTITY_CONSTANT} = 'CREATE_{PRIMARY_ENTITY_CONSTANT}',
  UPDATE_{PRIMARY_ENTITY_CONSTANT} = 'UPDATE_{PRIMARY_ENTITY_CONSTANT}',
  DELETE_{PRIMARY_ENTITY_CONSTANT} = 'DELETE_{PRIMARY_ENTITY_CONSTANT}',
  APPROVE_{PRIMARY_ENTITY_CONSTANT} = 'APPROVE_{PRIMARY_ENTITY_CONSTANT}',
  EXPORT_DATA = 'EXPORT_DATA',
  LOGIN = 'LOGIN',
  PERMISSION_CHANGE = 'PERMISSION_CHANGE'
}

// Audit Log Schema
interface AuditLog {
  id: string;
  timestamp: Date;
  userId: string;
  userRole: string;
  eventType: AuditEventType;
  resourceType: string;
  resourceId: string;
  action: string;
  oldValues?: object;
  newValues?: object;
  ipAddress: string;
  userAgent: string;
  success: boolean;
  errorMessage?: string;
}
```

#### SOX Compliance Implementation
```typescript
// Financial Controls Audit
class SOXComplianceAuditor {
  async auditFinancialTransaction(transaction: Transaction): Promise<AuditResult> {
    const controls = await this.checkInternalControls(transaction);
    const segregation = await this.verifySegregationOfDuties(transaction);
    const approval = await this.validateApprovalChain(transaction);

    return {
      compliant: controls.passed && segregation.passed && approval.passed,
      violations: [...controls.violations, ...segregation.violations, ...approval.violations],
      recommendations: this.generateRemediationSteps()
    };
  }
}
```

---

## Part 4: UI Consistency and Interaction Patterns

### 4.1 Standard UI Component Patterns

**Button Standards Across Disciplines**:
```typescript
// Consistent button component interface
interface StandardButtonProps {
  variant: 'primary' | 'secondary' | 'danger' | 'success';
  size: 'small' | 'medium' | 'large';
  disabled?: boolean;
  loading?: boolean;
  onClick: () => void;
  children: React.ReactNode;
}

// Consistent button styling
const BUTTON_STYLES = {
  primary: 'bg-blue-600 hover:bg-blue-700 text-white',
  secondary: 'bg-gray-200 hover:bg-gray-300 text-gray-800',
  danger: 'bg-red-600 hover:bg-red-700 text-white',
  success: 'bg-green-600 hover:bg-green-700 text-white'
};
```

**Table Interaction Standards**:
```typescript
// Consistent table component interface
interface DataTableProps<T> {
  data: T[];
  columns: ColumnDefinition<T>[];
  sortable?: boolean;
  filterable?: boolean;
  selectable?: boolean;
  pagination?: PaginationConfig;
  onRowClick?: (row: T) => void;
  onSelectionChange?: (selectedRows: T[]) => void;
}

// Standard table behaviors
const TABLE_BEHAVIORS = {
  sorting: 'Click column header to sort (ascending → descending → no sort)',
  filtering: 'Use filter dropdowns in column headers',
  selection: 'Checkbox in first column for row selection',
  pagination: '10, 25, 50, 100 items per page options'
};
```

### 4.2 Form Validation and Error Handling

**Consistent Validation Patterns**:
```typescript
// Standard validation error display
const ValidationError: React.FC<{ errors: string[] }> = ({ errors }) => (
  <div className="validation-errors" role="alert" aria-live="polite">
    {errors.map((error, index) => (
      <div key={index} className="error-message">
        <ErrorIcon />
        <span>{error}</span>
      </div>
    ))}
  </div>
);

// Field-level validation styling
const FIELD_STATES = {
  default: 'border-gray-300 focus:border-blue-500',
  error: 'border-red-500 focus:border-red-600',
  success: 'border-green-500 focus:border-green-600',
  disabled: 'border-gray-200 bg-gray-100 cursor-not-allowed'
};
```

**Form Submission Standards**:
```typescript
// Consistent form submission flow
const handleFormSubmit = async (formData: FormData) => {
  setSubmitting(true);
  setErrors([]);

  try {
    // Validate form data
    const validationResult = await validateFormData(formData);

    if (!validationResult.isValid) {
      setErrors(validationResult.errors);
      return;
    }

    // Submit data
    const result = await submitFormData(formData);

    // Show success message
    showSuccessToast('Data saved successfully');

    // Reset form or redirect
    resetForm();

  } catch (error) {
    setErrors([getErrorMessage(error)]);
  } finally {
    setSubmitting(false);
  }
};
```

### 4.3 File Handling and Export Standards

**File Upload Patterns**:
```typescript
// Consistent file upload interface
interface FileUploadProps {
  accept: string[]; // e.g., ['.pdf', '.docx', '.xlsx']
  maxSize: number; // in bytes
  multiple?: boolean;
  onUpload: (files: File[]) => Promise<void>;
  onProgress?: (progress: number) => void;
}

// Drag and drop upload area
const FileUploadArea: React.FC<FileUploadProps> = ({ ... }) => (
  <div
    className="upload-area"
    onDragOver={handleDragOver}
    onDrop={handleDrop}
  >
    <UploadIcon />
    <p>Drag files here or <button>browse</button></p>
    <small>Supported formats: {accept.join(', ')}</small>
  </div>
);
```

**Export Functionality Standards**:
```typescript
// Consistent export options
const EXPORT_OPTIONS = {
  formats: ['CSV', 'Excel', 'PDF', 'JSON'],
  dateRange: true,
  filters: true,
  columns: 'selectable'
};

// Export button with dropdown
const ExportButton: React.FC = () => (
  <DropdownMenu>
    <DropdownMenuTrigger>
      <Button variant="outline">
        <DownloadIcon />
        Export
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent>
      <DropdownMenuItem onClick={() => exportData('csv')}>
        Export as CSV
      </DropdownMenuItem>
      <DropdownMenuItem onClick={() => exportData('excel')}>
        Export as Excel
      </DropdownMenuItem>
      <DropdownMenuItem onClick={() => exportData('pdf')}>
        Export as PDF
      </DropdownMenuItem>
    </DropdownMenuContent>
  </DropdownMenu>
);
```

### 4.4 Dropdown and Select Component Standards

**Consistent Dropdown Behavior**:
```typescript
// Standard select component
interface SelectProps {
  options: SelectOption[];
  value?: string | string[];
  multiple?: boolean;
  searchable?: boolean;
  placeholder?: string;
  onChange: (value: string | string[]) => void;
}

// Searchable dropdown with keyboard navigation
const SearchableSelect: React.FC<SelectProps> = ({ ... }) => {
  const [searchTerm, setSearchTerm] = useState('');
  const [isOpen, setIsOpen] = useState(false);

  // Filter options based on search
  const filteredOptions = options.filter(option =>
    option.label.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // Keyboard navigation support
  const handleKeyDown = (event: KeyboardEvent) => {
    switch (event.key) {
      case 'ArrowDown': // Navigate options
      case 'ArrowUp':
      case 'Enter': // Select option
      case 'Escape': // Close dropdown
        // Implementation
        break;
    }
  };

  return (
    <div className="select-container">
      <input
        type="text"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        onFocus={() => setIsOpen(true)}
        placeholder={placeholder}
      />
      {isOpen && (
        <ul className="options-list" role="listbox">
          {filteredOptions.map(option => (
            <li
              key={option.value}
              role="option"
              onClick={() => handleSelect(option)}
            >
              {option.label}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};
```

### 4.5 Modal and Dialog Standards

**Modal Opening/Closing Patterns**:
```typescript
// Consistent modal management
const useModal = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [modalData, setModalData] = useState(null);

  const openModal = (data?: any) => {
    setModalData(data);
    setIsOpen(true);
  };

  const closeModal = () => {
    setIsOpen(false);
    setModalData(null);
  };

  return { isOpen, modalData, openModal, closeModal };
};

// Modal backdrop and focus management
const Modal: React.FC<ModalProps> = ({ isOpen, onClose, children }) => {
  // Focus trap implementation
  // Backdrop click handling
  // Escape key handling
  // Accessibility attributes

  if (!isOpen) return null;

  return (
    <div className="modal-backdrop" onClick={onClose}>
      <div
        className="modal-content"
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
      >
        {children}
      </div>
    </div>
  );
};
```

### 4.6 Loading States and Feedback

**Consistent Loading Indicators**:
```typescript
// Button loading state
const LoadingButton: React.FC<ButtonProps> = ({ loading, children, ...props }) => (
  <button {...props} disabled={loading || props.disabled}>
    {loading ? (
      <>
        <Spinner size="small" />
        <span>Loading...</span>
      </>
    ) : (
      children
    )}
  </button>
);

// Table loading state
const LoadingTable: React.FC = () => (
  <div className="loading-table">
    <div className="loading-skeleton header"></div>
    {Array.from({ length: 5 }).map((_, index) => (
      <div key={index} className="loading-skeleton row"></div>
    ))}
  </div>
);

// Page-level loading
const PageLoader: React.FC = () => (
  <div className="page-loader">
    <div className="spinner"></div>
    <p>Loading page content...</p>
  </div>
);
```

### 4.7 Navigation and State Management

**Consistent Navigation Patterns**:
```typescript
// Breadcrumb navigation
const Breadcrumbs: React.FC<{ path: NavItem[] }> = ({ path }) => (
  <nav aria-label="Breadcrumb">
    <ol className="breadcrumb-list">
      {path.map((item, index) => (
        <li key={item.id}>
          {index < path.length - 1 ? (
            <Link to={item.href}>{item.label}</Link>
          ) : (
            <span aria-current="page">{item.label}</span>
          )}
        </li>
      ))}
    </ol>
  </nav>
);

// Tab navigation consistency
const TabNavigation: React.FC<{ tabs: TabItem[] }> = ({ tabs, activeTab, onTabChange }) => (
  <div className="tab-navigation" role="tablist">
    {tabs.map(tab => (
      <button
        key={tab.id}
        role="tab"
        aria-selected={activeTab === tab.id}
        onClick={() => onTabChange(tab.id)}
        className={activeTab === tab.id ? 'active' : ''}
      >
        {tab.label}
      </button>
    ))}
  </div>
);
```

---

## Part 5: Implemented Workflow Knowledge

### 5.1 Existing Workflow Documentation

**Current Implemented Workflows**:
- **{PRIMARY_WORKFLOW_1_NAME}**: {workflow_1_implementation_status} - {workflow_1_implementation_notes}
- **{PRIMARY_WORKFLOW_2_NAME}**: {workflow_2_implementation_status} - {workflow_2_implementation_notes}

**Workflow Implementation Details**:
```typescript
// Actual implementation of {PRIMARY_WORKFLOW_1_NAME}
interface {primary_workflow_1_id}Implementation {
  steps: WorkflowStep[];
  validation: ValidationRules;
  errorHandling: ErrorHandler;
  logging: AuditLogger;
}

// Current workflow status and known behaviors
const WORKFLOW_STATUS = {
  '{primary_workflow_1_id}': {
    status: '{workflow_1_status}', // 'active', 'deprecated', 'maintenance'
    version: '{workflow_1_version}',
    lastUpdated: '{workflow_1_last_updated}',
    knownIssues: [{workflow_1_known_issues}],
    performance: {
      avgExecutionTime: '{workflow_1_avg_time}ms',
      successRate: '{workflow_1_success_rate}%',
      errorRate: '{workflow_1_error_rate}%'
    }
  }
};
```

### 5.2 Testing and Debugging Knowledge

**Workflow Test Cases**:
```typescript
// Comprehensive test scenarios for {PRIMARY_WORKFLOW_1_NAME}
const WORKFLOW_TEST_CASES = {
  happyPath: {
    description: 'Complete successful execution',
    input: { /* test data */ },
    expectedOutput: { /* expected results */ },
    assertions: ['status === "completed"', 'all validations pass']
  },
  edgeCases: [
    {
      scenario: 'Invalid input data',
      input: { /* invalid data */ },
      expectedBehavior: 'Validation error with specific message',
      errorCode: 'VALIDATION_ERROR'
    },
    {
      scenario: 'Network timeout during execution',
      input: { /* normal data */ },
      expectedBehavior: 'Graceful retry with exponential backoff',
      maxRetries: 3
    }
  ],
  errorScenarios: [
    {
      scenario: 'Database connection failure',
      expectedBehavior: 'Transaction rollback, error logging',
      recovery: 'Manual intervention required'
    }
  ]
};
```

**Debugging Checkpoints**:
```typescript
// Key debugging points in workflow execution
const DEBUG_CHECKPOINTS = {
  initialization: {
    logs: ['Workflow started', 'Input validation'],
    metrics: ['initialization_time'],
    breakpoints: ['validateInput()', 'initializeContext()']
  },
  execution: {
    logs: ['Step execution', 'Data transformation'],
    metrics: ['step_execution_time', 'data_processing_time'],
    breakpoints: ['executeStep()', 'transformData()']
  },
  completion: {
    logs: ['Workflow completed', 'Results saved'],
    metrics: ['total_execution_time', 'success_confirmation'],
    breakpoints: ['finalizeWorkflow()', 'sendNotifications()']
  }
};
```

### 5.3 Runtime Behavior and Monitoring

**Performance Monitoring**:
```typescript
// Real-time performance metrics
const PERFORMANCE_METRICS = {
  executionTime: {
    p50: '{workflow_1_p50_time}ms',
    p95: '{workflow_1_p95_time}ms',
    p99: '{workflow_1_p99_time}ms'
  },
  errorRates: {
    validationErrors: '{validation_error_rate}%',
    systemErrors: '{system_error_rate}%',
    timeoutErrors: '{timeout_error_rate}%'
  },
  throughput: {
    requestsPerMinute: {workflow_1_rpm},
    concurrentExecutions: {workflow_1_concurrent_max}
  }
};
```

**Common Issues and Solutions**:
```typescript
// Known issues and their solutions
const KNOWN_ISSUES = {
  'ISSUE-001': {
    description: 'Race condition in concurrent executions',
    symptoms: ['Inconsistent data updates', 'Deadlock errors'],
    rootCause: 'Missing database transaction isolation',
    solution: 'Implement SERIALIZABLE isolation level',
    workaround: 'Limit concurrent executions to 1',
    status: 'fixed in v{fix_version}'
  },
  'ISSUE-002': {
    description: 'Memory leak in long-running workflows',
    symptoms: ['Increasing memory usage', 'Performance degradation'],
    rootCause: 'Event listeners not properly cleaned up',
    solution: 'Implement proper cleanup in finally blocks',
    workaround: 'Restart service daily',
    status: 'mitigation implemented'
  }
};
```

### 5.4 Maintenance and Evolution

**Workflow Maintenance Schedule**:
```typescript
// Regular maintenance activities
const MAINTENANCE_SCHEDULE = {
  daily: [
    'Monitor error rates and performance metrics',
    'Review workflow execution logs',
    'Check for failed workflow instances'
  ],
  weekly: [
    'Analyze workflow performance trends',
    'Review and update test cases',
    'Validate data integrity'
  ],
  monthly: [
    'Full workflow regression testing',
    'Performance optimization review',
    'Security vulnerability assessment'
  ]
};
```

**Evolution Planning**:
```typescript
// Future improvements and planned changes
const EVOLUTION_PLAN = {
  shortTerm: {
    priority: 'high',
    changes: [
      'Add comprehensive input validation',
      'Implement circuit breaker pattern',
      'Add detailed execution metrics'
    ]
  },
  longTerm: {
    priority: 'medium',
    changes: [
      'Migrate to event-driven architecture',
      'Implement workflow versioning',
      'Add real-time progress tracking'
    ]
  }
};
```

---

## Part 6: UI Consistency Standards Establishment

### 6.1 Reference Discipline Methodology

**Primary Reference Discipline**: `01900_procurement` (Buyer Agent)
**Reason**: Most mature implementation with comprehensive workflow coverage

**Standards Establishment Process**:
```typescript
// Step 1: Analyze Reference Implementation
const REFERENCE_ANALYSIS = {
  procurement_discipline: {
    components: {
      buttons: 'Orange theme (#FF8C00), 40px height, rounded corners',
      tables: 'Sortable columns, pagination, bulk actions',
      modals: '600px width, centered, backdrop blur',
      forms: 'Consistent spacing, validation states, error display'
    },
    interactions: {
      navigation: 'State-based with visual indicators',
      fileUploads: 'Drag & drop with progress indicators',
      search: 'Real-time with debouncing, keyboard navigation'
    },
    responsive: {
      breakpoints: '768px, 1024px, 1440px',
      grid: 'CSS Grid with auto-fit columns',
      mobile: 'Single column, stacked layout'
    }
  }
};

// Step 2: Extract Standards
const UI_STANDARDS = {
  colors: REFERENCE_ANALYSIS.procurement_discipline.components.buttons.theme,
  spacing: REFERENCE_ANALYSIS.procurement_discipline.components.forms.spacing,
  typography: REFERENCE_ANALYSIS.procurement_discipline.components.buttons.fontSize,
  components: REFERENCE_ANALYSIS.procurement_discipline.components,
  interactions: REFERENCE_ANALYSIS.procurement_discipline.interactions,
  responsive: REFERENCE_ANALYSIS.procurement_discipline.responsive
};
```

### 6.2 Standards Validation Process

**Automated Consistency Checking**:
```typescript
// Validate new discipline against standards
const validateDisciplineConsistency = (newDiscipline: Discipline) => {
  const violations = [];

  // Component Standards
  if (newDiscipline.buttons.height !== UI_STANDARDS.components.buttons.height) {
    violations.push({
      type: 'component',
      element: 'button',
      property: 'height',
      expected: UI_STANDARDS.components.buttons.height,
      actual: newDiscipline.buttons.height,
      severity: 'high'
    });
  }

  // Interaction Standards
  if (!newDiscipline.search.keyboardNavigation) {
    violations.push({
      type: 'interaction',
      element: 'search',
      property: 'keyboardNavigation',
      expected: true,
      actual: false,
      severity: 'medium'
    });
  }

  // Responsive Standards
  if (newDiscipline.breakpoints.mobile !== UI_STANDARDS.responsive.breakpoints[0]) {
    violations.push({
      type: 'responsive',
      element: 'breakpoints',
      property: 'mobile',
      expected: UI_STANDARDS.responsive.breakpoints[0],
      actual: newDiscipline.breakpoints.mobile,
      severity: 'high'
    });
  }

  return {
    compliant: violations.length === 0,
    violations,
    recommendations: generateFixes(violations)
  };
};
```

### 6.3 Standards Evolution Process

**Standards Update Workflow**:
```typescript
// When a discipline introduces an improvement
const proposeStandardsUpdate = (improvement: UIImprovement) => {
  // Step 1: Validate improvement doesn't break existing functionality
  const impactAnalysis = analyzeImpact(improvement);

  // Step 2: Test across all disciplines
  const compatibilityTest = testAcrossDisciplines(improvement);

  // Step 3: Update standards if approved
  if (compatibilityTest.passes && impactAnalysis.acceptable) {
    updateUIStandards(improvement);
    notifyAllAgents(improvement);
    scheduleImplementation(improvement);
  }
};

// Example: Button size improvement
const buttonSizeImprovement = {
  component: 'button',
  property: 'height',
  oldValue: '40px',
  newValue: '44px',
  reason: 'Better touch targets for mobile',
  impact: 'Minor layout adjustments needed',
  migration: 'Automatic CSS updates available'
};
```

### 6.4 Cross-Discipline Consistency Monitoring

**Automated Compliance Dashboard**:
```typescript
// Real-time consistency monitoring
const CONSISTENCY_DASHBOARD = {
  overallCompliance: {
    compliantDisciplines: 45,
    totalDisciplines: 52,
    complianceRate: '86.5%'
  },
  violationsByCategory: {
    component: 12,
    interaction: 8,
    responsive: 15,
    accessibility: 3
  },
  topViolations: [
    { issue: 'Button height inconsistency', disciplines: ['00850', '00870'], count: 2 },
    { issue: 'Missing keyboard navigation', disciplines: ['00250', '00300'], count: 2 },
    { issue: 'Mobile breakpoint mismatch', disciplines: ['00400', '00500'], count: 3 }
  ],
  recentFixes: [
    { discipline: '00850', fix: 'Updated button heights', date: '2026-04-08' },
    { discipline: '00250', fix: 'Added keyboard navigation', date: '2026-04-07' }
  ]
};
```

### 6.5 Standards Documentation Process

**Living Standards Document**:
```typescript
// Auto-updating standards documentation
const STANDARDS_DOCUMENT = {
  version: '2.1.3',
  lastUpdated: new Date('2026-04-10'),
  referenceDiscipline: '01900_procurement',
  sections: {
    components: {
      buttons: UI_STANDARDS.components.buttons,
      tables: UI_STANDARDS.components.tables,
      forms: UI_STANDARDS.components.forms,
      modals: UI_STANDARDS.components.modals
    },
    interactions: UI_STANDARDS.interactions,
    responsive: UI_STANDARDS.responsive,
    accessibility: {
      keyboard: 'Full navigation support required',
      screenReader: 'ARIA labels with 95% coverage',
      contrast: 'WCAG AA compliance',
      focus: 'Visible focus indicators'
    }
  },
  changeLog: [
    {
      version: '2.1.3',
      date: '2026-04-10',
      changes: ['Updated button touch targets', 'Enhanced mobile responsiveness'],
      affectedDisciplines: ['all']
    }
  ]
};
```

---

## Part 7: Existing Implementation Validation Process

### 7.1 Data Collection Phase - Discipline Analysis

**Automated UI Specification Extraction**:
```typescript
// Script to analyze existing discipline implementations
const analyzeExistingDiscipline = async (disciplineCode: string) => {
  console.log(`🔍 Analyzing ${disciplineCode} implementation...`);

  // 1. Component Analysis
  const components = await extractUIComponents(disciplineCode);
  const componentSpecs = {
    buttons: analyzeButtons(components.buttons),
    tables: analyzeTables(components.tables),
    forms: analyzeForms(components.forms),
    modals: analyzeModals(components.modals)
  };

  // 2. Interaction Analysis
  const interactions = await extractInteractions(disciplineCode);
  const interactionSpecs = {
    navigation: analyzeNavigation(interactions.navigation),
    search: analyzeSearch(interactions.search),
    fileHandling: analyzeFileHandling(interactions.fileHandling)
  };

  // 3. Responsive Analysis
  const responsive = await extractResponsiveDesign(disciplineCode);
  const responsiveSpecs = {
    breakpoints: analyzeBreakpoints(responsive.breakpoints),
    grid: analyzeGridSystem(responsive.grid),
    mobile: analyzeMobileOptimizations(responsive.mobile)
  };

  // 4. Generate Discipline Report
  return {
    disciplineCode,
    analysisDate: new Date(),
    componentSpecs,
    interactionSpecs,
    responsiveSpecs,
    screenshots: await captureScreenshots(disciplineCode),
    sourceFiles: await identifySourceFiles(disciplineCode)
  };
};
```

**Batch Analysis Script**:
```bash
#!/bin/bash
# analyze_all_disciplines.sh

echo "🚀 Starting comprehensive UI consistency analysis..."

# Define all discipline codes
DISCIPLINES=(
  "00250" "00300" "00400" "00425" "00430" "00435"
  "00825" "00835" "00850" "00855" "00860" "00870"
  "00877" "00880" "00882" "00883" "00884" "00885"
  "00886" "00888" "00889" "00890" "00895" "00900"
  "01000" "01100" "01200" "01200" "01300" "01300"
  "01400" "01500" "01500" "01600" "01700" "01750"
  "01800" "01800" "01850" "01900" "02000" "02000"
  "02025" "02035" "02050" "02075" "02200" "02250"
  "02400" "02500" "03000"
)

# Analyze each discipline
for discipline in "${DISCIPLINES[@]}"; do
  echo "📊 Analyzing discipline: $discipline"
  node scripts/analyze-discipline.js "$discipline" >> analysis_results.json
done

echo "✅ Analysis complete. Results in analysis_results.json"
```

### 7.2 Standards Comparison Phase - Validation Against Reference

**Intelligent Standards Comparison with Variance Handling**:
```typescript
// Compare discipline analysis against established standards with variance tolerance
const compareAgainstStandards = (disciplineAnalysis: DisciplineAnalysis) => {
  console.log(`⚖️ Comparing ${disciplineAnalysis.disciplineCode} against standards...`);

  const violations: Violation[] = [];
  const warnings: Variance[] = [];
  const compliance: Compliance = {
    overall: 0,
    components: 0,
    interactions: 0,
    responsive: 0,
    accessibility: 0
  };

  // Component Compliance Check with Tolerance
  const componentResults = checkComponentComplianceWithTolerance(
    disciplineAnalysis.componentSpecs,
    UI_STANDARDS.components,
    COMPONENT_TOLERANCE_RULES
  );
  violations.push(...componentResults.violations);
  warnings.push(...componentResults.warnings);

  // Interaction Compliance Check with Flexibility
  const interactionResults = checkInteractionComplianceWithFlexibility(
    disciplineAnalysis.interactionSpecs,
    UI_STANDARDS.interactions,
    INTERACTION_FLEXIBILITY_RULES
  );
  violations.push(...interactionResults.violations);
  warnings.push(...interactionResults.warnings);

  // Responsive Compliance Check with Context
  const responsiveResults = checkResponsiveComplianceWithContext(
    disciplineAnalysis.responsiveSpecs,
    UI_STANDARDS.responsive,
    RESPONSIVE_CONTEXT_RULES
  );
  violations.push(...responsiveResults.violations);
  warnings.push(...responsiveResults.warnings);

  // Discipline-Specific Variance Assessment
  const varianceAssessment = assessLegitimateVariances(
    disciplineAnalysis,
    DISCIPLINE_SPECIFIC_RULES[disciplineAnalysis.disciplineCode]
  );
  warnings.push(...varianceAssessment.approvedVariances);

  // Calculate Weighted Compliance Scores
  compliance.components = calculateWeightedComplianceScore('components', violations, warnings);
  compliance.interactions = calculateWeightedComplianceScore('interactions', violations, warnings);
  compliance.responsive = calculateWeightedComplianceScore('responsive', violations, warnings);
  compliance.overall = (compliance.components + compliance.interactions + compliance.responsive) / 3;

  return {
    disciplineCode: disciplineAnalysis.disciplineCode,
    compliance,
    violations,        // Must-fix issues
    warnings,          // Review for potential issues or approved variances
    approvedVariances: varianceAssessment.approvedVariances,
    recommendations: generateSmartRecommendations(violations, warnings),
    priority: determineRemediationPriority(violations, warnings),
    estimatedEffort: estimateFixEffort(violations, warnings),
    varianceAnalysis: varianceAssessment
  };
};
```

**Compliance Scoring Algorithm**:
```typescript
const calculateComplianceScore = (category: string, violations: Violation[]): number => {
  const categoryViolations = violations.filter(v => v.category === category);
  const totalChecks = getTotalChecksForCategory(category);
  const passingChecks = totalChecks - categoryViolations.length;

  return Math.round((passingChecks / totalChecks) * 100);
};

// Compliance thresholds
const COMPLIANCE_THRESHOLDS = {
  excellent: 95,  // 95-100%
  good: 85,       // 85-94%
  fair: 70,       // 70-84%
  poor: 0         // 0-69%
};
```

### 7.3 Remediation Phase - Systematic Fixes

**Automated Fix Generation**:
```typescript
// Generate specific fix recommendations
const generateRecommendations = (violations: Violation[]): Recommendation[] => {
  return violations.map(violation => ({
    violationId: violation.id,
    component: violation.component,
    property: violation.property,
    currentValue: violation.actual,
    targetValue: violation.expected,
    severity: violation.severity,

    // Automated fix suggestions
    fixType: determineFixType(violation),
    codeChanges: generateCodeChanges(violation),
    cssChanges: generateCSSChanges(violation),
    testUpdates: generateTestUpdates(violation),

    // Implementation guidance
    effort: estimateEffort(violation),
    risk: assessRisk(violation),
    dependencies: identifyDependencies(violation)
  }));
};
```

**Remediation Workflow**:
```typescript
// Execute fixes in priority order
const executeRemediationPlan = async (disciplineCode: string, recommendations: Recommendation[]) => {
  // Sort by priority and effort
  const prioritizedFixes = recommendations.sort((a, b) =>
    (PRIORITY_WEIGHTS[a.severity] * EFFORT_WEIGHTS[a.effort]) -
    (PRIORITY_WEIGHTS[b.severity] * EFFORT_WEIGHTS[b.effort])
  );

  for (const fix of prioritizedFixes) {
    console.log(`🔧 Applying fix: ${fix.violationId}`);

    // Backup current state
    await createBackup(disciplineCode, fix.component);

    // Apply automated fixes
    if (fix.fixType === 'automated') {
      await applyAutomatedFix(fix);
    } else {
      await createManualFixTask(fix);
    }

    // Validate fix
    const validation = await validateFix(fix);
    if (!validation.passed) {
      await rollbackFix(disciplineCode, fix);
      await escalateToManual(fix);
    }

    // Update compliance dashboard
    await updateComplianceDashboard(disciplineCode);
  }
};
```

### 7.4 Monitoring Phase - Prevent Future Drift

**Continuous Compliance Monitoring**:
```typescript
// Real-time compliance monitoring
const startComplianceMonitoring = () => {
  // Monitor code changes
  watchForCodeChanges((change: CodeChange) => {
    const complianceImpact = assessComplianceImpact(change);
    if (complianceImpact.significant) {
      alertComplianceTeam(change, complianceImpact);
    }
  });

  // Monitor deployments
  watchForDeployments((deployment: Deployment) => {
    const preDeployCompliance = checkCompliance(deployment.discipline);
    if (preDeployCompliance.overall < COMPLIANCE_THRESHOLDS.good) {
      blockDeployment(deployment, preDeployCompliance);
    }
  });

  // Daily compliance audits
  scheduleDailyAudit(() => {
    const auditResults = runComplianceAudit();
    generateComplianceReport(auditResults);
    if (auditResults.violations.length > 0) {
      notifyDevelopmentTeams(auditResults);
    }
  });
};
```

**Compliance Dashboard**:
```typescript
// Real-time compliance visualization
const COMPLIANCE_DASHBOARD = {
  summary: {
    totalDisciplines: 52,
    compliantDisciplines: 45,
    averageCompliance: 87.3,
    trend: 'improving' // improving, stable, declining
  },

  disciplineBreakdown: [
    { code: '01900', compliance: 98.2, status: 'reference' },
    { code: '00850', compliance: 92.1, status: 'good' },
    { code: '00870', compliance: 85.7, status: 'fair' },
    { code: '00250', compliance: 76.4, status: 'needs_attention' }
  ],

  violationTrends: {
    componentViolations: { current: 23, previous: 31, trend: 'down' },
    interactionViolations: { current: 15, previous: 18, trend: 'down' },
    responsiveViolations: { current: 28, previous: 35, trend: 'down' }
  },

  recentActivity: [
    { discipline: '00850', action: 'Fixed button heights', date: '2026-04-10' },
    { discipline: '00250', action: 'Added keyboard navigation', date: '2026-04-09' },
    { discipline: '00870', action: 'Updated responsive breakpoints', date: '2026-04-08' }
  ]
};
```

---

## Part 8: System Integration Points

### 4.1 {PRIMARY_MODAL_1_NAME} Modal

**Modal ID**: `{PRIMARY_MODAL_1_ID}`
**Trigger**: "{PRIMARY_MODAL_1_TRIGGER}" button
**Purpose**: {primary_modal_1_purpose}

**Form Sections**:

1. **{SECTION_1_NAME}**
   ```
   {field_1_label}: [{field_1_input_type}]
   {field_2_label}: [{field_2_input_type}]
   ```

2. **{SECTION_2_NAME}** (Dynamic table)
   ```
   | {table_col_1} | {table_col_2} | {table_col_3} |
   |---------------|---------------|---------------|
   | [{input_1}]   | [{input_2}]   | [{input_3}]   |
   ```

### 4.2 {PRIMARY_MODAL_2_NAME} Modal

**Modal ID**: `{PRIMARY_MODAL_2_ID}`
**Trigger**: "{PRIMARY_MODAL_2_TRIGGER}" button
**Purpose**: {primary_modal_2_purpose}

**Interface Elements**:

1. **{ELEMENT_1_NAME}**
   ```
   {element_1_label}: [{element_1_type} with {element_1_feature}]
   [Scrape Button]
   ```

2. **{ELEMENT_2_NAME}** (Dynamic table)
   ```
   | {result_col_1} | {result_col_2} | {result_col_3} |
   |----------------|----------------|----------------|
   | [{result_1}]   | [{result_2}]   | [{result_3}]   |
   ```

---

## Part 5: System Integration Points

### 5.1 {INTEGRATION_SYSTEM_1}

**System**: {integration_1_system}
**Purpose**: {integration_1_purpose}

**Integration Points**:
- **{integration_1_point_1}**: {integration_1_point_1_desc}
- **{integration_1_point_2}**: {integration_1_point_2_desc}

**API Endpoints**:
```
{integration_1_endpoint_1}
{integration_1_endpoint_2}
```

### 5.2 {INTEGRATION_SYSTEM_2}

**System**: {integration_2_system}
**Purpose**: {integration_2_purpose}

**Integration Points**:
- **{integration_2_point_1}**: {integration_2_point_1_desc}
- **{integration_2_point_2}**: {integration_2_point_2_desc}

**API Endpoints**:
```
{integration_2_endpoint_1}
{integration_2_endpoint_2}
```

---

## Part 6: UI Component Specifications

### 6.1 Navigation Components

#### State Button Component
**Component**: `StateButton`
**Props**:
```javascript
{
  state: string, // "{state_values}"
  isActive: boolean,
  onClick: function,
  children: ReactNode
}
```

**Styling**: Semi-transparent background, hover effects, active state highlighting

#### Modal Trigger Button Component
**Component**: `ModalTriggerButton`
**Props**:
```javascript
{
  modalId: string,
  modalType: string,
  onClick: function,
  disabled: boolean,
  children: ReactNode
}
```

**Styling**: Consistent button sizing, loading states, disabled states

### 6.2 Data Display Components

#### {DISCIPLINE_NAME} Table Component
**Component**: `{DisciplineName}Table`
**Features**:
- Sortable columns
- Filterable data
- Pagination
- Export functionality (CSV, PDF)
- Row selection and bulk actions

**Props**:
```javascript
{
  data: Array,
  columns: Array,
  sortable: boolean,
  filterable: boolean,
  pagination: boolean,
  exportable: boolean
}
```

---

## Part 7: Error Handling and Validation

### 7.1 Form Validation Rules

#### {PRIMARY_ENTITY_NAME} Validation
```javascript
const {primary_entity_camel}ValidationRules = {
  {field_1_camel}: {
    required: true,
    message: '{field_1_error_message}'
  },
  {field_2_camel}: {
    {field_2_rule}: {field_2_value},
    message: '{field_2_error_message}'
  }
};
```

### 7.2 Error Messages and User Guidance

#### Common Error Scenarios
- **{ERROR_1_CONDITION}**: "{ERROR_1_MESSAGE}"
- **{ERROR_2_CONDITION}**: "{ERROR_2_MESSAGE}"

---

## Part 8: Performance and Optimization

### 8.1 Data Loading Optimization

#### Lazy Loading
- Load {domain_entities} on demand
- Paginate large {primary_entity_plural} lists
- Load detailed information only when needed

#### Caching Strategy
- Cache frequently used {domain_entities} for 24 hours
- Cache {workflow_name} matrices for session duration
- Cache templates locally

### 8.2 Search and Filter Optimization

#### Search Implementation
- Full-text search across {search_fields}
- Fuzzy matching for {fuzzy_match_fields}
- Category-based filtering for {filter_categories}

#### Filter Options
```javascript
const filterOptions = {
  {filter_1}: ['{filter_1_option_1}', '{filter_1_option_2}'],
  {filter_2}: '{filter_2_type}',
  {filter_3}: '{filter_3_type}',
  {filter_4}: '{filter_4_type}'
};
```

---

## Part 9: Accessibility and Compliance

### 9.1 Accessibility Features

#### Keyboard Navigation
- Tab order through all form elements
- Keyboard shortcuts for common actions
- Screen reader support with ARIA labels

#### Visual Accessibility
- High contrast mode support
- Color-blind friendly status indicators
- Scalable text and interface elements

### 9.2 Compliance Requirements

#### {COMPLIANCE_TYPE_1}
- {compliance_1_requirement_1}
- {compliance_1_requirement_2}

#### {COMPLIANCE_TYPE_2}
- {compliance_2_requirement_1}
- {compliance_2_requirement_2}

---

## Part 10: Testing and Quality Assurance

### 10.1 Unit Testing Coverage

#### Component Testing
- Modal opening/closing functionality
- Form validation logic
- Data submission handling
- Error state management

#### Integration Testing
- API endpoint connectivity
- Database transaction integrity
- {integration_system} delivery
- Document generation accuracy

### 10.2 User Acceptance Testing

#### {DISCIPLINE_NAME} Workflow Testing
- Complete {workflow_1_name} process
- Multi-level {approval_process} routing
- {entity_1} {process_1} flow
- Report generation and export

#### Edge Case Testing
- Network connectivity issues
- Large dataset handling
- Concurrent user access
- System performance under load

---

## Metadata

- **Agent**: {AGENT_TITLE} (KnowledgeForge AI)
- **Primary Discipline**: {DISCIPLINE_CODE} {DISCIPLINE_NAME}
- **Knowledge Type**: Page-Specific UI and Workflow Knowledge
- **Last Reviewed**: {CURRENT_DATE}
- **Version**: 1.0
- **Related Skills**:
  - {agent_slug}-knowledgeforge
  - {agent_slug}-knowledgeforge-{discipline_slug}

## Appendices

### Appendix A: API Reference Summary

| Endpoint | Method | Purpose | Response |
|----------|--------|---------|----------|
| `{api_endpoint_1}` | {api_method_1} | {api_purpose_1} | {api_response_1} |
| `{api_endpoint_2}` | {api_method_2} | {api_purpose_2} | {api_response_2} |

### Appendix B: Common {DISCIPLINE_NAME} Abbreviations

| Abbreviation | Full Term |
|-------------|-----------|
| {ABBREV_1} | {ABBREV_1_FULL} |
| {ABBREV_2} | {ABBREV_2_FULL} |

### Appendix C: {PRIMARY_ENTITY_NAME} Number Format

**Format**: {NUMBER_FORMAT}
- {format_component_1}: {format_desc_1}
- {format_component_2}: {format_desc_2}

**Examples**:
- {example_1} ({example_1_desc})
- {example_2} ({example_2_desc})

---

## Appendix D: Visual Layout Specifications (Quality Assurance)

### D.1 Button Positioning Validation Matrix

| Button Name | Expected Position | CSS Coordinates | Visual Reference | Test Status |
|-------------|-------------------|-----------------|------------------|-------------|
| {BUTTON_1_NAME} | {button_1_position} | {button_1_css} | {button_1_visual_ref} | {button_1_test_status} |
| {BUTTON_2_NAME} | {button_2_position} | {button_2_css} | {button_2_visual_ref} | {button_2_test_status} |
| {BUTTON_3_NAME} | {button_3_position} | {button_3_css} | {button_3_visual_ref} | {button_3_test_status} |

### D.2 Layout Grid Specifications

**Container**: `{GRID_CONTAINER_ID}`
- **Grid Template**: `{GRID_TEMPLATE_COLUMNS}`
- **Gap**: `{GRID_GAP}`
- **Responsive Breakpoints**:
  - Mobile (< 768px): `{MOBILE_GRID_COLUMNS}`
  - Tablet (768px - 1024px): `{TABLET_GRID_COLUMNS}`
  - Desktop (> 1024px): `{DESKTOP_GRID_COLUMNS}`

### D.3 Color Scheme and Typography

**Primary Colors**:
- Background: `{PRIMARY_BACKGROUND_COLOR}` ({PRIMARY_BACKGROUND_HEX})
- Text: `{PRIMARY_TEXT_COLOR}` ({PRIMARY_TEXT_HEX})
- Accent: `{PRIMARY_ACCENT_COLOR}` ({PRIMARY_ACCENT_HEX})

**Typography Scale**:
- H1: `{H1_FONT_SIZE}` / `{H1_LINE_HEIGHT}` / `{H1_FONT_WEIGHT}`
- Body: `{BODY_FONT_SIZE}` / `{BODY_LINE_HEIGHT}` / `{BODY_FONT_WEIGHT}`
- Buttons: `{BUTTON_FONT_SIZE}` / `{BUTTON_LINE_HEIGHT}` / `{BUTTON_FONT_WEIGHT}`

### D.4 Component Sizing Standards

**Button Dimensions**:
- Standard: `{BUTTON_STANDARD_WIDTH}` × `{BUTTON_STANDARD_HEIGHT}`
- Large: `{BUTTON_LARGE_WIDTH}` × `{BUTTON_LARGE_HEIGHT}`
- Small: `{BUTTON_SMALL_WIDTH}` × `{BUTTON_SMALL_HEIGHT}`

**Modal Dimensions**:
- Standard Modal: `{MODAL_STANDARD_WIDTH}` × `{MODAL_STANDARD_HEIGHT}`
- Large Modal: `{MODAL_LARGE_WIDTH}` × `{MODAL_LARGE_HEIGHT}`

---

## Appendix E: Quality Assurance Integration

### E.1 Automated Visual Testing

**Visual Regression Baselines**:
- Page Load State: `{VISUAL_BASELINE_PAGE_LOAD}`
- Button Interactions: `{VISUAL_BASELINE_BUTTON_STATES}`
- Modal Layouts: `{VISUAL_BASELINE_MODALS}`
- Form States: `{VISUAL_BASELINE_FORMS}`

**Layout Validation Tests**:
```javascript
// Test button positioning accuracy
test('button positioning within tolerance', () => {{
  const button = screen.getByTestId('{BUTTON_1_ID}');
  const rect = button.getBoundingClientRect();
  expect(rect.left).toBeCloseTo({BUTTON_1_EXPECTED_LEFT}, {POSITION_TOLERANCE});
  expect(rect.top).toBeCloseTo({BUTTON_1_EXPECTED_TOP}, {POSITION_TOLERANCE});
}});
```

### E.2 Accessibility Automation

**Screen Reader Validation**:
- ARIA Labels: `{ARIA_COVERAGE_PERCENTAGE}%` coverage required
- Semantic Structure: `{SEMANTIC_SCORE}/100` score target
- Keyboard Navigation: Full tab order tested

---

## Appendix F: Quality Check Procedures

### F.1 Visual Quality Validation

**Button Position Verification**:
1. Load page in development environment
2. Use browser dev tools to measure button positions
3. Compare against specifications (±{POSITION_TOLERANCE}px tolerance)
4. Document any deviations with screenshots
5. Update baselines if changes are approved

**Layout Grid Inspection**:
1. Verify CSS Grid implementation matches template
2. Test responsive breakpoints manually
3. Check dynamic column calculations
4. Validate gap and spacing consistency

### F.2 Performance Quality Checks

**Load Time Validation**:
- First Contentful Paint: < `{FCP_TARGET}ms`
- Largest Contentful Paint: < `{LCP_TARGET}ms`
- Cumulative Layout Shift: < `{CLS_TARGET}`

**Interaction Performance**:
- Button click response: < `{BUTTON_RESPONSE_TARGET}ms`
- Modal open animation: < `{MODAL_OPEN_TARGET}ms`

---

**Document Version**: 1.0
**Last Updated**: {CURRENT_DATE}
**Applicable To**: {AGENT_TITLE} Agent - KnowledgeForge AI
**Contact**: KnowledgeForge AI Documentation Team

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

# Procurement Document Generation Workflow - Technical Specification

## 🔧 **Technical Implementation Details**

### **Component Architecture**

```
client/src/pages/01900-procurement/
├── components/
│   ├── DocumentAssemblyDashboard.jsx    # Universal document assembly system
│   └── modals/
│       ├── CreateOrderModal.jsx         # PO/WO/SO creation
│       ├── 01900-ScopeOfWorkModal.js    # SOW generation
│       └── AppendixRequirementsDisplay.jsx # Unified user allocation
├── services/
│   └── procurementTemplateService.js    # Template management
├── hooks/
│   └── useProcurementOrders.js          # Order management
└── 01901-purchase-orders-page.js        # Main procurement page

client/src/pages/01300-governance/
└── components/
    └── MyTasksDashboard.jsx             # Task management

server/src/
├── controllers/
│   ├── procurementController.js         # Order CRUD operations
│   └── approvalController.js            # Approval workflow management
├── routes/
│   ├── procurement-orders-routes.js     # Order API endpoints
│   └── scope-of-work-routes.js          # SOW and task generation
└── sql/
    └── create_limits_of_authority_table.sql # Governance approval rules
```

### **Database Schema Integration**

```sql
-- Core tables involved
procurement_orders (order details, assignments, approvals)
scope_of_work (SOW content, templates, compliance)
tasks (appendix contributions, assignments, status)
limits_of_authority (governance-controlled approval rules)
user_management (disciplines, roles, assignments)
disciplines (department structures, requirements)
projects (project context, requirements)

-- Limits of Authority Table Structure
limits_of_authority (
    id UUID PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id),
    department_code VARCHAR(50),
    document_type VARCHAR(50), -- 'procurement_order', 'work_order', 'service_order'
    min_amount DECIMAL(15,2) DEFAULT 0,
    max_amount DECIMAL(15,2),
    required_approvals JSONB, -- Array of required approval roles
    conditions JSONB, -- Additional governance conditions
    is_active BOOLEAN DEFAULT true
)

-- Helper Function
get_limits_of_authority_approvals(
    organization_id UUID,
    department_code VARCHAR(50),
    document_type VARCHAR(50),
    amount DECIMAL(15,2)
) RETURNS JSONB
```

### **API Endpoints**

```
/api/procurement-orders              # Order CRUD operations
/api/scope-of-work                  # SOW generation and management
/api/tasks                          # Task management and updates
/api/templates                      # Template management
/api/approval-workflows             # Approval routing and status
/api/limits-of-authority           # Governance-controlled approval rules
```

### **Key Integration Points**

- **Template System**: Unified templates with discipline assignments
- **User Management**: Discipline-based user filtering and assignment
- **Task System**: Automated task creation with status tracking
- **Approval System**: Configurable routing with escalation
- **Document System**: Automated compilation and distribution

### **User-Discipline Assignment System**

**Overview**: The system implements a comprehensive multi-discipline user assignment model, allowing users to be assigned to multiple disciplines simultaneously for collaborative workflows across different project areas.

**Key Principle**: ✅ **Users can be assigned to multiple disciplines** - A single user can participate in procurement workflows across different disciplines (e.g., Engineering, Safety, Quality) based on their expertise and project requirements.

**Current Status**: ✅ **45 active disciplines with multi-discipline user assignments** across the EPCM organization (`90cd635a-380f-4586-a3b7-a09103b6df94`)

**Recent Fix (2025-12-09)**: Resolved issue where disciplines were not showing users in procurement modals. The problem was that the `/api/users/by-discipline` endpoint was incorrectly searching user profiles instead of using the `user_discipline_access` table.

#### **Multi-Discipline Assignment Benefits**

- **Cross-Functional Collaboration**: Users can contribute to procurement workflows across multiple disciplines
- **Expertise Utilization**: Specialists can participate in relevant procurement activities regardless of primary discipline
- **Flexible Team Composition**: Project teams can include members from various disciplines as needed
- **Comprehensive Coverage**: Ensures all procurement disciplines have access to qualified personnel

#### **Assignment Examples**

```javascript
// User assigned to multiple disciplines
{
  userId: "uuid-user-1",
  disciplines: [
    { id: "engineering", name: "Engineering", access_level: "write" },
    { id: "safety", name: "Safety", access_level: "write" },
    { id: "quality", name: "Quality Assurance", access_level: "admin" }
  ]
}
```

#### **Discipline Categories**

**Engineering Disciplines** (9):

- Architectural, Chemical Engineering, Civil Engineering, Developer
- Electrical Engineering, Instrumentation Engineering, Mechanical Engineering
- Process Engineering, Structural Engineering

**Procurement & Commercial** (6):

- Contracts, Procurement, Sales, Sundry
- Contracts Post Award, Contracts Pre Award

**Management & Governance** (5):

- Governance, Operations, Project Controls, Scheduling
- Director Contracts, Director Procurement

**Safety & Quality** (5):

- Safety, HSE, Quality Assurance, Quality Control, Inspection

**Support Functions** (15):

- Finance, Legal, Human Resources, Ethics, Health
- Environmental, Logistics, Local Content, Landscaping
- Public Relations, Quantity Surveying, Other Parties
- Director Construction, Director Engineering, Director Finance

**Director Roles** (5):

- Director HSE, Director Logistics, Director Project, Director Projects, Directors

#### **Technical Implementation**

**Database Structure**:

```sql
-- User-discipline access table
CREATE TABLE user_discipline_access (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES user_management(user_id),
    organization_id UUID REFERENCES organizations(id),
    discipline_code VARCHAR(255), -- Discipline code (e.g., "00825" for Architectural)
    access_level VARCHAR(20),     -- 'write' for regular users, 'admin' for managers
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Disciplines table
CREATE TABLE disciplines (
    id UUID PRIMARY KEY,
    organization_id UUID REFERENCES organizations(id),
    code VARCHAR(50) UNIQUE,      -- Discipline code (e.g., "00825")
    name VARCHAR(255),            -- Discipline name (e.g., "Architectural")
    is_active BOOLEAN DEFAULT true
);
```

**API Endpoints**:

```javascript
// Get all disciplines with their users
GET /api/user-discipline?organization_id={org_id}
// Returns: { disciplines: [{ id, name, code, users: [{ id, name, email, job_title }] }] }

// Get users for specific discipline
GET /api/users/by-discipline?discipline_name={name}&organization_id={org_id}
// Returns: { users: [{ user_id, email, full_name, job_title, department }] }
```

**Key Features**:

- **Organization-Scoped**: All assignments filtered by organization ID
- **Code-Based Matching**: Uses discipline codes for reliable user lookup
- **Role-Based Access**: Regular users get 'write' access, admins get 'admin' access to all disciplines
- **Active User Filtering**: Only active users are returned
- **Real-time Updates**: User assignments reflected immediately in procurement modals
- **Comprehensive Coverage**: All 45 active disciplines ensure complete workflow participation

**Fix Details**: Updated `/api/users/by-discipline` endpoint to properly query `user_discipline_access` table using discipline codes instead of searching user profile fields. Populated `user_discipline_access` table with 54 user-discipline mappings using `populate_user_discipline_access.js` script.

---

## 🔧 **Document Ordering Management - Technical Architecture**

### **System Overview**

The Document Variation Builder serves as the **foundational configuration layer** that precedes the procurement document generation workflow. It provides a sophisticated visual builder interface where users can assemble contract variations by dragging document sections like building blocks, with built-in agent capability indicators and task decomposition preview.

#### **Database Schema**

**Database Schema**:
```sql
-- Discipline document sections table
CREATE TABLE discipline_document_sections (
    id UUID PRIMARY KEY,
    discipline_code VARCHAR(50),        -- e.g., "01900" for Procurement
    section_code VARCHAR(10),          -- e.g., "A", "B", "C"
    section_name VARCHAR(255),         -- e.g., "Technical Specifications"
    section_type VARCHAR(50),          -- "appendix", "schedule", "attachment"
    display_order INTEGER,             -- Determines sequence in documents
    required BOOLEAN DEFAULT false,    -- Whether section is mandatory
    allows_multiple_types BOOLEAN DEFAULT false,
    available_document_types JSONB,    -- Supported document types
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

**API Integration**:
- `GET /api/discipline-document-sections/{discipline}` - Load sections for discipline
- `PUT /api/discipline-document-sections/reorder` - Update section ordering
- Referenced by procurement document assembly during Phase 4

#### **Component Architecture**

**Database Schema**:
```sql
-- Discipline document sections table
CREATE TABLE discipline_document_sections (
    id UUID PRIMARY KEY,
    discipline_code VARCHAR(50),        -- e.g., "01900" for Procurement
    section_code VARCHAR(10),          -- e.g., "A", "B", "C"
    section_name VARCHAR(255),         -- e.g., "Technical Specifications"
    section_type VARCHAR(50),          -- "appendix", "schedule", "attachment"
    display_order INTEGER,             -- Determines sequence in documents
    required BOOLEAN DEFAULT false,    -- Whether section is mandatory
    allows_multiple_types BOOLEAN DEFAULT false,
    available_document_types JSONB,    -- Supported document types
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

**API Integration**:
- `GET /api/discipline-document-sections/{discipline}` - Load sections for discipline
- `PUT /api/discipline-document-sections/reorder` - Update section ordering
- Referenced by procurement document assembly during Phase 4

---

## 📄 **Document Assembly Dashboard - Technical Architecture**

**Component Props**: `orderId`, `discipline` (defaults to 'procurement'), `onBack` callback
**State Management**: React hooks for assembly state, progress tracking, and configuration
**API Integration**: Fetches business object data and content components dynamically
**Lucide Icons**: Modern icon library for consistent UI elements
**Pure CSS Styling**: No Bootstrap dependencies, custom color schemes and layouts

**Assembly Process**:

1. **Modal Trigger**: "Assemble Documents" button in procurement orders table (dynamically imported)
2. **Content Validation**: Checks SOW completion and appendix status across all components
3. **Configuration Review**: Assembly settings for format, structure, security, and naming conventions
4. **Progressive Assembly**: 7-step compilation process with real-time progress updates:
   - Validating content approval status
   - Compiling SOW document sections
   - Integrating appendix content
   - Applying cover sheet and formatting
   - Generating PDF version
   - Generating Word version
   - Creating download package
5. **Package Generation**: Creates comprehensive ZIP package with:
   - Cover Sheet (PDF)
   - Main SOW Document (PDF)
   - Individual Appendix Files (PDF)
   - Complete metadata and audit trail
6. **Distribution Interface**: Download package or send to stakeholders with notification system

**Integration Points**:
- **Business Object API**: `/api/procurement-orders/${orderId}` for order details
- **Content Components API**: `/api/content-components?business_object_id=${orderId}&discipline=${discipline}`
- **Assembly Hierarchy API**: `/api/assembly-hierarchy?business_object_id=${orderId}&discipline=${discipline}`
- **Download System**: `/api/documents/${orderId}/download` for package retrieval

---

## 🤖 **Agent Workflow Integration**

**System Architecture**: The procurement workflow uses **Supabase** (PostgreSQL-based BaaS) for all data storage, authentication, and real-time features. Remote database connection at `https://mseizswoiwyewsidknta.supabase.co` with Row Level Security (RLS) policies.

**Supabase Client Configuration**:

```javascript
// Remote Supabase connection (no local database required)
const supabaseUrl = 'https://mseizswoiwyewsidknta.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';

// Features used:
- Real-time subscriptions (future enhancement)
- Row Level Security (RLS) policies
- Authentication bypass for development
- Automatic UUID generation
- JSONB metadata storage
```

**Development Mode Authentication Bypass**:

- **RLS Policies**: Allow access when `auth.uid() IS NULL` for development mode
- **Task Assignment**: Tasks assigned to `assigned_to: null` (visible to all users via auth bypass)
- **Metadata Tracking**: `original_assigned_to` preserved for production migration
- **Development Flag**: `development_mode: true` in task metadata

**Production Mode Behavior**:

- Tasks assigned to specific authenticated users as selected in UI
- Standard user-based task filtering and permissions
- Full authentication required - no bypass

**Implementation Details**:

```javascript
// Server-side task creation logic
const isDevelopment = process.env.NODE_ENV === 'development' ||
                     req.headers.host?.includes('localhost');

assigned_to: isDevelopment ? null : userId, // NULL for dev, userId for prod
metadata: {
  original_assigned_to: userId, // Track for production
  development_mode: isDevelopment
}
```

**Dashboard Query Logic**:

```javascript
// Development mode includes NULL assigned_to and known dev user IDs
if (finalUser?.id && finalUser.id !== null) {
  query.eq('assigned_to', finalUser.id); // Production: user-specific
} else {
  // Development: include NULL tasks + existing dev user tasks
  const devUserIds = ['550e8400-e29b-41d4-a716-446655440000', ...];
  query.or(`assigned_to.is.null,assigned_to.in.(${devUserIds.join(',')})`);
}
```

**Supabase Tables Used**:

- `tasks` - Task storage with JSONB metadata
- `procurement_orders` - Order data with discipline assignments
- `scope_of_work` - SOW document management
- `disciplines` - Organization discipline definitions
- `user_discipline_access` - User-discipline relationships

---

## 📊 **Performance Metrics Integration**

```javascript
const procurementWorkflowMetrics = {
  stepCompletionTime: {
    orderCreation: "< 2 minutes",
    templateSelection: "< 30 seconds",
    userAssignment: "< 5 minutes",
    sowGeneration: "< 10 minutes",
    approvalRouting: "< 24 hours"
  },
  errorRates: {
    clientErrors: "< 1%",
    serverErrors: "< 0.5%",
    userErrors: "< 2%",
    systemTimeouts: "< 0.1%"
  },
  userSatisfaction: {
    easeOfUse: "> 4.7/5",
    featureCompleteness: "> 98%",
    errorRecovery: "> 95%",
    taskVisibility: "> 96%"
  },
  systemPerformance: {
    templateLoadTime: "< 500ms",
    apiResponseTime: "< 200ms",
    databaseQueryTime: "< 100ms",
    pageLoadTime: "< 2 seconds"
  }
};
```

---

## 🔒 **Security Considerations**

### **Data Access Control**

**Row Level Security (RLS):**
- All database queries filtered by `organization_id` for multi-tenant isolation
- User-specific data access enforced through Supabase RLS policies
- Discipline-based access control prevents cross-discipline data exposure

**Authentication & Authorization:**
- All API endpoints require authenticated user context
- Development mode bypass maintains data isolation through organization scoping
- User role validation occurs at multiple levels (frontend, API, database)

### **Input Validation & Sanitization**

**Client-Side Validation:**
- Form inputs validated using JSON schema definitions
- File uploads restricted by type, size, and content validation
- User selections validated against allowed discipline and role combinations

**Server-Side Validation:**
- All API inputs validated before database operations
- SQL injection prevention through parameterized queries
- File content validation before processing

### **Audit Trail & Monitoring**

**Activity Logging:**
- All procurement order creation logged with user context
- Template usage tracked for security and compliance monitoring
- User assignment changes audited for accountability

**Error Handling Security:**
- Error messages sanitized to prevent information leakage
- Sensitive data excluded from error responses
- Secure logging of security events without exposing user data

### **File Upload Security**

**Content Validation:**
- File type verification using magic bytes, not just file extensions
- Virus scanning integration for uploaded documents
- Size limits enforced to prevent DoS attacks

**Access Control:**
- Uploaded files accessible only to authorized users within organization
- Secure URLs with expiration tokens for file access
- File deletion policies to prevent unauthorized retention

---

## 🧪 **Testing & Quality Assurance**

### **Unit Testing Coverage**

**Component Testing:**
- CreateOrderModal step transitions and validation logic
- UserSelector discipline filtering and assignment functionality
- TemplateService API integration and error handling

**Service Layer Testing:**
- Procurement order creation with various discipline combinations
- User assignment validation and permission checking
- Template retrieval and filtering logic

### **Integration Testing**

**End-to-End Workflow Testing:**
- Complete procurement order creation with SOW generation
- User assignment and task creation verification
- Template selection and form generation validation
- Approval workflow execution and status updates

**API Integration Testing:**
- Supabase RLS policy enforcement verification
- Organization-scoped data isolation testing
- Cross-discipline permission boundary testing

### **User Acceptance Testing**

**Workflow Validation:**
- Procurement officer order creation experience
- Discipline user assignment and task completion flow
- Governance administrator approval routing verification

**Performance Testing:**
- Large organization scaling (1000+ users, 50+ disciplines)
- Concurrent workflow execution stress testing
- Template generation performance under load

### **Automated Testing Integration**

**CI/CD Pipeline Testing:**
```javascript
// Automated test suite structure
const procurementWorkflowTests = {
  unit: {
    componentLogic: 'Component behavior validation',
    serviceMethods: 'API service functionality',
    validationRules: 'Form and data validation'
  },
  integration: {
    workflowExecution: 'End-to-end process validation',
    apiContracts: 'Interface compliance verification',
    dataConsistency: 'Database integrity checks'
  },
  e2e: {
    userJourneys: 'Complete user workflow testing',
    crossBrowser: 'Compatibility validation',
    performance: 'Load and scalability testing'
  }
};
```

---

## 📊 **Workflow Efficiency Metrics**

- **Task Completion Rate**: >98% of assigned tasks completed within SLA
- **Template Utilization**: 95% of procurement templates actively used
- **User Assignment Accuracy**: >99% correct discipline mappings
- **Approval Cycle Time**: <12 hours for standard approvals
- **Document Generation Success**: >99.5% successful completions
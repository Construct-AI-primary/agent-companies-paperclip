---
title: "MEASURE-TENDER-006: External Bespoke Tender Portal"
description: "Create a bespoke B2B tender portal for issuing tenders to sub-vendors and managing contracts pre-award workflows"
gigabrain_tags: issue, measurement, tender, external-portal, contracts-pre-award, b2b, subdomain, vendor-management
labels: ["measurement", "tender", "frontend", "web", "external"]
blocked_by: []
depends_on: ["MEASURE-TENDER-001", "MEASURE-TENDER-003"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/web/issues
last_updated: 2026-04-25
status: backlog
priority: High
story_points: 34
due_date: "2026-05-30"
assigned_to: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-006: External Bespoke Tender Portal

## Overview

Create a **bespoke B2B tender portal** for issuing tenders to sub-vendors and managing contracts pre-award workflows. This portal serves **two distinct user groups**:

1. **Internal Users** (authenticated): Contracts Pre-Award team, Procurement officers
2. **External Users** (invited/guest): Sub-vendors, subcontractors, suppliers

The portal provides a **unified interface** for the complete tender lifecycle, from tender creation through subcontract award.

## User Groups and Access

### Internal Users (Authenticated via ConstructAI)

| Role | Access | Capabilities |
|------|--------|--------------|
| Contracts Pre-Award Team | Full tender management | Create, publish, evaluate, award |
| Procurement Officers | Tender coordination | Manage RFQs, track quotations |
| QS/Measurement Team | BOQ linkage | Link BOQ to tender packages |
| Management | Approval workflows | Approve awards, view reports |

### External Users (Invited/Guest Access)

| Role | Access | Capabilities |
|------|--------|--------------|
| Sub-vendors | Own quotations only | View opportunities, submit quotes |
| Suppliers | Own quotations only | View opportunities, submit quotes |
| Public (optional) | Browse listings only | View published tenders (no quote) |

## Portal Architecture

### Subdomain Configuration

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    BESPOKE TENDER PORTAL                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  Primary:    tenders.yourcompany.co.za    (Branded public portal)        │
│  Internal:   tenders-admin.yourcompany.co.za  (Authenticated)          │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Technology Stack

- **Framework**: Next.js 14 with App Router
- **UI**: React + Tailwind CSS (or existing ConstructAI CSS)
- **Auth**: NextAuth.js with multi-provider support
- **Database**: Shared with ConstructAI (Supabase)
- **Email**: Integration with 03010 Email system
- **Hosting**: Vercel / Railway / self-hosted

## Core Features

### 1. Public Tender Listings

```typescript
// Tender listing page - accessible to all
interface PublicTender {
  id: string;
  tender_number: string;
  title: string;
  description: string;
  trade_categories: string[];  // ['electrical', 'plumbing']
  estimated_value: number;
  closing_date: Date;
  status: 'published' | 'closed' | 'awarded';
  documents: Document[];
  procurement_entity: string;
}

// Public page shows:
// - All published tenders
// - Filter by trade category, value range, closing date
// - Download tender documents
// - Registration/login to submit quotation
```

### 2. Sub-vendor Registration & Prequalification

```typescript
// External vendor self-registration
interface VendorRegistration {
  company_name: string;
  registration_number: string;
  cidb_grade: string;
  bbbee_level: string;
  trade_categories: string[];
  contact_person: ContactInfo;
  bank_details: BankInfo;  // encrypted
  documents: {
    cidb_certificate: File;
    bbbee_certificate: File;
    insurance_certificate: File;
    tax_clearance: File;
  };
  status: 'pending' | 'approved' | 'rejected';
}

// Self-service portal for:
// - Register and submit documents
// - Track prequalification status
// - Update company information
```

### 3. Quotation Submission

```typescript
// Secure quotation submission
interface QuotationSubmission {
  tender_id: string;
  vendor_id: string;
  quoted_amount: number;
  currency: string;
  validity_period: number;
  programme_commitment: string;
  technical_proposal: Text;
  documents: Document[];
  submitted_at: Date;
  status: 'draft' | 'submitted' | 'under_review' | 'awarded' | 'rejected';
}

// Features:
// - Save draft quotations
// - Submit with all required documents
// - Track submission status
// - Receive award/rejection notifications
```

### 4. Contracts Pre-Award Dashboard

```typescript
// Internal dashboard for contracts team
interface ContractsDashboard {
  active_tenders: Tender[];
  pending_evaluations: Evaluation[];
  recent_submissions: Quotation[];
  award_recommendations: Recommendation[];
  approval_queue: Approval[];
}

// Capabilities:
// - Create new tender from BOQ or manual
// - Publish tender to portal
// - Manage tender timeline (publish, close, extend)
// - Evaluate quotations with scoring matrix
// - Generate award recommendation
// - Submit for approval
// - Issue award notification
```

### 5. Evaluation & Scoring

```typescript
// Multi-criteria evaluation
interface EvaluationCriteria {
  name: string;
  weight: number;  // percentage
  max_score: number;
}

interface QuotationEvaluation {
  quotation_id: string;
  criteria: {
    name: string;
    score: number;
    notes: string;
  }[];
  total_score: number;
  rank: number;
  recommendation: 'award' | 'shortlist' | 'reject';
  approved_by: string;
  approved_at: Date;
}

// Scoring matrix:
// - Technical compliance
// - Commercial competitiveness
// - B-BBEE contribution
// - Programme suitability
// - Safety record
```

## Page Structure

```
tenders.yourcompany.co.za/
├── /                          # Landing page with active tenders
├── /tenders                   # Browse all published tenders
├── /tenders/[id]             # Tender detail page
├── /tenders/[id]/quote       # Submit quotation (login required)
├── /register                  # Vendor registration
├── /dashboard                 # Vendor dashboard (quotation status)
├── /login                     # Authentication
│
└── /admin                     # Internal (authenticated)
    ├── /admin/tenders         # Manage all tenders
    ├── /admin/tenders/new     # Create new tender
    ├── /admin/tenders/[id]    # Edit/publish tender
    ├── /admin/evaluations      # Evaluation dashboard
    ├── /admin/quotations       # All quotations
    ├── /admin/vendors          # Vendor management
    └── /admin/awards           # Award approvals
```

## Component Structure

```
client/
├── src/
│   ├── app/
│   │   ├── (public)/          # Public pages
│   │   │   ├── page.tsx       # Landing
│   │   │   ├── tenders/
│   │   │   ├── register/
│   │   │   └── dashboard/
│   │   │
│   │   ├── (admin)/           # Authenticated admin
│   │   │   ├── admin/
│   │   │   ├── tenders/
│   │   │   ├── evaluations/
│   │   │   └── vendors/
│   │   │
│   │   └── api/               # API routes
│   │       ├── tenders/
│   │       ├── quotations/
│   │       └── vendors/
│   │
│   ├── components/
│   │   ├── tender-card.tsx
│   │   ├── tender-form.tsx
│   │   ├── quotation-form.tsx
│   │   ├── evaluation-matrix.tsx
│   │   ├── vendor-card.tsx
│   │   └── vendor-registration.tsx
│   │
│   └── lib/
│       ├── auth.ts            # NextAuth config
│       ├── supabase.ts        # DB client
│       └── tender-api.ts      # API client
```

## API Integration

### Internal API Calls (to ConstructAI)

```typescript
// Connect to MEASURE-TENDER backend
const TENDER_API = {
  // Sync tender data
  getPublishedTenders: () => api.get('/api/subcontract-rfq/rfqs?status=published'),
  getTenderDetail: (id) => api.get(`/api/subcontract-rfq/rfqs/${id}`),
  
  // Quotation submission
  submitQuotation: (data) => api.post('/api/subcontract-rfq/quotations', data),
  getMyQuotations: () => api.get('/api/subcontract-rfq/quotations/my'),
  
  // Vendor registration
  registerVendor: (data) => api.post('/api/subcontract-rfq/subcontractors', data),
  updateVendor: (id, data) => api.put(`/api/subcontract-rfq/subcontractors/${id}`, data),
  
  // Admin functions (authenticated)
  createTender: (data) => api.post('/api/subcontract-rfq/rfqs', data),
  publishTender: (id) => api.post(`/api/subcontract-rfq/rfqs/${id}/publish`),
  evaluateQuotation: (data) => api.post('/api/subcontract-rfq/quotations/evaluate'),
  awardTender: (rfqId, quoteId) => api.post(`/api/subcontract-rfq/rfqs/${rfqId}/award`),
};
```

## Email Integration

```typescript
// Automated notifications
const EMAIL_TRIGGERS = {
  // To vendors
  'tender_published': 'New tender opportunity matching your trade',
  'quotation_received': 'We received your quotation',
  'award_notification': 'Congratulations! Your quotation was successful',
  'rejection_notification': 'Quotation feedback',
  
  // To internal team
  'new_submission': 'New quotation submitted for review',
  'evaluation_reminder': 'Evaluation deadline approaching',
  'approval_required': 'Award requires approval',
};
```

## Design Requirements

### Branding
- Professional construction industry aesthetic
- Match existing ConstructAI branding
- Mobile-responsive for field access

### UX Considerations
- Simple vendor registration flow (minimal friction)
- Clear tender document download
- Step-by-step quotation submission wizard
- Real-time status updates

### Security
- Email verification for vendor accounts
- Document upload validation (PDF, max size)
- Rate limiting on submission endpoints
- CSRF protection on all forms

## Acceptance Criteria

- [ ] Public tender listing page with filtering
- [ ] Tender detail page with document download
- [ ] Vendor self-registration with document upload
- [ ] Quotation submission wizard
- [ ] Vendor dashboard (submission status)
- [ ] Internal admin dashboard for contracts team
- [ ] Multi-criteria evaluation matrix
- [ ] Award workflow with approvals
- [ ] Email notifications for all key events
- [ ] Mobile-responsive design
- [ ] SSO with ConstructAI for internal users
- [ ] Sub-vendor email verification

## Dependencies

- MEASURE-TENDER-001: Database Schema (RLS policies for public access)
- MEASURE-TENDER-003: API Routes (public endpoints)
- MEASURE-TENDER-004: UI Dashboard (reuse components)
- NextAuth.js configuration
- 03010 Email system integration

## Files to Create

```
tender-portal/
├── package.json
├── next.config.js
├── tailwind.config.js
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── styles/
├── public/
│   └── favicon.ico
└── README.md
```

---

**Issue Type**: Frontend Web Application
**Estimated Hours**: 40-60 hours
**Agent Assignment**: loopy-ai (Loopy AI) + devcore-devforge (DevForge AI)

**Note**: This portal complements MEASURE-TENDER-004 (internal dashboard) by providing external-facing access for sub-vendors while maintaining connection to the same MEASURE-TENDER backend.
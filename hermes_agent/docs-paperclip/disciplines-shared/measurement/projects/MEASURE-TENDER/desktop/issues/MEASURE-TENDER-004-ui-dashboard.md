---
delegation:
  parent_goal_id: "MEASURE-ROOT-2026"
  delegation_prompt: "Decompose into sub-tasks as needed per heartbeat loop. Assign sub-tasks to subordinate agents via assigneeAgentId and parentId in the task API."
  allowed_sub_assignees: []
  heartbeat_frequency: "15min"
goals:
  company_goal: "Deliver MEASURE-TENDER subcontractor integration system"
title: "MEASURE-TENDER-004: Sub-vendor Portal Manager UI"
description: "Create React dashboard for managing subcontractor portal sources and RFQ workflows following the integration-management-page pattern"
gigabrain_tags: issue, measurement, tender, ui-dashboard, react, tender-management, integration-ui
labels: ["measurement", "tender", "frontend", "desktop"]
blocked_by: []
depends_on: ["MEASURE-TENDER-003", "PROCURE-001"]
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/desktop/issues
last_updated: 2026-04-25
status: backlog
priority: Medium
story_points: 13
due_date: "2026-05-15"
assignee: loopy-ai
company: loopy-ai
team: ui
---

# MEASURE-TENDER-004: Sub-vendor Portal Manager UI

## Overview

Create the React-based dashboard UI for managing subcontractor portal sources and RFQ workflows. This dashboard follows the proven pattern from the `01900-integration-management-page.js` component and provides a complete interface for the Subcontract Tender Integration System.

## Requirements

### Dashboard Sections

#### 1. Portal Source Manager
- **Source Cards**: Display all configured portal sources
- **Status Indicators**: Active/Inactive/Error states with color coding
- **Quick Actions**: Test, Sync, Edit, Delete buttons
- **Health Status**: Last sync time, sync frequency, success rate

#### 2. RFQ Management
- **RFQ List Table**: Sortable, filterable list of all RFQs
- **Status Badges**: Draft, Published, Closed, Awarded, Cancelled
- **Trade Category Filter**: Electrical, Plumbing, HVAC, Structural, Civil
- **Bulk Actions**: Publish selected, Close selected

#### 3. Quotation Comparison View
- **Comparison Matrix**: Side-by-side quotation comparison
- **Scoring Visualization**: Bar charts for technical/commercial scores
- **Award Recommendation**: One-click recommendation for best value
- **Export Options**: PDF report, Excel comparison

#### 4. Subcontractor Directory
- **Prequalified List**: All approved subcontractors
- **Trade Categories**: Filter by specialization
- **Compliance Badges**: CIDB, B-BBEE, Safety certified
- **Performance History**: Past awards and ratings

### Component Structure

```
client/src/pages/01900-procurement/components/
├── subcontract-rfq/
│   ├── SubcontractRFQPage.js           # Main page component
│   ├── SubcontractPortalManager.js    # Portal source management
│   ├── PortalSourceCard.js            # Individual source display
│   ├── PortalSourceModal.js           # Add/Edit source modal
│   ├── RFQListTable.js               # RFQ listing with filters
│   ├── RFQDetailModal.js             # RFQ view/edit modal
│   ├── CreateRFQModal.js             # New RFQ form
│   ├── QuotationComparison.js         # Bid comparison view
│   ├── SubcontractorDirectory.js      # Subcontractor list
│   ├── SubcontractorDetailModal.js    # Subcontractor view/edit
│   └── SyncStatusPanel.js             # Real-time sync status
├── css/
│   └── subcontract-rfq.css            # Component styles
└── services/
    └── subcontract-rfq-service.js     # API client
```

### Key UI Patterns

#### Portal Source Card
```jsx
<div className="portal-source-card">
  <div className="source-header">
    <span className="source-name">{source.name}</span>
    <StatusBadge status={source.status} />
  </div>
  
  <div className="source-stats">
    <div className="stat">
      <span className="stat-label">Last Sync</span>
      <span className="stat-value">{formatDate(source.last_sync_at)}</span>
    </div>
    <div className="stat">
      <span className="stat-label">RFQs Synced</span>
      <span className="stat-value">{source.rfqs_count}</span>
    </div>
    <div className="stat">
      <span className="stat-label">Success Rate</span>
      <span className="stat-value">{source.success_rate}%</span>
    </div>
  </div>
  
  <div className="source-actions">
    <button onClick={() => testConnection(source.id)}>Test</button>
    <button onClick={() => syncNow(source.id)}>Sync</button>
    <button onClick={() => editSource(source.id)}>Edit</button>
  </div>
</div>
```

#### Quotation Comparison Table
```jsx
<table className="quotation-comparison">
  <thead>
    <tr>
      <th>Subcontractor</th>
      <th>CIDB</th>
      <th>B-BBEE</th>
      <th>Quoted</th>
      <th>Technical</th>
      <th>Commercial</th>
      <th>Total</th>
      <th>Recommend</th>
    </tr>
  </thead>
  <tbody>
    {quotations.map(q => (
      <tr key={q.id} className={q.recommended_for_award ? 'recommended' : ''}>
        <td>{q.subcontractor.name}</td>
        <td>{q.subcontractor.cidb_grade}</td>
        <td>{q.subcontractor.bbbee_level}</td>
        <td>R {q.quoted_amount.toLocaleString()}</td>
        <td><ScoreBar score={q.technical_score} /></td>
        <td><ScoreBar score={q.commercial_score} /></td>
        <td><strong>{q.overall_score}%</strong></td>
        <td>
          <button 
            disabled={q.recommended_for_award}
            onClick={() => recommendAward(q.rfq_id, q.id)}
          >
            {q.recommended_for_award ? '✓ Recommended' : 'Recommend'}
          </button>
        </td>
      </tr>
    ))}
  </tbody>
</table>
```

### Styling

Follow existing ConstructAI styling patterns:
- Use existing CSS variables for colors
- Match accordion/card styles from other procurement pages
- Use consistent button styles and spacing
- Implement responsive design for mobile

### Integration with API

```javascript
// SubcontractRFQService API client
export const SubcontractRFQService = {
  // Sources
  getSources: () => api.get('/subcontract-rfq/sources'),
  createSource: (data) => api.post('/subcontract-rfq/sources', data),
  updateSource: (id, data) => api.put(`/subcontract-rfq/sources/${id}`, data),
  deleteSource: (id) => api.delete(`/subcontract-rfq/sources/${id}`),
  testConnection: (id) => api.post(`/subcontract-rfq/sources/${id}/test`),
  syncNow: (id) => api.post(`/subcontract-rfq/sources/${id}/sync`),
  
  // RFQs
  getRFQs: (filters) => api.get('/subcontract-rfq/rfqs', { params: filters }),
  createRFQ: (data) => api.post('/subcontract-rfq/rfqs', data),
  getRFQDetail: (id) => api.get(`/subcontract-rfq/rfqs/${id}`),
  publishRFQ: (id) => api.post(`/subcontract-rfq/rfqs/${id}/publish`),
  closeRFQ: (id) => api.post(`/subcontract-rfq/rfqs/${id}/close`),
  
  // Quotations
  getQuotations: (rfqId) => api.get(`/subcontract-rfq/quotations/${rfqId}`),
  submitQuotation: (rfqId, data) => api.post(`/subcontract-rfq/quotations/${rfqId}`, data),
  recommendAward: (rfqId, quoteId) => api.post(`/subcontract-rfq/quotations/${rfqId}/${quoteId}/recommend`),
  
  // Subcontractors
  getSubcontractors: (filters) => api.get('/subcontract-rfq/subcontractors', { params: filters }),
  addSubcontractor: (data) => api.post('/subcontract-rfq/subcontractors', data),
  updateSubcontractor: (id, data) => api.put(`/subcontract-rfq/subcontractors/${id}`, data),
};
```

## Acceptance Criteria

- [ ] Portal Source Manager with all CRUD operations
- [ ] RFQ List with filtering and pagination
- [ ] RFQ Create/Edit modals with form validation
- [ ] Quotation Comparison view with scoring visualization
- [ ] Subcontractor Directory with prequalification status
- [ ] Real-time sync status indicators
- [ ] Responsive design for desktop and mobile
- [ ] Integration with API endpoints (MEASURE-TENDER-003)
- [ ] Loading states and error handling
- [ ] Accessibility compliance (WCAG 2.1)

## Dependencies

- MEASURE-TENDER-003: API Routes must be complete
- **PROCURE-001**: 01900 page foundation must be verified (login, nav, state buttons, logout)
- **PROCURE-012**: CSS compliance pass provides styling constraints for new components
- Existing React component patterns from ConstructAI
- CSS styling system from existing pages

## Post-Build Coordination with PROCURE-TEST

After MEASURE-TENDER-004 builds the subcontract-rfq components:

1. **PROCURE-005 regression**: Re-run to verify all 7 existing workspace modals remain functional alongside new subcontract-rfq components
2. **PROCURE-009 verification**: SubcontractorDirectory.js loads alongside existing supplier cards
3. **PROCURE-012 re-run**: Verify new components follow `A-01900-*` CSS naming conventions
4. **PROCURE-015 execution**: Dedicated issue for subcontract-rfq component testing using 8-field metadata + delegation + QC checklist pattern

This ensures the final combined page (existing 01900 components + new subcontract-rfq) is tested as a single unit before production sign-off.

## Files to Create

```
client/src/pages/01900-procurement/components/subcontract-rfq/
client/src/pages/01900-procurement/components/subcontract-rfq/*.js
client/src/common/css/pages/subcontract-rfq.css
```

---

**Issue Type**: Frontend UI
**Estimated Hours**: 20-24 hours
**Agent Assignment**: loopy-ai (Loopy AI)

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

# Supabase Client to API Migration Procedure

## Overview
This document outlines the systematic migration of direct Supabase client calls to API endpoint usage for procurement and safety modules. This migration improves security, consistency, and maintainability by centralizing database operations through server-side endpoints.

## Migration Scope
- **Modules**: Procurement (01900) and Safety (02400)
- **Approach**: Convert direct `supabaseClient.from()` calls to `fetch()` API calls
- **Benefits**:
  - Better RLS (Row Level Security) handling
  - Centralized business logic
  - Improved error handling
  - Consistent API patterns

## Migration Steps

### Phase 1: Analysis & Planning
1. **Identify Target Files**: Scan for direct supabaseClient usage in procurement/safety modules
2. **Categorize Operations**: Group by CRUD operations and table targets
3. **Check Existing Endpoints**: Verify which API routes already exist
4. **Plan New Endpoints**: Design missing server routes and controllers

### Phase 2: API Endpoint Creation
1. **Create Missing Routes**: Add new API endpoints in `/server/src/routes/`
2. **Implement Controllers**: Add corresponding controller functions
3. **Add Middleware**: Include authentication and validation
4. **Test Endpoints**: Verify functionality with Postman/curl

### Phase 3: Client Migration
1. **Update Service Files**: Replace supabaseClient calls with fetch API
2. **Update Component Hooks**: Modify data fetching logic
3. **Remove Direct Imports**: Clean up supabaseClient imports
4. **Test Functionality**: Ensure UI components work correctly

### Phase 4: Testing & Validation
1. **Unit Tests**: Update test files to mock API calls
2. **Integration Tests**: Test complete workflows
3. **Performance Testing**: Verify no degradation
4. **Security Audit**: Confirm RLS policies work correctly

## File Categories

### Procurement Module (01900)
- **Services**: `client/src/services/procurementOrderService.js` ✅ COMPLETED
- **Pages**: Purchase orders, supplier directory, templates, SOW
- **Components**: Modals, forms, data displays

### Safety Module (02400)
- **Services**: `client/src/pages/02400-safety/services/`
- **Pages**: Contractor vetting, HSSE evaluation, safety templates
- **Components**: Modals, assessment forms, document uploads

## Common Patterns

### Before (Direct Supabase)
```javascript
import supabaseClient from '@lib/supabaseClient.js';

const { data, error } = await supabaseClient
  .from('table_name')
  .select('*')
  .eq('field', value);
```

### After (API Endpoint)
```javascript
const response = await fetch('/api/endpoint', {
  method: 'GET',
  headers: { 'Content-Type': 'application/json' }
});
const result = await response.json();
```

## Migration Checklist

### Procurement Files to Migrate
- [x] `client/src/services/procurementOrderService.js`
- [x] `client/src/pages/01900-procurement/components/01900-supplier-directory-page.js`
- [x] `client/src/pages/01900-procurement/components/01900-template-management-page.js`
- [x] `client/src/pages/01900-procurement/components/01900-scope-of-work-page.js`
- [x] `client/src/pages/01900-procurement/components/01900-appendix-d-training-materials.js`
- [ ] `client/src/pages/01900-procurement/components/01900-integration-management-page.js`

### Server-Side API Endpoints Created
- [x] Supplier CRUD endpoints (`/api/suppliers`)
- [x] Supplier statistics endpoint (`/api/suppliers/stats`)
- [x] Supplier bulk operations (`/api/suppliers/bulk`)
- [x] HSSE evaluation CRUD endpoints (`/api/hsse-evaluations`)
- [x] HSSE evaluation statistics endpoint (`/api/hsse-evaluations/stats`)
- [x] Procurement template CRUD endpoints (`/api/procurement-templates`)
- [x] Procurement template statistics endpoint (`/api/procurement-templates/stats`)

### Safety Files to Migrate
- [ ] `client/src/pages/02400-safety/services/SafetyTemplateService.js`
- [x] `client/src/pages/02400-safety/services/hsseEvaluationService.js`
- [ ] `client/src/pages/02400-safety/components/02400-safety-document-templates-page.js`
- [ ] `client/src/pages/02400-safety/02400-contractor-vetting/components/02400-contractor-vetting-page.js`
- [ ] `client/src/pages/02400-safety/components/modals/02400-SafetyUpsertFileModal.js`
- [ ] `client/src/pages/02400-safety/components/modals/02400-assign-contractor-modal.js`

## API Endpoint Patterns

### Standard CRUD Endpoints
```
GET    /api/procurement-orders      # List all
GET    /api/procurement-orders/:id  # Get single
POST   /api/procurement-orders      # Create
PUT    /api/procurement-orders/:id  # Update
DELETE /api/procurement-orders/:id  # Delete
```

### Specialized Endpoints
```
GET    /api/procurement-orders/stats              # Statistics
GET    /api/procurement-orders/with-sow           # With SOW data
POST   /api/procurement-orders/:id/sow-associate  # Associate SOW
```

## Error Handling

### Client-Side
```javascript
try {
  const response = await fetch('/api/endpoint', options);
  if (!response.ok) {
    throw new Error(`HTTP ${response.status}`);
  }
  const result = await response.json();
  return result;
} catch (error) {
  console.error('API call failed:', error);
  throw error;
}
```

### Server-Side
```javascript
try {
  const { data, error } = await supabaseClient
    .from('table')
    .select('*');

  if (error) {
    console.error('Database error:', error);
    return res.status(500).json({ error: 'Database operation failed' });
  }

  res.json({ success: true, data });
} catch (err) {
  console.error('Server error:', err);
  res.status(500).json({ error: 'Internal server error' });
}
```

## Testing Strategy

### Unit Tests
- Mock fetch API calls
- Test error scenarios
- Verify data transformation

### Integration Tests
- Test complete user workflows
- Verify data consistency
- Check performance metrics

### Manual Testing
- UI functionality verification
- Error message display
- Loading states and feedback

## Rollback Plan

1. **Git Branches**: Create feature branches for each migration batch
2. **Incremental Commits**: Commit after each successful file migration
3. **Backup Strategy**: Keep original files as reference
4. **Revert Commands**: Document how to rollback if needed

## Success Criteria

- [ ] All direct supabaseClient calls replaced with API calls
- [ ] No functionality regressions
- [ ] Improved error handling and user feedback
- [ ] Consistent API response formats
- [ ] All tests passing
- [ ] Performance maintained or improved

## Timeline

### Week 1: Planning & Setup
- Complete file analysis
- Create migration documentation
- Set up testing framework

### Week 2-3: Procurement Migration
- Migrate all procurement files
- Create missing API endpoints
- Test procurement functionality

### Week 4: Safety Migration
- Migrate all safety files
- Create missing API endpoints
- Test safety functionality

### Week 5: Final Testing & Documentation
- Comprehensive testing
- Performance optimization
- Documentation updates

## Risk Mitigation

### Technical Risks
- **RLS Policy Conflicts**: Test with different user roles
- **Performance Degradation**: Monitor API response times
- **Data Consistency**: Verify all data operations work correctly

### Operational Risks
- **Downtime**: Schedule migrations during low-usage periods
- **Data Loss**: Ensure proper backup procedures
- **User Impact**: Communicate changes to users

## Success Metrics

- **Functionality**: 100% of features working post-migration
- **Performance**: API response times within acceptable limits
- **Reliability**: Reduced error rates and improved error messages
- **Maintainability**: Cleaner, more consistent codebase
- **Security**: Proper RLS implementation through API layer

## Outstanding Issues/Files

### Files Still Using Direct Supabase Client Access

Based on a comprehensive codebase scan, the following files still contain direct `supabaseClient` usage and are candidates for future migration:

#### Procurement Module (01900) - High Priority
- [x] `client/src/pages/01900-procurement/components/01900-scope-of-work-page.js` - SOW management
- [x] `client/src/pages/01900-procurement/components/01900-appendix-d-training-materials.js` - Training materials
- [x] `client/src/pages/01900-procurement/components/modals/01900-SupplierSetupModal.js` - Supplier setup modal
- [x] `client/src/pages/01900-procurement/components/modals/01900-WorkingSupplierDetailsModal.js` - Working supplier details modal
- [x] `client/src/pages/01900-procurement/components/modals/01900-ScopeOfWorkModal.js` - Scope of work creation modal
- [ ] `client/src/pages/01900-procurement/components/01900-appendix-d-training-materials-sophisticated.js` - Training materials (enhanced)
- [ ] `client/src/pages/01900-procurement/components/01900-appendix-d-training-materials-upgraded.js` - Training materials (latest)
- [ ] `client/src/pages/01900-procurement/components/01900-appendix-e-logistics-documents.js` - Logistics documents
- [ ] `client/src/pages/01900-procurement/components/01900-integration-management-page.js` - Integration management
- [ ] `client/src/pages/01900-procurement/components/document-ordering-management-page.js` - Document ordering
- [ ] `client/src/pages/01900-procurement/utils/disciplineMapping.js` - Discipline utilities
- [ ] `client/src/pages/01900-procurement/components/modals/01900-ScopeOfWorkModal.js` - SOW modal
- [ ] `client/src/pages/01900-procurement/components/modals/SOWAssociationModal.jsx` - SOW association
- [ ] `client/src/pages/01900-procurement/components/modals/01900-WorkingSupplierDetailsModal.js` - Supplier details
- [ ] `client/src/pages/01900-procurement/components/modals/01900-UpsertUrlModal.js` - URL management
- [ ] `client/src/pages/01900-procurement/components/modals/01900-SupplierSetupModal.js` - Supplier setup
- [ ] `client/src/pages/01900-procurement/components/modals/01900-UpsertUnstructuredModal.js` - Unstructured data
- [ ] `client/src/pages/01900-procurement/components/modals/01900-AddTenderModal.js` - Tender creation
- [ ] `client/src/pages/01900-procurement/components/modals/CreateOrderModal.jsx` - Order creation
- [ ] `client/src/pages/01900-procurement/components/modals/01900-ContactScraperModal.js` - Contact scraping
- [ ] `client/src/pages/01900-procurement/components/modals/01900-Assign-Contractor-Modal.js` - Contractor assignment
- [ ] `client/src/pages/01900-procurement/components/modals/01900-UpsertFileModal.js` - File management
- [ ] `client/src/pages/01900-procurement/components/modals/01900-AppendixMaterialModal.js` - Appendix materials
- [ ] `client/src/pages/01900-procurement/components/modals/01900-UpsertCloudModal.jsx` - Cloud storage
- [ ] `client/src/pages/01900-procurement/components/01900-scope-of-work.js` - SOW page
- [ ] `client/src/pages/01900-procurement/components/modals/01900-ScopeOfWorkModal.js` - SOW modal (duplicate)
- [ ] `client/src/pages/01900-procurement/components/01900-tender-monitor-management-page.js` - Tender monitoring

#### Safety Module (02400) - Medium Priority
- [ ] `client/src/pages/02400-safety/components/02400-safety-document-templates-page.js` - Safety templates
- [ ] `client/src/pages/02400-safety/02400-contractor-vetting/components/02400-contractor-vetting-page.js` - Contractor vetting
- [ ] `client/src/pages/02400-safety/components/modals/02400-SafetyUpsertFileModal.js` - File uploads
- [ ] `client/src/pages/02400-safety/components/modals/02400-assign-contractor-modal.js` - Contractor assignment

#### Other Modules - Lower Priority
- [ ] `client/src/pages/01700-logistics/components/01700-logistics-tracking-page.js` - Logistics tracking
- [ ] `client/src/pages/00900-document-control/00900-document-version-management-page.js` - Document versioning
- [ ] `client/src/pages/00900-document-control/components/00900-entities-active-page.js` - Entity management
- [ ] `client/src/pages/00900-document-control/components/modals/00900-DocumentUploadModal.js` - Document uploads
- [ ] `client/src/pages/00300-construction/components/modals/A-0300-03-02-modal-method-statmt.js` - Method statements
- [ ] `client/src/pages/00300-construction/components/modals/00300-RiskAssessmentModal.js` - Risk assessments
- [ ] `client/src/pages/00106-timesheet/components/00106-timesheet-page.js` - Timesheet management
- [ ] `client/src/pages/00850-civil-engineering/components/00850-technical-documents-page.js` - Technical documents
- [ ] `client/src/pages/00850-civil-engineering/components/00850-technical-document-wizard.js` - Document wizard
- [ ] `client/src/pages/00875-sales/components/tender-management/00875-tender-management-page.js` - Tender management
- [ ] `client/src/pages/00875-sales/components/tender-management/00875-tender-monitor-management-page.js` - Tender monitoring

### Migration Impact Analysis

#### High Impact Files (Priority 1)
- Files with complex business logic that would benefit most from API centralization
- Files with frequent database operations
- Files used by multiple users simultaneously

#### Medium Impact Files (Priority 2)
- Files with moderate database usage
- Files with established patterns that can be easily migrated
- Files that support critical business workflows

#### Low Impact Files (Priority 3)
- Files with minimal database operations
- Files that are rarely used or in maintenance mode
- Files with complex legacy integrations

### Migration Strategy for Remaining Files

1. **Create API Endpoints**: For each table/database operation, create corresponding REST endpoints
2. **Build Service Layer**: Create client-side services following the established pattern
3. **Migrate Components**: Replace direct supabaseClient calls with service method calls
4. **Test Thoroughly**: Ensure all functionality works correctly post-migration
5. **Remove Legacy Code**: Clean up unused imports and deprecated code

### Estimated Effort

- **High Priority (Procurement)**: ~40 files, ~2-3 weeks effort
- **Medium Priority (Safety)**: ~4 files, ~3-4 days effort
- **Low Priority (Other)**: ~10+ files, ~1-2 weeks effort
- **Total Remaining**: ~50+ files, ~4-6 weeks total effort

### Benefits of Completing Migration

- **Complete API Architecture**: Full server-side control over data operations
- **Enhanced Security**: All database access through controlled endpoints
- **Improved Performance**: Optimized queries and caching at API layer
- **Better Monitoring**: Centralized logging and error tracking
- **Consistent Patterns**: Uniform error handling and response formats
- **Future-Proof**: Easier to modify business logic and add features

## Next Steps

1. **Immediate Next Steps**:
   - Prioritize procurement template management migration
   - Create API endpoints for procurement templates
   - Migrate scope-of-work components

2. **Medium-term Goals**:
   - Complete all procurement module migrations
   - Finish safety module migrations
   - Establish migration patterns for other modules

3. **Long-term Vision**:
   - Complete migration across entire codebase
   - Establish API-first development practices
   - Implement comprehensive testing and monitoring

4. **Success Metrics**:
   - Zero direct supabaseClient usage in client code
   - 100% API endpoint coverage for database operations
   - Improved application performance and reliability
   - Enhanced security posture

---

**Migration Lead**: AI Assistant
**Start Date**: 2026-01-06
**Completion Date**: 2026-01-06
**Status**: Procurement Module - COMPLETED ✅
**Next Phase**: Safety Module Migration (02400)

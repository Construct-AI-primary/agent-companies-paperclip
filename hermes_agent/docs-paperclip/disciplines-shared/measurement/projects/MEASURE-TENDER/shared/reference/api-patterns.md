---
title: "MEASURE-TENDER API Patterns Reference"
description: "RESTful API patterns for subcontractor RFQ management following /api/tender-integration conventions"
gigabrain_tags: reference, measurement, tender, api-routes, restful, express, patterns
para_section: disciplines-shared/measurement/projects/MEASURE-TENDER/shared/reference
last_updated: 2026-04-25
---

# MEASURE-TENDER API Patterns Reference

Standard API patterns following `/api/tender-integration` conventions.

## Route Structure

```
/api/subcontract-rfq/
├── health                          GET    - System health status
├── sources                         GET    - List all portal sources
├── sources                         POST   - Register new source
├── sources/:sourceId               GET    - Get source details
├── sources/:sourceId               PUT    - Update source config
├── sources/:sourceId               DELETE - Remove source
├── sources/:sourceId/test           POST   - Test connection
├── sources/:sourceId/sync           POST   - Trigger manual sync
├── bulk/sync                       POST   - Sync multiple sources
├── rfqs                            GET    - List RFQs (with filters)
├── rfqs                            POST   - Create new RFQ
├── rfqs/:rfqId                     GET    - Get RFQ details
├── rfqs/:rfqId                     PUT    - Update RFQ
├── rfqs/:rfqId                     DELETE - Cancel RFQ
├── rfqs/:rfqId/publish             POST   - Publish to sub-vendors
├── rfqs/:rfqId/close               POST   - Close bidding
├── subcontractors                   GET    - List prequalified subs
├── subcontractors                   POST   - Add subcontractor
├── subcontractors/:subId           PUT    - Update prequal status
├── quotations/:rfqId                GET    - Get comparison matrix
├── quotations/:rfqId                POST   - Submit quotation
├── quotations/:rfqId/:quoteId      PUT    - Update quotation
├── quotations/:rfqId/:quoteId/recommend POST - Mark for award
├── sync-history                    GET    - Get sync history
├── sync-history/:sourceId           GET    - Get source sync history
├── errors                          GET    - Get error logs
└── errors/:errorId/resolve          POST   - Mark error resolved
```

## Standard Response Format

### Success Response
```json
{
  "success": true,
  "data": { ... },
  "meta": {
    "page": 1,
    "total": 100
  }
}
```

### Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Closing date must be in the future",
    "field": "closing_date",
    "details": {}
  }
}
```

## Route Handler Pattern

```javascript
router.post('/rfqs', 
  authenticateToken,
  validateRFQInput,
  async (req, res) => {
    try {
      const rfq = await subcontractService.createRFQ({
        ...req.body,
        organization_id: req.user.organization_id
      });
      
      res.status(201).json({
        success: true,
        data: rfq
      });
    } catch (error) {
      res.status(error.status || 500).json({
        success: false,
        error: {
          code: error.code || 'INTERNAL_ERROR',
          message: error.message
        }
      });
    }
  }
);
```

## Request Examples

### Create RFQ
```http
POST /api/subcontract-rfq/rfqs
Content-Type: application/json

{
  "title": "Electrical Installation - Phase 1",
  "description": "Complete electrical installation for building A",
  "trade_category": "electrical",
  "scope_of_works": "Full electrical installation including...",
  "cidb_grading_required": "3GB",
  "estimated_value": 2500000,
  "closing_date": "2026-05-15T12:00:00Z",
  "boq_reference_id": "uuid-here"
}
```

### Get Quotations Comparison
```http
GET /api/subcontract-rfq/quotations/{rfqId}
```
```json
{
  "success": true,
  "rfq": {
    "id": "uuid",
    "rfq_number": "RFQ-2026-001",
    "title": "Electrical Installation - Phase 1",
    "status": "closed"
  },
  "quotations": [
    {
      "id": "uuid",
      "subcontractor": {
        "name": "ABC Electrical",
        "cidb_grade": "3GB",
        "bbbee_level": "1"
      },
      "quoted_amount": 2350000,
      "technical_score": 85.5,
      "commercial_score": 92.0,
      "overall_score": 89.2,
      "compliance_status": "compliant",
      "recommended_for_award": true
    }
  ]
}
```

## Authentication & Authorization

| Role | Access |
|------|--------|
| `procurement_officer` | Full CRUD on RFQs and quotations |
| `procurement_manager` | All + approve awards |
| `admin` | Full access including source management |

## Rate Limiting

| Endpoint Type | Limit |
|--------------|-------|
| General | 100 requests/minute per org |
| Sync Operations | 10 requests/minute per source |
| Bulk Operations | 5 requests/minute |

---

**Reference Version**: 1.0
**Last Updated**: 2026-04-25

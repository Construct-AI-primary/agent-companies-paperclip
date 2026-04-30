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

# 01900 → 01700 Procurement-to-Logistics Data Mapping Specification

**Created:** 2026-03-08  
**Source Workflows:** 01900 Procurement / 01700 Logistics  
**Status:** Drafted from implementation audit and current codebase review  
**Purpose:** Define the authoritative field mapping, transformation rules, validation expectations, and known gaps for procurement-to-logistics handoff.

---

## 1. Scope

This document maps the 01900 procurement workflow card set to the 01700 logistics workflow data model and identifies:

- direct mappings already implemented,
- partial mappings that need enrichment or transformation,
- unmapped/weakly mapped fields requiring follow-up implementation,
- validation rules for handoff quality.

This specification is based on review of:

- `01900_procurement/input-agent/cards/index.js`
- `01900_procurement/input-agent/cards/*.js`
- `01700_logistics/services/procurement_logistics_integrator.js`
- workflow audit and implementation plan documents

---

## 2. Current-State Summary

### 2.1 Confirmed Findings

1. The procurement workflow exposes **43 cards**, but cards **29-30 are currently unused placeholders**.
2. The current logistics integration service implements only a **small subset of required procurement fields**.
3. The current integrator has a **field-path inconsistency**:
   - transformed item data is written to `containers.cargo_description`
   - validation later checks `logisticsData.items`
   - cargo inference also checks `logisticsData.items`
   - this creates a likely runtime/data-quality gap.
4. Some audit references to card numbers differ from actual code numbering because the code has evolved and includes placeholder cards.
5. Several logistics-critical fields are captured in 01900 UI cards, but are not yet clearly mapped into 01700 conversation data.

### 2.2 Mapping Status Legend

| Status | Meaning |
|--------|---------|
| ✅ Implemented | Mapping exists in current code and is reasonably aligned |
| ⚠️ Partial | Some data exists but transformation, target field, or usage is incomplete |
| ❌ Unmapped | Source captured in procurement but not clearly transferred to logistics |
| ➖ N/A | Not relevant for logistics handoff |

---

## 3. Card-to-Logistics Mapping Matrix

## 3.1 Foundation / Destination

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 1 | Group Selection | `group` | Cargo class / routing context | ⚠️ Partial | Proposed: `procurement_context.group` |
| 2 | Category Selection | `category` | Commodity classification / handling rules | ⚠️ Partial | Proposed: `procurement_context.category` |
| 3 | Item Selection | `selected_items` / `items` | Cargo description and planning | ⚠️ Partial | `containers.cargo_description` + proposed `items` |
| 4 | Destination Zone | `destination_region` / zone | Route planning / regional constraints | ❌ Unmapped | Proposed: `routing.destination_region` |
| 5 | Destination Country | `destination_country` | Customs, destination compliance, country logic | ✅ Implemented | `destination_country` |

## 3.2 Supplier & Safety

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 6 | Supplier Selection | `supplier_name`, supplier details | Origin party, shipping documentation | ✅ Implemented (name only) | `supplier_name` |
| 7 | Hazardous Materials | hazardous flag / material type | Dangerous goods handling | ⚠️ Partial | Proposed: `cargo.hazardous_materials` |
| 8 | Safety Certifications | certifications | Transport and handling compliance evidence | ❌ Unmapped | Proposed: `compliance.safety_certifications` |
| 9 | Environmental Compliance | environmental requirements | Restricted materials / route constraints | ❌ Unmapped | Proposed: `compliance.environmental` |
| 10 | Quality Standards | quality / inspection requirements | Export/import doc package support | ❌ Unmapped | Proposed: `compliance.quality_requirements` |

## 3.3 Transportation & Logistics

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 11 | Transportation Method | transportation mode | Shipment planning | ❌ Unmapped | Proposed: `shipment.transport_method` |
| 12 | Delivery Timeline | timeline / urgency | Scheduling and carrier selection | ❌ Unmapped | Proposed: `shipment.delivery_timeline` |
| 13 | Special Handling | special handling flags | Cargo classification / special packaging | ⚠️ Partial | Proposed: `shipment.special_handling[]` |
| 14 | Customs Documentation | customs document selections | Document generation checklist | ⚠️ Partial | Proposed: `customs.required_documents[]` |
| 15 | Special Customs | special customs requirements / permits | Special declarations / country rules / HS workflow | ⚠️ Partial | `special_permits.*` + proposed `customs.special_requirements[]` |

## 3.4 Commercial Setup

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 16 | Payment Terms | payment terms | Commercial invoice / trade terms reference | ❌ Unmapped | Proposed: `commercial.payment_terms` |
| 17 | Acceptance Testing | acceptance criteria | Delivery acceptance and inspection checkpoints | ❌ Unmapped | Proposed: `delivery.acceptance_requirements` |
| 18 | Contract Terms | contract / legal terms | Logistics responsibility references | ❌ Unmapped | Proposed: `commercial.contract_terms` |
| 19 | Currency & Payment Methods | currency / payment method | Invoice and customs valuation support | ⚠️ Partial | Proposed: `commercial.currency`, `commercial.payment_method` |
| 20 | Supplier Banking Details | banking details | Usually not needed for logistics generation | ➖ N/A | Not recommended for transfer except controlled references |

## 3.5 Services & Training

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 21 | Training Support | training/service requirements | Post-delivery service coordination | ❌ Unmapped | Proposed: `post_delivery.training_support` |
| 22 | Documentation Manuals | manuals / drawings / spare lists | Shipping document pack attachments | ⚠️ Partial | Proposed: `documents.supporting_materials[]` |
| 23 | Performance Guarantees | warranty / guarantees / penalties | Reference only; low direct logistics use | ❌ Unmapped | Proposed: `commercial.performance_terms` |
| 24 | Supplier Logistics | supplier country / incoterms / broker need | Critical international shipment setup | ⚠️ Partial | `supplier_country`, proposed `shipment.incoterms`, `customs.broker_required` |
| 25 | Cargo Insurance | insurance selections | Shipment risk and document requirements | ⚠️ Partial | Proposed: `insurance.coverage`, `insurance.requirements[]` |

## 3.6 Advanced Commercial / Item Logistics

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 26 | Risk Management | risk factors | Routing / security / packaging decisions | ❌ Unmapped | Proposed: `risk_management.requirements[]` |
| 27 | Item Logistics | weight, dimensions, origin, HS codes, licenses | Core shipping and customs calculations | ⚠️ Partial | Transformed inside items, but target inconsistency exists |
| 28 | Final Review | confirmation / completeness | Handoff readiness gate | ➖ N/A | Workflow state only |
| 29 | Placeholder | N/A | Reserved | ➖ N/A | None |
| 30 | Placeholder | N/A | Reserved | ➖ N/A | None |

## 3.7 Technical Documentation

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 31 | Spare Parts Lists | spare parts list | Packing and shipment detail support | ❌ Unmapped | Proposed: `documents.spare_parts_list` |
| 32 | Technical Performance Guarantees | technical guarantees | Low direct logistics use | ➖ N/A | Optional reference only |
| 33 | Warranty Terms | warranty | Insurance / commercial reference | ❌ Unmapped | Proposed: `commercial.warranty_terms` |
| 34 | Penalty Clauses | penalties | Contractual reference | ➖ N/A | Optional reference only |
| 35 | Supplier Location | supplier location / origin | Export origin / pickup planning | ⚠️ Partial | Proposed: `supplier_origin.address`, `supplier_origin.country` |

## 3.8 Supplier Logistics

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 36 | Shipping Terms | shipping terms | Routing and responsibility model | ❌ Unmapped | Proposed: `shipment.shipping_terms` |
| 37 | Incoterms Selection | incoterms | Critical trade responsibility split | ❌ Unmapped as explicit field | Proposed: `shipment.incoterms` |
| 38 | Customs Broker | broker details | Customs clearance setup | ❌ Unmapped | Proposed: `customs.broker` |
| 39 | Insurance Coverage Level | coverage level | Insurance document generation | ❌ Unmapped | Proposed: `insurance.coverage_level` |
| 40 | Specific Risk Coverage | specific insured risks | Insurance scope | ❌ Unmapped | Proposed: `insurance.specific_risk_coverage[]` |

## 3.9 Finalization

| Card | Procurement Card | Source Field(s) | Intended Logistics Use | Current Mapping Status | Current / Proposed Target |
|------|------------------|-----------------|------------------------|------------------------|---------------------------|
| 41 | Insurance Provider | provider selection | Insurance certificate sourcing | ❌ Unmapped | Proposed: `insurance.provider` |
| 42 | Final Review Confirmation | approval confirmation | Handoff trigger gate | ➖ N/A | workflow state only |
| 43 | Order Creation Processing | order status / output | Handoff event metadata | ⚠️ Partial | `procurement_handoff.*` |

---

## 4. Implemented Mapping Review (Current Code)

The current `ProcurementLogisticsIntegrator` implements the following direct mappings:

| Procurement Source | Logistics Target | Status |
|--------------------|------------------|--------|
| `supplier_name` | `supplier_name` | ✅ |
| `supplier_country` | `supplier_country` | ✅ |
| `destination_country` | `destination_country` | ✅ |
| `destination_port` | `destination_port` | ✅ |
| `phytosanitary_requirements` | `special_permits.phytosanitary` | ✅ |
| `estimated_value` | `total_value` | ✅ but validation references wrong field name |
| `importer_nif` | `importer_details.nif` | ✅ |

### 4.1 Implemented Derived Mapping

| Procurement Source | Logic | Logistics Target | Status |
|--------------------|-------|------------------|--------|
| `items` | transformed by `transformProcurementItems()` | `containers.cargo_description` | ⚠️ Partial due to downstream field mismatch |

### 4.2 Conditional Mapping

| Condition | Effect | Status |
|-----------|--------|--------|
| destination country includes Guinea | importer info, CDC requirement, Guinea requirements metadata | ⚠️ Partial |

---

## 5. Critical Gaps Requiring Implementation

## 5.1 High-Priority Gaps

1. **Item logistics target inconsistency**  
   Current mapping writes transformed items to `containers.cargo_description`, but validation and cargo inference expect `items`.

2. **HS code transfer not explicit**  
   HS codes are only carried if already present inside parsed item objects; there is no guaranteed mapping from the item logistics card into customs structures.

3. **Special handling not normalized**  
   The workflow captures special handling options, but no explicit normalized logistics handoff exists.

4. **Incoterms not explicitly mapped**  
   Supplier logistics and supplier-logistics card groups capture incoterms, yet 01700 does not receive a dedicated `shipment.incoterms` field.

5. **Insurance coverage not explicitly mapped**  
   Cargo insurance, coverage level, specific risk coverage, and insurance provider are not consolidated into a logistics insurance structure.

## 5.2 Medium-Priority Gaps

1. Transportation mode and timeline are not transferred into the logistics planning model.
2. Customs documentation selections are not transferred as a required document checklist.
3. Supplier location/origin is not normalized for export origin planning.
4. Documentation/manual requirements are not mapped as logistics-supporting documents.

---

## 6. Proposed Canonical Handoff Model

```json
{
  "procurement_handoff": {
    "procurement_order_id": "string",
    "procurement_type": "string",
    "transfer_timestamp": "ISO-8601",
    "data_quality_score": 0
  },
  "procurement_context": {
    "group": "string",
    "category": "string",
    "selected_items": []
  },
  "supplier": {
    "name": "string",
    "country": "string",
    "location": "string"
  },
  "shipment": {
    "transport_method": "string",
    "delivery_timeline": "string",
    "shipping_terms": "string",
    "incoterms": "string",
    "special_handling": []
  },
  "destination": {
    "country": "string",
    "region": "string",
    "port": "string"
  },
  "items": [
    {
      "description": "string",
      "quantity": 0,
      "unit_price": 0,
      "total_value": 0,
      "weight": 0,
      "dimensions": "string",
      "country_of_origin": "string",
      "hs_code": "string",
      "export_license_required": false,
      "stackable": false,
      "orientation_requirements": "string",
      "special_securing": "string"
    }
  ],
  "customs": {
    "required_documents": [],
    "special_requirements": [],
    "broker_required": false,
    "broker": {},
    "importer_details": {
      "nif": "string",
      "address": "string"
    }
  },
  "insurance": {
    "coverage": [],
    "coverage_level": "string",
    "specific_risk_coverage": [],
    "provider": "string"
  },
  "documents": {
    "supporting_materials": [],
    "spare_parts_list": false
  },
  "commercial": {
    "currency": "string",
    "payment_terms": "string",
    "warranty_terms": "string"
  },
  "risk_management": {
    "requirements": []
  }
}
```

---

## 7. Transformation Rules

## 7.1 Item-Level Transformation Rules

| Source | Transformation Rule | Result |
|--------|---------------------|--------|
| Tabular/parsed procurement items | Preserve per-item descriptions, quantity, unit price | `items[]` |
| Missing weight | Estimate using item description keywords or explicit default | `items[].weight` |
| `hscode` / `hs_code` | Normalize to `hs_code` | `items[].hs_code` |
| Dimensions text | Preserve raw until standardized parser exists | `items[].dimensions` |
| Origin text | Normalize country name if possible | `items[].country_of_origin` |

## 7.2 Special Handling Normalization

| Procurement Option | Proposed Logistics Value |
|--------------------|-------------------------|
| Temperature controlled | `temperature_controlled` |
| Fragile | `fragile` |
| Hazardous materials | `hazardous_materials` |
| Customs clearance assistance | `customs_assistance` |
| Special packaging | `special_packaging` |
| Export standards compliance | `export_compliance` |
| Climate-controlled packaging | `climate_controlled_packaging` |

## 7.3 Insurance Normalization

Consolidate all insurance-related cards into a single insurance object:

- coverage requirements
- coverage level
- specific risk coverage
- provider choice

---

## 8. Validation Rules

## 8.1 Minimum Handoff Requirements

The following should be present before automatic logistics handoff is treated as valid:

- supplier name
- destination country
- total/estimated value
- at least one item
- item description and quantity for each line item

## 8.2 International Shipment Requirements

For non-domestic shipments, require or warn on:

- incoterms
- transport method
- customs documentation set
- supplier country / origin

## 8.3 Guinea-Specific Requirements

For Guinea destinations:

- importer NIF required
- importer address required
- CDC declaration required for applicable high-value shipments
- customs broker / local representation should be flagged

## 8.4 Data Quality Scoring Guidance

| Condition | Suggested Penalty |
|-----------|-------------------|
| Missing supplier or destination | -10 each |
| Missing items | -15 |
| Missing incoterms for international shipment | -10 |
| Missing HS code for customs-sensitive items | -10 |
| Missing weight/dimensions for freight-sensitive items | -10 |
| Missing importer details for Guinea | -10 |

---

## 9. Implementation Recommendations for Phase 1.1

1. Update `procurement_logistics_integrator.js` so transformed items are written to a canonical `items` array and, if needed, mirrored into any legacy structure.
2. Normalize logistics-critical procurement fields into explicit handoff structures:
   - `shipment.incoterms`
   - `shipment.transport_method`
   - `shipment.delivery_timeline`
   - `shipment.special_handling[]`
   - `customs.required_documents[]`
   - `insurance.*`
3. Add validation rules that distinguish:
   - domestic shipments,
   - international shipments,
   - Guinea-specific shipments.
4. Preserve existing compatibility while improving the canonical handoff model.
5. Build tests that verify:
   - item logistics data is available to logistics,
   - HS codes and customs requirements survive handoff,
   - special handling and insurance are correctly normalized.

---

## 10. Acceptance Checklist for This Specification

- [x] All 43 cards reviewed, including placeholder status for 29-30
- [x] Logistics relevance assessed for each card group
- [x] Current implemented mappings documented
- [x] Partial/unmapped fields identified
- [x] Canonical target structure proposed
- [x] Validation rules defined
- [x] Phase 1.1 implementation guidance captured

---

## 11. Next Step

Proceed to implement the service-level mapping corrections in:

- `deep-agents/deep_agents/agents/pages/01700_logistics/services/procurement_logistics_integrator.js`

and then add focused validation tests for the canonical handoff behavior.
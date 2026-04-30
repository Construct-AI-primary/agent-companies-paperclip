---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# Data Mapping Specification Document

**Document ID:** SPEC-DATA-MAP-001
**Version:** 1.0
**Created:** 2026-03-08
**Last Updated:** 2026-03-08
**Status:** ✅ Complete
**Owner:** Development Team

---

## Executive Summary

This document provides a comprehensive specification for data mapping between the 01900 Procurement Workflow and downstream systems, including the 01700 Logistics Workflow, Statement of Work (SOW) documents, and various appendices. It defines field-level mappings, transformation rules, validation requirements, and data flow patterns.

### Scope

- **Source System:** 01900 Procurement Order Workflow (43 cards)
- **Destination Systems:**
  - 01700 Logistics Workflow
  - SOW Document Generation
  - Appendix Documents (A-F)
  - Compliance and Reporting Systems

### Key Objectives

1. Document all field mappings from procurement cards to destination systems
2. Define transformation rules for data conversion and normalization
3. Specify validation rules for data integrity
4. Provide examples and use cases for each mapping
5. Create visual mapping diagrams for complex data flows

---

## Table of Contents

1. [Card Inventory and Classification](#1-card-inventory-and-classification)
2. [Field Mapping Specifications](#2-field-mapping-specifications)
3. [Transformation Rules](#3-transformation-rules)
4. [Validation Rules](#4-validation-rules)
5. [Data Flow Diagrams](#5-data-flow-diagrams)
6. [Examples and Use Cases](#6-examples-and-use-cases)
7. [Error Handling](#7-error-handling)
8. [Appendix: Complete Field Reference](#8-appendix-complete-field-reference)

---

## 1. Card Inventory and Classification

### 1.1 Card Categories

The 43 procurement cards are organized into the following categories:

| Category | Card Range | Purpose | Destination Priority |
|----------|------------|---------|---------------------|
| **Project Information** | 1-5 | Basic project details | SOW, Logistics |
| **Supplier Information** | 6-10 | Supplier and contact data | SOW, Logistics, Compliance |
| **Item Details** | 11-18 | Product/service specifications | SOW, Logistics, Appendices |
| **Logistics Data** | 19-24 | Shipping and delivery | Logistics, Customs |
| **Compliance** | 25-30 | Regulatory and safety | Compliance, SOW |
| **Financial** | 31-36 | Pricing and payment | SOW, Finance |
| **Documentation** | 37-43 | Attachments and references | All Systems |

### 1.2 Complete Card Inventory

| Card # | Card Name | Category | Primary Destination | Required |
|--------|-----------|----------|---------------------|----------|
| 1 | Project Identification | Project Info | SOW | ✅ Yes |
| 2 | Project Description | Project Info | SOW, Logistics | ✅ Yes |
| 3 | Project Location | Project Info | SOW, Logistics | ✅ Yes |
| 4 | Project Timeline | Project Info | SOW, Logistics | ✅ Yes |
| 5 | Project Stakeholders | Project Info | SOW | ⚠️ Conditional |
| 6 | Supplier Identification | Supplier Info | SOW, Logistics | ✅ Yes |
| 7 | Supplier Contact Details | Supplier Info | SOW, Logistics | ✅ Yes |
| 8 | Special Handling Requirements | Supplier Info | Logistics | ⚠️ Conditional |
| 9 | Supplier Certifications | Supplier Info | Compliance, SOW | ⚠️ Conditional |
| 10 | Special Customs Requirements | Supplier Info | Logistics, Customs | ⚠️ Conditional |
| 11 | Item Identification | Item Details | SOW, Logistics | ✅ Yes |
| 12 | Item Description | Item Details | SOW, Appendices | ✅ Yes |
| 13 | Item Specifications | Item Details | SOW, Appendices | ✅ Yes |
| 14 | Item Quantity | Item Details | SOW, Logistics | ✅ Yes |
| 15 | Item Pricing | Item Details | SOW, Finance | ✅ Yes |
| 16 | Item Delivery Terms | Item Details | Logistics | ✅ Yes |
| 17 | Item Quality Requirements | Item Details | SOW, Appendices | ⚠️ Conditional |
| 18 | Item Compliance Data | Item Details | Compliance, Logistics | ⚠️ Conditional |
| 19 | Supplier Logistics Data | Logistics | Logistics | ✅ Yes |
| 20 | Cargo Insurance | Logistics | Logistics, Finance | ⚠️ Conditional |
| 21 | Shipping Requirements | Logistics | Logistics | ✅ Yes |
| 22 | Item Logistics Data | Logistics | Logistics | ✅ Yes |
| 23 | Delivery Schedule | Logistics | Logistics, SOW | ✅ Yes |
| 24 | Customs Documentation | Logistics | Customs, Logistics | ⚠️ Conditional |
| 25 | Regulatory Compliance | Compliance | Compliance, SOW | ⚠️ Conditional |
| 26 | Safety Requirements | Compliance | Compliance, SOW | ⚠️ Conditional |
| 27 | Environmental Compliance | Compliance | Compliance | ⚠️ Conditional |
| 28 | Quality Assurance | Compliance | SOW, Appendices | ⚠️ Conditional |
| 29 | *Available for Future Use* | - | - | - |
| 30 | *Available for Future Use* | - | - | - |
| 31 | Payment Terms | Financial | SOW, Finance | ✅ Yes |
| 32 | Pricing Breakdown | Financial | SOW, Finance | ✅ Yes |
| 33 | Cost Allocation | Financial | Finance | ⚠️ Conditional |
| 34 | Budget Codes | Financial | Finance | ⚠️ Conditional |
| 35 | Currency and Exchange | Financial | SOW, Finance | ✅ Yes |
| 36 | Tax Information | Financial | SOW, Finance | ✅ Yes |
| 37 | Technical Documents | Documentation | All Systems | ⚠️ Conditional |
| 38 | Drawings and Specifications | Documentation | SOW, Logistics | ⚠️ Conditional |
| 39 | Certificates | Documentation | Compliance, SOW | ⚠️ Conditional |
| 40 | Test Reports | Documentation | Quality, SOW | ⚠️ Conditional |
| 41 | Safety Data Sheets | Documentation | Compliance, Logistics | ⚠️ Conditional |
| 42 | Operating Manuals | Documentation | Logistics, SOW | ⚠️ Conditional |
| 43 | Warranty Documents | Documentation | SOW, Logistics | ⚠️ Conditional |

---

## 2. Field Mapping Specifications

### 2.1 Project Information Cards (1-5)

#### Card 1: Project Identification

**Source Fields:**
```json
{
  "project_id": "string (required)",
  "project_name": "string (required)",
  "project_code": "string (required)",
  "client_name": "string (required)",
  "client_reference": "string (optional)"
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.project_id` | `project_id` | Direct copy | Required, unique |
| `sow.project_name` | `project_name` | Direct copy | Required, max 200 chars |
| `sow.project_code` | `project_code` | Uppercase, trim | Required, format: PRJ-XXXX |
| `sow.client.name` | `client_name` | Direct copy | Required |
| `sow.client.reference` | `client_reference` | Direct copy | Optional |
| `logistics.shipment.project_id` | `project_id` | Direct copy | Required |
| `logistics.customs.project_reference` | `project_code` | Direct copy | Required |

**Example Transformation:**
```javascript
// Input
{
  "project_id": "proj-2026-001",
  "project_name": "Mining Equipment Procurement",
  "project_code": "MEP-2026-001",
  "client_name": "ABC Mining Corporation",
  "client_reference": "REF-12345"
}

// Output (SOW)
{
  "project": {
    "id": "proj-2026-001",
    "name": "Mining Equipment Procurement",
    "code": "MEP-2026-001",
    "client": {
      "name": "ABC Mining Corporation",
      "reference": "REF-12345"
    }
  }
}

// Output (Logistics)
{
  "shipment": {
    "project_id": "proj-2026-001"
  },
  "customs": {
    "project_reference": "MEP-2026-001"
  }
}
```

#### Card 2: Project Description

**Source Fields:**
```json
{
  "project_description": "string (required)",
  "project_scope": "string (required)",
  "project_objectives": "array[string] (required)",
  "project_constraints": "array[string] (optional)"
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.description.summary` | `project_description` | Direct copy, max 500 chars | Required |
| `sow.description.scope` | `project_scope` | Direct copy | Required |
| `sow.description.objectives` | `project_objectives` | Array copy | Required, min 1 |
| `sow.description.constraints` | `project_constraints` | Array copy | Optional |
| `logistics.shipment.description` | `project_description` | Truncate to 200 chars | Required |
| `appendix_a.project_summary` | `project_description` | Direct copy | Required |

#### Card 3: Project Location

**Source Fields:**
```json
{
  "delivery_address": {
    "street": "string (required)",
    "city": "string (required)",
    "state_province": "string (required)",
    "postal_code": "string (required)",
    "country": "string (required)",
    "country_code": "string (required, ISO 3166-1)"
  },
  "site_coordinates": {
    "latitude": "number (optional)",
    "longitude": "number (optional)"
  },
  "delivery_instructions": "string (optional)"
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.delivery.address` | `delivery_address` | Object copy | Required |
| `sow.delivery.coordinates` | `site_coordinates` | Object copy | Optional |
| `sow.delivery.instructions` | `delivery_instructions` | Direct copy | Optional |
| `logistics.destination.address` | `delivery_address` | Object copy | Required |
| `logistics.destination.coordinates` | `site_coordinates` | Object copy | Optional |
| `logistics.destination.instructions` | `delivery_instructions` | Direct copy | Optional |
| `customs.destination_country` | `delivery_address.country_code` | Direct copy | Required, ISO code |

**Country Code Transformation:**
```javascript
// Transformation function
function transformCountryCode(countryCode) {
  // Validate ISO 3166-1 alpha-2 code
  const validCodes = ['ZA', 'GN', 'US', 'GB', 'DE', 'CN', 'IN', 'BR', ...];
  
  if (!validCodes.includes(countryCode)) {
    throw new ValidationError(`Invalid country code: ${countryCode}`);
  }
  
  return {
    iso_alpha2: countryCode,
    iso_alpha3: convertToAlpha3(countryCode),
    name: getCountryName(countryCode)
  };
}
```

#### Card 4: Project Timeline

**Source Fields:**
```json
{
  "start_date": "date (required)",
  "end_date": "date (required)",
  "milestones": [
    {
      "name": "string (required)",
      "date": "date (required)",
      "description": "string (optional)"
    }
  ],
  "delivery_preferences": {
    "preferred_dates": "array[date] (optional)",
    "excluded_dates": "array[date] (optional)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.timeline.start_date` | `start_date` | ISO 8601 format | Required |
| `sow.timeline.end_date` | `end_date` | ISO 8601 format | Required, after start |
| `sow.timeline.milestones` | `milestones` | Array copy | Required, min 1 |
| `logistics.delivery.window_start` | `start_date` | ISO 8601 format | Required |
| `logistics.delivery.window_end` | `end_date` | ISO 8601 format | Required |
| `logistics.delivery.preferred_dates` | `delivery_preferences.preferred_dates` | Array copy | Optional |
| `appendix_c.timeline.start` | `start_date` | ISO 8601 format | Required |
| `appendix_c.timeline.end` | `end_date` | ISO 8601 format | Required |

#### Card 5: Project Stakeholders

**Source Fields:**
```json
{
  "stakeholders": [
    {
      "name": "string (required)",
      "role": "string (required)",
      "email": "string (required)",
      "phone": "string (optional)",
      "organization": "string (required)",
      "is_primary": "boolean (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.stakeholders` | `stakeholders` | Array copy, filter primary | Required, min 1 primary |
| `logistics.contacts` | `stakeholders` | Filter by logistics role | Optional |
| `compliance.approvers` | `stakeholders` | Filter by approval role | Optional |

---

### 2.2 Supplier Information Cards (6-10)

#### Card 6: Supplier Identification

**Source Fields:**
```json
{
  "supplier_id": "string (required)",
  "supplier_name": "string (required)",
  "supplier_type": "enum: manufacturer | distributor | service_provider (required)",
  "registration_number": "string (required)",
  "tax_identification": "string (required)",
  "country_of_origin": "string (required, ISO 3166-1)",
  "website": "string (optional)"
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.supplier.id` | `supplier_id` | Direct copy | Required |
| `sow.supplier.name` | `supplier_name` | Direct copy | Required |
| `sow.supplier.type` | `supplier_type` | Enum validation | Required |
| `sow.supplier.registration` | `registration_number` | Direct copy | Required |
| `sow.supplier.tax_id` | `tax_identification` | Direct copy | Required |
| `sow.supplier.country` | `country_of_origin` | Country code transform | Required |
| `logistics.supplier.id` | `supplier_id` | Direct copy | Required |
| `logistics.supplier.name` | `supplier_name` | Direct copy | Required |
| `logistics.supplier.country` | `country_of_origin` | Country code transform | Required |
| `customs.supplier.origin_country` | `country_of_origin` | Direct copy | Required |
| `compliance.supplier.registration` | `registration_number` | Direct copy | Required |

#### Card 7: Supplier Contact Details

**Source Fields:**
```json
{
  "primary_contact": {
    "name": "string (required)",
    "title": "string (required)",
    "email": "string (required)",
    "phone": "string (required)",
    "mobile": "string (optional)"
  },
  "secondary_contacts": [
    {
      "name": "string (required)",
      "title": "string (required)",
      "email": "string (required)",
      "phone": "string (optional)",
      "role": "string (required)"
    }
  ],
  "address": {
    "street": "string (required)",
    "city": "string (required)",
    "state_province": "string (required)",
    "postal_code": "string (required)",
    "country": "string (required)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.supplier.contact.primary` | `primary_contact` | Object copy | Required |
| `sow.supplier.contact.secondary` | `secondary_contacts` | Array copy | Optional |
| `sow.supplier.address` | `address` | Object copy | Required |
| `logistics.supplier.contact` | `primary_contact` | Object copy | Required |
| `logistics.supplier.address` | `address` | Object copy | Required |
| `customs.supplier.contact` | `primary_contact` | Object copy | Required |

#### Card 8: Special Handling Requirements

**Source Fields:**
```json
{
  "handling_requirements": {
    "fragile": "boolean (required)",
    "hazardous": "boolean (required)",
    "temperature_controlled": "boolean (required)",
    "oversized": "boolean (required)",
    "high_value": "boolean (required)"
  },
  "special_instructions": "string (optional)",
  "equipment_requirements": [
    {
      "type": "string (required)",
      "description": "string (required)",
      "quantity": "number (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.handling.fragile` | `handling_requirements.fragile` | Direct copy | Required |
| `logistics.handling.hazardous` | `handling_requirements.hazardous` | Direct copy | Required |
| `logistics.handling.temperature_controlled` | `handling_requirements.temperature_controlled` | Direct copy | Required |
| `logistics.handling.oversized` | `handling_requirements.oversized` | Direct copy | Required |
| `logistics.handling.high_value` | `handling_requirements.high_value` | Direct copy | Required |
| `logistics.handling.instructions` | `special_instructions` | Direct copy | Optional |
| `logistics.handling.equipment` | `equipment_requirements` | Array copy | Optional |
| `customs.hazardous_materials` | `handling_requirements.hazardous` | Boolean to flag | Required |
| `sow.special_requirements` | `special_instructions` | Direct copy | Optional |

#### Card 9: Supplier Certifications

**Source Fields:**
```json
{
  "certifications": [
    {
      "name": "string (required)",
      "issuer": "string (required)",
      "certificate_number": "string (required)",
      "valid_from": "date (required)",
      "valid_to": "date (required)",
      "scope": "string (optional)"
    }
  ],
  "quality_standards": [
    {
      "standard": "string (required)",
      "certified": "boolean (required)",
      "certificate_id": "string (optional)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.supplier.certifications` | `certifications` | Array copy, validate dates | Required |
| `sow.supplier.quality_standards` | `quality_standards` | Array copy | Required |
| `compliance.supplier.certifications` | `certifications` | Array copy, filter active | Required |
| `compliance.supplier.quality_standards` | `quality_standards` | Array copy | Required |
| `logistics.supplier.certifications` | `certifications` | Array copy, filter logistics-relevant | Optional |

#### Card 10: Special Customs Requirements

**Source Fields:**
```json
{
  "hs_codes": [
    {
      "code": "string (required)",
      "description": "string (required)",
      "category": "string (required)"
    }
  ],
  "customs_value": {
    "currency": "string (required)",
    "amount": "number (required)",
    "incoterms": "string (required)"
  },
  "import_restrictions": [
    {
      "type": "string (required)",
      "description": "string (required)",
      "license_required": "boolean (required)"
    }
  ],
  "country_specific_requirements": {
    "destination_country": "string (required)",
    "requirements": "array[string] (required)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `customs.hs_codes` | `hs_codes` | Array copy, validate format | Required |
| `customs.value` | `customs_value` | Object copy | Required |
| `customs.import_restrictions` | `import_restrictions` | Array copy | Optional |
| `customs.country_requirements` | `country_specific_requirements` | Object copy | Required |
| `logistics.customs.hs_codes` | `hs_codes` | Array copy | Required |
| `logistics.customs.value` | `customs_value` | Object copy | Required |
| `compliance.customs.hs_codes` | `hs_codes` | Array copy | Required |
| `sow.customs_requirements` | `country_specific_requirements` | Object copy | Optional |

---

### 2.3 Item Details Cards (11-18)

#### Card 11: Item Identification

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "item_name": "string (required)",
      "item_code": "string (required)",
      "category": "string (required)",
      "subcategory": "string (optional)",
      "description": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].id` | `items[].item_id` | Direct copy | Required, unique |
| `sow.items[].name` | `items[].item_name` | Direct copy | Required |
| `sow.items[].code` | `items[].item_code` | Direct copy | Required |
| `sow.items[].category` | `items[].category` | Direct copy | Required |
| `sow.items[].subcategory` | `items[].subcategory` | Direct copy | Optional |
| `sow.items[].description` | `items[].description` | Direct copy | Required |
| `logistics.items[].id` | `items[].item_id` | Direct copy | Required |
| `logistics.items[].name` | `items[].item_name` | Direct copy | Required |
| `logistics.items[].category` | `items[].category` | Direct copy | Required |
| `appendix_a.items[]` | `items[]` | Full object copy | Required |

#### Card 12: Item Description

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "detailed_description": "string (required)",
      "technical_specifications": "string (optional)",
      "material_composition": "string (optional)",
      "dimensions": {
        "length": "number (optional)",
        "width": "number (optional)",
        "height": "number (optional)",
        "unit": "string (optional)"
      },
      "weight": {
        "value": "number (optional)",
        "unit": "string (optional)"
      }
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].description.detailed` | `items[].detailed_description` | Direct copy | Required |
| `sow.items[].description.technical` | `items[].technical_specifications` | Direct copy | Optional |
| `sow.items[].description.material` | `items[].material_composition` | Direct copy | Optional |
| `sow.items[].description.dimensions` | `items[].dimensions` | Object copy | Optional |
| `sow.items[].description.weight` | `items[].weight` | Object copy | Optional |
| `logistics.items[].description` | `items[].detailed_description` | Truncate to 500 chars | Required |
| `logistics.items[].dimensions` | `items[].dimensions` | Object copy | Required for logistics |
| `logistics.items[].weight` | `items[].weight` | Object copy | Required for logistics |
| `appendix_a.items[].description` | `items[].detailed_description` | Direct copy | Required |

#### Card 13: Item Specifications

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "specifications": [
        {
          "name": "string (required)",
          "value": "string (required)",
          "unit": "string (optional)",
          "tolerance": "string (optional)"
        }
      ],
      "performance_criteria": [
        {
          "criterion": "string (required)",
          "value": "string (required)",
          "test_method": "string (optional)"
        }
      ]
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].specifications` | `items[].specifications` | Array copy | Required |
| `sow.items[].performance_criteria` | `items[].performance_criteria` | Array copy | Optional |
| `appendix_a.items[].specifications` | `items[].specifications` | Array copy | Required |
| `appendix_a.items[].performance` | `items[].performance_criteria` | Array copy | Optional |
| `compliance.items[].specifications` | `items[].specifications` | Array copy | Required |

#### Card 14: Item Quantity

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "quantity": {
        "value": "number (required)",
        "unit": "string (required)",
        "tolerance_plus": "number (optional)",
        "tolerance_minus": "number (optional)"
      },
      "packaging": {
        "type": "string (required)",
        "units_per_package": "number (required)",
        "total_packages": "number (required)"
      }
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].quantity.value` | `items[].quantity.value` | Direct copy | Required, > 0 |
| `sow.items[].quantity.unit` | `items[].quantity.unit` | Direct copy | Required |
| `sow.items[].quantity.tolerance` | `items[].quantity.tolerance_plus/minus` | Object copy | Optional |
| `sow.items[].packaging` | `items[].packaging` | Object copy | Required |
| `logistics.items[].quantity` | `items[].quantity.value` | Direct copy | Required |
| `logistics.items[].packaging` | `items[].packaging` | Object copy | Required |
| `appendix_a.items[].quantity` | `items[].quantity` | Object copy | Required |

#### Card 15: Item Pricing

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "pricing": {
        "unit_price": "number (required)",
        "currency": "string (required)",
        "total_price": "number (required)",
        "price_basis": "string (required)",
        "price_validity": "date (required)"
      },
      "discounts": [
        {
          "type": "string (required)",
          "percentage": "number (optional)",
          "amount": "number (optional)",
          "conditions": "string (optional)"
        }
      ]
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].pricing.unit_price` | `items[].pricing.unit_price` | Direct copy | Required, > 0 |
| `sow.items[].pricing.currency` | `items[].pricing.currency` | ISO 4217 code | Required |
| `sow.items[].pricing.total` | `items[].pricing.total_price` | Direct copy | Required |
| `sow.items[].pricing.basis` | `items[].pricing.price_basis` | Direct copy | Required |
| `sow.items[].pricing.validity` | `items[].pricing.price_validity` | ISO 8601 date | Required |
| `sow.items[].discounts` | `items[].discounts` | Array copy | Optional |
| `appendix_f.items[].pricing` | `items[].pricing` | Object copy | Required |

#### Card 16: Item Delivery Terms

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "delivery_terms": {
        "incoterms": "string (required)",
        "delivery_point": "string (required)",
        "shipping_terms": "string (optional)",
        "transit_time": "number (optional)"
      },
      "delivery_method": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].delivery.incoterms` | `items[].delivery_terms.incoterms` | Validate Incoterms 2020 | Required |
| `sow.items[].delivery.point` | `items[].delivery_terms.delivery_point` | Direct copy | Required |
| `sow.items[].delivery.terms` | `items[].delivery_terms.shipping_terms` | Direct copy | Optional |
| `sow.items[].delivery.method` | `items[].delivery_method` | Direct copy | Required |
| `logistics.items[].incoterms` | `items[].delivery_terms.incoterms` | Direct copy | Required |
| `logistics.items[].delivery_point` | `items[].delivery_terms.delivery_point` | Direct copy | Required |
| `logistics.items[].transit_time` | `items[].delivery_terms.transit_time` | Direct copy | Optional |

#### Card 17: Item Quality Requirements

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "quality_requirements": {
        "inspection_required": "boolean (required)",
        "inspection_type": "string (optional)",
        "acceptance_criteria": "string (required)",
        "testing_requirements": [
          {
            "test_name": "string (required)",
            "standard": "string (required)",
            "frequency": "string (required)"
          }
        ]
      }
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].quality.inspection_required` | `items[].quality_requirements.inspection_required` | Direct copy | Required |
| `sow.items[].quality.inspection_type` | `items[].quality_requirements.inspection_type` | Direct copy | Conditional |
| `sow.items[].quality.acceptance_criteria` | `items[].quality_requirements.acceptance_criteria` | Direct copy | Required |
| `sow.items[].quality.testing` | `items[].quality_requirements.testing_requirements` | Array copy | Optional |
| `appendix_b.items[].quality` | `items[].quality_requirements` | Object copy | Required |
| `compliance.items[].quality` | `items[].quality_requirements` | Object copy | Required |

#### Card 18: Item Compliance Data

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "compliance": {
        "regulatory_requirements": [
          {
            "regulation": "string (required)",
            "requirement": "string (required)",
            "compliance_status": "enum: compliant | pending | non_compliant (required)"
          }
        ],
        "certifications_required": [
          {
            "certification": "string (required)",
            "authority": "string (required)",
            "validity_required": "boolean (required)"
          }
        ],
        "environmental_compliance": {
          "rohs_compliant": "boolean (required)",
          "reach_compliant": "boolean (required)",
          "conflict_minerals": "boolean (required)"
        }
      }
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.items[].compliance.regulatory` | `items[].compliance.regulatory_requirements` | Array copy | Required |
| `sow.items[].compliance.certifications` | `items[].compliance.certifications_required` | Array copy | Required |
| `sow.items[].compliance.environmental` | `items[].compliance.environmental_compliance` | Object copy | Required |
| `compliance.items[].regulatory` | `items[].compliance.regulatory_requirements` | Array copy | Required |
| `compliance.items[].certifications` | `items[].compliance.certifications_required` | Array copy | Required |
| `compliance.items[].environmental` | `items[].compliance.environmental_compliance` | Object copy | Required |
| `logistics.items[].compliance_flags` | `items[].compliance` | Extract flags | Required |

---

### 2.4 Logistics Data Cards (19-24)

#### Card 19: Supplier Logistics Data

**Source Fields:**
```json
{
  "logistics": {
    "shipping_method": "string (required)",
    "preferred_carrier": "string (optional)",
    "carrier_account": "string (optional)",
    "pickup_location": {
      "address": "string (required)",
      "city": "string (required)",
      "country": "string (required)",
      "country_code": "string (required)"
    },
    "shipping_marks": "string (optional)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.shipment.method` | `logistics.shipping_method` | Direct copy | Required |
| `logistics.shipment.carrier` | `logistics.preferred_carrier` | Direct copy | Optional |
| `logistics.shipment.carrier_account` | `logistics.carrier_account` | Direct copy | Optional |
| `logistics.pickup.address` | `logistics.pickup_location.address` | Direct copy | Required |
| `logistics.pickup.city` | `logistics.pickup_location.city` | Direct copy | Required |
| `logistics.pickup.country` | `logistics.pickup_location.country_code` | ISO code | Required |
| `logistics.shipping_marks` | `logistics.shipping_marks` | Direct copy | Optional |
| `sow.logistics.shipping_method` | `logistics.shipping_method` | Direct copy | Required |

#### Card 20: Cargo Insurance

**Source Fields:**
```json
{
  "insurance": {
    "required": "boolean (required)",
    "provider": "string (optional)",
    "policy_number": "string (optional)",
    "coverage_amount": {
      "value": "number (required)",
      "currency": "string (required)"
    },
    "coverage_type": "string (required)",
    "valid_from": "date (required)",
    "valid_to": "date (required)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.insurance.required` | `insurance.required` | Direct copy | Required |
| `logistics.insurance.provider` | `insurance.provider` | Direct copy | Conditional |
| `logistics.insurance.policy_number` | `insurance.policy_number` | Direct copy | Conditional |
| `logistics.insurance.coverage_amount` | `insurance.coverage_amount` | Object copy | Required |
| `logistics.insurance.coverage_type` | `insurance.coverage_type` | Direct copy | Required |
| `logistics.insurance.valid_from` | `insurance.valid_from` | ISO 8601 date | Required |
| `logistics.insurance.valid_to` | `insurance.valid_to` | ISO 8601 date | Required |
| `sow.insurance` | `insurance` | Object copy | Conditional |

#### Card 21: Shipping Requirements

**Source Fields:**
```json
{
  "shipping": {
    "container_type": "string (required)",
    "container_quantity": "number (required)",
    "stacking_requirements": "string (optional)",
    "temperature_requirements": {
      "min": "number (optional)",
      "max": "number (optional)",
      "unit": "string (optional)"
    },
    "humidity_requirements": {
      "min": "number (optional)",
      "max": "number (optional)"
    },
    "ventilation_requirements": "string (optional)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.shipping.container_type` | `shipping.container_type` | Direct copy | Required |
| `logistics.shipping.container_quantity` | `shipping.container_quantity` | Direct copy | Required, > 0 |
| `logistics.shipping.stacking` | `shipping.stacking_requirements` | Direct copy | Optional |
| `logistics.shipping.temperature` | `shipping.temperature_requirements` | Object copy | Optional |
| `logistics.shipping.humidity` | `shipping.humidity_requirements` | Object copy | Optional |
| `logistics.shipping.ventilation` | `shipping.ventilation_requirements` | Direct copy | Optional |
| `sow.shipping_requirements` | `shipping` | Object copy | Required |

#### Card 22: Item Logistics Data

**Source Fields:**
```json
{
  "items": [
    {
      "item_id": "string (required)",
      "logistics": {
        "weight": {
          "gross": "number (required)",
          "net": "number (required)",
          "unit": "string (required)"
        },
        "dimensions": {
          "length": "number (required)",
          "width": "number (required)",
          "height": "number (required)",
          "unit": "string (required)"
        },
        "volume": {
          "value": "number (required)",
          "unit": "string (required)"
        },
        "packaging_type": "string (required)",
        "hazardous_material": "boolean (required)",
        "un_number": "string (optional)",
        "imdg_class": "string (optional)"
      }
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.items[].weight.gross` | `items[].logistics.weight.gross` | Direct copy | Required |
| `logistics.items[].weight.net` | `items[].logistics.weight.net` | Direct copy | Required |
| `logistics.items[].weight.unit` | `items[].logistics.weight.unit` | Direct copy | Required |
| `logistics.items[].dimensions.length` | `items[].logistics.dimensions.length` | Direct copy | Required |
| `logistics.items[].dimensions.width` | `items[].logistics.dimensions.width` | Direct copy | Required |
| `logistics.items[].dimensions.height` | `items[].logistics.dimensions.height` | Direct copy | Required |
| `logistics.items[].dimensions.unit` | `items[].logistics.dimensions.unit` | Direct copy | Required |
| `logistics.items[].volume` | `items[].logistics.volume` | Object copy | Required |
| `logistics.items[].packaging_type` | `items[].logistics.packaging_type` | Direct copy | Required |
| `logistics.items[].hazardous` | `items[].logistics.hazardous_material` | Direct copy | Required |
| `logistics.items[].un_number` | `items[].logistics.un_number` | Direct copy | Conditional |
| `logistics.items[].imdg_class` | `items[].logistics.imdg_class` | Direct copy | Conditional |
| `customs.items[].weight` | `items[].logistics.weight` | Object copy | Required |
| `customs.items[].hazardous` | `items[].logistics.hazardous_material` | Direct copy | Required |

#### Card 23: Delivery Schedule

**Source Fields:**
```json
{
  "delivery": {
    "requested_date": "date (required)",
    "earliest_date": "date (optional)",
    "latest_date": "date (optional)",
    "delivery_schedule": [
      {
        "item_id": "string (required)",
        "quantity": "number (required)",
        "delivery_date": "date (required)",
        "delivery_location": "string (required)"
      }
    ],
    "partial_delivery_allowed": "boolean (required)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `logistics.delivery.requested_date` | `delivery.requested_date` | ISO 8601 date | Required |
| `logistics.delivery.earliest_date` | `delivery.earliest_date` | ISO 8601 date | Optional |
| `logistics.delivery.latest_date` | `delivery.latest_date` | ISO 8601 date | Optional |
| `logistics.delivery.schedule` | `delivery.delivery_schedule` | Array copy | Required |
| `logistics.delivery.partial_allowed` | `delivery.partial_delivery_allowed` | Direct copy | Required |
| `sow.delivery.requested_date` | `delivery.requested_date` | ISO 8601 date | Required |
| `sow.delivery.schedule` | `delivery.delivery_schedule` | Array copy | Required |
| `appendix_c.delivery` | `delivery` | Object copy | Required |

#### Card 24: Customs Documentation

**Source Fields:**
```json
{
  "customs": {
    "export_documents": [
      {
        "type": "string (required)",
        "description": "string (required)",
        "required": "boolean (required)"
      }
    ],
    "import_documents": [
      {
        "type": "string (required)",
        "description": "string (required)",
        "required": "boolean (required)"
      }
    ],
    "licenses_required": [
      {
        "license_type": "string (required)",
        "issuing_authority": "string (required)",
        "validity_period": "string (required)"
      }
    ],
    "country_specific": {
      "destination_country": "string (required)",
      "special_requirements": "array[string] (optional)"
    }
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `customs.export_documents` | `customs.export_documents` | Array copy | Required |
| `customs.import_documents` | `customs.import_documents` | Array copy | Required |
| `customs.licenses` | `customs.licenses_required` | Array copy | Optional |
| `customs.country_requirements` | `customs.country_specific` | Object copy | Required |
| `logistics.customs.documents` | `customs.export_documents + import_documents` | Merged array | Required |
| `sow.customs_requirements` | `customs` | Object copy | Required |

---

### 2.5 Compliance Cards (25-28)

#### Card 25: Regulatory Compliance

**Source Fields:**
```json
{
  "regulatory": {
    "applicable_regulations": [
      {
        "regulation": "string (required)",
        "jurisdiction": "string (required)",
        "compliance_status": "enum: compliant | pending | non_compliant (required)",
        "compliance_date": "date (optional)"
      }
    ],
    "permits_required": [
      {
        "permit_type": "string (required)",
        "authority": "string (required)",
        "status": "enum: obtained | pending | not_required (required)"
      }
    ]
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `compliance.regulations` | `regulatory.applicable_regulations` | Array copy | Required |
| `compliance.permits` | `regulatory.permits_required` | Array copy | Required |
| `sow.compliance.regulations` | `regulatory.applicable_regulations` | Array copy | Required |
| `sow.compliance.permits` | `regulatory.permits_required` | Array copy | Required |

#### Card 26: Safety Requirements

**Source Fields:**
```json
{
  "safety": {
    "hazard_classification": "string (required)",
    "safety_data_sheet_required": "boolean (required)",
    "safety_data_sheet_provided": "boolean (optional)",
    "risk_assessment_required": "boolean (required)",
    "ppe_requirements": [
      {
        "item": "string (required)",
        "standard": "string (required)"
      }
    ],
    "emergency_procedures": "string (optional)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `compliance.safety.hazard_class` | `safety.hazard_classification` | Direct copy | Required |
| `compliance.safety.sds_required` | `safety.safety_data_sheet_required` | Direct copy | Required |
| `compliance.safety.sds_provided` | `safety.safety_data_sheet_provided` | Direct copy | Conditional |
| `compliance.safety.risk_assessment` | `safety.risk_assessment_required` | Direct copy | Required |
| `compliance.safety.ppe` | `safety.ppe_requirements` | Array copy | Optional |
| `compliance.safety.emergency` | `safety.emergency_procedures` | Direct copy | Optional |
| `sow.safety` | `safety` | Object copy | Required |
| `appendix_b.safety` | `safety` | Object copy | Required |

#### Card 27: Environmental Compliance

**Source Fields:**
```json
{
  "environmental": {
    "environmental_impact_assessment": "boolean (required)",
    "waste_management_plan": "boolean (required)",
    "emission_standards": [
      {
        "standard": "string (required)",
        "compliance_status": "enum: compliant | pending | non_compliant (required)"
      }
    ],
    "sustainability_requirements": [
      {
        "requirement": "string (required)",
        "target": "string (required)"
      }
    ]
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `compliance.environmental.impact_assessment` | `environmental.environmental_impact_assessment` | Direct copy | Required |
| `compliance.environmental.waste_management` | `environmental.waste_management_plan` | Direct copy | Required |
| `compliance.environmental.emissions` | `environmental.emission_standards` | Array copy | Required |
| `compliance.environmental.sustainability` | `environmental.sustainability_requirements` | Array copy | Optional |
| `sow.environmental` | `environmental` | Object copy | Required |

#### Card 28: Quality Assurance

**Source Fields:**
```json
{
  "quality": {
    "quality_management_system": "string (required)",
    "inspection_plan": {
      "type": "string (required)",
      "frequency": "string (required)",
      "criteria": "string (required)"
    },
    "testing_requirements": [
      {
        "test": "string (required)",
        "standard": "string (required)",
        "acceptance_criteria": "string (required)"
      }
    ],
    "quality_certifications": [
      {
        "certification": "string (required)",
        "standard": "string (required)",
        "valid_to": "date (required)"
      }
    ]
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `compliance.quality.management_system` | `quality.quality_management_system` | Direct copy | Required |
| `compliance.quality.inspection` | `quality.inspection_plan` | Object copy | Required |
| `compliance.quality.testing` | `quality.testing_requirements` | Array copy | Required |
| `compliance.quality.certifications` | `quality.quality_certifications` | Array copy | Required |
| `sow.quality` | `quality` | Object copy | Required |
| `appendix_b.quality` | `quality` | Object copy | Required |

---

### 2.6 Financial Cards (31-36)

#### Card 31: Payment Terms

**Source Fields:**
```json
{
  "payment": {
    "terms": "string (required)",
    "payment_schedule": [
      {
        "milestone": "string (required)",
        "percentage": "number (required)",
        "due_date": "date (required)",
        "conditions": "string (optional)"
      }
    ],
    "payment_method": "string (required)",
    "bank_details": {
      "bank_name": "string (required)",
      "account_name": "string (required)",
      "account_number": "string (required)",
      "swift_code": "string (optional)",
      "routing_number": "string (optional)"
    }
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.payment.terms` | `payment.terms` | Direct copy | Required |
| `sow.payment.schedule` | `payment.payment_schedule` | Array copy | Required |
| `sow.payment.method` | `payment.payment_method` | Direct copy | Required |
| `sow.payment.bank_details` | `payment.bank_details` | Object copy | Required |
| `finance.payment.terms` | `payment.terms` | Direct copy | Required |
| `finance.payment.schedule` | `payment.payment_schedule` | Array copy | Required |
| `appendix_f.payment` | `payment` | Object copy | Required |

#### Card 32: Pricing Breakdown

**Source Fields:**
```json
{
  "pricing": {
    "base_price": {
      "value": "number (required)",
      "currency": "string (required)"
    },
    "breakdown": [
      {
        "component": "string (required)",
        "description": "string (required)",
        "amount": "number (required)"
      }
    ],
    "taxes": [
      {
        "tax_type": "string (required)",
        "rate": "number (required)",
        "amount": "number (required)"
      }
    ],
    "total_price": {
      "value": "number (required)",
      "currency": "string (required)"
    }
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.pricing.base` | `pricing.base_price` | Object copy | Required |
| `sow.pricing.breakdown` | `pricing.breakdown` | Array copy | Required |
| `sow.pricing.taxes` | `pricing.taxes` | Array copy | Required |
| `sow.pricing.total` | `pricing.total_price` | Object copy | Required |
| `finance.pricing.base` | `pricing.base_price` | Object copy | Required |
| `finance.pricing.breakdown` | `pricing.breakdown` | Array copy | Required |
| `finance.pricing.taxes` | `pricing.taxes` | Array copy | Required |
| `finance.pricing.total` | `pricing.total_price` | Object copy | Required |
| `appendix_f.pricing` | `pricing` | Object copy | Required |

#### Card 33: Cost Allocation

**Source Fields:**
```json
{
  "cost_allocation": {
    "budget_codes": [
      {
        "code": "string (required)",
        "description": "string (required)",
        "amount": "number (required)",
        "percentage": "number (required)"
      }
    ],
    "cost_centers": [
      {
        "center": "string (required)",
        "amount": "number (required)"
      }
    ]
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `finance.cost_allocation.budget_codes` | `cost_allocation.budget_codes` | Array copy | Required |
| `finance.cost_allocation.cost_centers` | `cost_allocation.cost_centers` | Array copy | Required |
| `sow.cost_allocation` | `cost_allocation` | Object copy | Optional |

#### Card 34: Budget Codes

**Source Fields:**
```json
{
  "budget": {
    "project_budget": {
      "total": "number (required)",
      "currency": "string (required)",
      "fiscal_year": "string (required)"
    },
    "budget_lines": [
      {
        "line_code": "string (required)",
        "description": "string (required)",
        "allocated": "number (required)",
        "spent": "number (required)",
        "remaining": "number (required)"
      }
    ]
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `finance.budget.total` | `budget.project_budget.total` | Direct copy | Required |
| `finance.budget.currency` | `budget.project_budget.currency` | ISO 4217 code | Required |
| `finance.budget.fiscal_year` | `budget.project_budget.fiscal_year` | Direct copy | Required |
| `finance.budget.lines` | `budget.budget_lines` | Array copy | Required |
| `sow.budget` | `budget` | Object copy | Optional |

#### Card 35: Currency and Exchange

**Source Fields:**
```json
{
  "currency": {
    "base_currency": "string (required)",
    "transaction_currency": "string (required)",
    "exchange_rate": "number (required)",
    "exchange_rate_date": "date (required)",
    "exchange_rate_source": "string (required)"
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.currency.base` | `currency.base_currency` | ISO 4217 code | Required |
| `sow.currency.transaction` | `currency.transaction_currency` | ISO 4217 code | Required |
| `sow.currency.exchange_rate` | `currency.exchange_rate` | Direct copy | Required |
| `sow.currency.exchange_date` | `currency.exchange_rate_date` | ISO 8601 date | Required |
| `sow.currency.exchange_source` | `currency.exchange_rate_source` | Direct copy | Required |
| `finance.currency` | `currency` | Object copy | Required |
| `appendix_f.currency` | `currency` | Object copy | Required |

#### Card 36: Tax Information

**Source Fields:**
```json
{
  "tax": {
    "applicable_taxes": [
      {
        "tax_type": "string (required)",
        "rate": "number (required)",
        "amount": "number (required)",
        "jurisdiction": "string (required)"
      }
    ],
    "tax_exemptions": [
      {
        "exemption_type": "string (required)",
        "certificate_number": "string (required)",
        "valid_to": "date (required)"
      }
    ],
    "tax_registration": {
      "supplier_tax_id": "string (required)",
      "buyer_tax_id": "string (required)"
    }
  }
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.tax.applicable` | `tax.applicable_taxes` | Array copy | Required |
| `sow.tax.exemptions` | `tax.tax_exemptions` | Array copy | Optional |
| `sow.tax.registration` | `tax.tax_registration` | Object copy | Required |
| `finance.tax.applicable` | `tax.applicable_taxes` | Array copy | Required |
| `finance.tax.exemptions` | `tax.tax_exemptions` | Array copy | Optional |
| `finance.tax.registration` | `tax.tax_registration` | Object copy | Required |
| `appendix_f.tax` | `tax` | Object copy | Required |

---

### 2.7 Documentation Cards (37-43)

#### Card 37: Technical Documents

**Source Fields:**
```json
{
  "technical_documents": [
    {
      "document_id": "string (required)",
      "document_name": "string (required)",
      "document_type": "string (required)",
      "file_path": "string (required)",
      "file_size": "number (required)",
      "upload_date": "date (required)",
      "uploaded_by": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.documents.technical` | `technical_documents` | Array copy | Required |
| `logistics.documents.technical` | `technical_documents` | Array copy | Required |
| `compliance.documents.technical` | `technical_documents` | Array copy | Required |

#### Card 38: Drawings and Specifications

**Source Fields:**
```json
{
  "drawings": [
    {
      "drawing_id": "string (required)",
      "drawing_name": "string (required)",
      "drawing_type": "string (required)",
      "revision": "string (required)",
      "scale": "string (optional)",
      "file_path": "string (required)",
      "approval_status": "enum: approved | pending | rejected (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.documents.drawings` | `drawings` | Array copy | Required |
| `logistics.documents.drawings` | `drawings` | Array copy | Required |
| `appendix_a.drawings` | `drawings` | Array copy | Required |

#### Card 39: Certificates

**Source Fields:**
```json
{
  "certificates": [
    {
      "certificate_id": "string (required)",
      "certificate_type": "string (required)",
      "issuer": "string (required)",
      "issue_date": "date (required)",
      "expiry_date": "date (required)",
      "scope": "string (optional)",
      "file_path": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.certificates` | `certificates` | Array copy, validate dates | Required |
| `compliance.certificates` | `certificates` | Array copy, filter active | Required |
| `logistics.certificates` | `certificates` | Array copy, filter logistics-relevant | Required |

#### Card 40: Test Reports

**Source Fields:**
```json
{
  "test_reports": [
    {
      "report_id": "string (required)",
      "test_type": "string (required)",
      "test_date": "date (required)",
      "test_standard": "string (required)",
      "result": "enum: pass | fail | conditional (required)",
      "test_facility": "string (required)",
      "file_path": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.test_reports` | `test_reports` | Array copy | Required |
| `compliance.test_reports` | `test_reports` | Array copy, filter passed | Required |
| `quality.test_reports` | `test_reports` | Array copy | Required |

#### Card 41: Safety Data Sheets

**Source Fields:**
```json
{
  "safety_data_sheets": [
    {
      "sds_id": "string (required)",
      "product_name": "string (required)",
      "manufacturer": "string (required)",
      "issue_date": "date (required)",
      "revision": "string (required)",
      "hazard_classification": "string (required)",
      "file_path": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.safety_data_sheets` | `safety_data_sheets` | Array copy | Required |
| `compliance.safety_data_sheets` | `safety_data_sheets` | Array copy | Required |
| `logistics.safety_data_sheets` | `safety_data_sheets` | Array copy | Required |
| `appendix_b.safety_data_sheets` | `safety_data_sheets` | Array copy | Required |

#### Card 42: Operating Manuals

**Source Fields:**
```json
{
  "operating_manuals": [
    {
      "manual_id": "string (required)",
      "manual_name": "string (required)",
      "language": "string (required)",
      "version": "string (required)",
      "file_path": "string (required)",
      "file_size": "number (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.operating_manuals` | `operating_manuals` | Array copy | Required |
| `logistics.operating_manuals` | `operating_manuals` | Array copy | Required |
| `appendix_a.operating_manuals` | `operating_manuals` | Array copy | Required |

#### Card 43: Warranty Documents

**Source Fields:**
```json
{
  "warranty_documents": [
    {
      "warranty_id": "string (required)",
      "warranty_type": "string (required)",
      "coverage_period": "string (required)",
      "start_date": "date (required)",
      "end_date": "date (required)",
      "terms": "string (required)",
      "file_path": "string (required)"
    }
  ]
}
```

**Destination Mappings:**

| Destination Field | Source Field | Transformation | Validation |
|-------------------|--------------|----------------|------------|
| `sow.warranties` | `warranty_documents` | Array copy, validate dates | Required |
| `logistics.warranties` | `warranty_documents` | Array copy | Required |
| `appendix_a.warranties` | `warranty_documents` | Array copy | Required |

---

## 3. Transformation Rules

### 3.1 Data Type Transformations

| Source Type | Target Type | Transformation Function | Example |
|-------------|-------------|------------------------|---------|
| String | String | Trim, uppercase/lowercase | `" abc " → "ABC"` |
| String | Number | Parse float/int | `"123.45" → 123.45` |
| String | Date | ISO 8601 format | `"2026-03-08" → "2026-03-08T00:00:00Z"` |
| String | Boolean | Parse boolean | `"true" → true` |
| String | Enum | Validate against enum | `"manufacturer" → SupplierType.MANUFACTURER` |
| Number | String | Format with precision | `123.456 → "123.46"` |
| Date | String | ISO 8601 format | `Date → "2026-03-08T00:00:00Z"` |
| Array | Array | Map/Filter elements | `Filter active items` |
| Object | Object | Deep copy with mapping | `Nested object transformation` |

### 3.2 Field-Level Transformations

#### Country Code Transformation

```javascript
function transformCountryCode(countryCode) {
  // Validate ISO 3166-1 alpha-2 code
  const validCodes = ['ZA', 'GN', 'US', 'GB', 'DE', 'CN', 'IN', 'BR', ...];
  
  if (!validCodes.includes(countryCode)) {
    throw new ValidationError(`Invalid country code: ${countryCode}`);
  }
  
  return {
    iso_alpha2: countryCode,
    iso_alpha3: convertToAlpha3(countryCode),
    name: getCountryName(countryCode),
    numeric: getCountryNumeric(countryCode)
  };
}

// Example usage
const country = transformCountryCode('ZA');
// Output: { iso_alpha2: 'ZA', iso_alpha3: 'ZAF', name: 'South Africa', numeric: '710' }
```

#### Currency Transformation

```javascript
function transformCurrency(currencyCode) {
  // Validate ISO 4217 currency code
  const validCurrencies = ['ZAR', 'USD', 'EUR', 'GBP', 'CNY', 'INR', 'BRL', ...];
  
  if (!validCurrencies.includes(currencyCode)) {
    throw new ValidationError(`Invalid currency code: ${currencyCode}`);
  }
  
  return {
    code: currencyCode,
    name: getCurrencyName(currencyCode),
    symbol: getCurrencySymbol(currencyCode),
    decimal_places: getCurrencyDecimals(currencyCode)
  };
}

// Example usage
const currency = transformCurrency('ZAR');
// Output: { code: 'ZAR', name: 'South African Rand', symbol: 'R', decimal_places: 2 }
```

#### Date Transformation

```javascript
function transformDate(dateString, format = 'ISO8601') {
  const date = new Date(dateString);
  
  if (isNaN(date.getTime())) {
    throw new ValidationError(`Invalid date: ${dateString}`);
  }
  
  switch (format) {
    case 'ISO8601':
      return date.toISOString();
    case 'YYYY-MM-DD':
      return date.toISOString().split('T')[0];
    case 'DD/MM/YYYY':
      return date.toLocaleDateString('en-GB');
    default:
      return date.toISOString();
  }
}

// Example usage
const isoDate = transformDate('2026-03-08', 'ISO8601');
// Output: '2026-03-08T00:00:00.000Z'
```

#### Incoterms Transformation

```javascript
function transformIncoterms(incotermsCode) {
  // Validate Incoterms 2020 code
  const validIncoterms = ['EXW', 'FCA', 'FAS', 'FOB', 'CFR', 'CIF', 'CPT', 'CIP', 'DAP', 'DPU', 'DDP'];
  
  if (!validIncoterms.includes(incotermsCode)) {
    throw new ValidationError(`Invalid Incoterms code: ${incotermsCode}`);
  }
  
  return {
    code: incotermsCode,
    name: getIncotermName(incotermsCode),
    description: getIncotermDescription(incotermsCode),
    responsibility: getIncotermResponsibility(incotermsCode)
  };
}

// Example usage
const incoterm = transformIncoterms('FOB');
// Output: { code: 'FOB', name: 'Free On Board', description: '...', responsibility: {...} }
```

### 3.3 Object Transformations

#### Address Transformation

```javascript
function transformAddress(sourceAddress) {
  return {
    street: sourceAddress.street?.trim() || '',
    city: sourceAddress.city?.trim() || '',
    state_province: sourceAddress.state_province?.trim() || '',
    postal_code: sourceAddress.postal_code?.trim() || '',
    country: sourceAddress.country?.trim() || '',
    country_code: transformCountryCode(sourceAddress.country_code),
    coordinates: sourceAddress.coordinates ? {
      latitude: parseFloat(sourceAddress.coordinates.latitude),
      longitude: parseFloat(sourceAddress.coordinates.longitude)
    } : null
  };
}
```

#### Item Transformation

```javascript
function transformItem(sourceItem) {
  return {
    id: sourceItem.item_id,
    name: sourceItem.item_name,
    code: sourceItem.item_code,
    category: sourceItem.category,
    subcategory: sourceItem.subcategory,
    description: {
      summary: sourceItem.description,
      detailed: sourceItem.detailed_description,
      technical: sourceItem.technical_specifications
    },
    quantity: {
      value: parseFloat(sourceItem.quantity.value),
      unit: sourceItem.quantity.unit,
      tolerance: {
        plus: parseFloat(sourceItem.quantity.tolerance_plus || 0),
        minus: parseFloat(sourceItem.quantity.tolerance_minus || 0)
      }
    },
    pricing: {
      unit_price: parseFloat(sourceItem.pricing.unit_price),
      currency: transformCurrency(sourceItem.pricing.currency),
      total: parseFloat(sourceItem.pricing.total_price)
    },
    logistics: {
      weight: {
        gross: parseFloat(sourceItem.logistics.weight.gross),
        net: parseFloat(sourceItem.logistics.weight.net),
        unit: sourceItem.logistics.weight.unit
      },
      dimensions: {
        length: parseFloat(sourceItem.logistics.dimensions.length),
        width: parseFloat(sourceItem.logistics.dimensions.width),
        height: parseFloat(sourceItem.logistics.dimensions.height),
        unit: sourceItem.logistics.dimensions.unit
      }
    }
  };
}
```

---

## 4. Validation Rules

### 4.1 Field-Level Validation

| Field | Validation Type | Rule | Error Message |
|-------|-----------------|------|---------------|
| `project_id` | Required, Unique | Non-empty string, unique in system | "Project ID is required and must be unique" |
| `project_name` | Required, Length | Non-empty, max 200 characters | "Project name is required (max 200 characters)" |
| `project_code` | Required, Pattern | Format: PRJ-XXXX | "Project code must follow format PRJ-XXXX" |
| `email` | Required, Email | Valid email format | "Invalid email format" |
| `phone` | Optional, Phone | Valid phone format | "Invalid phone format" |
| `country_code` | Required, ISO | ISO 3166-1 alpha-2 | "Invalid country code" |
| `currency` | Required, ISO | ISO 4217 | "Invalid currency code" |
| `date` | Required, Date | ISO 8601 format | "Invalid date format" |
| `quantity` | Required, Number | Positive number | "Quantity must be a positive number" |
| `price` | Required, Number | Positive number, max 2 decimals | "Price must be a positive number with max 2 decimals" |

### 4.2 Cross-Field Validation

#### Date Range Validation

```javascript
function validateDateRange(startDate, endDate) {
  const start = new Date(startDate);
  const end = new Date(endDate);
  
  if (start >= end) {
    throw new ValidationError("End date must be after start date");
  }
  
  const maxDuration = 365 * 24 * 60 * 60 * 1000; // 1 year in milliseconds
  if (end - start > maxDuration) {
    throw new ValidationError("Project duration cannot exceed 1 year");
  }
  
  return true;
}
```

#### Quantity Tolerance Validation

```javascript
function validateQuantityTolerance(quantity, tolerancePlus, toleranceMinus) {
  if (tolerancePlus < 0 || toleranceMinus < 0) {
    throw new ValidationError("Tolerance values must be non-negative");
  }
  
  if (tolerancePlus > quantity * 0.5) {
    throw new ValidationError("Positive tolerance cannot exceed 50% of quantity");
  }
  
  if (toleranceMinus > quantity * 0.5) {
    throw new ValidationError("Negative tolerance cannot exceed 50% of quantity");
  }
  
  return true;
}
```

#### Price Validation

```javascript
function validatePricing(unitPrice, totalPrice, quantity) {
  const calculatedTotal = unitPrice * quantity;
  const tolerance = calculatedTotal * 0.01; // 1% tolerance
  
  if (Math.abs(totalPrice - calculatedTotal) > tolerance) {
    throw new ValidationError("Total price does not match unit price × quantity");
  }
  
  return true;
}
```

### 4.3 Business Rule Validation

#### Supplier Validation

```javascript
function validateSupplier(supplier) {
  // Required fields
  if (!supplier.supplier_id || !supplier.supplier_name) {
    throw new ValidationError("Supplier ID and name are required");
  }
  
  // Country validation
  if (!isValidCountryCode(supplier.country_of_origin)) {
    throw new ValidationError("Invalid supplier country of origin");
  }
  
  // Registration number validation
  if (!supplier.registration_number) {
    throw new ValidationError("Supplier registration number is required");
  }
  
  // Tax ID validation
  if (!supplier.tax_identification) {
    throw new ValidationError("Supplier tax identification is required");
  }
  
  return true;
}
```

#### Item Validation

```javascript
function validateItem(item) {
  // Required fields
  if (!item.item_id || !item.item_name || !item.item_code) {
    throw new ValidationError("Item ID, name, and code are required");
  }
  
  // Quantity validation
  if (item.quantity.value <= 0) {
    throw new ValidationError("Item quantity must be positive");
  }
  
  // Pricing validation
  if (item.pricing.unit_price <= 0) {
    throw new ValidationError("Item unit price must be positive");
  }
  
  // Weight validation (if hazardous)
  if (item.logistics.hazardous_material && !item.logistics.un_number) {
    throw new ValidationError("UN number required for hazardous materials");
  }
  
  return true;
}
``
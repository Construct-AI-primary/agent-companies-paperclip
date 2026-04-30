---
title: "Engineering Platform — Component Knowledge"
description: "Complete platform architecture, component inventory, and 8-field metadata for the cross-discipline engineering platform"
author: "DevForge AI / KnowledgeForge AI"
date: "2026-04-28"
version: "1.0"
memory_layer: "working_knowledge"
para_section: "engineering/projects/ENG-PLATFORM-000/knowledge"
---

# Engineering Platform — Component Knowledge

## Platform Overview

- **Platform ID**: `engineering-platform`
- **Disciplines**: 10 (00825, 00835, 00850, 00855, 00860, 00870, 00871, 00872, 01000, 03000)
- **File Path**: `client/src/shared/engineering/`
- **Background**: Discipline-specific engineering imagery
- **Navigation**: Fixed bottom center, accordion-style
- **CAD Integration**: Multi-system support (AutoCAD, Revit, Civil 3D, Plant 3D, Inventor, Fusion 360, Navisworks)

## 8-Field Metadata — Shared Components

### CADModelViewer

```json
{
  "page_id": "engineering-platform",
  "discipline": "all",
  "component": "CADModelViewer",
  "template_score": 0.90,
  "vector_store": "supabase_vectors/engineering/",
  "ui_buttons": {
    "id": "cad-model-viewer",
    "class": "engineering-component",
    "action": "loadModel(cadSystem, filePath)",
    "supported_formats": ["DWG", "DXF", "RVT", "RFA", "IPT", "IAM", "F3D", "NWD", "NWF"]
  },
  "supabase_schema": {
    "table": "a_engineering_models",
    "columns": ["id", "discipline_code", "model_name", "cad_system", "file_path", "geometry_data"],
    "indexes": ["idx_engineering_cad"]
  },
  "qc_checklist": [
    "3D model renders correctly",
    "Zoom/pan/rotate controls functional",
    "Model metadata displays",
    "Multiple CAD formats supported",
    "Loading indicator shows during load"
  ],
  "last_updated": "2026-04-28"
}
```

### EngineeringValidation

```json
{
  "page_id": "engineering-platform",
  "discipline": "all",
  "component": "EngineeringValidation",
  "template_score": 0.88,
  "vector_store": "supabase_vectors/engineering/",
  "ui_buttons": {
    "id": "engineering-validation",
    "class": "engineering-component",
    "action": "validateAgainstStandards(discipline, standards)",
    "validation_types": ["standards", "code-compliance", "design-rules"]
  },
  "supabase_schema": {
    "table": "a_engineering_models",
    "columns": ["validation_status", "compliance_errors", "standards_version"],
    "indexes": []
  },
  "qc_checklist": [
    "Validation rules apply per discipline",
    "Standards compliance checked automatically",
    "Error messages display with context",
    "Validation status persists to database",
    "Re-validation triggers on model update"
  ],
  "last_updated": "2026-04-28"
}
```

### StandardsSelector

```json
{
  "page_id": "engineering-platform",
  "discipline": "all",
  "component": "StandardsSelector",
  "template_score": 0.92,
  "vector_store": "supabase_vectors/engineering/",
  "ui_buttons": {
    "id": "standards-selector",
    "class": "engineering-component",
    "action": "selectStandards(discipline, jurisdiction)",
    "standards_by_discipline": {
      "00850": ["SANS-10160", "BS-8110", "ACI-318"],
      "00860": ["SANS-10142", "IEC-60364", "NECA"],
      "00870": ["ASHRAE", "SMACNA", "ASME"],
      "00872": ["SANS-10160", "ACI-318", "Eurocode"]
    }
  },
  "supabase_schema": null,
  "qc_checklist": [
    "Standards list loads based on discipline",
    "Jurisdictional filtering works",
    "Selection persists across sessions",
    "Version selection available",
    "Standards metadata displays"
  ],
  "last_updated": "2026-04-28"
}
```

### AnalysisResults

```json
{
  "page_id": "engineering-platform",
  "discipline": "00850,00860,00870,00872",
  "component": "AnalysisResults",
  "template_score": 0.85,
  "vector_store": "supabase_vectors/engineering/",
  "ui_buttons": {
    "id": "analysis-results",
    "class": "engineering-component",
    "action": "displayAnalysis(modelId, analysisType)",
    "analysis_types": ["fea", "thermal", "fluid", "power-flow", "hvac"]
  },
  "supabase_schema": {
    "table": "a_engineering_analysis",
    "columns": ["id", "model_id", "analysis_type", "results_data", "result_summary", "accuracy_metrics"],
    "indexes": ["idx_analysis_model", "idx_analysis_type"]
  },
  "qc_checklist": [
    "Results display in readable format",
    "Charts and graphs render correctly",
    "Export to PDF/Excel works",
    "Historical results accessible",
    "Comparison between runs available"
  ],
  "last_updated": "2026-04-28"
}
```

### EngineeringAuditTrail

```json
{
  "page_id": "engineering-platform",
  "discipline": "all",
  "component": "EngineeringAuditTrail",
  "template_score": 0.93,
  "vector_store": "supabase_vectors/engineering/",
  "ui_buttons": {
    "id": "audit-trail",
    "class": "engineering-component",
    "action": "displayAuditTrail(modelId)",
    "filter_types": ["all", "design-changes", "validation", "analysis"]
  },
  "supabase_schema": {
    "table": "a_engineering_models",
    "columns": ["created_by", "created_at", "updated_by", "updated_at"],
    "indexes": []
  },
  "qc_checklist": [
    "Audit entries display chronologically",
    "Filter by action type works",
    "User attribution is correct",
    "Export to PDF works",
    "Timestamp accuracy verified"
  ],
  "last_updated": "2026-04-28"
}
```

## Discipline Configuration Structure

### Civil Engineering (00850)

```json
{
  "discipline_code": "00850",
  "name": "Civil Engineering",
  "standards": ["SANS-10160", "BS-8110", "ACI-318"],
  "analysis_types": ["structural", "geotechnical", "hydraulic"],
  "cad_systems": ["civil3d", "autocad", "microstation"],
  "templates": ["foundation-design", "retaining-wall", "bridge-design"],
  "validation_rules": "civilValidationRules",
  "pilot_issue": "ENG-PLATFORM-012"
}
```

### Structural Engineering (00872)

```json
{
  "discipline_code": "00872",
  "name": "Structural Engineering",
  "standards": ["SANS-10160", "ACI-318", "Eurocode"],
  "analysis_types": ["fea", "steel", "concrete"],
  "cad_systems": ["revit", "autocad", "robot"],
  "templates": ["steel-connection", "concrete-mix", "foundation-design"],
  "validation_rules": "structuralValidationRules",
  "pilot_issue": "ENG-PLATFORM-013"
}
```

### MEP Engineering (00870/00860)

```json
{
  "discipline_code": "00870",
  "name": "Mechanical Engineering",
  "standards": ["ASHRAE", "SMACNA", "ASME"],
  "analysis_types": ["hvac", "plumbing", "fire-protection"],
  "cad_systems": ["inventor", "revit", "autocad"],
  "templates": ["hvac-system", "plumbing-layout", "fire-protection"],
  "validation_rules": "mechanicalValidationRules",
  "pilot_issue": "ENG-PLATFORM-014"
}
```

## Platform-Level QC Checklist

- [ ] 5 shared components render across all disciplines
- [ ] Discipline configuration loads per selected discipline
- [ ] CAD system selection persists
- [ ] Standards selector filters by jurisdiction
- [ ] Analysis results display for applicable disciplines
- [ ] Audit trail captures all design changes
- [ ] Validation runs automatically on model update
- [ ] Multi-CAD framework supports 7 systems
- [ ] Accordion navigation includes all 10 disciplines
- [ ] Routing system handles `/engineering?discipline=XXXXX`

## Related Documentation

| Document | Focus | Used In |
|----------|-------|---------|
| `shared-components.md` | Platform architecture | ENG-PLATFORM-001 |
| `discipline-configurations.md` | Discipline setup | ENG-PLATFORM-002 |
| `cad-integration-patterns.md` | CAD integration | ENG-PLATFORM-007 |
| `analysis-workflows.md` | Analysis procedures | ENG-PLATFORM-007 |
| `testing-procedures.md` | Testing approach | ENG-PLATFORM-015 |

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: DevForge AI / KnowledgeForge AI

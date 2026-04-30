---
title: "Engineering Platform — Complete Metadata Bundle"
description: "Single JSON bundle of all 8-field metadata for engineering platform components, ready for upload to root issue"
author: "KnowledgeForge AI"
date: "2026-04-28"
version: "1.0"
---

# Engineering Platform — Complete Metadata Bundle

## Bundle Summary

| Metric | Value |
|--------|-------|
| Total engineering disciplines | 10 (00825, 00835, 00850, 00855, 00860, 00870, 00871, 00872, 01000, 03000) |
| CAD/BIM systems supported | 7 (AutoCAD, Revit, Civil 3D, Plant 3D, Inventor, Fusion 360, Navisworks) |
| Platform components | 25 (5 shared components + 10 discipline configs + 10 adaptation docs) |
| Phases | 6 |
| Issues | 17 |
| Companies involved | 5 (DevForge, DomainForge, KnowledgeForge, IntegrateForge, QualityForge) |
| Agents assigned | 12 |
| Supabase tables | 2 (a_engineering_models, a_engineering_analysis) |
| Extraction date | 2026-04-28 |
| Upload target | ENG-PLATFORM-000 root issue Documents |

## Full Bundle Structure

```json
{
  "project": "ENG-PLATFORM-000",
  "discipline": "engineering-platform-cross-discipline",
  "extraction_date": "2026-04-28",
  "total_components": 25,
  "engineering_disciplines": [
    {
      "discipline_code": "00825",
      "name": "Architectural Engineering",
      "standards": ["IBC", "SANS-10400", "NFPA"],
      "cad_systems": ["revit", "autocad", "navisworks"],
      "analysis_types": ["energy", "lighting", "acoustics"],
      "pilot_status": "complete",
      "pilot_issue": "ENG-AUTO-010"
    },
    {
      "discipline_code": "00835",
      "name": "Chemical Engineering",
      "standards": ["ASME", "API", "IEC"],
      "cad_systems": ["autocad", "plant3d"],
      "analysis_types": ["process", "thermal", "fluid"],
      "pilot_status": "pending",
      "pilot_issue": null
    },
    {
      "discipline_code": "00850",
      "name": "Civil Engineering",
      "standards": ["SANS-10160", "BS-8110", "ACI-318"],
      "cad_systems": ["civil3d", "autocad", "microstation"],
      "analysis_types": ["structural", "geotechnical", "hydraulic"],
      "pilot_status": "planned",
      "pilot_issue": "ENG-PLATFORM-012"
    },
    {
      "discipline_code": "00855",
      "name": "Geotechnical Engineering",
      "standards": ["SANS-10146", "Eurocode 7"],
      "cad_systems": ["autocad", "civil3d"],
      "analysis_types": ["soil", "foundation", "slope"],
      "pilot_status": "pending",
      "pilot_issue": null
    },
    {
      "discipline_code": "00860",
      "name": "Electrical Engineering",
      "standards": ["SANS-10142", "IEC-60364", "NECA"],
      "cad_systems": ["autocad", "revit"],
      "analysis_types": ["power-flow", "short-circuit", "harmonic"],
      "pilot_status": "planned",
      "pilot_issue": "ENG-PLATFORM-014"
    },
    {
      "discipline_code": "00870",
      "name": "Mechanical Engineering",
      "standards": ["ASHRAE", "SMACNA", "ASME"],
      "cad_systems": ["inventor", "revit", "autocad"],
      "analysis_types": ["hvac", "plumbing", "fire-protection"],
      "pilot_status": "planned",
      "pilot_issue": "ENG-PLATFORM-014"
    },
    {
      "discipline_code": "00871",
      "name": "Process Engineering",
      "standards": ["ASME", "API", "ISO"],
      "cad_systems": ["plant3d", "autocad"],
      "analysis_types": ["process-flow", "equipment", "piping"],
      "pilot_status": "pending",
      "pilot_issue": null
    },
    {
      "discipline_code": "00872",
      "name": "Structural Engineering",
      "standards": ["SANS-10160", "ACI-318", "Eurocode"],
      "cad_systems": ["revit", "autocad", "robot"],
      "analysis_types": ["fea", "steel", "concrete"],
      "pilot_status": "planned",
      "pilot_issue": "ENG-PLATFORM-013"
    },
    {
      "discipline_code": "01000",
      "name": "Environmental Engineering",
      "standards": ["ISO-14001", "EIA regulations"],
      "cad_systems": ["autocad", "civil3d"],
      "analysis_types": ["impact", "wastewater", "air-quality"],
      "pilot_status": "pending",
      "pilot_issue": null
    },
    {
      "discipline_code": "03000",
      "name": "Landscaping Engineering",
      "standards": ["LEED", "SANS-10400"],
      "cad_systems": ["autocad", "civil3d"],
      "analysis_types": ["irrigation", "drainage", "planting"],
      "pilot_status": "pending",
      "pilot_issue": null
    }
  ],
  "shared_components": [
    {
      "component_id": "CADModelViewer",
      "file_path": "client/src/shared/engineering/components/CADModelViewer.js",
      "description": "3D model visualization interface",
      "disciplines": ["all"],
      "qc_checklist": [
        "Component renders 3D model",
        "Supports multiple CAD formats",
        "Zoom/pan/rotate controls work",
        "Model metadata displays"
      ]
    },
    {
      "component_id": "EngineeringValidation",
      "file_path": "client/src/shared/engineering/components/EngineeringValidation.js",
      "description": "Real-time engineering validation",
      "disciplines": ["all"],
      "qc_checklist": [
        "Validation rules apply per discipline",
        "Standards compliance checked",
        "Error messages display correctly",
        "Validation status persists"
      ]
    },
    {
      "component_id": "StandardsSelector",
      "file_path": "client/src/shared/engineering/components/StandardsSelector.js",
      "description": "Engineering standards selection",
      "disciplines": ["all"],
      "qc_checklist": [
        "Standards list loads per discipline",
        "Selection persists",
        "Jurisdictional filtering works",
        "Version selection available"
      ]
    },
    {
      "component_id": "AnalysisResults",
      "file_path": "client/src/shared/engineering/components/AnalysisResults.js",
      "description": "FEA/thermal/acoustic analysis display",
      "disciplines": ["00850", "00860", "00870", "00872"],
      "qc_checklist": [
        "Results display in readable format",
        "Charts/graphs render correctly",
        "Export functionality works",
        "Historical results accessible"
      ]
    },
    {
      "component_id": "EngineeringAuditTrail",
      "file_path": "client/src/shared/engineering/components/EngineeringAuditTrail.js",
      "description": "Engineering audit trail display",
      "disciplines": ["all"],
      "qc_checklist": [
        "Audit entries display chronologically",
        "Filter by action type works",
        "User attribution correct",
        "Export to PDF works"
      ]
    }
  ],
  "cad_systems": [
    {
      "system_id": "autocad",
      "name": "AutoCAD",
      "disciplines": ["00825", "00835", "00850", "00855", "00860", "00870", "00871", "00872", "01000", "03000"],
      "file_types": ["DWG", "DXF"],
      "integration_status": "planned"
    },
    {
      "system_id": "revit",
      "name": "Revit",
      "disciplines": ["00825", "00860", "00870", "00872"],
      "file_types": ["RVT", "RFA"],
      "integration_status": "planned"
    },
    {
      "system_id": "civil3d",
      "name": "Civil 3D",
      "disciplines": ["00850", "00855", "01000", "03000"],
      "file_types": ["DWG"],
      "integration_status": "planned"
    },
    {
      "system_id": "plant3d",
      "name": "Plant 3D",
      "disciplines": ["00835", "00871"],
      "file_types": ["DWG"],
      "integration_status": "planned"
    },
    {
      "system_id": "inventor",
      "name": "Inventor",
      "disciplines": ["00870"],
      "file_types": ["IPT", "IAM"],
      "integration_status": "planned"
    },
    {
      "system_id": "fusion360",
      "name": "Fusion 360",
      "disciplines": ["00870"],
      "file_types": ["F3D"],
      "integration_status": "planned"
    },
    {
      "system_id": "navisworks",
      "name": "Navisworks",
      "disciplines": ["00825", "00872"],
      "file_types": ["NWD", "NWF"],
      "integration_status": "planned"
    }
  ],
  "database_tables": [
    {
      "table": "a_engineering_models",
      "columns": ["id", "discipline_code", "project_id", "model_name", "model_type", "cad_system", "file_path", "version", "geometry_data", "material_properties", "load_conditions", "analysis_results", "standards_version", "validation_status", "compliance_errors", "created_by", "created_at", "updated_by", "updated_at", "related_models", "discipline_dependencies"],
      "indexes": ["idx_engineering_discipline", "idx_engineering_project", "idx_engineering_type", "idx_engineering_cad"]
    },
    {
      "table": "a_engineering_analysis",
      "columns": ["id", "model_id", "analysis_type", "analysis_engine", "status", "input_parameters", "boundary_conditions", "results_data", "result_summary", "convergence_status", "computation_time", "memory_usage", "accuracy_metrics", "created_at", "completed_at"],
      "indexes": ["idx_analysis_model", "idx_analysis_type", "idx_analysis_status"]
    }
  ],
  "summary": {
    "total_components": 25,
    "engineering_disciplines": 10,
    "cad_systems": 7,
    "shared_components": 5,
    "discipline_configs": 10,
    "phases": 6,
    "issues": 17,
    "companies_involved": 5,
    "agents_assigned": 12,
    "supabase_tables": 2,
    "extraction_date": "2026-04-28",
    "ready_for_platform": true
  }
}
```

## Upload Instructions

To make this knowledge available to all sub-agents:

1. Upload this bundle to the **ENG-PLATFORM-000** root issue's Documents tab
2. Document key: `"engineering-platform-metadata"`
3. All sub-agents inherit automatically via `parentId`
4. Agents query: `Documents.engineering-platform-metadata.disciplines` or `.cad_systems` or `.shared_components`

---

**Version**: 1.0
**Last Updated**: 2026-04-28
**Author**: KnowledgeForge AI

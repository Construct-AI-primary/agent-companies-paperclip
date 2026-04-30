#!/usr/bin/env python3
"""
UNIV-WORKFLOW Issue Batch Generation Script

Generates all remaining issues (UNIV-011 through UNIV-045) based on the
specifications in BATCH-IMPORT-READINESS.md and the template from
project-and-issue-generation-procedure.md.

Usage:
    python3 generate-remaining-issues.py

Output:
    Creates 18 issue files in the issues/ directory
"""

import os
from pathlib import Path

# Base directory
BASE_DIR = Path(__file__).parent.parent
ISSUES_DIR = BASE_DIR / "issues"

# Ensure issues directory exists
ISSUES_DIR.mkdir(exist_ok=True)

# Issue definitions from BATCH-IMPORT-READINESS.md
ISSUES = {
    # Phase 2: Regulatory Compliance (remaining 3)
    "UNIV-011": {
        "title": "Code Database Integration",
        "phase": "Phase 2 — Regulatory Compliance",
        "priority": "high",
        "company": "InfraForge AI",
        "agent": "database-infraforge",
        "supporting": "QualityForge AI (guardian-qualityforge)",
        "description": "Integrate regulatory code databases (IBC, NEC, OSHA, EPA) with compliance workflow template for automated requirement lookup and verification.",
        "context": "Compliance checking requires access to current building codes, electrical codes, safety regulations, and environmental standards. Integration must support multiple jurisdictions and automatic updates.",
        "objectives": [
            "Design database schema for regulatory codes and requirements",
            "Implement API integration with code databases",
            "Create automated code update mechanism",
            "Build lookup and query system for compliance verification",
            "Establish version control for code revisions"
        ],
        "acceptance_criteria": [
            "Database schema supports all major code types (building, electrical, safety, environmental)",
            "API integration operational for top 10 code databases",
            "Automated update mechanism runs weekly",
            "Lookup system returns accurate requirements in <2 seconds",
            "Version control tracks all code changes",
            "Integration tested with UNIV-010 compliance workflow",
            "Documentation complete for database maintenance"
        ],
        "blocked_by": ["UNIV-010"],
        "blocks": ["UNIV-012"],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["database-architecture", "api-integration", "regulatory-codes"],
        "target_files": [
            "packages/db/src/schema/regulatory_codes.ts",
            "server/src/services/regulatory-compliance/code-database.ts",
            "server/src/services/regulatory-compliance/code-lookup-api.ts",
            "docs-paperclip/disciplines/workflows/templates/regulatory-compliance/database-schema.md"
        ]
    },
    "UNIV-012": {
        "title": "Multi-Discipline Compliance Configuration",
        "phase": "Phase 2 — Regulatory Compliance",
        "priority": "medium",
        "company": "DomainForge AI",
        "agent": "architectural-domainforge",
        "supporting": "Multiple DomainForge agents for 8 disciplines",
        "description": "Configure compliance workflow for all 8 engineering disciplines with discipline-specific codes, regulations, and approval processes.",
        "context": "Each engineering discipline has unique regulatory requirements. Configuration must map appropriate codes to each discipline while maintaining workflow consistency.",
        "objectives": [
            "Map applicable codes to each of 8 disciplines",
            "Configure discipline-specific approval workflows",
            "Establish jurisdiction-based compliance requirements",
            "Create discipline-specific compliance checklists",
            "Document cross-discipline coordination requirements"
        ],
        "acceptance_criteria": [
            "All 8 disciplines have complete compliance configurations",
            "Code mappings validated by discipline experts (8/8)",
            "Approval workflows tested for each discipline",
            "Jurisdiction variations documented and supported",
            "Cross-discipline coordination points identified",
            "Configuration validation scripts operational",
            "Integration with code database (UNIV-011) successful"
        ],
        "blocked_by": ["UNIV-010", "UNIV-011"],
        "blocks": ["UNIV-013"],
        "complexity": "complex",
        "hours": "40-48",
        "timeline": "6-7 days",
        "skills": ["compliance-configuration", "multi-discipline-coordination"],
        "target_files": [
            "docs-paperclip/disciplines/00825_architectural/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00835_chemical-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00850_civil-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00860_electrical-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00855_geotechnical-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00870_mechanical-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00871_process-engineering/workflows/compliance-config.yaml",
            "docs-paperclip/disciplines/00872_structural/workflows/compliance-config.yaml"
        ]
    },
    "UNIV-013": {
        "title": "Compliance Workflow Deployment (5 disciplines)",
        "phase": "Phase 2 — Regulatory Compliance",
        "priority": "high",
        "company": "PaperclipForge AI",
        "agent": "issue-batch-importer-paperclipforge",
        "supporting": "QualityForge AI (guardian-qualityforge) for validation",
        "description": "Deploy regulatory compliance workflow to 5 pilot disciplines (Architectural, Civil, Electrical, Mechanical, Structural) for testing and validation.",
        "context": "Similar to specification development pilot (UNIV-004), validate compliance workflow with real projects before full rollout.",
        "objectives": [
            "Deploy compliance workflow to 5 pilot disciplines",
            "Execute real compliance projects in each discipline",
            "Collect performance metrics and user feedback",
            "Validate automated code checking accuracy",
            "Identify and resolve deployment issues"
        ],
        "acceptance_criteria": [
            "Compliance workflow deployed to all 5 pilot disciplines",
            "Minimum 2 compliance projects completed per discipline (10 total)",
            "Automated verification accuracy >90%",
            "User feedback collected from all disciplines",
            "Performance metrics meet targets (as defined in UNIV-010)",
            "Issues documented and prioritized",
            "Deployment report with recommendations generated"
        ],
        "blocked_by": ["UNIV-010", "UNIV-011", "UNIV-012"],
        "blocks": [],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["deployment", "quality-validation", "performance-analysis"],
        "target_files": [
            "docs-paperclip/disciplines/00825_architectural/projects/COMPLIANCE-PILOT/",
            "docs-paperclip/disciplines/00850_civil-engineering/projects/COMPLIANCE-PILOT/",
            "docs-paperclip/disciplines/00860_electrical-engineering/projects/COMPLIANCE-PILOT/",
            "docs-paperclip/disciplines/00870_mechanical-engineering/projects/COMPLIANCE-PILOT/",
            "docs-paperclip/disciplines/00872_structural/projects/COMPLIANCE-PILOT/",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/compliance-pilot-report.md"
        ]
    },
    
    # Phase 3: Construction Administration (4 issues)
    "UNIV-020": {
        "title": "Construction Administration Template Development",
        "phase": "Phase 3 — Construction Administration",
        "priority": "high",
        "company": "DevForge AI",
        "agent": "devcore-devforge",
        "supporting": "DomainForge AI (architectural-domainforge) for CA expertise",
        "description": "Create universal construction administration workflow template covering RFI management, submittal review, site observation, and change order processing.",
        "context": "Construction administration is the 3rd universal workflow. All disciplines require CA capabilities during construction phase.",
        "objectives": [
            "Design CA workflow structure (RFI, submittals, observations, changes)",
            "Create template for each CA activity type",
            "Build routing and escalation logic",
            "Establish documentation standards",
            "Ensure 85-90% reusability across disciplines"
        ],
        "acceptance_criteria": [
            "Complete CA workflow template with all activity types",
            "RFI response workflow with <48 hour target",
            "Submittal review workflow with approval tracking",
            "Site observation documentation templates",
            "Change order processing workflow",
            "Template tested with 3 discipline scenarios",
            "Reusability metric >85%"
        ],
        "blocked_by": [],
        "blocks": ["UNIV-021", "UNIV-022", "UNIV-023"],
        "complexity": "complex",
        "hours": "28-36",
        "timeline": "5-6 days",
        "skills": ["construction-administration", "workflow-design"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/templates/construction-administration/base-template.md",
            "docs-paperclip/disciplines/workflows/templates/construction-administration/rfi-workflow.yaml",
            "docs-paperclip/disciplines/workflows/templates/construction-administration/submittal-workflow.yaml",
            "docs-paperclip/procedures/workflows/construction-administration-procedure.md"
        ]
    },
    "UNIV-021": {
        "title": "RFI Response Workflow Automation",
        "phase": "Phase 3 — Construction Administration",
        "priority": "high",
        "company": "DevForge AI",
        "agent": "devcore-devforge",
        "supporting": "InfraForge AI (integration-infraforge) for system integration",
        "description": "Automate RFI (Request for Information) response workflow including routing, tracking, response drafting, and approval management.",
        "context": "RFI response time is critical for construction schedule. Automation must reduce response time from days to hours while maintaining quality.",
        "objectives": [
            "Implement automated RFI intake and routing",
            "Build intelligent priority classification",
            "Create response drafting assistance",
            "Establish approval workflow automation",
            "Integrate with project management systems"
        ],
        "acceptance_criteria": [
            "Automated RFI routing based on discipline and complexity",
            "Priority classification accuracy >85%",
            "Response drafting templates for common RFI types",
            "Approval workflow with escalation (24/48/72 hour targets)",
            "Integration with top 3 PM systems (Procore, PlanGrid, Autodesk)",
            "Average response time <48 hours",
            "Documentation and training materials complete"
        ],
        "blocked_by": ["UNIV-020"],
        "blocks": [],
        "complexity": "medium",
        "hours": "24-30",
        "timeline": "4-5 days",
        "skills": ["workflow-automation", "system-integration"],
        "target_files": [
            "server/src/services/construction-admin/rfi-router.ts",
            "server/src/services/construction-admin/rfi-priority-classifier.ts",
            "server/src/services/construction-admin/rfi-response-generator.ts",
            "packages/db/src/schema/construction_admin_rfis.ts"
        ]
    },
    "UNIV-022": {
        "title": "Submittal Review Integration",
        "phase": "Phase 3 — Construction Administration",
        "priority": "medium",
        "company": "InfraForge AI",
        "agent": "integration-infraforge",
        "supporting": "DomainForge AI (multiple disciplines) for review expertise",
        "description": "Integrate submittal review workflow with document management systems, automated compliance checking, and multi-discipline coordination.",
        "context": "Submittals require review by multiple disciplines and compliance verification. Integration streamlines coordination and reduces review cycles.",
        "objectives": [
            "Integrate with document management systems",
            "Automate compliance checking against specifications",
            "Enable multi-discipline review coordination",
            "Track submittal status and approvals",
            "Generate review reports and action items"
        ],
        "acceptance_criteria": [
            "Integration with major DMS platforms (3+)",
            "Automated compliance checking operational",
            "Multi-discipline review routing functional",
            "Status tracking dashboard created",
            "Review reports auto-generated",
            "Average review cycle time reduced by 30%",
            "Testing complete with real submittal scenarios"
        ],
        "blocked_by": ["UNIV-020"],
        "blocks": [],
        "complexity": "complex",
        "hours": "28-36",
        "timeline": "5-6 days",
        "skills": ["system-integration", "document-management"],
        "target_files": [
            "server/src/services/construction-admin/submittal-integration.ts",
            "server/src/services/construction-admin/submittal-compliance-checker.ts",
            "server/src/services/construction-admin/submittal-router.ts",
            "ui/src/components/construction-admin/SubmittalDashboard.tsx"
        ]
    },
    "UNIV-023": {
        "title": "CA Deployment and Validation",
        "phase": "Phase 3 — Construction Administration",
        "priority": "high",
        "company": "QualityForge AI",
        "agent": "guardian-qualityforge",
        "supporting": "DomainForge AI (multiple disciplines) for pilot execution",
        "description": "Deploy construction administration workflow to pilot disciplines, validate performance, and collect feedback for refinement.",
        "context": "Final validation of CA workflow before full rollout. Ensures all components work together in real construction scenarios.",
        "objectives": [
            "Deploy CA workflow to 3 pilot disciplines",
            "Execute real CA activities (RFIs, submittals, observations)",
            "Validate performance metrics and quality",
            "Collect stakeholder feedback",
            "Refine workflows based on pilot results"
        ],
        "acceptance_criteria": [
            "CA workflow deployed to 3 pilot disciplines",
            "Minimum 20 RFIs processed through automated workflow",
            "Minimum 15 submittals reviewed using integration",
            "Performance targets met (response time, review cycles)",
            "User satisfaction >4/5 from all stakeholders",
            "Issues identified and remediation plan created",
            "Deployment report with rollout recommendations"
        ],
        "blocked_by": ["UNIV-020", "UNIV-021", "UNIV-022"],
        "blocks": [],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["quality-validation", "deployment", "performance-analysis"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/ca-pilot-report.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/ca-performance-metrics.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/ca-feedback-analysis.md"
        ]
    },
    
    # Phase 4: Commissioning & Handover (4 issues)
    "UNIV-030": {
        "title": "Commissioning Workflow Template",
        "phase": "Phase 4 — Commissioning & Handover",
        "priority": "high",
        "company": "QualityForge AI",
        "agent": "validator-qualityforge",
        "supporting": "DomainForge AI (mechanical-engineering-domainforge) for commissioning expertise",
        "description": "Create universal commissioning workflow template covering testing, verification, documentation, and system handover processes.",
        "context": "Commissioning ensures installed systems meet design specifications. Template must support various system types across all disciplines.",
        "objectives": [
            "Design commissioning workflow structure",
            "Create testing protocol templates",
            "Build verification and acceptance workflows",
            "Establish documentation requirements",
            "Enable 80-90% reusability across system types"
        ],
        "acceptance_criteria": [
            "Complete commissioning workflow template",
            "Testing protocol templates for major system types",
            "Verification workflow with acceptance criteria",
            "Documentation automation for commissioning reports",
            "Template tested with 3 different system types",
            "Reusability metric >80%",
            "Integration with quality management systems"
        ],
        "blocked_by": [],
        "blocks": ["UNIV-031", "UNIV-032", "UNIV-033"],
        "complexity": "complex",
        "hours": "28-36",
        "timeline": "5-6 days",
        "skills": ["commissioning", "quality-validation", "testing-protocols"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/templates/commissioning/base-template.md",
            "docs-paperclip/disciplines/workflows/templates/commissioning/testing-protocols.yaml",
            "docs-paperclip/disciplines/workflows/templates/commissioning/verification-workflow.yaml",
            "docs-paperclip/procedures/workflows/commissioning-procedure.md"
        ]
    },
    "UNIV-031": {
        "title": "Documentation Automation System",
        "phase": "Phase 4 — Commissioning & Handover",
        "priority": "high",
        "company": "InfraForge AI",
        "agent": "database-infraforge",
        "supporting": "KnowledgeForge AI (doc-analyzer-knowledgeforge)",
        "description": "Automate generation of commissioning documentation, O&M manuals, as-built drawings compilation, and handover packages.",
        "context": "Handover documentation is time-consuming and error-prone. Automation must ensure completeness and accuracy while reducing manual effort.",
        "objectives": [
            "Implement automated commissioning report generation",
            "Create O&M manual compilation system",
            "Build as-built drawing package automation",
            "Establish handover checklist automation",
            "Integrate with document management systems"
        ],
        "acceptance_criteria": [
            "Automated commissioning report generation operational",
            "O&M manual compilation from multiple sources",
            "As-built drawing package creation automated",
            "Handover checklist auto-populated from project data",
            "DMS integration for all document types",
            "Documentation completeness validation >95%",
            "Time savings >60% vs manual documentation"
        ],
        "blocked_by": ["UNIV-030"],
        "blocks": [],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["document-automation", "system-integration"],
        "target_files": [
            "server/src/services/commissioning/report-generator.ts",
            "server/src/services/commissioning/om-manual-compiler.ts",
            "server/src/services/commissioning/as-built-packager.ts",
            "server/src/services/commissioning/handover-checklist.ts"
        ]
    },
    "UNIV-032": {
        "title": "Testing Protocol Templates",
        "phase": "Phase 4 — Commissioning & Handover",
        "priority": "medium",
        "company": "DomainForge AI",
        "agent": "mechanical-engineering-domainforge",
        "supporting": "Multiple DomainForge agents for discipline-specific protocols",
        "description": "Create comprehensive testing protocol templates for all major system types across engineering disciplines.",
        "context": "Testing protocols vary by system type and discipline. Templates must standardize approach while accommodating specific requirements.",
        "objectives": [
            "Create testing protocols for 15+ major system types",
            "Document discipline-specific testing requirements",
            "Establish pass/fail criteria and tolerances",
            "Build test result documentation templates",
            "Enable customization for project-specific needs"
        ],
        "acceptance_criteria": [
            "Testing protocols created for all major system types",
            "Protocols validated by discipline experts",
            "Pass/fail criteria clearly defined for each protocol",
            "Test result templates standardized",
            "Customization guidelines documented",
            "Protocols tested in pilot commissioning activities",
            "User feedback incorporated"
        ],
        "blocked_by": ["UNIV-030"],
        "blocks": [],
        "complexity": "medium",
        "hours": "24-32",
        "timeline": "4-5 days",
        "skills": ["testing-protocols", "discipline-expertise"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/templates/commissioning/protocols/hvac-testing.md",
            "docs-paperclip/disciplines/workflows/templates/commissioning/protocols/electrical-testing.md",
            "docs-paperclip/disciplines/workflows/templates/commissioning/protocols/plumbing-testing.md",
            "docs-paperclip/disciplines/workflows/templates/commissioning/protocols/fire-safety-testing.md",
            "docs-paperclip/disciplines/workflows/templates/commissioning/PROTOCOL-LIBRARY.md"
        ]
    },
    "UNIV-033": {
        "title": "Handover Process Activation",
        "phase": "Phase 4 — Commissioning & Handover",
        "priority": "high",
        "company": "QualityForge AI",
        "agent": "validator-qualityforge",
        "supporting": "DomainForge AI (multiple disciplines) for handover validation",
        "description": "Activate and validate complete handover process including commissioning, documentation, training, and acceptance.",
        "context": "Handover is the final project milestone. Process must ensure complete documentation, successful commissioning, and owner readiness.",
        "objectives": [
            "Execute complete handover process for pilot projects",
            "Validate commissioning workflow integration",
            "Verify documentation completeness",
            "Conduct owner training and acceptance",
            "Collect performance metrics and feedback"
        ],
        "acceptance_criteria": [
            "Handover process executed for 3 pilot projects",
            "All commissioning activities completed successfully",
            "Documentation packages validated 100% complete",
            "Owner training conducted and satisfaction >4.5/5",
            "Acceptance criteria met for all systems",
            "Handover timeline within target (±10%)",
            "Process improvement recommendations documented"
        ],
        "blocked_by": ["UNIV-030", "UNIV-031", "UNIV-032"],
        "blocks": [],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["quality-validation", "commissioning", "training"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/handover-pilot-report.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/commissioning-metrics.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/owner-acceptance-feedback.md"
        ]
    },
    
    # Phase 5: Safety & Finalization (6 issues)
    "UNIV-040": {
        "title": "Safety Management Template",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "high",
        "company": "QualityForge AI",
        "agent": "validator-qualityforge",
        "supporting": "DomainForge AI (safety-domainforge-safety-risk-management)",
        "description": "Create universal safety management workflow template covering hazard analysis, risk assessment, safety documentation, and compliance.",
        "context": "Safety is critical across all engineering disciplines. Template must support various safety frameworks (HAZOP, LOPA, PHA) while maintaining workflow consistency.",
        "objectives": [
            "Design safety management workflow structure",
            "Create hazard analysis templates (HAZOP, LOPA, PHA)",
            "Build risk assessment and mitigation workflows",
            "Establish safety documentation standards",
            "Ensure 90-95% reusability across disciplines"
        ],
        "acceptance_criteria": [
            "Complete safety management workflow template",
            "HAZOP, LOPA, and PHA templates created",
            "Risk assessment workflow with mitigation tracking",
            "Safety documentation automation implemented",
            "Template tested with 3 different safety scenarios",
            "Reusability metric >90%",
            "Integration with safety management systems"
        ],
        "blocked_by": [],
        "blocks": ["UNIV-041", "UNIV-042"],
        "complexity": "complex",
        "hours": "28-36",
        "timeline": "5-6 days",
        "skills": ["safety-management", "risk-assessment", "hazard-analysis"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/templates/safety/base-template.md",
            "docs-paperclip/disciplines/workflows/templates/safety/hazop-template.yaml",
            "docs-paperclip/disciplines/workflows/templates/safety/lopa-template.yaml",
            "docs-paperclip/procedures/workflows/safety-management-procedure.md"
        ]
    },
    "UNIV-041": {
        "title": "Hazard Analysis Templates (HAZOP, LOPA)",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "high",
        "company": "DevForge AI",
        "agent": "codesmith-devforge",
        "supporting": "DomainForge AI (safety-domainforge-safety-risk-management, process-engineering-domainforge)",
        "description": "Develop comprehensive hazard analysis templates for HAZOP (Hazard and Operability Study) and LOPA (Layer of Protection Analysis).",
        "context": "HAZOP and LOPA are industry-standard hazard analysis methods. Templates must support structured methodology while enabling automation where possible.",
        "objectives": [
            "Create HAZOP worksheet templates and workflows",
            "Develop LOPA analysis templates with risk matrices",
            "Build automated guide word generation for HAZOP",
            "Implement risk calculation and SIL determination",
            "Establish team collaboration features"
        ],
        "acceptance_criteria": [
            "HAZOP templates with complete guide word library",
            "LOPA templates with risk matrices and SIL calculation",
            "Automated guide word suggestion operational",
            "Risk calculation accuracy validated by safety experts",
            "Team collaboration features functional",
            "Templates tested with real hazard analysis scenarios",
            "User training materials created"
        ],
        "blocked_by": ["UNIV-040"],
        "blocks": [],
        "complexity": "complex",
        "hours": "32-40",
        "timeline": "5-6 days",
        "skills": ["safety-analysis", "process-safety", "risk-assessment"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/templates/safety/hazop/worksheet-template.md",
            "docs-paperclip/disciplines/workflows/templates/safety/lopa/analysis-template.md",
            "server/src/services/safety/hazop-guide-words.ts",
            "server/src/services/safety/lopa-risk-calculator.ts",
            "ui/src/components/safety/HazopWorksheet.tsx"
        ]
    },
    "UNIV-042": {
        "title": "Safety Documentation System",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "medium",
        "company": "KnowledgeForge AI",
        "agent": "doc-analyzer-knowledgeforge",
        "supporting": "DomainForge AI (safety-domainforge-safety-risk-management)",
        "description": "Implement automated safety documentation system for incident reports, safety data sheets, training records, and compliance reporting.",
        "context": "Safety documentation is regulatory requirement. Automation ensures completeness, accuracy, and timely submission while reducing administrative burden.",
        "objectives": [
            "Automate incident report generation and routing",
            "Create safety data sheet management system",
            "Build training record tracking and reporting",
            "Implement compliance reporting automation",
            "Integrate with regulatory reporting systems"
        ],
        "acceptance_criteria": [
            "Incident report automation operational",
            "SDS management system with search and retrieval",
            "Training record tracking with expiration alerts",
            "Compliance reports auto-generated",
            "Regulatory system integration functional",
            "Documentation completeness >95%",
            "Report generation time <5 minutes"
        ],
        "blocked_by": ["UNIV-040"],
        "blocks": [],
        "complexity": "medium",
        "hours": "24-32",
        "timeline": "4-5 days",
        "skills": ["documentation-automation", "compliance-reporting"],
        "target_files": [
            "server/src/services/safety/incident-reporter.ts",
            "server/src/services/safety/sds-manager.ts",
            "server/src/services/safety/training-tracker.ts",
            "server/src/services/safety/compliance-reporter.ts"
        ]
    },
    "UNIV-043": {
        "title": "Complete Rollout Optimization",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "critical",
        "company": "DevForge AI",
        "agent": "codesmith-devforge",
        "supporting": "KnowledgeForge AI (qa-strategy-knowledgeforge)",
        "description": "Optimize and finalize all 5 universal workflows for complete rollout to all 23 engineering and support disciplines.",
        "context": "Final optimization before full production deployment. Must ensure performance, scalability, and user experience meet production standards.",
        "objectives": [
            "Conduct performance optimization across all workflows",
            "Resolve all outstanding issues from pilot programs",
            "Implement scalability improvements",
            "Enhance user experience based on feedback",
            "Prepare production deployment plan"
        ],
        "acceptance_criteria": [
            "All 5 workflows optimized for production",
            "Performance benchmarks met (response time, throughput)",
            "All critical and high-priority issues resolved",
            "Scalability testing confirms 10x capacity headroom",
            "User experience improvements implemented",
            "Production deployment plan approved",
            "Rollback procedures documented and tested"
        ],
        "blocked_by": ["UNIV-040", "UNIV-041", "UNIV-042"],
        "blocks": ["UNIV-044", "UNIV-045"],
        "complexity": "complex",
        "hours": "40-48",
        "timeline": "6-7 days",
        "skills": ["performance-optimization", "scalability", "deployment-planning"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/optimization-report.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/performance-benchmarks.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/deployment/production-rollout-plan.md"
        ]
    },
    "UNIV-044": {
        "title": "Metrics Collection and Analysis",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "high",
        "company": "PaperclipForge AI",
        "agent": "assignment-specialist-paperclipforge",
        "supporting": "QualityForge AI (guardian-qualityforge)",
        "description": "Collect comprehensive metrics from all pilot programs and production rollout, analyze performance, and generate final project report.",
        "context": "Final metrics collection validates project success and ROI. Analysis informs future workflow development and expansion planning.",
        "objectives": [
            "Collect metrics from all 5 workflow pilots",
            "Analyze performance against baseline (UNIV-005)",
            "Calculate actual ROI and time savings",
            "Generate comprehensive project report",
            "Document lessons learned and recommendations"
        ],
        "acceptance_criteria": [
            "Complete metrics collected from all workflows",
            "Performance analysis shows target achievement",
            "ROI calculation demonstrates >150% return",
            "Time savings >40% vs manual processes",
            "Final project report comprehensive and actionable",
            "Lessons learned documented for future projects",
            "Stakeholder presentation materials created"
        ],
        "blocked_by": ["UNIV-043"],
        "blocks": ["UNIV-045"],
        "complexity": "medium",
        "hours": "20-28",
        "timeline": "4-5 days",
        "skills": ["data-analysis", "project-reporting", "roi-calculation"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/final-metrics-report.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/roi-analysis.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/lessons-learned.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/stakeholder-presentation.pptx"
        ]
    },
    "UNIV-045": {
        "title": "ROI Analysis and Expansion Planning",
        "phase": "Phase 5 — Safety & Finalization",
        "priority": "critical",
        "company": "PaperclipForge AI",
        "agent": "assignment-specialist-paperclipforge",
        "supporting": "DevForge AI (codesmith-devforge)",
        "description": "Conduct comprehensive ROI analysis and develop expansion plan for additional workflows and disciplines based on project success.",
        "context": "Project success enables expansion. ROI analysis justifies investment in additional universal workflows and broader discipline coverage.",
        "objectives": [
            "Calculate comprehensive project ROI",
            "Identify next-priority workflows for development",
            "Develop expansion plan for remaining disciplines",
            "Create business case for additional investment",
            "Present recommendations to stakeholders"
        ],
        "acceptance_criteria": [
            "Complete ROI analysis with detailed breakdown",
            "ROI exceeds 150% threshold",
            "Next 3 priority workflows identified with justification",
            "Expansion plan covers remaining 15 disciplines",
            "Business case approved by stakeholders",
            "Investment request submitted and approved",
            "Phase 2 project kickoff scheduled"
        ],
        "blocked_by": ["UNIV-043", "UNIV-044"],
        "blocks": [],
        "complexity": "medium",
        "hours": "20-28",
        "timeline": "4-5 days",
        "skills": ["roi-analysis", "strategic-planning", "business-case-development"],
        "target_files": [
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/comprehensive-roi-analysis.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/expansion-plan.md",
            "docs-paperclip/disciplines/workflows/projects/UNIV-WORKFLOW/reports/business-case.md",
            "docs-paperclip/plans/workflows/2026-06-01-workflow-expansion-phase-2-plan.md"
        ]
    }
}


def generate_issue_file(issue_id, issue_data):
    """Generate a single issue file from template"""
    
    # Build dependencies section
    dependencies = []
    if issue_data.get("blocked_by"):
        for blocker in issue_data["blocked_by"]:
            dependencies.append(f"- BLOCKED BY: [{blocker}] (Must complete {blocker} first)")
    if issue_data.get("blocks"):
        for blocked in issue_data["blocks"]:
            dependencies.append(f"- BLOCKS: [{blocked}] (This must complete before {blocked})")
    
    dependencies_text = "\n".join(dependencies) if dependencies else "- No dependencies"
    
    # Build target files section
    target_files = "\n  - ".join(issue_data.get("target_files", ["(To be determined)"]))
    
    # Build objectives section
    objectives = "\n- ".join(issue_data.get("objectives", ["(To be defined)"]))
    
    # Build acceptance criteria section
    acceptance_criteria = "\n- [ ] ".join(issue_data.get("acceptance_criteria", ["(To be defined)"]))
    
    # Build skills section
    skills = "\n- `".join([f"{skill}` (shared)" for skill in issue_data.get("skills", [])])
    
    content = f"""---
id: {issue_id}
title: {issue_data['title']}
phase: {issue_data['phase']}
status: open
priority: {issue_data['priority']}
---

# {issue_id}: {issue_data['title']}

## Description

{issue_data['description']}

**Context**: {issue_data['context']}

**Objectives**:
- {objectives}

**Scope**:
- In Scope: {issue_data['description'][:100]}...
- Out of Scope: Implementation details for other workflows

## Acceptance Criteria

- [ ] {acceptance_criteria}

## Assigned Company & Agent

- **Company:** {issue_data['company']}
- **Agent:** {issue_data['agent']}
- **Supporting:** {issue_data.get('supporting', 'N/A')}

## Working Directory & Repository

- **Local Repository:** `/Users/_Hermes/paperclip-render`
- **Working Directory:** `/Users/_Hermes/paperclip-render`
- **Target Files:**
  - {target_files}

## Required Skills

- `{skills}

## Dependencies

{dependencies_text}

## Estimated Effort

- **Complexity**: {issue_data['complexity']}
- **Estimated Hours**: {issue_data['hours']}
- **Timeline**: {issue_data['timeline']}

## Paperclip Task Schema

```yaml
company: {issue_data['company'].lower().replace(' ', '-')}
agent: {issue_data['agent']}
toolsets:
  - file_tools
  - code_execution
  - terminal_tools
max_iterations: 100
priority: {1 if issue_data['priority'] == 'critical' else 2 if issue_data['priority'] == 'high' else 3}
```

## Technical Notes

**Implementation Approach**:
{issue_data.get('context', 'See description for implementation context.')}

**Key Requirements**:
- Follow established patterns from previous workflows
- Ensure integration with existing systems
- Maintain consistency with universal workflow standards
- Document all customizations and configurations

## Success Validation

**How to verify completion**:
1. Review all acceptance criteria
2. Validate functionality with test scenarios
3. Collect feedback from stakeholders
4. Confirm integration with other workflows

**Expected Outcomes**:
- All acceptance criteria met
- Quality standards achieved
- Stakeholder approval received
- Ready for next workflow phase

---

**Created**: 2026-04-13
**Updated**: 2026-04-13
"""
    
    return content


def main():
    """Generate all remaining issues"""
    print("🚀 UNIV-WORKFLOW Issue Batch Generator")
    print("=" * 60)
    print(f"Generating {len(ISSUES)} issues...")
    print()
    
    success_count = 0
    error_count = 0
    
    for issue_id in sorted(ISSUES.keys()):
        issue_data = ISSUES[issue_id]
        filename = f"{issue_id}-{issue_data['title'].lower().replace(' ', '-').replace('(', '').replace(')', '').replace(',', '')[:50]}.md"
        filepath = ISSUES_DIR / filename
        
        try:
            content = generate_issue_file(issue_id, issue_data)
            with open(filepath, 'w') as f:
                f.write(content)
            print(f"✓ Created: {filename}")
            success_count += 1
        except Exception as e:
            print(f"✗ Error creating {filename}: {str(e)}")
            error_count += 1
    
    print()
    print("=" * 60)
    print(f"✅ Success: {success_count}/{len(ISSUES)} issues generated")
    if error_count > 0:
        print(f"❌ Errors: {error_count}")
    print()
    print("Next steps:")
    print("1. Review generated issues in issues/ directory")
    print("2. Update BATCH-IMPORT-READINESS.md status")
    print("3. Run validation: ./validate-issues.sh")
    print("4. Import to Paperclip using issue-batch-importer")


if __name__ == "__main__":
    main()
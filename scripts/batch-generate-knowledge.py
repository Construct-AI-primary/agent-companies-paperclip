#!/usr/bin/env python3
"""
Batch Knowledge Generation Script for Construct AI Disciplines

This script generates page knowledge for multiple disciplines in batch mode.
It reads the PAGE-KNOWLEDGE-CONFIG.json file and generates knowledge for all
configured disciplines that don't already have knowledge files.

Usage:
    python3 scripts/batch-generate-knowledge.py [--force] [--limit N]

Options:
    --force: Regenerate knowledge even if files already exist
    --limit N: Limit to N disciplines (for testing)
"""

import json
import os
import sys
import subprocess
from pathlib import Path
from typing import List, Dict, Any

def load_config(config_path: str) -> Dict[str, Any]:
    """Load the configuration file."""
    try:
        with open(config_path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Error: Configuration file not found: {config_path}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON in configuration file: {e}")
        sys.exit(1)

def get_existing_knowledge_files(base_path: str) -> List[str]:
    """Get list of disciplines that already have knowledge files."""
    knowledge_path = Path(base_path) / "docs-paperclip" / "disciplines"
    existing = []

    for discipline_dir in knowledge_path.iterdir():
        if discipline_dir.is_dir():
            knowledge_file = discipline_dir / "knowledge" / "PAGE-KNOWLEDGE.md"
            if knowledge_file.exists():
                # Extract discipline code from directory name (e.g., "00850-civil-engineering" -> "00850_civil_engineering")
                discipline_code = discipline_dir.name.replace('-', '_')
                existing.append(discipline_code)

    return existing

def discover_all_disciplines(base_path: str, include_non: bool = False) -> List[str]:
    """Discover all disciplines from construct-ai docs directory."""
    disciplines = []

    # Discover regular disciplines
    construct_ai_path = Path(base_path) / "docs-construct-ai" / "disciplines"
    if construct_ai_path.exists():
        for discipline_dir in construct_ai_path.iterdir():
            if discipline_dir.is_dir() and discipline_dir.name[0].isdigit():
                # Convert directory name to config format (e.g., "00850_civil-engineering" -> "00850_civil_engineering")
                discipline_code = discipline_dir.name.replace('-', '_')
                disciplines.append(discipline_code)

    # Discover disciplines-non if requested
    if include_non:
        disciplines_non_path = Path(base_path) / "docs-construct-ai" / "disciplines-non"
        if disciplines_non_path.exists():
            for discipline_dir in disciplines_non_path.iterdir():
                if discipline_dir.is_dir():
                    # For disciplines-non, use the directory name as-is but replace hyphens with underscores
                    discipline_code = discipline_dir.name.replace('-', '_')
                    disciplines.append(discipline_code)

    return sorted(disciplines)

def generate_discipline_config(discipline_code: str) -> Dict[str, Any]:
    """Generate configuration for a discipline based on its code and directory structure."""
    # Parse discipline code and name
    parts = discipline_code.split('_', 1)
    code = parts[0]
    name_slug = parts[1] if len(parts) > 1 else ""

    # Convert to readable names
    discipline_name = name_slug.replace('_', ' ').title() if name_slug else "General"
    agent_title = get_agent_title_from_code(code, name_slug)
    agent_slug = get_agent_slug_from_code(code, name_slug)

    # Generate basic configuration template
    config = {
        "DISCIPLINE_CODE": code,
        "DISCIPLINE_NAME": discipline_name,
        "discipline_name": name_slug.replace('_', ' ') if name_slug else "general",
        "discipline_slug": name_slug.replace('_', '-') if name_slug else "general",
        "AGENT_TITLE": agent_title,
        "AGENT_ROLE": name_slug.replace('_', ' ') if name_slug else "general",
        "agent_slug": agent_slug,
        "CURRENT_DATE": "2026-04-10",
        "page_primary_function": f"comprehensive {name_slug.replace('_', ' ')} management and operations",
        "primary_function": f"manage {name_slug.replace('_', ' ')} processes and workflows",
        "domain_entities": f"{name_slug.replace('_', ' ')} records and data",
        "number_of_states": "3",
        "STATE_1_NAME": "Agents",
        "state_1_purpose": "AI agent interactions and correspondence management",
        "BUTTON_1_NAME": "Correspondence Reply",
        "button_1_description": f"Modal for {name_slug.replace('_', ' ')} correspondence replies",
        "BUTTON_1_COMPONENT": "CorrespondenceReplyModal",
        "button_1_function": f"Handle {name_slug.replace('_', ' ')} communications and responses",
        "button_1_data_flow": f"Integrates with email system and {name_slug.replace('_', ' ')} database",
        "BUTTON_2_NAME": "Cloud Import",
        "button_2_description": "Cloud-based data import operations",
        "BUTTON_2_COMPONENT": "CloudImportModal",
        "button_2_function": f"Import {name_slug.replace('_', ' ')} data from cloud storage",
        "button_2_data_flow": f"Integrates with cloud storage APIs for {name_slug.replace('_', ' ')} documents",
        "STATE_2_NAME": "Upserts",
        "state_2_purpose": f"Data modification operations for {name_slug.replace('_', ' ')} data",
        "BUTTON_3_NAME": "Upsert Files",
        "button_3_description": "File-based data upsert operations",
        "BUTTON_3_COMPONENT": "FileUpsertModal",
        "button_3_function": f"Upload and process {name_slug.replace('_', ' ')} data files",
        "button_3_data_flow": f"Parse and validate {name_slug.replace('_', ' ')} data for database insertion",
        "STATE_3_NAME": "Workspace",
        "state_3_purpose": f"Workspace management and {name_slug.replace('_', ' ')} tools",
        "BUTTON_4_NAME": "Data Manager",
        "button_4_description": f"Data management tools for {name_slug.replace('_', ' ')}",
        "BUTTON_4_COMPONENT": "DataManagerModal",
        "button_4_function": f"Manage {name_slug.replace('_', ' ')} data and configurations",
        "button_4_data_flow": f"CRUD operations for {name_slug.replace('_', ' ')} entities",
        "PRIMARY_TABLE_1_NAME": f"{discipline_name} Records",
        "primary_table_1_id": f"{name_slug}_records",
        "primary_table_1_pk": f"{name_slug}_id",
        "primary_table_1_purpose": f"Track all {name_slug.replace('_', ' ')} records and their lifecycle",
        "col_1_name": f"{name_slug}_id",
        "col_1_type": "VARCHAR(20)",
        "col_1_description": f"Unique {name_slug.replace('_', ' ')} identifier",
        "col_1_validation": f"Format: {code.upper()}-{{YYYY}}-{{NNNNN}}",
        "col_2_name": "status",
        "col_2_type": "ENUM",
        "col_2_description": "Record status",
        "col_2_validation": "Values: draft, active, completed, cancelled",
        "col_3_name": "description",
        "col_3_type": "TEXT",
        "col_3_description": "Record description",
        "col_3_validation": "Required, max 1000 characters",
        "PRIMARY_TABLE_2_NAME": "Details",
        "primary_table_2_id": f"{name_slug}_details",
        "primary_table_2_pk": "detail_id",
        "primary_table_2_purpose": f"Maintain {name_slug.replace('_', ' ')} details and specifications",
        "col_4_name": "name",
        "col_4_type": "VARCHAR(255)",
        "col_4_description": "Detail name",
        "col_4_validation": "Required, unique within record",
        "col_5_name": "value",
        "col_5_type": "TEXT",
        "col_5_description": "Detail value",
        "col_5_validation": "Required",
        "WORKFLOW_TABLE_1_NAME": "Approvals",
        "workflow_table_1_purpose": f"Manage approval processes for {name_slug.replace('_', ' ')} records",
        "wf_col_1": "approval_id",
        "wf_col_1_type": "INTEGER",
        "wf_col_1_description": "Primary key",
        "wf_col_2": "status",
        "wf_col_2_type": "ENUM",
        "wf_col_2_description": "Values: pending, approved, rejected",
        "PRIMARY_WORKFLOW_1_NAME": f"{discipline_name} Creation",
        "primary_workflow_1_id": f"{name_slug}_creation_workflow",
        "workflow_1_trigger": f"New {name_slug.replace('_', ' ')} record initiated",
        "workflow_1_purpose": f"Guide record creation through complete {name_slug.replace('_', ' ')} process",
        "STEP_1_NAME": "Information Gathering",
        "STEP_1_COMPONENT": "InfoModal",
        "step_1_action": "Collect required information and specifications",
        "step_1_validation": "All mandatory fields completed",
        "step_1_data_source": "User input and system defaults",
        "STEP_2_NAME": "Validation",
        "STEP_2_COMPONENT": "ValidationModal",
        "step_2_action": "Validate information and check requirements",
        "step_2_validation": "All validations pass",
        "step_2_data_source": "Business rules and requirements",
        "STEP_3_NAME": "Approval",
        "step_3_action": "Submit for approval and processing",
        "step_3_integration": "Email notifications and approval routing",
        "step_3_data_source": "Creates approval records and notifications",
        "PRIMARY_WORKFLOW_2_NAME": f"{discipline_name} Processing",
        "primary_workflow_2_id": f"{name_slug}_processing_workflow",
        "workflow_2_trigger": f"{discipline_name} record approved",
        "workflow_2_purpose": f"Process approved {name_slug.replace('_', ' ')} records",
        "STEP_4_NAME": "Assignment",
        "STEP_4_MODAL": "AssignmentModal",
        "step_4_fields": "Assign to responsible party and set priorities",
        "step_4_validation": "Valid assignment and priority",
        "STEP_5_NAME": "Execution",
        "STEP_5_COMPONENT": "ExecutionModal",
        "step_5_action": "Execute the approved process",
        "step_5_data_source": "Process workflows and procedures",
        "PRIMARY_MODAL_1_NAME": f"{discipline_name} Creation",
        "PRIMARY_MODAL_1_ID": f"{discipline_name.replace(' ', '')}CreationModal",
        "PRIMARY_MODAL_1_TRIGGER": "New Record",
        "primary_modal_1_purpose": f"Create new {name_slug.replace('_', ' ')} records",
        "SECTION_1_NAME": "Basic Information",
        "field_1_label": "Record ID",
        "field_1_input_type": f"Auto-generated: {code.upper()}-2026-00001",
        "field_2_label": "Description",
        "field_2_input_type": "Text area with validation",
        "SECTION_2_NAME": "Details",
        "table_col_1": "Field",
        "table_col_2": "Value",
        "table_col_3": "Required",
        "input_1": "Text",
        "input_2": "Select",
        "input_3": "Checkbox",
        "PRIMARY_MODAL_2_NAME": f"{discipline_name} Details",
        "PRIMARY_MODAL_2_ID": f"{discipline_name.replace(' ', '')}DetailsModal",
        "PRIMARY_MODAL_2_TRIGGER": "View Details",
        "primary_modal_2_purpose": f"View and edit {name_slug.replace('_', ' ')} record details",
        "ELEMENT_1_NAME": "Record Information",
        "element_1_label": "Status",
        "element_1_type": "Status badge",
        "element_1_feature": "color-coded",
        "ELEMENT_2_NAME": "Actions",
        "result_col_1": "Action",
        "result_col_2": "Available",
        "result_col_3": "Permission",
        "result_1": "Edit",
        "result_2": "Yes/No",
        "result_3": "Role-based",
        "INTEGRATION_SYSTEM_1": "Document Management",
        "integration_1_system": "Document storage and retrieval system",
        "integration_1_purpose": f"Store and retrieve {name_slug.replace('_', ' ')} documents and attachments",
        "integration_1_point_1": "Document Upload",
        "integration_1_point_1_desc": f"Upload {name_slug.replace('_', ' ')} related documents",
        "integration_1_point_2": "Document Access",
        "integration_1_point_2_desc": "Retrieve documents for record processing",
        "integration_1_endpoint_1": f"/api/{name_slug}/documents/upload",
        "integration_1_endpoint_2": f"/api/{name_slug}/documents/get",
        "INTEGRATION_SYSTEM_2": "Email Integration",
        "integration_2_system": "Email notification system",
        "integration_2_purpose": f"Send notifications for {name_slug.replace('_', ' ')} record updates",
        "integration_2_point_1": "Status Updates",
        "integration_2_point_1_desc": f"Notify stakeholders of {name_slug.replace('_', ' ')} status changes",
        "integration_2_point_2": "Approval Requests",
        "integration_2_point_2_desc": "Send approval requests to designated approvers",
        "integration_2_endpoint_1": f"/api/{name_slug}/email/status-update",
        "integration_2_endpoint_2": f"/api/{name_slug}/email/approval-request",
        "state_values": "agents, upserts, workspace",
        "DisciplineName": discipline_name,
        "PRIMARY_ENTITY_NAME": f"{discipline_name} Record",
        "primary_entity_camel": f"{name_slug}Record",
        "field_1_camel": f"{name_slug}Id",
        "field_1_error_message": "Record ID is required",
        "field_2_camel": "description",
        "field_2_rule": "required",
        "field_2_value": "true",
        "field_2_error_message": "Description is required",
        "ERROR_1_CONDITION": "Record Not Found",
        "ERROR_1_MESSAGE": f"{discipline_name} record not found. Please check the record ID.",
        "ERROR_2_CONDITION": "Validation Failed",
        "ERROR_2_MESSAGE": "Record validation failed. Please check all required fields.",
        "primary_entity_plural": f"{name_slug.replace('_', ' ')} records",
        "workflow_name": "approval",
        "search_fields": f"{name_slug.replace('_', ' ')} names and descriptions",
        "fuzzy_match_fields": "record details",
        "filter_categories": f"{name_slug.replace('_', ' ')} records",
        "filter_1": "status",
        "filter_1_option_1": "draft",
        "filter_1_option_2": "active",
        "filter_2": "created_date",
        "filter_2_type": "date range",
        "filter_3": "priority",
        "filter_3_type": "select",
        "filter_4": "assigned_to",
        "filter_4_type": "user select",
        "COMPLIANCE_TYPE_1": "Data Management",
        "compliance_1_requirement_1": "Proper data classification and handling",
        "compliance_1_requirement_2": "Audit trail maintenance",
        "COMPLIANCE_TYPE_2": "Access Control",
        "compliance_2_requirement_1": "Role-based access permissions",
        "compliance_2_requirement_2": "Data privacy compliance",
        "integration_system": "Document Management",
        "workflow_1_name": "record creation",
        "approval_process": "approval",
        "entity_1": "Record",
        "process_1": "processing",
        "api_endpoint_1": f"/api/{name_slug}/records",
        "api_method_1": "GET",
        "api_purpose_1": f"List {name_slug.replace('_', ' ')} records",
        "api_response_1": "Array of record objects",
        "api_endpoint_2": f"/api/{name_slug}/details",
        "api_method_2": "GET",
        "api_purpose_2": f"Get {name_slug.replace('_', ' ')} record details",
        "api_response_2": "Record detail object",
        "ABBREV_1": code[:4].upper(),
        "ABBREV_1_FULL": discipline_name,
        "ABBREV_2": "REC",
        "ABBREV_2_FULL": "Record",
        "NUMBER_FORMAT": f"{code.upper()}-{{YYYY}}-{{NNNNN}}",
        "format_component_1": "YYYY",
        "format_desc_1": "4-digit year",
        "format_component_2": "NNNNN",
        "format_desc_2": "5-digit sequential number (padded with zeros)",
        "example_1": f"{code.upper()}-2026-00001",
        "example_1_desc": f"First {name_slug.replace('_', ' ')} record of 2026",
        "example_2": f"{code.upper()}-2026-01234",
        "example_2_desc": f"1234th {name_slug.replace('_', ' ')} record of 2026",
        "button_1_position": "Bottom center of viewport",
        "button_1_css": "position: fixed; left: 50%; bottom: 10px; transform: translateX(-50%)",
        "button_1_visual_ref": "Navigation row horizontal layout",
        "button_1_test_status": "✅ Validated",
        "button_2_position": "Modal grid layout",
        "button_2_css": "CSS Grid with dynamic columns",
        "button_2_visual_ref": "Centered modal overlay",
        "button_2_test_status": "✅ Validated",
        "button_3_position": "Modal grid layout",
        "button_3_css": "CSS Grid with dynamic columns",
        "button_3_visual_ref": "Centered modal overlay",
        "button_3_test_status": "✅ Validated",
        "GRID_CONTAINER_ID": f"A-{code}-button-container",
        "GRID_TEMPLATE_COLUMNS": "repeat(auto-fit, minmax(200px, 1fr))",
        "GRID_GAP": "20px",
        "MOBILE_GRID_COLUMNS": "1",
        "TABLET_GRID_COLUMNS": "2",
        "DESKTOP_GRID_COLUMNS": "3-4",
        "PRIMARY_BACKGROUND_COLOR": "Orange theme",
        "PRIMARY_BACKGROUND_HEX": "#FF8C00",
        "PRIMARY_TEXT_COLOR": "Dark text",
        "PRIMARY_TEXT_HEX": "#333333",
        "PRIMARY_ACCENT_COLOR": "Orange accent",
        "PRIMARY_ACCENT_HEX": "#FFA500",
        "H1_FONT_SIZE": "2rem",
        "H1_LINE_HEIGHT": "1.2",
        "H1_FONT_WEIGHT": "bold",
        "BODY_FONT_SIZE": "1rem",
        "BODY_LINE_HEIGHT": "1.5",
        "BODY_FONT_WEIGHT": "normal",
        "BUTTON_FONT_SIZE": "1rem",
        "BUTTON_LINE_HEIGHT": "1.2",
        "BUTTON_FONT_WEIGHT": "medium",
        "BUTTON_STANDARD_WIDTH": "120px",
        "BUTTON_STANDARD_HEIGHT": "40px",
        "BUTTON_LARGE_WIDTH": "160px",
        "BUTTON_LARGE_HEIGHT": "55px",
        "BUTTON_SMALL_WIDTH": "80px",
        "BUTTON_SMALL_HEIGHT": "32px",
        "MODAL_STANDARD_WIDTH": "600px",
        "MODAL_STANDARD_HEIGHT": "auto",
        "MODAL_LARGE_WIDTH": "800px",
        "MODAL_LARGE_HEIGHT": "auto",
        "VISUAL_BASELINE_PAGE_LOAD": f"{name_slug}-baseline-page-load.png",
        "VISUAL_BASELINE_BUTTON_STATES": f"{name_slug}-baseline-button-states.png",
        "VISUAL_BASELINE_MODALS": f"{name_slug}-baseline-modals.png",
        "VISUAL_BASELINE_FORMS": f"{name_slug}-baseline-forms.png",
        "BUTTON_1_ID": f"{name_slug}-correspondence-btn",
        "BUTTON_1_EXPECTED_LEFT": "50%",
        "POSITION_TOLERANCE": "2",
        "BUTTON_1_EXPECTED_TOP": "10px",
        "ARIA_COVERAGE_PERCENTAGE": "95",
        "SEMANTIC_SCORE": "90",
        "POSITION_TOLERANCE": "2",
        "FCP_TARGET": "2000",
        "LCP_TARGET": "3000",
        "CLS_TARGET": "0.1",
        "BUTTON_RESPONSE_TARGET": "100",
        "MODAL_OPEN_TARGET": "300",
        "workflow_1_implementation_status": "active",
        "workflow_1_implementation_notes": "Fully implemented with approval workflow integration",
        "workflow_2_implementation_status": "active",
        "workflow_2_implementation_notes": "Record processing with automated validation",
        "workflow_1_status": "active",
        "workflow_1_version": "2.1.3",
        "workflow_1_last_updated": "2026-03-15",
        "workflow_1_known_issues": f"'ISSUE-001: Race condition in {name_slug} approval routing'",
        "workflow_1_avg_time": "450",
        "workflow_1_success_rate": "94.2",
        "workflow_1_error_rate": "2.1",
        "workflow_1_p50_time": "380",
        "workflow_1_p95_time": "720",
        "workflow_1_p99_time": "1200",
        "validation_error_rate": "1.8",
        "system_error_rate": "0.3",
        "timeout_error_rate": "0.2",
        "workflow_1_rpm": "25",
        "workflow_1_concurrent_max": "5",
        "fix_version": "2.2.0"
    }

    return config

def get_agent_title_from_code(code: str, name_slug: str) -> str:
    """Determine agent title based on discipline code."""
    code_prefix = code[:4]

    # Engineering disciplines
    if code_prefix in ['0082', '0083', '0084', '0085', '0086', '0087', '0088']:
        if 'director' in name_slug:
            return "Director"
        elif 'manager' in name_slug:
            return "Manager"
        else:
            return "Engineer"

    # Business disciplines
    elif code_prefix in ['0025', '0030', '0040', '0120', '0170', '0175', '0190']:
        if 'director' in name_slug:
            return "Director"
        else:
            return "Specialist"

    # Quality and safety
    elif code_prefix in ['0220', '0225', '0240']:
        return "Inspector"

    # Default
    else:
        return "Specialist"

def get_agent_slug_from_code(code: str, name_slug: str) -> str:
    """Determine agent slug based on discipline code."""
    # Extract meaningful parts from name_slug
    if name_slug:
        # Take first meaningful word or combine key parts
        parts = name_slug.split('_')
        if len(parts) >= 2:
            return f"{parts[0]}-{parts[1]}"
        else:
            return parts[0]

    # Fallback based on code
    return f"specialist-{code[:4]}"

def generate_knowledge_for_discipline(discipline_code: str, force: bool = False) -> bool:
    """Generate knowledge for a single discipline."""
    try:
        print(f"Generating knowledge for {discipline_code}...")

        # Check if knowledge already exists
        if not force:
            knowledge_path = f"docs-paperclip/disciplines/{discipline_code.replace('_', '-')}/knowledge/PAGE-KNOWLEDGE.md"
            if os.path.exists(knowledge_path):
                print(f"  Skipping {discipline_code} - knowledge already exists")
                return True

        # Generate configuration for this discipline
        config = generate_discipline_config(discipline_code)

        # Create temporary config file at the expected location
        config_path = "docs-paperclip/disciplines/PAGE-KNOWLEDGE-CONFIG.json"
        backup_config = None

        # Backup existing config if it exists
        if os.path.exists(config_path):
            with open(config_path, 'r') as f:
                backup_config = f.read()

        # Write our temporary config
        with open(config_path, 'w') as f:
            json.dump({"disciplines": {discipline_code: config}}, f, indent=2)

        try:
            # Run the generation script
            result = subprocess.run([
                sys.executable,
                "scripts/generate-page-knowledge.py",
                discipline_code
            ], capture_output=True, text=True, cwd=os.getcwd())

            if result.returncode == 0:
                print(f"  ✅ Successfully generated knowledge for {discipline_code}")
                return True
            else:
                print(f"  ❌ Failed to generate knowledge for {discipline_code}")
                print(f"     Error: {result.stderr}")
                return False
        finally:
            # Restore original config or remove temp config
            if backup_config is not None:
                with open(config_path, 'w') as f:
                    f.write(backup_config)
            else:
                if os.path.exists(config_path):
                    os.remove(config_path)

    except Exception as e:
        print(f"  ❌ Error generating knowledge for {discipline_code}: {e}")
        return False

def main():
    """Main batch generation function."""
    import argparse

    parser = argparse.ArgumentParser(description="Batch generate knowledge for Construct AI disciplines")
    parser.add_argument("--force", action="store_true", help="Regenerate knowledge even if files already exist")
    parser.add_argument("--limit", type=int, help="Limit number of disciplines to process")
    parser.add_argument("--disciplines", nargs="+", help="Specific disciplines to process")
    parser.add_argument("--auto-discover", action="store_true", help="Auto-discover all disciplines from construct-ai docs")
    parser.add_argument("--include-non", action="store_true", help="Include disciplines-non (system operations) in discovery")
    parser.add_argument("--config", help="Path to configuration file (default: PAGE-KNOWLEDGE-CONFIG.json)")

    args = parser.parse_args()

    # Auto-discover disciplines from construct-ai docs
    if args.auto_discover:
        available_disciplines = discover_all_disciplines(".", args.include_non)
        if args.include_non:
            print(f"Auto-discovered {len(available_disciplines)} disciplines from construct-ai docs (including disciplines-non)")
        else:
            print(f"Auto-discovered {len(available_disciplines)} disciplines from construct-ai docs")
    else:
        # Load configuration
        config_path = args.config or "docs-paperclip/disciplines/PAGE-KNOWLEDGE-CONFIG.json"
        config = load_config(config_path)

        # Get available disciplines from config
        available_disciplines = list(config.get("disciplines", {}).keys())

        if not available_disciplines:
            print("Error: No disciplines found in configuration. Use --auto-discover to find all disciplines automatically.")
            sys.exit(1)

        print(f"Found {len(available_disciplines)} disciplines in configuration")

    # Filter disciplines if specific ones requested
    if args.disciplines:
        disciplines_to_process = [d for d in args.disciplines if d in available_disciplines]
        if len(disciplines_to_process) != len(args.disciplines):
            missing = [d for d in args.disciplines if d not in available_disciplines]
            print(f"Warning: Some requested disciplines not found: {missing}")
    else:
        disciplines_to_process = available_disciplines

    # Apply limit if specified
    if args.limit:
        disciplines_to_process = disciplines_to_process[:args.limit]

    print(f"Will process {len(disciplines_to_process)} disciplines")

    # Get existing knowledge files
    existing_knowledge = get_existing_knowledge_files(".")
    print(f"Found {len(existing_knowledge)} disciplines with existing knowledge")

    # Filter out disciplines that already have knowledge (unless force is used)
    if not args.force:
        original_count = len(disciplines_to_process)
        disciplines_to_process = [d for d in disciplines_to_process if d not in existing_knowledge]
        skipped_count = original_count - len(disciplines_to_process)
        if skipped_count > 0:
            print(f"Skipped {skipped_count} disciplines with existing knowledge (use --force to regenerate)")

    if not disciplines_to_process:
        print("No disciplines to process")
        return

    print(f"\n🚀 Starting batch generation for {len(disciplines_to_process)} disciplines...")
    print("=" * 60)

    # Process disciplines
    successful = 0
    failed = 0

    for i, discipline in enumerate(disciplines_to_process, 1):
        print(f"\n[{i}/{len(disciplines_to_process)}] Processing {discipline}")
        if generate_knowledge_for_discipline(discipline, args.force):
            successful += 1
        else:
            failed += 1

    # Summary
    print("\n" + "=" * 60)
    print("📊 BATCH GENERATION COMPLETE")
    print("=" * 60)
    print(f"Total disciplines processed: {len(disciplines_to_process)}")
    print(f"Successful: {successful}")
    print(f"Failed: {failed}")

    if failed > 0:
        print(f"\n⚠️  {failed} disciplines failed to generate. Check the output above for details.")
        sys.exit(1)
    else:
        print("\n🎉 All disciplines processed successfully!")

if __name__ == "__main__":
    main()
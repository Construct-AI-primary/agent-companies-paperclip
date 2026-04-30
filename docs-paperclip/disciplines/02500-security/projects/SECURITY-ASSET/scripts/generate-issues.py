#!/usr/bin/env python3
"""
SECURITY-ASSET Issue Generator

Generates Paperclip issues for the SECURITY-ASSET project following the discipline automation workflow.
This script creates both desktop and mobile issues based on the workflows list.

Usage:
    python generate-issues.py --platform desktop --count 8
    python generate-issues.py --platform mobile --count 7
    python generate-issues.py --all
"""

import os
import sys
import argparse
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional

# Issue templates for desktop platform
DESKTOP_ISSUES = [
    {
        "id": "DESKTOP-SEC-001",
        "title": "GPS Tracking Dashboard",
        "description": "Create a comprehensive GPS tracking dashboard for monitoring construction equipment locations in real-time with interactive map visualization, asset status indicators, and geofence breach alerts",
        "priority": "High",
        "estimated_hours": 24,
        "agent": "interface-devforge",
        "platform_notes": "Full-screen map visualization with multiple asset markers, Real-time location updates with WebSocket integration, Advanced filtering and search capabilities, Export functionality for reports, Multi-monitor support for security operations centers",
        "acceptance_criteria": [
            "Interactive map with OpenStreetMap/Google Maps integration",
            "Real-time asset location markers with status colors",
            "Geofence visualization with breach indicators",
            "Asset filtering by type, status, and location",
            "Location history playback with timeline slider",
            "Export to CSV/PDF functionality",
            "Responsive layout for various screen sizes",
            "Performance optimized for 100+ assets"
        ]
    },
    {
        "id": "DESKTOP-SEC-002",
        "title": "Geofence Management System",
        "description": "Build a geofence management system for creating, editing, and monitoring virtual boundaries around construction sites, equipment storage areas, and restricted zones with automated breach detection",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "codesmith-devforge",
        "platform_notes": "Map-based geofence drawing tools, Bulk geofence configuration, Scheduled geofence activation/deactivation, Integration with asset assignment rules",
        "acceptance_criteria": [
            "Create circular, rectangular, and polygon geofences",
            "Assign assets to specific geofences",
            "Configure breach alert rules and thresholds",
            "Schedule geofence active periods",
            "View geofence breach history and statistics",
            "Bulk operations for multiple geofences",
            "Geofence overlap detection and warnings"
        ]
    },
    {
        "id": "DESKTOP-SEC-003",
        "title": "Asset Location History & Reporting",
        "description": "Implement asset location history tracking with comprehensive reporting, route visualization, stoppage detection, and compliance documentation for audit trails",
        "priority": "Medium",
        "estimated_hours": 16,
        "agent": "devcore-devforge",
        "platform_notes": "Historical route playback with animation, Advanced filtering by date range and events, Custom report generation, PDF/CSV export for compliance",
        "acceptance_criteria": [
            "Historical location data storage and retrieval",
            "Route visualization with timestamps",
            "Stoppage detection and duration tracking",
            "Speed analysis and alerts",
            "Custom report templates",
            "Scheduled report generation",
            "Export to multiple formats",
            "Data retention policy management"
        ]
    },
    {
        "id": "DESKTOP-SEC-004",
        "title": "Equipment Immobilization Controls",
        "description": "Build secure equipment immobilization controls for remote engine shutdown, fuel cut-off, and wheel lock activation with multi-level authorization and safety interlocks",
        "priority": "High",
        "estimated_hours": 28,
        "agent": "codesmith-devforge",
        "platform_notes": "Secure admin-only access controls, Audit logging for all commands, Multi-factor authorization for critical actions, Emergency override procedures",
        "acceptance_criteria": [
            "Remote engine shutdown command interface",
            "Fuel system cut-off controls",
            "Wheel lock activation/deactivation",
            "Multi-level authorization workflow",
            "Command confirmation and rollback",
            "Safety interlock validation",
            "Complete audit trail for all commands",
            "Emergency override with escalation"
        ]
    },
    {
        "id": "DESKTOP-SEC-005",
        "title": "Alert Configuration & Management",
        "description": "Create a comprehensive alert configuration system for setting up theft detection rules, notification channels, escalation workflows, and alert response procedures",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "interface-devforge",
        "platform_notes": "Rule-based alert configuration, Multi-channel notification setup, Escalation workflow designer, Alert analytics and trends",
        "acceptance_criteria": [
            "Alert rule creation and management",
            "Multiple notification channel configuration",
            "Escalation workflow setup",
            "Alert priority and severity classification",
            "Alert response templates",
            "Alert analytics dashboard",
            "Integration with incident management",
            "Alert suppression rules"
        ]
    },
    {
        "id": "DESKTOP-SEC-006",
        "title": "Inventory Management Interface",
        "description": "Build a comprehensive inventory management interface for asset registration, barcode/QR code scanning integration, RFID tracking, and automated reconciliation workflows",
        "priority": "High",
        "estimated_hours": 24,
        "agent": "devcore-devforge",
        "platform_notes": "Bulk asset import/export, Barcode scanner integration, RFID reader configuration, Reconciliation reports",
        "acceptance_criteria": [
            "Asset registration and tagging interface",
            "Barcode/QR code scanning integration",
            "RFID reader configuration and management",
            "Automated inventory reconciliation",
            "Asset check-in/check-out workflows",
            "Inventory discrepancy reports",
            "Stock level alerts",
            "Integration with procurement systems"
        ]
    },
    {
        "id": "DESKTOP-SEC-007",
        "title": "Incident Reporting & Investigation",
        "description": "Implement a comprehensive incident reporting and investigation system for documenting security incidents, managing evidence, tracking corrective actions, and generating compliance reports",
        "priority": "Medium-High",
        "estimated_hours": 20,
        "agent": "interface-devforge",
        "platform_notes": "Evidence attachment and management, Investigation workflow designer, Corrective action tracking, Compliance report generation",
        "acceptance_criteria": [
            "Incident documentation with templates",
            "Evidence collection and attachment",
            "Investigation workflow management",
            "Corrective action planning and tracking",
            "Incident classification and categorization",
            "Investigation timeline visualization",
            "Compliance reporting",
            "Integration with law enforcement procedures"
        ]
    },
    {
        "id": "DESKTOP-SEC-008",
        "title": "Security Analytics Dashboard",
        "description": "Create a comprehensive security analytics dashboard with KPI visualization, incident trend analysis, asset protection metrics, and executive reporting capabilities",
        "priority": "Medium",
        "estimated_hours": 24,
        "agent": "devcore-devforge",
        "platform_notes": "Interactive charts and graphs, Customizable dashboard widgets, Scheduled report delivery, Executive summary views",
        "acceptance_criteria": [
            "KPI dashboard with customizable widgets",
            "Incident trend visualization",
            "Asset protection metrics",
            "Response time analytics",
            "Cost-benefit analysis",
            "Executive report generation",
            "Scheduled report delivery",
            "Benchmark comparison tools"
        ]
    }
]

# Issue templates for mobile platform
MOBILE_ISSUES = [
    {
        "id": "MOBILE-SEC-002",
        "title": "GPS Tracking Mobile Interface",
        "description": "Create a mobile GPS tracking interface for field security personnel to monitor asset locations, view geofence status, and receive real-time breach alerts on mobile devices",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "codesmith-devforge",
        "platform_notes": "Touch-friendly map interface, Offline map caching for remote sites, Push notification for alerts, Battery-optimized location updates",
        "acceptance_criteria": [
            "Mobile-optimized map view with asset markers",
            "Real-time location updates with push notifications",
            "Geofence status indicators",
            "Quick asset search and filtering",
            "Offline mode with data sync",
            "Touch-friendly controls (44px minimum targets)",
            "Performance on mobile networks",
            "Battery optimization for field use"
        ]
    },
    {
        "id": "MOBILE-SEC-003",
        "title": "Alert Response Mobile Interface",
        "description": "Build a mobile alert response interface for security personnel to receive, view, acknowledge, and respond to security alerts in the field with location-aware actions",
        "priority": "High",
        "estimated_hours": 16,
        "agent": "interface-devforge",
        "platform_notes": "Quick action buttons for common responses, Voice-guided alert response, Camera integration for evidence capture, GPS-tagged response actions",
        "acceptance_criteria": [
            "Push notification with alert details",
            "Quick acknowledge/dismiss actions",
            "Alert response with notes and photos",
            "Location-tagged response actions",
            "Voice note attachment",
            "Camera integration for evidence",
            "Offline alert queue with sync",
            "Response time tracking"
        ]
    },
    {
        "id": "MOBILE-SEC-004",
        "title": "Inventory Scanning Mobile Interface",
        "description": "Create a mobile inventory scanning interface for field personnel to scan barcodes, QR codes, and RFID tags for asset verification, check-in/check-out, and reconciliation",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "devcore-devforge",
        "platform_notes": "Camera-based barcode/QR scanning, NFC/RFID reader integration, Offline scanning with sync, Quick asset lookup",
        "acceptance_criteria": [
            "Camera-based barcode/QR scanning",
            "NFC RFID tag reading",
            "Asset verification and lookup",
            "Check-in/check-out workflows",
            "Offline scanning with queue",
            "Photo capture for asset condition",
            "GPS-tagged scan locations",
            "Sync when online"
        ]
    },
    {
        "id": "MOBILE-SEC-005",
        "title": "Patrol Management Mobile Interface",
        "description": "Build a mobile patrol management interface for security guards to view assigned routes, check in at checkpoints, report incidents, and track patrol progress",
        "priority": "Medium",
        "estimated_hours": 18,
        "agent": "interface-devforge",
        "platform_notes": "Route visualization with checkpoints, QR code checkpoint verification, Voice-guided patrol instructions, One-handed operation design",
        "acceptance_criteria": [
            "Patrol route display with map",
            "Checkpoint check-in via QR scan",
            "GPS-verified checkpoint validation",
            "Incident reporting during patrol",
            "Route progress tracking",
            "Voice-guided navigation",
            "Offline route access",
            "Battery-efficient operation"
        ]
    },
    {
        "id": "MOBILE-SEC-006",
        "title": "Incident Reporting Mobile Interface",
        "description": "Create a mobile incident reporting interface for field personnel to quickly document and report security incidents with photos, voice notes, and location data",
        "priority": "Medium-High",
        "estimated_hours": 16,
        "agent": "devcore-devforge",
        "platform_notes": "Quick incident capture, Voice-to-text for descriptions, Multi-photo attachment, Offline incident queue",
        "acceptance_criteria": [
            "Quick incident creation form",
            "Voice-to-text description input",
            "Multi-photo capture and attachment",
            "GPS-tagged incident location",
            "Witness information capture",
            "Offline incident storage",
            "Auto-sync when online",
            "Incident template shortcuts"
        ]
    },
    {
        "id": "MOBILE-SEC-007",
        "title": "Surveillance Viewing Mobile Interface",
        "description": "Build a mobile surveillance viewing interface for security personnel to access live camera feeds, view recorded footage, and receive motion detection alerts on mobile devices",
        "priority": "Medium",
        "estimated_hours": 16,
        "agent": "codesmith-devforge",
        "platform_notes": "Adaptive video streaming, Low-bandwidth mode, Push notifications for alerts, Portrait and landscape support",
        "acceptance_criteria": [
            "Live camera feed viewing",
            "Recorded footage playback",
            "Motion detection alerts",
            "Camera selection and grouping",
            "Low-bandwidth streaming mode",
            "Screenshot capture",
            "Video clip download",
            "Offline alert queue"
        ]
    },
    {
        "id": "MOBILE-SEC-008",
        "title": "Security Dashboard Mobile Interface",
        "description": "Create a mobile security dashboard for supervisors to monitor security status, view key metrics, and access quick actions for security operations management",
        "priority": "Medium",
        "estimated_hours": 14,
        "agent": "devcore-devforge",
        "platform_notes": "Widget-based dashboard, Quick action shortcuts, Pull-to-refresh data, Dark mode support",
        "acceptance_criteria": [
            "Security status overview widgets",
            "Key metric display",
            "Quick action shortcuts",
            "Alert summary view",
            "Asset status summary",
            "Pull-to-refresh data",
            "Dark mode support",
            "Widget customization"
        ]
    }
]


def generate_issue_content(issue: Dict, platform: str) -> str:
    """Generate markdown content for an issue."""
    timestamp = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.000000+00:00")
    
    acceptance_criteria_md = "\n".join([
        f"- {criteria}" for criteria in issue["acceptance_criteria"]
    ])
    
    platform_notes_md = "\n".join([
        f"- {note}" for note in issue["platform_notes"].split(", ")
    ])
    
    content = f"""# [{platform.capitalize()}] {issue['title']}

**Issue ID:** {issue['id']}-{issue['title'].lower().replace(' ', '-').replace('&', 'and').replace('/', '-')}
**Priority:** {issue['priority']}
**Estimated Hours:** {issue['estimated_hours']}
**Assigned Company:** devforge-ai
**Assigned Agent:** {issue['agent']}
**Generated:** {timestamp}

## Description

{issue['description']}

**{platform.capitalize()} Platform Notes:**
{platform_notes_md}

## Acceptance Criteria

{acceptance_criteria_md}

## Status

- [ ] To Do
- [ ] In Progress
- [ ] In Review
- [ ] Done

## Notes

_Add implementation notes, blockers, and resolution details here._
"""
    return content


def generate_issues(platform: str, output_dir: Path, count: Optional[int] = None) -> List[str]:
    """Generate issues for the specified platform."""
    issues = DESKTOP_ISSUES if platform == "desktop" else MOBILE_ISSUES
    
    if count:
        issues = issues[:count]
    
    generated_files = []
    
    for issue in issues:
        # Convert title to filename-safe format
        safe_title = issue['title'].lower().replace(' ', '-').replace('&', 'and').replace('/', '-')
        filename = f"{issue['id']}-{safe_title}.md"
        filepath = output_dir / filename
        
        content = generate_issue_content(issue, platform)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        
        generated_files.append(str(filepath))
        print(f"Generated: {filepath}")
    
    return generated_files


def main():
    parser = argparse.ArgumentParser(
        description="Generate Paperclip issues for SECURITY-ASSET project"
    )
    parser.add_argument(
        "--platform",
        choices=["desktop", "mobile", "all"],
        default="all",
        help="Platform to generate issues for"
    )
    parser.add_argument(
        "--count",
        type=int,
        help="Maximum number of issues to generate per platform"
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="Output directory for generated issues"
    )
    
    args = parser.parse_args()
    
    # Determine output directory
    if args.output_dir:
        base_dir = args.output_dir
    else:
        # Default to project directory
        script_dir = Path(__file__).parent
        base_dir = script_dir.parent
    
    desktop_dir = base_dir / "desktop" / "issues"
    mobile_dir = base_dir / "mobile" / "issues"
    
    # Create directories if they don't exist
    desktop_dir.mkdir(parents=True, exist_ok=True)
    mobile_dir.mkdir(parents=True, exist_ok=True)
    
    total_generated = []
    
    if args.platform in ["desktop", "all"]:
        print(f"\nGenerating desktop issues...")
        desktop_files = generate_issues("desktop", desktop_dir, args.count)
        total_generated.extend(desktop_files)
    
    if args.platform in ["mobile", "all"]:
        print(f"\nGenerating mobile issues...")
        mobile_files = generate_issues("mobile", mobile_dir, args.count)
        total_generated.extend(mobile_files)
    
    print(f"\n✅ Generated {len(total_generated)} issues total")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())

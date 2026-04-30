#!/usr/bin/env python3
"""
PROC-BUDGET Issue Generator

Generates Paperclip issues for the PROC-BUDGET project following the discipline automation workflow.
This script creates desktop, mobile, and web issues based on the workflows list.

Usage:
    python generate-issues.py --platform desktop --count 8
    python generate-issues.py --platform mobile --count 6
    python generate-issues.py --platform web --count 6
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
        "id": "DESKTOP-BUD-001",
        "title": "Budget Planning Dashboard",
        "description": "Create a comprehensive budget planning dashboard for managing budget allocations, approvals, and hierarchies across construction projects",
        "priority": "High",
        "estimated_hours": 24,
        "agent": "interface-devforge",
        "platform_notes": "Full-screen budget overview with hierarchical visualization, Budget approval workflow integration, Multi-project budget comparison, Export functionality for reports",
        "acceptance_criteria": [
            "Interactive budget hierarchy visualization",
            "Budget creation and editing interface",
            "Multi-level approval workflow integration",
            "Budget version history tracking",
            "Budget vs allocation comparison",
            "Export to CSV/PDF functionality",
            "Responsive layout for various screen sizes",
            "Performance optimized for large datasets"
        ]
    },
    {
        "id": "DESKTOP-BUD-002",
        "title": "Spend Monitoring Dashboard",
        "description": "Build a real-time spend monitoring dashboard for tracking actual expenditures against budget allocations with live updates",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "codesmith-devforge",
        "platform_notes": "Real-time spend visualization, Budget vs actual comparison charts, Spend categorization views, Filter and drill-down capabilities",
        "acceptance_criteria": [
            "Real-time spend data visualization",
            "Budget vs actual comparison charts",
            "Spend categorization by project and category",
            "Filter and drill-down capabilities",
            "Spend trend analysis",
            "Multi-currency support",
            "Performance optimized for real-time updates",
            "Export functionality for reports"
        ]
    },
    {
        "id": "DESKTOP-BUD-003",
        "title": "Variance Analysis Tools",
        "description": "Implement comprehensive variance analysis tools for identifying budget deviations, root cause analysis, and corrective action tracking",
        "priority": "High",
        "estimated_hours": 24,
        "agent": "devcore-devforge",
        "platform_notes": "Variance calculation engine, Root cause analysis workflow, Threshold configuration, Trend visualization",
        "acceptance_criteria": [
            "Variance calculation with configurable thresholds",
            "Root cause analysis workflow",
            "Variance trend visualization",
            "Forecast vs budget comparison",
            "Variance explanation documentation",
            "Automated alert generation",
            "Customizable variance reports",
            "Integration with spend monitoring"
        ]
    },
    {
        "id": "DESKTOP-BUD-004",
        "title": "Cost Reduction Management",
        "description": "Build a cost reduction management system for identifying opportunities, tracking initiatives, and measuring savings ROI",
        "priority": "Medium-High",
        "estimated_hours": 20,
        "agent": "interface-devforge",
        "platform_notes": "Opportunity identification interface, Initiative tracking dashboard, ROI calculation tools, Savings visualization",
        "acceptance_criteria": [
            "Cost reduction opportunity identification",
            "Initiative tracking and management",
            "Savings calculation and tracking",
            "ROI analysis and reporting",
            "Continuous improvement tracking",
            "Integration with budget planning",
            "Performance dashboard",
            "Success metrics tracking"
        ]
    },
    {
        "id": "DESKTOP-BUD-005",
        "title": "Budget Reallocation Workflow",
        "description": "Create a budget reallocation workflow system with multi-level approval routing, transfer execution, and audit trail",
        "priority": "Medium",
        "estimated_hours": 20,
        "agent": "codesmith-devforge",
        "platform_notes": "Reallocation request form, Approval workflow visualization, Transfer execution interface, Audit trail viewer",
        "acceptance_criteria": [
            "Reallocation request creation and editing",
            "Multi-level approval routing",
            "Budget transfer execution",
            "Approval history tracking",
            "Compliance validation",
            "Audit trail documentation",
            "Automated notifications",
            "Transfer confirmation workflow"
        ]
    },
    {
        "id": "DESKTOP-BUD-006",
        "title": "Budget Reporting Engine",
        "description": "Implement a comprehensive budget reporting engine with scheduled reports, executive dashboards, and customizable templates",
        "priority": "Medium",
        "estimated_hours": 18,
        "agent": "devcore-devforge",
        "platform_notes": "Report template builder, Scheduled report generation, Executive dashboard views, Multi-format export",
        "acceptance_criteria": [
            "Report template builder",
            "Scheduled report generation",
            "Executive dashboard views",
            "Customizable report templates",
            "Multi-format export (PDF, Excel, CSV)",
            "Report distribution automation",
            "Budget forecasting reports",
            "Compliance report generation"
        ]
    },
    {
        "id": "DESKTOP-BUD-007",
        "title": "ERP Integration Module",
        "description": "Build ERP integration module for synchronizing budget data with SAP, Oracle, and NetSuite financial systems",
        "priority": "High",
        "estimated_hours": 28,
        "agent": "codesmith-devforge",
        "platform_notes": "SAP integration, Oracle integration, NetSuite integration, Data synchronization dashboard",
        "acceptance_criteria": [
            "SAP financial system integration",
            "Oracle financial system integration",
            "NetSuite integration",
            "Data synchronization management",
            "Error handling and retry logic",
            "Sync status dashboard",
            "Manual sync trigger",
            "Audit logging for sync operations"
        ]
    },
    {
        "id": "DESKTOP-BUD-008",
        "title": "Budget Analytics Dashboard",
        "description": "Create a comprehensive budget analytics dashboard with KPI visualization, trend analysis, and executive reporting",
        "priority": "Medium",
        "estimated_hours": 22,
        "agent": "interface-devforge",
        "platform_notes": "KPI dashboard with customizable widgets, Trend analysis charts, Executive summary views, Benchmark comparison",
        "acceptance_criteria": [
            "KPI dashboard with customizable widgets",
            "Budget trend visualization",
            "Executive summary views",
            "Benchmark comparison tools",
            "Predictive analytics display",
            "Performance metrics tracking",
            "Drill-down capabilities",
            "Real-time data updates"
        ]
    }
]

# Issue templates for mobile platform
MOBILE_ISSUES = [
    {
        "id": "MOBILE-BUD-001",
        "title": "Budget Alert Mobile Interface",
        "description": "Create a mobile budget alert interface for receiving real-time budget notifications, variance alerts, and approval requests",
        "priority": "High",
        "estimated_hours": 18,
        "agent": "interface-devforge",
        "platform_notes": "Push notification for budget alerts, Quick approve/reject actions, Offline alert queue, Voice-guided alerts",
        "acceptance_criteria": [
            "Push notification for budget alerts",
            "Quick approve/reject actions",
            "Alert details with budget context",
            "Offline alert queue with sync",
            "Touch-friendly controls (44px minimum targets)",
            "Performance on mobile networks",
            "Battery optimization",
            "Alert history view"
        ]
    },
    {
        "id": "MOBILE-BUD-002",
        "title": "Spend Capture Mobile Interface",
        "description": "Build a mobile spend capture interface for field personnel to record expenses, upload receipts, and tag to budget categories",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "codesmith-devforge",
        "platform_notes": "Quick expense entry, Receipt photo capture, GPS-tagged expenses, Offline data entry",
        "acceptance_criteria": [
            "Quick expense entry form",
            "Receipt photo capture",
            "GPS-tagged expense location",
            "Budget category selection",
            "Offline data entry with sync",
            "Voice-to-text for descriptions",
            "Expense template shortcuts",
            "Approval request submission"
        ]
    },
    {
        "id": "MOBILE-BUD-003",
        "title": "Budget Approval Mobile Interface",
        "description": "Create a mobile budget approval interface for reviewing and approving budget requests, reallocations, and expenditures",
        "priority": "High",
        "estimated_hours": 16,
        "agent": "devcore-devforge",
        "platform_notes": "Quick approval workflow, Document attachment viewing, Delegation options, Approval history",
        "acceptance_criteria": [
            "Budget request review interface",
            "Quick approve/reject actions",
            "Document attachment viewing",
            "Delegation options",
            "Approval history view",
            "Comments and notes",
            "Push notification for pending approvals",
            "Offline approval queue"
        ]
    },
    {
        "id": "MOBILE-BUD-004",
        "title": "Budget Status Mobile Dashboard",
        "description": "Implement a mobile budget status dashboard for viewing real-time budget health, spend status, and key metrics",
        "priority": "Medium-High",
        "estimated_hours": 16,
        "agent": "interface-devforge",
        "platform_notes": "Widget-based dashboard, Quick budget health view, Pull-to-refresh data, Dark mode support",
        "acceptance_criteria": [
            "Budget health overview widgets",
            "Spend status indicators",
            "Key metric display",
            "Pull-to-refresh data",
            "Dark mode support",
            "Widget customization",
            "Quick action shortcuts",
            "Budget comparison view"
        ]
    },
    {
        "id": "MOBILE-BUD-005",
        "title": "Variance Alert Mobile Interface",
        "description": "Build a mobile variance alert interface for receiving threshold breach notifications and initiating corrective actions",
        "priority": "Medium",
        "estimated_hours": 14,
        "agent": "codesmith-devforge",
        "platform_notes": "Push notification for variances, Quick corrective action, Trend visualization, Root cause entry",
        "acceptance_criteria": [
            "Push notification for variance alerts",
            "Variance details with context",
            "Quick corrective action entry",
            "Trend visualization",
            "Root cause documentation",
            "Photo attachment for evidence",
            "Offline queue with sync",
            "Alert acknowledgment tracking"
        ]
    },
    {
        "id": "MOBILE-BUD-006",
        "title": "Budget Search Mobile Interface",
        "description": "Create a mobile budget search interface for quickly finding budget items, transactions, and historical data",
        "priority": "Medium",
        "estimated_hours": 12,
        "agent": "devcore-devforge",
        "platform_notes": "Quick search with filters, Recent searches, Voice search, Barcode/PO scanning",
        "acceptance_criteria": [
            "Quick search with filters",
            "Recent searches history",
            "Voice search capability",
            "Purchase order barcode scanning",
            "Search result drill-down",
            "Offline search cache",
            "Filter presets",
            "Search result bookmarking"
        ]
    }
]

# Issue templates for web platform
WEB_ISSUES = [
    {
        "id": "WEB-BUD-001",
        "title": "Executive Budget Dashboard",
        "description": "Create an executive budget dashboard for senior leadership to view organization-wide budget health, key metrics, and strategic insights",
        "priority": "High",
        "estimated_hours": 24,
        "agent": "interface-devforge",
        "platform_notes": "Organization-wide budget view, KPI widgets, Strategic insight cards, Drill-down capabilities",
        "acceptance_criteria": [
            "Organization-wide budget overview",
            "KPI dashboard widgets",
            "Strategic insight cards",
            "Drill-down to project level",
            "Responsive design for all browsers",
            "Real-time data updates",
            "Export to PDF/Excel",
            "Customizable dashboard layout"
        ]
    },
    {
        "id": "WEB-BUD-002",
        "title": "Budget Planning Web Interface",
        "description": "Build a web-based budget planning interface for creating, editing, and managing budget allocations across multiple projects",
        "priority": "High",
        "estimated_hours": 22,
        "agent": "codesmith-devforge",
        "platform_notes": "Spreadsheet-like grid interface, Bulk budget editing, Approval workflow integration, Version comparison",
        "acceptance_criteria": [
            "Spreadsheet-like budget grid",
            "Bulk budget editing",
            "Approval workflow integration",
            "Version comparison tool",
            "Import from Excel",
            "Multi-project support",
            "Budget allocation rules",
            "Validation and error highlighting"
        ]
    },
    {
        "id": "WEB-BUD-003",
        "title": "Spend Analytics Web Portal",
        "description": "Implement a comprehensive spend analytics web portal with advanced filtering, visualization, and export capabilities",
        "priority": "High",
        "estimated_hours": 20,
        "agent": "devcore-devforge",
        "platform_notes": "Advanced filtering options, Chart visualizations, Custom report builder, Multi-dimensional analysis",
        "acceptance_criteria": [
            "Advanced spend filtering",
            "Chart and graph visualizations",
            "Custom report builder",
            "Multi-dimensional analysis",
            "Drill-down capabilities",
            "Export to multiple formats",
            "Scheduled report delivery",
            "Spend trend analysis"
        ]
    },
    {
        "id": "WEB-BUD-004",
        "title": "Budget Approval Web Workflow",
        "description": "Create a web-based budget approval workflow system with document management, collaboration, and audit trail",
        "priority": "Medium-High",
        "estimated_hours": 20,
        "agent": "interface-devforge",
        "platform_notes": "Approval queue management, Document collaboration, Comment threads, Approval history viewer",
        "acceptance_criteria": [
            "Approval queue management",
            "Document attachment and viewing",
            "Comment threads and mentions",
            "Approval history viewer",
            "Delegation management",
            "Bulk approval options",
            "Email notification integration",
            "Mobile-responsive design"
        ]
    },
    {
        "id": "WEB-BUD-005",
        "title": "Cost Reduction Web Portal",
        "description": "Build a cost reduction web portal for managing initiatives, tracking savings, and measuring ROI across the organization",
        "priority": "Medium",
        "estimated_hours": 18,
        "agent": "codesmith-devforge",
        "platform_notes": "Initiative management dashboard, Savings tracker, ROI calculator, Leaderboard views",
        "acceptance_criteria": [
            "Initiative management dashboard",
            "Savings tracker with targets",
            "ROI calculator and reports",
            "Initiative leaderboard",
            "Success stories sharing",
            "Progress visualization",
            "Integration with budget planning",
            "Performance analytics"
        ]
    },
    {
        "id": "WEB-BUD-006",
        "title": "Budget Forecast Web Tool",
        "description": "Implement a budget forecast web tool with predictive analytics, scenario modeling, and what-if analysis capabilities",
        "priority": "Medium",
        "estimated_hours": 20,
        "agent": "devcore-devforge",
        "platform_notes": "Forecast model configuration, Scenario builder, What-if analysis, Projection visualization",
        "acceptance_criteria": [
            "Forecast model configuration",
            "Scenario builder",
            "What-if analysis tools",
            "Projection visualization",
            "Historical data comparison",
            "Confidence interval display",
            "Export forecasts",
            "Scenario comparison"
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
    issues_map = {"desktop": DESKTOP_ISSUES, "mobile": MOBILE_ISSUES, "web": WEB_ISSUES}
    issues = issues_map.get(platform, [])
    
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
        description="Generate Paperclip issues for PROC-BUDGET project"
    )
    parser.add_argument(
        "--platform",
        choices=["desktop", "mobile", "web", "all"],
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
    web_dir = base_dir / "web" / "issues"
    
    # Create directories if they don't exist
    desktop_dir.mkdir(parents=True, exist_ok=True)
    mobile_dir.mkdir(parents=True, exist_ok=True)
    web_dir.mkdir(parents=True, exist_ok=True)
    
    total_generated = []
    
    if args.platform in ["desktop", "all"]:
        print(f"\nGenerating desktop issues...")
        desktop_files = generate_issues("desktop", desktop_dir, args.count)
        total_generated.extend(desktop_files)
    
    if args.platform in ["mobile", "all"]:
        print(f"\nGenerating mobile issues...")
        mobile_files = generate_issues("mobile", mobile_dir, args.count)
        total_generated.extend(mobile_files)
    
    if args.platform in ["web", "all"]:
        print(f"\nGenerating web issues...")
        web_files = generate_issues("web", web_dir, args.count)
        total_generated.extend(web_files)
    
    print(f"\n✅ Generated {len(total_generated)} issues total")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""
Complete Supabase Database Backup Script

This script creates a comprehensive backup of all Paperclip tables from Supabase,
saving data as JSON files organized by timestamped directories.

Usage:
    python backup_supabase.py

Environment Variables:
    SUPABASE_URL: Your Supabase project URL
    SUPABASE_SERVICE_ROLE_KEY: Your Supabase service role key (for full access)

Output:
    Creates a timestamped backup directory with:
    - Individual JSON files for each table
    - A manifest file with backup metadata
    - Table statistics and row counts
"""

import os
import sys
import json
import time
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any, Optional

try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase-py not installed. Install with: pip install supabase")
    sys.exit(1)

# Load environment variables from .env file
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # python-dotenv not available, rely on system env vars

# List of all Paperclip tables (from schema files)
PAPERCLIP_TABLES = [
    # Core entities
    "companies",
    "agents",
    "issues",
    "projects",

    # Agent-related
    "agent_api_keys",
    "agent_config_revisions",
    "agent_runtime_state",
    "agent_task_sessions",
    "agent_wakeup_requests",

    # Authentication & Authorization
    "board_api_keys",
    "company_memberships",
    "principal_permission_grants",
    "instance_user_roles",

    # Work management
    "issue_comments",
    "issue_attachments",
    "issue_approvals",
    "issue_execution_decisions",
    "issue_inbox_archives",
    "issue_labels",
    "issue_read_states",
    "issue_relations",
    "issue_work_products",
    "issue_documents",

    # Execution & Heartbeat
    "heartbeat_runs",
    "heartbeat_run_events",
    "execution_workspaces",

    # Approvals & Governance
    "approvals",
    "approval_comments",

    # Assets & Documents
    "assets",
    "documents",
    "document_revisions",

    # Skills & Capabilities
    "company_skills",

    # Budgets & Costs
    "budget_policies",
    "budget_incidents",
    "cost_events",

    # Goals & Planning
    "goals",
    "project_goals",

    # Workspaces
    "project_workspaces",
    "workspace_operations",
    "workspace_runtime_services",

    # Plugins
    "plugins",
    "plugin_config",
    "plugin_company_settings",
    "plugin_entities",
    "plugin_jobs",
    "plugin_logs",
    "plugin_state",
    "plugin_webhooks",

    # Feedback & Voting
    "feedback_votes",
    "feedback_exports",

    # Inbox management
    "inbox_dismissals",

    # Routines
    "routines",

    # Company assets
    "company_logos",

    # Secrets management
    "company_secrets",
    "company_secret_versions",

    # Activity logging
    "activity_log",

    # Instance settings
    "instance_settings",

    # Invitations
    "invites",
    "join_requests",

    # CLI auth
    "cli_auth_challenges",

    # Labels
    "labels",

    # Finance
    "finance_events",
]

# Tables that might be large and need special handling
LARGE_TABLES = {
    "activity_log",
    "heartbeat_run_events",
    "cost_events",
    "issue_comments",
    "agent_task_sessions",
}

# Tables to skip (usually system or very large)
SKIP_TABLES = {
    # Add any tables you want to skip here
}


def get_supabase_client() -> Client:
    """Create and return Supabase client with service role access."""
    url = os.getenv('SUPABASE_URL')
    service_key = os.getenv('SUPABASE_SERVICE_ROLE_KEY')

    if not url:
        raise ValueError("SUPABASE_URL environment variable is required")

    if not service_key:
        raise ValueError("SUPABASE_SERVICE_ROLE_KEY is REQUIRED for full database backup")

    return create_client(url, service_key)


def create_backup_directory() -> Path:
    """Create a timestamped backup directory."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = Path(f"supabase_backup_{timestamp}")
    backup_dir.mkdir(parents=True, exist_ok=True)
    return backup_dir


def export_table(supabase: Client, table_name: str, backup_dir: Path) -> Dict[str, Any]:
    """Export a single table to JSON file."""
    print(f"Exporting table: {table_name}")

    try:
        # For large tables, we might need to paginate
        if table_name in LARGE_TABLES:
            print(f"  Large table detected, using pagination...")
            return export_large_table(supabase, table_name, backup_dir)
        else:
            # Standard export
            response = supabase.table(table_name).select('*').execute()
            data = response.data
    except Exception as e:
        print(f"  Error exporting {table_name}: {e}")
        return {
            "table": table_name,
            "success": False,
            "error": str(e),
            "row_count": 0,
            "file_size": 0
        }

    # Write to JSON file
    output_file = backup_dir / f"{table_name}.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False, default=str)

    file_size = output_file.stat().st_size

    print(f"  Exported {len(data)} rows ({file_size} bytes)")

    return {
        "table": table_name,
        "success": True,
        "row_count": len(data),
        "file_size": file_size,
        "file_path": str(output_file)
    }


def export_large_table(supabase: Client, table_name: str, backup_dir: Path, batch_size: int = 1000) -> Dict[str, Any]:
    """Export a large table using pagination."""
    all_data = []
    offset = 0
    total_rows = 0

    while True:
        try:
            response = supabase.table(table_name).select('*').range(offset, offset + batch_size - 1).execute()
            batch_data = response.data

            if not batch_data:
                break

            all_data.extend(batch_data)
            total_rows += len(batch_data)
            offset += batch_size

            print(f"  Exported batch: {len(batch_data)} rows (total: {total_rows})")

            # Safety check to prevent infinite loops
            if len(batch_data) < batch_size:
                break

        except Exception as e:
            print(f"  Error in batch export for {table_name}: {e}")
            break

    # Write to JSON file
    output_file = backup_dir / f"{table_name}.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(all_data, f, indent=2, ensure_ascii=False, default=str)

    file_size = output_file.stat().st_size

    print(f"  Large table export complete: {total_rows} total rows ({file_size} bytes)")

    return {
        "table": table_name,
        "success": True,
        "row_count": total_rows,
        "file_size": file_size,
        "file_path": str(output_file),
        "used_pagination": True
    }


def create_manifest(backup_dir: Path, stats: List[Dict[str, Any]]) -> None:
    """Create a backup manifest file with metadata."""
    manifest = {
        "backup_timestamp": datetime.now().isoformat(),
        "backup_directory": str(backup_dir),
        "supabase_url": os.getenv('SUPABASE_URL', 'NOT_SET'),
        "total_tables": len(stats),
        "successful_exports": len([s for s in stats if s.get("success", False)]),
        "failed_exports": len([s for s in stats if not s.get("success", False)]),
        "total_rows": sum(s.get("row_count", 0) for s in stats),
        "total_size_bytes": sum(s.get("file_size", 0) for s in stats),
        "table_stats": stats,
        "backup_script_version": "1.0.0",
        "notes": [
            "This backup contains all Paperclip database tables",
            "Data is exported as JSON for easy restoration",
            "Large tables were exported using pagination",
            "Timestamps are stored as ISO format strings"
        ]
    }

    manifest_file = backup_dir / "backup_manifest.json"
    with open(manifest_file, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print(f"\nManifest created: {manifest_file}")


def main():
    """Main backup function."""
    print("🗄️  Starting complete Supabase database backup...")
    print("⚠️  This will export ALL tables and may take a while for large databases.\n")

    # Confirm with user
    if '--yes' not in sys.argv:
        response = input("Are you sure you want to backup all tables? (type 'yes' to confirm): ")
        if response.lower() != 'yes':
            print("Backup cancelled.")
            sys.exit(0)

    try:
        # Initialize
        supabase = get_supabase_client()
        backup_dir = create_backup_directory()

        print(f"📁 Backup directory: {backup_dir}")
        print(f"🔗 Supabase URL: {os.getenv('SUPABASE_URL')}")
        print()

        # Export all tables
        stats = []
        successful = 0
        failed = 0

        for table_name in PAPERCLIP_TABLES:
            if table_name in SKIP_TABLES:
                print(f"⏭️  Skipping table: {table_name}")
                continue

            try:
                table_stats = export_table(supabase, table_name, backup_dir)
                stats.append(table_stats)

                if table_stats["success"]:
                    successful += 1
                else:
                    failed += 1

            except Exception as e:
                print(f"❌ Unexpected error exporting {table_name}: {e}")
                stats.append({
                    "table": table_name,
                    "success": False,
                    "error": str(e),
                    "row_count": 0,
                    "file_size": 0
                })
                failed += 1

        # Create manifest
        create_manifest(backup_dir, stats)

        # Print summary
        total_rows = sum(s.get("row_count", 0) for s in stats)
        total_size = sum(s.get("file_size", 0) for s in stats)

        print("\n" + "="*60)
        print("BACKUP COMPLETE")
        print("="*60)
        print(f"Backup directory: {backup_dir}")
        print(f"Tables processed: {len(stats)}")
        print(f"Successful exports: {successful}")
        print(f"Failed exports: {failed}")
        print(f"Total rows exported: {total_rows:,}")
        print(f"Total data size: {total_size:,} bytes ({total_size/1024/1024:.2f} MB)")
        print("="*60)

        if failed > 0:
            print(f"⚠️  Warning: {failed} tables failed to export")
            print("Check the backup_manifest.json for details")
            sys.exit(1)

        print("✅ Database backup completed successfully!")
        print(f"📦 Files saved in: {backup_dir}")

    except Exception as e:
        print(f"❌ Error during backup: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
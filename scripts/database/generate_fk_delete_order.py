#!/usr/bin/env python3
"""
Generate correct FK-aware DELETE order from the FK relationships CSV.
Reads docs-paperclip/schema/FK table relationships.csv and produces
DELETE statements in correct dependency order for bulk agent deletion.
"""
import csv
from collections import defaultdict

def parse_fk_csv(path):
    """Parse FK relationships CSV and return list of dicts."""
    rows = []
    with open(path, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            rows.append(row)
    return rows

def get_agent_fks(rows):
    """Extract all FKs referencing public.agents."""
    agent_fks = []
    for row in rows:
        if row['referenced_table'] == 'public.agents':
            agent_fks.append({
                'table': row['table_name'].replace('public.', ''),
                'column': row['local_column'],
                'delete_rule': row['delete_rule'],
            })
    return agent_fks

def get_heartbeat_run_fks(rows):
    """Extract all FKs referencing public.heartbeat_runs."""
    hr_fks = []
    for row in rows:
        if row['referenced_table'] == 'public.heartbeat_runs':
            hr_fks.append({
                'table': row['table_name'].replace('public.', ''),
                'column': row['local_column'],
                'delete_rule': row['delete_rule'],
            })
    return hr_fks

def main():
    rows = parse_fk_csv('docs-paperclip/schema/FK table relationships.csv')
    agent_fks = get_agent_fks(rows)
    hr_fks = get_heartbeat_run_fks(rows)
    
    # Separate by delete rule
    set_null_fks = [fk for fk in agent_fks if fk['delete_rule'] == 'SET NULL']
    cascade_fks = [fk for fk in agent_fks if fk['delete_rule'] == 'CASCADE']
    no_action_fks = [fk for fk in agent_fks if fk['delete_rule'] == 'NO ACTION']
    
    # Exclude self-referential (agents.reports_to -> agents.id)
    no_action_fks = [fk for fk in no_action_fks if fk['table'] != 'agents']
    
    print("-- ============================================================")
    print("-- FK-AWARE DELETE ORDER FOR ALL AGENTS")
    print("-- Generated from: docs-paperclip/schema/FK table relationships.csv")
    print("-- ============================================================")
    print()
    print("BEGIN;")
    print()
    
    # PHASE 1: SET NULL - these won't block, do them first for safety
    print("-- Phase 1: SET NULL for nullable FKs (won't block, safety first)")
    for fk in set_null_fks:
        print(f"UPDATE {fk['table']} SET {fk['column']} = NULL "
              f"WHERE {fk['column']}::text IN (SELECT id::text FROM agents);")
    print()
    
    # PHASE 2: Tables that reference heartbeat_runs (deepest dependencies)
    # These must be deleted before heartbeat_runs can be deleted
    print("-- Phase 2: Delete from tables referencing heartbeat_runs (deepest deps)")
    hr_no_action = [fk for fk in hr_fks if fk['delete_rule'] == 'NO ACTION']
    hr_set_null = [fk for fk in hr_fks if fk['delete_rule'] == 'SET NULL']
    
    # SET NULL first for heartbeat_runs references
    for fk in hr_set_null:
        if fk['table'] != 'heartbeat_runs':  # skip self-ref
            print(f"UPDATE {fk['table']} SET {fk['column']} = NULL "
                  f"WHERE {fk['column']}::text IN ("
                  f"SELECT hr.id::text FROM heartbeat_runs hr "
                  f"WHERE hr.agent_id::text IN (SELECT id::text FROM agents));")
    
    # DELETE from tables referencing heartbeat_runs
    for fk in hr_no_action:
        if fk['table'] != 'heartbeat_runs':  # skip self-ref
            print(f"DELETE FROM {fk['table']} WHERE {fk['column']}::text IN (")
            print(f"    SELECT hr.id::text FROM heartbeat_runs hr")
            print(f"    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)")
            print(f");")
    print()
    
    # PHASE 3: Delete heartbeat_run_events (references heartbeat_runs)
    print("-- Phase 3: Delete heartbeat_run_events")
    print("DELETE FROM heartbeat_run_events WHERE run_id::text IN (")
    print("    SELECT hr.id::text FROM heartbeat_runs hr")
    print("    WHERE hr.agent_id::text IN (SELECT id::text FROM agents)")
    print(");")
    print()
    
    # PHASE 4: Delete heartbeat_runs
    print("-- Phase 4: Delete heartbeat_runs")
    print("DELETE FROM heartbeat_runs WHERE agent_id::text IN (SELECT id::text FROM agents);")
    print()
    
    # PHASE 5: Delete from agent-specific operational tables
    print("-- Phase 5: Delete from agent operational tables (direct agent_id FKs)")
    operational_tables = [
        'agent_task_sessions', 'agent_runtime_state', 'agent_wakeup_requests',
        'agent_config_revisions', 'agent_skill_assignments', 'agent_api_keys'
    ]
    for table in operational_tables:
        # Find the FK for this table
        matching = [fk for fk in no_action_fks if fk['table'] == table]
        if matching:
            col = matching[0]['column']
            print(f"DELETE FROM {table} WHERE {col}::text IN (SELECT id::text FROM agents);")
    print()
    
    # PHASE 6: Delete from all other tables with NO ACTION FKs to agents
    print("-- Phase 6: Delete from all other tables referencing agents directly")
    already_handled = set(operational_tables + ['heartbeat_runs', 'heartbeat_run_events'])
    remaining = [fk for fk in no_action_fks if fk['table'] not in already_handled]
    
    # Sort by table name for consistency
    remaining.sort(key=lambda x: x['table'])
    
    for fk in remaining:
        print(f"DELETE FROM {fk['table']} WHERE {fk['column']}::text IN (SELECT id::text FROM agents);")
    print()
    
    # PHASE 7: Clear self-referential FK
    print("-- Phase 7: Clear self-referential reports_to FK")
    print("UPDATE agents SET reports_to = NULL;")
    print()
    
    # PHASE 8: Delete agents
    print("-- Phase 8: Delete all agents")
    print("DELETE FROM agents;")
    print()
    
    print("COMMIT;")
    print()
    print("-- ============================================================")
    print(f"-- Summary: {len(agent_fks)} FKs to agents processed")
    print(f"--   SET NULL: {len(set_null_fks)}")
    print(f"--   CASCADE:  {len(cascade_fks)}")
    print(f"--   NO ACTION: {len(no_action_fks)}")
    print(f"--   Heartbeat_runs chain: {len(hr_fks)} FKs")
    print("-- ============================================================")

if __name__ == '__main__':
    main()
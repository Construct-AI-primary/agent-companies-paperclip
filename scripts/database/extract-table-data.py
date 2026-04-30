#!/usr/bin/env python3
"""
Script to extract table contents from Paperclip database and save to docs-paperclip/schema/contents/
"""

import os
import sys
import sqlite3
import json
from pathlib import Path

def get_db_path():
    """Find the database file"""
    # Check for environment variable
    db_url = os.getenv('DATABASE_URL')
    if db_url and db_url.startswith('sqlite:'):
        db_path = db_url.replace('sqlite:', '')
    else:
        # Look for common database locations
        possible_paths = [
            'data/pglite/paperclip.db',
            'paperclip.db',
            '../data/pglite/paperclip.db'
        ]
        for path in possible_paths:
            if os.path.exists(path):
                db_path = path
                break
        else:
            print("Could not find database file. Please set DATABASE_URL or ensure database exists.")
            sys.exit(1)

    return db_path

def extract_table_data(db_path, table_name):
    """Extract all data from a table"""
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()

        # Get column names
        cursor.execute(f"PRAGMA table_info({table_name})")
        columns = [col[1] for col in cursor.fetchall()]

        # Get all data
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()

        conn.close()

        return {
            'table_name': table_name,
            'columns': columns,
            'row_count': len(rows),
            'data': rows
        }
    except Exception as e:
        print(f"Error extracting data from {table_name}: {e}")
        return None

def save_table_data(data, output_dir):
    """Save table data to JSON file"""
    if data is None:
        return

    os.makedirs(output_dir, exist_ok=True)

    filename = f"{data['table_name']}.json"
    filepath = os.path.join(output_dir, filename)

    # Convert tuples to lists for JSON serialization
    serializable_data = data.copy()
    serializable_data['data'] = [list(row) for row in data['data']]

    with open(filepath, 'w') as f:
        json.dump(serializable_data, f, indent=2, default=str)

    print(f"Saved {data['row_count']} rows from {data['table_name']} to {filepath}")

def main():
    tables_to_extract = ['agents', 'org_chart_hierarchy', 'org_chart_json', 'companies']

    db_path = get_db_path()
    print(f"Using database: {db_path}")

    output_dir = "docs-paperclip/schema/contents"
    print(f"Output directory: {output_dir}")

    for table_name in tables_to_extract:
        print(f"Extracting data from {table_name}...")
        data = extract_table_data(db_path, table_name)
        if data:
            save_table_data(data, output_dir)
        else:
            print(f"Failed to extract data from {table_name}")

    print("Extraction complete!")

if __name__ == "__main__":
    main()
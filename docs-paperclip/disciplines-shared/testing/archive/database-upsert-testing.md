---
memory_layer: durable_knowledge
para_section: pages/database-upsert-testing
gigabrain_tags: testing, database-upsert-testing, documents, hermes-agent, upsert-buttons, discipline-pages
openstinger_context: database-upsert-testing-documentation
last_updated: 2026-04-02
---

# Database Upsert Testing Documentation

## Purpose

This document outlines the process for testing upserts of documents to the database via the upsert buttons available across all discipline pages. It is designed to facilitate automated testing by the Hermes agent.

## Overview

Upsert functionality allows for inserting new documents or updating existing ones in the database. Testing ensures that these operations work correctly across different discipline pages.

## Testing Procedures

1. **Access Discipline Pages**: Navigate to each discipline page where upsert buttons are present.
2. **Trigger Upsert**: Click or activate the upsert button for a test document.
3. **Verify Database Operation**: Check if the document is inserted or updated in the database as expected.
4. **Repeat for All Disciplines**: Perform the above steps for all discipline pages.

## Notes for Hermes Agent

- Ensure database connections are active.
- Use test data that does not interfere with production data.
- Log any errors or discrepancies for further investigation.
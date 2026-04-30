# Shared Data Models

## Overview

This directory contains shared data model documentation for the Logistics workflow.

## Data Models

### Inventory Item
```json
{
  "id": "string",
  "sku": "string",
  "name": "string",
  "quantity": "number",
  "reorderLevel": "number",
  "location": "string"
}
```

### Delivery
```json
{
  "id": "string",
  "destination": "string",
  "scheduledTime": "datetime",
  "status": "pending|in_transit|delivered",
  "items": "InventoryItem[]"
}
```

## Related Documents

- [Project README](../README.md)

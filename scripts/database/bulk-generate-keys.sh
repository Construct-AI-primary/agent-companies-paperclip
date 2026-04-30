#!/bin/bash

# Bulk generate API keys for all agents using the Paperclip API
# This script assumes you have:
# 1. Paperclip running locally on port 3100
# 2. Board authentication (API key or session)

# Base URL for the API
BASE_URL="http://localhost:3100/api"

echo "🧪 Testing Paperclip connection..."
echo "🔗 API URL: ${BASE_URL}"

# Test connection (in development mode, authentication is automatic)
health_check=$(curl -s "${BASE_URL}/health")
if [ $? -ne 0 ] || [ "$health_check" = "" ]; then
    echo "❌ Cannot connect to Paperclip API at ${BASE_URL}"
    echo "   Make sure Paperclip is running with: pnpm dev"
    exit 1
fi

echo "✅ Paperclip API is accessible"
echo ""

# In development mode (local_trusted), no API key is needed
# The middleware automatically authenticates as board user
BOARD_API_KEY=""

echo "Fetching all companies..."

# Get all companies first (no auth header needed in dev mode)
companies=$(curl -s "${BASE_URL}/companies")

if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch companies. Check your API key and that Paperclip is running."
    exit 1
fi

echo "Found companies. Processing agents..."

# For each company, get agents and create keys
echo "$companies" | jq -r '.[] | .id' | while read company_id; do
    echo "Processing company: $company_id"

    # Get all agents for this company (no auth needed in dev mode)
    agents=$(curl -s "${BASE_URL}/companies/${company_id}/agents")

    if [ $? -ne 0 ]; then
        echo "Error: Failed to fetch agents for company $company_id"
        continue
    fi

    # For each agent, check if they have API keys and create one if not
    echo "$agents" | jq -r '.[] | select(.status != "pending_approval" and .status != "terminated") | .id' | while read agent_id; do
        agent_name=$(echo "$agents" | jq -r ".[] | select(.id == \"$agent_id\") | .name")

        echo "Checking agent: $agent_name ($agent_id)"

        # Check if agent already has API keys (no auth needed in dev mode)
        keys=$(curl -s "${BASE_URL}/agents/${agent_id}/keys")

        if [ "$(echo "$keys" | jq '. | length')" -gt 0 ]; then
            echo "  ✓ Agent already has API keys, skipping"
            continue
        fi

        echo "  → Creating API key for agent..."

        # Create API key (no auth needed in dev mode)
        result=$(curl -s -X POST \
            -H "Content-Type: application/json" \
            -d '{"name": "default"}' \
            "${BASE_URL}/agents/${agent_id}/keys")

        if [ $? -eq 0 ] && [ "$(echo "$result" | jq -r '.token')" != "null" ]; then
            token=$(echo "$result" | jq -r '.token')
            key_id=$(echo "$result" | jq -r '.id')
            echo "  ✓ Created key: $key_id"
            echo "  ⚠️  TOKEN (SAVE THIS): $token"
            echo "  📝 Agent: $agent_name"
            echo ""
        else
            echo "  ✗ Failed to create key for agent $agent_name"
            echo "  Error: $result"
        fi
    done
done

echo "Bulk API key generation complete!"
echo "⚠️  IMPORTANT: The tokens shown above will not be displayed again."
echo "   Make sure to save them securely!"
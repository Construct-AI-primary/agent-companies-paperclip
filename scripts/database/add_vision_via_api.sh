#!/bin/bash
# Add Vision Loopy CEO agent via Paperclip API
# Generated: 2026-04-13

echo "=================================="
echo "Adding Vision Loopy CEO via API"
echo "=================================="
echo ""

# Check if API is running
echo "Step 1: Checking API health..."
if ! curl -s http://localhost:3100/api/health > /dev/null; then
    echo "❌ API is not running. Start with: pnpm dev"
    exit 1
fi
echo "✅ API is running"

echo ""
echo "Step 2: Finding Loopy AI company..."

# Get Loopy AI company
LOOPY_COMPANY=$(curl -s http://localhost:3100/api/companies | jq -r '.[] | select(.name == "Loopy AI") | .id')

if [ -z "$LOOPY_COMPANY" ]; then
    echo "❌ Loopy AI company not found"
    exit 1
fi

echo "✅ Found Loopy AI company: $LOOPY_COMPANY"

echo ""
echo "Step 3: Checking existing Vision agent..."

# Check if Vision already exists
VISION_EXISTS=$(curl -s "http://localhost:3100/api/companies/$LOOPY_COMPANY/agents" | jq -r '.[] | select(.name == "Vision") | .id')

if [ -n "$VISION_EXISTS" ]; then
    echo "⚠️  Vision agent already exists with ID: $VISION_EXISTS"
    echo "Skipping creation..."
else
    echo "✅ Vision agent not found - will create"
fi

echo ""
echo "Step 4: Creating Vision agent..."

if [ -z "$VISION_EXISTS" ]; then
    # Create Vision agent
    CREATE_RESPONSE=$(curl -s -X POST "http://localhost:3100/api/companies/$LOOPY_COMPANY/agents" \
        -H "Content-Type: application/json" \
        -d '{
            "name": "Vision",
            "role": "ceo",
            "title": "Chief Executive Officer",
            "reportsTo": null,
            "capabilities": "Strategic planning and company vision, cross-division coordination, performance monitoring and reporting, resource allocation and priority setting, external partnerships and stakeholder management.",
            "adapterType": "claude_local",
            "adapterConfig": {
                "model": "anthropic/claude-3.5-sonnet",
                "temperature": 0.7,
                "maxTokens": 4096
            }
        }')

    VISION_ID=$(echo $CREATE_RESPONSE | jq -r '.id')

    if [ -n "$VISION_ID" ] && [ "$VISION_ID" != "null" ]; then
        echo "✅ Created Vision agent with ID: $VISION_ID"
    else
        echo "❌ Failed to create Vision agent"
        echo "Response: $CREATE_RESPONSE"
        exit 1
    fi
else
    VISION_ID=$VISION_EXISTS
fi

echo ""
echo "Step 5: Updating reporting structure..."

# Get all existing Loopy AI agents (excluding Vision)
AGENTS_TO_UPDATE=$(curl -s "http://localhost:3100/api/companies/$LOOPY_COMPANY/agents" | jq -r ".[] | select(.name != \"Vision\") | .id")

for AGENT_ID in $AGENTS_TO_UPDATE; do
    echo "Updating agent $AGENT_ID to report to Vision..."
    
    UPDATE_RESPONSE=$(curl -s -X PATCH "http://localhost:3100/api/agents/$AGENT_ID" \
        -H "Content-Type: application/json" \
        -d "{\"reportsTo\": \"$VISION_ID\"}")
    
    if echo "$UPDATE_RESPONSE" | grep -q "error"; then
        echo "⚠️  Warning: Failed to update agent $AGENT_ID"
    else
        echo "✅ Updated agent $AGENT_ID"
    fi
done

echo ""
echo "Step 6: Final verification..."

# Get final agent list
FINAL_AGENTS=$(curl -s "http://localhost:3100/api/companies/$LOOPY_COMPANY/agents")

VISION_COUNT=$(echo $FINAL_AGENTS | jq '.[] | select(.name == "Vision") | .id' | wc -l)
TOTAL_AGENTS=$(echo $FINAL_AGENTS | jq '. | length')

echo "✅ Final result:"
echo "   - Total Loopy AI agents: $TOTAL_AGENTS"
echo "   - Vision agents: $VISION_COUNT"

echo ""
echo "=================================="
echo "🎉 Vision Loopy CEO setup complete!"
echo "=================================="
echo ""
echo "Vision has been added as CEO and all existing agents now report to Vision."

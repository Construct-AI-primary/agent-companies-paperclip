import { createHash, randomBytes } from "node:crypto";
import postgres from "postgres";

// Database connection - use Supabase direct connection from test-db.mjs
const DATABASE_URL = process.env.DATABASE_URL || 'postgresql://postgres:JvFAeF6GHq7YDZlo@db.gmorarhibiptvcrnvrpi.supabase.co:5432/postgres';

// Helper functions from the application
function hashToken(token) {
  return createHash("sha256").update(token).digest("hex");
}

function createToken() {
  return `pcp_${randomBytes(24).toString("hex")}`;
}

async function generateApiKeysForAllAgents() {
  console.log('Connecting to database...');

  // Create database connection
  const sql = postgres(DATABASE_URL, {
    max: 1,
    connect_timeout: 10,
  });

  try {
    console.log('Finding agents without API keys...');

    // Find all agents that don't have API keys
    const agentsWithoutKeys = await sql`
      SELECT a.id, a.name, a.company_id, a.status
      FROM agents a
      WHERE a.status NOT IN ('pending_approval', 'terminated')
      AND NOT EXISTS (
        SELECT 1 FROM agent_api_keys k
        WHERE k.agent_id = a.id
        AND k.revoked_at IS NULL
      )
      ORDER BY a.company_id, a.name
    `;

    console.log(`Found ${agentsWithoutKeys.length} agents without API keys`);

    if (agentsWithoutKeys.length === 0) {
      console.log('All agents already have API keys!');
      return;
    }

    console.log('\nGenerating API keys...\n');

    const results = [];

    for (const agent of agentsWithoutKeys) {
      // Generate token and hash
      const token = createToken();
      const keyHash = hashToken(token);

      // Insert into database
      const inserted = await sql`
        INSERT INTO agent_api_keys (agent_id, company_id, name, api_key)
        VALUES (${agent.id}, ${agent.company_id}, 'default', ${keyHash})
        RETURNING id, name, created_at
      `;

      const result = {
        agentId: agent.id,
        agentName: agent.name,
        companyId: agent.company_id,
        keyId: inserted[0].id,
        token: token,
        createdAt: inserted[0].created_at
      };

      results.push(result);

      console.log(`✓ Generated key for ${agent.name} (${agent.id}):`);
      console.log(`  Token: ${token}`);
      console.log(`  Key ID: ${inserted[0].id}`);
      console.log();
    }

    console.log(`\n✅ Successfully generated ${results.length} API keys for agents`);
    console.log('\n📋 Summary:');
    console.log('='.repeat(80));

    results.forEach(result => {
      console.log(`Agent: ${result.agentName} (${result.agentId})`);
      console.log(`Token: ${result.token}`);
      console.log(`Key ID: ${result.keyId}`);
      console.log('-'.repeat(40));
    });

    console.log('\n⚠️  IMPORTANT: Save these tokens securely! They will not be shown again.');
    console.log('The tokens are stored as SHA256 hashes in the database for authentication.');

  } catch (error) {
    console.error('Error generating API keys:', error);
    process.exit(1);
  } finally {
    await sql.end();
  }
}

// Run the script
generateApiKeysForAllAgents().catch(console.error);
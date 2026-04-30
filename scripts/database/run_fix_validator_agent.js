#!/usr/bin/env node

import postgres from 'postgres';

// Use Supabase service role key for admin access
const sql = postgres('postgresql://postgres.gmorarhibiptvcrnvrpi:eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb3JhcmhpYmlwdHZjcm52cnBpIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MzI4MzI0OSwiZXhwIjoyMDg4ODU5MjQ5fQ.LMTbfUtyurnJDfn_aW4UIXiyMLwTUMhc70jjRAZRpIQ@aws-1-eu-west-1.pooler.supabase.com:6543/postgres?sslmode=require', {
  connection: { family: 4 }
});

async function runFix() {
  try {
    console.log('Running Validator agent fix...');

    // Update the agent to use hermes_local adapter
    const result = await sql`
      UPDATE agents
      SET adapter_type = 'hermes_local',
          adapter_config = jsonb_build_object(
              'url', 'https://github.com/Construct-AI-primary/construct_ai.git',
              'persistSession', true,
              'toolsets', jsonb_build_array('file_tools', 'terminal_tools', 'git'),
              'timeoutSec', 600,
              'graceSec', 15
          )
      WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a'
      AND adapter_type = 'http'
    `;

    console.log(`Updated ${result.count} agent(s)`);

    // Verify the change
    const agent = await sql`
      SELECT
          id,
          name,
          adapter_type,
          adapter_config
      FROM agents
      WHERE id = '982344cb-0dc9-4cf4-99cc-22bf9a61655a'
    `;

    console.log('Agent configuration after fix:');
    console.log(JSON.stringify(agent[0], null, 2));

  } catch (error) {
    console.error('Error running fix:', error);
  } finally {
    await sql.end();
  }
}

runFix().catch(console.error);
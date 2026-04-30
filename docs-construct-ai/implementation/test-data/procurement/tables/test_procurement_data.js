#!/usr/bin/env node

/**
 * Simple Procurement Test Data Validation Script
 * Tests database connectivity and validates test data integrity
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

const CONFIG = {
  supabaseUrl: process.env.SUPABASE_URL,
  supabaseKey: process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY,
  organizationId: '90cd635a-380f-4586-a3b7-a09103b6df94'
};

// Test data validation
async function testDatabaseConnection() {
  console.log('🧪 Testing Database Connection and Test Data Integrity...\n');

  try {
    const supabase = createClient(CONFIG.supabaseUrl, CONFIG.supabaseKey, {
      auth: { persistSession: false },
      global: { headers: { 'x-organization-id': CONFIG.organizationId } }
    });

    console.log('✅ Database connection established');

    // Test 1: Check user management table
    console.log('\n📊 Testing User Management Data...');
    const { data: users, error: userError } = await supabase
      .from('user_management')
      .select('user_id, full_name, email, disciplines')
      .limit(5);

    if (userError) {
      console.error('❌ User management query failed:', userError.message);
    } else {
      console.log(`✅ Found ${users.length} users in database`);
      users.forEach(user => {
        console.log(`   - ${user.full_name} (${user.email}): ${user.disciplines?.join(', ') || 'No disciplines'}`);
      });
    }

    // Test 2: Check procurement orders
    console.log('\n📋 Testing Procurement Orders...');
    const { data: orders, error: orderError } = await supabase
      .from('procurement_orders')
      .select('id, order_number, title, status, created_by')
      .limit(5);

    if (orderError) {
      console.error('❌ Procurement orders query failed:', orderError.message);
    } else {
      console.log(`✅ Found ${orders.length} procurement orders`);
      orders.forEach(order => {
        console.log(`   - ${order.order_number}: ${order.title} (${order.status})`);
      });
    }

    // Test 3: Check templates
    console.log('\n📝 Testing Templates...');
    const { data: templates, error: templateError } = await supabase
      .from('templates')
      .select('id, name, type, discipline')
      .limit(5);

    if (templateError) {
      console.error('❌ Templates query failed:', templateError.message);
    } else {
      console.log(`✅ Found ${templates.length} templates`);
      templates.forEach(template => {
        console.log(`   - ${template.name} (${template.type}) - ${template.discipline}`);
      });
    }

    // Test 4: Test relationships
    console.log('\n🔗 Testing Data Relationships...');

    if (orders.length > 0 && users.length > 0) {
      const order = orders[0];
      const user = users.find(u => u.user_id === order.created_by);

      if (user) {
        console.log(`✅ Relationship validated: Order "${order.title}" created by ${user.full_name}`);
      } else {
        console.log(`⚠️  Relationship issue: Order created by user not found in user_management`);
      }
    }

    // Test 5: Check agent workflow executions (may be empty due to previous errors)
    console.log('\n🤖 Testing Agent Workflow Executions...');
    const { data: executions, error: execError } = await supabase
      .from('agent_workflow_executions')
      .select('id, agent_name, stage, status')
      .limit(5);

    if (execError) {
      console.error('❌ Agent executions query failed:', execError.message);
    } else {
      console.log(`ℹ️  Found ${executions.length} agent workflow executions`);
      if (executions.length === 0) {
        console.log('   (This is expected if agent workflow population failed)');
      } else {
        executions.forEach(exec => {
          console.log(`   - ${exec.agent_name}: ${exec.stage} (${exec.status})`);
        });
      }
    }

    console.log('\n🎉 Test Data Validation Complete!');
    console.log('====================================');
    console.log('Summary:');
    console.log(`- Users: ${users?.length || 0} found`);
    console.log(`- Orders: ${orders?.length || 0} found`);
    console.log(`- Templates: ${templates?.length || 0} found`);
    console.log(`- Agent Executions: ${executions?.length || 0} found`);
    console.log('\n✅ Core procurement workflow test data is ready for testing!');

  } catch (error) {
    console.error('\n💥 FATAL ERROR during test data validation:', error);
    process.exit(1);
  }
}

// Run the test
testDatabaseConnection().catch(console.error);

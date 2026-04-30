#!/usr/bin/env node

/**
 * Production Vision API Testing Script
 * Tests drawing analysis endpoints and Vision API connectivity
 * Can be used to diagnose both local and production issues
 */

const fs = require('fs');
const path = require('path');
const { promisify } = require('util');
const { exec } = require('child_process');

const execAsync = promisify(exec);

// Configuration - change these for different testing scenarios
const CONFIG = {
  // Local development endpoint
  LOCAL_URL: 'http://localhost:3060/api/agents/drawing-analysis',

  // Production endpoint (change this for your deploy)
  PROD_URL: 'https://construct-ai.onrender.com/api/agents/drawing-analysis',
  HEALTH_URL: 'https://construct-ai.onrender.com/api/agents/drawing-analysis/health',

  // Use local or production
  USE_PRODUCTION: process.env.NODE_ENV === 'production' || process.argv.includes('--prod'),
  TEST_TIMEOUT: 60000, // 60 seconds
};

// ANSI color codes for console output
const colors = {
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  reset: '\x1b[0m',
  bold: '\x1b[1m'
};

const testResults = {
  total: 0,
  passed: 0,
  failed: 0
};

/**
 * Log test results
 */
function logTest(testName, passed, message = '', error = null) {
  testResults.total++;
  const status = passed ? `${colors.green}✓ PASS${colors.reset}` : `${colors.red}✗ FAIL${colors.reset}`;
  const color = passed ? colors.green : colors.red;

  console.log(`${color}[TEST ${testResults.total}]${colors.reset} ${testName}: ${status}`);
  if (message) console.log(`  ${colors.cyan}${message}${colors.reset}`);

  if (passed) {
    testResults.passed++;
  } else {
    testResults.failed++;
    if (error) {
      console.log(`${colors.red}  ERROR:${colors.reset} ${error.message}`);
    }
  }
}

/**
 * Make HTTP request with curl
 */
async function makeRequest(url, options = {}) {
  const { method = 'GET', body = null, headers = {} } = options;

  let curlCmd = `curl -s -X ${method}`;

  // Add timeout
  curlCmd += ` --max-time ${CONFIG.TEST_TIMEOUT / 1000}`;

  // Add headers if provided
  Object.entries(headers).forEach(([key, value]) => {
    curlCmd += ` -H "${key}:${value}"`;
  });

  // Add body for POST requests
  if (body && method === 'POST') {
    if (body.file) {
      // File upload
      curlCmd += ` -F "${body.fieldName}=@${body.file}"`;
    } else {
      // JSON body
      curlCmd += ` -H "Content-Type: application/json" -d '${JSON.stringify(body)}'`;
    }
  }

  curlCmd += ` "${url}"`;

  console.log(`${colors.blue}Executing: ${colors.reset}${curlCmd}`);

  try {
    const { stdout, stderr } = await execAsync(curlCmd);
    console.log(`${colors.green}Response received${colors.reset}`);

    // Try to parse JSON response
    try {
      return { success: true, data: JSON.parse(stdout), raw: stdout };
    } catch (parseError) {
      return { success: true, data: stdout, isText: true, raw: stdout };
    }
  } catch (error) {
    console.log(`${colors.red}Request failed${colors.reset}`);
    return { success: false, error: error.message };
  }
}

/**
 * Test health check endpoint
 */
async function testHealthCheck() {
  console.log(`\n${colors.bold}${colors.blue}=== HEALTH CHECK TEST ===${colors.reset}`);

  const response = await makeRequest(CONFIG.HEALTH_URL);

  if (response.success && response.data) {
    const healthStatus = response.data.status;

    logTest('Health Check Endpoint',
      healthStatus === 'healthy',
      `Status: ${healthStatus}, Model: ${response.data.model || 'N/A'}`,
      healthStatus !== 'healthy' ? new Error(JSON.stringify(response.data)) : null
    );
  } else {
    logTest('Health Check Endpoint',
      false,
      'Health check endpoint not responding',
      new Error(response.error)
    );
  }
}

/**
 * Test basic GET request (should fail with method error)
 */
async function testEndpointConnectivity() {
  console.log(`\n${colors.bold}${colors.blue}=== ENDPOINT CONNECTIVITY TEST ===${colors.reset}`);

  const url = CONFIG.USE_PRODUCTION ? CONFIG.PROD_URL : CONFIG.LOCAL_URL;
  const response = await makeRequest(url, { method: 'GET' });

  // Should get a method not allowed (405) or bad request error, but endpoint should respond
  const isConnected = response.success || response.error.includes('405') || response.error.includes('400');

  logTest('Endpoint Connectivity',
    isConnected,
    CONFIG.USE_PRODUCTION ? 'Production endpoint reachable' : 'Local development endpoint reachable',
    isConnected ? null : new Error(response.error)
  );
}

/**
 * Test with sample PDF file
 */
async function testWithSampleFiles() {
  console.log(`\n${colors.bold}${colors.blue}=== DRAWING ANALYSIS TEST ===${colors.reset}`);

  // Find sample PDF file in project
  const possibleFiles = [
    'test_lubricants_form.pdf',
    path.join('test', 'test_lubricants_form.pdf'),
    path.join('client', 'test_lubricants_form.pdf'),
    path.join('.', 'test_lubricants_form.pdf')
  ];

  let testFile = null;
  for (const file of possibleFiles) {
    if (fs.existsSync(file)) {
      testFile = file;
      break;
    }
  }

  if (!testFile) {
    logTest('Sample File Test',
      false,
      'No sample PDF file found for testing',
      new Error('Missing test file: test_lubricants_form.pdf')
    );
    return;
  }

  const url = CONFIG.USE_PRODUCTION ? CONFIG.PROD_URL : CONFIG.LOCAL_URL;
  const response = await makeRequest(url, {
    method: 'POST',
    body: {
      fieldName: 'files',
      file: testFile
    }
  });

  if (response.success && response.data) {
    const isSuccess = response.data.success !== false;
    const analysisType = response.data.analysis ? 'Vision/metadata analysis successful' : 'No analysis content returned';
    const error = response.data.error ? `Error: ${response.data.error}` : null;

    logTest('Drawing Analysis Upload',
      isSuccess,
      `${analysisType}${response.data.analysis ? ` (${response.data.analysis.length} chars)` : ''}`,
      error ? new Error(error) : null
    );

    // Additional analysis of response
    if (response.data.fileCount) {
      console.log(`  ${colors.green}Files processed: ${response.data.fileCount}${colors.reset}`);
    }

    if (response.data.analysisType) {
      console.log(`  ${colors.green}Analysis type: ${response.data.analysisType}${colors.reset}`);
      if (response.data.analysisType === 'drawing_comparison') {
        console.log(`  ${colors.green}✅ Vision API working (drawing comparison succeeded)${colors.reset}`);
      } else {
        console.log(`  ${colors.green}📄 Metadata fallback activated${colors.reset}`);
      }
    }

  } else {
    logTest('Drawing Analysis Upload',
      false,
      'File upload or processing failed',
      new Error(response.error || 'Unknown error')
    );
  }
}

/**
 * Test Vision API error visibility
 */
async function testVisionAPIErrorVisibility() {
  console.log(`\n${colors.bold}${colors.blue}=== VISION API ERROR VISIBILITY TEST ===${colors.reset}`);

  const url = CONFIG.USE_PRODUCTION ? CONFIG.PROD_URL : CONFIG.LOCAL_URL;

  // Try with a non-PDF file to trigger validation error
  const response = await makeRequest(url, {
    method: 'POST',
    body: {
      fieldName: 'files',
      file: 'package.json' // Should be rejected
    }
  });

  if (response.success && response.data) {
    const hasErrorMessage = response.data.error && response.data.message;
    logTest('Error Message Visibility',
      hasErrorMessage,
      hasErrorMessage ? 'Error messages properly returned in response' : 'No error message in response',
      hasErrorMessage ? null : new Error('Error messages not visible')
    );
  } else {
    logTest('Error Message Visibility',
      false,
      'No response received for error test',
      new Error(response.error)
    );
  }
}

/**
 * Main test execution
 */
async function runTests() {
  console.log(`${colors.bold}${colors.magenta}🎯 DRAWING ANALYSIS PRODUCTION TEST SUITE${colors.reset}`);
  console.log(`${colors.bold}Testing endpoint: ${colors.reset}${CONFIG.USE_PRODUCTION ? CONFIG.PROD_URL : CONFIG.LOCAL_URL}`);
  console.log(`${colors.bold}Mode: ${colors.reset}${CONFIG.USE_PRODUCTION ? 'Production' : 'Local Development'}`);
  console.log(`${colors.bold}Timestamp: ${colors.reset}${new Date().toISOString()}`);
  console.log('');

  const startTime = Date.now();

  try {
    // Run all tests
    await testHealthCheck();
    await testEndpointConnectivity();
    await testWithSampleFiles();
    await testVisionAPIErrorVisibility();
  } catch (error) {
    console.error(`${colors.red}Test suite failed:`, error);
  }

  const totalTime = Date.now() - startTime;

  // Results summary
  console.log(`\n${colors.bold}${colors.blue}=== TEST RESULTS SUMMARY ===${colors.reset}`);
  console.log(`${colors.bold}Tests Run: ${testResults.total}${colors.reset}`);
  console.log(`${colors.green}Passed: ${testResults.passed}${colors.reset}`);
  console.log(`${colors.red}Failed: ${testResults.failed}${colors.reset}`);
  console.log(`${colors.cyan}Total Time: ${totalTime}ms${colors.reset}`);

  // Specific guidance
  if (testResults.failed > 0) {
    console.log(`\n${colors.bold}${colors.red}🔍 DIAGNOSIS GUIDANCE:${colors.reset}`);
    console.log(`${colors.red}• Failed tests indicate specific issues to fix${colors.reset}`);
    console.log(`${colors.red}• Check server logs for detailed Vision API error messages${colors.reset}`);
    console.log(`${colors.yellow}• Run locally: ${colors.reset}node docs/test_vision_api_production.cjs`);
    console.log(`${colors.yellow}• Test production: ${colors.reset}NODE_ENV=production node docs/test_vision_api_production.cjs`);
  } else {
    console.log(`\n${colors.bold}${colors.green}✅ ALL TESTS PASSED${colors.reset}`);
    console.log(`${colors.green}• Vision API system appears functional${colors.reset}`);
    console.log(`${colors.green}• Error handling and fallback mechanisms working${colors.reset}`);
  }

  // Next steps
  console.log(`\n${colors.bold}${colors.cyan}Next Steps:${colors.reset}`);
  console.log(`${colors.cyan}1. Fix any FAILED test items${colors.reset}`);
  console.log(`${colors.cyan}2. Run server logs audit grep "VISION API" *${colors.reset}`);
  console.log(`${colors.cyan}3. Test with: curl -X POST ${CONFIG.USE_PRODUCTION ? CONFIG.PROD_URL : CONFIG.LOCAL_URL} -F "files=@drawing.pdf"${colors.reset}`);

  console.log(`\n${colors.bold}${colors.magenta}🎯 Test Script Location: docs/test_vision_api_production.cjs${colors.reset}`);
}

// Handle command line execution
if (require.main === module) {
  runTests().catch(error => {
    console.error(`${colors.red}Test suite execution failed:`, error);
    process.exit(1);
  });
}

module.exports = { runTests, CONFIG };

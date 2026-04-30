---
memory_layer: durable_knowledge
para_section: pages/environment-switching-testing
gigabrain_tags: testing, environment-switching-testing, hermes-agent, webpack, supabase, api-endpoints, feature-flags, build-configuration, development-mode, production-mode, error-tracking, error-handling
openstinger_context: environment-switching-testing-documentation
last_updated: 2026-04-02
---

# Environment Switching Production Testing Document for Hermes Agent

## Environment System Overview

This document provides comprehensive testing procedures for validating the environment switching capabilities of the ConstructAI application between development and production modes. The application uses multiple environment-dependent configurations that must be thoroughly tested to ensure proper operation across all modes.

Key environment components:
- **Environment Variables**: Server-side (.env files) and client-side (webpack DefinePlugin) injection
- **Build Configurations**: Webpack-based client building with mode-dependent optimizations
- **API Endpoints**: Environment-specific API routing and service connections
- **Supabase Integration**: Database connections varying by environment
- **Feature Flags**: Development-only features and debugging capabilities
- **Security Configurations**: Environment-dependent security settings and API key management

## Configuration Files

### Environment Files
- `.env.dev`: Development environment variables
- `.env.example`: Template for production environment setup
- Client-side variables injected via webpack DefinePlugin
- Server-side variables loaded via dotenv

### Build Configuration
- **Webpack Config** (`client/config/webpack.config.cjs`):
  - Mode detection based on `NODE_ENV`
  - Environment variables injected via DefinePlugin
  - Production: Source maps disabled, minimized bundles, optimized chunks
  - Development: Hot reloading, aggressive cache prevention, proxy to server

### Client-Side Environment Usage
- `process.env.NODE_ENV`: Core mode detection
- `process.env.REACT_APP_NODE_ENV`: Legacy React app mode
- Supabase configuration via DefinePlugin injection
- Runtime checks for localhost/debug modes

## Environment Variables to Test

### Core Variables
- `NODE_ENV`: `'development'`, `'production'`, `'demo'`
- `PORT`: Server port (3060 development, configurable production)
- `DATABASE_STRATEGY`: `'sqlite'` (dev) vs `'supabase'` (prod/demo)

### Supabase Configuration
- `SUPABASE_URL`: Database endpoint (construct_ai vs demo/production)
- `SUPABASE_ANON_KEY`: Anonymous access key
- `SUPABASE_SERVICE_ROLE_KEY`: Administrative access key
- `OPENCLAW_SUPABASE_*`: Secondary database for OpenClaw integration

### AI Service Configuration
- `OPENAI_API_KEY`: OpenAI Vision API key
- `OPENAI_ORG_ID`: Organization identifier (optional)
- `KIMI_API_KEY`: Kimi K2.5 API key
- `FIREWORKS_API_KEY`: Fireworks AI for drawing analysis
- `OPENROUTER_API_KEY`: Alternative AI service routing

### Encryption
- `DATABASE_ENCRYPTION_KEY`: Data encryption key for SQLite/Supabase

## Build Modes & Behaviors to Test

### Development Mode
- Console logging enabled for debugging
- Hot reloading and live feedback
- Aggressive cache prevention headers
- Proxy to backend server on :3060
- Source maps enabled
- Performance monitoring and error boundaries show details

### Production Mode
- Minified bundles with content hashing
- Source maps disabled
- Caching enabled for performance
- Optimized CSS extraction
- Error messages sanitized (no stack traces)
- Performance monitoring minimal

### Environment Variable Injection
- Client receives: `NODE_ENV`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`
- Server loads all environment variables from .env files
- Webpack DefinePlugin vs server dotenv loading

### Supabase Connection Testing
- Anonymous key authentication
- Service role for administrative operations
- Environment-specific database endpoints
- Connection timeout and error handling

### API Endpoint Testing
- Local development: `http://localhost:3060`
- Production: Configurable base URL
- CORS configuration validation
- Authentication headers and routing

### Logging Behavior
- Development: Verbose console output, error details exposed
- Production: Minimal logging, sanitized error messages

### Caching Behavior
- Development: Cache-Control: no-cache headers
- Production: Browser caching for assets and API responses

### File Loading & Asset Handling
- Webpack asset optimization in production
- CopyWebpackPlugin for static assets
- Locale file handling and caching

### React Component Behavior
- Error boundaries show details in development
- Performance monitoring components active in development
- Debug toolbars and panels development-only

### Security Considerations
- No sensitive keys exposed to client (service role kept server-side)
- CORS properly configured per environment
- HTTPS enforcement in production
- API key rotation testing

## Testing Procedures

### Test 1: Environment Variable Loading and Injection
**Description**: Verify that environment variables are properly loaded and injected into both server and client environments.

**Prerequisites**:
- Valid .env.dev and/or .env.prod files
- Application built with correct NODE_ENV

**Test Data**:
- Development: NODE_ENV=development, SUPABASE_URL=dev-db-url
- Production: NODE_ENV=production, SUPABASE_URL=prod-db-url

**Steps**:
1. Set environment variables via .env files
2. Build application using appropriate build command
3. Start server and verify output
4. Check browser console for injected variables
5. Verify server-side environment access

**Expected Results**:
- Server starts with correct environment
- Client receives defined variables via process.env
- No undefined environment errors

**Pass/Fail Criteria**: All variables accessible and correctly valued

**Priority**: Critical

**Links to Sources**:
- `client/config/webpack.config.cjs` - DefinePlugin configuration
- `.env.dev` - Development environment variables
- `.env.example` - Production template

### Test 2: Supabase Database Connection Switching
**Description**: Verify database connections switch properly between environments.

**Prerequisites**:
- Supabase projects created for development and production
- Environment-specific keys configured

**Test Data**:
- Dev database: mseizswoiwyewsidknta.supabase.co
- Prod keys and URLs configured

**Steps**:
1. Switch NODE_ENV between development/production
2. Rebuild application
3. Verify connection by attempting authenticated database query
4. Confirm data access matches expected environment
5. Test authentication flows

**Expected Results**:
- Database queries succeed with correct credentials
- Data isolation between environments
- Connection errors handled gracefully

**Pass/Fail Criteria**: Successful connections and data access isolation

**Priority**: Critical

**Links to Sources**:
- `.env.dev` - Supabase configuration
- Supabase dashboard API settings

### Test 3: API Endpoint Routing Validation
**Description**: Test that API endpoints route correctly based on environment.

**Prerequisites**:
- Server running in target environment
- Client built for corresponding environment

**Test Data**:
- Dev: http://localhost:3060/api/*
- Prod: Configured production URL

**Steps**:
1. Deploy application in each environment
2. Send API requests from client
3. Verify requests reach correct backend
4. Check response data validation
5. Test error handling and CORS

**Expected Results**:
- API calls complete successfully
- Proper headers and authentication
- Environment-appropriate responses

**Pass/Fail Criteria**: All API routes functional and authenticated

**Priority**: High

**Links to Sources**:
- `client/src/services/userOrganizationService.js` - Base URL logic
- Webpack proxy configuration

### Test 4: Build Configuration Mode Switching
**Description**: Verify webpack builds correctly for different modes.

**Prerequisites**:
- Node dependencies installed
- Environment variables available

**Test Data**:
- Development build artifacts
- Production optimized bundles

**Steps**:
1. Execute `npm run build:fast` with NODE_ENV=development
2. Execute `npm run build:fast` with NODE_ENV=production
3. Compare bundle outputs and sizes
4. Verify source maps presence/absence
5. Test asset loading and optimization

**Expected Results**:
- Development: Readable code, source maps, development features
- Production: Minified, optimized, production features

**Pass/Fail Criteria**: Bundle builds successfully and functions correctly

**Priority**: Critical

**Links to Sources**:
- `package.json` build scripts
- `client/config/webpack.config.cjs` mode logic

### Test 5: Feature Flag and Debug Mode Validation
**Description**: Test development-only features are properly gated.

**Prerequisites**:
- Application built in both modes
- Developer user accounts configured

**Test Data**:
- Dev mode user roles
- Debug toolbar visibility
- Console debug messages

**Steps**:
1. Build and deploy in development mode
2. Verify developer tools are accessible
3. Switch to production build
4. Confirm developer features are hidden
5. Test error boundary behavior differences

**Expected Results**:
- Development: Debug panels visible, detailed logging
- Production: Clean interface, minimal exposure

**Pass/Fail Criteria**: No debug features leak to production

**Priority**: High

**Links to Sources**:
- Client-side `process.env.NODE_ENV` checks
- Error boundary components

### Test 6: Caching Behavior Verification
**Description**: Ensure caching headers and behaviors match environment requirements.

**Prerequisites**:
- Client built for target environment
- Server configured appropriately

**Test Data**:
- Cache-Control headers
- Asset hashing and versioning

**Steps**:
1. Build and serve in development mode
2. Verify no-cache headers in responses
3. Repeat for production mode
4. Confirm browser caching behavior
5. Test asset updates and cache busting

**Expected Results**:
- Development: Aggressive no-cache enforcement
- Production: Appropriate caching for performance

**Pass/Fail Criteria**: Headers and caching match environment expectations

**Priority**: Medium

**Links to Sources**:
- Webpack devServer proxy headers
- Cache configuration in server routes

### Test 7: AI Service API Key Management
**Description**: Verify AI service credentials are properly managed across environments.

**Prerequisites**:
- AI service accounts configured
- Environment-specific keys set

**Test Data**:
- OpenAI, Kimi, Fireworks API keys
- Service endpoint configurations

**Steps**:
1. Configure keys for each environment
2. Test AI service calls in each mode
3. Verify authentication and rate limiting
4. Check for key exposure in client bundles
5. Test fallback behavior for failed services

**Expected Results**:
- AI services functional with correct keys
- No sensitive key exposure
- Graceful degradation on failures

**Pass/Fail Criteria**: AI features work without security risks

**Priority**: High

**Links to Sources**:
- `.env.dev` AI service keys
- Client-side AI service implementations

### Test 8: Security Header Validation
**Description**: Verify security headers are properly applied per environment.

**Prerequisites**:
- Server and client configured for environment
- HTTPS available in production

**Test Data**:
- CORS policies, CSP headers
- XSS protection settings

**Steps**:
1. Deploy in development environment
2. Check security headers via browser dev tools
3. Repeat for production environment
4. Verify HTTPS enforcement in production
5. Test cross-origin request handling

**Expected Results**:
- Appropriate security headers applied
- No conflicts with development needs
- Production security maximized

**Pass/Fail Criteria**: All security requirements met without functionality loss

**Priority**: Critical

**Links to Sources**:
- Server helmet middleware configuration
- Webpack devServer security headers

### Test 9: Performance Monitoring Switch
**Description**: Test performance monitoring components activate correctly.

**Prerequisites**:
- Application built and running
- Performance monitoring libraries loaded

**Test Data**:
- Render tracking, memory usage
- Component timing data

**Steps**:
1. Build in development mode
2. Navigate through application features
3. Verify performance data collection
4. Switch to production build
5. Confirm minimal performance monitoring in production

**Expected Results**:
- Development: Comprehensive performance tracking
- Production: Minimal overhead monitoring

**Pass/Fail Criteria**: Performance data available in development, hidden in production

**Priority**: Medium

**Links to Sources**:
- Performance monitoring utilities
- Enable/disable flags based on NODE_ENV

### Test 10: Database Strategy Switching
**Description**: Test switching between SQLite (development) and Supabase (production).

**Prerequisites**:
- Both database systems configured
- Migration scripts available

**Test Data**:
- SQLite local database
- Supabase production database

**Steps**:
1. Set DATABASE_STRATEGY=sqlite and NODE_ENV=development
2. Initialize and populate SQLite database
3. Switch to DATABASE_STRATEGY=supabase for production
4. Migrate data and perform operations
5. Verify data consistency across strategies

**Expected Results**:
- Both strategies functional with correct environment
- Data migration successful
- No service disruption during switching

**Pass/Fail Criteria**: Applications function identically with different databases

**Priority**: High

**Links to Sources**:
- Database configuration scripts
- Migration procedures

## Build Commands

### Development Mode Setup
```bash
# Set environment
export NODE_ENV=development
export DATABASE_STRATEGY=sqlite

# Build and run
npm run clean-cache
npm install --legacy-peer-deps
npm run build:client:fresh
npm run dev:fresh
```

### Production Mode Setup
```bash
# Set environment
export NODE_ENV=production
export DATABASE_STRATEGY=supabase

# Build optimized
npm run build:fast
npm run serve
```

### Demo Environment
```bash
# Set environment
export NODE_ENV=demo
export DATABASE_STRATEGY=supabase

# Build and run
npm run dev:demo:fresh
```

## Error Reporting

If any test encounters errors or failures, create a detailed error report in:
`/Users/chadferguson/Documents/construct_ai/docs-construct-ai/error-tracking/environment-switching-errors-{timestamp}.md`

### Error Report Format

```markdown
# Environment Switching Error Report

**Timestamp**: {timestamp}
**Test Case**: [Test number and name]
**Environment**: Development/Production
**Error Description**: [Detailed description]

## Error Details
- **Error Message**: [Exact error text]
- **Stack Trace**: [If applicable]
- **Environment Variables**: [Relevant env vars at time of error]
- **Build Configuration**: [Webpack/prod configs used]

## Reproduction Steps
1. [Step by step reproduction]
2. [Commands executed]
3. [Environment setup]

## Expected Behavior
[What should have happened]

## Impact Assessment
- Severity: [Critical/High/Medium/Low]
- Affected Systems: [Client/Server/Database]
- User Impact: [Description]

## Logs and Artifacts
```bash
[Relevant console output]
[Configuration files]
```

## Mitigation Actions Taken
[Immediate fix if known]

## Recommended Solution
[Long-term fix recommendations]
```

---

*This document serves as a comprehensive guide for initializing, testing, and maintaining environment switching capabilities in the ConstructAI application. Regular execution of these tests ensures production stability and development efficiency.*
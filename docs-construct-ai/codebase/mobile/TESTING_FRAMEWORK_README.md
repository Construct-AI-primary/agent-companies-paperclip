---
memory_layer: durable_knowledge
para_section: pages/codebase/mobile
gigabrain_tags: mobile, codebase, cross-platform
documentation
openstinger_context: mobile-development, responsive-design
last_updated: 2026-03-21
related_docs:
  - codebase/mobile/
  - disciplines/
---
# ConstructAI Testing Framework

This comprehensive testing framework provides end-to-end testing capabilities for the ConstructAI mobile application, covering unit tests, integration tests, E2E tests, performance tests, and accessibility tests.

## Table of Contents

1. [Overview](#overview)
2. [Testing Structure](#testing-structure)
3. [E2E Testing Setup](#e2e-testing-setup)
4. [Running Tests](#running-tests)
5. [Test Categories](#test-categories)
6. [Performance Testing](#performance-testing)
7. [Accessibility Testing](#accessibility-testing)
8. [CI/CD Integration](#ci-cd-integration)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

## Overview

The testing framework is built around:
- **Jest** for unit and integration testing
- **Detox** for end-to-end testing
- **React Native Testing Library** for component testing
- **Custom performance and accessibility test suites**

### Key Features

- ✅ Complete E2E test coverage for main user journeys
- ✅ Performance monitoring and benchmarking
- ✅ Accessibility compliance testing
- ✅ Cross-platform testing (iOS/Android)
- ✅ CI/CD ready configuration
- ✅ Comprehensive test reporting

## Testing Structure

```
├── e2e/                          # End-to-end tests
│   ├── jest.config.js           # E2E Jest configuration
│   ├── init.js                  # E2E test initialization
│   ├── appNavigation.test.js    # App navigation tests
│   ├── safetyWorkflow.test.js   # Safety workflow tests
│   └── equipmentWorkflow.test.js # Equipment workflow tests
├── .detoxrc.json                # Detox configuration
├── src/services/__tests__/      # Unit and integration tests
│   ├── performance.test.ts      # Performance test suite
│   ├── accessibility.test.ts    # Accessibility test suite
│   ├── database.test.ts         # Database service tests
│   ├── aiService.test.ts        # AI service tests
│   └── api.test.ts              # API service tests
├── src/components/__tests__/    # Component tests
├── src/screens/__tests__/       # Screen component tests
└── jest.config.js               # Main Jest configuration
```

## E2E Testing Setup

### Prerequisites

1. **Node.js** (v16 or higher)
2. **Xcode** (for iOS testing)
3. **Android Studio** (for Android testing)
4. **Detox CLI**: `npm install -g detox-cli`

### Installation

```bash
# Install dependencies
npm install

# Install Detox CLI globally
npm install -g detox-cli

# For iOS
cd ios && pod install

# For Android
# Ensure Android SDK is properly configured
```

### Detox Configuration

The `.detoxrc.json` file contains configurations for:
- iOS Simulator testing
- Android Emulator testing
- Test artifacts (screenshots, videos, logs)
- Build configurations

## Running Tests

### Unit Tests

```bash
# Run all unit tests
npm test

# Run specific test file
npm test -- src/services/__tests__/database.test.ts

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

### E2E Tests

```bash
# Build and run E2E tests for iOS
detox build --configuration ios.simulator
detox test --configuration ios.simulator

# Build and run E2E tests for Android
detox build --configuration android.emulator
detox test --configuration android.emulator

# Run specific E2E test file
detox test --configuration ios.simulator e2e/safetyWorkflow.test.js
```

### Performance Tests

```bash
# Run performance test suite
npm test -- src/services/__tests__/performance.test.ts

# Run with performance profiling
npm run test:performance
```

### Accessibility Tests

```bash
# Run accessibility test suite
npm test -- src/services/__tests__/accessibility.test.ts

# Generate accessibility report
npm run test:accessibility-report
```

## Test Categories

### 1. App Navigation Tests (`e2e/appNavigation.test.js`)

Tests the main navigation flows:
- Initial screen display
- Navigation between Stock, Safety, and Equipment dashboards
- Navigation state persistence
- Back navigation

### 2. Safety Workflow Tests (`e2e/safetyWorkflow.test.js`)

Comprehensive safety incident management testing:
- Incident reporting and creation
- Hazard reporting
- Incident details viewing
- Status updates
- Offline functionality
- Form validation
- Data synchronization

### 3. Equipment Workflow Tests (`e2e/equipmentWorkflow.test.js`)

Equipment management testing:
- Equipment registration
- Equipment listing and details
- Maintenance scheduling
- Status updates
- Search and filtering
- Reporting functionality
- Offline operations

### 4. Performance Tests (`src/services/__tests__/performance.test.ts`)

Performance monitoring:
- App startup time
- Database operations
- API response times
- Memory usage
- Rendering performance
- Network performance
- CPU usage monitoring

### 5. Accessibility Tests (`src/services/__tests__/accessibility.test.ts`)

Accessibility compliance:
- Screen reader support
- Keyboard navigation
- Focus management
- Color contrast validation
- Touch target sizes
- Form accessibility
- Media accessibility
- Error announcements

## Performance Testing

### Metrics Tracked

- **App Startup**: Time to initialize the application
- **Database Operations**: Read/write performance
- **API Responses**: Network request timing
- **Memory Usage**: Heap size and garbage collection
- **Rendering**: Component render times
- **Network**: Request/response performance

### Benchmarks

```javascript
const benchmarks = {
  appStartup: 3000,      // 3 seconds max
  apiResponse: 500,      // 500ms max
  databaseQuery: 100,    // 100ms max
  componentRender: 50,   // 50ms max
  networkRequest: 1000,  // 1 second max
};
```

### Performance Reporting

Performance tests generate detailed reports including:
- Execution times for each operation
- Memory usage patterns
- Recommendations for optimization
- Compliance with performance benchmarks

## Accessibility Testing

### Compliance Standards

- **WCAG 2.1 AA**: Web Content Accessibility Guidelines
- **Section 508**: US government accessibility standards
- **Platform Guidelines**: iOS and Android accessibility guidelines

### Features Tested

- Screen reader compatibility
- Keyboard navigation support
- Focus management
- Color contrast ratios
- Touch target sizes (minimum 44x44pt on iOS, 48x48dp on Android)
- Form field labeling
- Error message announcements
- Media descriptions

### Accessibility Report

```javascript
const accessibilityReport = {
  timestamp: new Date().toISOString(),
  platform: Platform.OS,
  screenReaderEnabled: true,
  compliance: {
    wcag21: 'AA',
    section508: true,
    score: 95,
  },
  issues: [],
  recommendations: [],
};
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: E2E Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '16'

      - name: Install dependencies
        run: npm ci

      - name: Install Detox CLI
        run: npm install -g detox-cli

      - name: Install iOS dependencies
        run: cd ios && pod install

      - name: Build for testing
        run: detox build --configuration ios.simulator

      - name: Run E2E tests
        run: detox test --configuration ios.simulator

      - name: Upload test artifacts
        uses: actions/upload-artifact@v2
        if: always()
        with:
          name: test-artifacts
          path: artifacts/
```

### Test Artifacts

Detox generates:
- Screenshots on test failures
- Video recordings of test runs
- Device logs
- Test execution reports

## Best Practices

### Writing E2E Tests

1. **Use descriptive test names** that explain the user behavior being tested
2. **Follow the Arrange-Act-Assert pattern**
3. **Use test IDs** for reliable element selection
4. **Handle async operations** properly with await
5. **Clean up test data** after each test
6. **Test both success and failure scenarios**

### Example E2E Test

```javascript
describe('Safety Workflow', () => {
  beforeEach(async () => {
    await device.reloadReactNative();
    await element(by.text('Safety')).tap();
  });

  it('should create a new incident report', async () => {
    // Arrange
    await element(by.text('Report Incident')).tap();

    // Act
    await element(by.id('incident-type-picker')).tap();
    await element(by.text('Accident')).tap();
    await element(by.id('incident-description-input'))
      .typeText('Test incident description');
    await element(by.id('incident-severity-picker')).tap();
    await element(by.text('High')).tap();
    await element(by.text('Submit Report')).tap();

    // Assert
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();
    await expect(element(by.text('Incident reported successfully'))).toBeVisible();
  });
});
```

### Performance Testing Best Practices

1. **Set realistic benchmarks** based on device capabilities
2. **Test on target devices** (not just simulators)
3. **Monitor memory leaks** in long-running tests
4. **Profile network requests** for optimization opportunities
5. **Use performance budgets** to prevent regressions

### Accessibility Testing Best Practices

1. **Test with screen readers enabled**
2. **Verify keyboard navigation** without mouse/touch
3. **Check color contrast** with automated tools
4. **Validate touch targets** meet minimum size requirements
5. **Test form validation** announcements
6. **Verify media descriptions** and captions

## Troubleshooting

### Common Issues

#### Detox Build Failures

```bash
# Clean and rebuild
detox clean-framework-cache
detox build --configuration ios.simulator --clean
```

#### Simulator Issues

```bash
# Reset simulators
xcrun simctl erase all

# List available devices
xcrun simctl list devices
```

#### Android Emulator Issues

```bash
# List available emulators
emulator -list-avds

# Start emulator
emulator -avd Pixel_5_API_33
```

#### Test Timeouts

```javascript
// Increase timeout for slow operations
it('should handle slow operation', async () => {
  // ... test code
}, 30000); // 30 second timeout
```

#### Element Not Found

```javascript
// Use testID for reliable element selection
await element(by.id('submit-button')).tap();

// Or use accessibility labels
await element(by.label('Submit Form')).tap();
```

### Debugging Tests

```bash
# Run tests with verbose output
detox test --configuration ios.simulator --loglevel verbose

# Run specific test with debugging
detox test --configuration ios.simulator --grep "should create incident"

# Take screenshots on failure
detox test --configuration ios.simulator --take-screenshots failing
```

### Performance Issues

```bash
# Profile test execution
detox test --configuration ios.simulator --record-performance all

# Monitor memory usage
detox test --configuration ios.simulator --record-memory all
```

## Contributing

### Adding New Tests

1. **Follow the existing structure** and naming conventions
2. **Add appropriate test IDs** to components
3. **Include both positive and negative test cases**
4. **Update documentation** when adding new test categories
5. **Ensure tests are reliable** and not flaky

### Test Maintenance

1. **Regularly update test selectors** when UI changes
2. **Keep test data realistic** and representative
3. **Monitor test execution times** and optimize slow tests
4. **Review and update performance benchmarks** periodically
5. **Ensure accessibility tests** reflect current WCAG guidelines

## Support

For questions or issues with the testing framework:

1. Check the [troubleshooting section](#troubleshooting)
2. Review existing test examples
3. Consult the Detox documentation
4. Create an issue with detailed reproduction steps

## Changelog

### v1.0.0
- Initial release with comprehensive E2E testing
- Performance and accessibility test suites
- CI/CD integration support
- Cross-platform testing capabilities

---

This testing framework ensures the ConstructAI application maintains high quality, performance, and accessibility standards across all user interactions and workflows.

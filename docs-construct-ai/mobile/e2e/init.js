/**
 * E2E Test Initialization
 *
 * This file sets up the testing environment for Detox E2E tests.
 * It configures the test runner and provides utilities for E2E testing.
 */

const { detox } = require('detox');
const config = require('../.detoxrc.json');

beforeAll(async () => {
  await detox.init(config);
});

beforeEach(async () => {
  await device.reloadReactNative();
});

afterAll(async () => {
  await detox.cleanup();
});

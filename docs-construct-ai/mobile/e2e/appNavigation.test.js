/**
 * App Navigation E2E Tests
 *
 * Tests the main navigation flows and screen transitions in the ConstructAI app.
 * These tests verify that users can navigate between different sections of the app
 * and that the navigation state is maintained correctly.
 */

describe('App Navigation', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  it('should display the initial Stock Dashboard screen', async () => {
    await expect(element(by.text('ConstructAI Stock Management'))).toBeVisible();
  });

  it('should navigate to Safety Dashboard', async () => {
    // Navigate to Safety Dashboard
    await element(by.text('Safety')).tap();

    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();
    await expect(element(by.text('Report Incident'))).toBeVisible();
    await expect(element(by.text('Report Hazard'))).toBeVisible();
  });

  it('should navigate to Equipment Dashboard', async () => {
    // Navigate to Equipment Dashboard
    await element(by.text('Equipment')).tap();

    await expect(element(by.text('Equipment Dashboard'))).toBeVisible();
    await expect(element(by.text('Register Equipment'))).toBeVisible();
  });

  it('should navigate back to Stock Dashboard', async () => {
    // Navigate to Stock Dashboard
    await element(by.text('Stock')).tap();

    await expect(element(by.text('ConstructAI Stock Management'))).toBeVisible();
  });

  it('should maintain navigation state after backgrounding and foregrounding', async () => {
    // Navigate to Safety Dashboard
    await element(by.text('Safety')).tap();
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();

    // Background and foreground the app
    await device.sendToHome();
    await device.launchApp();

    // Should still be on Safety Dashboard
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();
  });
});

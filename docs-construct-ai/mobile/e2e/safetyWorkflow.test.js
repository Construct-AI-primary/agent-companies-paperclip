/**
 * Safety Workflow E2E Tests
 *
 * Tests the complete safety incident reporting and management workflow.
 * This includes creating incidents, viewing details, and managing safety data.
 */

describe('Safety Workflow', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
    // Navigate to Safety Dashboard
    await element(by.text('Safety')).tap();
  });

  it('should display safety dashboard with key metrics', async () => {
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();
    await expect(element(by.text('Report Incident'))).toBeVisible();
    await expect(element(by.text('Report Hazard'))).toBeVisible();
    await expect(element(by.text('View Incidents'))).toBeVisible();
    await expect(element(by.text('View Hazards'))).toBeVisible();
  });

  it('should navigate to incident report form', async () => {
    await element(by.text('Report Incident')).tap();

    await expect(element(by.text('Report Incident'))).toBeVisible();
    await expect(element(by.id('incident-type-picker'))).toBeVisible();
    await expect(element(by.id('incident-description-input'))).toBeVisible();
    await expect(element(by.id('incident-severity-picker'))).toBeVisible();
  });

  it('should create a new incident report', async () => {
    await element(by.text('Report Incident')).tap();

    // Fill out incident form
    await element(by.id('incident-type-picker')).tap();
    await element(by.text('Accident')).tap();

    await element(by.id('incident-description-input')).typeText('Test incident description');
    await element(by.id('incident-severity-picker')).tap();
    await element(by.text('High')).tap();

    // Add location if available
    try {
      await element(by.id('location-input')).typeText('Construction Site A');
    } catch (e) {
      // Location input might not be available
    }

    // Submit the form
    await element(by.text('Submit Report')).tap();

    // Should navigate back to dashboard
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();

    // Should show success message
    await expect(element(by.text('Incident reported successfully'))).toBeVisible();
  });

  it('should create a hazard report', async () => {
    await element(by.text('Report Hazard')).tap();

    await expect(element(by.text('Report Hazard'))).toBeVisible();

    // Fill out hazard form
    await element(by.id('hazard-type-picker')).tap();
    await element(by.text('Chemical')).tap();

    await element(by.id('hazard-description-input')).typeText('Hazardous chemical spill');
    await element(by.id('hazard-risk-level-picker')).tap();
    await element(by.text('High')).tap();

    // Submit the form
    await element(by.text('Submit Report')).tap();

    // Should navigate back to dashboard
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();

    // Should show success message
    await expect(element(by.text('Hazard reported successfully'))).toBeVisible();
  });

  it('should view incident details', async () => {
    // Navigate to incidents list
    await element(by.text('View Incidents')).tap();

    await expect(element(by.text('Incidents'))).toBeVisible();

    // Tap on first incident
    const firstIncident = element(by.id('incident-item')).atIndex(0);
    await firstIncident.tap();

    // Should show incident details
    await expect(element(by.text('Incident Details'))).toBeVisible();
    await expect(element(by.id('incident-description'))).toBeVisible();
    await expect(element(by.id('incident-severity'))).toBeVisible();
    await expect(element(by.id('incident-status'))).toBeVisible();
  });

  it('should update incident status', async () => {
    // Navigate to incident details
    await element(by.text('View Incidents')).tap();
    await element(by.id('incident-item')).atIndex(0).tap();

    // Update status
    await element(by.id('status-update-button')).tap();
    await element(by.text('Investigating')).tap();

    // Should show updated status
    await expect(element(by.text('Investigating'))).toBeVisible();

    // Should show success message
    await expect(element(by.text('Status updated successfully'))).toBeVisible();
  });

  it('should handle offline incident reporting', async () => {
    // Simulate offline mode
    await device.setNetworkConnection({ type: 'none' });

    await element(by.text('Report Incident')).tap();

    // Fill out form
    await element(by.id('incident-type-picker')).tap();
    await element(by.text('Near Miss')).tap();
    await element(by.id('incident-description-input')).typeText('Offline incident report');
    await element(by.id('incident-severity-picker')).tap();
    await element(by.text('Medium')).tap();

    // Submit offline
    await element(by.text('Submit Report')).tap();

    // Should show offline success message
    await expect(element(by.text('Incident saved locally. Will sync when online.'))).toBeVisible();

    // Restore network
    await device.setNetworkConnection({ type: 'wifi' });
  });

  it('should sync data when coming back online', async () => {
    // Simulate being offline and having pending data
    await device.setNetworkConnection({ type: 'none' });

    // Create offline incident
    await element(by.text('Report Incident')).tap();
    await element(by.id('incident-type-picker')).tap();
    await element(by.text('Equipment Failure')).tap();
    await element(by.id('incident-description-input')).typeText('Sync test incident');
    await element(by.id('incident-severity-picker')).tap();
    await element(by.text('Low')).tap();
    await element(by.text('Submit Report')).tap();

    // Come back online
    await device.setNetworkConnection({ type: 'wifi' });

    // Trigger sync
    await element(by.text('Sync Data')).tap();

    // Should show sync success
    await expect(element(by.text('Data synced successfully'))).toBeVisible();
  });

  it('should handle form validation errors', async () => {
    await element(by.text('Report Incident')).tap();

    // Try to submit without required fields
    await element(by.text('Submit Report')).tap();

    // Should show validation errors
    await expect(element(by.text('Please select an incident type'))).toBeVisible();
    await expect(element(by.text('Please enter a description'))).toBeVisible();
  });

  it('should navigate back from forms', async () => {
    await element(by.text('Report Incident')).tap();

    // Navigate back
    await element(by.id('back-button')).tap();

    // Should be back on dashboard
    await expect(element(by.text('ConstructAI Safety'))).toBeVisible();
  });
});

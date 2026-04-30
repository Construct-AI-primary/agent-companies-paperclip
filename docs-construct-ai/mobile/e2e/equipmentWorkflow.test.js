/**
 * Equipment Workflow E2E Tests
 *
 * Tests the complete equipment management workflow including registration,
 * viewing details, maintenance tracking, and equipment status updates.
 */

describe('Equipment Workflow', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
    // Navigate to Equipment Dashboard
    await element(by.text('Equipment')).tap();
  });

  it('should display equipment dashboard', async () => {
    await expect(element(by.text('Equipment Dashboard'))).toBeVisible();
    await expect(element(by.text('Register Equipment'))).toBeVisible();
    await expect(element(by.text('View Equipment'))).toBeVisible();
    await expect(element(by.text('Maintenance Schedule'))).toBeVisible();
  });

  it('should navigate to equipment registration form', async () => {
    await element(by.text('Register Equipment')).tap();

    await expect(element(by.text('Register Equipment'))).toBeVisible();
    await expect(element(by.id('equipment-name-input'))).toBeVisible();
    await expect(element(by.id('equipment-type-picker'))).toBeVisible();
    await expect(element(by.id('equipment-status-picker'))).toBeVisible();
  });

  it('should register new equipment', async () => {
    await element(by.text('Register Equipment')).tap();

    // Fill out equipment form
    await element(by.id('equipment-name-input')).typeText('Excavator XYZ-123');
    await element(by.id('equipment-type-picker')).tap();
    await element(by.text('Heavy Machinery')).tap();

    await element(by.id('equipment-code-input')).typeText('EXC-001');
    await element(by.id('equipment-make-input')).typeText('Caterpillar');
    await element(by.id('equipment-model-input')).typeText('320D');
    await element(by.id('equipment-serial-input')).typeText('CAT320D2024001');

    await element(by.id('equipment-status-picker')).tap();
    await element(by.text('Active')).tap();

    await element(by.id('equipment-location-input')).typeText('Site A - Zone 3');

    // Submit the form
    await element(by.text('Register Equipment')).tap();

    // Should navigate back to dashboard
    await expect(element(by.text('Equipment Dashboard'))).toBeVisible();

    // Should show success message
    await expect(element(by.text('Equipment registered successfully'))).toBeVisible();
  });

  it('should view equipment list and details', async () => {
    await element(by.text('View Equipment')).tap();

    await expect(element(by.text('Equipment List'))).toBeVisible();

    // Should show equipment items
    await expect(element(by.id('equipment-item')).atIndex(0)).toBeVisible();

    // Tap on first equipment item
    await element(by.id('equipment-item')).atIndex(0).tap();

    // Should show equipment details
    await expect(element(by.text('Equipment Details'))).toBeVisible();
    await expect(element(by.id('equipment-name'))).toBeVisible();
    await expect(element(by.id('equipment-status'))).toBeVisible();
    await expect(element(by.id('equipment-location'))).toBeVisible();
  });

  it('should update equipment status', async () => {
    // Navigate to equipment details
    await element(by.text('View Equipment')).tap();
    await element(by.id('equipment-item')).atIndex(0).tap();

    // Update status
    await element(by.id('status-update-button')).tap();
    await element(by.text('Maintenance')).tap();

    // Should show updated status
    await expect(element(by.text('Maintenance'))).toBeVisible();

    // Should show success message
    await expect(element(by.text('Equipment status updated'))).toBeVisible();
  });

  it('should schedule maintenance for equipment', async () => {
    // Navigate to equipment details
    await element(by.text('View Equipment')).tap();
    await element(by.id('equipment-item')).atIndex(0).tap();

    // Schedule maintenance
    await element(by.text('Schedule Maintenance')).tap();

    await expect(element(by.text('Schedule Maintenance'))).toBeVisible();

    // Fill maintenance form
    await element(by.id('maintenance-type-picker')).tap();
    await element(by.text('Preventive')).tap();

    await element(by.id('maintenance-description-input')).typeText('Regular maintenance check');
    await element(by.id('maintenance-priority-picker')).tap();
    await element(by.text('Medium')).tap();

    // Set due date
    await element(by.id('maintenance-due-date-picker')).tap();
    await element(by.text('15')).tap(); // Select 15th of current month

    // Schedule maintenance
    await element(by.text('Schedule Maintenance')).tap();

    // Should show success message
    await expect(element(by.text('Maintenance scheduled successfully'))).toBeVisible();
  });

  it('should view maintenance schedule', async () => {
    await element(by.text('Maintenance Schedule')).tap();

    await expect(element(by.text('Maintenance Schedule'))).toBeVisible();

    // Should show upcoming maintenance items
    await expect(element(by.id('maintenance-item')).atIndex(0)).toBeVisible();

    // Tap on maintenance item
    await element(by.id('maintenance-item')).atIndex(0).tap();

    // Should show maintenance details
    await expect(element(by.id('maintenance-description'))).toBeVisible();
    await expect(element(by.id('maintenance-due-date'))).toBeVisible();
    await expect(element(by.id('maintenance-priority'))).toBeVisible();
  });

  it('should complete maintenance task', async () => {
    // Navigate to maintenance schedule
    await element(by.text('Maintenance Schedule')).tap();
    await element(by.id('maintenance-item')).atIndex(0).tap();

    // Mark as completed
    await element(by.text('Mark as Completed')).tap();

    // Should show completion form
    await expect(element(by.text('Complete Maintenance'))).toBeVisible();

    // Fill completion details
    await element(by.id('completion-notes-input')).typeText('Maintenance completed successfully');
    await element(by.id('completion-cost-input')).typeText('250.00');

    // Submit completion
    await element(by.text('Complete Maintenance')).tap();

    // Should show success message
    await expect(element(by.text('Maintenance completed successfully'))).toBeVisible();
  });

  it('should handle equipment search and filtering', async () => {
    await element(by.text('View Equipment')).tap();

    // Test search functionality
    await element(by.id('equipment-search-input')).typeText('Excavator');

    // Should filter results
    await expect(element(by.id('equipment-item')).atIndex(0)).toBeVisible();

    // Test status filter
    await element(by.id('status-filter-button')).tap();
    await element(by.text('Active')).tap();

    // Should show only active equipment
    const equipmentItems = element(by.id('equipment-item'));
    await expect(equipmentItems).toBeVisible();
  });

  it('should generate equipment reports', async () => {
    await element(by.text('Equipment Reports')).tap();

    await expect(element(by.text('Equipment Reports'))).toBeVisible();

    // Generate utilization report
    await element(by.text('Utilization Report')).tap();

    await expect(element(by.text('Equipment Utilization Report'))).toBeVisible();
    await expect(element(by.id('utilization-chart'))).toBeVisible();

    // Generate maintenance report
    await element(by.text('Maintenance Report')).tap();

    await expect(element(by.text('Maintenance Report'))).toBeVisible();
    await expect(element(by.id('maintenance-summary'))).toBeVisible();
  });

  it('should handle equipment offline operations', async () => {
    // Simulate offline mode
    await device.setNetworkConnection({ type: 'none' });

    await element(by.text('Register Equipment')).tap();

    // Fill out form offline
    await element(by.id('equipment-name-input')).typeText('Offline Equipment Test');
    await element(by.id('equipment-type-picker')).tap();
    await element(by.text('Tools')).tap();
    await element(by.id('equipment-status-picker')).tap();
    await element(by.text('Active')).tap();

    // Submit offline
    await element(by.text('Register Equipment')).tap();

    // Should show offline success message
    await expect(element(by.text('Equipment saved locally. Will sync when online.'))).toBeVisible();

    // Restore network
    await device.setNetworkConnection({ type: 'wifi' });
  });

  it('should sync equipment data when online', async () => {
    // Simulate offline equipment registration
    await device.setNetworkConnection({ type: 'none' });

    await element(by.text('Register Equipment')).tap();
    await element(by.id('equipment-name-input')).typeText('Sync Test Equipment');
    await element(by.id('equipment-type-picker')).tap();
    await element(by.text('Vehicles')).tap();
    await element(by.id('equipment-status-picker')).tap();
    await element(by.text('Active')).tap();
    await element(by.text('Register Equipment')).tap();

    // Come back online and sync
    await device.setNetworkConnection({ type: 'wifi' });
    await element(by.text('Sync Data')).tap();

    // Should show sync success
    await expect(element(by.text('Equipment data synced successfully'))).toBeVisible();
  });

  it('should handle equipment form validation', async () => {
    await element(by.text('Register Equipment')).tap();

    // Try to submit without required fields
    await element(by.text('Register Equipment')).tap();

    // Should show validation errors
    await expect(element(by.text('Please enter equipment name'))).toBeVisible();
    await expect(element(by.text('Please select equipment type'))).toBeVisible();
  });

  it('should navigate back from equipment forms', async () => {
    await element(by.text('Register Equipment')).tap();

    // Navigate back
    await element(by.id('back-button')).tap();

    // Should be back on dashboard
    await expect(element(by.text('Equipment Dashboard'))).toBeVisible();
  });
});

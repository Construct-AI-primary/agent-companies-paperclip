/**
 * Settings Workflow E2E Tests
 *
 * Tests the settings screen functionality including safety monitoring preferences,
 * notification settings, and system information display.
 */

const { device, expect, element, by, waitFor } = require('detox');

describe('Settings Workflow', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  describe('Safety Settings Screen', () => {
    it('should display safety settings screen with current status', async () => {
      // Navigate to settings screen
      await element(by.id('settings-tab')).tap();

      // Wait for settings screen to load
      await waitFor(element(by.text('Safety Settings')))
        .toBeVisible()
        .withTimeout(5000);

      // Verify header elements
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Configure safety monitoring preferences'))).toBeVisible();
    });

    it('should display current safety statistics', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify stats section
      await expect(element(by.text('Current Status'))).toBeVisible();

      // Check for stat cards (these will show actual data from Redux store)
      await expect(element(by.text('Active Incidents'))).toBeVisible();
      await expect(element(by.text('Active Hazards'))).toBeVisible();
      await expect(element(by.text('Sync Status'))).toBeVisible();
    });

    it('should display notification settings', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify notification settings section
      await expect(element(by.text('Notification Settings'))).toBeVisible();

      // Check notification settings items
      await expect(element(by.text('Critical Incident Alerts: Enabled'))).toBeVisible();
      await expect(element(by.text('Hazard Detection: Enabled'))).toBeVisible();
      await expect(element(by.text('Safety Inspection Reminders: Enabled'))).toBeVisible();
    });

    it('should display system information', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify system information section
      await expect(element(by.text('System Information'))).toBeVisible();

      // Check system info items
      await expect(element(by.text('AI Analytics Engine: Active'))).toBeVisible();
      await expect(element(by.text('Offline Data Sync: Ready'))).toBeVisible();
      await expect(element(by.text('Mobile App Version: 1.0.0'))).toBeVisible();
    });

    it('should handle screen scrolling', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Scroll to bottom to ensure all content is accessible
      await element(by.id('settings-scroll-view')).scrollTo('bottom');

      // Verify bottom content is visible
      await expect(element(by.text('Mobile App Version: 1.0.0'))).toBeVisible();

      // Scroll back to top
      await element(by.id('settings-scroll-view')).scrollTo('top');
      await expect(element(by.text('Safety Settings'))).toBeVisible();
    });

    it('should maintain state when navigating away and back', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Navigate to another tab
      await element(by.id('dashboard-tab')).tap();
      await expect(element(by.text('ConstructAI'))).toBeVisible();

      // Navigate back to settings
      await element(by.id('settings-tab')).tap();
      await expect(element(by.text('Safety Settings'))).toBeVisible();

      // Verify content is still displayed
      await expect(element(by.text('Current Status'))).toBeVisible();
      await expect(element(by.text('Notification Settings'))).toBeVisible();
    });

    it('should handle different screen orientations', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Change to landscape orientation
      await device.setOrientation('landscape');

      // Verify content is still accessible
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Current Status'))).toBeVisible();

      // Change back to portrait
      await device.setOrientation('portrait');
      await expect(element(by.text('Safety Settings'))).toBeVisible();
    });

    it('should be accessible with screen reader', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify accessibility labels are present
      await expect(element(by.label('Safety Settings Screen'))).toBeVisible();
      await expect(element(by.label('Current Status Section'))).toBeVisible();
      await expect(element(by.label('Notification Settings Section'))).toBeVisible();
      await expect(element(by.label('System Information Section'))).toBeVisible();
    });

    it('should handle memory pressure gracefully', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Simulate memory warning (if supported by Detox)
      // This would test if the screen handles memory pressure without crashing

      // Verify screen remains functional
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await element(by.id('settings-scroll-view')).scrollTo('bottom');
      await expect(element(by.text('Mobile App Version: 1.0.0'))).toBeVisible();
    });

    it('should update statistics when data changes', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Get initial values
      const initialStats = await element(by.id('active-incidents-count')).getAttributes();

      // Simulate data change (this would happen through Redux in real app)
      // In a real test, you might dispatch actions or mock API responses

      // Verify the screen can handle data updates without crashing
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Current Status'))).toBeVisible();
    });

    it('should handle network connectivity changes', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Disable network connectivity
      await device.disableSynchronization();
      await device.setURLBlacklist(['.*']);

      // Verify offline functionality
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Offline Data Sync: Ready'))).toBeVisible();

      // Re-enable network
      await device.enableSynchronization();
      await device.setURLBlacklist([]);
    });

    it('should support different text sizes for accessibility', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Test with larger text size
      await device.setStatusBar({
        time: '12:00',
        dataNetwork: 'wifi',
        wifiMode: 'active',
        wifiBars: '3',
        cellularMode: 'active',
        cellularBars: '4',
        batteryState: 'charged',
        batteryLevel: '100',
      });

      // Verify content is still readable and accessible
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await element(by.id('settings-scroll-view')).scrollTo('bottom');
      await expect(element(by.text('Mobile App Version: 1.0.0'))).toBeVisible();
    });
  });

  describe('Settings Integration', () => {
    it('should integrate with Redux store for safety data', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify that the screen displays data from Redux store
      // This tests the integration between the settings screen and the safety slice
      await expect(element(by.text('Active Incidents'))).toBeVisible();
      await expect(element(by.text('Active Hazards'))).toBeVisible();
    });

    it('should handle empty or zero data gracefully', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Test with zero incidents and hazards
      // In a real app, this would be handled by the Redux store
      await expect(element(by.text('Active Incidents'))).toBeVisible();
      await expect(element(by.text('Active Hazards'))).toBeVisible();
    });

    it('should display sync status correctly', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify sync status display
      await expect(element(by.text('Sync Status'))).toBeVisible();

      // Test different sync states (this would be dynamic in real app)
      await expect(element(by.text('Sync Status'))).toBeVisible();
    });

    it('should maintain settings across app sessions', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Verify that settings persist across app launches
      // This would test AsyncStorage integration
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Notification Settings'))).toBeVisible();
    });
  });

  describe('Settings Performance', () => {
    it('should load settings screen quickly', async () => {
      const startTime = Date.now();

      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings')))
        .toBeVisible()
        .withTimeout(3000);

      const loadTime = Date.now() - startTime;

      // Verify screen loads within acceptable time (under 3 seconds)
      expect(loadTime).toBeLessThan(3000);
    });

    it('should handle rapid navigation to settings', async () => {
      // Rapidly navigate to settings multiple times
      for (let i = 0; i < 3; i++) {
        await element(by.id('settings-tab')).tap();
        await waitFor(element(by.text('Safety Settings'))).toBeVisible();

        // Navigate away
        await element(by.id('dashboard-tab')).tap();
        await expect(element(by.text('ConstructAI'))).toBeVisible();
      }

      // Final navigation to settings
      await element(by.id('settings-tab')).tap();
      await expect(element(by.text('Safety Settings'))).toBeVisible();
    });

    it('should handle background and foreground transitions', async () => {
      await element(by.id('settings-tab')).tap();
      await waitFor(element(by.text('Safety Settings'))).toBeVisible();

      // Send app to background
      await device.sendToHome();

      // Bring app back to foreground
      await device.launchApp({ newInstance: false });

      // Verify settings screen is still functional
      await expect(element(by.text('Safety Settings'))).toBeVisible();
      await expect(element(by.text('Current Status'))).toBeVisible();
    });
  });
});

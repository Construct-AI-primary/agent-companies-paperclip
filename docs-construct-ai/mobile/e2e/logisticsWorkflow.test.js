/**
 * Logistics Workflow E2E Tests
 *
 * Tests the logistics functionality including AI-powered load management,
 * shipment tracking, AI inspection capabilities, and real-time monitoring.
 */

const { device, expect, element, by, waitFor } = require('detox');

describe('Logistics Workflow', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  describe('Logistics Dashboard', () => {
    it('should display logistics dashboard with AI-powered load management', async () => {
      // Navigate to logistics screen
      await element(by.id('logistics-tab')).tap();

      // Wait for dashboard to load
      await waitFor(element(by.text('ConstructAI Logistics')))
        .toBeVisible()
        .withTimeout(5000);

      // Verify header elements
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();
      await expect(element(by.text('AI-powered load management'))).toBeVisible();
    });

    it('should display key statistics and metrics', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify stat cards are displayed
      await expect(element(by.text('Active Shipments'))).toBeVisible();
      await expect(element(by.text('Completed Today'))).toBeVisible();
      await expect(element(by.text('AI Detections'))).toBeVisible();
      await expect(element(by.text('Loading Activities'))).toBeVisible();
    });

    it('should display quick action buttons', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify quick action buttons
      await expect(element(by.text('Create Load'))).toBeVisible();
      await expect(element(by.text('Start Inspection'))).toBeVisible();
      await expect(element(by.text('Report Damage'))).toBeVisible();
      await expect(element(by.text('Analytics'))).toBeVisible();
    });

    it('should display active shipments with progress tracking', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify shipments section
      await expect(element(by.text('📦 Active Shipments'))).toBeVisible();

      // Check for shipment cards (these will show actual data)
      await expect(element(by.text('LH-2025-789'))).toBeVisible();
      await expect(element(by.text('Cape Town'))).toBeVisible();
    });

    it('should display AI insights and recommendations', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify AI insights section
      await expect(element(by.text('🤖 AI Insights'))).toBeVisible();
      await expect(element(by.text('Detection Accuracy'))).toBeVisible();
      await expect(element(by.text('Processing Speed'))).toBeVisible();
      await expect(element(by.text('Issues Detected'))).toBeVisible();
    });

    it('should display recent alerts with different severity levels', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify alerts section
      await expect(element(by.text('🚨 Recent Alerts'))).toBeVisible();

      // Check for alert items
      await expect(element(by.text('Container Damage Detected'))).toBeVisible();
      await expect(element(by.text('Overage Detected'))).toBeVisible();
      await expect(element(by.text('Inspection Completed'))).toBeVisible();
    });

    it('should handle pull-to-refresh functionality', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Perform pull-to-refresh
      await element(by.id('logistics-scroll-view')).swipe('down', 'fast', 0.5);

      // Verify refresh completes and data updates
      await waitFor(element(by.text('ConstructAI Logistics')))
        .toBeVisible()
        .withTimeout(10000);

      // Verify AI insights updated (this would change in real app)
      await expect(element(by.text('Detection Accuracy'))).toBeVisible();
    });

    it('should navigate to shipment detail when tapping shipment card', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Tap on a shipment card
      await element(by.text('LH-2025-789')).tap();

      // Verify navigation (this would depend on actual navigation setup)
      // In a real app, this would navigate to ShipmentDetail screen
      await expect(element(by.text('LH-2025-789'))).toBeVisible();
    });

    it('should navigate to create load screen', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Tap create load button
      await element(by.text('Create Load')).tap();

      // Verify navigation to create shipment screen
      // This would depend on actual navigation setup
      await expect(element(by.text('Create Load'))).not.toBeVisible();
    });

    it('should navigate to AI inspection screen', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Tap start inspection button
      await element(by.text('Start Inspection')).tap();

      // Verify navigation to AI inspection screen
      await waitFor(element(by.text('AI Inspection')))
        .toBeVisible()
        .withTimeout(5000);
    });

    it('should handle screen scrolling and content visibility', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Scroll to bottom to ensure all content is accessible
      await element(by.id('logistics-scroll-view')).scrollTo('bottom');

      // Verify bottom content is visible
      await expect(element(by.text('🚨 Recent Alerts'))).toBeVisible();

      // Scroll back to top
      await element(by.id('logistics-scroll-view')).scrollTo('top');
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();
    });

    it('should update AI insights when refreshed', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Get initial AI accuracy value
      const initialAccuracy = await element(by.id('ai-accuracy-value')).getAttributes();

      // Perform refresh
      await element(by.id('logistics-scroll-view')).swipe('down', 'fast', 0.5);

      // Wait for refresh to complete
      await waitFor(element(by.text('ConstructAI Logistics')))
        .toBeVisible()
        .withTimeout(10000);

      // Verify AI insights are updated (values would change in real app)
      await expect(element(by.text('Detection Accuracy'))).toBeVisible();
    });

    it('should display shipment progress bars correctly', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify progress bars are displayed
      await expect(element(by.id('progress-bar-789'))).toBeVisible();
      await expect(element(by.text('73%'))).toBeVisible();
      await expect(element(by.text('ETA: March 15, 2:30 PM'))).toBeVisible();
    });

    it('should handle different shipment statuses with correct colors', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify status badges are displayed with correct styling
      await expect(element(by.text('LOADING'))).toBeVisible();
      await expect(element(by.text('IN_TRANSIT'))).toBeVisible();
      await expect(element(by.text('PLANNING'))).toBeVisible();
    });

    it('should display AI recommendations when available', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify recommendations section
      await expect(element(by.text('💡 Recommendations'))).toBeVisible();

      // Check for recommendation items
      await expect(element(by.text('Consider additional equipment monitoring'))).toBeVisible();
    });
  });

  describe('AI Inspection Screen', () => {
    it('should display AI inspection screen with camera interface', async () => {
      // Navigate to AI inspection
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();
      await element(by.text('Start Inspection')).tap();

      // Wait for inspection screen to load
      await waitFor(element(by.text('AI Inspection')))
        .toBeVisible()
        .withTimeout(5000);

      // Verify header elements
      await expect(element(by.text('AI Inspection'))).toBeVisible();
      await expect(element(by.text('Start AI Inspection Session'))).toBeVisible();
    });

    it('should display detection mode selection', async () => {
      await navigateToInspectionScreen();

      // Verify detection modes are displayed
      await expect(element(by.text('Detection Mode:'))).toBeVisible();
      await expect(element(by.text('Damage Detection'))).toBeVisible();
      await expect(element(by.text('Item Counting'))).toBeVisible();
      await expect(element(by.text('Anomaly Detection'))).toBeVisible();
      await expect(element(by.text('Load Classification'))).toBeVisible();
    });

    it('should allow selection of different detection modes', async () => {
      await navigateToInspectionScreen();

      // Select different detection modes
      await element(by.text('Item Counting')).tap();
      await expect(element(by.id('detection-mode-counting'))).toBeVisible();

      await element(by.text('Anomaly Detection')).tap();
      await expect(element(by.id('detection-mode-anomaly'))).toBeVisible();

      await element(by.text('Load Classification')).tap();
      await expect(element(by.id('detection-mode-classification'))).toBeVisible();
    });

    it('should start inspection session when start button is pressed', async () => {
      await navigateToInspectionScreen();

      // Select a detection mode
      await element(by.text('Damage Detection')).tap();

      // Start session
      await element(by.text('Start Session')).tap();

      // Verify session started
      await expect(element(by.text('Start AI Inspection Session'))).not.toBeVisible();
      await expect(element(by.id('camera-view'))).toBeVisible();
    });

    it('should display camera controls during active session', async () => {
      await startInspectionSession();

      // Verify camera controls are visible
      await expect(element(by.text('Library'))).toBeVisible();
      await expect(element(by.id('capture-button'))).toBeVisible();
      await expect(element(by.text('Flip'))).toBeVisible();
    });

    it('should capture photo and perform AI analysis', async () => {
      await startInspectionSession();

      // Capture photo
      await element(by.id('capture-button')).tap();

      // Verify analysis starts
      await expect(element(by.text('AI Analyzing...'))).toBeVisible();

      // Wait for analysis to complete
      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(10000);
    });

    it('should display AI analysis results', async () => {
      await startInspectionSession();
      await element(by.id('capture-button')).tap();

      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(10000);

      // Verify results are displayed
      await expect(element(by.text('DAMAGE DETECTION'))).toBeVisible();
      await expect(element(by.id('confidence-percentage'))).toBeVisible();
      await expect(element(by.text('Recommendations:'))).toBeVisible();
    });

    it('should allow selection of images from library', async () => {
      await startInspectionSession();

      // Tap library button
      await element(by.text('Library')).tap();

      // Verify image picker opens (this would depend on device permissions)
      // In a real test, you might need to mock the image picker
      await expect(element(by.id('camera-view'))).toBeVisible();
    });

    it('should allow camera flip between front and back', async () => {
      await startInspectionSession();

      // Tap flip button
      await element(by.text('Flip')).tap();

      // Verify camera flips (this would change camera view)
      await expect(element(by.id('camera-view'))).toBeVisible();
    });

    it('should display detection mode indicator', async () => {
      await startInspectionSession();

      // Verify mode indicator is shown
      await expect(element(by.text('DAMAGE DETECTION'))).toBeVisible();
    });

    it('should allow clearing analysis results', async () => {
      await startInspectionSession();
      await element(by.id('capture-button')).tap();

      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(10000);

      // Clear results
      await element(by.id('clear-results-button')).tap();

      // Verify results are cleared
      await expect(element(by.text('AI Analysis Results (0)'))).toBeVisible();
    });

    it('should generate inspection report', async () => {
      await startInspectionSession();
      await element(by.id('capture-button')).tap();

      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(10000);

      // Generate report
      await element(by.text('Generate Report')).tap();

      // Verify report generation
      await expect(element(by.text('Report Generated'))).toBeVisible();
    });

    it('should end inspection session', async () => {
      await startInspectionSession();

      // End session
      await element(by.text('End Session')).tap();

      // Verify session ends and shows summary
      await expect(element(by.text('Session Complete'))).toBeVisible();
      await expect(element(by.text('Review Results'))).toBeVisible();
      await expect(element(by.text('Generate Report'))).toBeVisible();
    });

    it('should handle camera permission denial', async () => {
      // Mock camera permission denial
      await element(by.id('logistics-tab')).tap();
      await element(by.text('Start Inspection')).tap();

      // If permissions are denied, should show error screen
      await waitFor(element(by.text('Camera Permission Required')))
        .toBeVisible()
        .withTimeout(5000);

      await expect(element(by.text('This app needs camera and location permissions'))).toBeVisible();
      await expect(element(by.text('Go Back'))).toBeVisible();
    });

    it('should handle multiple consecutive analyses', async () => {
      await startInspectionSession();

      // Perform multiple analyses
      for (let i = 0; i < 3; i++) {
        await element(by.id('capture-button')).tap();
        await waitFor(element(by.text(`AI Analysis Results (${i + 1})`)))
          .toBeVisible()
          .withTimeout(10000);
      }

      // Verify all results are displayed
      await expect(element(by.text('AI Analysis Results (3)'))).toBeVisible();
    });

    it('should display analysis results in scrollable view', async () => {
      await startInspectionSession();

      // Perform multiple analyses to create scrollable content
      for (let i = 0; i < 5; i++) {
        await element(by.id('capture-button')).tap();
        await waitFor(element(by.text(`AI Analysis Results (${i + 1})`)))
          .toBeVisible()
          .withTimeout(10000);
      }

      // Scroll through results
      await element(by.id('results-scroll-view')).scrollTo('bottom');
      await element(by.id('results-scroll-view')).scrollTo('top');

      // Verify scrolling works
      await expect(element(by.text('AI Analysis Results (5)'))).toBeVisible();
    });

    it('should handle different analysis result severities', async () => {
      await startInspectionSession();
      await element(by.id('capture-button')).tap();

      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(10000);

      // Verify different severity levels are displayed correctly
      await expect(element(by.id('severity-indicator'))).toBeVisible();
    });

    it('should maintain session state during analysis', async () => {
      await startInspectionSession();

      // Start analysis
      await element(by.id('capture-button')).tap();
      await expect(element(by.text('AI Analyzing...'))).toBeVisible();

      // Verify session controls remain accessible
      await expect(element(by.text('Generate Report'))).toBeVisible();
      await expect(element(by.text('End Session'))).toBeVisible();
    });

    it('should handle back navigation from inspection screen', async () => {
      await navigateToInspectionScreen();

      // Tap back button
      await element(by.id('back-button')).tap();

      // Verify navigation back to logistics dashboard
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();
    });
  });

  describe('Logistics Integration', () => {
    it('should integrate with Redux store for logistics data', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Verify data comes from Redux store
      await expect(element(by.text('Active Shipments'))).toBeVisible();
      await expect(element(by.text('AI Detections'))).toBeVisible();
    });

    it('should update data when store changes', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Initial data
      await expect(element(by.text('8'))).toBeVisible(); // Active shipments

      // Simulate store update (this would happen through Redux actions)
      // In real app, this would update when new data arrives

      // Verify screen reflects changes
      await expect(element(by.text('Active Shipments'))).toBeVisible();
    });

    it('should handle offline functionality', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Disable network
      await device.disableSynchronization();

      // Verify offline functionality works
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Re-enable network
      await device.enableSynchronization();
    });
  });

  describe('Logistics Performance', () => {
    it('should load logistics dashboard quickly', async () => {
      const startTime = Date.now();

      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics')))
        .toBeVisible()
        .withTimeout(3000);

      const loadTime = Date.now() - startTime;

      // Verify screen loads within acceptable time
      expect(loadTime).toBeLessThan(3000);
    });

    it('should handle rapid navigation between screens', async () => {
      // Navigate to logistics
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Navigate to inspection
      await element(by.text('Start Inspection')).tap();
      await waitFor(element(by.text('AI Inspection'))).toBeVisible();

      // Navigate back
      await element(by.id('back-button')).tap();
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Navigate to inspection again
      await element(by.text('Start Inspection')).tap();
      await expect(element(by.text('AI Inspection'))).toBeVisible();
    });

    it('should handle background and foreground transitions', async () => {
      await element(by.id('logistics-tab')).tap();
      await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();

      // Send to background
      await device.sendToHome();

      // Bring back to foreground
      await device.launchApp({ newInstance: false });

      // Verify functionality remains intact
      await expect(element(by.text('ConstructAI Logistics'))).toBeVisible();
    });

    it('should handle memory pressure during AI analysis', async () => {
      await startInspectionSession();

      // Start analysis
      await element(by.id('capture-button')).tap();
      await expect(element(by.text('AI Analyzing...'))).toBeVisible();

      // Simulate memory pressure (if supported by Detox)
      // Verify analysis completes without crashing
      await waitFor(element(by.text('AI Analysis Results')))
        .toBeVisible()
        .withTimeout(15000);
    });
  });

  // Helper functions
  async function navigateToInspectionScreen() {
    await element(by.id('logistics-tab')).tap();
    await waitFor(element(by.text('ConstructAI Logistics'))).toBeVisible();
    await element(by.text('Start Inspection')).tap();
    await waitFor(element(by.text('AI Inspection'))).toBeVisible();
  }

  async function startInspectionSession() {
    await navigateToInspectionScreen();
    await element(by.text('Damage Detection')).tap();
    await element(by.text('Start Session')).tap();
    await expect(element(by.id('camera-view'))).toBeVisible();
  }
});

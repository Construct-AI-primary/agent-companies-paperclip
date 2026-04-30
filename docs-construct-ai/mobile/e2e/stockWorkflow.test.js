/**
 * Stock Management Workflow E2E Tests
 *
 * Tests the complete stock management workflow including AI-powered inventory
 * tracking, alerts management, scanning functionality, and analytics.
 */

describe('Stock Management Workflow', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
    // Ensure we're on the Stock Dashboard (initial screen)
    await expect(element(by.text('ConstructAI Stock'))).toBeVisible();
  });

  it('should display stock dashboard with key metrics', async () => {
    await expect(element(by.text('ConstructAI Stock'))).toBeVisible();
    await expect(element(by.text('AI-powered inventory management'))).toBeVisible();

    // Check key statistics are displayed
    await expect(element(by.text('Total Items'))).toBeVisible();
    await expect(element(by.text('Stock Value'))).toBeVisible();
    await expect(element(by.text('Low Stock'))).toBeVisible();
    await expect(element(by.text('AI Scans Today'))).toBeVisible();
  });

  it('should display quick action buttons', async () => {
    await expect(element(by.text('Scan Stock'))).toBeVisible();
    await expect(element(by.text('Inventory'))).toBeVisible();
    await expect(element(by.text('AI Analytics'))).toBeVisible();
    await expect(element(by.id('alerts-button'))).toBeVisible();
  });

  it('should navigate to stock scanner', async () => {
    await element(by.text('Scan Stock')).tap();

    await expect(element(by.text('Stock Scanner'))).toBeVisible();
    await expect(element(by.id('camera-view'))).toBeVisible();
    await expect(element(by.text('Scan Item'))).toBeVisible();
  });

  it('should perform stock scanning workflow', async () => {
    await element(by.text('Scan Stock')).tap();

    // Test manual entry fallback
    await element(by.text('Manual Entry')).tap();

    await expect(element(by.text('Manual Stock Entry'))).toBeVisible();

    // Fill manual entry form
    await element(by.id('item-sku-input')).typeText('STEEL-REINF-001');
    await element(by.id('item-name-input')).typeText('Steel Reinforcement Bars');
    await element(by.id('quantity-input')).typeText('45');
    await element(by.id('location-input')).typeText('A-03-12');

    // Submit manual entry
    await element(by.text('Add to Inventory')).tap();

    // Should show success message
    await expect(element(by.text('Item added successfully'))).toBeVisible();

    // Should navigate back to scanner
    await expect(element(by.text('Stock Scanner'))).toBeVisible();
  });

  it('should navigate to inventory list', async () => {
    await element(by.text('Inventory')).tap();

    await expect(element(by.text('Inventory List'))).toBeVisible();
    await expect(element(by.id('search-input'))).toBeVisible();
    await expect(element(by.id('filter-button'))).toBeVisible();
  });

  it('should search and filter inventory', async () => {
    await element(by.text('Inventory')).tap();

    // Test search functionality
    await element(by.id('search-input')).typeText('Steel');

    // Should filter results
    await expect(element(by.text('Steel Reinforcement Bars'))).toBeVisible();

    // Test filter by status
    await element(by.id('filter-button')).tap();
    await element(by.text('Low Stock')).tap();

    // Should show only low stock items
    await expect(element(by.id('low-stock-indicator'))).toBeVisible();
  });

  it('should view item details', async () => {
    await element(by.text('Inventory')).tap();

    // Tap on first item
    const firstItem = element(by.id('inventory-item')).atIndex(0);
    await firstItem.tap();

    // Should show item details
    await expect(element(by.text('Item Details'))).toBeVisible();
    await expect(element(by.id('item-sku'))).toBeVisible();
    await expect(element(by.id('item-name'))).toBeVisible();
    await expect(element(by.id('current-stock'))).toBeVisible();
    await expect(element(by.id('min-stock-level'))).toBeVisible();
  });

  it('should update stock levels', async () => {
    await element(by.text('Inventory')).tap();
    await element(by.id('inventory-item')).atIndex(0).tap();

    // Update stock quantity
    await element(by.text('Update Stock')).tap();

    await expect(element(by.text('Update Stock Level'))).toBeVisible();

    // Enter new quantity
    await element(by.id('new-quantity-input')).typeText('75');
    await element(by.id('update-reason-input')).typeText('Received new delivery');

    // Submit update
    await element(by.text('Update Stock')).tap();

    // Should show success message
    await expect(element(by.text('Stock updated successfully'))).toBeVisible();
  });

  it('should navigate to AI analytics', async () => {
    await element(by.text('AI Analytics')).tap();

    await expect(element(by.text('AI Analytics Dashboard'))).toBeVisible();
    await expect(element(by.text('Detection Accuracy'))).toBeVisible();
    await expect(element(by.text('Stock Optimization'))).toBeVisible();
  });

  it('should display AI insights and predictions', async () => {
    // AI insights should be visible on main dashboard
    await expect(element(by.text('AI Insights'))).toBeVisible();
    await expect(element(by.text('Detection Accuracy'))).toBeVisible();

    // Check for AI predictions
    await expect(element(by.text('AI Predictions'))).toBeVisible();

    // Should show prediction items
    const predictionItems = element(by.id('prediction-item'));
    await expect(predictionItems).toBeVisible();
  });

  it('should handle AI prediction interactions', async () => {
    // Find actionable prediction
    const actionablePrediction = element(by.id('actionable-prediction')).atIndex(0);

    if (await actionablePrediction.isVisible()) {
      await actionablePrediction.tap();

      // Should show prediction details or action options
      await expect(element(by.text('Prediction Details'))).toBeVisible();
      await expect(element(by.text('Take Action'))).toBeVisible();
    }
  });

  it('should display and manage alerts', async () => {
    await expect(element(by.text('Recent Alerts'))).toBeVisible();

    // Should show alert items
    const alertItems = element(by.id('alert-item'));
    await expect(alertItems.atIndex(0)).toBeVisible();

    // Tap on first alert
    await alertItems.atIndex(0).tap();

    // Should show alert details
    await expect(element(by.text('Alert Details'))).toBeVisible();
    await expect(element(by.id('alert-message'))).toBeVisible();
    await expect(element(by.id('ai-recommendation'))).toBeVisible();
  });

  it('should acknowledge alerts', async () => {
    // Navigate to alerts section
    await element(by.text('View All')).tap();

    await expect(element(by.text('Alert Center'))).toBeVisible();

    // Find unacknowledged alert
    const unacknowledgedAlert = element(by.id('unacknowledged-alert')).atIndex(0);
    await unacknowledgedAlert.tap();

    // Acknowledge the alert
    await element(by.text('Mark as Acknowledged')).tap();

    // Should show success message
    await expect(element(by.text('Alert acknowledged'))).toBeVisible();

    // Alert should no longer appear in unacknowledged list
    await expect(unacknowledgedAlert).toBeNotVisible();
  });

  it('should handle pull-to-refresh functionality', async () => {
    const { getByText } = require('@testing-library/react-native');

    // Perform pull-to-refresh
    await element(by.id('scroll-view')).swipe('down', 'fast');

    // Should show refresh indicator
    await expect(element(by.id('refresh-indicator'))).toBeVisible();

    // Wait for refresh to complete
    await new Promise(resolve => setTimeout(resolve, 3000));

    // Refresh should complete
    await expect(element(by.id('refresh-indicator'))).toBeNotVisible();

    // Should show updated data or success message
    await expect(element(by.text('Data refreshed'))).toBeVisible();
  });

  it('should display recent items with AI status', async () => {
    await expect(element(by.text('Recent Items'))).toBeVisible();

    // Should show item cards
    const itemCards = element(by.id('item-card'));
    await expect(itemCards.atIndex(0)).toBeVisible();

    // Check for AI status indicators
    await expect(element(by.id('ai-status-badge'))).toBeVisible();
    await expect(element(by.id('ai-confidence-score'))).toBeVisible();
  });

  it('should navigate to item detail from recent items', async () => {
    const itemCards = element(by.id('item-card'));
    await itemCards.atIndex(0).tap();

    // Should navigate to item detail screen
    await expect(element(by.text('Item Details'))).toBeVisible();
    await expect(element(by.id('item-sku'))).toBeVisible();
    await expect(element(by.id('item-location'))).toBeVisible();
    await expect(element(by.id('stock-history'))).toBeVisible();
  });

  it('should handle low stock alerts', async () => {
    // Find item with low stock status
    const lowStockItem = element(by.id('low-stock-item')).atIndex(0);

    if (await lowStockItem.isVisible()) {
      await lowStockItem.tap();

      // Should show low stock warning
      await expect(element(by.text('Low Stock Alert'))).toBeVisible();
      await expect(element(by.text('Reorder Recommended'))).toBeVisible();

      // Should show reorder options
      await expect(element(by.text('Create Purchase Order'))).toBeVisible();
    }
  });

  it('should handle expiry alerts', async () => {
    // Find item with expiry warning
    const expiringItem = element(by.id('expiring-item')).atIndex(0);

    if (await expiringItem.isVisible()) {
      await expiringItem.tap();

      // Should show expiry warning
      await expect(element(by.text('Expiry Alert'))).toBeVisible();
      await expect(element(by.id('expiry-date'))).toBeVisible();

      // Should show expiry management options
      await expect(element(by.text('Use First'))).toBeVisible();
      await expect(element(by.text('Check Alternatives'))).toBeVisible();
    }
  });

  it('should generate stock reports', async () => {
    await element(by.text('AI Analytics')).tap();

    // Navigate to reports section
    await element(by.text('Reports')).tap();

    await expect(element(by.text('Stock Reports'))).toBeVisible();

    // Generate inventory report
    await element(by.text('Inventory Report')).tap();

    await expect(element(by.text('Generating Report...'))).toBeVisible();

    // Wait for report generation
    await new Promise(resolve => setTimeout(resolve, 2000));

    // Should show report results
    await expect(element(by.text('Inventory Report'))).toBeVisible();
    await expect(element(by.id('report-summary'))).toBeVisible();
  });

  it('should handle offline stock operations', async () => {
    // Simulate offline mode
    await device.setNetworkConnection({ type: 'none' });

    // Try to scan stock
    await element(by.text('Scan Stock')).tap();

    // Should show offline indicator
    await expect(element(by.text('Offline Mode'))).toBeVisible();

    // Try manual entry
    await element(by.text('Manual Entry')).tap();

    // Fill form
    await element(by.id('item-sku-input')).typeText('OFFLINE-TEST-001');
    await element(by.id('item-name-input')).typeText('Offline Test Item');
    await element(by.id('quantity-input')).typeText('10');

    // Submit offline
    await element(by.text('Save Locally')).tap();

    // Should show offline success message
    await expect(element(by.text('Saved locally. Will sync when online.'))).toBeVisible();

    // Restore network
    await device.setNetworkConnection({ type: 'wifi' });
  });

  it('should sync offline data when online', async () => {
    // Simulate having offline data and coming back online
    await device.setNetworkConnection({ type: 'none' });

    // Create offline entry
    await element(by.text('Scan Stock')).tap();
    await element(by.text('Manual Entry')).tap();
    await element(by.id('item-sku-input')).typeText('SYNC-TEST-001');
    await element(by.id('item-name-input')).typeText('Sync Test Item');
    await element(by.id('quantity-input')).typeText('5');
    await element(by.text('Save Locally')).tap();

    // Come back online
    await device.setNetworkConnection({ type: 'wifi' });

    // Trigger sync
    await element(by.text('Sync Data')).tap();

    // Should show sync progress
    await expect(element(by.text('Syncing data...'))).toBeVisible();

    // Should show sync success
    await expect(element(by.text('Data synced successfully'))).toBeVisible();
  });

  it('should handle stock form validation', async () => {
    await element(by.text('Scan Stock')).tap();
    await element(by.text('Manual Entry')).tap();

    // Try to submit without required fields
    await element(by.text('Add to Inventory')).tap();

    // Should show validation errors
    await expect(element(by.text('Please enter item SKU'))).toBeVisible();
    await expect(element(by.text('Please enter item name'))).toBeVisible();
    await expect(element(by.text('Please enter quantity'))).toBeVisible();
  });

  it('should navigate back from stock screens', async () => {
    await element(by.text('Scan Stock')).tap();

    // Navigate back
    await element(by.id('back-button')).tap();

    // Should be back on dashboard
    await expect(element(by.text('ConstructAI Stock'))).toBeVisible();
  });

  it('should handle bulk stock operations', async () => {
    await element(by.text('Inventory')).tap();

    // Select multiple items for bulk operation
    await element(by.id('select-mode-button')).tap();

    const itemCheckboxes = element(by.id('item-checkbox'));
    await itemCheckboxes.atIndex(0).tap();
    await itemCheckboxes.atIndex(1).tap();

    // Perform bulk update
    await element(by.text('Bulk Update')).tap();

    await expect(element(by.text('Bulk Stock Update'))).toBeVisible();

    // Update quantity for all selected items
    await element(by.id('bulk-quantity-input')).typeText('50');
    await element(by.text('Apply to All')).tap();

    // Should show success message
    await expect(element(by.text('Bulk update completed'))).toBeVisible();
  });

  it('should display stock trends and analytics', async () => {
    await element(by.text('AI Analytics')).tap();

    await expect(element(by.text('Stock Trends'))).toBeVisible();
    await expect(element(by.id('stock-chart'))).toBeVisible();
    await expect(element(by.id('demand-prediction-chart'))).toBeVisible();

    // Should show trend indicators
    await expect(element(by.id('trend-indicator')).atIndex(0)).toBeVisible();
  });

  it('should handle stock optimization recommendations', async () => {
    await element(by.text('AI Analytics')).tap();

    await expect(element(by.text('Optimization Recommendations'))).toBeVisible();

    // Should show optimization suggestions
    const recommendations = element(by.id('optimization-item'));
    await expect(recommendations.atIndex(0)).toBeVisible();

    // Tap on recommendation
    await recommendations.atIndex(0).tap();

    // Should show recommendation details
    await expect(element(by.id('recommendation-details'))).toBeVisible();
    await expect(element(by.text('Apply Recommendation'))).toBeVisible();
  });
});

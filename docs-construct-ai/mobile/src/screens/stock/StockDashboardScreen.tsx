import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  RefreshControl,
  Dimensions,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../../store';
import { updateAIInsights } from '../../store/slices/stockSlice';
import MainNavigation from '../../components/MainNavigation';

const { width } = Dimensions.get('window');

const StockDashboardScreen: React.FC = () => {
  const navigation = useNavigation();
  const dispatch = useDispatch();

  const [refreshing, setRefreshing] = useState(false);
  const { items, alerts, aiInsights } = useSelector((state: RootState) => state.stock);

  // Mock data for demonstration
  const dashboardStats = {
    totalItems: 1250,
    totalValue: 245000,
    lowStockItems: 23,
    expiringSoon: 8,
    aiDetections: aiInsights.detectionsToday,
    alertsCount: alerts.filter(a => !a.acknowledged).length,
  };

  const recentItems = [
    {
      id: '1',
      sku: 'STEEL-REINF-001',
      name: 'Steel Reinforcement Bars',
      quantity: 45,
      minStock: 50,
      location: 'A-03-12',
      aiStatus: 'LOW_STOCK',
      confidence: 96,
    },
    {
      id: '2',
      sku: 'CONC-AGG-002',
      name: 'Concrete Aggregate Mix',
      quantity: 125,
      minStock: 100,
      location: 'B-07-05',
      aiStatus: 'NORMAL',
      confidence: 93,
    },
    {
      id: '3',
      sku: 'CEMENT-OPC-003',
      name: 'Ordinary Portland Cement',
      quantity: 8,
      minStock: 25,
      location: 'C-02-08',
      aiStatus: 'CRITICAL_LOW',
      expiry: '2025-03-15',
      confidence: 99,
    },
  ];

  const recentAlerts = [
    {
      id: '1',
      type: 'low_stock' as const,
      severity: 'high' as const,
      message: 'Steel Reinforcement Bars below minimum level',
      timestamp: '15 min ago',
      aiRecommendation: 'Reorder immediately - demand trend increasing',
    },
    {
      id: '2',
      type: 'expiry_soon' as const,
      severity: 'medium' as const,
      message: 'Ordinary Portland Cement expires in 3 days',
      timestamp: '1 hour ago',
      aiRecommendation: 'Use first-expire-first-out and reorder fresh stock',
    },
    {
      id: '3',
      type: 'anomaly' as const,
      severity: 'low' as const,
      message: 'Irregular stacking detected in Zone A',
      timestamp: '2 hours ago',
      aiRecommendation: 'Inspect and restack for better organization',
    },
  ];

  const aiPredictions = [
    {
      type: 'demand',
      item: 'Steel Reinforcement',
      prediction: '20% increase expected next week',
      confidence: 87,
      actionable: true,
    },
    {
      type: 'supplier',
      item: 'Concrete Mix',
      prediction: 'Delivery delay from Supplier XYZ',
      confidence: 79,
      actionable: true,
    },
    {
      type: 'expiry',
      item: 'Portland Cement',
      prediction: '5 bags expire before usage',
      confidence: 94,
      actionable: true,
    },
  ];

  const onRefresh = async () => {
    setRefreshing(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 2000));

    // Update AI insights
    dispatch(updateAIInsights({
      detectionsToday: Math.floor(Math.random() * 5) + dashboardStats.aiDetections,
      accuracyRate: 92.0 + Math.random() * 8,
      totalItemsTracked: dashboardStats.totalItems,
      stockOptimization: {
        overstockValue: Math.floor(Math.random() * 5000) + 15000,
        stockoutPrevention: Math.floor(Math.random() * 200) + 400,
        expiryPrevention: Math.floor(Math.random() * 10) + 15,
      },
      predictions: [
        {
          itemId: 'STEEL-REINF-001',
          type: 'demand',
          confidence: 0.88,
          prediction: 'Demand surge expected due to construction peak',
          actionable: true,
          dueDate: '2025-02-15',
        },
        {
          itemId: 'CEMENT-OPC-003',
          type: 'expiry',
          confidence: 0.95,
          prediction: '4 bags will expire before use if not consumed',
          actionable: true,
          dueDate: '2025-03-15',
        },
      ],
    }));

    setRefreshing(false);
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'NORMAL': return '#28a745';
      case 'LOW_STOCK': return '#ffc107';
      case 'CRITICAL_LOW': return '#dc3545';
      case 'OVERSTOCK': return '#17a2b8';
      default: return '#6c757d';
    }
  };

  const getAlertIcon = (type: string) => {
    switch (type) {
      case 'low_stock': return 'trending-down';
      case 'expiry_soon': return 'alarm';
      case 'anomaly': return 'alert-circle';
      case 'out_of_stock': return 'remove-circle';
      case 'overstock': return 'archive';
      default: return 'home';
    }
  };

  const getAlertColor = (type: string) => {
    switch (type) {
      case 'low_stock': return '#dc3545';
      case 'expiry_soon': return '#ffc107';
      case 'anomaly': return '#fd7e14';
      case 'out_of_stock': return '#e83e8c';
      case 'overstock': return '#17a2b8';
      default: return '#6c757d';
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView
        contentContainerStyle={styles.scrollContainer}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={onRefresh}
            colors={['#007AFF']}
            tintColor="#007AFF"
          />
        }
      >
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.title}>ConstructAI Stock</Text>
          <Text style={styles.subtitle}>AI-powered inventory management</Text>
        </View>

        {/* Key Stats */}
        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.totalItems}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="cube" size={14} color="#007AFF" />
              Total Items
            </Text>
            <Text style={[styles.statSubtext, { color: '#28a745' }]}>
              All tracked by AI
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>R{dashboardStats.totalValue.toLocaleString()}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="cash" size={14} color="#28a745" />
              Stock Value
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.lowStockItems}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="warning" size={14} color="#ffc107" />
              Low Stock
            </Text>
            <Text style={[styles.statSubtext, { color: '#28a745' }]}>
              ↓ 15% this month
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.aiDetections}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="eye" size={14} color="#007AFF" />
              AI Scans Today
            </Text>
            <Text style={[styles.statSubtext, { color: '#007AFF' }]}>
              {aiInsights?.accuracyRate?.toFixed(1) || '92.0'}% accuracy
            </Text>
          </View>
        </View>

        {/* Quick Actions */}
        <View style={styles.quickActionsContainer}>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('StockScanner')}>
            <Ionicons name="camera" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Scan Stock</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('InventoryList')}>
            <Ionicons name="list" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Inventory</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('StockAIReports')}>
            <Ionicons name="stats-chart" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>AI Analytics</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('AlertCenter')}>
            <Ionicons name="notifications" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Alerts ({dashboardStats.alertsCount})</Text>
          </TouchableOpacity>
        </View>

        {/* Recent Items Status */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>📦 Recent Items</Text>
            <TouchableOpacity>
              <Text style={styles.viewAllText}>View All</Text>
            </TouchableOpacity>
          </View>

          {recentItems.map((item) => (
            <TouchableOpacity
              key={item.id}
              style={styles.itemCard}
              onPress={() => navigation.navigate('StockItemDetail', { itemId: item.id })}
            >
              <View style={styles.itemHeader}>
                <Text style={styles.itemSku}>{item.sku}</Text>
                <View style={[styles.statusBadge, { backgroundColor: getStatusColor(item.aiStatus) }]}>
                  <Text style={styles.statusText}>{item.aiStatus.replace('_', ' ')}</Text>
                </View>
              </View>

              <Text style={styles.itemName}>{item.name}</Text>

              <View style={styles.itemDetails}>
                <Text style={styles.itemLocation}>
                  📍 {item.location}
                </Text>
                <Text style={styles.itemQuantity}>
                  {item.quantity} / {item.minStock} min
                </Text>
                <Text style={styles.aiConfidence}>
                  AI: {item.confidence}%
                </Text>
              </View>

              {item.expiry && (
                <Text style={styles.expiryWarning}>
                  ⚠️ Expires {item.expiry}
                </Text>
              )}
            </TouchableOpacity>
          ))}
        </View>

        {/* AI Insights */}
        <View style={styles.aiInsightsContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>🤖 AI Insights</Text>
            <TouchableOpacity>
              <Ionicons name="settings" size={20} color="#007AFF" />
            </TouchableOpacity>
          </View>

          <View style={styles.aiStatsRow}>
            <View style={styles.aiStatItem}>
              <Text style={styles.aiStatNumber}>{aiInsights?.accuracyRate?.toFixed(1) || '92.0'}%</Text>
              <Text style={styles.aiStatLabel}>Detection Accuracy</Text>
            </View>
            <View style={styles.aiStatItem}>
              <Text style={styles.aiStatNumber}>{aiInsights?.stockOptimization?.stockoutPrevention || '450'}</Text>
              <Text style={styles.aiStatLabel}>Stockouts Prevented</Text>
            </View>
            <View style={styles.aiStatItem}>
              <Text style={styles.aiStatNumber}>{aiInsights?.stockOptimization?.expiryPrevention || '23'}</Text>
              <Text style={styles.aiStatLabel}>Expiry Alerts</Text>
            </View>
          </View>

          {aiPredictions.length > 0 && (
            <View style={styles.predictionsContainer}>
              <Text style={styles.predictionsTitle}>🔮 AI Predictions</Text>
              {aiPredictions.map((prediction, index) => (
                <View key={index} style={styles.predictionItem}>
                  <View style={styles.predictionIcon}>
                    <Ionicons
                      name={
                        prediction.type === 'demand' ? 'trending-up' :
                        prediction.type === 'expiry' ? 'alarm' : 'warning'
                      }
                      size={16}
                      color={
                        prediction.type === 'demand' ? '#28a745' :
                        prediction.type === 'expiry' ? '#dc3545' : '#ffc107'
                      }
                    />
                  </View>
                  <View style={styles.predictionContent}>
                    <Text style={styles.predictionText}>
                      <Text style={styles.predictionItemName}>{prediction.item}:</Text>
                      {' '}{prediction.prediction}
                    </Text>
                    <Text style={styles.confidenceText}>
                      Confidence: {prediction.confidence}%
                    </Text>
                  </View>
                  {prediction.actionable && (
                    <TouchableOpacity style={styles.actionButton}>
                      <Ionicons name="arrow-forward" size={16} color="#007AFF" />
                    </TouchableOpacity>
                  )}
                </View>
              ))}
            </View>
          )}
        </View>

        {/* Recent Alerts */}
        <View style={styles.sectionContainer}>
          <Text style={styles.sectionTitle}>🚨 Recent Alerts</Text>

          {recentAlerts.map((alert) => (
            <TouchableOpacity
              key={alert.id}
              style={styles.alertCard}
              onPress={() => navigation.navigate('AlertDetail', { alert })}
            >
              <View style={styles.alertHeader}>
                <Ionicons
                  name={getAlertIcon(alert.type)}
                  size={20}
                  color={getAlertColor(alert.type)}
                />
                <View style={styles.alertContent}>
                  <Text style={styles.alertTitle}>{alert.message}</Text>
                  <Text style={styles.alertTime}>{alert.timestamp}</Text>
                </View>
                <TouchableOpacity style={styles.acknowledgeButton}>
                  <Ionicons name="checkmark-circle" size={20} color="#28a745" />
                </TouchableOpacity>
              </View>
              <View style={styles.recommendationContainer}>
                <Text style={styles.recommendationLabel}>💡 AI Recommendation:</Text>
                <Text style={styles.recommendationText}>{alert.aiRecommendation}</Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>
      </ScrollView>
      
      {/* Bottom Navigation Bar */}
      <MainNavigation />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollContainer: {
    padding: 16,
  },
  header: {
    alignItems: 'center',
    marginBottom: 24,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 4,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
  },
  statsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: 24,
    gap: 8,
  },
  statCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    width: (width - 40) / 2,
  },
  statNumber: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#007AFF',
    marginBottom: 4,
  },
  statLabel: {
    fontSize: 12,
    color: '#666',
    marginBottom: 4,
    textAlign: 'center',
  },
  statSubtext: {
    fontSize: 11,
    fontWeight: '600',
  },
  quickActionsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: 24,
    gap: 12,
  },
  actionButton: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 5,
    width: (width - 52) / 2,
    borderWidth: 2,
    borderColor: '#007AFF',
  },
  actionButtonText: {
    color: '#000',
    fontSize: 14,
    fontWeight: '600',
    marginTop: 8,
    textAlign: 'center',
  },
  sectionContainer: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  viewAllText: {
    fontSize: 14,
    color: '#007AFF',
    fontWeight: '600',
  },
  itemCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  itemHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  itemSku: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  statusBadge: {
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
  },
  statusText: {
    fontSize: 10,
    fontWeight: 'bold',
    color: '#fff',
  },
  itemName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  itemDetails: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  itemLocation: {
    fontSize: 12,
    color: '#666',
    flex: 1,
  },
  itemQuantity: {
    fontSize: 12,
    color: '#333',
    fontWeight: '600',
  },
  aiConfidence: {
    fontSize: 12,
    color: '#007AFF',
    fontWeight: '600',
  },
  expiryWarning: {
    fontSize: 12,
    color: '#dc3545',
    fontWeight: '600',
    marginTop: 8,
  },
  aiInsightsContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  aiStatsRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    marginBottom: 16,
  },
  aiStatItem: {
    alignItems: 'center',
  },
  aiStatNumber: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  aiStatLabel: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
    marginTop: 4,
  },
  predictionsContainer: {
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    paddingTop: 16,
  },
  predictionsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  predictionItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  predictionIcon: {
    width: 30,
    height: 30,
    borderRadius: 15,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  predictionContent: {
    flex: 1,
  },
  predictionText: {
    fontSize: 14,
    color: '#333',
    lineHeight: 20,
  },
  predictionItemName: {
    fontWeight: '600',
    color: '#007AFF',
  },
  alertCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    borderLeftWidth: 4,
    borderLeftColor: '#ffc107',
  },
  alertHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  alertContent: {
    flex: 1,
    marginLeft: 12,
  },
  alertTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  alertTime: {
    fontSize: 12,
    color: '#666',
  },
  acknowledgeButton: {
    padding: 4,
  },
  recommendationContainer: {
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
    padding: 12,
  },
  recommendationLabel: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#666',
    marginBottom: 4,
  },
  recommendationText: {
    fontSize: 14,
    color: '#333',
    lineHeight: 20,
  },
  confidenceText: {
    fontSize: 10,
    color: '#666',
    marginTop: 2,
  },
});

export default StockDashboardScreen;

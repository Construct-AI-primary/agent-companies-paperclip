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
import { updateAIInsights } from '../../store/slices/logisticsSlice';

const { width } = Dimensions.get('window');

const LogisticsDashboardScreen: React.FC = () => {
  const navigation = useNavigation();
  const dispatch = useDispatch();

  const [refreshing, setRefreshing] = useState(false);
  const { loads, inspections, aiInsights } = useSelector((state: RootState) => state.logistics);

  // Mock data for demonstration
  const dashboardStats = {
    activeShipments: 8,
    loadingActivities: 12,
    completedToday: 5,
    pendingInspections: 3,
    aiDetections: aiInsights.damageDetections,
    accuracy: aiInsights.accuracy,
  };

  const recentShipments = [
    {
      id: 'LH-2025-789',
      destination: 'Cape Town',
      status: 'loading' as const,
      eta: 'March 15, 2:30 PM',
      progress: 73,
    },
    {
      id: 'LH-2025-790',
      destination: 'Durban',
      status: 'in_transit' as const,
      eta: 'March 14, 9:15 AM',
      progress: 100,
    },
    {
      id: 'LH-2025-791',
      destination: 'Johannesburg',
      status: 'planning' as const,
      eta: 'March 16, 11:00 AM',
      progress: 15,
    },
  ];

  const recentAlerts = [
    {
      type: 'critical' as const,
      title: 'Container Damage Detected',
      description: 'AI detected damage on Container LH-2025-789-001',
      time: '5 min ago',
      location: 'Dock 3',
    },
    {
      type: 'warning' as const,
      title: 'Overage Detected',
      description: 'Batch #4587: +23 items (+4.1% variance)',
      time: '15 min ago',
      location: 'Loading Bay A',
    },
    {
      type: 'info' as const,
      title: 'Inspection Completed',
      description: 'Daily safety inspection completed successfully',
      time: '1 hour ago',
      location: 'Equipment Bay',
    },
  ];

  const onRefresh = async () => {
    setRefreshing(true);
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 2000));

    // Update AI insights
    dispatch(updateAIInsights({
      damageDetections: Math.floor(Math.random() * 10) + dashboardStats.aiDetections,
      accuracy: 94.2 + Math.random() * 3,
      processingSpeed: 1.8 + Math.random() * 0.6,
      recommendations: [
        'Consider additional equipment monitoring in high-traffic areas',
        'Review loading procedures for improved efficiency',
        'Schedule preventive maintenance for fork truck FL-003'
      ]
    }));

    setRefreshing(false);
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'delivered': return '#28a745';
      case 'in_transit': return '#007AFF';
      case 'loading': return '#ffc107';
      case 'delayed': return '#dc3545';
      default: return '#6c757d';
    }
  };

  const getAlertIcon = (type: string) => {
    switch (type) {
      case 'critical': return 'alert-circle';
      case 'warning': return 'warning';
      case 'info': return 'information-circle';
      default: return 'notifications';
    }
  };

  const getAlertColor = (type: string) => {
    switch (type) {
      case 'critical': return '#dc3545';
      case 'warning': return '#ffc107';
      case 'info': return '#17a2b8';
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
          <Text style={styles.title}>ConstructAI Logistics</Text>
          <Text style={styles.subtitle}>AI-powered load management</Text>
        </View>

        {/* Key Stats */}
        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.activeShipments}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="cube" size={14} color="#007AFF" />
              Active Shipments
            </Text>
            <Text style={[styles.statSubtext, { color: '#28a745' }]}>
              ↑ 12% from yesterday
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.completedToday}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="checkmark-circle" size={14} color="#28a745" />
              Completed Today
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.aiDetections}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="eye" size={14} color="#007AFF" />
              AI Detections
            </Text>
            <Text style={[styles.statSubtext, { color: '#007AFF' }]}>
              {aiInsights.accuracy.toFixed(1)}% accuracy
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.loadingActivities}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="construct" size={14} color="#ffc107" />
              Loading Activities
            </Text>
          </View>
        </View>

        {/* Quick Actions */}
        <View style={styles.quickActionsContainer}>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('ShipmentCreate')}>
            <Ionicons name="add-circle" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Create Load</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('InspectionStart')}>
            <Ionicons name="qr-code" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Start Inspection</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('DamageReport')}>
            <Ionicons name="warning" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Report Damage</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.actionButton} onPress={() => navigation.navigate('AnalyticsScreen')}>
            <Ionicons name="stats-chart" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>Analytics</Text>
          </TouchableOpacity>
        </View>

        {/* Active Shipments */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>📦 Active Shipments</Text>
            <TouchableOpacity>
              <Text style={styles.viewAllText}>View All</Text>
            </TouchableOpacity>
          </View>

          {recentShipments.map((shipment) => (
            <TouchableOpacity
              key={shipment.id}
              style={styles.shipmentCard}
              onPress={() => navigation.navigate('ShipmentDetail', { shipmentId: shipment.id })}
            >
              <View style={styles.shipmentHeader}>
                <Text style={styles.shipmentId}>{shipment.id}</Text>
                <View style={[styles.statusBadge, { backgroundColor: getStatusColor(shipment.status) }]}>
                  <Text style={styles.statusText}>{shipment.status.replace('_', ' ').toUpperCase()}</Text>
                </View>
              </View>

              <Text style={styles.shipmentDestination}>
                <Ionicons name="location" size={14} color="#666" />
                {' '}{shipment.destination}
              </Text>

              <View style={styles.shipmentFooter}>
                <Text style={styles.eta}>
                  <Ionicons name="time" size={14} color="#666" />
                  {' '}ETA: {shipment.eta}
                </Text>
                <View style={styles.progressContainer}>
                  <View style={styles.progressBar}>
                    <View
                      style={[styles.progressFill, { width: `${shipment.progress}%` }]}
                    />
                  </View>
                  <Text style={styles.progressText}>{shipment.progress}%</Text>
                </View>
              </View>
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
              <Text style={styles.aiStatNumber}>{aiInsights.accuracy.toFixed(1)}%</Text>
              <Text style={styles.aiStatLabel}>Detection Accuracy</Text>
            </View>
            <View style={styles.aiStatItem}>
              <Text style={styles.aiStatNumber}>{aiInsights.processingSpeed.toFixed(1)}s</Text>
              <Text style={styles.aiStatLabel}>Processing Speed</Text>
            </View>
            <View style={styles.aiStatItem}>
              <Text style={styles.aiStatNumber}>{aiInsights.damageDetections}</Text>
              <Text style={styles.aiStatLabel}>Issues Detected</Text>
            </View>
          </View>

          {aiInsights.recommendations.length > 0 && (
            <View style={styles.recommendationsContainer}>
              <Text style={styles.recommendationsTitle}>💡 Recommendations</Text>
              {aiInsights.recommendations.slice(0, 2).map((rec, index) => (
                <View key={index} style={styles.recommendationItem}>
                  <Ionicons name="bulb" size={16} color="#ffc107" />
                  <Text style={styles.recommendationText}>{rec}</Text>
                </View>
              ))}
            </View>
          )}
        </View>

        {/* Recent Alerts */}
        <View style={styles.sectionContainer}>
          <Text style={styles.sectionTitle}>🚨 Recent Alerts</Text>

          {recentAlerts.map((alert, index) => (
            <TouchableOpacity
              key={index}
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
                  <Text style={styles.alertTitle}>{alert.title}</Text>
                  <Text style={styles.alertLocation}>
                    <Ionicons name="location" size={12} color="#666" />
                    {' '}{alert.location}
                  </Text>
                </View>
                <Text style={styles.alertTime}>{alert.time}</Text>
              </View>
              <Text style={styles.alertDescription}>{alert.description}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </ScrollView>
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
    fontSize: 32,
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
    backgroundColor: '#007AFF',
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
  },
  actionButtonText: {
    color: '#fff',
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
  shipmentCard: {
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
  shipmentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  shipmentId: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
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
  shipmentDestination: {
    fontSize: 14,
    color: '#666',
    marginBottom: 12,
  },
  shipmentFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  eta: {
    fontSize: 12,
    color: '#666',
    flex: 1,
  },
  progressContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  progressBar: {
    flex: 1,
    height: 4,
    backgroundColor: '#e0e0e0',
    borderRadius: 2,
    marginHorizontal: 8,
  },
  progressFill: {
    height: '100%',
    backgroundColor: '#007AFF',
    borderRadius: 2,
  },
  progressText: {
    fontSize: 12,
    color: '#666',
    minWidth: 35,
    textAlign: 'right',
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
  recommendationsContainer: {
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    paddingTop: 16,
  },
  recommendationsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  recommendationItem: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 8,
  },
  recommendationText: {
    fontSize: 14,
    color: '#666',
    marginLeft: 8,
    flex: 1,
    lineHeight: 20,
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
    borderLeftColor: '#ffc107', // Will be dynamic based on alert type
  },
  alertHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  alertContent: {
    flex: 1,
    marginLeft: 12,
  },
  alertTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 2,
  },
  alertLocation: {
    fontSize: 12,
    color: '#666',
  },
  alertTime: {
    fontSize: 12,
    color: '#666',
  },
  alertDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
});

export default LogisticsDashboardScreen;

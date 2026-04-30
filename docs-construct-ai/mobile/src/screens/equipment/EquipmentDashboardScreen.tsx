import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  RefreshControl,
  Dimensions,
  ActivityIndicator,
  Alert,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../../store';
import equipmentSlice, { updateAIInsights, completeMaintenanceTask, generateAIPrediction } from '../../store/slices/equipmentSlice';
import { voiceService } from '../../services/voiceService';

const { width } = Dimensions.get('window');

const EquipmentDashboardScreen: React.FC = () => {
  const navigation = useNavigation();
  const dispatch = useDispatch();

  const [refreshing, setRefreshing] = useState(false);
  const { equipment, alerts, maintenanceTasks, aiInsights, loading } = useSelector((state: RootState) => state.equipment);

  // Mock data for demonstration
  const dashboardStats = {
    totalEquipment: 48,
    operational: 42,
    maintenanceRequired: 4,
    criticalEquipment: 2,
    totalAlerts: alerts.filter(a => !a.acknowledged).length,
    aiPredictions: aiInsights.optimizationOpportunities,
    avgHealthScore: aiInsights.avgHealthScore,
  };

  const activeEquipment = [
    {
      id: '1',
      assetTag: 'EXC-033',
      name: 'Caterpillar Excavator 320D',
      healthScore: 87,
      status: 'operational' as const,
      location: 'Site A - Foundation Zone',
      aiPredictedFailures: 1,
      nextMaintenance: '3 days',
      category: 'heavy_machinery',
    },
    {
      id: '2',
      assetTag: 'CRN-045',
      name: 'Paterson Crane PC-12',
      healthScore: 45,
      status: 'critical' as const,
      location: 'Site B - Tower Lift',
      aiPredictedFailures: 3,
      nextMaintenance: 'Overdue',
      category: 'heavy_machinery',
    },
    {
      id: '3',
      assetTag: 'TRK-028',
      name: 'Studebaker Dump Truck SD-88',
      healthScore: 92,
      status: 'operational' as const,
      location: 'Material Handling Zone',
      aiPredictedFailures: 0,
      nextMaintenance: '12 days',
      category: 'vehicles',
    },
    {
      id: '4',
      assetTag: 'LDZ-051',
      name: 'Volvo L110H Loader',
      healthScore: 73,
      status: 'maintenance_required' as const,
      location: 'Site C - Excavation',
      aiPredictedFailures: 2,
      nextMaintenance: 'Immediate',
      category: 'heavy_machinery',
    },
  ];

  const recentAlerts = [
    {
      id: '1',
      equipment: 'Paterson Crane PC-12',
      type: 'critical',
      message: 'Hydraulic pressure dropping - risk of imminent failure',
      aiRecommendation: 'Emergency maintenance required. Estimated downtime: 4-6 hours',
      costEstimate: 8500,
      severity: 'critical',
      time: '2 min ago',
    },
    {
      id: '2',
      equipment: 'Volvo L110H Loader',
      type: 'high',
      message: 'Engine oil analysis shows high wear particles',
      aiRecommendation: 'Schedule immediate oil change and engine inspection',
      costEstimate: 2450,
      severity: 'high',
      time: '15 min ago',
    },
    {
      id: '3',
      equipment: 'Caterpillar Excavator 320D',
      type: 'medium',
      message: 'AI predicted potential hydraulic leak in 4.2 days',
      aiRecommendation: 'Plan preventive maintenance to avoid downtime',
      costEstimate: 1200,
      severity: 'medium',
      time: '1 hour ago',
    },
  ];

  const upcomingMaintenance = [
    {
      equipment: 'Studebaker Dump Truck SD-88',
      task: 'Routine Service & Oil Change',
      dueIn: '3 days',
      technician: 'John Smith',
      aiOptimized: true,
      estimatedTime: '2 hours',
      aiConfidence: 89,
    },
    {
      equipment: 'Volvo L110H Loader',
      task: 'Engine Inspection & Filter Replacement',
      dueIn: 'Immediate',
      technician: 'Sarah Johnson',
      aiOptimized: true,
      estimatedTime: '4 hours',
      aiConfidence: 95,
    },
    {
      equipment: 'Caterpillar Excavator 320D',
      task: 'Hydraulic System Preventive Maintenance',
      dueIn: '4 days',
      technician: 'Mike Wilson',
      aiOptimized: true,
      estimatedTime: '6 hours',
      aiConfidence: 87,
    },
  ];

  const aiInsightsSummary = [
    {
      title: 'Predictive Maintenance Savings',
      value: '$45,200',
      period: 'This month',
      trend: '+12%',
      color: '#28a745',
    },
    {
      title: 'Equipment Uptime',
      value: '94.8%',
      period: 'Last 30 days',
      trend: '+2.1%',
      color: '#007AFF',
    },
    {
      title: 'Failure Prevention Rate',
      value: '89%',
      period: 'Prediction accuracy',
      trend: '+5%',
      color: '#ffc107',
    },
    {
      title: 'Maintenance Efficiency',
      value: '78%',
      period: 'Task optimization',
      trend: '+11%',
      color: '#dc3545',
    },
  ];

  const onRefresh = async () => {
    setRefreshing(true);

    // Simulate API refresh and AI analysis
    await new Promise(resolve => setTimeout(resolve, 2000));

    // Generate new AI insights
    dispatch(updateAIInsights({
      totalEquipment: Math.floor(Math.random() * 5) + dashboardStats.totalEquipment,
      avgHealthScore: 80 + Math.random() * 15,
      criticalEquipment: Math.floor(Math.random() * 3) + 1,
      upcomingMaintenance: Math.floor(Math.random() * 8) + 5,
      costSavings: Math.floor(Math.random() * 5000) + 35000,
      predictionsAccuracy: 85 + Math.random() * 10,
      optimizationOpportunities: Math.floor(Math.random() * 3) + aiInsights.optimizationOpportunities,
    }));

    setRefreshing(false);
  };

  const getHealthColor = (health: number) => {
    if (health >= 80) return '#28a745';
    if (health >= 60) return '#ffc107';
    if (health >= 40) return '#fd7e14';
    return '#dc3545';
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'operational': return '#28a745';
      case 'maintenance_required': return '#ffc107';
      case 'critical': return '#dc3545';
      default: return '#6c757d';
    }
  };

  const getAlertIcon = (severity: string) => {
    switch (severity) {
      case 'critical': return 'alert-circle';
      case 'high': return 'warning';
      case 'medium': return 'information-circle';
      case 'low': return 'checkmark-circle';
      default: return 'notifications';
    }
  };

  const handleMaintenanceCompletion = (maintenanceId: string) => {
    Alert.alert(
      'Complete Maintenance Task',
      'Confirm that this maintenance task has been completed?',
      [
        {
          text: 'Complete',
          onPress: () => {
            dispatch(completeMaintenanceTask({
              taskId: maintenanceId,
              notes: 'Completed as planned',
              photos: [],
              cost: Math.floor(Math.random() * 2000) + 500,
            }));
            Alert.alert('Success', 'Maintenance task completed and recorded');
          },
        },
        { text: 'Cancel', style: 'cancel' },
      ]
    );
  };

  const generateAIPredictionForEquipment = () => {
    const randomEquipmentId = `eq_${Math.floor(Math.random() * 10) + 1}`;
    dispatch(generateAIPrediction({ equipmentId: randomEquipmentId }));
    Alert.alert('AI Analysis', 'AI is analyzing equipment health... Results will be available shortly.');
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView
        testID="equipment-dashboard-scrollview"
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
          <Text style={styles.title}>ConstructAI Equipment</Text>
          <Text style={styles.subtitle}>AI-powered predictive maintenance</Text>
        </View>

        {/* Key Stats */}
        <View style={styles.statsContainer}>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.totalEquipment}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="construct" size={14} color="#007AFF" />
              Total Equipment
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.operational}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="checkmark-circle" size={14} color="#28a745" />
              Operational
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.maintenanceRequired}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="construct" size={14} color="#ffc107" />
              Maintenance Needed
            </Text>
          </View>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>{dashboardStats.criticalEquipment}</Text>
            <Text style={styles.statLabel}>
              <Ionicons name="alert-circle" size={14} color="#dc3545" />
              Critical
            </Text>
          </View>
        </View>

        {/* Quick AI Actions */}
        <View style={styles.aiActionsContainer}>
          <TouchableOpacity style={styles.aiActionButton} onPress={generateAIPredictionForEquipment}>
            <Ionicons name="analytics" size={24} color="#fff" />
            <Text style={styles.aiActionButtonText}>Generate AI Prediction</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.aiActionButton} onPress={() => navigation.navigate('MaintenanceSchedule')}>
            <Ionicons name="calendar" size={24} color="#fff" />
            <Text style={styles.aiActionButtonText}>Schedule Tasks</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.aiActionButton} onPress={() => navigation.navigate('EquipmentAnalytics')}>
            <Ionicons name="stats-chart" size={24} color="#fff" />
            <Text style={styles.aiActionButtonText}>AI Analytics</Text>
          </TouchableOpacity>
          <TouchableOpacity style={styles.aiActionButton} onPress={() => navigation.navigate('AlertsCenter')}>
            <Ionicons name="notifications" size={24} color="#fff" />
            <Text style={styles.aiActionButtonText}>Alerts ({dashboardStats.totalAlerts})</Text>
          </TouchableOpacity>
        </View>

        {/* AI Insights Summary */}
        <View style={styles.aiInsightsContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>🤖 AI Insights & Performance</Text>
            <TouchableOpacity>
              <Ionicons name="settings" size={20} color="#007AFF" />
            </TouchableOpacity>
          </View>

          <View style={styles.aiStatsGrid}>
            {aiInsightsSummary.map((insight, index) => (
              <View key={index} style={styles.aiStatCard}>
                <Text style={styles.aiStatValue}>{insight.value}</Text>
                <Text style={styles.aiStatTitle}>{insight.title}</Text>
                <Text style={styles.aiStatPeriod}>{insight.period}</Text>
                <Text style={[styles.aiStatTrend, { color: insight.color }]}>
                  {insight.trend}
                </Text>
              </View>
            ))}
          </View>
        </View>

        {/* Active Equipment Status */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>🛠️ Equipment Status</Text>
            <TouchableOpacity>
              <Text style={styles.viewAllText}>View All</Text>
            </TouchableOpacity>
          </View>

          {activeEquipment.map((equipment) => (
            <TouchableOpacity
              key={equipment.id}
              style={styles.equipmentCard}
              onPress={() => navigation.navigate('EquipmentDetail', { equipmentId: equipment.id })}
            >
              <View style={styles.equipmentHeader}>
                <Text style={styles.equipmentAssetTag}>{equipment.assetTag}</Text>
                <View style={[styles.statusBadge, { backgroundColor: getStatusColor(equipment.status) }]}>
                  <Text style={styles.statusText}>{equipment.status.replace('_', ' ').toUpperCase()}</Text>
                </View>
              </View>

              <Text style={styles.equipmentName}>{equipment.name}</Text>

              <View style={styles.equipmentMetrics}>
                <View style={styles.healthIndicator}>
                  <Text style={styles.healthLabel}>Health</Text>
                  <Text style={[styles.healthScore, { color: getHealthColor(equipment.healthScore) }]}>
                    {equipment.healthScore}%
                  </Text>
                </View>

                <View style={styles.locationContainer}>
                  <Ionicons name="location" size={14} color="#666" />
                  <Text style={styles.locationText}>{equipment.location}</Text>
                </View>
              </View>

              <View style={styles.equipmentFooter}>
                <Text style={styles.maintenanceInfo}>
                  Next Service: {equipment.nextMaintenance}
                </Text>
                {equipment.aiPredictedFailures > 0 && (
                  <View style={styles.aiWarning}>
                  <Ionicons name="analytics" size={12} color="#dc3545" />
                    <Text style={styles.aiWarningText}>
                      {equipment.aiPredictedFailures} AI predictions
                    </Text>
                  </View>
                )}
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* AI Alerts */}
        <View style={styles.sectionContainer}>
          <Text style={styles.sectionTitle}>🚨 AI-Powered Alerts</Text>

          {recentAlerts.map((alert) => (
            <TouchableOpacity
              key={alert.id}
              style={styles.alertCard}
              onPress={() => navigation.navigate('AlertDetail', { alert })}
            >
              <View style={styles.alertHeader}>
                <Ionicons
                  name={getAlertIcon(alert.severity)}
                  size={20}
                  color={
                    alert.severity === 'critical' ? '#dc3545' :
                    alert.severity === 'high' ? '#fd7e14' :
                    alert.severity === 'medium' ? '#ffc107' : '#17a2b8'
                  }
                />
                <View style={styles.alertContent}>
                  <Text style={styles.alertEquipment}>{alert.equipment}</Text>
                  <Text style={styles.alertMessage}>{alert.message}</Text>
                  <Text style={styles.alertTime}>{alert.time}</Text>
                </View>
                <TouchableOpacity style={styles.acknowledgeButton}>
                  <Ionicons name="checkmark-circle" size={20} color="#28a745" />
                </TouchableOpacity>
              </View>

              <View style={styles.aiRecommendationContainer}>
                <Text style={styles.recommendationLabel}>💡 AI Recommendation:</Text>
                <Text style={styles.recommendationText}>{alert.aiRecommendation}</Text>
                <Text style={styles.costEstimate}>Estimated cost: R{alert.costEstimate}</Text>
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* Upcoming Maintenance */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={styles.sectionTitle}>📅 AI-Optimized Maintenance Schedule</Text>
            <TouchableOpacity>
              <Ionicons name="add-circle" size={20} color="#007AFF" />
            </TouchableOpacity>
          </View>

          {upcomingMaintenance.map((maintenance, index) => (
            <View key={index} style={styles.maintenanceCard}>
              <View style={styles.maintenanceHeader}>
                <Text style={styles.maintenanceEquipment}>{maintenance.equipment}</Text>
                <Text style={styles.maintenanceDue}>
                  Due: {maintenance.dueIn}
                </Text>
              </View>

              <Text style={styles.maintenanceTask}>{maintenance.task}</Text>

              <View style={styles.maintenanceDetails}>
                <Text style={styles.technician}>
                  👷 {maintenance.technician}
                </Text>
                <Text style={styles.estimatedTime}>
                  ⏱️ {maintenance.estimatedTime}
                </Text>
              </View>

              {maintenance.aiOptimized && (
                <View style={styles.aiOptimizedContainer}>
                  <Ionicons name="analytics" size={16} color="#007AFF" />
                  <Text style={styles.aiConfidence}>
                    AI Optimized ({maintenance.aiConfidence}% confidence)
                  </Text>
                </View>
              )}

              <View style={styles.maintenanceActions}>
                <TouchableOpacity
                  style={styles.rescheduleButton}
                  onPress={() => navigation.navigate('MaintenanceReschedule', { maintenance })}
                >
                  <Text style={styles.rescheduleButtonText}>Reschedule</Text>
                </TouchableOpacity>

                <TouchableOpacity
                  style={styles.completeButton}
                  onPress={() => handleMaintenanceCompletion(maintenance.equipment)}
                >
                  <Text style={styles.completeButtonText}>Complete</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))}
        </View>

        {/* Loading Overlay */}
        {loading && (
          <View style={styles.loadingOverlay}>
            <ActivityIndicator size="large" color="#007AFF" />
            <Text style={styles.loadingText}>AI Analyzing Equipment...</Text>
          </View>
        )}
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
  aiActionsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: 24,
    gap: 12,
  },
  aiActionButton: {
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
  aiActionButtonText: {
    color: '#000',
    fontSize: 14,
    fontWeight: '600',
    marginTop: 8,
    textAlign: 'center',
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
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
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
  aiStatsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  aiStatCard: {
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
    padding: 12,
    marginBottom: 12,
    width: (width - 72) / 2,
    alignItems: 'center',
  },
  aiStatValue: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  aiStatTitle: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
    marginTop: 4,
  },
  aiStatPeriod: {
    fontSize: 10,
    color: '#888',
    marginTop: 2,
  },
  aiStatTrend: {
    fontSize: 12,
    fontWeight: '600',
    marginTop: 4,
  },
  sectionContainer: {
    marginBottom: 24,
  },
  equipmentCard: {
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
  equipmentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  equipmentAssetTag: {
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
  equipmentName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  equipmentMetrics: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  healthIndicator: {
    alignItems: 'center',
  },
  healthLabel: {
    fontSize: 12,
    color: '#666',
    marginBottom: 4,
  },
  healthScore: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  locationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    justifyContent: 'flex-end',
  },
  locationText: {
    fontSize: 12,
    color: '#666',
    marginLeft: 4,
  },
  equipmentFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  maintenanceInfo: {
    fontSize: 12,
    color: '#666',
  },
  aiWarning: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  aiWarningText: {
    fontSize: 12,
    color: '#dc3545',
    marginLeft: 4,
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
  alertEquipment: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  alertMessage: {
    fontSize: 14,
    color: '#333',
    marginBottom: 4,
    lineHeight: 20,
  },
  alertTime: {
    fontSize: 12,
    color: '#666',
  },
  acknowledgeButton: {
    padding: 4,
  },
  aiRecommendationContainer: {
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
    marginBottom: 8,
  },
  costEstimate: {
    fontSize: 12,
    color: '#007AFF',
    fontWeight: '600',
  },
  maintenanceCard: {
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
  maintenanceHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  maintenanceEquipment: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
  },
  maintenanceDue: {
    fontSize: 12,
    color: '#dc3545',
    fontWeight: '600',
  },
  maintenanceTask: {
    fontSize: 14,
    color: '#666',
    marginBottom: 12,
  },
  maintenanceDetails: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 12,
  },
  technician: {
    fontSize: 12,
    color: '#666',
  },
  estimatedTime: {
    fontSize: 12,
    color: '#666',
  },
  aiOptimizedContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#e7f3ff',
    borderRadius: 6,
    paddingHorizontal: 8,
    paddingVertical: 4,
    marginBottom: 12,
  },
  aiConfidence: {
    fontSize: 12,
    color: '#007AFF',
    fontWeight: '600',
    marginLeft: 4,
  },
  maintenanceActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    gap: 12,
  },
  rescheduleButton: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 8,
    paddingVertical: 10,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#6c757d',
  },
  rescheduleButtonText: {
    color: '#000',
    fontSize: 14,
    fontWeight: '600',
  },
  completeButton: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 8,
    paddingVertical: 10,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: '#28a745',
  },
  completeButtonText: {
    color: '#000',
    fontSize: 14,
    fontWeight: '600',
  },
  loadingOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(245, 245, 245, 0.8)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '600',
  },
});

export default EquipmentDashboardScreen;

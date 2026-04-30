import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  Dimensions,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { aiService } from '../services/aiService';
import MainNavigation from '../components/MainNavigation';

const { width } = Dimensions.get('window');

const MainDashboardScreen: React.FC = () => {
  const navigation = useNavigation();
  const [, forceUpdate] = useState({}); // Force component re-render

  useEffect(() => {
    // Listen for language changes and force re-render
    const unsubscribe = aiService.onLanguageChange(() => {
      forceUpdate({}); // Force re-render when language changes
    });

    return unsubscribe; // Clean up listener on unmount
  }, []);

  const mainModules = [
    {
      name: 'StockDashboard',
      titleKey: 'stockManagement',
      descriptionKey: 'stockDescription',
      icon: 'cube',
      color: '#007AFF',
      stats: '1,250 items tracked',
    },
    {
      name: 'SafetyDashboard',
      titleKey: 'safetyManagement',
      descriptionKey: 'safetyDescription',
      icon: 'shield',
      color: '#28a745',
      stats: '98% compliance rate',
    },
    {
      name: 'IncidentManagement',
      titleKey: 'incidentManagement',
      descriptionKey: 'incidentDescription',
      icon: 'alert-circle',
      color: '#dc3545',
      stats: 'AI-powered classification',
    },
    {
      name: 'EquipmentDashboard',
      titleKey: 'equipmentManagement',
      descriptionKey: 'equipmentDescription',
      icon: 'construct',
      color: '#ff6b35',
      stats: '48 assets monitored',
    },
    {
      name: 'LogisticsDashboard',
      titleKey: 'logisticsManagement',
      descriptionKey: 'logisticsDescription',
      icon: 'bus',
      color: '#F7DC6F',
      stats: '23 active routes',
    },
    {
      name: 'CustomsClearance',
      titleKey: 'customsClearance',
      descriptionKey: 'customsDescription',
      icon: 'document-text',
      color: '#17a2b8',
      stats: 'GPS-tagged documents',
    },
    {
      name: 'PurchaseOrders',
      titleKey: 'purchaseOrders',
      descriptionKey: 'purchaseDescription',
      icon: 'cart',
      color: '#9b59b6',
      stats: 'Voice-to-text orders',
    },
    {
      name: 'InspectionStart',
      titleKey: 'inspectionManagement',
      descriptionKey: 'inspectionDescription',
      icon: 'search',
      color: '#20b2aa',
      stats: 'AI inspection platform',
    },
    {
      name: 'AIDocumentTools',
      titleKey: 'aiTools',
      descriptionKey: 'aiToolsDescription',
      icon: 'rocket',
      color: '#ff6347',
      stats: 'Advanced AI features',
    },
    {
      name: 'AISettings',
      titleKey: 'aiSettings',
      descriptionKey: 'aiSettingsDescription',
      icon: 'settings',
      color: '#FF6347',
      stats: 'Customize AI experience',
    },
  ];

  const quickActions = [
    {
      titleKey: 'viewAnalytics',
      descriptionKey: 'analyticsDescription',
      onPress: () => navigation.navigate('StockDashboard' as never),
      color: '#007AFF',
    },
    {
      titleKey: 'reportIssue',
      descriptionKey: 'issueDescription',
      onPress: () => navigation.navigate('SafetyDashboard' as never),
      color: '#dc3545',
    },
    {
      titleKey: 'viewReports',
      descriptionKey: 'reportsDescription',
      onPress: () => navigation.navigate('AIDocumentTools' as never),
      color: '#28a745',
    },
  ];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContainer}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.title}>{aiService.getText('title')}</Text>
          <Text style={styles.subtitle}>{aiService.getText('subtitle')}</Text>
          <Text style={styles.version}>{aiService.getText('version')}</Text>
        </View>

        {/* Welcome Message */}
        <View style={styles.welcomeContainer}>
          <Text style={styles.welcomeTitle}>{aiService.getText('welcomeTitle')}</Text>
          <Text style={styles.welcomeText}>
            {aiService.getText('welcomeText')}
          </Text>
        </View>

        {/* Main Modules */}
        <View style={styles.modulesSection}>
          <Text style={styles.sectionTitle}>{aiService.getText('mainModules')}</Text>
          
          {mainModules.map((module, index) => (
            <TouchableOpacity
              key={index}
              style={styles.moduleCard}
              onPress={() => navigation.navigate(module.name as never)}
            >
              <View style={styles.moduleHeader}>
                <Ionicons name={module.icon as any} size={32} color={module.color} />
                <View style={styles.moduleInfo}>
                  <Text style={styles.moduleTitle}>{aiService.getText(module.titleKey)}</Text>
                  <Text style={styles.moduleDescription}>{aiService.getText(module.descriptionKey)}</Text>
                  <Text style={styles.moduleStats}>{module.stats}</Text>
                </View>
                <Ionicons name="arrow-forward" size={24} color={module.color} />
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* Quick Actions */}
        <View style={styles.quickActionsSection}>
          <Text style={styles.sectionTitle}>{aiService.getText('quickActions')}</Text>
          
          <View style={styles.quickActionsGrid}>
            {quickActions.map((action, index) => (
              <TouchableOpacity
                key={index}
                style={[styles.quickActionButton, { borderColor: action.color }]}
                onPress={action.onPress}
              >
                <Text style={styles.quickActionTitle}>{aiService.getText(action.titleKey)}</Text>
                <Text style={styles.quickActionDescription}>{aiService.getText(action.descriptionKey)}</Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* System Status */}
        <View style={styles.statusSection}>
          <Text style={styles.sectionTitle}>{aiService.getText('systemStatus')}</Text>
          
          <View style={styles.statusGrid}>
            <View style={styles.statusItem}>
              <Ionicons name="checkmark-circle" size={24} color="#28a745" />
              <Text style={styles.statusText}>{aiService.getText('allSystemsOnline')}</Text>
            </View>
            <View style={styles.statusItem}>
              <Ionicons name="cloud" size={24} color="#007AFF" />
              <Text style={styles.statusText}>{aiService.getText('cloudSyncActive')}</Text>
            </View>
            <View style={styles.statusItem}>
              <Ionicons name="shield-checkmark" size={24} color="#ff6b35" />
              <Text style={styles.statusText}>{aiService.getText('securityVerified')}</Text>
            </View>
            <View style={styles.statusItem}>
              <Ionicons name="analytics" size={24} color="#9b59b6" />
              <Text style={styles.statusText}>{aiService.getText('aiProcessing')}</Text>
            </View>
          </View>
        </View>

        {/* Getting Started */}
        <View style={styles.gettingStartedSection}>
          <Text style={styles.sectionTitle}>{aiService.getText('gettingStarted')}</Text>
          
          <View style={styles.tipsContainer}>
            <Text style={styles.tipText}>{aiService.getText('tip1')}</Text>
            <Text style={styles.tipText}>{aiService.getText('tip2')}</Text>
            <Text style={styles.tipText}>{aiService.getText('tip3')}</Text>
            <Text style={styles.tipText}>{aiService.getText('tip4')}</Text>
          </View>
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
    backgroundColor: '#f8f9fa', // Light gray background
  },
  scrollContainer: {
    padding: 20,
  },
  header: {
    alignItems: 'center',
    marginBottom: 30,
    paddingTop: 20,
    backgroundColor: '#ffffff',
    borderRadius: 16,
    padding: 20,
    marginHorizontal: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#2c3e50',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 18,
    color: '#7f8c8d',
    textAlign: 'center',
    marginBottom: 4,
  },
  version: {
    fontSize: 14,
    color: '#95a5a6',
    fontWeight: '600',
  },
  welcomeContainer: {
    backgroundColor: '#ffffff',
    borderRadius: 16,
    padding: 24,
    marginBottom: 30,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 5,
  },
  welcomeTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2c3e50',
    marginBottom: 12,
    textAlign: 'center',
  },
  welcomeText: {
    fontSize: 16,
    color: '#7f8c8d',
    lineHeight: 24,
    textAlign: 'center',
  },
  modulesSection: {
    marginBottom: 30,
  },
  sectionTitle: {
    fontSize: 22,
    fontWeight: 'bold',
    color: '#2c3e50',
    marginBottom: 20,
  },
  moduleCard: {
    backgroundColor: '#ffffff',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.05,
    shadowRadius: 4,
    elevation: 2,
  },
  moduleHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  moduleInfo: {
    flex: 1,
    marginLeft: 16,
  },
  moduleTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#2c3e50',
    marginBottom: 6,
  },
  moduleDescription: {
    fontSize: 14,
    color: '#7f8c8d',
    marginBottom: 8,
    lineHeight: 20,
  },
  moduleStats: {
    fontSize: 12,
    color: '#95a5a6',
    fontWeight: '600',
  },
  quickActionsSection: {
    marginBottom: 30,
  },
  quickActionsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    gap: 12,
  },
  quickActionButton: {
    flex: 1,
    minWidth: (width - 52) / 2,
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 8,
    elevation: 5,
    backgroundColor: '#fff',
    borderWidth: 2,
  },
  quickActionTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#000',
    marginBottom: 6,
    textAlign: 'center',
  },
  quickActionDescription: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
    lineHeight: 16,
  },
  statusSection: {
    marginBottom: 30,
  },
  statusGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    gap: 12,
  },
  statusItem: {
    flex: 1,
    minWidth: (width - 52) / 2,
    backgroundColor: '#ffffff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.05,
    shadowRadius: 4,
    elevation: 2,
  },
  statusText: {
    fontSize: 14,
    color: '#2c3e50',
    marginTop: 8,
    fontWeight: '600',
    textAlign: 'center',
  },
  gettingStartedSection: {
    marginBottom: 20,
  },
  tipsContainer: {
    backgroundColor: '#e8f4f8',
    borderRadius: 12,
    padding: 20,
  },
  tipText: {
    fontSize: 14,
    color: '#2c3e50',
    marginBottom: 8,
    lineHeight: 20,
  },
});

export default MainDashboardScreen;
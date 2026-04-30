// Civil Engineering Mobile Screen
// Main screen for civil engineering tools and workflow access

import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  Alert,
  Modal,
} from 'react-native';
import { useAgentState } from '../../hooks/useAgentState';
import CivilEngineeringWorkflow from './components/CivilEngineeringWorkflow';

const CivilEngineeringScreen = () => {
  const [activeTab, setActiveTab] = useState('foundation');
  const [showWorkflowModal, setShowWorkflowModal] = useState(false);
  const isAgentState = useAgentState();

  const tabs = [
    { id: 'foundation', label: 'Foundation', icon: '🏗️' },
    { id: 'structural', label: 'Structural', icon: '🔧' },
    { id: 'soil', label: 'Soil Analysis', icon: '🌱' },
    { id: 'concrete', label: 'Concrete', icon: '🧱' },
  ];

  const handleOpenWorkflow = () => {
    if (isAgentState) {
      setShowWorkflowModal(true);
    } else {
      Alert.alert(
        'Agent Access Required',
        'Document Generator is only available when in Agent state.',
        [{ text: 'OK' }]
      );
    }
  };

  const renderTabContent = () => {
    switch (activeTab) {
      case 'foundation':
        return <FoundationDesignPanel />;
      case 'structural':
        return <StructuralAnalysisPanel />;
      case 'soil':
        return <SoilAnalysisPanel />;
      case 'concrete':
        return <ConcreteMixPanel />;
      default:
        return <FoundationDesignPanel />;
    }
  };

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.title}>Civil Engineering</Text>
        <Text style={styles.subtitle}>Foundation Design & Structural Analysis</Text>
      </View>

      {/* Agent State Workflow Button */}
      {isAgentState && (
        <TouchableOpacity
          style={styles.workflowButton}
          onPress={handleOpenWorkflow}
        >
          <Text style={styles.workflowButtonText}>Document Generator</Text>
          <Text style={styles.workflowButtonSubtext}>
            Access the complete 13-card civil engineering design workflow system
          </Text>
        </TouchableOpacity>
      )}

      {/* Tab Navigation */}
      <View style={styles.tabContainer}>
        {tabs.map(tab => (
          <TouchableOpacity
            key={tab.id}
            style={[
              styles.tab,
              activeTab === tab.id && styles.activeTab
            ]}
            onPress={() => setActiveTab(tab.id)}
          >
            <Text style={styles.tabIcon}>{tab.icon}</Text>
            <Text style={[
              styles.tabLabel,
              activeTab === tab.id && styles.activeTabLabel
            ]}>
              {tab.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Tab Content */}
      <ScrollView style={styles.content}>
        {renderTabContent()}
      </ScrollView>

      {/* Workflow Modal */}
      <Modal
        visible={showWorkflowModal}
        animationType="slide"
        presentationStyle="fullScreen"
        onRequestClose={() => setShowWorkflowModal(false)}
      >
        <CivilEngineeringWorkflow
          onClose={() => setShowWorkflowModal(false)}
        />
      </Modal>
    </View>
  );
};

// Placeholder components for existing functionality
const FoundationDesignPanel = () => (
  <View style={styles.panel}>
    <Text style={styles.panelTitle}>Foundation Design Calculator</Text>
    <Text style={styles.panelDescription}>
      Calculate foundation dimensions, reinforcement, and safety factors
    </Text>
    <TouchableOpacity style={styles.actionButton}>
      <Text style={styles.actionButtonText}>Start Calculation</Text>
    </TouchableOpacity>
  </View>
);

const StructuralAnalysisPanel = () => (
  <View style={styles.panel}>
    <Text style={styles.panelTitle}>Structural Analysis Tools</Text>
    <Text style={styles.panelDescription}>
      Perform structural calculations and analysis
    </Text>
    <TouchableOpacity style={styles.actionButton}>
      <Text style={styles.actionButtonText}>Open Calculator</Text>
    </TouchableOpacity>
  </View>
);

const SoilAnalysisPanel = () => (
  <View style={styles.panel}>
    <Text style={styles.panelTitle}>Soil Analysis Integration</Text>
    <Text style={styles.panelDescription}>
      Bearing capacity and settlement analysis
    </Text>
    <TouchableOpacity style={styles.actionButton}>
      <Text style={styles.actionButtonText}>Analyze Soil</Text>
    </TouchableOpacity>
  </View>
);

const ConcreteMixPanel = () => (
  <View style={styles.panel}>
    <Text style={styles.panelTitle}>Concrete Mix Design</Text>
    <Text style={styles.panelDescription}>
      Design concrete mixes and calculate quantities
    </Text>
    <TouchableOpacity style={styles.actionButton}>
      <Text style={styles.actionButtonText}>Design Mix</Text>
    </TouchableOpacity>
  </View>
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#2563eb',
    padding: 20,
    paddingTop: 60,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: 'white',
    marginBottom: 4,
  },
  subtitle: {
    fontSize: 16,
    color: 'rgba(255, 255, 255, 0.8)',
  },
  workflowButton: {
    backgroundColor: '#10b981',
    margin: 16,
    padding: 16,
    borderRadius: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  workflowButtonText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: 'white',
    textAlign: 'center',
  },
  workflowButtonSubtext: {
    fontSize: 14,
    color: 'rgba(255, 255, 255, 0.9)',
    textAlign: 'center',
    marginTop: 4,
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: 'white',
    marginHorizontal: 16,
    marginTop: 8,
    borderRadius: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  tab: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 8,
  },
  activeTab: {
    backgroundColor: '#2563eb',
  },
  tabIcon: {
    fontSize: 20,
    marginBottom: 4,
  },
  tabLabel: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
  },
  activeTabLabel: {
    color: 'white',
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  panel: {
    backgroundColor: 'white',
    padding: 20,
    borderRadius: 8,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  panelTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#1f2937',
    marginBottom: 8,
  },
  panelDescription: {
    fontSize: 14,
    color: '#6b7280',
    marginBottom: 16,
    lineHeight: 20,
  },
  actionButton: {
    backgroundColor: '#2563eb',
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 6,
    alignItems: 'center',
  },
  actionButtonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default CivilEngineeringScreen;
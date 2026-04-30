// Civil Engineering Panel Component
// Main interface for civil engineering calculations and tools

import React, { useState, useEffect } from 'react';
import {
  View,
  ScrollView,
  Text,
  TouchableOpacity,
  StyleSheet,
  Alert,
  ActivityIndicator,
  Dimensions
} from 'react-native';
import { Card, Button, Input, Select, SelectItem, Icon } from '@ui-kitten/components';
import { civilEngineeringService } from '../../services/civilEngineeringService';
import { FoundationDesignInput, StructuralAnalysisInput, SoilAnalysisInput, ConcreteMixDesignInput } from '../../services/civilEngineeringService';

const { width } = Dimensions.get('window');

interface CivilEngineeringPanelProps {
  projectId: string;
  onDrawingCreated?: (drawingIds: string[]) => void;
  onHITLRequired?: (reason: string) => void;
}

export const CivilEngineeringPanel: React.FC<CivilEngineeringPanelProps> = ({
  projectId,
  onDrawingCreated,
  onHITLRequired
}) => {
  const [activeTab, setActiveTab] = useState<'foundation' | 'structural' | 'soil' | 'concrete'>('foundation');
  const [loading, setLoading] = useState(false);
  const [progress, setProgress] = useState<string>('');
  const [results, setResults] = useState<any>(null);

  // Foundation Design State
  const [foundationInput, setFoundationInput] = useState<FoundationDesignInput>({
    projectId,
    location: { latitude: 0, longitude: 0 },
    loads: { deadLoad: 0, liveLoad: 0 },
    soilProperties: { bearingCapacity: 0, soilType: 'sand' },
    foundationType: 'isolated'
  });

  // Structural Analysis State
  const [structuralInput, setStructuralInput] = useState<StructuralAnalysisInput>({
    structureType: 'building',
    material: 'concrete',
    loads: { deadLoad: 0, liveLoad: 0, windLoad: 0, seismicLoad: 0 },
    geometry: {},
    constraints: {}
  });

  // Soil Analysis State
  const [soilInput, setSoilInput] = useState<SoilAnalysisInput>({
    location: { latitude: 0, longitude: 0 },
    testType: 'standard_penetration',
    testData: { depth: [], values: [] },
    projectRequirements: { foundationType: 'isolated', expectedLoads: 0 }
  });

  // Concrete Mix Design State
  const [concreteInput, setConcreteInput] = useState<ConcreteMixDesignInput>({
    strength: { target28Day: 25 },
    exposureConditions: { environment: 'moderate', exposureClass: 'XC3' },
    aggregateProperties: { maxSize: 20, specificGravity: 2.65, absorption: 1.5 },
    cementType: 'OPC',
    workability: { slump: 75, placementMethod: 'pump' }
  });

  const handleFoundationDesign = async () => {
    setLoading(true);
    setProgress('Starting foundation design calculation...');

    try {
      const result = await civilEngineeringService.designFoundation(foundationInput);

      setResults(result);
      onDrawingCreated?.(result.drawings);

      if (result.constructionNotes.some(note => note.includes('⚠️'))) {
        onHITLRequired?.('Foundation design requires specialist review');
      }

      Alert.alert(
        'Foundation Design Complete',
        `Designed ${result.foundationType} foundation with safety factors: Bearing ${result.safetyFactors.bearing.toFixed(1)}`,
        [{ text: 'OK' }]
      );

    } catch (error: any) {
      Alert.alert('Design Failed', error.message);
      onHITLRequired?.(error.message);
    } finally {
      setLoading(false);
      setProgress('');
    }
  };

  const handleStructuralAnalysis = async () => {
    setLoading(true);
    setProgress('Performing structural analysis...');

    try {
      const result = await civilEngineeringService.performStructuralAnalysis(structuralInput);
      setResults(result);

      Alert.alert(
        'Structural Analysis Complete',
        `Analysis completed with utilization ratios: Strength ${(result.utilizationRatios.strength * 100).toFixed(1)}%, Deflection ${(result.utilizationRatios.deflection * 100).toFixed(1)}%`
      );

    } catch (error: any) {
      Alert.alert('Analysis Failed', error.message);
    } finally {
      setLoading(false);
      setProgress('');
    }
  };

  const handleSoilAnalysis = async () => {
    setLoading(true);
    setProgress('Analyzing soil properties...');

    try {
      const result = await civilEngineeringService.analyzeSoilProperties(soilInput);
      setResults(result);

      Alert.alert(
        'Soil Analysis Complete',
        `Soil bearing capacity: ${result.bearingCapacity} kPa. ${result.suitabilityAssessment.recommendedType} foundation recommended.`
      );

    } catch (error: any) {
      Alert.alert('Analysis Failed', error.message);
    } finally {
      setLoading(false);
      setProgress('');
    }
  };

  const handleConcreteMixDesign = async () => {
    setLoading(true);
    setProgress('Designing concrete mix...');

    try {
      const result = await civilEngineeringService.designConcreteMix(concreteInput);
      setResults(result);

      Alert.alert(
        'Concrete Mix Design Complete',
        `Designed mix for ${result.characteristicStrength} MPa strength. Cost: R${result.costAnalysis?.costPerCubicMeter?.toFixed(2)}/m³`
      );

    } catch (error: any) {
      Alert.alert('Mix Design Failed', error.message);
    } finally {
      setLoading(false);
      setProgress('');
    }
  };

  const renderFoundationTab = () => (
    <ScrollView style={styles.tabContent}>
      <Card style={styles.inputCard}>
        <Text style={styles.sectionTitle}>Foundation Design Calculator</Text>

        <Input
          label="Dead Load (kN)"
          value={foundationInput.loads.deadLoad.toString()}
          onChangeText={(value) => setFoundationInput(prev => ({
            ...prev,
            loads: { ...prev.loads, deadLoad: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Input
          label="Live Load (kN)"
          value={foundationInput.loads.liveLoad.toString()}
          onChangeText={(value) => setFoundationInput(prev => ({
            ...prev,
            loads: { ...prev.loads, liveLoad: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Input
          label="Soil Bearing Capacity (kPa)"
          value={foundationInput.soilProperties.bearingCapacity.toString()}
          onChangeText={(value) => setFoundationInput(prev => ({
            ...prev,
            soilProperties: { ...prev.soilProperties, bearingCapacity: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Select
          label="Soil Type"
          value={foundationInput.soilProperties.soilType}
          onSelect={(index) => {
            const soilTypes = ['clay', 'sand', 'gravel', 'silt'];
            setFoundationInput(prev => ({
              ...prev,
              soilProperties: { ...prev.soilProperties, soilType: soilTypes[index.row] }
            }));
          }}
          style={styles.input}
        >
          <SelectItem title="Clay" />
          <SelectItem title="Sand" />
          <SelectItem title="Gravel" />
          <SelectItem title="Silt" />
        </Select>

        <Select
          label="Foundation Type"
          value={foundationInput.foundationType}
          onSelect={(index) => {
            const types = ['isolated', 'combined', 'raft', 'pile'];
            setFoundationInput(prev => ({ ...prev, foundationType: types[index.row] }));
          }}
          style={styles.input}
        >
          <SelectItem title="Isolated Footing" />
          <SelectItem title="Combined Footing" />
          <SelectItem title="Raft Foundation" />
          <SelectItem title="Pile Foundation" />
        </Select>

        <Button
          onPress={handleFoundationDesign}
          disabled={loading}
          style={styles.calculateButton}
        >
          {loading ? 'Designing...' : 'Design Foundation'}
        </Button>
      </Card>
    </ScrollView>
  );

  const renderStructuralTab = () => (
    <ScrollView style={styles.tabContent}>
      <Card style={styles.inputCard}>
        <Text style={styles.sectionTitle}>Structural Analysis Calculator</Text>

        <Select
          label="Structure Type"
          value={structuralInput.structureType}
          onSelect={(index) => {
            const types = ['building', 'bridge', 'tower', 'industrial'];
            setStructuralInput(prev => ({ ...prev, structureType: types[index.row] }));
          }}
          style={styles.input}
        >
          <SelectItem title="Building" />
          <SelectItem title="Bridge" />
          <SelectItem title="Tower" />
          <SelectItem title="Industrial" />
        </Select>

        <Select
          label="Material"
          value={structuralInput.material}
          onSelect={(index) => {
            const materials = ['concrete', 'steel', 'timber', 'masonry'];
            setStructuralInput(prev => ({ ...prev, material: materials[index.row] }));
          }}
          style={styles.input}
        >
          <SelectItem title="Concrete" />
          <SelectItem title="Steel" />
          <SelectItem title="Timber" />
          <SelectItem title="Masonry" />
        </Select>

        <Input
          label="Dead Load (kN)"
          value={structuralInput.loads.deadLoad.toString()}
          onChangeText={(value) => setStructuralInput(prev => ({
            ...prev,
            loads: { ...prev.loads, deadLoad: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Input
          label="Live Load (kN)"
          value={structuralInput.loads.liveLoad.toString()}
          onChangeText={(value) => setStructuralInput(prev => ({
            ...prev,
            loads: { ...prev.loads, liveLoad: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Input
          label="Wind Load (kN)"
          value={structuralInput.loads.windLoad.toString()}
          onChangeText={(value) => setStructuralInput(prev => ({
            ...prev,
            loads: { ...prev.loads, windLoad: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Button
          onPress={handleStructuralAnalysis}
          disabled={loading}
          style={styles.calculateButton}
        >
          {loading ? 'Analyzing...' : 'Perform Analysis'}
        </Button>
      </Card>
    </ScrollView>
  );

  const renderSoilTab = () => (
    <ScrollView style={styles.tabContent}>
      <Card style={styles.inputCard}>
        <Text style={styles.sectionTitle}>Soil Analysis Tool</Text>

        <Select
          label="Test Type"
          value={soilInput.testType}
          onSelect={(index) => {
            const types = ['standard_penetration', 'cone_penetration', 'laboratory', 'field_observation'];
            setSoilInput(prev => ({ ...prev, testType: types[index.row] }));
          }}
          style={styles.input}
        >
          <SelectItem title="Standard Penetration Test" />
          <SelectItem title="Cone Penetration Test" />
          <SelectItem title="Laboratory Test" />
          <SelectItem title="Field Observation" />
        </Select>

        <Input
          label="Test Values (comma-separated)"
          value={soilInput.testData.values.join(', ')}
          onChangeText={(value) => setSoilInput(prev => ({
            ...prev,
            testData: {
              ...prev.testData,
              values: value.split(',').map(v => parseFloat(v.trim()) || 0)
            }
          }))}
          placeholder="10, 12, 15, 18, 20"
          style={styles.input}
        />

        <Input
          label="Depths (m, comma-separated)"
          value={soilInput.testData.depth.join(', ')}
          onChangeText={(value) => setSoilInput(prev => ({
            ...prev,
            testData: {
              ...prev.testData,
              depth: value.split(',').map(v => parseFloat(v.trim()) || 0)
            }
          }))}
          placeholder="1, 2, 3, 4, 5"
          style={styles.input}
        />

        <Input
          label="Expected Loads (kN)"
          value={soilInput.projectRequirements.expectedLoads.toString()}
          onChangeText={(value) => setSoilInput(prev => ({
            ...prev,
            projectRequirements: { ...prev.projectRequirements, expectedLoads: parseFloat(value) || 0 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Button
          onPress={handleSoilAnalysis}
          disabled={loading}
          style={styles.calculateButton}
        >
          {loading ? 'Analyzing...' : 'Analyze Soil'}
        </Button>
      </Card>
    </ScrollView>
  );

  const renderConcreteTab = () => (
    <ScrollView style={styles.tabContent}>
      <Card style={styles.inputCard}>
        <Text style={styles.sectionTitle}>Concrete Mix Design Calculator</Text>

        <Input
          label="Target 28-Day Strength (MPa)"
          value={concreteInput.strength.target28Day.toString()}
          onChangeText={(value) => setConcreteInput(prev => ({
            ...prev,
            strength: { ...prev.strength, target28Day: parseFloat(value) || 25 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Select
          label="Exposure Environment"
          value={concreteInput.exposureConditions.environment}
          onSelect={(index) => {
            const environments = ['mild', 'moderate', 'severe', 'very_severe', 'extreme'];
            setConcreteInput(prev => ({
              ...prev,
              exposureConditions: { ...prev.exposureConditions, environment: environments[index.row] }
            }));
          }}
          style={styles.input}
        >
          <SelectItem title="Mild" />
          <SelectItem title="Moderate" />
          <SelectItem title="Severe" />
          <SelectItem title="Very Severe" />
          <SelectItem title="Extreme" />
        </Select>

        <Input
          label="Max Aggregate Size (mm)"
          value={concreteInput.aggregateProperties.maxSize.toString()}
          onChangeText={(value) => setConcreteInput(prev => ({
            ...prev,
            aggregateProperties: { ...prev.aggregateProperties, maxSize: parseFloat(value) || 20 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Select
          label="Cement Type"
          value={concreteInput.cementType}
          onSelect={(index) => {
            const types = ['OPC', 'PPC', 'PSC', 'SRPC'];
            setConcreteInput(prev => ({ ...prev, cementType: types[index.row] }));
          }}
          style={styles.input}
        >
          <SelectItem title="OPC (Ordinary Portland Cement)" />
          <SelectItem title="PPC (Portland Pozzolana Cement)" />
          <SelectItem title="PSC (Portland Slag Cement)" />
          <SelectItem title="SRPC (Sulphate Resistant Cement)" />
        </Select>

        <Input
          label="Target Slump (mm)"
          value={concreteInput.workability.slump.toString()}
          onChangeText={(value) => setConcreteInput(prev => ({
            ...prev,
            workability: { ...prev.workability, slump: parseFloat(value) || 75 }
          }))}
          keyboardType="numeric"
          style={styles.input}
        />

        <Button
          onPress={handleConcreteMixDesign}
          disabled={loading}
          style={styles.calculateButton}
        >
          {loading ? 'Designing...' : 'Design Mix'}
        </Button>
      </Card>
    </ScrollView>
  );

  const renderResults = () => {
    if (!results) return null;

    return (
      <Card style={styles.resultsCard}>
        <Text style={styles.resultsTitle}>Calculation Results</Text>
        <ScrollView style={styles.resultsScroll}>
          <Text style={styles.resultsText}>
            {JSON.stringify(results, null, 2)}
          </Text>
        </ScrollView>
      </Card>
    );
  };

  return (
    <View style={styles.container}>
      {/* Tab Navigation */}
      <View style={styles.tabBar}>
        {[
          { key: 'foundation', label: 'Foundation', icon: '🏗️' },
          { key: 'structural', label: 'Structural', icon: '🔧' },
          { key: 'soil', label: 'Soil', icon: '🌱' },
          { key: 'concrete', label: 'Concrete', icon: '🧱' }
        ].map((tab) => (
          <TouchableOpacity
            key={tab.key}
            style={[styles.tab, activeTab === tab.key && styles.activeTab]}
            onPress={() => setActiveTab(tab.key as any)}
          >
            <Text style={styles.tabIcon}>{tab.icon}</Text>
            <Text style={[styles.tabLabel, activeTab === tab.key && styles.activeTabLabel]}>
              {tab.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Progress Indicator */}
      {loading && (
        <View style={styles.progressContainer}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.progressText}>{progress}</Text>
        </View>
      )}

      {/* Tab Content */}
      {activeTab === 'foundation' && renderFoundationTab()}
      {activeTab === 'structural' && renderStructuralTab()}
      {activeTab === 'soil' && renderSoilTab()}
      {activeTab === 'concrete' && renderConcreteTab()}

      {/* Results Display */}
      {results && renderResults()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  tabBar: {
    flexDirection: 'row',
    backgroundColor: 'white',
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  tab: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 4,
  },
  activeTab: {
    borderBottomWidth: 3,
    borderBottomColor: '#007AFF',
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
    color: '#007AFF',
    fontWeight: '600',
  },
  tabContent: {
    flex: 1,
    padding: 16,
  },
  inputCard: {
    marginBottom: 16,
    borderRadius: 12,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
    textAlign: 'center',
  },
  input: {
    marginBottom: 12,
  },
  calculateButton: {
    marginTop: 16,
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  },
  progressContainer: {
    padding: 16,
    alignItems: 'center',
    backgroundColor: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  progressText: {
    marginTop: 8,
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
  },
  resultsCard: {
    margin: 16,
    borderRadius: 12,
    maxHeight: 300,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  resultsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
    textAlign: 'center',
  },
  resultsScroll: {
    maxHeight: 250,
  },
  resultsText: {
    fontSize: 12,
    fontFamily: 'monospace',
    color: '#666',
    lineHeight: 16,
  },
});

export default CivilEngineeringPanel;
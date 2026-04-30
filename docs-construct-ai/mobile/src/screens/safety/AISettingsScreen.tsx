import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  Alert,
  Switch,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { aiService, AIModel } from '../../services/aiService';

const AISettingsScreen: React.FC = () => {
  const navigation = useNavigation();
  const [availableModels, setAvailableModels] = useState<AIModel[]>([]);
  const [currentModel, setCurrentModel] = useState<AIModel | null>(null);
  const [selectedModelId, setSelectedModelId] = useState<string>('');
  const [temperature, setTemperature] = useState<number>(0.7);
  const [currentLanguage, setCurrentLanguage] = useState<string>('en');
  const [isDirty, setIsDirty] = useState<boolean>(false);

  // Available languages with friendly names and flags
  const AVAILABLE_LANGUAGES = [
    { code: 'en', name: 'English', flag: '🇺🇸' },
    { code: 'es', name: 'Español', flag: '🇪🇸' },
    { code: 'fr', name: 'Français', flag: '🇫🇷' },
    { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
    { code: 'pt', name: 'Português', flag: '🇰🇷' },
    { code: 'ar', name: 'العربية', flag: '🇸🇦', rtl: true },
    { code: 'xh', name: 'isiXhosa', flag: '🇿🇦' },
    { code: 'zu', name: 'isiZulu', flag: '🇿🇦' },
  ];

  useEffect(() => {
    loadAISettings();
  }, []);

  const loadAISettings = async () => {
    try {
      const models = aiService.getAvailableModels();
      const current = aiService.getCurrentModel();
      const currentTemp = current?.defaultTemperature || 0.7;
      const savedLanguage = await AsyncStorage.getItem('ai_language') || 'en';
      const currentAILanguage = aiService.getLanguage();

      setAvailableModels(models);
      setCurrentModel(current);
      setSelectedModelId(current?.id || '');
      setTemperature(currentTemp);
      setCurrentLanguage(savedLanguage);
      aiService.setLanguage(savedLanguage);
      setIsDirty(false);
    } catch (error) {
      console.error('Error loading AI settings:', error);
      Alert.alert('Error', 'Failed to load AI settings');
    }
  };

  const handleModelChange = (modelId: string) => {
    if (currentModel?.id !== modelId) {
      const newModel = availableModels.find(m => m.id === modelId);
      if (newModel) {
        setSelectedModelId(modelId);
        setTemperature(newModel.defaultTemperature);
        setIsDirty(true);
      }
    }
  };

  const handleSaveSettings = () => {
    try {
      const success = aiService.switchModel(selectedModelId);
      if (success) {
        const newModel = availableModels.find(m => m.id === selectedModelId);
        setCurrentModel(newModel || null);
        setIsDirty(false);
        Alert.alert('Success', 'AI settings saved successfully');
      } else {
        Alert.alert('Error', 'Failed to switch AI model');
      }
    } catch (error) {
      console.error('Error saving AI settings:', error);
      Alert.alert('Error', 'Failed to save AI settings');
    }
  };

  const handleResetSettings = () => {
    loadAISettings();
  };

  const getCapabilityIcon = (capability: string) => {
    switch (capability) {
      case 'text-analysis':
        return 'document-text';
      case 'video-analysis':
        return 'videocam';
      case 'risk-assessment':
        return 'warning';
      default:
        return 'settings';
    }
  };

  const getCapabilityDescription = (capability: string) => {
    switch (capability) {
      case 'text-analysis':
        return 'Analyze documents and reports';
      case 'video-analysis':
        return 'Process safety video content';
      case 'risk-assessment':
        return 'Generate risk assessments';
      default:
        return capability;
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity
          onPress={() => navigation.goBack()}
          style={styles.backButton}
        >
          <Ionicons name="arrow-back" size={24} color="#007AFF" />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>AI Settings</Text>
        <View style={{ width: 40 }} />
      </View>

      <ScrollView style={styles.content}>
        {/* Language Selection - PRINICIPAL POSITION */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>🌍 Choose Your Language</Text>
          <Text style={styles.languageDescription}>
            Select your preferred language for AI interactions and safety reports.
            This will be used immediately for all AI functions.
          </Text>
          <View style={styles.languageContainer}>
            {AVAILABLE_LANGUAGES.map((language) => (
              <TouchableOpacity
                key={language.code}
                style={[
                  styles.languageCard,
                  currentLanguage === language.code && styles.languageCardSelected
                ]}
                onPress={async () => {
                  try {
                    setCurrentLanguage(language.code);
                    aiService.setLanguage(language.code);
                    await AsyncStorage.setItem('ai_language', language.code);
                    setIsDirty(true);
                  } catch (error) {
                    console.error('Error saving language:', error);
                    Alert.alert('Error', 'Failed to save language setting');
                  }
                }}
              >
                <View style={styles.languageHeader}>
                  <Text style={styles.languageFlag}>{language.flag}</Text>
                  <View style={styles.languageInfo}>
                    <Text style={styles.languageName}>{language.name}</Text>
                  </View>
                  {currentLanguage === language.code && (
                    <Ionicons name="checkmark-circle" size={24} color="#28a745" />
                  )}
                </View>

                {language.rtl && (
                  <Text style={styles.rtlNote}>RTL (Right-to-Left) Language</Text>
                )}
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Current Model Status */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Current AI Model</Text>
          <View style={styles.currentModelCard}>
            <View style={styles.modelHeader}>
              <Ionicons name="settings" size={28} color="#007AFF" />
              <View style={styles.modelInfo}>
                <Text style={styles.modelName}>
                  {currentModel?.name || 'No Model Selected'}
                </Text>
                <Text style={styles.modelProvider}>
                  {currentModel?.provider || 'Unknown Provider'}
                </Text>
              </View>
            </View>
            <Text style={styles.modelDescription}>
              {currentModel?.description || 'No model description available'}
            </Text>
          </View>
        </View>

        {/* Model Selection */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Available Models</Text>
          {availableModels.map((model) => (
            <TouchableOpacity
              key={model.id}
              style={[
                styles.modelCard,
                selectedModelId === model.id && styles.modelCardSelected
              ]}
              onPress={() => handleModelChange(model.id)}
            >
              <View style={styles.modelHeader}>
                <View style={styles.modelIcon}>
                  <Ionicons name="settings" size={24} color="#007AFF" />
                </View>
                <View style={styles.modelInfo}>
                  <Text style={styles.modelName}>{model.name}</Text>
                  <Text style={styles.modelProvider}>{model.provider}</Text>
                </View>
                {selectedModelId === model.id && (
                  <Ionicons name="checkmark-circle" size={24} color="#28a745" />
                )}
              </View>

              <Text style={styles.modelDescription}>{model.description}</Text>

              {/* Model Capabilities */}
              <View style={styles.capabilitiesContainer}>
                <Text style={styles.capabilitiesTitle}>Capabilities:</Text>
                <View style={styles.capabilitiesList}>
                  {model.capabilities.map((capability, index) => (
                    <View key={index} style={styles.capabilityItem}>
                      <Ionicons
                        name={getCapabilityIcon(capability)}
                        size={16}
                        color="#007AFF"
                      />
                      <Text style={styles.capabilityText}>
                        {getCapabilityDescription(capability)}
                      </Text>
                    </View>
                  ))}
                </View>
              </View>

              {/* Model Statistics */}
              <View style={styles.modelStats}>
                <View style={styles.statItem}>
                  <Text style={styles.statLabel}>Max Tokens</Text>
                  <Text style={styles.statValue}>{model.maxTokens}</Text>
                </View>
                <View style={styles.statItem}>
                  <Text style={styles.statLabel}>Temperature</Text>
                  <Text style={styles.statValue}>{model.defaultTemperature}</Text>
                </View>
              </View>
            </TouchableOpacity>
          ))}
        </View>

        {/* Temperature Settings */}
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Temperature Setting</Text>
          <View style={styles.temperatureContainer}>
            <Text style={styles.temperatureLabel}>
              Creativity Level: {temperature.toFixed(1)}
            </Text>
            <Text style={styles.temperatureDescription}>
              Lower values = More predictable responses{'\n'}
              Higher values = More creative responses
            </Text>
            <View style={styles.temperatureControls}>
              <TouchableOpacity
                style={[styles.temperatureButton, temperature <= 0.1 && styles.temperatureButtonActive]}
                onPress={() => {
                  const newTemp = Math.max(0, temperature - 0.1);
                  setTemperature(newTemp);
                  setIsDirty(true);
                }}
              >
                <Text style={styles.temperatureButtonText}>-</Text>
              </TouchableOpacity>

              <View style={styles.temperatureBar}>
                <View
                  style={[
                    styles.temperatureFill,
                    { width: `${temperature * 100}%` }
                  ]}
                />
              </View>

              <TouchableOpacity
                style={[styles.temperatureButton, temperature >= 1.0 && styles.temperatureButtonActive]}
                onPress={() => {
                  const newTemp = Math.min(1.0, temperature + 0.1);
                  setTemperature(newTemp);
                  setIsDirty(true);
                }}
              >
                <Text style={styles.temperatureButtonText}>+</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>



        {/* Action Buttons */}
        {isDirty && (
          <View style={styles.section}>
            <TouchableOpacity
              style={styles.saveButton}
              onPress={handleSaveSettings}
            >
              <Ionicons name="save" size={20} color="#fff" />
              <Text style={styles.saveButtonText}>Save Settings</Text>
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.resetButton}
              onPress={handleResetSettings}
            >
              <Ionicons name="refresh" size={20} color="#666" />
              <Text style={styles.resetButtonText}>Reset Changes</Text>
            </TouchableOpacity>
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
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  backButton: {
    width: 40,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  content: {
    flex: 1,
  },
  section: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },

  // Current Model Card
  currentModelCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  modelHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  modelInfo: {
    marginLeft: 12,
    flex: 1,
  },
  modelName: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  modelProvider: {
    fontSize: 14,
    color: '#666',
  },
  modelDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },

  // Model Selection Cards
  modelCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  modelCardSelected: {
    borderColor: '#007AFF',
  },
  modelIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#f0f8ff',
    justifyContent: 'center',
    alignItems: 'center',
  },

  // Capabilities
  capabilitiesContainer: {
    marginTop: 12,
  },
  capabilitiesTitle: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  capabilitiesList: {
    flexDirection: 'row',
    flexWrap: 'wrap',
  },
  capabilityItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f8f9fa',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    marginRight: 8,
    marginBottom: 4,
  },
  capabilityText: {
    fontSize: 12,
    color: '#666',
    marginLeft: 4,
  },

  // Model Statistics
  modelStats: {
    flexDirection: 'row',
    marginTop: 12,
  },
  statItem: {
    flex: 1,
    alignItems: 'center',
  },
  statLabel: {
    fontSize: 12,
    color: '#666',
    marginBottom: 4,
  },
  statValue: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#007AFF',
  },

  // Temperature Settings
  temperatureContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  temperatureLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
    marginBottom: 8,
  },
  temperatureDescription: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    marginBottom: 20,
    lineHeight: 20,
  },
  temperatureControls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 10,
  },
  temperatureButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    marginHorizontal: 10,
  },
  temperatureButtonActive: {
    backgroundColor: '#007AFF',
  },
  temperatureButtonText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#666',
  },
  temperatureBar: {
    flex: 1,
    height: 8,
    backgroundColor: '#e0e0e0',
    borderRadius: 4,
    overflow: 'hidden',
  },
  temperatureFill: {
    height: '100%',
    backgroundColor: '#007AFF',
    borderRadius: 4,
  },

  // Language Selection Styles
  languageDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 16,
    lineHeight: 20,
  },
  languageContainer: {
    marginTop: 12,
  },
  languageCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  languageCardSelected: {
    borderColor: '#007AFF',
  },
  languageHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  languageFlag: {
    fontSize: 24,
    marginRight: 12,
  },
  languageInfo: {
    flex: 1,
  },
  languageName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
  },
  rtlNote: {
    fontSize: 12,
    color: '#007AFF',
    fontStyle: 'italic',
    marginTop: 4,
  },

  // Action Buttons
  saveButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#28a745',
    padding: 16,
    borderRadius: 12,
    marginBottom: 12,
  },
  saveButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
    marginLeft: 8,
  },
  resetButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  resetButtonText: {
    color: '#666',
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
});

export default AISettingsScreen;

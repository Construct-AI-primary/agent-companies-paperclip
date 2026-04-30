import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  SafeAreaView,
  Alert,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { Ionicons } from '@expo/vector-icons';
import { useSelector } from 'react-redux';
import { RootState } from '../../store';
import { voiceService, VoiceCommand } from '../../services/voiceService';
import { aiService } from '../../services/aiService';

const SafetyDashboardScreen: React.FC = () => {
  const navigation = useNavigation();
  const incidents = useSelector((state: RootState) => state.safety.incidents);
  const hazards = useSelector((state: RootState) => state.safety.hazards);
  const [isVoiceListening, setIsVoiceListening] = useState(false);
  const [languageTrigger, setLanguageTrigger] = useState(0);
  const unsubscribeRef = useRef<(() => void) | null>(null);

  useEffect(() => {
    // Listen for language changes with proper cleanup
    const unsubscribe = aiService.onLanguageChange(() => {
      setLanguageTrigger(prev => prev + 1);
    });

    unsubscribeRef.current = unsubscribe;

    // Force initial render to ensure translation is applied
    setLanguageTrigger(prev => prev + 1);

    return () => {
      if (unsubscribeRef.current) {
        unsubscribeRef.current();
        unsubscribeRef.current = null;
      }
    };
  }, []);

  const handleIncidentReport = () => {
    navigation.navigate('IncidentReport' as never);
  };

  const handleHazardReport = () => {
    navigation.navigate('HazardReport' as never);
  };

  const handleSyncData = () => {
    Alert.alert('Sync Data', 'Sync functionality will be implemented here');
  };

  const handleSettings = () => {
    navigation.navigate('SafetySettings' as never);
  };

  const handleVoiceCommand = async (command: VoiceCommand) => {
    try {
      switch (command.command) {
        case 'report_incident':
          await voiceService.speak('Opening incident report form');
          handleIncidentReport();
          break;
        case 'report_hazard':
          await voiceService.speak('Opening hazard report form');
          handleHazardReport();
          break;
        case 'navigate_dashboard':
          await voiceService.speak('Already on dashboard');
          break;
        case 'help':
          const commands = voiceService.getVoiceCommands();
          const helpText = `Available commands: ${commands.map(c => c.action).join(', ')}`;
          await voiceService.speak(helpText);
          break;
        default:
          await voiceService.speak(`Command not recognized: ${command.action}`);
      }
    } catch (error) {
      console.error('Error handling voice command:', error);
    }
  };

  const toggleVoiceListening = async () => {
    try {
      if (isVoiceListening) {
        await voiceService.stopListening();
        setIsVoiceListening(false);
      } else {
        await voiceService.startListening(
          async (result) => {
            const command = voiceService.processVoiceCommand(result.text);
            if (command) {
              await handleVoiceCommand(command);
            }
          },
          (error) => {
            console.error('Voice error:', error);
            setIsVoiceListening(false);
          }
        );
        setIsVoiceListening(true);
        await voiceService.speak('Voice commands activated. Say help for available commands.');
      }
    } catch (error) {
      console.error('Error toggling voice:', error);
      setIsVoiceListening(false);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContainer}>
        <View style={styles.header}>
          <Text style={styles.title}>{aiService.getText('safetyDashboardTitle')}</Text>
          <Text style={styles.subtitle}>{aiService.getText('safetyDashboardSubtitle')}</Text>

          {/* Voice Control Button */}
          <TouchableOpacity
            testID="voice-button"
            style={[styles.voiceButton, isVoiceListening && styles.voiceButtonActive]}
            onPress={toggleVoiceListening}
          >
            <Ionicons
              name={isVoiceListening ? "mic-off" : "mic"}
              size={24}
              color="#fff"
            />
          </TouchableOpacity>
        </View>

        <View style={styles.statsContainer}>
          <TouchableOpacity
            style={styles.statCard}
            onPress={() => navigation.navigate('IncidentReport' as never)}
          >
            <Text style={styles.statNumber}>{incidents.length}</Text>
            <Text style={styles.statLabel}>{aiService.getText('totalIncidents')}</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.statCard}
            onPress={() => navigation.navigate('HazardReport' as never)}
          >
            <Text style={styles.statNumber}>{hazards.length}</Text>
            <Text style={styles.statLabel}>{aiService.getText('totalHazards')}</Text>
          </TouchableOpacity>
          <View style={styles.statCard}>
            <Text style={styles.statNumber}>
              {incidents.length > 0 ? Math.round((incidents.filter(i => i.synced).length / incidents.length) * 100) : 100}%
            </Text>
            <Text style={styles.statLabel}>{aiService.getText('syncStatus')}</Text>
          </View>
        </View>

        <View style={styles.quickActionsContainer}>
          <TouchableOpacity style={styles.actionButton} onPress={handleIncidentReport}>
            <Ionicons name="alert-circle" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>{aiService.getText('reportIncident')}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.actionButton} onPress={handleHazardReport}>
            <Ionicons name="warning" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>{aiService.getText('reportHazard')}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.actionButton} onPress={handleSyncData}>
            <Ionicons name="sync" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>{aiService.getText('syncData')}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.actionButton} onPress={handleSettings}>
            <Ionicons name="settings" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>{aiService.getText('settings')}</Text>
          </TouchableOpacity>

          <TouchableOpacity 
            style={styles.actionButton} 
            onPress={() => navigation.navigate('AIDocumentTools' as never)}
          >
            <Ionicons name="document-text" size={32} color="#fff" />
            <Text style={styles.actionButtonText}>{aiService.getText('aiTools')}</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.recentActivityContainer}>
          <Text style={styles.sectionTitle}>{aiService.getText('recentIncidents')}</Text>
          {incidents.length > 0 ? (
            incidents.slice(0, 5).map((incident) => (
              <TouchableOpacity
                key={incident.id}
                style={styles.activityItem}
                onPress={() => navigation.navigate('IncidentDetail' as never, { incidentId: incident.id })}
              >
                <Ionicons
                  name={incident.severity === 'critical' ? 'alert-circle' : 'information-circle'}
                  size={20}
                  color={
                    incident.severity === 'critical' ? '#dc3545' :
                    incident.severity === 'high' ? '#fd7e14' :
                    incident.severity === 'medium' ? '#ffc107' : '#28a745'
                  }
                />
                <View style={styles.activityContent}>
                  <Text style={styles.activityText} numberOfLines={1}>
                    {incident.incidentType.replace('_', ' ').toUpperCase()}: {incident.description}
                  </Text>
                  <Text style={styles.activityTime}>
                    {new Date(incident.reportedAt).toLocaleDateString()}
                  </Text>
                </View>
                <Ionicons name="chevron-forward" size={16} color="#ccc" />
              </TouchableOpacity>
            ))
          ) : (
            <View style={styles.emptyState}>
              <Ionicons name="document-text-outline" size={48} color="#ccc" />
              <Text style={styles.emptyStateText}>{aiService.getText('noIncidentsReported')}</Text>
              <TouchableOpacity
                style={styles.emptyStateButton}
                onPress={handleIncidentReport}
              >
                <Text style={styles.emptyStateButtonText}>{aiService.getText('reportFirstIncident')}</Text>
              </TouchableOpacity>
            </View>
          )}
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
    justifyContent: 'space-between',
    marginBottom: 24,
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
    flex: 1,
    marginHorizontal: 4,
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
    textAlign: 'center',
  },
  quickActionsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
    marginBottom: 24,
  },
  actionButton: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    width: '48%',
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
  recentActivityContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  activityItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 0.5,
    borderBottomColor: '#e0e0e0',
  },
  activityContent: {
    flex: 1,
    marginLeft: 12,
    marginRight: 8,
  },
  activityText: {
    fontSize: 14,
    color: '#333',
    marginBottom: 2,
  },
  activityTime: {
    fontSize: 12,
    color: '#666',
  },
  emptyState: {
    alignItems: 'center',
    paddingVertical: 32,
  },
  emptyStateText: {
    fontSize: 16,
    color: '#666',
    marginTop: 16,
    marginBottom: 16,
  },
  emptyStateButton: {
    backgroundColor: '#fff',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 8,
    borderWidth: 2,
    borderColor: '#007AFF',
  },
  emptyStateButtonText: {
    color: '#000',
    fontSize: 14,
    fontWeight: '600',
  },
  voiceButton: {
    position: 'absolute',
    top: 10,
    right: 10,
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 5,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  voiceButtonActive: {
    backgroundColor: '#FF3B30',
  },
});

export default SafetyDashboardScreen;

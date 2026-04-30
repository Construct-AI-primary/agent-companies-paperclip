import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Alert,
  ScrollView,
  TextInput,
  ActivityIndicator,
} from 'react-native';
import { useDispatch } from 'react-redux';
import { Ionicons } from '@expo/vector-icons';
import { voiceService, VoiceResult, VoiceCommand } from '../services/voiceService';
import { addIncident } from '../store/slices/safetySlice';
import { SafetyIncident } from '../store/slices/safetySlice';

interface VoiceIncidentReporterProps {
  onComplete?: (incident: SafetyIncident) => void;
  onCancel?: () => void;
}

export const VoiceIncidentReporter: React.FC<VoiceIncidentReporterProps> = ({
  onComplete,
  onCancel,
}) => {
  const dispatch = useDispatch();
  const [isListening, setIsListening] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);
  const [transcript, setTranscript] = useState('');
  const [description, setDescription] = useState('');
  const [severity, setSeverity] = useState<'low' | 'medium' | 'high' | 'critical'>('medium');
  const [incidentType, setIncidentType] = useState('');
  const [currentStep, setCurrentStep] = useState<'type' | 'description' | 'severity' | 'confirm'>('type');
  const [voiceStatus, setVoiceStatus] = useState('');

  const steps = {
    type: 'What type of incident occurred?',
    description: 'Please describe the incident in detail',
    severity: 'What is the severity level?',
    confirm: 'Please confirm the incident details'
  };

  useEffect(() => {
    // Initialize voice service
    return () => {
      voiceService.stopListening();
      voiceService.stopSpeaking();
    };
  }, []);

  const handleVoiceResult = async (result: VoiceResult) => {
    setTranscript(result.text);

    if (result.isFinal) {
      await processVoiceInput(result.text);
    }
  };

  const handleVoiceError = (error: string) => {
    setVoiceStatus(`Error: ${error}`);
    setIsListening(false);
  };

  const processVoiceInput = async (text: string) => {
    setIsProcessing(true);

    try {
      // Check for voice commands first
      const command = voiceService.processVoiceCommand(text);
      if (command) {
        await handleVoiceCommand(command);
        return;
      }

      // Process based on current step
      switch (currentStep) {
        case 'type':
          await processIncidentType(text);
          break;
        case 'description':
          await processDescription(text);
          break;
        case 'severity':
          await processSeverity(text);
          break;
        case 'confirm':
          await processConfirmation(text);
          break;
      }
    } catch (error) {
      console.error('Error processing voice input:', error);
      await voiceService.speak('Sorry, I didn\'t understand that. Please try again.');
    } finally {
      setIsProcessing(false);
    }
  };

  const processIncidentType = async (text: string) => {
    // Extract incident type from voice input
    const lowerText = text.toLowerCase();

    let detectedType = '';
    if (lowerText.includes('fall') || lowerText.includes('slip')) {
      detectedType = 'Fall/Slip';
    } else if (lowerText.includes('equipment') || lowerText.includes('machine')) {
      detectedType = 'Equipment Failure';
    } else if (lowerText.includes('chemical') || lowerText.includes('spill')) {
      detectedType = 'Chemical Spill';
    } else if (lowerText.includes('fire')) {
      detectedType = 'Fire';
    } else if (lowerText.includes('electrical')) {
      detectedType = 'Electrical Issue';
    } else {
      detectedType = text; // Use the raw input
    }

    setIncidentType(detectedType);
    await voiceService.speak(`Incident type set to ${detectedType}. Now please describe what happened.`);
    setCurrentStep('description');
  };

  const processDescription = async (text: string) => {
    setDescription(text);
    await voiceService.speak('Description recorded. What is the severity level: low, medium, high, or critical?');
    setCurrentStep('severity');
  };

  const processSeverity = async (text: string) => {
    const lowerText = text.toLowerCase();

    let detectedSeverity: 'low' | 'medium' | 'high' | 'critical' = 'medium';
    if (lowerText.includes('low') || lowerText.includes('minor')) {
      detectedSeverity = 'low';
    } else if (lowerText.includes('high') || lowerText.includes('serious')) {
      detectedSeverity = 'high';
    } else if (lowerText.includes('critical') || lowerText.includes('emergency')) {
      detectedSeverity = 'critical';
    }

    setSeverity(detectedSeverity);
    await voiceService.speak(`Severity set to ${detectedSeverity}. Please confirm: Type: ${incidentType}, Description: ${description}, Severity: ${detectedSeverity}. Say yes to submit or no to cancel.`);
    setCurrentStep('confirm');
  };

  const processConfirmation = async (text: string) => {
    const lowerText = text.toLowerCase();

    if (lowerText.includes('yes') || lowerText.includes('confirm') || lowerText.includes('submit')) {
      await submitIncident();
    } else if (lowerText.includes('no') || lowerText.includes('cancel')) {
      await voiceService.speak('Incident reporting cancelled.');
      onCancel?.();
    } else {
      await voiceService.speak('Please say yes to submit or no to cancel.');
    }
  };

  const handleVoiceCommand = async (command: VoiceCommand) => {
    switch (command.command) {
      case 'cancel':
        await voiceService.speak('Incident reporting cancelled.');
        onCancel?.();
        break;
      case 'help':
        await voiceService.speak('Available commands: cancel, help, or continue with incident details.');
        break;
      default:
        await voiceService.speak(`Command recognized: ${command.action}`);
    }
  };

  const submitIncident = async () => {
    try {
      const incidentData = {
        incidentType,
        description,
        severity,
        status: 'reported' as const,
        photos: [],
        videos: [],
        immediateActions: '',
      };

      const result = await dispatch(addIncident(incidentData));
      await voiceService.speak('Incident report submitted successfully.');

      if (onComplete) {
        onComplete(result.payload as SafetyIncident);
      }
    } catch (error) {
      console.error('Error submitting incident:', error);
      await voiceService.speak('Sorry, there was an error submitting the incident. Please try again.');
    }
  };

  const startListening = async () => {
    try {
      setVoiceStatus('Listening...');
      await voiceService.startListening(handleVoiceResult, handleVoiceError);
      setIsListening(true);
    } catch (error) {
      console.error('Error starting voice recognition:', error);
      setVoiceStatus('Error starting voice recognition');
    }
  };

  const stopListening = async () => {
    try {
      await voiceService.stopListening();
      setIsListening(false);
      setVoiceStatus('');
    } catch (error) {
      console.error('Error stopping voice recognition:', error);
    }
  };

  const getCurrentPrompt = () => {
    return steps[currentStep];
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Voice Incident Reporter</Text>
        <Text style={styles.step}>Step: {currentStep}</Text>
      </View>

      <View style={styles.promptContainer}>
        <Text style={styles.prompt}>{getCurrentPrompt()}</Text>
      </View>

      <View style={styles.voiceControls}>
        <TouchableOpacity
          style={[styles.voiceButton, isListening && styles.voiceButtonActive]}
          onPress={isListening ? stopListening : startListening}
          disabled={isProcessing}
        >
          {isProcessing ? (
            <ActivityIndicator color="#fff" />
          ) : (
            <Ionicons
              name={isListening ? "mic-off" : "mic"}
              size={32}
              color="#fff"
            />
          )}
        </TouchableOpacity>

        <Text style={styles.voiceStatus}>
          {isProcessing ? 'Processing...' : voiceStatus || 'Tap to speak'}
        </Text>
      </View>

      <View style={styles.transcriptContainer}>
        <Text style={styles.transcriptLabel}>Transcript:</Text>
        <Text style={styles.transcript}>{transcript || 'No speech detected'}</Text>
      </View>

      <View style={styles.detailsContainer}>
        <Text style={styles.detailsTitle}>Current Details:</Text>
        <Text>Type: {incidentType || 'Not set'}</Text>
        <Text>Description: {description || 'Not set'}</Text>
        <Text>Severity: {severity}</Text>
      </View>

      <View style={styles.manualInput}>
        <Text style={styles.manualTitle}>Or enter manually:</Text>

        <TextInput
          style={styles.input}
          placeholder="Incident Type"
          value={incidentType}
          onChangeText={setIncidentType}
        />

        <TextInput
          style={styles.input}
          placeholder="Description"
          value={description}
          onChangeText={setDescription}
          multiline
        />

        <View style={styles.severityButtons}>
          {(['low', 'medium', 'high', 'critical'] as const).map((level) => (
            <TouchableOpacity
              key={level}
              style={[
                styles.severityButton,
                severity === level && styles.severityButtonActive
              ]}
              onPress={() => setSeverity(level)}
            >
              <Text style={[
                styles.severityButtonText,
                severity === level && styles.severityButtonTextActive
              ]}>
                {level.toUpperCase()}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      <View style={styles.actionButtons}>
        <TouchableOpacity style={styles.cancelButton} onPress={onCancel}>
          <Text style={styles.cancelButtonText}>Cancel</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.submitButton, (!incidentType || !description) && styles.submitButtonDisabled]}
          onPress={submitIncident}
          disabled={!incidentType || !description}
        >
          <Text style={styles.submitButtonText}>Submit Report</Text>
        </TouchableOpacity>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  header: {
    alignItems: 'center',
    marginBottom: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 5,
  },
  step: {
    fontSize: 16,
    color: '#666',
  },
  promptContainer: {
    backgroundColor: '#f0f8ff',
    padding: 15,
    borderRadius: 10,
    marginBottom: 20,
  },
  prompt: {
    fontSize: 18,
    textAlign: 'center',
    color: '#333',
  },
  voiceControls: {
    alignItems: 'center',
    marginBottom: 20,
  },
  voiceButton: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 10,
  },
  voiceButtonActive: {
    backgroundColor: '#FF3B30',
  },
  voiceStatus: {
    fontSize: 16,
    color: '#666',
  },
  transcriptContainer: {
    backgroundColor: '#f9f9f9',
    padding: 15,
    borderRadius: 10,
    marginBottom: 20,
  },
  transcriptLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 5,
  },
  transcript: {
    fontSize: 14,
    color: '#666',
    fontStyle: 'italic',
  },
  detailsContainer: {
    backgroundColor: '#fff3cd',
    padding: 15,
    borderRadius: 10,
    marginBottom: 20,
  },
  detailsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  manualInput: {
    marginBottom: 20,
  },
  manualTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 5,
    padding: 10,
    marginBottom: 10,
    fontSize: 16,
  },
  severityButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 10,
  },
  severityButton: {
    flex: 1,
    padding: 10,
    marginHorizontal: 2,
    borderRadius: 5,
    borderWidth: 1,
    borderColor: '#ddd',
    alignItems: 'center',
  },
  severityButtonActive: {
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  },
  severityButtonText: {
    fontSize: 12,
    fontWeight: 'bold',
    color: '#666',
  },
  severityButtonTextActive: {
    color: '#fff',
  },
  actionButtons: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  cancelButton: {
    flex: 1,
    backgroundColor: '#6c757d',
    padding: 15,
    borderRadius: 5,
    marginRight: 10,
    alignItems: 'center',
  },
  cancelButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  submitButton: {
    flex: 2,
    backgroundColor: '#28a745',
    padding: 15,
    borderRadius: 5,
    alignItems: 'center',
  },
  submitButtonDisabled: {
    backgroundColor: '#6c757d',
  },
  submitButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default VoiceIncidentReporter;

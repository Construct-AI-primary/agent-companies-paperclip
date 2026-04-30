import React, { useState, useEffect } from 'react';
import { View, TouchableOpacity, StyleSheet } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { voiceService, VoiceResult, VoiceCommand } from '../services/voiceService';

interface VoiceCommandHandlerProps {
  onCommand?: (command: VoiceCommand) => void;
  onVoiceResult?: (result: VoiceResult) => void;
  style?: any;
}

export const VoiceCommandHandler: React.FC<VoiceCommandHandlerProps> = ({
  onCommand,
  onVoiceResult,
  style,
}) => {
  const [isListening, setIsListening] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  useEffect(() => {
    return () => {
      voiceService.stopListening();
    };
  }, []);

  const handleVoiceResult = async (result: VoiceResult) => {
    setIsProcessing(true);

    try {
      // Check for voice commands
      const command = voiceService.processVoiceCommand(result.text);
      if (command && onCommand) {
        onCommand(command);
      }

      // Pass result to parent
      if (onVoiceResult) {
        onVoiceResult(result);
      }
    } catch (error) {
      console.error('Error processing voice result:', error);
    } finally {
      setIsProcessing(false);
    }
  };

  const handleVoiceError = (error: string) => {
    console.error('Voice error:', error);
    setIsListening(false);
    setIsProcessing(false);
  };

  const toggleListening = async () => {
    try {
      if (isListening) {
        await voiceService.stopListening();
        setIsListening(false);
      } else {
        await voiceService.startListening(handleVoiceResult, handleVoiceError);
        setIsListening(true);
      }
    } catch (error) {
      console.error('Error toggling voice listening:', error);
      setIsListening(false);
    }
  };

  return (
    <View style={[styles.container, style]}>
      <TouchableOpacity
        testID="voice-command-container"
        accessibilityRole="button"
        style={[styles.voiceButton, isListening && styles.voiceButtonActive]}
        onPress={toggleListening}
        disabled={isProcessing}
      >
        <Ionicons
          name={isListening ? "mic-off" : "mic"}
          size={24}
          color="#fff"
        />
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  voiceButton: {
    width: 50,
    height: 50,
    borderRadius: 25,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 3,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
  },
  voiceButtonActive: {
    backgroundColor: '#FF3B30',
  },
});

export default VoiceCommandHandler;

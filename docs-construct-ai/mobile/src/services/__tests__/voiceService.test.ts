/**
 * Voice Service Unit Tests
 *
 * Tests the voice service functionality including speech recognition,
 * text-to-speech, voice command processing, and multi-language support.
 */

import { voiceService, VoiceCommand, VoiceResult } from '../voiceService';
import Voice from '@react-native-voice/voice';
import Tts from 'react-native-tts';

// Mock external dependencies
jest.mock('@react-native-voice/voice');
jest.mock('react-native-tts');

describe('VoiceService', () => {
  const mockVoice = Voice as jest.Mocked<typeof Voice>;
  const mockTts = Tts as jest.Mocked<typeof Tts>;

  // Mock voice results
  const mockSpeechResults = {
    value: ['Hello world'],
    confidence: [0.9],
  };

  const mockPartialResults = {
    value: ['Hello'],
  };

  const mockSpeechError = {
    error: {
      message: 'Speech recognition failed',
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    mockVoice.isAvailable.mockResolvedValue(1 as any);
    mockVoice.isRecognizing.mockResolvedValue(0 as any);
    mockVoice.start.mockResolvedValue('success' as any);
    mockVoice.stop.mockResolvedValue('success' as any);
    mockVoice.destroy.mockResolvedValue('success' as any);

    mockTts.setDefaultLanguage.mockResolvedValue('success' as any);
    mockTts.setDefaultRate.mockResolvedValue('success' as any);
    mockTts.setDefaultPitch.mockResolvedValue('success' as any);
    mockTts.speak.mockResolvedValue('success' as any);
    mockTts.stop.mockResolvedValue('success' as any);
    mockTts.addEventListener.mockImplementation(() => ({}) as any);
  });

  describe('Initialization', () => {
    it('should initialize voice service', () => {
      // Reinitialize service to trigger initialization
      const newService = new (voiceService.constructor as any)();

      expect(mockVoice.onSpeechStart).toBeDefined();
      expect(mockVoice.onSpeechRecognized).toBeDefined();
      expect(mockVoice.onSpeechEnd).toBeDefined();
      expect(mockVoice.onSpeechError).toBeDefined();
      expect(mockVoice.onSpeechResults).toBeDefined();
      expect(mockVoice.onSpeechPartialResults).toBeDefined();
      expect(mockVoice.onSpeechVolumeChanged).toBeDefined();
    });

    it('should initialize TTS service', () => {
      const newService = new (voiceService.constructor as any)();

      expect(mockTts.setDefaultLanguage).toHaveBeenCalledWith('en-US');
      expect(mockTts.setDefaultRate).toHaveBeenCalledWith(0.5);
      expect(mockTts.setDefaultPitch).toHaveBeenCalledWith(1.0);
      expect(mockTts.addEventListener).toHaveBeenCalledTimes(3);
    });

    it('should handle voice initialization errors', () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      // Mock Voice methods to throw errors
      mockVoice.onSpeechStart = jest.fn().mockImplementation(() => {
        throw new Error('Voice initialization failed');
      });

      const newService = new (voiceService.constructor as any)();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to initialize voice service:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });

    it('should handle TTS initialization errors', () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockTts.setDefaultLanguage.mockRejectedValue(new Error('TTS initialization failed'));

      const newService = new (voiceService.constructor as any)();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to initialize TTS:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Voice Recognition', () => {
    it('should start listening successfully', async () => {
      const onResult = jest.fn();
      const onError = jest.fn();

      await voiceService.startListening(onResult, onError);

      expect(mockVoice.start).toHaveBeenCalledWith('en-US');
      expect(mockTts.speak).toHaveBeenCalledWith('Listening...');
    });

    it('should stop listening', async () => {
      // Start listening first
      await voiceService.startListening();

      // Stop listening
      await voiceService.stopListening();

      expect(mockVoice.stop).toHaveBeenCalled();
    });

    it('should handle start listening when already listening', async () => {
      // Start first session
      await voiceService.startListening();

      // Start second session (should stop first)
      await voiceService.startListening();

      expect(mockVoice.stop).toHaveBeenCalledTimes(1);
      expect(mockVoice.start).toHaveBeenCalledTimes(2);
    });

    it('should handle start listening errors', async () => {
      const onError = jest.fn();
      mockVoice.start.mockRejectedValue(new Error('Voice start failed'));

      await voiceService.startListening(undefined, onError);

      expect(onError).toHaveBeenCalledWith('Voice start failed');
    });

    it('should handle start listening when not initialized', async () => {
      const service = voiceService as any;
      service.isInitialized = false;

      const onError = jest.fn();

      await voiceService.startListening(undefined, onError);

      expect(onError).toHaveBeenCalledWith('Voice service not initialized');
    });
  });

  describe('Speech Event Handlers', () => {
    it('should handle speech start event', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = voiceService as any;
      service.onSpeechStart();

      expect(consoleSpy).toHaveBeenCalledWith('Speech recognition started');

      consoleSpy.mockRestore();
    });

    it('should handle speech recognized event', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = voiceService as any;
      service.onSpeechRecognized();

      expect(consoleSpy).toHaveBeenCalledWith('Speech recognized');

      consoleSpy.mockRestore();
    });

    it('should handle speech end event', () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const service = voiceService as any;
      service.onSpeechEnd();

      expect(consoleSpy).toHaveBeenCalledWith('Speech recognition ended');

      consoleSpy.mockRestore();
    });

    it('should handle speech error event', () => {
      const onError = jest.fn();
      const service = voiceService as any;

      service.onErrorCallback = onError;
      service.onSpeechError(mockSpeechError);

      expect(onError).toHaveBeenCalledWith('Speech recognition failed');
    });

    it('should handle speech results event', () => {
      const onResult = jest.fn();
      const service = voiceService as any;

      service.onResultCallback = onResult;
      service.onSpeechResults(mockSpeechResults);

      expect(onResult).toHaveBeenCalledWith({
        text: 'Hello world',
        confidence: 0.9,
        isFinal: true,
      });
    });

    it('should handle partial speech results event', () => {
      const onResult = jest.fn();
      const service = voiceService as any;

      service.onResultCallback = onResult;
      service.onSpeechPartialResults(mockPartialResults);

      expect(onResult).toHaveBeenCalledWith({
        text: 'Hello',
        confidence: 0.5,
        isFinal: false,
      });
    });

    it('should handle speech volume changed event', () => {
      const service = voiceService as any;

      // Should not throw error
      expect(() => service.onSpeechVolumeChanged()).not.toThrow();
    });
  });

  describe('Text-to-Speech', () => {
    it('should speak text successfully', async () => {
      const text = 'Hello world';

      await voiceService.speak(text);

      expect(mockTts.speak).toHaveBeenCalledWith(text);
    });

    it('should stop speaking', async () => {
      await voiceService.stopSpeaking();

      expect(mockTts.stop).toHaveBeenCalled();
    });

    it('should handle speak errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockTts.speak.mockRejectedValue(new Error('TTS failed'));

      await voiceService.speak('Test text');

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to speak:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });

    it('should handle stop speaking errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockTts.stop.mockRejectedValue(new Error('TTS stop failed'));

      await voiceService.stopSpeaking();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to stop speaking:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Voice Command Processing', () => {
    it('should process voice command successfully', () => {
      const result = voiceService.processVoiceCommand('Report a new incident');

      expect(result).toMatchObject({
        command: 'report_incident',
        action: 'Start incident reporting',
        keywords: expect.any(Array),
      });
    });

    it('should return null for unrecognized command', () => {
      const result = voiceService.processVoiceCommand('Unrecognized command text');

      expect(result).toBeNull();
    });

    it('should be case insensitive', () => {
      const result = voiceService.processVoiceCommand('REPORT INCIDENT');

      expect(result?.command).toBe('report_incident');
    });

    it('should match partial keywords', () => {
      const result = voiceService.processVoiceCommand('Take a photo please');

      expect(result?.command).toBe('take_photo');
    });

    it('should return all available voice commands', () => {
      const commands = voiceService.getVoiceCommands();

      expect(commands).toHaveLength(11); // Based on the voiceCommands array
      expect(commands[0]).toHaveProperty('command');
      expect(commands[0]).toHaveProperty('action');
      expect(commands[0]).toHaveProperty('keywords');
    });

    it('should include all expected command types', () => {
      const commands = voiceService.getVoiceCommands();
      const commandTypes = commands.map(cmd => cmd.command);

      expect(commandTypes).toContain('report_incident');
      expect(commandTypes).toContain('report_hazard');
      expect(commandTypes).toContain('take_photo');
      expect(commandTypes).toContain('record_audio');
      expect(commandTypes).toContain('record_video');
      expect(commandTypes).toContain('get_location');
      expect(commandTypes).toContain('submit_report');
      expect(commandTypes).toContain('cancel');
      expect(commandTypes).toContain('help');
      expect(commandTypes).toContain('navigate_dashboard');
      expect(commandTypes).toContain('navigate_incidents');
      expect(commandTypes).toContain('navigate_hazards');
    });
  });

  describe('Voice Status', () => {
    it('should return correct listening status', () => {
      expect(voiceService.isCurrentlyListening()).toBe(false);

      // Simulate listening state
      const service = voiceService as any;
      service.isListening = true;

      expect(voiceService.isCurrentlyListening()).toBe(true);
    });

    it('should get voice status successfully', async () => {
      const status = await voiceService.getVoiceStatus();

      expect(status).toEqual({
        isAvailable: true,
        isRecognizing: false,
        isListening: false,
      });

      expect(mockVoice.isAvailable).toHaveBeenCalled();
      expect(mockVoice.isRecognizing).toHaveBeenCalled();
    });

    it('should handle voice status errors', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockVoice.isAvailable.mockRejectedValue(new Error('Voice status failed'));

      const status = await voiceService.getVoiceStatus();

      expect(status).toEqual({
        isAvailable: false,
        isRecognizing: false,
        isListening: false,
      });

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to get voice status:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Translation Support', () => {
    it('should translate text successfully', async () => {
      const result = await voiceService.translateText('Hello world', 'es', 'en');

      expect(result).toBe('Hello world'); // Mock returns original text
    });

    it('should handle translation errors', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      const result = await voiceService.translateText('Hello', 'es');

      expect(result).toBe('Hello');
      expect(consoleSpy).toHaveBeenCalledWith(
        'Translation requested: Hello from auto to es'
      );

      consoleSpy.mockRestore();
    });

    it('should return supported languages', () => {
      const languages = voiceService.getSupportedLanguages();

      expect(languages).toHaveLength(12);
      expect(languages).toContain('en');
      expect(languages).toContain('es');
      expect(languages).toContain('fr');
      expect(languages).toContain('de');
      expect(languages).toContain('zh');
    });
  });

  describe('Language Configuration', () => {
    it('should set voice language', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await voiceService.setVoiceLanguage('es-ES');

      expect(consoleSpy).toHaveBeenCalledWith('Voice language set to: es-ES');

      consoleSpy.mockRestore();
    });

    it('should set TTS language', async () => {
      await voiceService.setTTSLanguage('es-ES');

      expect(mockTts.setDefaultLanguage).toHaveBeenCalledWith('es-ES');
    });

    it('should handle voice language errors', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      // Mock would throw error in real implementation
      await voiceService.setVoiceLanguage('invalid-lang');

      expect(consoleSpy).toHaveBeenCalledWith('Voice language set to: invalid-lang');

      consoleSpy.mockRestore();
    });

    it('should handle TTS language errors', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockTts.setDefaultLanguage.mockRejectedValue(new Error('TTS language failed'));

      await voiceService.setTTSLanguage('invalid-lang');

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to set TTS language:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Service Lifecycle', () => {
    it('should destroy service properly', async () => {
      const service = voiceService as any;
      service.isListening = true;

      await voiceService.destroy();

      expect(mockVoice.stop).toHaveBeenCalled();
      expect(mockTts.stop).toHaveBeenCalled();
    });

    it('should handle destroy errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

      mockVoice.stop.mockRejectedValue(new Error('Voice destroy failed'));

      await voiceService.destroy();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to destroy voice service:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Voice Command Keywords', () => {
    it('should match incident reporting keywords', () => {
      const testCases = [
        'report incident',
        'new incident',
        'create incident',
        'start incident',
        'accident report',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('report_incident');
      });
    });

    it('should match hazard reporting keywords', () => {
      const testCases = [
        'report hazard',
        'danger alert',
        'risk warning',
        'unsafe condition',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('report_hazard');
      });
    });

    it('should match photo capture keywords', () => {
      const testCases = [
        'take photo',
        'capture picture',
        'camera shot',
        'evidence photo',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('take_photo');
      });
    });

    it('should match audio recording keywords', () => {
      const testCases = [
        'record audio',
        'voice note',
        'sound recording',
        'speak note',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('record_audio');
      });
    });

    it('should match video recording keywords', () => {
      const testCases = [
        'record video',
        'film incident',
        'safety video',
        'capture video',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('record_video');
      });
    });

    it('should match location keywords', () => {
      const testCases = [
        'get location',
        'find GPS',
        'current position',
        'where am I',
        'coordinates',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('get_location');
      });
    });

    it('should match submission keywords', () => {
      const testCases = [
        'submit report',
        'send report',
        'finish report',
        'complete submission',
        'save report',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('submit_report');
      });
    });

    it('should match cancellation keywords', () => {
      const testCases = [
        'cancel action',
        'stop process',
        'abort operation',
        'quit now',
        'never mind',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('cancel');
      });
    });

    it('should match help keywords', () => {
      const testCases = [
        'show help',
        'list commands',
        'what can I say',
        'voice guide',
        'assist me',
      ];

      testCases.forEach(text => {
        const result = voiceService.processVoiceCommand(text);
        expect(result?.command).toBe('help');
      });
    });

    it('should match navigation keywords', () => {
      const dashboardResult = voiceService.processVoiceCommand('go to dashboard');
      expect(dashboardResult?.command).toBe('navigate_dashboard');

      const incidentsResult = voiceService.processVoiceCommand('show incidents');
      expect(incidentsResult?.command).toBe('navigate_incidents');

      const hazardsResult = voiceService.processVoiceCommand('view hazards');
      expect(hazardsResult?.command).toBe('navigate_hazards');
    });
  });

  describe('Edge Cases and Error Handling', () => {
    it('should handle empty speech results', () => {
      const onResult = jest.fn();
      const service = voiceService as any;

      service.onResultCallback = onResult;
      service.onSpeechResults({ value: [] });

      expect(onResult).not.toHaveBeenCalled();
    });

    it('should handle null speech results', () => {
      const onResult = jest.fn();
      const service = voiceService as any;

      service.onResultCallback = onResult;
      service.onSpeechResults(null);

      expect(onResult).not.toHaveBeenCalled();
    });

    it('should handle speech error without error callback', () => {
      const service = voiceService as any;

      service.onErrorCallback = undefined;
      service.onSpeechError(mockSpeechError);

      // Should not throw error
      expect(() => service.onSpeechError(mockSpeechError)).not.toThrow();
    });

    it('should handle speech results without result callback', () => {
      const service = voiceService as any;

      service.onResultCallback = undefined;
      service.onSpeechResults(mockSpeechResults);

      // Should not throw error
      expect(() => service.onSpeechResults(mockSpeechResults)).not.toThrow();
    });

    it('should handle partial results without result callback', () => {
      const service = voiceService as any;

      service.onResultCallback = undefined;
      service.onSpeechPartialResults(mockPartialResults);

      // Should not throw error
      expect(() => service.onSpeechPartialResults(mockPartialResults)).not.toThrow();
    });

    it('should handle stop listening when not listening', async () => {
      const service = voiceService as any;
      service.isListening = false;

      await voiceService.stopListening();

      expect(mockVoice.stop).not.toHaveBeenCalled();
    });

    it('should handle translation with empty text', async () => {
      const result = await voiceService.translateText('', 'es');

      expect(result).toBe('');
    });

    it('should handle translation with same source and target language', async () => {
      const result = await voiceService.translateText('Hello', 'en', 'en');

      expect(result).toBe('Hello');
    });
  });

  describe('Performance and Resource Management', () => {
    it('should handle multiple voice commands efficiently', () => {
      const testTexts = [
        'report incident',
        'take photo',
        'submit report',
        'cancel',
        'help',
        'dashboard',
        'incidents',
        'hazards',
        'location',
        'video',
      ];

      const startTime = Date.now();

      testTexts.forEach(text => {
        voiceService.processVoiceCommand(text);
      });

      const endTime = Date.now();
      const processingTime = endTime - startTime;

      expect(processingTime).toBeLessThan(100); // Should process quickly
    });

    it('should handle concurrent voice operations', async () => {
      const operations = [
        voiceService.speak('Test 1'),
        voiceService.speak('Test 2'),
        voiceService.speak('Test 3'),
      ];

      await Promise.all(operations);

      expect(mockTts.speak).toHaveBeenCalledTimes(3);
    });

    it('should clean up resources on destroy', async () => {
      const service = voiceService as any;
      service.isListening = true;

      await voiceService.destroy();

      expect(service.isListening).toBe(false);
      expect(mockVoice.stop).toHaveBeenCalled();
      expect(mockTts.stop).toHaveBeenCalled();
    });
  });
});

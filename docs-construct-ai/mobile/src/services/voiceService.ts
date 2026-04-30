import Voice from '@react-native-voice/voice';
import Tts from 'react-native-tts';

export interface VoiceCommand {
  command: string;
  action: string;
  keywords: string[];
}

export interface VoiceResult {
  text: string;
  confidence: number;
  isFinal: boolean;
}

class VoiceService {
  private isListening: boolean = false;
  private isInitialized: boolean = false;
  private onResultCallback?: (result: VoiceResult) => void;
  private onErrorCallback?: (error: string) => void;

  // Voice commands
  private voiceCommands: VoiceCommand[] = [
    {
      command: 'report_incident',
      action: 'Start incident reporting',
      keywords: ['report', 'incident', 'new', 'create', 'start', 'accident']
    },
    {
      command: 'report_hazard',
      action: 'Start hazard reporting',
      keywords: ['hazard', 'danger', 'risk', 'unsafe', 'warning']
    },
    {
      command: 'take_photo',
      action: 'Take incident photo',
      keywords: ['photo', 'picture', 'camera', 'capture', 'image', 'evidence']
    },
    {
      command: 'record_audio',
      action: 'Record voice note',
      keywords: ['record', 'audio', 'voice', 'note', 'sound', 'speak']
    },
    {
      command: 'record_video',
      action: 'Record safety video',
      keywords: ['video', 'record', 'film', 'capture', 'safety', 'incident']
    },
    {
      command: 'get_location',
      action: 'Get current location',
      keywords: ['location', 'gps', 'where', 'position', 'coordinates', 'here']
    },
    {
      command: 'submit_report',
      action: 'Submit incident report',
      keywords: ['submit', 'send', 'finish', 'complete', 'done', 'save']
    },
    {
      command: 'cancel',
      action: 'Cancel current action',
      keywords: ['cancel', 'stop', 'abort', 'quit', 'exit', 'nevermind']
    },
    {
      command: 'help',
      action: 'Show voice commands',
      keywords: ['help', 'commands', 'what', 'how', 'guide', 'assist']
    },
    {
      command: 'navigate_dashboard',
      action: 'Go to dashboard',
      keywords: ['dashboard', 'home', 'main', 'menu']
    },
    {
      command: 'navigate_incidents',
      action: 'Go to incidents',
      keywords: ['incidents', 'reports', 'list', 'view']
    },
    {
      command: 'navigate_hazards',
      action: 'Go to hazards',
      keywords: ['hazards', 'dangers', 'risks']
    }
  ];

  constructor() {
    this.initializeVoice();
    this.initializeTTS();
  }

  private async initializeVoice() {
    try {
      // Set up voice recognition event handlers
      Voice.onSpeechStart = this.onSpeechStart.bind(this);
      Voice.onSpeechRecognized = this.onSpeechRecognized.bind(this);
      Voice.onSpeechEnd = this.onSpeechEnd.bind(this);
      Voice.onSpeechError = this.onSpeechError.bind(this);
      Voice.onSpeechResults = this.onSpeechResults.bind(this);
      Voice.onSpeechPartialResults = this.onSpeechPartialResults.bind(this);
      Voice.onSpeechVolumeChanged = this.onSpeechVolumeChanged.bind(this);

      this.isInitialized = true;
    } catch (error) {
      console.error('Failed to initialize voice service:', error);
    }
  }

  private async initializeTTS() {
    try {
      // Configure text-to-speech
      await Tts.setDefaultLanguage('en-US');
      await Tts.setDefaultRate(0.5);
      await Tts.setDefaultPitch(1.0);

      // Set up TTS event handlers
      Tts.addEventListener('tts-start', () => {
        console.log('TTS started');
      });

      Tts.addEventListener('tts-finish', () => {
        console.log('TTS finished');
      });

      Tts.addEventListener('tts-cancel', () => {
        console.log('TTS cancelled');
      });
    } catch (error) {
      console.error('Failed to initialize TTS:', error);
    }
  }

  // Voice recognition event handlers
  private onSpeechStart() {
    console.log('Speech recognition started');
  }

  private onSpeechRecognized() {
    console.log('Speech recognized');
  }

  private onSpeechEnd() {
    console.log('Speech recognition ended');
  }

  private onSpeechError(error: any) {
    console.error('Speech recognition error:', error);
    if (this.onErrorCallback) {
      this.onErrorCallback(error?.error?.message || 'Speech recognition error');
    }
  }

  private onSpeechResults(results: any) {
    if (results?.value && results.value.length > 0) {
      const text = results.value[0];
      const confidence = results.confidence?.[0] || 0.8;

      console.log('Speech results:', text, confidence);

      if (this.onResultCallback) {
        this.onResultCallback({
          text,
          confidence,
          isFinal: true
        });
      }
    }
  }

  private onSpeechPartialResults(results: any) {
    if (results?.value && results.value.length > 0) {
      const text = results.value[0];

      if (this.onResultCallback) {
        this.onResultCallback({
          text,
          confidence: 0.5,
          isFinal: false
        });
      }
    }
  }

  private onSpeechVolumeChanged() {
    // Handle volume changes if needed
  }

  // Public methods
  async startListening(onResult?: (result: VoiceResult) => void, onError?: (error: string) => void) {
    try {
      if (!this.isInitialized) {
        throw new Error('Voice service not initialized');
      }

      if (this.isListening) {
        await this.stopListening();
      }

      this.onResultCallback = onResult;
      this.onErrorCallback = onError;

      await Voice.start('en-US');
      this.isListening = true;

      // Provide audio feedback
      await this.speak('Listening...');

    } catch (error) {
      console.error('Failed to start listening:', error);
      if (onError) {
        onError(error instanceof Error ? error.message : 'Failed to start listening');
      }
    }
  }

  async stopListening() {
    try {
      if (this.isListening) {
        await Voice.stop();
        this.isListening = false;
      }
    } catch (error) {
      console.error('Failed to stop listening:', error);
    }
  }

  async speak(text: string) {
    try {
      await Tts.speak(text);
    } catch (error) {
      console.error('Failed to speak:', error);
    }
  }

  async stopSpeaking() {
    try {
      await Tts.stop();
    } catch (error) {
      console.error('Failed to stop speaking:', error);
    }
  }

  // Voice command processing
  processVoiceCommand(text: string): VoiceCommand | null {
    const lowerText = text.toLowerCase();

    for (const command of this.voiceCommands) {
      for (const keyword of command.keywords) {
        if (lowerText.includes(keyword)) {
          return command;
        }
      }
    }

    return null;
  }

  // Get available voice commands
  getVoiceCommands(): VoiceCommand[] {
    return this.voiceCommands;
  }

  // Check if currently listening
  isCurrentlyListening(): boolean {
    return this.isListening;
  }

  // Get voice recognition status
  async getVoiceStatus() {
    try {
      const isAvailable = await Voice.isAvailable();
      const isRecognizing = await Voice.isRecognizing();

      return {
        isAvailable,
        isRecognizing,
        isListening: this.isListening
      };
    } catch (error) {
      console.error('Failed to get voice status:', error);
      return {
        isAvailable: false,
        isRecognizing: false,
        isListening: this.isListening
      };
    }
  }

  // Translation support
  async translateText(text: string, targetLanguage: string, sourceLanguage?: string): Promise<string> {
    try {
      // This would integrate with a translation service like Google Translate, Azure Translator, etc.
      // For now, we'll return the original text with a note
      console.log(`Translation requested: ${text} from ${sourceLanguage || 'auto'} to ${targetLanguage}`);

      // Placeholder for translation service integration
      // const translatedText = await translationService.translate(text, targetLanguage, sourceLanguage);

      // For demonstration, return original text
      return text;
    } catch (error) {
      console.error('Translation failed:', error);
      return text; // Return original text if translation fails
    }
  }

  // Get supported languages for translation
  getSupportedLanguages(): string[] {
    return [
      'en', // English
      'es', // Spanish
      'fr', // French
      'de', // German
      'it', // Italian
      'pt', // Portuguese
      'ru', // Russian
      'ja', // Japanese
      'ko', // Korean
      'zh', // Chinese
      'ar', // Arabic
      'hi', // Hindi
    ];
  }

  // Set voice language for speech recognition
  async setVoiceLanguage(language: string) {
    try {
      // This would change the language for voice recognition
      // await Voice.setLanguage(language);
      console.log(`Voice language set to: ${language}`);
    } catch (error) {
      console.error('Failed to set voice language:', error);
    }
  }

  // Set TTS language
  async setTTSLanguage(language: string) {
    try {
      await Tts.setDefaultLanguage(language);
      console.log(`TTS language set to: ${language}`);
    } catch (error) {
      console.error('Failed to set TTS language:', error);
    }
  }

  // Cleanup
  async destroy() {
    try {
      await this.stopListening();
      await this.stopSpeaking();

      // Note: Event listener cleanup would be handled here
    } catch (error) {
      console.error('Failed to destroy voice service:', error);
    }
  }
}

// Export singleton instance
export const voiceService = new VoiceService();
export default voiceService;

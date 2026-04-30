import React, { useState, useRef, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  KeyboardAvoidingView,
  Platform,
  Animated,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { aiService } from '../services/aiService';

interface Message {
  id: string;
  text: string;
  isUser: boolean;
  timestamp: Date;
  suggestions?: string[];
}

interface SafetyChatbotProps {
  onFormFill?: (field: string, value: string) => void;
  onNavigate?: (action: string) => void;
  context?: 'incident' | 'hazard' | 'general';
}

export const SafetyChatbot: React.FC<SafetyChatbotProps> = ({
  onFormFill,
  onNavigate,
  context = 'general',
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const [isTyping, setIsTyping] = useState(false);
  const [currentInput, setCurrentInput] = useState('');
  const [messages, setMessages] = useState<Message[]>([]);
  const scrollViewRef = useRef<ScrollView>(null);
  const slideAnim = useRef(new Animated.Value(400)).current;

  useEffect(() => {
    // Send welcome message
    sendWelcomeMessage();
  }, []);

  useEffect(() => {
    if (isOpen) {
      Animated.spring(slideAnim, {
        toValue: 0,
        useNativeDriver: true,
      }).start();

      // Scroll to bottom when opening
      setTimeout(() => {
        scrollViewRef.current?.scrollToEnd({ animated: true });
      }, 100);
    } else {
      Animated.spring(slideAnim, {
        toValue: 400,
        useNativeDriver: true,
      }).start();
    }
  }, [isOpen]);

  const sendWelcomeMessage = () => {
    const welcomeMessages = {
      incident: "Hi! I'm here to help you report the safety incident. What happened? You can describe the incident or ask me for guidance.",
      hazard: "Hello! I'm here to assist with reporting this safety hazard. Please describe the hazard or ask me about proper reporting procedures.",
      general: "Hello! I'm your Safety AI Assistant. I can help you with incident reports, safety procedures, and answer questions. How can I assist you today?"
    };

    const welcomeMessage: Message = {
      id: 'welcome',
      text: welcomeMessages[context],
      isUser: false,
      timestamp: new Date(),
      suggestions: [
        "How do I report an incident?",
        "What evidence should I collect?",
        "What are the safety procedures?",
        "Help me fill out this form"
      ]
    };

    setMessages([welcomeMessage]);
  };

  const handleSendMessage = async (text: string) => {
    if (!text.trim()) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      text,
      isUser: true,
      timestamp: new Date(),
    };

    setMessages(prev => [...prev, userMessage]);
    setCurrentInput('');
    setIsTyping(true);

    try {
      // Process the message through AI
      const response = await processMessage(text.toLowerCase());

      // Create bot response
      const botMessage: Message = {
        id: (Date.now() + 1).toString(),
        text: response.text,
        isUser: false,
        timestamp: new Date(),
        suggestions: response.suggestions,
      };

      setMessages(prev => [...prev, botMessage]);

      // Execute any actions
      if (response.action) {
        handleChatAction(response.action);
      }
    } catch (error) {
      console.error('Chatbot error:', error);
      const errorMessage: Message = {
        id: (Date.now() + 2).toString(),
        text: "I'm sorry, I couldn't process that. Please try again or ask for help.",
        isUser: false,
        timestamp: new Date(),
      };
      setMessages(prev => [...prev, errorMessage]);
    } finally {
      setIsTyping(false);
      setTimeout(() => {
        scrollViewRef.current?.scrollToEnd({ animated: true });
      }, 100);
    }
  };

  const handleSuggestionClick = (suggestion: string) => {
    setCurrentInput(suggestion);
    setTimeout(() => handleSendMessage(suggestion), 100);
  };

  const processMessage = async (text: string) => {
    // Process different types of messages
    if (text.includes('report incident') || text.includes('incident') || text.includes('happened')) {
      return await handleIncidentGuidance(text);
    } else if (text.includes('hazard') || text.includes('danger') || text.includes('unsafe')) {
      return await handleHazardGuidance(text);
    } else if (text.includes('evidence') || text.includes('photo') || text.includes('video')) {
      return await handleEvidenceGuidance(text);
    } else if (text.includes('fill') || text.includes('form') || text.includes('help')) {
      return await handleFormGuidance(text);
    } else if (text.includes('location') || text.includes('where')) {
      return await handleLocationGuidance(text);
    } else if (text.includes('submit') || text.includes('save') || text.includes('done')) {
      return await handleSubmitGuidance(text);
    } else if (text.includes('severity') || text.includes('level') || text.includes('serious')) {
      return await handleSeverityGuidance(text);
    } else if (text.includes('what should i do') || text.includes('procedure') || text.includes('protocol')) {
      return await handleProcedureGuidance(text);
    } else {
      return await handleGeneralQuestion(text);
    }
  };

  const handleIncidentGuidance = async (text: string) => {
    const responses = [
      "For incident reporting, please provide details about:",
      "• What happened",
      "• When and where it occurred",
      "• Who was involved",
      "• Any immediate actions taken",
      "• Photos or videos if available",
      "",
      "You can also ask for help with filling out any field.",
    ];

    return {
      text: responses.join('\n'),
      suggestions: ['Help me fill this form', 'What evidence to collect?', 'Submit report', 'Cancel'],
      action: text.includes('help') ? 'show-form-help' : null,
    };
  };

  const handleHazardGuidance = async (text: string) => {
    const responses = [
      "For hazard reporting, include:",
      "• Type of hazard (slip/trip, chemical, equipment, etc.)",
      "• Detailed description",
      "• Risk assessment (low/medium/high)",
      "• Mitigation recommendations",
      "• Location details",
      "",
      "Visual documentation helps with assessment.",
    ];

    return {
      text: responses.join('\n'),
      suggestions: ['Help me classify this hazard', 'What mitigation steps?', 'Take a photo', 'Submit report'],
      action: text.includes('help') ? 'show-hazard-help' : null,
    };
  };

  const handleEvidenceGuidance = async (text: string) => {
    const responses = [
      "Strong evidence includes:",
      "📸 Photos from multiple angles",
      "🎬 Videos showing the issue",
      "📍 GPS location data",
      "🔄 Before/after shots for comparison",
      "",
      "Clear, well-lit images work best for AI analysis.",
    ];

    return {
      text: responses.join('\n'),
      suggestions: ['Take photo', 'Record video', 'Get GPS location', 'Analyze photo/video'],
    };
  };

  const handleFormGuidance = async (text: string) => {
    const guidance = context === 'incident'
      ? "I can help you fill out the incident report form. Just tell me what field needs help, such as:\n• Describe incident\n• Set incident type\n• Choose severity\n• Record immediate actions"
      : "I can guide you through the hazard reporting form:\n• Hazard type selection\n• Risk assessment\n• Mitigation planning\n• Location details";

    return {
      text: guidance,
      suggestions: ['Help with description', 'Help with classification', 'Guidance on risk factors', 'Submit when ready'],
      action: 'show-form-fields',
    };
  };

  const handleLocationGuidance = async (text: string) => {
    return {
      text: "Location data helps dispatch the right response team:\n\n• Use GPS to capture exact coordinates\n• Include building/room/area description\n• Note proximity to emergency equipment\n• Enable location services for accuracy",
      suggestions: ['Get GPS location', 'Help with description', 'Emergency contacts', 'Response team'],
      action: 'request-location',
    };
  };

  const handleSubmitGuidance = async (text: string) => {
    return {
      text: "Before submitting:\n\n✅ All required fields completed\n✅ Evidence collected\n✅ Location captured\n✅ Severity assessment done\n✅ Description is clear and detailed\n\nReady to submit safely?",
      suggestions: ['Yes, submit report', 'Review form first', 'Add more evidence', 'Cancel'],
      action: 'ready-to-submit',
    };
  };

  const handleSeverityGuidance = async (text: string) => {
    return {
      text: "Severity Levels:\n\n🔴 HIGH - Immediate danger, serious injury possible\n🟡 MEDIUM - Potential for harm, needs attention\n🟢 LOW - Minor issue, schedule for follow-up\n\nConsider: injury potential, property damage, response urgency",
      suggestions: ['Set to High', 'Set to Medium', 'Set to Low', 'Help me assess'],
      action: 'show-severity-scale',
    };
  };

  const handleProcedureGuidance = async (text: string) => {
    return {
      text: "Safety reporting procedures:\n\n1. Secure the area if dangerous\n2. Ensure immediate safety of personnel\n3. Report the incident/hazard\n4. Collect evidence if safe to do so\n5. Wait for response team if needed\n\nAlways prioritize safety first, then documentation.",
      suggestions: ['Emergency procedures', 'Personal protective equipment', 'Evacuation guidelines', 'First aid procedures'],
    };
  };

  const handleGeneralQuestion = async (text: string) => {
    try {
      const aiResponse = await aiService.generateChatResponse(text);
      return {
        text: aiResponse,
        suggestions: ['Ask another question', 'Help with report', 'Emergency assistance', 'Safety guidelines'],
      };
    } catch (error) {
      return {
        text: "I'm here to help with safety reporting. I can assist with: form completion, evidence collection, procedure guidance, or answer safety-related questions.",
        suggestions: ['Help with form', 'Safety procedures', 'Evidence collection', 'Emergency contacts'],
      };
    }
  };

  const handleChatAction = (action: string) => {
    switch (action) {
      case 'request-location':
        onNavigate?.('get-location');
        break;
      case 'take-photo':
        onNavigate?.('take-photo');
        break;
      case 'record-video':
        onNavigate?.('record-video');
        break;
      case 'show-form-fields':
        onNavigate?.('show-form-help');
        break;
    }
  };

  const toggleChatbot = () => {
    setIsOpen(!isOpen);
  };

  const formatTime = (date: Date) => {
    return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  };

  const renderMessage = (message: Message) => (
    <View
      key={message.id}
      style={[
        styles.messageContainer,
        message.isUser ? styles.userMessage : styles.botMessage
      ]}
    >
      <Text style={[
        styles.messageText,
        message.isUser ? styles.userMessageText : styles.botMessageText
      ]}>
        {message.text}
      </Text>
      <Text style={styles.timestampText}>
        {formatTime(message.timestamp)}
      </Text>

      {!message.isUser && message.suggestions && (
        <View style={styles.suggestionsContainer}>
          {message.suggestions.map((suggestion, index) => (
            <TouchableOpacity
              key={index}
              style={styles.suggestionButton}
              onPress={() => handleSuggestionClick(suggestion)}
            >
              <Text style={styles.suggestionText}>{suggestion}</Text>
            </TouchableOpacity>
          ))}
        </View>
      )}
    </View>
  );

  return (
    <>
      {/* Floating Button */}
      <TouchableOpacity
        style={styles.floatingButton}
        onPress={toggleChatbot}
      >
        <Ionicons
          name={isOpen ? "close" : "chatbox-ellipses"}
          size={24}
          color="#fff"
        />
      </TouchableOpacity>

      {/* Chat Interface - Only render when open */}
      {isOpen && (
        <View style={styles.chatContainer}>
          <KeyboardAvoidingView
            behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
            style={styles.keyboardAvoid}
          >
            {/* Header */}
            <View style={styles.chatHeader}>
              <TouchableOpacity onPress={toggleChatbot}>
                <Ionicons name="close" size={24} color="#666" />
              </TouchableOpacity>
              <Text style={styles.chatTitle}>Safety AI Assistant</Text>
              <View style={{ width: 24 }} />
            </View>

            {/* Messages */}
            <ScrollView
              ref={scrollViewRef}
              style={styles.messagesContainer}
              showsVerticalScrollIndicator={false}
            >
              {messages.map(renderMessage)}

              {isTyping && (
                <View style={[styles.messageContainer, styles.botMessage]}>
                  <View style={styles.typingIndicator}>
                    <Text style={styles.typingText}>AI is thinking...</Text>
                    <View style={styles.typingDots}>
                      <View style={[styles.typingDot, styles.typingDot1]} />
                      <View style={[styles.typingDot, styles.typingDot2]} />
                      <View style={[styles.typingDot, styles.typingDot3]} />
                    </View>
                  </View>
                </View>
              )}
            </ScrollView>

            {/* Input */}
            <View style={styles.inputContainer}>
              <TextInput
                style={styles.textInput}
                placeholder="Ask me anything about safety..."
                value={currentInput}
                onChangeText={setCurrentInput}
                multiline
                maxLength={500}
              />
              <TouchableOpacity
                style={[styles.sendButton, !currentInput.trim() && styles.sendButtonDisabled]}
                onPress={() => handleSendMessage(currentInput)}
                disabled={!currentInput.trim() || isTyping}
              >
                <Ionicons
                  name="send"
                  size={20}
                  color={!currentInput.trim() ? "#ccc" : "#007AFF"}
                />
              </TouchableOpacity>
            </View>
          </KeyboardAvoidingView>
        </View>
      )}
    </>
  );
};

const styles = StyleSheet.create({
  floatingButton: {
    position: 'absolute',
    bottom: 20, // Standard bottom right position
    right: 20,
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: '#007AFF',
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 10 },
    shadowOpacity: 0.6,
    shadowRadius: 10,
  },
  chatContainer: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    height: '70%',
    backgroundColor: '#fff',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    elevation: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: -4 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    overflow: 'hidden',
  },
  keyboardAvoid: {
    flex: 1,
  },
  chatHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  chatTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
  },
  messagesContainer: {
    flex: 1,
    padding: 16,
  },
  messageContainer: {
    maxWidth: '80%',
    marginBottom: 16,
    padding: 12,
    borderRadius: 16,
  },
  userMessage: {
    alignSelf: 'flex-end',
    backgroundColor: '#007AFF',
    borderBottomRightRadius: 4,
  },
  botMessage: {
    alignSelf: 'flex-start',
    backgroundColor: '#f0f0f0',
    borderBottomLeftRadius: 4,
  },
  messageText: {
    fontSize: 14,
    lineHeight: 20,
  },
  userMessageText: {
    color: '#fff',
  },
  botMessageText: {
    color: '#333',
  },
  timestampText: {
    fontSize: 10,
    color: '#999',
    marginTop: 4,
    textAlign: 'right',
  },
  suggestionsContainer: {
    marginTop: 8,
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 4,
  },
  suggestionButton: {
    paddingVertical: 6,
    paddingHorizontal: 12,
    backgroundColor: '#e3f2fd',
    borderRadius: 16,
    marginRight: 4,
    marginBottom: 4,
  },
  suggestionText: {
    fontSize: 12,
    color: '#007AFF',
    fontWeight: '500',
  },
  typingIndicator: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
  },
  typingText: {
    fontSize: 12,
    color: '#666',
    marginRight: 8,
  },
  typingDots: {
    flexDirection: 'row',
    marginTop: 2,
  },
  typingDot: {
    width: 4,
    height: 4,
    borderRadius: 2,
    backgroundColor: '#007AFF',
    marginHorizontal: 2,
  },
  typingDot1: {
    opacity: 0.4,
  },
  typingDot2: {
    opacity: 0.7,
  },
  typingDot3: {
    opacity: 1,
  },
  inputContainer: {
    flexDirection: 'row',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
    backgroundColor: '#fff',
  },
  textInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 20,
    paddingHorizontal: 16,
    paddingVertical: 8,
    fontSize: 16,
    maxHeight: 80,
    backgroundColor: '#f8f8f8',
  },
  sendButton: {
    width: 40,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 8,
  },
  sendButtonDisabled: {
    opacity: 0.5,
  },
});

export default SafetyChatbot;

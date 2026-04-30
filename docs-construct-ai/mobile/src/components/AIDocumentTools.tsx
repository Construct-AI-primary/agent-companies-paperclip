import React, { useState } from 'react';
import { View, Text, TouchableOpacity, ScrollView, StyleSheet, Alert, TextInput } from 'react-native';
import { aiService } from '../services/aiService';

interface AIDocumentToolsProps {
  onClose?: () => void;
}

const AIDocumentTools: React.FC<AIDocumentToolsProps> = ({ onClose }) => {
  const [activeTool, setActiveTool] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const tools = [
    {
      id: 'translator',
      title: 'Document Translator',
      description: 'Translate documents to multiple languages',
      icon: '🌍'
    },
    {
      id: 'comparator',
      title: 'Version Comparator',
      description: 'Compare document versions and track changes',
      icon: '📊'
    },
    {
      id: 'compliance',
      title: 'Compliance Checker',
      description: 'Check regulatory compliance automatically',
      icon: '✅'
    },
    {
      id: 'summarizer',
      title: 'Smart Summarizer',
      description: 'Generate AI-powered document summaries',
      icon: '📝'
    }
  ];

  const handleToolSelect = (toolId: string) => {
    setActiveTool(toolId);
  };

  const handleBack = () => {
    setActiveTool(null);
  };

  if (activeTool) {
    return <ToolInterface toolId={activeTool} onBack={handleBack} />;
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>AI Document Tools</Text>
        <Text style={styles.subtitle}>Advanced AI-powered document processing</Text>
      </View>

      <ScrollView style={styles.toolsGrid}>
        {tools.map((tool) => (
          <TouchableOpacity
            key={tool.id}
            style={styles.toolCard}
            onPress={() => handleToolSelect(tool.id)}
            accessibilityRole="button"
            accessibilityLabel={`${tool.title} tool`}
          >
            <Text style={styles.toolIcon}>{tool.icon}</Text>
            <Text style={styles.toolTitle}>{tool.title}</Text>
            <Text style={styles.toolDescription}>{tool.description}</Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {onClose && (
        <TouchableOpacity style={styles.closeButton} onPress={onClose}>
          <Text style={styles.closeButtonText}>Close</Text>
        </TouchableOpacity>
      )}
    </View>
  );
};

interface ToolInterfaceProps {
  toolId: string;
  onBack: () => void;
}

const ToolInterface: React.FC<ToolInterfaceProps> = ({ toolId, onBack }) => {
  const [input, setInput] = useState('');
  const [result, setResult] = useState<any>(null);
  const [loading, setLoading] = useState(false);

  const handleProcess = async () => {
    if (!input.trim()) {
      Alert.alert('Error', 'Please enter some content to process');
      return;
    }

    setLoading(true);
    try {
      let result;
      switch (toolId) {
        case 'translator':
          result = await aiService.translateDocument(input, 'es'); // Default to Spanish
          break;
        case 'comparator':
          // For demo, compare with a modified version
          const modified = input.replace(/\bthe\b/g, 'THE');
          result = await aiService.compareDocumentVersions(input, modified);
          break;
        case 'compliance':
          result = await aiService.checkDocumentCompliance(input, ['safety', 'training']);
          break;
        case 'summarizer':
          result = await aiService.summarizeDocument(input);
          break;
        default:
          throw new Error('Unknown tool');
      }
      setResult(result);
    } catch (error) {
      Alert.alert('Error', 'Failed to process document');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  const getToolTitle = () => {
    switch (toolId) {
      case 'translator': return 'Document Translator';
      case 'comparator': return 'Version Comparator';
      case 'compliance': return 'Compliance Checker';
      case 'summarizer': return 'Smart Summarizer';
      default: return 'AI Tool';
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity onPress={onBack} style={styles.backButton}>
          <Text style={styles.backButtonText}>← Back</Text>
        </TouchableOpacity>
        <Text style={styles.title}>{getToolTitle()}</Text>
      </View>

      <ScrollView style={styles.content}>
        <Text style={styles.inputLabel}>Document Content:</Text>
        <View style={styles.textInputContainer}>
          <TextInput
            style={styles.textInput}
            multiline
            placeholder="Enter your document content here..."
            value={input}
            onChangeText={setInput}
            textAlignVertical="top"
          />
        </View>

        <TouchableOpacity
          style={[styles.processButton, loading && styles.disabledButton]}
          onPress={handleProcess}
          disabled={loading}
        >
          <Text style={styles.processButtonText}>
            {loading ? 'Processing...' : 'Process Document'}
          </Text>
        </TouchableOpacity>

        {result && (
          <View style={styles.resultContainer}>
            <Text style={styles.resultTitle}>Results:</Text>
            <ScrollView style={styles.resultContent}>
              <Text style={styles.resultText}>
                {JSON.stringify(result, null, 2)}
              </Text>
            </ScrollView>
          </View>
        )}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#fff',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginTop: 5,
  },
  backButton: {
    position: 'absolute',
    left: 20,
    top: 20,
    zIndex: 1,
  },
  backButtonText: {
    fontSize: 16,
    color: '#007AFF',
  },
  toolsGrid: {
    flex: 1,
    padding: 20,
  },
  toolCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    marginBottom: 15,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  toolIcon: {
    fontSize: 32,
    textAlign: 'center',
    marginBottom: 10,
  },
  toolTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
    marginBottom: 5,
  },
  toolDescription: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    lineHeight: 20,
  },
  closeButton: {
    backgroundColor: '#007AFF',
    margin: 20,
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
  },
  closeButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
    padding: 20,
  },
  inputLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
  },
  textInputContainer: {
    backgroundColor: '#fff',
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    marginBottom: 20,
  },
  textInput: {
    minHeight: 150,
    padding: 15,
    fontSize: 16,
    color: '#333',
  },
  processButton: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    marginBottom: 20,
  },
  disabledButton: {
    backgroundColor: '#ccc',
  },
  processButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  resultContainer: {
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 15,
    borderWidth: 1,
    borderColor: '#e0e0e0',
  },
  resultTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
  },
  resultContent: {
    maxHeight: 300,
  },
  resultText: {
    fontSize: 12,
    color: '#333',
    fontFamily: 'monospace',
  },
});

export default AIDocumentTools;

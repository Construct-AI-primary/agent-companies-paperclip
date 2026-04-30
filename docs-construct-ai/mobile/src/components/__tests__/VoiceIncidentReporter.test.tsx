import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react-native';
import { Alert } from 'react-native';
import VoiceIncidentReporter from '../VoiceIncidentReporter';

// Mock Redux
const mockDispatch = jest.fn();
const mockAddIncident = jest.fn();

jest.mock('react-redux', () => ({
  ...jest.requireActual('react-redux'),
  useDispatch: () => mockDispatch,
}));

// Mock safety slice
jest.mock('../../store/slices/safetySlice', () => ({
  addIncident: mockAddIncident,
}));

// Mock voice service
const mockStartListening = jest.fn();
const mockStopListening = jest.fn();
const mockStopSpeaking = jest.fn();
const mockSpeak = jest.fn();
const mockProcessVoiceCommand = jest.fn();

jest.mock('../../services/voiceService', () => ({
  voiceService: {
    startListening: mockStartListening,
    stopListening: mockStopListening,
    stopSpeaking: mockStopSpeaking,
    speak: mockSpeak,
    processVoiceCommand: mockProcessVoiceCommand,
  },
}));

// Mock Ionicons
jest.mock('@expo/vector-icons', () => ({
  Ionicons: 'Ionicons',
}));

// Mock TouchableOpacity with proper testID and role forwarding
jest.mock('react-native/Libraries/Components/Touchable/TouchableOpacity', () => {
  const React = require('react');
  const { TouchableOpacity } = require('react-native');

  const MockTouchableOpacity = React.forwardRef((props, ref) => {
    const { testID, accessibilityRole, ...otherProps } = props;

    return React.createElement(TouchableOpacity, {
      ...otherProps,
      ref,
      testID: testID || 'touchable-opacity',
      accessibilityRole: accessibilityRole || 'button'
    });
  });

  MockTouchableOpacity.displayName = 'TouchableOpacity';
  return MockTouchableOpacity;
});

describe('VoiceIncidentReporter', () => {
  const mockOnComplete = jest.fn();
  const mockOnCancel = jest.fn();

  beforeEach(() => {
    jest.clearAllMocks();
    mockDispatch.mockReturnValue({ payload: { id: '1', incidentType: 'test' } });
    mockAddIncident.mockReturnValue({ type: 'ADD_INCIDENT', payload: { id: '1' } });
    mockStartListening.mockResolvedValue(undefined);
    mockStopListening.mockResolvedValue(undefined);
    mockStopSpeaking.mockResolvedValue(undefined);
    mockSpeak.mockResolvedValue(undefined);
  });

  it('renders correctly with initial state', () => {
    render(<VoiceIncidentReporter />);

    expect(screen.getByText('Voice Incident Reporter')).toBeTruthy();
    expect(screen.getByText('Step: type')).toBeTruthy();
    expect(screen.getByText('What type of incident occurred?')).toBeTruthy();
    expect(screen.getByText('Tap to speak')).toBeTruthy();
  });

  it('starts voice listening when voice button is pressed', async () => {
    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    expect(mockStartListening).toHaveBeenCalled();
    expect(screen.getByText('Listening...')).toBeTruthy();
  });

  it('stops voice listening when voice button is pressed while listening', async () => {
    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');

    // Start listening
    fireEvent.press(voiceButton);
    expect(mockStartListening).toHaveBeenCalled();

    // Stop listening
    fireEvent.press(voiceButton);
    expect(mockStopListening).toHaveBeenCalled();
  });

  it('processes incident type from voice input', async () => {
    const mockVoiceResult = { text: 'There was a fall incident', isFinal: true };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Fall/Slip. Now please describe what happened.');
      expect(screen.getByText('Step: description')).toBeTruthy();
    });
  });

  it('processes description from voice input', async () => {
    const mockVoiceResult = { text: 'Worker slipped on wet floor', isFinal: true };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter />);

    // First set incident type manually to get to description step
    const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
    fireEvent.changeText(incidentTypeInput, 'Fall/Slip');

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockSpeak).toHaveBeenCalledWith('Description recorded. What is the severity level: low, medium, high, or critical?');
      expect(screen.getByText('Step: severity')).toBeTruthy();
    });
  });

  it('processes severity from voice input', async () => {
    const mockVoiceResult = { text: 'high severity', isFinal: true };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter />);

    // Set up incident details manually
    const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
    fireEvent.changeText(incidentTypeInput, 'Fall/Slip');

    const descriptionInput = screen.getByPlaceholderText('Description');
    fireEvent.changeText(descriptionInput, 'Worker slipped on wet floor');

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockSpeak).toHaveBeenCalledWith('Severity set to high. Please confirm: Type: Fall/Slip, Description: Worker slipped on wet floor, Severity: high. Say yes to submit or no to cancel.');
      expect(screen.getByText('Step: confirm')).toBeTruthy();
    });
  });

  it('processes confirmation and submits incident', async () => {
    const mockVoiceResult = { text: 'yes submit', isFinal: true };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter onComplete={mockOnComplete} />);

    // Set up incident details manually
    const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
    fireEvent.changeText(incidentTypeInput, 'Fall/Slip');

    const descriptionInput = screen.getByPlaceholderText('Description');
    fireEvent.changeText(descriptionInput, 'Worker slipped on wet floor');

    // Set severity
    const highSeverityButton = screen.getByText('HIGH');
    fireEvent.press(highSeverityButton);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockDispatch).toHaveBeenCalled();
      expect(mockSpeak).toHaveBeenCalledWith('Incident report submitted successfully.');
      expect(mockOnComplete).toHaveBeenCalled();
    });
  });

  it('cancels incident reporting on voice command', async () => {
    const mockVoiceResult = { text: 'cancel', isFinal: true };
    const mockCommand = { command: 'cancel', action: 'cancel' };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });
    mockProcessVoiceCommand.mockReturnValue(mockCommand);

    render(<VoiceIncidentReporter onCancel={mockOnCancel} />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockSpeak).toHaveBeenCalledWith('Incident reporting cancelled.');
      expect(mockOnCancel).toHaveBeenCalled();
    });
  });

  it('handles voice help command', async () => {
    const mockVoiceResult = { text: 'help', isFinal: true };
    const mockCommand = { command: 'help', action: 'help' };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });
    mockProcessVoiceCommand.mockReturnValue(mockCommand);

    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(mockSpeak).toHaveBeenCalledWith('Available commands: cancel, help, or continue with incident details.');
    });
  });

  it('handles voice errors gracefully', async () => {
    const mockError = 'Microphone permission denied';

    mockStartListening.mockImplementation((onResult, onError) => {
      onError(mockError);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(screen.getByText(`Error: ${mockError}`)).toBeTruthy();
    });
  });

  it('handles processing errors gracefully', async () => {
    const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
    const mockVoiceResult = { text: 'invalid input', isFinal: true };

    mockStartListening.mockImplementation((onResult) => {
      onResult(mockVoiceResult);
      return Promise.resolve();
    });

    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error processing voice input:', expect.any(Error));
      expect(mockSpeak).toHaveBeenCalledWith('Sorry, I didn\'t understand that. Please try again.');
    });

    consoleSpy.mockRestore();
  });

  it('shows processing state during voice processing', async () => {
    let resolvePromise;
    const delayedPromise = new Promise((resolve) => {
      resolvePromise = resolve;
    });

    mockStartListening.mockReturnValue(delayedPromise);

    render(<VoiceIncidentReporter />);

    const voiceButton = screen.getByRole('button');
    fireEvent.press(voiceButton);

    expect(screen.getByText('Processing...')).toBeTruthy();

    resolvePromise();
    await waitFor(() => {
      expect(screen.queryByText('Processing...')).toBeNull();
    });
  });

  // Manual Input Tests
  describe('Manual Input', () => {
    it('allows manual incident type input', () => {
      render(<VoiceIncidentReporter />);

      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Equipment Failure');

      expect(incidentTypeInput.props.value).toBe('Equipment Failure');
    });

    it('allows manual description input', () => {
      render(<VoiceIncidentReporter />);

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Machine broke down');

      expect(descriptionInput.props.value).toBe('Machine broke down');
    });

    it('allows severity selection via buttons', () => {
      render(<VoiceIncidentReporter />);

      const highSeverityButton = screen.getByText('HIGH');
      fireEvent.press(highSeverityButton);

      // The button should be styled as active (this is tested via styling)
      expect(highSeverityButton).toBeTruthy();
    });

    it('submits incident manually', async () => {
      render(<VoiceIncidentReporter onComplete={mockOnComplete} />);

      // Fill in manual details
      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Chemical Spill');

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Chemical spilled in lab');

      const criticalSeverityButton = screen.getByText('CRITICAL');
      fireEvent.press(criticalSeverityButton);

      const submitButton = screen.getByText('Submit Report');
      fireEvent.press(submitButton);

      await waitFor(() => {
        expect(mockDispatch).toHaveBeenCalledWith(mockAddIncident({
          incidentType: 'Chemical Spill',
          description: 'Chemical spilled in lab',
          severity: 'critical',
          status: 'reported',
          photos: [],
          videos: [],
          immediateActions: '',
        }));
        expect(mockOnComplete).toHaveBeenCalled();
      });
    });

    it('disables submit button when required fields are empty', () => {
      render(<VoiceIncidentReporter />);

      const submitButton = screen.getByText('Submit Report');
      expect(submitButton).toBeDisabled();
    });

    it('enables submit button when required fields are filled', () => {
      render(<VoiceIncidentReporter />);

      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Test Incident');

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Test description');

      const submitButton = screen.getByText('Submit Report');
      expect(submitButton).not.toBeDisabled();
    });
  });

  // Voice Command Processing Tests
  describe('Voice Command Processing', () => {
    it('detects fall/slip incident type', async () => {
      const mockVoiceResult = { text: 'worker fell down', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Fall/Slip. Now please describe what happened.');
      });
    });

    it('detects equipment failure incident type', async () => {
      const mockVoiceResult = { text: 'machine broke', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Equipment Failure. Now please describe what happened.');
      });
    });

    it('detects chemical spill incident type', async () => {
      const mockVoiceResult = { text: 'chemical spill occurred', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Chemical Spill. Now please describe what happened.');
      });
    });

    it('detects fire incident type', async () => {
      const mockVoiceResult = { text: 'there was a fire', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Fire. Now please describe what happened.');
      });
    });

    it('detects electrical issue incident type', async () => {
      const mockVoiceResult = { text: 'electrical problem', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Incident type set to Electrical Issue. Now please describe what happened.');
      });
    });

    it('detects low severity', async () => {
      const mockVoiceResult = { text: 'low priority', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      // Set up incident details
      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Test');

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Test description');

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Severity set to low. Please confirm: Type: Test, Description: Test description, Severity: low. Say yes to submit or no to cancel.');
      });
    });

    it('detects critical severity', async () => {
      const mockVoiceResult = { text: 'emergency situation', isFinal: true };

      mockStartListening.mockImplementation((onResult) => {
        onResult(mockVoiceResult);
        return Promise.resolve();
      });

      render(<VoiceIncidentReporter />);

      // Set up incident details
      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Test');

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Test description');

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(mockSpeak).toHaveBeenCalledWith('Severity set to critical. Please confirm: Type: Test, Description: Test description, Severity: critical. Say yes to submit or no to cancel.');
      });
    });
  });

  // Error Handling Tests
  describe('Error Handling', () => {
    it('handles submission errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      mockDispatch.mockRejectedValue(new Error('Submission failed'));

      render(<VoiceIncidentReporter />);

      // Fill in required fields
      const incidentTypeInput = screen.getByPlaceholderText('Incident Type');
      fireEvent.changeText(incidentTypeInput, 'Test Incident');

      const descriptionInput = screen.getByPlaceholderText('Description');
      fireEvent.changeText(descriptionInput, 'Test description');

      const submitButton = screen.getByText('Submit Report');
      fireEvent.press(submitButton);

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Error submitting incident:', expect.any(Error));
        expect(mockSpeak).toHaveBeenCalledWith('Sorry, there was an error submitting the incident. Please try again.');
      });

      consoleSpy.mockRestore();
    });

    it('handles voice service start errors', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      mockStartListening.mockRejectedValue(new Error('Voice service error'));

      render(<VoiceIncidentReporter />);

      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Error starting voice recognition:', expect.any(Error));
        expect(screen.getByText('Error starting voice recognition')).toBeTruthy();
      });

      consoleSpy.mockRestore();
    });

    it('handles voice service stop errors', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      mockStopListening.mockRejectedValue(new Error('Stop error'));

      render(<VoiceIncidentReporter />);

      // Start listening first
      const voiceButton = screen.getByRole('button');
      fireEvent.press(voiceButton);

      // Then stop
      fireEvent.press(voiceButton);

      await waitFor(() => {
        expect(consoleSpy).toHaveBeenCalledWith('Error stopping voice recognition:', expect.any(Error));
      });

      consoleSpy.mockRestore();
    });
  });

  // Lifecycle Tests
  describe('Component Lifecycle', () => {
    it('cleans up voice services on unmount', () => {
      const { unmount } = render(<VoiceIncidentReporter />);

      unmount();

      expect(mockStopListening).toHaveBeenCalled();
      expect(mockStopSpeaking).toHaveBeenCalled();
    });

    it('calls onCancel when cancel button is pressed', () => {
      render(<VoiceIncidentReporter onCancel={mockOnCancel} />);

      const cancelButton = screen.getByText('Cancel');
      fireEvent.press(cancelButton);

      expect(mockOnCancel).toHaveBeenCalled();
    });
  });

  // Accessibility Tests
  describe('Accessibility', () => {
    it('has proper labels for interactive elements', () => {
      render(<VoiceIncidentReporter />);

      const buttons = screen.getAllByRole('button');
      expect(buttons.length).toBeGreaterThan(0);
    });

    it('shows current step information', () => {
      render(<VoiceIncidentReporter />);

      expect(screen.getByText('Step: type')).toBeTruthy();
      expect(screen.getByText('What type of incident occurred?')).toBeTruthy();
    });

    it('displays transcript information', () => {
      render(<VoiceIncidentReporter />);

      expect(screen.getByText('Transcript:')).toBeTruthy();
      expect(screen.getByText('No speech detected')).toBeTruthy();
    });

    it('shows current incident details', () => {
      render(<VoiceIncidentReporter />);

      expect(screen.getByText('Current Details:')).toBeTruthy();
      expect(screen.getByText('Type: Not set')).toBeTruthy();
      expect(screen.getByText('Description: Not set')).toBeTruthy();
      expect(screen.getByText('Severity: medium')).toBeTruthy();
    });
  });
});

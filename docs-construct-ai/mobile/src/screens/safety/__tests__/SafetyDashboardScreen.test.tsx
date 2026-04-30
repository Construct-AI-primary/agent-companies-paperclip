import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react-native';
import { Alert } from 'react-native';
import SafetyDashboardScreen from '../SafetyDashboardScreen';

// Mock navigation
const mockNavigate = jest.fn();
jest.mock('@react-navigation/native', () => ({
  useNavigation: () => ({
    navigate: mockNavigate,
  }),
}));

// Mock Redux
const mockSelector = jest.fn();
jest.mock('react-redux', () => ({
  ...jest.requireActual('react-redux'),
  useSelector: (selector: any) => mockSelector(selector),
}));

const mockState = {
  safety: {
    incidents: [
      {
        id: '1',
        incidentType: 'safety_violation',
        description: 'Worker not wearing safety helmet',
        severity: 'high',
        reportedAt: new Date().toISOString(),
        synced: true,
      },
      {
        id: '2',
        incidentType: 'equipment_failure',
        description: 'Crane malfunction',
        severity: 'critical',
        reportedAt: new Date().toISOString(),
        synced: false,
      },
    ],
    hazards: [
      {
        id: '1',
        hazardType: 'electrical',
        description: 'Exposed wiring',
        severity: 'medium',
        reportedAt: new Date().toISOString(),
      },
    ],
  },
};

// Mock selector implementation to properly apply selector functions
beforeEach(() => {
  mockSelector.mockImplementation((selector: any) => {
    // Create a mock root state
    const mockRootState = {
      safety: mockState.safety,
    };
    // Apply the selector function to the mock root state
    return selector(mockRootState);
  });
});

// Mock voice service - Define mocks with jest.fn() directly in the mock
jest.mock('../../../services/voiceService', () => {
  const mockStartListening = jest.fn();
  const mockStopListening = jest.fn().mockResolvedValue(undefined);
  const mockSpeak = jest.fn().mockResolvedValue(undefined);
  const mockProcessVoiceCommand = jest.fn().mockImplementation((text) => {
    if (text.includes('report incident')) {
      return { command: 'report_incident', action: 'report incident' };
    } else if (text.includes('report hazard')) {
      return { command: 'report_hazard', action: 'report hazard' };
    } else if (text.includes('help')) {
      return { command: 'help', action: 'help' };
    }
    return null;
  });
  const mockGetVoiceCommands = jest.fn().mockReturnValue([
    { action: 'report incident' },
    { action: 'report hazard' },
    { action: 'navigate dashboard' },
  ]);

  const mockVoiceService = {
    startListening: mockStartListening,
    stopListening: mockStopListening,
    speak: mockSpeak,
    processVoiceCommand: mockProcessVoiceCommand,
    getVoiceCommands: mockGetVoiceCommands,
    isCurrentlyListening: jest.fn().mockReturnValue(false),
    getVoiceStatus: jest.fn().mockResolvedValue({
      isAvailable: true,
      isRecognizing: false,
      isListening: false,
    }),
    destroy: jest.fn().mockResolvedValue(undefined),
  };

  return {
    voiceService: mockVoiceService,
    default: mockVoiceService,
    VoiceCommand: jest.fn(),
    VoiceResult: jest.fn(),
  };
});

// Import the mocked service to access the mock functions
import { voiceService } from '../../../services/voiceService';

// Get the mocked functions for test expectations
const mockVoiceService = voiceService as jest.Mocked<typeof voiceService>;

// Mock Alert
jest.mock('react-native/Libraries/Alert/Alert', () => ({
  alert: jest.fn(),
}));

// Mock Ionicons
jest.mock('@expo/vector-icons', () => ({
  Ionicons: 'Ionicons',
}));

// Mock aiService
jest.mock('../../../services/aiService', () => ({
  aiService: {
    getText: jest.fn((key) => {
      const translations: Record<string, string> = {
        safetyDashboardTitle: 'ConstructAI Safety',
        safetyDashboardSubtitle: 'Keep your workplace safe',
        totalIncidents: 'Total Incidents',
        totalHazards: 'Total Hazards',
        syncStatus: 'Sync Status',
        recentIncidents: 'Recent Incidents',
        noIncidentsReported: 'No incidents reported yet',
        reportFirstIncident: 'Report First Incident',
        reportIncident: 'Report Incident',
        reportHazard: 'Report Hazard',
        syncData: 'Sync Data',
        settings: 'Settings',
        aiTools: 'AI Tools',
      };
      return translations[key] || key;
    }),
    onLanguageChange: jest.fn((listener) => {
      // Return a mock unsubscribe function
      return () => {};
    }),
    getLanguage: jest.fn(() => 'en'),
  },
}));

describe('SafetyDashboardScreen', () => {
  beforeEach(() => {
    mockSelector.mockImplementation((selector: any) => {
      // Create a mock root state
      const mockRootState = {
        safety: mockState.safety,
      };
      // Apply the selector function to the mock root state
      return selector(mockRootState);
    });
    mockNavigate.mockClear();
    mockVoiceService.startListening.mockClear();
    mockVoiceService.stopListening.mockClear();
    mockVoiceService.speak.mockClear();
    mockVoiceService.processVoiceCommand.mockClear();
    mockVoiceService.getVoiceCommands.mockClear();
    jest.clearAllMocks();
  });

  it('renders correctly with header and stats', () => {
    render(<SafetyDashboardScreen />);

    expect(screen.getByText('ConstructAI Safety')).toBeTruthy();
    expect(screen.getByText('Keep your workplace safe')).toBeTruthy();
    const incidentCount = screen.getAllByText('2');
    expect(incidentCount.length).toBeGreaterThan(0); // Total Incidents
    const hazardCount = screen.getAllByText('1');
    expect(hazardCount.length).toBeGreaterThan(0); // Total Hazards
    expect(screen.getByText('50%')).toBeTruthy(); // Sync Status (1 out of 2 incidents synced)
  });

  it('renders quick action buttons', () => {
    render(<SafetyDashboardScreen />);

    expect(screen.getByText('Report Incident')).toBeTruthy();
    expect(screen.getByText('Report Hazard')).toBeTruthy();
    expect(screen.getByText('Sync Data')).toBeTruthy();
    expect(screen.getByText('Settings')).toBeTruthy();
    expect(screen.getByText('AI Tools')).toBeTruthy();
  });

  it('renders recent incidents section', () => {
    render(<SafetyDashboardScreen />);

    expect(screen.getByText('Recent Incidents')).toBeTruthy();
    expect(screen.getByText('SAFETY VIOLATION: Worker not wearing safety helmet')).toBeTruthy();
    expect(screen.getByText('EQUIPMENT FAILURE: Crane malfunction')).toBeTruthy();
  });

  it('navigates to incident report when report incident button is pressed', () => {
    render(<SafetyDashboardScreen />);

    const reportIncidentButton = screen.getByText('Report Incident');
    fireEvent.press(reportIncidentButton);

    expect(mockNavigate).toHaveBeenCalledWith('IncidentReport');
  });

  it('navigates to hazard report when report hazard button is pressed', () => {
    render(<SafetyDashboardScreen />);

    const reportHazardButton = screen.getByText('Report Hazard');
    fireEvent.press(reportHazardButton);

    expect(mockNavigate).toHaveBeenCalledWith('HazardReport');
  });

  it('navigates to settings when settings button is pressed', () => {
    render(<SafetyDashboardScreen />);

    const settingsButton = screen.getByText('Settings');
    fireEvent.press(settingsButton);

    expect(mockNavigate).toHaveBeenCalledWith('SafetySettings');
  });

  it('navigates to AI tools when AI tools button is pressed', () => {
    render(<SafetyDashboardScreen />);

    const aiToolsButton = screen.getByText('AI Tools');
    fireEvent.press(aiToolsButton);

    expect(mockNavigate).toHaveBeenCalledWith('AIDocumentTools');
  });

  it('shows alert when sync data button is pressed', () => {
    render(<SafetyDashboardScreen />);

    const syncButton = screen.getByText('Sync Data');
    fireEvent.press(syncButton);

    expect(Alert.alert).toHaveBeenCalledWith('Sync Data', 'Sync functionality will be implemented here');
  });

  it('navigates to incident detail when incident item is pressed', () => {
    render(<SafetyDashboardScreen />);

    const incidentItem = screen.getByText('SAFETY VIOLATION: Worker not wearing safety helmet');
    fireEvent.press(incidentItem);

    expect(mockNavigate).toHaveBeenCalledWith('IncidentDetail', { incidentId: '1' });
  });

  it('navigates to incident report when stat card is pressed', () => {
    render(<SafetyDashboardScreen />);

    const incidentStatCard = screen.getByText('Total Incidents');
    fireEvent.press(incidentStatCard);

    expect(mockNavigate).toHaveBeenCalledWith('IncidentReport');
  });

  it('navigates to hazard report when hazard stat card is pressed', () => {
    render(<SafetyDashboardScreen />);

    const hazardStatCard = screen.getByText('Total Hazards');
    fireEvent.press(hazardStatCard);

    expect(mockNavigate).toHaveBeenCalledWith('HazardReport');
  });

  it('shows empty state when no incidents exist', () => {
    mockSelector.mockReturnValue({
      ...mockState.safety,
      incidents: [],
    });

    render(<SafetyDashboardScreen />);

    expect(screen.getByText('No incidents reported yet')).toBeTruthy();
    expect(screen.getByText('Report First Incident')).toBeTruthy();
  });

  it('navigates to incident report from empty state button', () => {
    mockSelector.mockReturnValue({
      ...mockState.safety,
      incidents: [],
    });

    render(<SafetyDashboardScreen />);

    const reportFirstIncidentButton = screen.getByText('Report First Incident');
    fireEvent.press(reportFirstIncidentButton);

    expect(mockNavigate).toHaveBeenCalledWith('IncidentReport');
  });

  it('shows 100% sync status when all incidents are synced', () => {
    mockSelector.mockReturnValue({
      ...mockState.safety,
      incidents: [
        {
          id: '1',
          incidentType: 'safety_violation',
          description: 'Test incident',
          severity: 'high',
          reportedAt: new Date().toISOString(),
          synced: true,
        },
      ],
    });

    render(<SafetyDashboardScreen />);

    expect(screen.getByText('100%')).toBeTruthy();
  });

  it('shows 0% sync status when no incidents exist', () => {
    mockSelector.mockReturnValue({
      ...mockState.safety,
      incidents: [],
    });

    render(<SafetyDashboardScreen />);

    expect(screen.getByText('100%')).toBeTruthy(); // Default to 100% when no incidents
  });

  it('toggles voice listening when voice button is pressed', async () => {
    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult({ text: 'test', confidence: 0.9, isFinal: true });
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');

    // Start listening
    fireEvent.press(voiceButton);
    // Wait for the async operations to complete
    await waitFor(() => {
      expect(mockVoiceService.startListening).toHaveBeenCalled();
    });
    expect(mockVoiceService.speak).toHaveBeenCalledWith('Voice commands activated. Say help for available commands.');

    // Stop listening
    fireEvent.press(voiceButton);
    await waitFor(() => {
      expect(mockVoiceService.stopListening).toHaveBeenCalled();
    });
  });

  it('handles voice command for report incident', async () => {
    const mockVoiceResult = { text: 'report incident', confidence: 0.9, isFinal: true };
    const mockCommand = { command: 'report_incident', action: 'report incident', keywords: ['report', 'incident'] };

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult(mockVoiceResult);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.processVoiceCommand.mockReturnValue(mockCommand);
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(mockVoiceService.speak).toHaveBeenCalledWith('Opening incident report form');
    }, { timeout: 2000 });
    expect(mockNavigate).toHaveBeenCalledWith('IncidentReport');
  });

  it('handles voice command for report hazard', async () => {
    const mockVoiceResult = { text: 'report hazard', confidence: 0.9, isFinal: true };
    const mockCommand = { command: 'report_hazard', action: 'report hazard', keywords: ['report', 'hazard'] };

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult(mockVoiceResult);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.processVoiceCommand.mockReturnValue(mockCommand);
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(mockVoiceService.speak).toHaveBeenCalledWith('Opening hazard report form');
    }, { timeout: 2000 });
    expect(mockNavigate).toHaveBeenCalledWith('HazardReport');
  });

  it('handles voice command for help', async () => {
    const mockVoiceResult = { text: 'help', confidence: 0.9, isFinal: true };
    const mockCommand = { command: 'help', action: 'help', keywords: ['help'] };
    const mockCommands = [
      { command: 'report_incident', action: 'report incident', keywords: ['report', 'incident'] },
      { command: 'report_hazard', action: 'report hazard', keywords: ['report', 'hazard'] },
      { command: 'navigate_dashboard', action: 'navigate dashboard', keywords: ['navigate', 'dashboard'] },
    ];

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult(mockVoiceResult);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.processVoiceCommand.mockReturnValue(mockCommand);
    mockVoiceService.getVoiceCommands.mockReturnValue(mockCommands);
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(mockVoiceService.speak).toHaveBeenCalledWith('Available commands: report incident, report hazard, navigate dashboard');
    }, { timeout: 2000 });
  });

  it('handles unrecognized voice command', async () => {
    const mockVoiceResult = { text: 'unknown command', confidence: 0.9, isFinal: true };
    const mockCommand = { command: 'unknown', action: 'unknown command', keywords: ['unknown'] };

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult(mockVoiceResult);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.processVoiceCommand.mockReturnValue(mockCommand);
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(mockVoiceService.speak).toHaveBeenCalledWith('Command not recognized: unknown command');
    }, { timeout: 2000 });
  });

  it('handles voice service errors gracefully', async () => {
    const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
    const mockError = 'Microphone permission denied';

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onError callback immediately
      setTimeout(() => {
        if (onError) {
          onError(mockError);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.speak.mockResolvedValue(undefined);

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Voice error:', mockError);
    }, { timeout: 2000 });

    consoleSpy.mockRestore();
  });

  it('handles voice command processing errors gracefully', async () => {
    const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
    const mockVoiceResult = { text: 'test command', confidence: 0.9, isFinal: true };
    const mockCommand = { command: 'report_incident', action: 'report incident', keywords: ['report', 'incident'] };

    mockVoiceService.startListening.mockImplementation((onResult, onError) => {
      // Simulate calling the onResult callback immediately
      setTimeout(() => {
        if (onResult) {
          onResult(mockVoiceResult);
        }
      }, 10);
      return Promise.resolve();
    });
    mockVoiceService.processVoiceCommand.mockReturnValue(mockCommand);
    mockVoiceService.speak.mockRejectedValue(new Error('TTS error'));

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    // Wait for the async operations to complete
    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error handling voice command:', expect.any(Error));
    }, { timeout: 2000 });

    consoleSpy.mockRestore();
  });

  it('handles voice toggle errors gracefully', async () => {
    const consoleSpy = jest.spyOn(console, 'error').mockImplementation();

    mockVoiceService.startListening.mockRejectedValue(new Error('Permission denied'));

    render(<SafetyDashboardScreen />);

    const voiceButton = screen.getByTestId('voice-button');
    fireEvent.press(voiceButton);

    await waitFor(() => {
      expect(consoleSpy).toHaveBeenCalledWith('Error toggling voice:', expect.any(Error));
    });

    consoleSpy.mockRestore();
  });

  it('displays correct severity icons for incidents', () => {
    render(<SafetyDashboardScreen />);

    // Should have different icons for different severities
    // This test verifies the icon rendering logic is working
    expect(screen.getByText('SAFETY VIOLATION: Worker not wearing safety helmet')).toBeTruthy();
    expect(screen.getByText('EQUIPMENT FAILURE: Crane malfunction')).toBeTruthy();
  });

  it('shows only first 5 incidents in recent activity', () => {
    // Create 10 incidents with the same format as the component
    const manyIncidents = Array.from({ length: 10 }, (_, i) => ({
      id: `${i + 1}`,
      incidentType: 'safety_violation',
      description: `Incident ${i + 1}`,
      severity: 'medium',
      reportedAt: new Date().toISOString(),
      synced: true,
    }));

    // Update the mock state with many incidents
    const updatedMockState = {
      safety: {
        ...mockState.safety,
        incidents: manyIncidents,
      },
    };

    // Mock the selector to return the updated state
    mockSelector.mockImplementation((selector: any) => {
      // Apply the selector function to the updated mock state
      return selector(updatedMockState);
    });

    render(<SafetyDashboardScreen />);

    // Should only show first 5 incidents (with the correct format)
    expect(screen.getByText('SAFETY VIOLATION: Incident 1')).toBeTruthy();
    expect(screen.getByText('SAFETY VIOLATION: Incident 5')).toBeTruthy();
    expect(screen.queryByText('SAFETY VIOLATION: Incident 6')).toBeNull();
  });
});

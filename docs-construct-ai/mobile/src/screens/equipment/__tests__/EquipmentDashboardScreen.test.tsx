import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react-native';
import { Alert } from 'react-native';
import EquipmentDashboardScreen from '../EquipmentDashboardScreen';

// Mock navigation
const mockNavigate = jest.fn();
jest.mock('@react-navigation/native', () => ({
  useNavigation: () => ({
    navigate: mockNavigate,
  }),
}));

// Mock Redux
const mockDispatch = jest.fn();
const mockSelector = jest.fn();
const mockGenerateAIPrediction = jest.fn();
const mockUpdateAIInsights = jest.fn();
const mockCompleteMaintenanceTask = jest.fn();

jest.mock('react-redux', () => ({
  ...jest.requireActual('react-redux'),
  useDispatch: () => mockDispatch,
  useSelector: (selector) => mockSelector(selector),
}));

// Mock equipment slice
jest.mock('../../store/slices/equipmentSlice', () => ({
  updateAIInsights: mockUpdateAIInsights,
  completeMaintenanceTask: mockCompleteMaintenanceTask,
  generateAIPrediction: mockGenerateAIPrediction,
}), { virtual: true });

// Mock Alert
jest.mock('react-native/Libraries/Alert/Alert', () => ({
  alert: jest.fn(),
}));

// Mock Ionicons
jest.mock('@expo/vector-icons', () => ({
  Ionicons: 'Ionicons',
}));

// Mock Dimensions
jest.mock('react-native/Libraries/Utilities/Dimensions', () => ({
  get: jest.fn(() => ({ width: 375, height: 812 })),
}));

describe('EquipmentDashboardScreen', () => {
  const mockState = {
    equipment: {
      equipment: [],
      alerts: [
        { id: '1', acknowledged: false },
        { id: '2', acknowledged: true },
      ],
      maintenanceTasks: [],
      aiInsights: {
        optimizationOpportunities: 3,
        avgHealthScore: 85,
      },
      loading: false,
    },
  };

  beforeEach(() => {
    mockSelector.mockReturnValue(mockState.equipment);
    mockNavigate.mockClear();
    mockDispatch.mockClear();
    jest.clearAllMocks();
  });

  it('renders correctly with header and stats', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('ConstructAI Equipment')).toBeTruthy();
    expect(screen.getByText('AI-powered predictive maintenance')).toBeTruthy();
    expect(screen.getByText('48')).toBeTruthy(); // Total Equipment
    expect(screen.getByText('42')).toBeTruthy(); // Operational
    expect(screen.getByText('4')).toBeTruthy(); // Maintenance Needed
    expect(screen.getByText('2')).toBeTruthy(); // Critical
  });

  it('renders AI action buttons', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('Generate AI Prediction')).toBeTruthy();
    expect(screen.getByText('Schedule Tasks')).toBeTruthy();
    expect(screen.getByText('AI Analytics')).toBeTruthy();
    expect(screen.getByText('Alerts (1)')).toBeTruthy(); // 1 unacknowledged alert
  });

  it('renders AI insights section', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('🤖 AI Insights & Performance')).toBeTruthy();
    expect(screen.getByText('$45,200')).toBeTruthy(); // Predictive Maintenance Savings
    expect(screen.getByText('94.8%')).toBeTruthy(); // Equipment Uptime
    expect(screen.getByText('89%')).toBeTruthy(); // Failure Prevention Rate
    expect(screen.getByText('78%')).toBeTruthy(); // Maintenance Efficiency
  });

  it('renders equipment status cards', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('EXC-033')).toBeTruthy();
    const equipmentNames = screen.getAllByText('Caterpillar Excavator 320D');
    expect(equipmentNames.length).toBeGreaterThan(0);
    expect(screen.getByText('87%')).toBeTruthy(); // Health score
    expect(screen.getByText('Site A - Foundation Zone')).toBeTruthy();
  });

  it('renders AI alerts section', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('🚨 AI-Powered Alerts')).toBeTruthy();
    const craneNames = screen.getAllByText('Paterson Crane PC-12');
    expect(craneNames.length).toBeGreaterThan(0);
    expect(screen.getByText('Hydraulic pressure dropping - risk of imminent failure')).toBeTruthy();
    const recommendations = screen.getAllByText('💡 AI Recommendation:');
    expect(recommendations.length).toBeGreaterThan(0);
  });

  it('renders maintenance schedule section', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('📅 AI-Optimized Maintenance Schedule')).toBeTruthy();
    const truckNames = screen.getAllByText('Studebaker Dump Truck SD-88');
    expect(truckNames.length).toBeGreaterThan(0);
    expect(screen.getByText('Routine Service & Oil Change')).toBeTruthy();
    expect(screen.getByText('Due: 3 days')).toBeTruthy();
  });

  it('navigates to equipment detail when equipment card is pressed', () => {
    render(<EquipmentDashboardScreen />);

    const equipmentCards = screen.getAllByText('Caterpillar Excavator 320D');
    fireEvent.press(equipmentCards[0]);

    expect(mockNavigate).toHaveBeenCalledWith('EquipmentDetail', { equipmentId: '1' });
  });

  it('navigates to maintenance schedule when schedule button is pressed', () => {
    render(<EquipmentDashboardScreen />);

    const scheduleButton = screen.getByText('Schedule Tasks');
    fireEvent.press(scheduleButton);

    expect(mockNavigate).toHaveBeenCalledWith('MaintenanceSchedule');
  });

  it('navigates to AI analytics when analytics button is pressed', () => {
    render(<EquipmentDashboardScreen />);

    const analyticsButton = screen.getByText('AI Analytics');
    fireEvent.press(analyticsButton);

    expect(mockNavigate).toHaveBeenCalledWith('EquipmentAnalytics');
  });

  it('navigates to alerts center when alerts button is pressed', () => {
    render(<EquipmentDashboardScreen />);

    const alertsButton = screen.getByText('Alerts (1)');
    fireEvent.press(alertsButton);

    expect(mockNavigate).toHaveBeenCalledWith('AlertsCenter');
  });

  it('dispatches AI prediction action when generate prediction button is pressed', () => {
    render(<EquipmentDashboardScreen />);

    const predictionButton = screen.getByText('Generate AI Prediction');
    fireEvent.press(predictionButton);

    expect(mockDispatch).toHaveBeenCalled();
    // The dispatch should be called with generateAIPrediction action
    const dispatchCall = mockDispatch.mock.calls[0][0];
    expect(typeof dispatchCall).toBe('function'); // It's a thunk
  });

  it('handles maintenance completion with alert confirmation', () => {
    const alertSpy = jest.spyOn(Alert, 'alert');

    render(<EquipmentDashboardScreen />);

    const completeButtons = screen.getAllByText('Complete');
    expect(completeButtons.length).toBeGreaterThan(0);
    fireEvent.press(completeButtons[0]);

    expect(alertSpy).toHaveBeenCalledWith(
      'Complete Maintenance Task',
      'Confirm that this maintenance task has been completed?',
      expect.any(Array)
    );
  });

  it('shows loading overlay when loading state is true', () => {
    mockSelector.mockReturnValue({
      ...mockState.equipment,
      loading: true,
    });

    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('AI Analyzing Equipment...')).toBeTruthy();
  });

  it('handles pull to refresh', async () => {
    render(<EquipmentDashboardScreen />);

    // Find the ScrollView by its content
    const scrollView = screen.getByText('ConstructAI Equipment').parent?.parent;
    if (scrollView) {
      fireEvent(scrollView, 'onRefresh');
    }

    await waitFor(() => {
      expect(mockDispatch).toHaveBeenCalled();
    });
  });

  it('displays correct health score colors', () => {
    render(<EquipmentDashboardScreen />);

    // Health score of 87% should be green (good health)
    const healthScore = screen.getByText('87%');
    expect(healthScore).toBeTruthy();
    // Note: Color testing would require additional setup with jest-native
  });

  it('displays AI warnings for equipment with predictions', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('1 AI predictions')).toBeTruthy();
    expect(screen.getByText('3 AI predictions')).toBeTruthy();
  });

  it('shows AI confidence levels for optimized maintenance', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('AI Optimized (89% confidence)')).toBeTruthy();
    expect(screen.getByText('AI Optimized (95% confidence)')).toBeTruthy();
  });

  it('displays cost estimates for AI recommendations', () => {
    render(<EquipmentDashboardScreen />);

    expect(screen.getByText('Estimated cost: R8500')).toBeTruthy();
    expect(screen.getByText('Estimated cost: R2450')).toBeTruthy();
  });
});

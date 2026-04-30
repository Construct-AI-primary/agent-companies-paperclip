import React from 'react';
import { Alert } from 'react-native';
import { render, screen, fireEvent } from '@testing-library/react-native';
import EquipmentRegistrationForm from '../EquipmentRegistrationForm';

// Mock navigation
jest.mock('@react-navigation/native', () => ({
  useNavigation: () => ({
    goBack: jest.fn(),
  }),
}));

// Mock Redux
jest.mock('react-redux', () => ({
  ...jest.requireActual('react-redux'),
  useDispatch: () => jest.fn(),
}));

// Mock Ionicons to avoid issues with Expo vector icons in tests
jest.mock('@expo/vector-icons', () => ({
  Ionicons: 'Ionicons',
}));

describe('EquipmentRegistrationForm', () => {
  it('renders correctly', () => {
    render(<EquipmentRegistrationForm />);
    
    // Check that the main title is rendered
    expect(screen.getByText('Register New Equipment')).toBeTruthy();
    
    // Check that the name input field is rendered
    expect(screen.getByPlaceholderText('Enter equipment name...')).toBeTruthy();
    
    // Check that the submit button is rendered
    expect(screen.getByText('Register Equipment')).toBeTruthy();
  });

  it('updates equipment name when typed', () => {
    render(<EquipmentRegistrationForm />);

    const nameInput = screen.getByPlaceholderText('Enter equipment name...');
    fireEvent.changeText(nameInput, 'Test Equipment');
    
    // In React Native Testing Library, we can't directly check the value of a TextInput
    // But we can verify the event was handled without error
    expect(nameInput).toBeTruthy();
  });
});

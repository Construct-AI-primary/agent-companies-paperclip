module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.test.{js,jsx,ts,tsx}'],
  moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx'],
  testPathIgnorePatterns: [
    '<rootDir>/node_modules/',
    '<rootDir>/web/',
    '<rootDir>/WorkingApp/',
    '<rootDir>/WebPreview/',
  ],
  collectCoverageFrom: [
    '**/*.{js,jsx,ts,tsx}',
    '!**/node_modules/**',
    '!**/vendor/**',
    '!**/web/**',
    '!**/__tests__/**',
  ],
  coverageReporters: ['text', 'lcov'],
  moduleNameMapper: {
    '^@expo/vector-icons$': '<rootDir>/__mocks__/expo-vector-icons.js',
  },
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
  },
  transformIgnorePatterns: [
    'node_modules/(?!(jest-)?react-native|@react-native(-community)?|expo(nent)?|@expo(nent)?/.*|@react-navigation/.*|@react-native-async-storage/async-storage/.*)',
  ],
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  projects: [
    {
      displayName: 'node',
      testEnvironment: 'node',
      testMatch: ['**/__tests__/**/*.test.{js,jsx,ts,tsx}'],
      testPathIgnorePatterns: [
        '<rootDir>/node_modules/',
        '<rootDir>/web/',
        '<rootDir>/WorkingApp/',
        '<rootDir>/WebPreview/',
        '<rootDir>/src/screens/equipment/__tests__/EquipmentRegistrationForm.test.tsx',
      ],
      moduleNameMapper: {
        '^@expo/vector-icons$': '<rootDir>/__mocks__/expo-vector-icons.js',
      },
      transform: {
        '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
      },
      transformIgnorePatterns: [
        'node_modules/(?!(jest-)?react-native|@react-native(-community)?|expo(nent)?|@expo(nent)?/.*|@react-navigation/.*|@react-native-async-storage/async-storage/.*)',
      ],
      setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
    },
    {
      displayName: 'jsdom',
      testEnvironment: 'jsdom',
      testMatch: ['<rootDir>/src/screens/equipment/__tests__/EquipmentRegistrationForm.test.tsx'],
      moduleNameMapper: {
        '^@expo/vector-icons$': '<rootDir>/__mocks__/expo-vector-icons.js',
      },
      transform: {
        '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
      },
      transformIgnorePatterns: [
        'node_modules/(?!(jest-)?react-native|@react-native(-community)?|expo(nent)?|@expo(nent)?/.*|@react-navigation/.*|@react-native-async-storage/async-storage/.*)',
      ],
      setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
    },
  ],
};

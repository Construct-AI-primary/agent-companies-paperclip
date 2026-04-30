const expoPreset = require('jest-expo/jest-preset');

module.exports = {
  ...expoPreset,
  transformIgnorePatterns: [
    'node_modules/(?!((jest-)?react-native|@react-native(-community)?)|expo(nent)?|@expo(nent)?/.*|@react-native-async-storage/async-storage/.*|react-redux/.*|@react-navigation/.*|@expo/vector-icons/.*|react-native-reanimated/.*|react-native-gesture-handler/.*|react-native-screens/.*|react-native-safe-area-context/.*|@react-native-picker/picker/.*|react-native-modal/.*|react-native-paper/.*|react-native-vector-icons/.*|@supabase/.*|@reduxjs/toolkit/.*|lodash/.*|moment/.*|axios/.*|buffer/.*|crypto-browserify/.*|path-browserify/.*|readable-stream/.*|util/.*|immer/.*)',
  ],
  setupFilesAfterEnv: [
    '@testing-library/jest-native/extend-expect',
    '<rootDir>/jest.setup.js',
  ],
};

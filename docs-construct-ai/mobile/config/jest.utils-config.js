module.exports = {
  testEnvironment: 'node',
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
  },
  testMatch: ['**/src/utils/__tests__/**/*.test.(js|ts)'],
  moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx'],
  collectCoverageFrom: [
    'src/utils/**/*.{js,jsx,ts,tsx}',
    '!src/utils/__tests__/**',
  ],
};

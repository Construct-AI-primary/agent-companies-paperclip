# ConstructAI Mobile

A comprehensive React Native/Expo mobile application for ConstructAI, providing field operations, logistics management, safety monitoring, and procurement workflows on mobile devices.

## Features

- **Multi-Platform Support**: iOS, Android, and Web
- **Offline-First Architecture**: Full functionality without internet connectivity
- **AI-Powered Workflows**: Intelligent automation for logistics, safety, and procurement
- **Real-time Synchronization**: Seamless data sync with ConstructAI backend
- **Advanced Testing**: Comprehensive unit, integration, and E2E test suites
- **Internationalization**: Multi-language support with automated translation

## Tech Stack

- **Framework**: React Native 0.79.5 with Expo SDK 53
- **Language**: TypeScript
- **State Management**: Redux Toolkit
- **Navigation**: React Navigation v6
- **Database**: SQLite with custom sync layer
- **Testing**: Jest, React Testing Library, Detox (E2E)
- **CI/CD**: GitHub Actions with comprehensive pipeline

## Project Structure

```
ConstructAI-mobile/
├── src/
│   ├── components/          # Reusable UI components
│   ├── screens/            # Screen components by feature
│   ├── services/           # API, database, and utility services
│   ├── store/              # Redux store configuration
│   ├── navigation/         # Navigation configuration
│   └── utils/              # Helper functions and utilities
├── assets/                 # Images, fonts, and static assets
├── e2e/                    # End-to-end tests
├── __tests__/              # Unit and integration tests
├── WebPreview/             # Web preview build
├── WorkingApp/             # Alternative app configurations
└── .github/workflows/      # CI/CD pipelines
```

## Development Setup

### Prerequisites

- Node.js 18+
- npm or yarn
- Expo CLI
- iOS Simulator (macOS) or Android Studio (Android development)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Construct-AI-primary/constructai-mobile.git
   cd constructai-mobile
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

4. Run on specific platform:
   ```bash
   npm run ios      # iOS Simulator
   npm run android  # Android Emulator
   npm run web      # Web browser
   ```

### Testing

- **Unit Tests**: `npm test`
- **Integration Tests**: `npm run test:integration`
- **E2E Tests**: `npm run e2e`
- **All Tests**: `npm run test:all`

### Building

- **iOS**: `npm run build:ios`
- **Android**: `npm run build:android`
- **Web**: `npm run build:web`

## Key Features

### Logistics Management
- Customs clearance workflows
- Shipment tracking and monitoring
- Document management with OCR
- Real-time GPS tracking

### Safety & Compliance
- Incident reporting with voice commands
- Hazard identification with AI assistance
- Safety checklist automation
- Emergency response coordination

### Procurement
- Purchase order management
- Supplier evaluation workflows
- Contract digitization
- Approval process automation

### Equipment Management
- Asset tracking and maintenance
- Usage analytics and reporting
- Preventive maintenance scheduling
- Equipment lifecycle management

## Architecture

The app follows a modular architecture with:

- **Clean Architecture**: Separation of concerns with clear boundaries
- **Feature-based Organization**: Code organized by business features
- **Offline-First**: Optimistic updates with conflict resolution
- **Microservices Communication**: RESTful APIs with GraphQL support
- **Security**: End-to-end encryption and secure authentication

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes and add tests
4. Run the full test suite: `npm run test:all`
5. Commit your changes: `git commit -am 'Add your feature'`
6. Push to the branch: `git push origin feature/your-feature`
7. Submit a pull request

## CI/CD

The project uses GitHub Actions for continuous integration with:

- Automated testing on multiple Node.js versions
- iOS and Android build verification
- Bundle size analysis
- Security vulnerability scanning
- Performance regression testing

## Deployment

- **iOS**: App Store Connect with TestFlight beta distribution
- **Android**: Google Play Store with internal testing tracks
- **Web**: Vercel/Netlify with CDN optimization

## Support

For support and questions:
- Create an issue in this repository
- Contact the mobile development team
- Check the [ConstructAI Documentation](https://github.com/Construct-AI-primary/construct_ai_docs)

## License

This project is part of the ConstructAI ecosystem. See the main repository for licensing information.
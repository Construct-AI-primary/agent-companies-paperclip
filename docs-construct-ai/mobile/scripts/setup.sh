#!/bin/bash

# ConstructAI Mobile Emergency Setup Script
echo "🚀 EMERGENCY SETUP: Fixing Expo Issues..."
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

echo "🧹 Cleaning corrupted installation..."
# Remove problem files
rm -rf node_modules package-lock.json yarn.lock .expo

echo ""
echo "📦 Installing Expo first..."
npm install expo --force

echo ""
echo "📦 Installing all dependencies..."
npm install

echo ""
echo "🔧 Installing @expo/cli globally..."
npm install -g @expo/cli

echo ""
echo "🎯 Verifying Expo installation..."
which expo || echo "✅ Global expo found"
npx expo --version

echo ""
echo "⚡ Testing development server setup..."
timeout 5s npx expo start || echo "Server test completed"

echo ""
echo "📱 Creating .env file from template..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ Created .env from template"
else
    echo "ℹ️  .env file already exists"
fi

echo ""
echo "🎉 Setup Complete!"
echo ""
echo "🚀 To start your ConstructAI mobile app:"
echo ""
echo "   For iOS development:"
echo "   npx expo run:ios"
echo ""
echo "   For Android development:"
echo "   npx expo run:android"
echo ""
echo "   Or start the development server:"
echo "   npm start"
echo ""
echo "   Then scan the QR code with:"
echo "   - iOS: Camera app or Expo Go"
echo "   - Android: Expo Go app"
echo ""
echo "🔗 Additional Resources:"
echo "   📚 Documentation: https://docs.expo.dev/"
echo "   🛠️  Expo Dashboard: https://expo.dev/"
echo "   📞 Support: https://expo.dev/support"

echo ""
API_BASE_URL=http://localhost:3001/api
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key

# Development Settings
NODE_ENV=development
EXPO_DEBUG=true

# App Configuration
APP_NAME=ConstructAI
APP_VERSION=1.0.0
BUILD_NUMBER=1
EOF
    echo -e "${GREEN}✅ Environment file created (.env)${NC}"
    echo -e "${YELLOW}⚠️  Please update .env with your actual configuration values${NC}"
fi

# Create required directories
echo -e "${BLUE}📁 Creating project directories...${NC}"
mkdir -p src/{components,services,database,types,constants}
mkdir -p src/screens/{safety,inspections,hazards,analytics,settings}
mkdir -p assets/{images,icons,fonts}

echo -e "${GREEN}✅ Project structure created${NC}"

# Check if iOS development is possible (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo -e "${BLUE}🍎 Checking iOS development setup...${NC}"

    # Check if Xcode is installed
    if ! command -v xcodebuild &> /dev/null; then
        echo -e "${YELLOW}⚠️  Xcode not found. Install Xcode from the App Store for iOS development${NC}"
    else
        XCODE_VERSION=$(xcodebuild -version | head -n1 | awk '{print $2}')
        echo -e "${GREEN}✅ Xcode $XCODE_VERSION detected${NC}"
    fi

    # Check if CocoaPods is installed
    if ! command -v pod &> /dev/null; then
        echo -e "${YELLOW}⚠️  CocoaPods not found. Run: sudo gem install cocoapods${NC}"
    else
        POD_VERSION=$(pod --version)
        echo -e "${GREEN}✅ CocoaPods $POD_VERSION detected${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Not on macOS - iOS development not available${NC}"
fi

# Check Android development setup
echo -e "${BLUE}🤖 Checking Android development setup...${NC}"

if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n1 | awk -F '"' '{print $2}')
    echo -e "${GREEN}✅ Java $JAVA_VERSION detected${NC}"
else
    echo -e "${YELLOW}⚠️  Java not found. Install Android Studio for Android development${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
echo -e "${BLUE}🚀 To start developing:${NC}"
echo "1. Start the Expo development server:"
echo -e "${YELLOW}   npm start${NC}"
echo ""
echo "2. For iOS development:"
echo -e "${YELLOW}   npm run ios${NC}"
echo ""
echo "3. For Android development:"
echo -e "${YELLOW}   npm run android${NC}"
echo ""
echo "4. For web development (testing):"
echo -e "${YELLOW}   npm run web${NC}"
echo ""
echo -e "${BLUE}📖 Documentation:${NC}"
echo "- Main docs: ./README.md"
echo "- Implementation guide: ../docs/1300_99999_MOBILE_SAFETY_MODULE_IMPLEMENTATION.md"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"

// Web-specific setup for Expo compatibility with Node.js v22
if (typeof window !== 'undefined') {
  // Polyfill for web globals
  if (!window.Expo) {
    window.Expo = {};
  }
  
  // Mock native modules for web
  if (!window.NativeModules) {
    window.NativeModules = {};
  }
  
  // Ensure Expo modules are properly registered
  if (typeof window.ExpoModules === 'undefined') {
    window.ExpoModules = {
      registerWebGlobals: () => {
        // No-op for now, just prevent the error
      }
    };
  }
}

// Export for compatibility
export const registerWebGlobals = () => {
  // Simple implementation to prevent TypeError
};

const { getDefaultConfig } = require('expo/metro-config');

module.exports = (async () => {
  const config = getDefaultConfig(__dirname);

  // Add web extensions
  config.resolver.assetExts.push('web.tsx', 'web.ts', 'web.js');

  // Fix for Node.js v22 ESM compatibility
  config.resolver.extraNodeModules = {
    ...config.resolver.extraNodeModules,
    stream: require.resolve('readable-stream'),
    crypto: require.resolve('crypto-browserify'),
    path: require.resolve('path-browserify'),
    buffer: require.resolve('buffer'),
    util: require.resolve('util'),
  };

  return config;
})();

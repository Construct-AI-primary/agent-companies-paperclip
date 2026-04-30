// Comprehensive console error capture and display
// Run this in browser console to see all errors clearly

// Create a visible error display
const errorDisplay = document.createElement('div');
errorDisplay.id = 'error-capture-display';
errorDisplay.style.cssText = `
  position: fixed;
  top: 10px;
  right: 10px;
  width: 400px;
  max-height: 300px;
  background: #ff0000;
  color: white;
  padding: 10px;
  border-radius: 5px;
  font-family: monospace;
  font-size: 12px;
  z-index: 999999;
  overflow-y: auto;
  box-shadow: 0 0 10px rgba(0,0,0,0.5);
`;
errorDisplay.innerHTML = '<strong>CONSOLE ERRORS CAPTURED:</strong><br><br>';
document.body.appendChild(errorDisplay);

// Override console.error to capture and display errors
const originalConsoleError = console.error;
console.error = function(...args) {
  // Call original console.error
  originalConsoleError.apply(console, args);

  // Add to our display
  const errorText = args.map(arg =>
    typeof arg === 'object' ? JSON.stringify(arg, null, 2) : String(arg)
  ).join(' ');

  errorDisplay.innerHTML += `<div style="margin: 5px 0; padding: 5px; background: rgba(255,255,255,0.1); border-radius: 3px;">${errorText}</div>`;

  // Also log to a global variable for inspection
  window.capturedErrors = window.capturedErrors || [];
  window.capturedErrors.push({
    timestamp: new Date().toISOString(),
    args: args,
    stack: new Error().stack
  });
};

// Also capture unhandled errors
window.addEventListener('error', function(event) {
  const errorInfo = {
    message: event.message,
    filename: event.filename,
    lineno: event.lineno,
    colno: event.colno,
    error: event.error
  };

  console.error('UNHANDLED ERROR:', errorInfo);

  errorDisplay.innerHTML += `<div style="margin: 5px 0; padding: 5px; background: rgba(255,0,0,0.8); border-radius: 3px;"><strong>UNHANDLED:</strong> ${event.message} at ${event.filename}:${event.lineno}</div>`;
});

// Also capture unhandled promise rejections
window.addEventListener('unhandledrejection', function(event) {
  console.error('UNHANDLED PROMISE REJECTION:', event.reason);

  errorDisplay.innerHTML += `<div style="margin: 5px 0; padding: 5px; background: rgba(255,0,0,0.8); border-radius: 3px;"><strong>PROMISE REJECTION:</strong> ${event.reason}</div>`;
});

// Add a close button
const closeButton = document.createElement('button');
closeButton.textContent = '×';
closeButton.style.cssText = `
  position: absolute;
  top: 5px;
  right: 5px;
  background: none;
  border: none;
  color: white;
  font-size: 20px;
  cursor: pointer;
  padding: 0;
  margin: 0;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
`;
closeButton.onclick = () => document.body.removeChild(errorDisplay);
errorDisplay.appendChild(closeButton);

// Add a clear button
const clearButton = document.createElement('button');
clearButton.textContent = 'Clear';
clearButton.style.cssText = `
  position: absolute;
  top: 5px;
  right: 30px;
  background: rgba(255,255,255,0.2);
  border: none;
  color: white;
  font-size: 10px;
  cursor: pointer;
  padding: 2px 5px;
  border-radius: 3px;
`;
clearButton.onclick = () => {
  errorDisplay.innerHTML = '<strong>CONSOLE ERRORS CAPTURED:</strong><br><br>';
  errorDisplay.appendChild(closeButton);
  errorDisplay.appendChild(clearButton);
};
errorDisplay.appendChild(clearButton);

console.log('🔍 Error capture display created! All console errors will now be visible in the red box in the top-right corner.');
console.log('📋 You can also inspect window.capturedErrors for detailed error information.');
console.log('❌ Click the × to close or Clear to reset the display.');

// Trigger a test error to verify it's working
setTimeout(() => {
  console.error('Test error - this should appear in the red display box');
}, 1000);
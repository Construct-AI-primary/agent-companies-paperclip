import { configureStore } from '@reduxjs/toolkit';
import safetyReducer from './slices/safetySlice';
import logisticsReducer from './slices/logisticsSlice';
import stockReducer from './slices/stockSlice';
import equipmentReducer from './slices/equipmentSlice';

// Configure the Redux store
export const store = configureStore({
  reducer: {
    safety: safetyReducer,
    logistics: logisticsReducer,
    stock: stockReducer,
    equipment: equipmentReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        // Ignore these specific paths for non-serializable values
        ignoredActions: ['persist/PERSIST', 'persist/REHYDRATE'],
        ignoredPaths: ['register', 'rehydrate'],
      },
    }),
});

// Export types for TypeScript
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

// Export the store as default
export default store;

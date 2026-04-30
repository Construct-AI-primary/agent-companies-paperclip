/**
 * API Service Integration Tests
 *
 * These tests verify the actual integration between the API service
 * and Supabase backend, testing real network calls and data flow.
 *
 * Note: These tests require a valid Supabase configuration and may
 * make actual network calls. Use with caution in CI/CD environments.
 */

import { apiService } from '../api';

// Mock environment variables for testing
const originalEnv = process.env;

beforeAll(() => {
  // Set up test environment variables
  process.env.EXPO_PUBLIC_SUPABASE_URL = 'https://test.supabase.co';
  process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY = 'test-anon-key';

  // Mock Supabase client to avoid actual network calls
  jest.mock('@supabase/supabase-js', () => ({
    createClient: jest.fn(() => ({
      auth: {
        signInWithPassword: jest.fn(),
        signUp: jest.fn(),
        signOut: jest.fn(),
      },
      from: jest.fn(() => ({
        select: jest.fn(() => ({
          order: jest.fn(() => ({
            data: [],
            error: null,
          })),
        })),
        insert: jest.fn(() => ({
          select: jest.fn(() => ({
            single: jest.fn(() => ({
              data: { id: 'test-id' },
              error: null,
            })),
          })),
        })),
        update: jest.fn(() => ({
          eq: jest.fn(() => ({
            select: jest.fn(() => ({
              single: jest.fn(() => ({
                data: { id: 'test-id' },
                error: null,
              })),
            })),
          })),
        })),
        delete: jest.fn(() => ({
          eq: jest.fn(() => ({
            error: null,
          })),
        })),
        upsert: jest.fn(() => ({
          select: jest.fn(() => ({
            single: jest.fn(() => ({
              data: { id: 'test-id' },
              error: null,
            })),
          })),
        })),
      })),
      storage: {
        from: jest.fn(() => ({
          upload: jest.fn(() => ({
            data: { path: 'test-path' },
            error: null,
          })),
          getPublicUrl: jest.fn(() => ({
            data: { publicUrl: 'https://test.com/photo.jpg' },
          })),
        })),
      },
    })),
  }));
});

afterAll(() => {
  // Restore original environment
  process.env = originalEnv;
});

describe('API Service Integration', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Authentication Integration', () => {
    it('should handle successful login with Supabase', async () => {
      const mockUser = { id: '123', email: 'test@example.com' };

      // Mock the Supabase auth response
      const mockSupabase = require('@supabase/supabase-js').createClient();
      mockSupabase.auth.signInWithPassword.mockResolvedValue({
        data: { user: mockUser },
        error: null,
      });

      const result = await apiService.login('test@example.com', 'password123');

      expect(result).toEqual({ user: mockUser });
      expect(mockSupabase.auth.signInWithPassword).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123',
      });
    });

    it('should handle login errors from Supabase', async () => {
      const mockError = new Error('Invalid login credentials');

      const mockSupabase = require('@supabase/supabase-js').createClient();
      mockSupabase.auth.signInWithPassword.mockResolvedValue({
        data: null,
        error: mockError,
      });

      await expect(apiService.login('test@example.com', 'wrongpassword'))
        .rejects.toThrow('Invalid login credentials');
    });

    it('should handle successful registration with Supabase', async () => {
      const mockUser = { id: '123', email: 'new@example.com' };
      const userData = {
        email: 'new@example.com',
        password: 'password123',
        name: 'New User',
      };

      const mockSupabase = require('@supabase/supabase-js').createClient();
      mockSupabase.auth.signUp.mockResolvedValue({
        data: { user: mockUser },
        error: null,
      });

      const result = await apiService.register(userData);

      expect(result).toEqual({ user: mockUser });
      expect(mockSupabase.auth.signUp).toHaveBeenCalledWith({
        email: 'new@example.com',
        password: 'password123',
        options: {
          data: {
            name: 'New User',
          },
        },
      });
    });

    it('should handle logout with Supabase', async () => {
      const mockSupabase = require('@supabase/supabase-js').createClient();
      mockSupabase.auth.signOut.mockResolvedValue({
        error: null,
      });

      await expect(apiService.logout()).resolves.toBeUndefined();
      expect(mockSupabase.auth.signOut).toHaveBeenCalled();
    });
  });

  describe('Incident CRUD Integration', () => {
    it('should fetch incidents from Supabase', async () => {
      const mockIncidents = [
        {
          id: '1',
          incidentType: 'accident',
          description: 'Test incident',
          severity: 'high',
          reportedAt: '2024-01-01T00:00:00Z',
          synced: true,
        },
      ];

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockSelect = mockFrom.select();
      const mockOrder = mockSelect.order();

      mockOrder.data = mockIncidents;
      mockOrder.error = null;

      const result = await apiService.getIncidents();

      expect(result).toEqual(mockIncidents);
      expect(mockFrom.select).toHaveBeenCalledWith('*');
      expect(mockSelect.order).toHaveBeenCalledWith('reportedAt', { ascending: false });
    });

    it('should create incident in Supabase', async () => {
      const newIncident = {
        incidentType: 'accident',
        description: 'New incident',
        severity: 'medium' as const,
        photos: [],
        videos: [],
        status: 'reported' as const,
      };

      const expectedIncident = {
        ...newIncident,
        id: 'test-id',
        reportedAt: expect.any(String),
        synced: true,
      };

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockInsert = mockFrom.insert();
      const mockSelect = mockInsert.select();
      const mockSingle = mockSelect.single();

      mockSingle.data = expectedIncident;
      mockSingle.error = null;

      const result = await apiService.createIncident(newIncident);

      expect(result).toEqual(expectedIncident);
      expect(mockFrom.insert).toHaveBeenCalledWith([{
        ...newIncident,
        reportedAt: expect.any(String),
        synced: true,
      }]);
    });

    it('should update incident in Supabase', async () => {
      const updates = { severity: 'critical' as const };
      const updatedIncident = {
        id: '1',
        incidentType: 'accident',
        description: 'Updated incident',
        severity: 'critical',
        synced: true,
      };

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockUpdate = mockFrom.update();
      const mockEq = mockUpdate.eq();
      const mockSelect = mockEq.select();
      const mockSingle = mockSelect.single();

      mockSingle.data = updatedIncident;
      mockSingle.error = null;

      const result = await apiService.updateIncident('1', updates);

      expect(result).toEqual(updatedIncident);
      expect(mockFrom.update).toHaveBeenCalledWith(updates);
      expect(mockUpdate.eq).toHaveBeenCalledWith('id', '1');
    });

    it('should delete incident from Supabase', async () => {
      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockDelete = mockFrom.delete();
      const mockEq = mockDelete.eq();

      mockEq.error = null;

      await expect(apiService.deleteIncident('1')).resolves.toBeUndefined();
      expect(mockFrom.delete).toHaveBeenCalled();
      expect(mockDelete.eq).toHaveBeenCalledWith('id', '1');
    });
  });

  describe('Sync Operations Integration', () => {
    it('should sync incidents with Supabase', async () => {
      const incidents = [
        {
          id: '1',
          incidentType: 'accident',
          description: 'Test incident 1',
          severity: 'medium' as const,
          photos: [],
          videos: [],
          status: 'reported' as const,
          synced: false,
          reportedAt: '2024-01-01T00:00:00Z',
        },
      ];

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockUpsert = mockFrom.upsert();
      const mockSelect = mockUpsert.select();
      const mockSingle = mockSelect.single();

      mockSingle.data = { ...incidents[0], synced: true };
      mockSingle.error = null;

      const result = await apiService.syncIncidents(incidents);

      expect(result.synced).toHaveLength(1);
      expect(result.failed).toHaveLength(0);
      expect(mockFrom.upsert).toHaveBeenCalledWith([incidents[0]]);
    });

    it('should handle sync failures gracefully', async () => {
      const incidents = [
        {
          id: '1',
          incidentType: 'accident',
          description: 'Test incident 1',
          severity: 'medium' as const,
          photos: [],
          videos: [],
          status: 'reported' as const,
          synced: false,
          reportedAt: '2024-01-01T00:00:00Z',
        },
      ];

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockUpsert = mockFrom.upsert();
      const mockSelect = mockUpsert.select();
      const mockSingle = mockSelect.single();

      // Simulate sync failure
      mockSingle.data = null;
      mockSingle.error = new Error('Sync failed');

      const result = await apiService.syncIncidents(incidents);

      expect(result.synced).toHaveLength(0);
      expect(result.failed).toEqual(['1']);
    });
  });

  describe('File Upload Integration', () => {
    beforeEach(() => {
      // Mock fetch for photo upload
      global.fetch = jest.fn(() =>
        Promise.resolve({
          blob: () => Promise.resolve(new Blob(['test'])),
        })
      ) as jest.Mock;
    });

    afterEach(() => {
      (global.fetch as jest.Mock).mockRestore();
    });

    it('should upload photo to Supabase storage', async () => {
      const mockPhotoUri = 'file://path/to/photo.jpg';
      const expectedUrl = 'https://test.com/photo.jpg';

      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockStorage = mockSupabase.storage;
      const mockFrom = mockStorage.from();
      const mockUpload = mockFrom.upload();
      const mockGetPublicUrl = mockFrom.getPublicUrl();

      mockUpload.data = { path: 'test-path' };
      mockUpload.error = null;
      mockGetPublicUrl.data = { publicUrl: expectedUrl };

      const result = await apiService.uploadPhoto(mockPhotoUri, 'incident123');

      expect(result).toEqual({ url: expectedUrl });
      expect(mockFrom.upload).toHaveBeenCalled();
      expect(mockFrom.getPublicUrl).toHaveBeenCalled();
    });
  });

  describe('Error Handling Integration', () => {
    it('should handle network errors gracefully', async () => {
      const mockSupabase = require('@supabase/supabase-js').createClient();
      const mockFrom = mockSupabase.from();
      const mockSelect = mockFrom.select();
      const mockOrder = mockSelect.order();

      mockOrder.data = null;
      mockOrder.error = new Error('Network error');

      await expect(apiService.getIncidents()).rejects.toThrow('Network error');
    });

    it('should handle authentication errors', async () => {
      const mockSupabase = require('@supabase/supabase-js').createClient();
      mockSupabase.auth.signInWithPassword.mockResolvedValue({
        data: null,
        error: new Error('Authentication failed'),
      });

      await expect(apiService.login('test@example.com', 'password'))
        .rejects.toThrow('Authentication failed');
    });
  });
});

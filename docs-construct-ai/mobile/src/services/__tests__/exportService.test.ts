/**
 * Export Service Unit Tests
 *
 * Tests the export functionality for safety incidents and hazards,
 * including various export formats, filtering, file management, and sharing.
 */

import { exportService, ExportOptions, ExportResult } from '../exportService';
import * as FileSystem from 'expo-file-system';
import * as Sharing from 'expo-sharing';
import * as Print from 'expo-print';

// Mock external dependencies
jest.mock('expo-file-system');
jest.mock('expo-sharing');
jest.mock('expo-print');
jest.mock('expo-document-picker');

describe('ExportService', () => {
  const mockFileSystem = FileSystem as jest.Mocked<typeof FileSystem>;
  const mockSharing = Sharing as jest.Mocked<typeof Sharing>;
  const mockPrint = Print as jest.Mocked<typeof Print>;

  // Mock data
  const mockIncidents = [
    {
      id: '1',
      incidentType: 'accident',
      severity: 'high' as const,
      description: 'Worker slipped on wet floor',
      reportedAt: '2024-01-15T10:00:00Z',
      status: 'investigating' as const,
      location: { latitude: -26.2041, longitude: 28.0473 },
      photos: [{ uri: 'photo1.jpg', timestamp: '2024-01-15T10:00:00Z' }],
      videos: [{ uri: 'video1.mp4', timestamp: '2024-01-15T10:00:00Z' }],
      synced: false,
    },
    {
      id: '2',
      incidentType: 'near_miss',
      severity: 'medium' as const,
      description: 'Equipment almost fell',
      reportedAt: '2024-01-20T14:30:00Z',
      status: 'closed' as const,
      location: { latitude: -26.1951, longitude: 28.0345 },
      photos: [],
      videos: [],
      synced: true,
    },
    {
      id: '3',
      incidentType: 'accident',
      severity: 'critical' as const,
      description: 'Major equipment failure',
      reportedAt: '2024-02-01T09:15:00Z',
      status: 'reported' as const,
      location: undefined,
      photos: [{ uri: 'photo3.jpg', timestamp: '2024-02-01T09:15:00Z' }],
      videos: [
        { uri: 'video2.mp4', timestamp: '2024-02-01T09:15:00Z' },
        { uri: 'video3.mp4', timestamp: '2024-02-01T09:15:00Z' }
      ],
      synced: false,
    },
  ];

  const mockHazards = [
    {
      id: '1',
      hazardType: 'chemical',
      riskLevel: 'high' as const,
      description: 'Spilled hazardous chemicals',
      status: 'active' as const,
      location: { latitude: -26.2041, longitude: 28.0473 },
      synced: false,
    },
    {
      id: '2',
      hazardType: 'electrical',
      riskLevel: 'medium' as const,
      description: 'Exposed wiring',
      status: 'mitigated' as const,
      location: { latitude: -26.1951, longitude: 28.0345 },
      synced: true,
    },
  ];

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    Object.defineProperty(mockFileSystem, 'documentDirectory', {
      value: 'file:///documents/',
      writable: false,
    });
    mockFileSystem.getInfoAsync.mockResolvedValue({
      exists: true,
      uri: 'file:///documents/exports/',
      modificationTime: Date.now(),
      isDirectory: true,
    } as any);
    mockFileSystem.makeDirectoryAsync.mockResolvedValue(undefined);
    mockFileSystem.writeAsStringAsync.mockResolvedValue(undefined);
    mockFileSystem.readDirectoryAsync.mockResolvedValue([]);
    mockFileSystem.moveAsync.mockResolvedValue(undefined);
    mockSharing.isAvailableAsync.mockResolvedValue(true);
    mockSharing.shareAsync.mockResolvedValue(undefined);
    mockPrint.printToFileAsync.mockResolvedValue({
      uri: 'file:///temp/export.pdf',
      numberOfPages: 1
    } as any);
  });

  describe('Initialization', () => {
    it('should create export directory on initialization', async () => {
      mockFileSystem.getInfoAsync.mockResolvedValueOnce({
        exists: false,
        uri: 'file:///documents/exports/',
        modificationTime: Date.now(),
        isDirectory: false,
      } as any);

      // Reinitialize service to trigger directory creation
      const newService = new (exportService.constructor as any)();

      expect(mockFileSystem.makeDirectoryAsync).toHaveBeenCalledWith(
        'file:///documents/exports/',
        { intermediates: true }
      );
    });

    it('should handle directory creation errors gracefully', async () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      mockFileSystem.getInfoAsync.mockRejectedValueOnce(new Error('Permission denied'));

      const newService = new (exportService.constructor as any)();

      expect(consoleSpy).toHaveBeenCalledWith(
        'Failed to create export directory:',
        expect.any(Error)
      );

      consoleSpy.mockRestore();
    });
  });

  describe('Incident Export', () => {
    const baseOptions: ExportOptions = {
      format: 'json',
    };

    it('should export incidents to JSON format', async () => {
      const result = await exportService.exportIncidents(mockIncidents, baseOptions);

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-incidents-.*\.json/);
      expect(result.fileUri).toContain('exports/');
      expect(mockFileSystem.writeAsStringAsync).toHaveBeenCalled();

      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      expect(writtenContent.incidents).toHaveLength(3);
      expect(writtenContent.totalCount).toBe(3);
      expect(writtenContent.exportedAt).toBeDefined();
    });

    it('should export incidents to CSV format', async () => {
      const csvOptions: ExportOptions = { format: 'csv' };

      const result = await exportService.exportIncidents(mockIncidents, csvOptions);

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-incidents-.*\.csv/);
      expect(mockFileSystem.writeAsStringAsync).toHaveBeenCalled();

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      expect(csvContent).toContain('ID,Type,Severity,Description,Date,Status');
      expect(csvContent).toContain('accident');
      expect(csvContent).toContain('high');
    });

    it('should export incidents to PDF format', async () => {
      const pdfOptions: ExportOptions = { format: 'pdf' };

      const result = await exportService.exportIncidents(mockIncidents, pdfOptions);

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-incidents-.*\.pdf/);
      expect(mockPrint.printToFileAsync).toHaveBeenCalled();
      expect(mockFileSystem.moveAsync).toHaveBeenCalled();
    });

    it('should filter incidents by date range', async () => {
      const dateOptions: ExportOptions = {
        format: 'json',
        dateRange: {
          start: new Date('2024-01-10T00:00:00Z'),
          end: new Date('2024-01-25T23:59:59Z'),
        },
      };

      const result = await exportService.exportIncidents(mockIncidents, dateOptions);

      expect(result.success).toBe(true);
      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      // Should only include incidents 1 and 2 (within date range)
      expect(writtenContent.incidents).toHaveLength(2);
      expect(writtenContent.incidents.map((i: any) => i.id)).toEqual(['1', '2']);
    });

    it('should filter incidents by severity', async () => {
      const severityOptions: ExportOptions = {
        format: 'json',
        filterBySeverity: ['high', 'critical'],
      };

      const result = await exportService.exportIncidents(mockIncidents, severityOptions);

      expect(result.success).toBe(true);
      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      // Should only include high and critical severity incidents
      expect(writtenContent.incidents).toHaveLength(2);
      expect(writtenContent.incidents.map((i: any) => i.id)).toEqual(['1', '3']);
    });

    it('should filter incidents by type', async () => {
      const typeOptions: ExportOptions = {
        format: 'json',
        filterByType: ['accident'],
      };

      const result = await exportService.exportIncidents(mockIncidents, typeOptions);

      expect(result.success).toBe(true);
      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      // Should only include accident type incidents
      expect(writtenContent.incidents).toHaveLength(2);
      expect(writtenContent.incidents.map((i: any) => i.id)).toEqual(['1', '3']);
    });

    it('should handle empty filtered results', async () => {
      const emptyOptions: ExportOptions = {
        format: 'json',
        filterByType: ['nonexistent_type'],
      };

      const result = await exportService.exportIncidents(mockIncidents, emptyOptions);

      expect(result.success).toBe(false);
      expect(result.error).toBe('No incidents match the specified criteria');
    });

    it('should handle export errors gracefully', async () => {
      mockFileSystem.writeAsStringAsync.mockRejectedValueOnce(new Error('Disk full'));

      const result = await exportService.exportIncidents(mockIncidents, baseOptions);

      expect(result.success).toBe(false);
      expect(result.error).toBe('Disk full');
    });
  });

  describe('Hazard Export', () => {
    const baseOptions: ExportOptions = {
      format: 'json',
    };

    it('should export hazards to JSON format', async () => {
      const result = await exportService.exportHazards(mockHazards, baseOptions);

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-hazards-.*\.json/);

      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      expect(writtenContent.hazards).toHaveLength(2);
      expect(writtenContent.totalCount).toBe(2);
    });

    it('should export hazards to CSV format', async () => {
      const csvOptions: ExportOptions = { format: 'csv' };

      const result = await exportService.exportHazards(mockHazards, csvOptions);

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-hazards-.*\.csv/);

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      expect(csvContent).toContain('ID,Type,Risk Level,Description,Status');
      expect(csvContent).toContain('chemical');
      expect(csvContent).toContain('high');
    });

    it('should filter hazards by risk level', async () => {
      const riskOptions: ExportOptions = {
        format: 'json',
        filterBySeverity: ['high'],
      };

      const result = await exportService.exportHazards(mockHazards, riskOptions);

      expect(result.success).toBe(true);
      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      expect(writtenContent.hazards).toHaveLength(1);
      expect(writtenContent.hazards[0].id).toBe('1');
    });

    it('should filter hazards by type', async () => {
      const typeOptions: ExportOptions = {
        format: 'json',
        filterByType: ['electrical'],
      };

      const result = await exportService.exportHazards(mockHazards, typeOptions);

      expect(result.success).toBe(true);
      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      expect(writtenContent.hazards).toHaveLength(1);
      expect(writtenContent.hazards[0].id).toBe('2');
    });
  });

  describe('Comprehensive Safety Report', () => {
    it('should export comprehensive safety report to PDF', async () => {
      const reportOptions: ExportOptions = {
        format: 'pdf',
        dateRange: {
          start: new Date('2024-01-01T00:00:00Z'),
          end: new Date('2024-12-31T23:59:59Z'),
        },
      };

      const result = await exportService.exportSafetyReport(
        mockIncidents,
        mockHazards,
        reportOptions
      );

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-report-.*\.pdf/);
      expect(mockPrint.printToFileAsync).toHaveBeenCalled();
    });

    it('should export comprehensive safety report to JSON', async () => {
      const reportOptions: ExportOptions = {
        format: 'json',
      };

      const result = await exportService.exportSafetyReport(
        mockIncidents,
        mockHazards,
        reportOptions
      );

      expect(result.success).toBe(true);
      expect(result.fileName).toMatch(/safety-report-.*\.json/);

      const writtenContent = JSON.parse(
        (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1]
      );

      expect(writtenContent.incidents).toHaveLength(3);
      expect(writtenContent.hazards).toHaveLength(2);
      expect(writtenContent.generatedAt).toBeDefined();
      expect(writtenContent.totalIncidents).toBe(3);
      expect(writtenContent.totalHazards).toBe(2);
    });
  });

  describe('File Management', () => {
    it('should list exported files', async () => {
      const mockFiles = ['export1.pdf', 'export2.csv', 'export3.json'];
      mockFileSystem.readDirectoryAsync.mockResolvedValue(mockFiles);

      mockFileSystem.getInfoAsync.mockImplementation((uri: string) => {
        const fileName = uri.split('/').pop() || '';
        return Promise.resolve({
          exists: true,
          uri,
          size: fileName.includes('pdf') ? 50000 : fileName.includes('csv') ? 10000 : 5000,
          modificationTime: Date.now() - Math.random() * 86400000, // Random time within last 24h
          isDirectory: false,
        });
      });

      const files = await exportService.listExportedFiles();

      expect(files).toHaveLength(3);
      expect(files[0]).toHaveProperty('name');
      expect(files[0]).toHaveProperty('uri');
      expect(files[0]).toHaveProperty('size');
      expect(files[0]).toHaveProperty('modified');

      // Should be sorted by modification time (newest first)
      expect(files[0].modified.getTime()).toBeGreaterThanOrEqual(files[1].modified.getTime());
    });

    it('should delete exported file', async () => {
      const result = await exportService.deleteExportedFile('test.pdf');

      expect(result).toBe(true);
      expect(mockFileSystem.deleteAsync).toHaveBeenCalledWith(
        'file:///documents/exports/test.pdf'
      );
    });

    it('should handle file deletion errors', async () => {
      mockFileSystem.deleteAsync.mockRejectedValueOnce(new Error('File not found'));

      const result = await exportService.deleteExportedFile('nonexistent.pdf');

      expect(result).toBe(false);
    });

    it('should clear all exported files', async () => {
      const mockFiles = [
        { name: 'file1.pdf', uri: 'file:///documents/exports/file1.pdf', size: 1000, modified: new Date() },
        { name: 'file2.csv', uri: 'file:///documents/exports/file2.csv', size: 2000, modified: new Date() },
      ];

      // Mock listExportedFiles
      const listSpy = jest.spyOn(exportService, 'listExportedFiles').mockResolvedValue(mockFiles);

      const result = await exportService.clearAllExports();

      expect(result).toBe(true);
      expect(mockFileSystem.deleteAsync).toHaveBeenCalledTimes(2);

      listSpy.mockRestore();
    });

    it('should get export statistics', async () => {
      const mockFiles = [
        { name: 'file1.pdf', uri: 'uri1', size: 1000, modified: new Date('2024-01-01') },
        { name: 'file2.csv', uri: 'uri2', size: 2000, modified: new Date('2024-01-02') },
        { name: 'file3.json', uri: 'uri3', size: 500, modified: new Date('2024-01-03') },
      ];

      const listSpy = jest.spyOn(exportService, 'listExportedFiles').mockResolvedValue(mockFiles);

      const stats = await exportService.getExportStatistics();

      expect(stats.totalFiles).toBe(3);
      expect(stats.totalSize).toBe(3500);
      expect(stats.oldestFile).toEqual(new Date('2024-01-01'));
      expect(stats.newestFile).toEqual(new Date('2024-01-03'));

      listSpy.mockRestore();
    });

    it('should handle empty export directory statistics', async () => {
      const listSpy = jest.spyOn(exportService, 'listExportedFiles').mockResolvedValue([]);

      const stats = await exportService.getExportStatistics();

      expect(stats.totalFiles).toBe(0);
      expect(stats.totalSize).toBe(0);
      expect(stats.oldestFile).toBeNull();
      expect(stats.newestFile).toBeNull();

      listSpy.mockRestore();
    });
  });

  describe('File Sharing', () => {
    it('should share file successfully', async () => {
      const fileUri = 'file:///documents/exports/test.pdf';
      const fileName = 'test.pdf';

      const result = await exportService.shareFile(fileUri, fileName);

      expect(result).toBe(true);
      expect(mockSharing.shareAsync).toHaveBeenCalledWith(fileUri, {
        mimeType: 'application/pdf',
        dialogTitle: 'Share test.pdf',
      });
    });

    it('should handle sharing when not available', async () => {
      mockSharing.isAvailableAsync.mockResolvedValueOnce(false);

      const result = await exportService.shareFile('test.pdf', 'test.pdf');

      expect(result).toBe(false);
      expect(mockSharing.shareAsync).not.toHaveBeenCalled();
    });

    it('should handle sharing errors', async () => {
      mockSharing.shareAsync.mockRejectedValueOnce(new Error('Sharing failed'));

      const result = await exportService.shareFile('test.pdf', 'test.pdf');

      expect(result).toBe(false);
    });

    it('should determine correct MIME types', () => {
      // Test through shareFile method
      const testCases = [
        { fileName: 'test.pdf', expectedMime: 'application/pdf' },
        { fileName: 'test.csv', expectedMime: 'text/csv' },
        { fileName: 'test.json', expectedMime: 'application/json' },
        { fileName: 'test.unknown', expectedMime: 'application/octet-stream' },
      ];

      testCases.forEach(({ fileName, expectedMime }) => {
        exportService.shareFile(`file://${fileName}`, fileName);
        expect(mockSharing.shareAsync).toHaveBeenCalledWith(
          `file://${fileName}`,
          expect.objectContaining({ mimeType: expectedMime })
        );
      });
    });
  });

  describe('Error Handling', () => {
    it('should handle unsupported export format', async () => {
      const invalidOptions: ExportOptions = {
        format: 'unsupported' as any,
      };

      const result = await exportService.exportIncidents(mockIncidents, invalidOptions);

      expect(result.success).toBe(false);
      expect(result.error).toContain('Unsupported format');
    });

    it('should handle file system errors during export', async () => {
      mockFileSystem.writeAsStringAsync.mockRejectedValueOnce(
        new Error('Insufficient storage')
      );

      const result = await exportService.exportIncidents(mockIncidents, { format: 'json' });

      expect(result.success).toBe(false);
      expect(result.error).toBe('Insufficient storage');
    });

    it('should handle PDF generation errors', async () => {
      mockPrint.printToFileAsync.mockRejectedValueOnce(
        new Error('PDF generation failed')
      );

      const result = await exportService.exportIncidents(mockIncidents, { format: 'pdf' });

      expect(result.success).toBe(false);
      expect(result.error).toBe('PDF generation failed');
    });

    it('should handle file listing errors', async () => {
      mockFileSystem.readDirectoryAsync.mockRejectedValueOnce(
        new Error('Directory access denied')
      );

      const files = await exportService.listExportedFiles();

      expect(files).toEqual([]);
    });
  });

  describe('Data Processing', () => {
    it('should properly escape CSV special characters', async () => {
      const incidentsWithSpecialChars = [
        {
          ...mockIncidents[0],
          description: 'Description with "quotes" and, commas',
        },
      ];

      const result = await exportService.exportIncidents(incidentsWithSpecialChars, {
        format: 'csv',
      });

      expect(result.success).toBe(true);

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      expect(csvContent).toContain('"Description with ""quotes"" and, commas"');
    });

    it('should include media counts in CSV export', async () => {
      const result = await exportService.exportIncidents(mockIncidents, {
        format: 'csv',
      });

      expect(result.success).toBe(true);

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      expect(csvContent).toContain('Photos Count');
      expect(csvContent).toContain('Videos Count');
      expect(csvContent).toContain('2'); // Photos count for first incident
      expect(csvContent).toContain('1'); // Videos count for first incident
    });

    it('should format dates correctly in exports', async () => {
      const result = await exportService.exportIncidents(mockIncidents, {
        format: 'csv',
      });

      expect(result.success).toBe(true);

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      expect(csvContent).toContain('1/15/2024'); // US date format
    });

    it('should handle incidents without location data', async () => {
      const result = await exportService.exportIncidents(mockIncidents, {
        format: 'csv',
      });

      expect(result.success).toBe(true);

      const csvContent = (mockFileSystem.writeAsStringAsync as jest.Mock).mock.calls[0][1];
      // Should handle null location gracefully
      expect(csvContent).toContain(',,'); // Empty location fields for incident without location
    });
  });

  describe('Performance and Resource Management', () => {
    it('should handle large datasets efficiently', async () => {
      const largeIncidents = Array.from({ length: 1000 }, (_, i) => ({
        ...mockIncidents[0],
        id: `large-${i}`,
        description: `Large incident ${i}`,
      }));

      const startTime = Date.now();

      const result = await exportService.exportIncidents(largeIncidents, {
        format: 'json',
      });

      const endTime = Date.now();
      const duration = endTime - startTime;

      expect(result.success).toBe(true);
      expect(duration).toBeLessThan(5000); // Should complete within 5 seconds
    });

    it('should clean up temporary files after PDF export', async () => {
      const result = await exportService.exportIncidents(mockIncidents, {
        format: 'pdf',
      });

      expect(result.success).toBe(true);
      expect(mockFileSystem.moveAsync).toHaveBeenCalled();
      expect(mockFileSystem.deleteAsync).not.toHaveBeenCalled(); // PDF temp file should be moved, not deleted
    });

    it('should handle concurrent export operations', async () => {
      const exportPromises = [
        exportService.exportIncidents(mockIncidents, { format: 'json' }),
        exportService.exportHazards(mockHazards, { format: 'csv' }),
        exportService.exportSafetyReport(mockIncidents, mockHazards, { format: 'json' }),
      ];

      const results = await Promise.all(exportPromises);

      results.forEach(result => {
        expect(result.success).toBe(true);
      });

      expect(mockFileSystem.writeAsStringAsync).toHaveBeenCalledTimes(3);
    });
  });

  describe('Service Lifecycle', () => {
    it('should destroy service properly', async () => {
      const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

      await exportService.destroy();

      expect(consoleSpy).toHaveBeenCalledWith('Export service destroyed');

      consoleSpy.mockRestore();
    });
  });
});

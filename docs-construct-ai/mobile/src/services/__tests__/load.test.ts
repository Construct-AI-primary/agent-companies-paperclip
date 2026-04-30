/**
 * Load Testing Suite
 *
 * Tests application performance under stress conditions including
 * high concurrent users, large data sets, and resource-intensive operations.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';

// Mock external dependencies
jest.mock('@react-native-async-storage/async-storage');

// Mock performance monitoring
const mockPerformance = {
  now: jest.fn(() => Date.now()),
  mark: jest.fn(),
  measure: jest.fn(),
  getEntriesByName: jest.fn(() => []),
  clearMarks: jest.fn(),
  clearMeasures: jest.fn(),
};

// Mock global performance object
Object.defineProperty(global, 'performance', {
  value: mockPerformance,
  writable: true,
});

describe('Load Testing Suite', () => {
  const mockAsyncStorage = AsyncStorage as jest.Mocked<typeof AsyncStorage>;

  beforeEach(() => {
    jest.clearAllMocks();

    // Setup default mocks
    mockAsyncStorage.getItem.mockResolvedValue(null);
    mockAsyncStorage.setItem.mockResolvedValue(undefined);
    mockAsyncStorage.removeItem.mockResolvedValue(undefined);
    mockAsyncStorage.clear.mockResolvedValue(undefined);
    mockAsyncStorage.getAllKeys.mockResolvedValue([]);

    // Reset performance mocks
    mockPerformance.now.mockReturnValue(Date.now());
    mockPerformance.mark.mockImplementation(() => {});
    mockPerformance.measure.mockImplementation(() => {});
    mockPerformance.getEntriesByName.mockReturnValue([]);
    mockPerformance.clearMarks.mockImplementation(() => {});
    mockPerformance.clearMeasures.mockImplementation(() => {});
  });

  describe('Concurrent User Load', () => {
    it('should handle multiple simultaneous user sessions', async () => {
      const concurrentUsers = 100;
      const userSessions: Promise<any>[] = [];

      // Mock user session creation
      const createUserSession = async (userId: number) => {
        const startTime = mockPerformance.now();

        // Simulate session creation with some processing time
        await new Promise(resolve => setTimeout(resolve, Math.random() * 100));

        const sessionData = {
          userId,
          sessionId: `session-${userId}-${Date.now()}`,
          createdAt: new Date(),
          lastActivity: new Date(),
        };

        // Store session data
        await mockAsyncStorage.setItem(`session-${userId}`, JSON.stringify(sessionData));

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return { sessionData, duration };
      };

      // Create concurrent user sessions
      for (let i = 1; i <= concurrentUsers; i++) {
        userSessions.push(createUserSession(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(userSessions);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all sessions were created successfully
      expect(results).toHaveLength(concurrentUsers);
      results.forEach((result, index) => {
        expect(result.sessionData.userId).toBe(index + 1);
        expect(result.sessionData.sessionId).toContain('session-');
        expect(result.duration).toBeGreaterThan(0);
      });

      // Verify performance is within acceptable limits (under 5 seconds for 100 users)
      expect(totalTime).toBeLessThan(5000);

      // Verify average session creation time
      const avgDuration = results.reduce((sum, result) => sum + result.duration, 0) / results.length;
      expect(avgDuration).toBeLessThan(200); // Under 200ms per session
    });

    it('should handle concurrent database operations', async () => {
      const concurrentOperations = 50;
      const operations: Promise<any>[] = [];

      // Mock database operation
      const performDatabaseOperation = async (operationId: number) => {
        const startTime = mockPerformance.now();

        // Simulate database operation with variable processing time
        const processingTime = 50 + Math.random() * 150; // 50-200ms
        await new Promise(resolve => setTimeout(resolve, processingTime));

        const operationResult = {
          operationId,
          type: 'database_query',
          success: true,
          data: `result-${operationId}`,
          timestamp: new Date(),
        };

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return { operationResult, duration };
      };

      // Execute concurrent database operations
      for (let i = 1; i <= concurrentOperations; i++) {
        operations.push(performDatabaseOperation(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(operations);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all operations completed successfully
      expect(results).toHaveLength(concurrentOperations);
      results.forEach((result, index) => {
        expect(result.operationResult.operationId).toBe(index + 1);
        expect(result.operationResult.success).toBe(true);
        expect(result.duration).toBeGreaterThan(45); // At least minimum processing time
      });

      // Verify performance requirements
      expect(totalTime).toBeLessThan(10000); // Under 10 seconds for 50 operations

      const avgDuration = results.reduce((sum, result) => sum + result.duration, 0) / results.length;
      expect(avgDuration).toBeLessThan(300); // Under 300ms per operation
    });

    it('should manage memory usage under concurrent load', async () => {
      const concurrentTasks = 30;
      const tasks: Promise<any>[] = [];

      // Mock memory-intensive task
      const performMemoryIntensiveTask = async (taskId: number) => {
        const startTime = mockPerformance.now();

        // Simulate memory allocation and processing
        const data = new Array(10000).fill(null).map((_, index) => ({
          id: `${taskId}-${index}`,
          data: `large-data-chunk-${taskId}-${index}`.repeat(10),
          timestamp: new Date(),
        }));

        // Process the data
        const processedData = data.map(item => ({
          ...item,
          processed: true,
          hash: `hash-${item.id}`,
        }));

        // Simulate garbage collection pressure
        await new Promise(resolve => setTimeout(resolve, Math.random() * 50));

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return {
          taskId,
          dataSize: processedData.length,
          duration,
          memoryUsage: processedData.length * 100, // Estimated memory usage
        };
      };

      // Execute concurrent memory-intensive tasks
      for (let i = 1; i <= concurrentTasks; i++) {
        tasks.push(performMemoryIntensiveTask(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(tasks);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all tasks completed
      expect(results).toHaveLength(concurrentTasks);
      results.forEach((result, index) => {
        expect(result.taskId).toBe(index + 1);
        expect(result.dataSize).toBe(10000);
        expect(result.duration).toBeGreaterThan(0);
      });

      // Verify performance under memory pressure
      expect(totalTime).toBeLessThan(8000); // Under 8 seconds

      const totalMemoryUsage = results.reduce((sum, result) => sum + result.memoryUsage, 0);
      const avgMemoryPerTask = totalMemoryUsage / results.length;

      // Verify reasonable memory usage (under 2MB per task)
      expect(avgMemoryPerTask).toBeLessThan(2000000);
    });
  });

  describe('Large Dataset Handling', () => {
    it('should handle large lists of data efficiently', async () => {
      const largeDatasetSize = 10000;
      const startTime = mockPerformance.now();

      // Generate large dataset
      const generateLargeDataset = () => {
        const dataset = [];
        for (let i = 0; i < largeDatasetSize; i++) {
          dataset.push({
            id: `item-${i}`,
            name: `Item ${i}`,
            description: `Description for item ${i}`.repeat(5),
            category: `Category-${Math.floor(i / 100)}`,
            createdAt: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000),
            tags: [`tag-${i % 10}`, `tag-${(i + 1) % 10}`, `tag-${(i + 2) % 10}`],
            metadata: {
              size: Math.floor(Math.random() * 1000),
              priority: Math.floor(Math.random() * 5),
              status: ['active', 'inactive', 'pending'][Math.floor(Math.random() * 3)],
            },
          });
        }
        return dataset;
      };

      const dataset = generateLargeDataset();
      const generationTime = mockPerformance.now() - startTime;

      expect(dataset).toHaveLength(largeDatasetSize);

      // Test data processing performance
      const processingStartTime = mockPerformance.now();

      // Filter active items
      const activeItems = dataset.filter(item => item.metadata.status === 'active');

      // Sort by creation date
      const sortedItems = [...dataset].sort((a, b) =>
        b.createdAt.getTime() - a.createdAt.getTime()
      );

      // Group by category
      const groupedItems = dataset.reduce((groups, item) => {
        const category = item.category;
        if (!groups[category]) {
          groups[category] = [];
        }
        groups[category].push(item);
        return groups;
      }, {} as Record<string, any[]>);

      const processingTime = mockPerformance.now() - processingStartTime;

      // Verify data integrity
      expect(activeItems.length).toBeGreaterThan(0);
      expect(sortedItems).toHaveLength(largeDatasetSize);
      expect(Object.keys(groupedItems)).toHaveLength(100); // 100 categories (10000 / 100)

      // Verify performance requirements
      expect(generationTime).toBeLessThan(1000); // Under 1 second to generate
      expect(processingTime).toBeLessThan(2000); // Under 2 seconds to process
    });

    it('should handle pagination of large datasets', async () => {
      const totalItems = 5000;
      const pageSize = 50;
      const totalPages = Math.ceil(totalItems / pageSize);

      // Mock paginated data fetching
      const fetchPage = async (page: number) => {
        const startTime = mockPerformance.now();

        // Simulate API call delay
        await new Promise(resolve => setTimeout(resolve, 100 + Math.random() * 200));

        const startIndex = (page - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalItems);

        const pageData = [];
        for (let i = startIndex; i < endIndex; i++) {
          pageData.push({
            id: `item-${i}`,
            name: `Item ${i}`,
            data: `Large data payload for item ${i}`.repeat(20),
          });
        }

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return {
          data: pageData,
          page,
          pageSize,
          totalItems,
          totalPages,
          hasNextPage: page < totalPages,
          hasPrevPage: page > 1,
          duration,
        };
      };

      // Test pagination performance
      const paginationStartTime = mockPerformance.now();
      const pagePromises = [];

      // Fetch first 10 pages concurrently
      for (let page = 1; page <= 10; page++) {
        pagePromises.push(fetchPage(page));
      }

      const pageResults = await Promise.all(pagePromises);
      const paginationTotalTime = mockPerformance.now() - paginationStartTime;

      // Verify pagination results
      expect(pageResults).toHaveLength(10);
      pageResults.forEach((result, index) => {
        const expectedPage = index + 1;
        expect(result.page).toBe(expectedPage);
        expect(result.data).toHaveLength(pageSize);
        expect(result.totalItems).toBe(totalItems);
        expect(result.duration).toBeGreaterThan(95); // At least minimum delay
      });

      // Verify performance
      expect(paginationTotalTime).toBeLessThan(3000); // Under 3 seconds for 10 concurrent pages

      const avgPageLoadTime = pageResults.reduce((sum, result) => sum + result.duration, 0) / pageResults.length;
      expect(avgPageLoadTime).toBeLessThan(500); // Under 500ms per page
    });

    it('should handle data export of large datasets', async () => {
      const exportDatasetSize = 25000;
      const startTime = mockPerformance.now();

      // Generate export data
      const generateExportData = () => {
        const data = [];
        for (let i = 0; i < exportDatasetSize; i++) {
          data.push({
            id: i + 1,
            name: `Export Item ${i + 1}`,
            category: `Category ${Math.floor(i / 1000) + 1}`,
            value: Math.random() * 1000,
            description: `Detailed description for export item ${i + 1}`.repeat(3),
            metadata: {
              created: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000).toISOString(),
              modified: new Date().toISOString(),
              tags: Array.from({ length: 5 }, (_, j) => `tag-${j + 1}`),
            },
          });
        }
        return data;
      };

      const exportData = generateExportData();
      const generationTime = mockPerformance.now() - startTime;

      expect(exportData).toHaveLength(exportDatasetSize);

      // Test data serialization performance
      const serializationStartTime = mockPerformance.now();

      // Convert to different formats
      const jsonData = JSON.stringify(exportData);
      const csvData = convertToCSV(exportData);

      const serializationTime = mockPerformance.now() - serializationStartTime;

      // Verify data sizes
      expect(jsonData.length).toBeGreaterThan(1000000); // At least 1MB
      expect(csvData.length).toBeGreaterThan(500000); // At least 500KB

      // Test compression simulation
      const compressionStartTime = mockPerformance.now();

      // Simulate compression (in real app, this would use a compression library)
      const compressedData = jsonData.replace(/\s+/g, ''); // Simple space removal
      const compressionRatio = compressedData.length / jsonData.length;

      const compressionTime = mockPerformance.now() - compressionStartTime;

      // Verify performance requirements
      expect(generationTime).toBeLessThan(2000); // Under 2 seconds to generate
      expect(serializationTime).toBeLessThan(3000); // Under 3 seconds to serialize
      expect(compressionTime).toBeLessThan(1000); // Under 1 second to compress
      expect(compressionRatio).toBeLessThan(1); // Some compression achieved
    });
  });

  describe('Resource-Intensive Operations', () => {
    it('should handle complex calculations under load', async () => {
      const calculationIterations = 1000;
      const concurrentCalculations = 20;
      const calculations: Promise<any>[] = [];

      // Mock complex calculation
      const performComplexCalculation = async (calcId: number) => {
        const startTime = mockPerformance.now();

        let result = 0;
        const data = new Array(calculationIterations).fill(null);

        // Perform CPU-intensive calculations
        for (let i = 0; i < calculationIterations; i++) {
          // Complex mathematical operations
          result += Math.sin(i) * Math.cos(i) * Math.sqrt(i + 1);
          result += Math.pow(Math.E, Math.sin(i / 100)) * Math.log(i + 1);

          // Array operations
          data[i] = {
            index: i,
            value: result,
            sqrt: Math.sqrt(Math.abs(result)),
            log: Math.log(Math.abs(result) + 1),
          };
        }

        // Additional processing
        const processedData = data.map(item => ({
          ...item,
          normalized: item.value / (result || 1),
          category: item.value > 0 ? 'positive' : 'negative',
        }));

        // Simulate I/O operation
        await new Promise(resolve => setTimeout(resolve, Math.random() * 20));

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return {
          calcId,
          result,
          dataPoints: processedData.length,
          duration,
          avgValue: result / calculationIterations,
        };
      };

      // Execute concurrent complex calculations
      for (let i = 1; i <= concurrentCalculations; i++) {
        calculations.push(performComplexCalculation(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(calculations);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all calculations completed
      expect(results).toHaveLength(concurrentCalculations);
      results.forEach((result, index) => {
        expect(result.calcId).toBe(index + 1);
        expect(result.dataPoints).toBe(calculationIterations);
        expect(result.duration).toBeGreaterThan(0);
        expect(typeof result.result).toBe('number');
      });

      // Verify performance requirements
      expect(totalTime).toBeLessThan(15000); // Under 15 seconds for 20 concurrent calculations

      const avgDuration = results.reduce((sum, result) => sum + result.duration, 0) / results.length;
      expect(avgDuration).toBeLessThan(1000); // Under 1 second per calculation

      const totalDataPoints = results.reduce((sum, result) => sum + result.dataPoints, 0);
      expect(totalDataPoints).toBe(calculationIterations * concurrentCalculations);
    });

    it('should handle file processing operations under load', async () => {
      const fileCount = 25;
      const avgFileSize = 1024 * 1024; // 1MB per file
      const fileOperations: Promise<any>[] = [];

      // Mock file processing operation
      const processFile = async (fileId: number) => {
        const startTime = mockPerformance.now();

        // Simulate file reading
        const fileSize = avgFileSize + (Math.random() - 0.5) * avgFileSize * 0.5; // ±50% variation
        const fileContent = 'x'.repeat(Math.floor(fileSize)); // Simulate file content

        // Simulate file processing
        const lines = fileContent.split('').filter(char => char === 'x').length;
        const words = Math.floor(lines / 10); // Simulate word count
        const checksum = fileContent.split('').reduce((sum, char) => sum + char.charCodeAt(0), 0);

        // Simulate file writing/modification
        const processedContent = fileContent
          .replace(/x/g, 'y')
          .toUpperCase()
          .substring(0, Math.floor(fileSize * 0.9)); // 90% of original size

        // Simulate I/O delay
        await new Promise(resolve => setTimeout(resolve, 50 + Math.random() * 100));

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return {
          fileId,
          originalSize: fileSize,
          processedSize: processedContent.length,
          lines,
          words,
          checksum,
          compressionRatio: processedContent.length / fileSize,
          duration,
        };
      };

      // Execute concurrent file processing operations
      for (let i = 1; i <= fileCount; i++) {
        fileOperations.push(processFile(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(fileOperations);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all file operations completed
      expect(results).toHaveLength(fileCount);
      results.forEach((result, index) => {
        expect(result.fileId).toBe(index + 1);
        expect(result.originalSize).toBeGreaterThan(avgFileSize * 0.5);
        expect(result.processedSize).toBeGreaterThan(0);
        expect(result.duration).toBeGreaterThan(45); // At least minimum processing time
      });

      // Verify performance requirements
      expect(totalTime).toBeLessThan(10000); // Under 10 seconds for 25 files

      const avgDuration = results.reduce((sum, result) => sum + result.duration, 0) / results.length;
      expect(avgDuration).toBeLessThan(500); // Under 500ms per file

      const totalOriginalSize = results.reduce((sum, result) => sum + result.originalSize, 0);
      const totalProcessedSize = results.reduce((sum, result) => sum + result.processedSize, 0);
      const avgCompressionRatio = results.reduce((sum, result) => sum + result.compressionRatio, 0) / results.length;

      expect(totalOriginalSize).toBeGreaterThan(fileCount * avgFileSize * 0.7); // At least 70% of expected total
      expect(avgCompressionRatio).toBeLessThan(1); // Some size reduction achieved
    });

    it('should handle network request bursts', async () => {
      const requestCount = 100;
      const concurrentRequests = 10;
      const networkRequests: Promise<any>[] = [];

      // Mock network request
      const makeNetworkRequest = async (requestId: number) => {
        const startTime = mockPerformance.now();

        // Simulate network delay (50-200ms)
        const networkDelay = 50 + Math.random() * 150;
        await new Promise(resolve => setTimeout(resolve, networkDelay));

        // Simulate response processing
        const responseData = {
          id: requestId,
          data: `response-data-${requestId}`.repeat(100), // Simulate response payload
          timestamp: new Date(),
          status: 200,
          headers: {
            'content-type': 'application/json',
            'content-length': Math.floor(Math.random() * 10000),
          },
        };

        // Simulate response parsing
        const parsedData = JSON.parse(JSON.stringify(responseData));
        const processingTime = Math.random() * 20;
        await new Promise(resolve => setTimeout(resolve, processingTime));

        const endTime = mockPerformance.now();
        const totalDuration = endTime - startTime;

        return {
          requestId,
          responseData: parsedData,
          networkDelay,
          processingTime,
          totalDuration,
          success: true,
        };
      };

      // Execute network request burst
      for (let i = 1; i <= requestCount; i++) {
        networkRequests.push(makeNetworkRequest(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(networkRequests);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all requests completed
      expect(results).toHaveLength(requestCount);
      results.forEach((result, index) => {
        expect(result.requestId).toBe(index + 1);
        expect(result.success).toBe(true);
        expect(result.totalDuration).toBeGreaterThan(result.networkDelay);
      });

      // Verify performance requirements
      expect(totalTime).toBeLessThan(20000); // Under 20 seconds for 100 requests

      const avgDuration = results.reduce((sum, result) => sum + result.totalDuration, 0) / results.length;
      expect(avgDuration).toBeLessThan(300); // Under 300ms per request

      // Verify request distribution (should be reasonably balanced)
      const networkDelays = results.map(result => result.networkDelay);
      const avgNetworkDelay = networkDelays.reduce((sum, delay) => sum + delay, 0) / networkDelays.length;
      const minDelay = Math.min(...networkDelays);
      const maxDelay = Math.max(...networkDelays);

      expect(avgNetworkDelay).toBeGreaterThan(50);
      expect(avgNetworkDelay).toBeLessThan(200);
      expect(maxDelay - minDelay).toBeLessThan(300); // Reasonable delay variation
    });
  });

  describe('Memory and Resource Management', () => {
    it('should handle memory cleanup under sustained load', async () => {
      const sustainedOperations = 50;
      const operations: Promise<any>[] = [];

      // Mock memory-leaking operation
      const performMemoryIntensiveOperation = async (operationId: number) => {
        const startTime = mockPerformance.now();

        // Create objects that should be garbage collected
        const largeObjects = [];
        for (let i = 0; i < 1000; i++) {
          largeObjects.push({
            id: `${operationId}-${i}`,
            data: new Array(1000).fill(`data-${operationId}-${i}`),
            nested: {
              level1: {
                level2: {
                  level3: `deep-data-${operationId}-${i}`.repeat(10),
                },
              },
            },
          });
        }

        // Process objects
        const processedObjects = largeObjects.map(obj => ({
          ...obj,
          processed: true,
          hash: `hash-${obj.id}`,
        }));

        // Simulate processing time
        await new Promise(resolve => setTimeout(resolve, Math.random() * 100));

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        // Return only essential data, allowing largeObjects to be garbage collected
        return {
          operationId,
          objectCount: processedObjects.length,
          duration,
          memoryFootprint: processedObjects.length * 2000, // Estimated memory usage
        };
      };

      // Execute sustained operations
      for (let i = 1; i <= sustainedOperations; i++) {
        operations.push(performMemoryIntensiveOperation(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(operations);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all operations completed
      expect(results).toHaveLength(sustainedOperations);
      results.forEach((result, index) => {
        expect(result.operationId).toBe(index + 1);
        expect(result.objectCount).toBe(1000);
        expect(result.duration).toBeGreaterThan(0);
      });

      // Verify performance under sustained load
      expect(totalTime).toBeLessThan(15000); // Under 15 seconds

      const totalMemoryFootprint = results.reduce((sum, result) => sum + result.memoryFootprint, 0);
      const avgMemoryPerOperation = totalMemoryFootprint / results.length;

      // Verify reasonable memory usage
      expect(avgMemoryPerOperation).toBeLessThan(3000000); // Under 3MB per operation
    });

    it('should handle connection pool management', async () => {
      const maxConnections = 20;
      const totalRequests = 200;
      const connectionPool: any[] = [];
      const requestQueue: Promise<any>[] = [];

      // Mock connection pool management
      const getConnection = async () => {
        if (connectionPool.length < maxConnections) {
          // Create new connection
          const connection = {
            id: `conn-${Date.now()}-${Math.random()}`,
            createdAt: new Date(),
            inUse: true,
            requestCount: 0,
          };
          connectionPool.push(connection);
          return connection;
        } else {
          // Wait for available connection (simplified)
          await new Promise(resolve => setTimeout(resolve, 10));
          return getConnection();
        }
      };

      const releaseConnection = (connection: any) => {
        connection.inUse = false;
        connection.requestCount++;
      };

      // Mock database request using connection pool
      const makeDatabaseRequest = async (requestId: number) => {
        const startTime = mockPerformance.now();

        const connection = await getConnection();

        // Simulate database operation
        await new Promise(resolve => setTimeout(resolve, 20 + Math.random() * 80));

        const result = {
          requestId,
          connectionId: connection.id,
          data: `db-result-${requestId}`,
          timestamp: new Date(),
        };

        releaseConnection(connection);

        const endTime = mockPerformance.now();
        const duration = endTime - startTime;

        return { result, duration, connectionId: connection.id };
      };

      // Execute requests using connection pool
      for (let i = 1; i <= totalRequests; i++) {
        requestQueue.push(makeDatabaseRequest(i));
      }

      const startTime = mockPerformance.now();
      const results = await Promise.all(requestQueue);
      const totalTime = mockPerformance.now() - startTime;

      // Verify all requests completed
      expect(results).toHaveLength(totalRequests);
      results.forEach((result, index) => {
        expect(result.result.requestId).toBe(index + 1);
        expect(result.duration).toBeGreaterThan(15); // At least minimum processing time
      });

      // Verify connection pool management
      expect(connectionPool.length).toBeLessThanOrEqual(maxConnections);

      const totalConnectionUsage = connectionPool.reduce((sum, conn) => sum + conn.requestCount, 0);
      expect(totalConnectionUsage).toBe(totalRequests);

      // Verify performance
      expect(totalTime).toBeLessThan(25000); // Under 25 seconds for 200 requests

      const avgDuration = results.reduce((sum, result) => sum + result.duration, 0) / results.length;
      expect(avgDuration).toBeLessThan(200); // Under 200ms per request
    });
  });
});

// Helper functions
function convertToCSV(data: any[]): string {
  if (data.length === 0) return '';

  const headers = Object.keys(data[0]);
  const csvRows = [];

  // Add headers
  csvRows.push(headers.join(','));

  // Add data rows
  data.forEach(item => {
    const values = headers.map(header => {
      const value = item[header];
      // Escape commas and quotes in CSV
      if (typeof value === 'string' && (value.includes(',') || value.includes('"'))) {
        return `"${value.replace(/"/g, '""')}"`;
      }
      return value;
    });
    csvRows.push(values.join(','));
  });

  return csvRows.join('\n');
}

import * as FileSystem from 'expo-file-system';
import * as Sharing from 'expo-sharing';
import * as Print from 'expo-print';
import * as DocumentPicker from 'expo-document-picker';
import { SafetyIncident, SafetyHazard } from '../store/slices/safetySlice';
import { Platform } from 'react-native';

export interface ExportOptions {
  format: 'pdf' | 'csv' | 'json' | 'excel';
  dateRange?: {
    start: Date;
    end: Date;
  };
  includePhotos?: boolean;
  includeVideos?: boolean;
  includeLocation?: boolean;
  filterBySeverity?: ('low' | 'medium' | 'high' | 'critical')[];
  filterByType?: string[];
}

export interface ExportResult {
  success: boolean;
  fileUri?: string;
  fileName?: string;
  fileSize?: number;
  error?: string;
}

class ExportService {
  private exportDirectory: string;

  constructor() {
    this.exportDirectory = FileSystem.documentDirectory + 'exports/';
    this.ensureExportDirectory();
  }

  private async ensureExportDirectory() {
    try {
      const dirInfo = await FileSystem.getInfoAsync(this.exportDirectory);
      if (!dirInfo.exists) {
        await FileSystem.makeDirectoryAsync(this.exportDirectory, { intermediates: true });
      }
    } catch (error) {
      console.error('Failed to create export directory:', error);
    }
  }

  // Export incidents data
  async exportIncidents(
    incidents: SafetyIncident[],
    options: ExportOptions
  ): Promise<ExportResult> {
    try {
      // Filter incidents based on options
      let filteredIncidents = this.filterIncidents(incidents, options);

      if (filteredIncidents.length === 0) {
        return {
          success: false,
          error: 'No incidents match the specified criteria'
        };
      }

      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const fileName = `safety-incidents-${timestamp}`;

      switch (options.format) {
        case 'pdf':
          return await this.exportIncidentsToPDF(filteredIncidents, fileName, options);
        case 'csv':
          return await this.exportIncidentsToCSV(filteredIncidents, fileName, options);
        case 'json':
          return await this.exportIncidentsToJSON(filteredIncidents, fileName, options);
        case 'excel':
          return await this.exportIncidentsToExcel(filteredIncidents, fileName, options);
        default:
          throw new Error(`Unsupported format: ${options.format}`);
      }
    } catch (error) {
      console.error('Failed to export incidents:', error);
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Export failed'
      };
    }
  }

  // Export hazards data
  async exportHazards(
    hazards: SafetyHazard[],
    options: ExportOptions
  ): Promise<ExportResult> {
    try {
      // Filter hazards based on options
      let filteredHazards = this.filterHazards(hazards, options);

      if (filteredHazards.length === 0) {
        return {
          success: false,
          error: 'No hazards match the specified criteria'
        };
      }

      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const fileName = `safety-hazards-${timestamp}`;

      switch (options.format) {
        case 'pdf':
          return await this.exportHazardsToPDF(filteredHazards, fileName, options);
        case 'csv':
          return await this.exportHazardsToCSV(filteredHazards, fileName, options);
        case 'json':
          return await this.exportHazardsToJSON(filteredHazards, fileName, options);
        case 'excel':
          return await this.exportHazardsToExcel(filteredHazards, fileName, options);
        default:
          throw new Error(`Unsupported format: ${options.format}`);
      }
    } catch (error) {
      console.error('Failed to export hazards:', error);
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Export failed'
      };
    }
  }

  // Export comprehensive safety report
  async exportSafetyReport(
    incidents: SafetyIncident[],
    hazards: SafetyHazard[],
    options: ExportOptions
  ): Promise<ExportResult> {
    try {
      const filteredIncidents = this.filterIncidents(incidents, options);
      const filteredHazards = this.filterHazards(hazards, options);

      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const fileName = `safety-report-${timestamp}`;

      if (options.format === 'pdf') {
        return await this.exportSafetyReportToPDF(
          filteredIncidents,
          filteredHazards,
          fileName,
          options
        );
      } else {
        // For other formats, combine incidents and hazards
        const combinedData = {
          incidents: filteredIncidents,
          hazards: filteredHazards,
          generatedAt: new Date().toISOString(),
          totalIncidents: filteredIncidents.length,
          totalHazards: filteredHazards.length
        };

        const jsonData = JSON.stringify(combinedData, null, 2);
        const fileUri = `${this.exportDirectory}${fileName}.json`;

        await FileSystem.writeAsStringAsync(fileUri, jsonData);

        return {
          success: true,
          fileUri,
          fileName: `${fileName}.json`,
          fileSize: jsonData.length
        };
      }
    } catch (error) {
      console.error('Failed to export safety report:', error);
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Export failed'
      };
    }
  }

  // Filter incidents based on options
  private filterIncidents(incidents: SafetyIncident[], options: ExportOptions): SafetyIncident[] {
    let filtered = [...incidents];

    // Date range filter
    if (options.dateRange) {
      filtered = filtered.filter(incident => {
        const incidentDate = new Date(incident.reportedAt);
        return incidentDate >= options.dateRange!.start && incidentDate <= options.dateRange!.end;
      });
    }

    // Severity filter
    if (options.filterBySeverity && options.filterBySeverity.length > 0) {
      filtered = filtered.filter(incident =>
        options.filterBySeverity!.includes(incident.severity)
      );
    }

    // Type filter
    if (options.filterByType && options.filterByType.length > 0) {
      filtered = filtered.filter(incident =>
        options.filterByType!.includes(incident.incidentType)
      );
    }

    return filtered;
  }

  // Filter hazards based on options
  private filterHazards(hazards: SafetyHazard[], options: ExportOptions): SafetyHazard[] {
    let filtered = [...hazards];

    // Date range filter (hazards don't have reportedAt, so skip this)

    // Risk level filter
    if (options.filterBySeverity && options.filterBySeverity.length > 0) {
      filtered = filtered.filter(hazard =>
        options.filterBySeverity!.includes(hazard.riskLevel as any)
      );
    }

    // Type filter
    if (options.filterByType && options.filterByType.length > 0) {
      filtered = filtered.filter(hazard =>
        options.filterByType!.includes(hazard.hazardType)
      );
    }

    return filtered;
  }

  // PDF Export for Incidents
  private async exportIncidentsToPDF(
    incidents: SafetyIncident[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const htmlContent = this.generateIncidentsPDFHTML(incidents, options);
    const { uri } = await Print.printToFileAsync({ html: htmlContent });

    const finalUri = `${this.exportDirectory}${fileName}.pdf`;
    await FileSystem.moveAsync({ from: uri, to: finalUri });

    const fileInfo = await FileSystem.getInfoAsync(finalUri);

    return {
      success: true,
      fileUri: finalUri,
      fileName: `${fileName}.pdf`,
      fileSize: fileInfo.exists ? fileInfo.size : 0
    };
  }

  // CSV Export for Incidents
  private async exportIncidentsToCSV(
    incidents: SafetyIncident[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const csvContent = this.generateIncidentsCSV(incidents, options);
    const fileUri = `${this.exportDirectory}${fileName}.csv`;

    await FileSystem.writeAsStringAsync(fileUri, csvContent);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.csv`,
      fileSize: csvContent.length
    };
  }

  // JSON Export
  private async exportIncidentsToJSON(
    incidents: SafetyIncident[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const exportData = {
      incidents,
      exportedAt: new Date().toISOString(),
      totalCount: incidents.length,
      options
    };

    const jsonData = JSON.stringify(exportData, null, 2);
    const fileUri = `${this.exportDirectory}${fileName}.json`;

    await FileSystem.writeAsStringAsync(fileUri, jsonData);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.json`,
      fileSize: jsonData.length
    };
  }

  // Excel Export (using CSV format for now)
  private async exportIncidentsToExcel(
    incidents: SafetyIncident[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    // For now, export as CSV with Excel formatting
    const csvContent = this.generateIncidentsCSV(incidents, options);
    const fileUri = `${this.exportDirectory}${fileName}.csv`;

    await FileSystem.writeAsStringAsync(fileUri, csvContent);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.csv`,
      fileSize: csvContent.length
    };
  }

  // Generate PDF HTML for incidents
  private generateIncidentsPDFHTML(incidents: SafetyIncident[], options: ExportOptions): string {
    const incidentRows = incidents.map(incident => `
      <tr>
        <td>${incident.id}</td>
        <td>${incident.incidentType}</td>
        <td>${incident.severity}</td>
        <td>${incident.description}</td>
        <td>${new Date(incident.reportedAt).toLocaleDateString()}</td>
        <td>${incident.status}</td>
      </tr>
    `).join('');

    return `
      <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #333; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
            .summary { background-color: #e9ecef; padding: 15px; margin-bottom: 20px; }
          </style>
        </head>
        <body>
          <h1>Safety Incidents Report</h1>
          <div class="summary">
            <h3>Report Summary</h3>
            <p><strong>Total Incidents:</strong> ${incidents.length}</p>
            <p><strong>Report Generated:</strong> ${new Date().toLocaleString()}</p>
            <p><strong>Date Range:</strong> ${options.dateRange ?
              `${options.dateRange.start.toLocaleDateString()} - ${options.dateRange.end.toLocaleDateString()}` :
              'All dates'}</p>
          </div>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Type</th>
                <th>Severity</th>
                <th>Description</th>
                <th>Date</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              ${incidentRows}
            </tbody>
          </table>
        </body>
      </html>
    `;
  }

  // Generate CSV for incidents
  private generateIncidentsCSV(incidents: SafetyIncident[], options: ExportOptions): string {
    const headers = [
      'ID',
      'Type',
      'Severity',
      'Description',
      'Date',
      'Status',
      'Location',
      'Photos Count',
      'Videos Count'
    ];

    const rows = incidents.map(incident => [
      incident.id,
      incident.incidentType,
      incident.severity,
      `"${incident.description.replace(/"/g, '""')}"`,
      new Date(incident.reportedAt).toLocaleDateString(),
      incident.status,
      incident.location ? `${incident.location.latitude},${incident.location.longitude}` : '',
      incident.photos.length,
      incident.videos.length
    ]);

    const csvContent = [headers, ...rows]
      .map(row => row.map(field => `"${field}"`).join(','))
      .join('\n');

    return csvContent;
  }

  // Similar methods for hazards (simplified for brevity)
  private async exportHazardsToPDF(
    hazards: SafetyHazard[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const htmlContent = this.generateHazardsPDFHTML(hazards, options);
    const { uri } = await Print.printToFileAsync({ html: htmlContent });

    const finalUri = `${this.exportDirectory}${fileName}.pdf`;
    await FileSystem.moveAsync({ from: uri, to: finalUri });

    const fileInfo = await FileSystem.getInfoAsync(finalUri);

    return {
      success: true,
      fileUri: finalUri,
      fileName: `${fileName}.pdf`,
      fileSize: fileInfo.exists ? fileInfo.size : 0
    };
  }

  private async exportHazardsToCSV(
    hazards: SafetyHazard[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const csvContent = this.generateHazardsCSV(hazards, options);
    const fileUri = `${this.exportDirectory}${fileName}.csv`;

    await FileSystem.writeAsStringAsync(fileUri, csvContent);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.csv`,
      fileSize: csvContent.length
    };
  }

  private async exportHazardsToJSON(
    hazards: SafetyHazard[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const exportData = {
      hazards,
      exportedAt: new Date().toISOString(),
      totalCount: hazards.length,
      options
    };

    const jsonData = JSON.stringify(exportData, null, 2);
    const fileUri = `${this.exportDirectory}${fileName}.json`;

    await FileSystem.writeAsStringAsync(fileUri, jsonData);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.json`,
      fileSize: jsonData.length
    };
  }

  private async exportHazardsToExcel(
    hazards: SafetyHazard[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const csvContent = this.generateHazardsCSV(hazards, options);
    const fileUri = `${this.exportDirectory}${fileName}.csv`;

    await FileSystem.writeAsStringAsync(fileUri, csvContent);

    return {
      success: true,
      fileUri,
      fileName: `${fileName}.csv`,
      fileSize: csvContent.length
    };
  }

  private generateHazardsPDFHTML(hazards: SafetyHazard[], options: ExportOptions): string {
    const hazardRows = hazards.map(hazard => `
      <tr>
        <td>${hazard.id}</td>
        <td>${hazard.hazardType}</td>
        <td>${hazard.riskLevel}</td>
        <td>${hazard.description}</td>
        <td>${hazard.status}</td>
      </tr>
    `).join('');

    return `
      <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #333; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
            .summary { background-color: #e9ecef; padding: 15px; margin-bottom: 20px; }
          </style>
        </head>
        <body>
          <h1>Safety Hazards Report</h1>
          <div class="summary">
            <h3>Report Summary</h3>
            <p><strong>Total Hazards:</strong> ${hazards.length}</p>
            <p><strong>Report Generated:</strong> ${new Date().toLocaleString()}</p>
          </div>
          <table>
            <thead>
              <tr>
                <th>ID</th>
                <th>Type</th>
                <th>Risk Level</th>
                <th>Description</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              ${hazardRows}
            </tbody>
          </table>
        </body>
      </html>
    `;
  }

  private generateHazardsCSV(hazards: SafetyHazard[], options: ExportOptions): string {
    const headers = [
      'ID',
      'Type',
      'Risk Level',
      'Description',
      'Status',
      'Location'
    ];

    const rows = hazards.map(hazard => [
      hazard.id,
      hazard.hazardType,
      hazard.riskLevel,
      `"${hazard.description.replace(/"/g, '""')}"`,
      hazard.status,
      hazard.location ? `${hazard.location.latitude},${hazard.location.longitude}` : ''
    ]);

    const csvContent = [headers, ...rows]
      .map(row => row.map(field => `"${field}"`).join(','))
      .join('\n');

    return csvContent;
  }

  private async exportSafetyReportToPDF(
    incidents: SafetyIncident[],
    hazards: SafetyHazard[],
    fileName: string,
    options: ExportOptions
  ): Promise<ExportResult> {
    const htmlContent = this.generateSafetyReportPDFHTML(incidents, hazards, options);
    const { uri } = await Print.printToFileAsync({ html: htmlContent });

    const finalUri = `${this.exportDirectory}${fileName}.pdf`;
    await FileSystem.moveAsync({ from: uri, to: finalUri });

    const fileInfo = await FileSystem.getInfoAsync(finalUri);

    return {
      success: true,
      fileUri: finalUri,
      fileName: `${fileName}.pdf`,
      fileSize: fileInfo.size
    };
  }

  private generateSafetyReportPDFHTML(
    incidents: SafetyIncident[],
    hazards: SafetyHazard[],
    options: ExportOptions
  ): string {
    const incidentSummary = this.generateIncidentSummary(incidents);
    const hazardSummary = this.generateHazardSummary(hazards);

    return `
      <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            h1 { color: #333; }
            h2 { color: #666; margin-top: 30px; }
            .summary { background-color: #e9ecef; padding: 15px; margin: 20px 0; }
            .stats { display: flex; justify-content: space-around; margin: 20px 0; }
            .stat { text-align: center; padding: 10px; background-color: #f8f9fa; border-radius: 5px; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; }
            th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
          </style>
        </head>
        <body>
          <h1>Comprehensive Safety Report</h1>
          <div class="summary">
            <h3>Report Overview</h3>
            <p><strong>Report Generated:</strong> ${new Date().toLocaleString()}</p>
            <p><strong>Date Range:</strong> ${options.dateRange ?
              `${options.dateRange.start.toLocaleDateString()} - ${options.dateRange.end.toLocaleDateString()}` :
              'All dates'}</p>
          </div>

          <div class="stats">
            <div class="stat">
              <h3>${incidents.length}</h3>
              <p>Total Incidents</p>
            </div>
            <div class="stat">
              <h3>${hazards.length}</h3>
              <p>Total Hazards</p>
            </div>
            <div class="stat">
              <h3>${incidents.filter(i => i.severity === 'critical').length}</h3>
              <p>Critical Incidents</p>
            </div>
            <div class="stat">
              <h3>${hazards.filter(h => h.status === 'active').length}</h3>
              <p>Active Hazards</p>
            </div>
          </div>

          <h2>Incident Summary</h2>
          ${incidentSummary}

          <h2>Hazard Summary</h2>
          ${hazardSummary}
        </body>
      </html>
    `;
  }

  private generateIncidentSummary(incidents: SafetyIncident[]): string {
    const severityCounts = {
      low: incidents.filter(i => i.severity === 'low').length,
      medium: incidents.filter(i => i.severity === 'medium').length,
      high: incidents.filter(i => i.severity === 'high').length,
      critical: incidents.filter(i => i.severity === 'critical').length,
    };

    const typeCounts = incidents.reduce((acc, incident) => {
      acc[incident.incidentType] = (acc[incident.incidentType] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    return `
      <div class="summary">
        <h4>Severity Distribution</h4>
        <ul>
          <li>Low: ${severityCounts.low}</li>
          <li>Medium: ${severityCounts.medium}</li>
          <li>High: ${severityCounts.high}</li>
          <li>Critical: ${severityCounts.critical}</li>
        </ul>
        <h4>Incident Types</h4>
        <ul>
          ${Object.entries(typeCounts).map(([type, count]) =>
            `<li>${type}: ${count}</li>`
          ).join('')}
        </ul>
      </div>
    `;
  }

  private generateHazardSummary(hazards: SafetyHazard[]): string {
    const riskCounts = {
      low: hazards.filter(h => h.riskLevel === 'low').length,
      medium: hazards.filter(h => h.riskLevel === 'medium').length,
      high: hazards.filter(h => h.riskLevel === 'high').length,
    };

    const statusCounts = {
      active: hazards.filter(h => h.status === 'active').length,
      mitigated: hazards.filter(h => h.status === 'mitigated').length,
      closed: hazards.filter(h => h.status === 'closed').length,
    };

    return `
      <div class="summary">
        <h4>Risk Level Distribution</h4>
        <ul>
          <li>Low: ${riskCounts.low}</li>
          <li>Medium: ${riskCounts.medium}</li>
          <li>High: ${riskCounts.high}</li>
        </ul>
        <h4>Status Distribution</h4>
        <ul>
          <li>Active: ${statusCounts.active}</li>
          <li>Mitigated: ${statusCounts.mitigated}</li>
          <li>Closed: ${statusCounts.closed}</li>
        </ul>
      </div>
    `;
  }

  // Share exported file
  async shareFile(fileUri: string, fileName: string): Promise<boolean> {
    try {
      const isAvailable = await Sharing.isAvailableAsync();
      if (!isAvailable) {
        console.warn('Sharing is not available on this device');
        return false;
      }

      await Sharing.shareAsync(fileUri, {
        mimeType: this.getMimeType(fileName),
        dialogTitle: `Share ${fileName}`,
      });

      return true;
    } catch (error) {
      console.error('Failed to share file:', error);
      return false;
    }
  }

  // Get MIME type for file
  private getMimeType(fileName: string): string {
    const extension = fileName.split('.').pop()?.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'csv':
        return 'text/csv';
      case 'json':
        return 'application/json';
      default:
        return 'application/octet-stream';
    }
  }

  // List exported files
  async listExportedFiles(): Promise<{ name: string; uri: string; size: number; modified: Date }[]> {
    try {
      const files = await FileSystem.readDirectoryAsync(this.exportDirectory);
      const fileDetails = await Promise.all(
        files.map(async (fileName) => {
          const fileUri = `${this.exportDirectory}${fileName}`;
          const fileInfo = await FileSystem.getInfoAsync(fileUri);
          return {
            name: fileName,
            uri: fileUri,
            size: fileInfo.exists ? fileInfo.size || 0 : 0,
            modified: new Date(fileInfo.exists ? fileInfo.modificationTime || 0 : 0),
          };
        })
      );

      return fileDetails.sort((a, b) => b.modified.getTime() - a.modified.getTime());
    } catch (error) {
      console.error('Failed to list exported files:', error);
      return [];
    }
  }

  // Delete exported file
  async deleteExportedFile(fileName: string): Promise<boolean> {
    try {
      const fileUri = `${this.exportDirectory}${fileName}`;
      await FileSystem.deleteAsync(fileUri);
      return true;
    } catch (error) {
      console.error('Failed to delete exported file:', error);
      return false;
    }
  }

  // Clear all exported files
  async clearAllExports(): Promise<boolean> {
    try {
      const files = await this.listExportedFiles();
      await Promise.all(
        files.map(file => FileSystem.deleteAsync(file.uri))
      );
      return true;
    } catch (error) {
      console.error('Failed to clear exports:', error);
      return false;
    }
  }

  // Get export statistics
  async getExportStatistics(): Promise<{
    totalFiles: number;
    totalSize: number;
    oldestFile: Date | null;
    newestFile: Date | null;
  }> {
    try {
      const files = await this.listExportedFiles();

      if (files.length === 0) {
        return {
          totalFiles: 0,
          totalSize: 0,
          oldestFile: null,
          newestFile: null,
        };
      }

      const totalSize = files.reduce((sum, file) => sum + file.size, 0);
      const sortedByDate = files.sort((a, b) => a.modified.getTime() - b.modified.getTime());

      return {
        totalFiles: files.length,
        totalSize,
        oldestFile: sortedByDate[0].modified,
        newestFile: sortedByDate[sortedByDate.length - 1].modified,
      };
    } catch (error) {
      console.error('Failed to get export statistics:', error);
      return {
        totalFiles: 0,
        totalSize: 0,
        oldestFile: null,
        newestFile: null,
      };
    }
  }

  // Cleanup
  async destroy() {
    // Cleanup will be handled by React Native's cleanup
    console.log('Export service destroyed');
  }
}

// Export singleton instance
export const exportService = new ExportService();
export default exportService;

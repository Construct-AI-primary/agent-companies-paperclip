/**
 * MeasurementCanvas.jsx
 * Core measurement canvas component for cross-discipline measurement platform
 * Provides interactive drawing overlay, measurement tools, and scale calibration
 */

import React, { useState, useRef, useEffect, useCallback } from 'react';
import PropTypes from 'prop-types';
import './MeasurementCanvas.css';

const MeasurementCanvas = ({
  drawing,
  discipline,
  measurementMode = 'manual',
  scale,
  tools = [],
  onMeasurement,
  onValidation,
  width = 800,
  height = 600
}) => {
  const canvasRef = useRef(null);
  const overlayRef = useRef(null);
  const [measurements, setMeasurements] = useState([]);
  const [currentTool, setCurrentTool] = useState(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [scaleCalibration, setScaleCalibration] = useState(scale);

  // Initialize canvas and overlay
  useEffect(() => {
    const canvas = canvasRef.current;
    const overlay = overlayRef.current;
    if (!canvas || !overlay) return;

    const ctx = canvas.getContext('2d');
    const overlayCtx = overlay.getContext('2d');

    // Set canvas dimensions
    canvas.width = width;
    canvas.height = height;
    overlay.width = width;
    overlay.height = height;

    // Load and render drawing
    loadDrawing(drawing, ctx);

    // Initialize overlay
    clearOverlay(overlayCtx);
  }, [drawing, width, height]);

  // Load drawing onto canvas
  const loadDrawing = useCallback(async (drawing, ctx) => {
    if (!drawing) return;

    try {
      // Handle different drawing formats (DWG, DXF, PDF, etc.)
      if (drawing.type === 'dwg' || drawing.type === 'dxf') {
        await renderCADDrawing(drawing, ctx);
      } else if (drawing.type === 'pdf') {
        await renderPDFDrawing(drawing, ctx);
      } else if (drawing.type === 'image') {
        await renderImageDrawing(drawing, ctx);
      }
    } catch (error) {
      console.error('Error loading drawing:', error);
      renderErrorState(ctx, 'Failed to load drawing');
    }
  }, []);

  // Render CAD drawing
  const renderCADDrawing = async (drawing, ctx) => {
    // Implementation for CAD rendering
    // This would integrate with CAD libraries or services
    ctx.fillStyle = '#f0f0f0';
    ctx.fillRect(0, 0, width, height);
    ctx.fillStyle = '#666';
    ctx.font = '16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('CAD Drawing Preview', width / 2, height / 2);
    ctx.fillText(`File: ${drawing.filename}`, width / 2, height / 2 + 30);
  };

  // Render PDF drawing
  const renderPDFDrawing = async (drawing, ctx) => {
    // Implementation for PDF rendering
    ctx.fillStyle = '#fff';
    ctx.fillRect(0, 0, width, height);
    ctx.fillStyle = '#666';
    ctx.font = '16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('PDF Drawing Preview', width / 2, height / 2);
  };

  // Render image drawing
  const renderImageDrawing = async (drawing, ctx) => {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload = () => {
        // Calculate scaling to fit canvas while maintaining aspect ratio
        const scale = Math.min(width / img.width, height / img.height);
        const scaledWidth = img.width * scale;
        const scaledHeight = img.height * scale;
        const x = (width - scaledWidth) / 2;
        const y = (height - scaledHeight) / 2;

        ctx.drawImage(img, x, y, scaledWidth, scaledHeight);
        resolve();
      };
      img.onerror = reject;
      img.src = drawing.dataUrl || drawing.url;
    });
  };

  // Render error state
  const renderErrorState = (ctx, message) => {
    ctx.fillStyle = '#ffebee';
    ctx.fillRect(0, 0, width, height);
    ctx.fillStyle = '#c62828';
    ctx.font = '16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText(message, width / 2, height / 2);
  };

  // Clear overlay
  const clearOverlay = (ctx) => {
    ctx.clearRect(0, 0, width, height);
  };

  // Handle mouse/touch events
  const handlePointerDown = (e) => {
    if (!currentTool) return;

    setIsDrawing(true);
    const rect = overlayRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    startMeasurement(x, y);
  };

  const handlePointerMove = (e) => {
    if (!isDrawing || !currentTool) return;

    const rect = overlayRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    updateMeasurement(x, y);
  };

  const handlePointerUp = (e) => {
    if (!isDrawing) return;

    setIsDrawing(false);
    const rect = overlayRef.current.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    completeMeasurement(x, y);
  };

  // Measurement operations
  const startMeasurement = (x, y) => {
    const newMeasurement = {
      id: generateId(),
      type: currentTool.type,
      discipline: discipline,
      points: [{ x, y }],
      scale: scaleCalibration,
      timestamp: new Date(),
      status: 'draft'
    };

    setMeasurements(prev => [...prev, newMeasurement]);
  };

  const updateMeasurement = (x, y) => {
    setMeasurements(prev => prev.map(m =>
      m.id === prev[prev.length - 1].id
        ? { ...m, points: [...m.points, { x, y }] }
        : m
    ));

    renderOverlay();
  };

  const completeMeasurement = (x, y) => {
    const completedMeasurement = measurements[measurements.length - 1];
    if (!completedMeasurement) return;

    // Calculate measurement value based on tool type
    const calculatedValue = calculateMeasurementValue(completedMeasurement, scaleCalibration);

    const finalMeasurement = {
      ...completedMeasurement,
      points: [...completedMeasurement.points, { x, y }],
      value: calculatedValue,
      status: 'completed'
    };

    // Update measurements state
    setMeasurements(prev => prev.map(m =>
      m.id === finalMeasurement.id ? finalMeasurement : m
    ));

    // Notify parent component
    onMeasurement && onMeasurement(finalMeasurement);

    // Trigger validation if in auto mode
    if (measurementMode === 'automatic' || measurementMode === 'semi-automatic') {
      validateMeasurement(finalMeasurement);
    }
  };

  // Calculate measurement value
  const calculateMeasurementValue = (measurement, scale) => {
    if (!scale || !scale.pixelsPerUnit) return null;

    switch (measurement.type) {
      case 'distance':
        if (measurement.points.length >= 2) {
          const distance = calculateDistance(measurement.points[0], measurement.points[measurement.points.length - 1]);
          return distance / scale.pixelsPerUnit;
        }
        break;

      case 'area':
        if (measurement.points.length >= 3) {
          return calculateArea(measurement.points) / Math.pow(scale.pixelsPerUnit, 2);
        }
        break;

      case 'angle':
        if (measurement.points.length >= 3) {
          return calculateAngle(measurement.points[0], measurement.points[1], measurement.points[2]);
        }
        break;

      default:
        return null;
    }
  };

  // Utility calculation functions
  const calculateDistance = (point1, point2) => {
    return Math.sqrt(Math.pow(point2.x - point1.x, 2) + Math.pow(point2.y - point1.y, 2));
  };

  const calculateArea = (points) => {
    let area = 0;
    for (let i = 0; i < points.length; i++) {
      const j = (i + 1) % points.length;
      area += points[i].x * points[j].y;
      area -= points[j].x * points[i].y;
    }
    return Math.abs(area) / 2;
  };

  const calculateAngle = (vertex, point1, point2) => {
    const vector1 = { x: point1.x - vertex.x, y: point1.y - vertex.y };
    const vector2 = { x: point2.x - vertex.x, y: point2.y - vertex.y };

    const dot = vector1.x * vector2.x + vector1.y * vector2.y;
    const mag1 = Math.sqrt(vector1.x * vector1.x + vector1.y * vector1.y);
    const mag2 = Math.sqrt(vector2.x * vector2.x + vector2.y * vector2.y);

    const cosAngle = dot / (mag1 * mag2);
    return Math.acos(Math.max(-1, Math.min(1, cosAngle))) * (180 / Math.PI);
  };

  // Render overlay with measurements
  const renderOverlay = () => {
    const ctx = overlayRef.current?.getContext('2d');
    if (!ctx) return;

    clearOverlay(ctx);

    // Render completed measurements
    measurements.forEach(measurement => {
      if (measurement.status === 'completed') {
        renderMeasurement(ctx, measurement);
      }
    });

    // Render current in-progress measurement
    if (isDrawing && measurements.length > 0) {
      const current = measurements[measurements.length - 1];
      renderMeasurement(ctx, current, true);
    }
  };

  // Render individual measurement
  const renderMeasurement = (ctx, measurement, isPreview = false) => {
    ctx.strokeStyle = isPreview ? '#007bff' : '#28a745';
    ctx.lineWidth = isPreview ? 2 : 3;
    ctx.setLineDash(isPreview ? [5, 5] : []);

    // Draw measurement geometry
    if (measurement.points.length >= 2) {
      ctx.beginPath();
      ctx.moveTo(measurement.points[0].x, measurement.points[0].y);

      for (let i = 1; i < measurement.points.length; i++) {
        ctx.lineTo(measurement.points[i].x, measurement.points[i].y);
      }

      if (measurement.points.length > 2 && measurement.type === 'area') {
        ctx.closePath();
        ctx.fillStyle = 'rgba(40, 167, 69, 0.1)';
        ctx.fill();
      }

      ctx.stroke();
    }

    // Draw measurement label
    if (measurement.value && !isPreview) {
      const lastPoint = measurement.points[measurement.points.length - 1];
      ctx.fillStyle = '#fff';
      ctx.strokeStyle = '#000';
      ctx.lineWidth = 1;
      ctx.setLineDash([]);

      const label = formatMeasurementLabel(measurement);
      const labelWidth = ctx.measureText(label).width;

      ctx.strokeRect(lastPoint.x + 10, lastPoint.y - 20, labelWidth + 8, 20);
      ctx.fillRect(lastPoint.x + 10, lastPoint.y - 20, labelWidth + 8, 20);

      ctx.fillStyle = '#000';
      ctx.textAlign = 'left';
      ctx.fillText(label, lastPoint.x + 14, lastPoint.y - 5);
    }

    ctx.setLineDash([]);
  };

  // Format measurement label
  const formatMeasurementLabel = (measurement) => {
    if (!measurement.value) return '';

    const unit = getDisciplineUnit(discipline, measurement.type);
    return `${measurement.value.toFixed(2)} ${unit}`;
  };

  // Get appropriate unit for discipline and measurement type
  const getDisciplineUnit = (discipline, type) => {
    const unitMap = {
      '00850': { distance: 'm', area: 'm²', angle: '°' }, // Civil
      '00860': { distance: 'mm', area: 'mm²', angle: '°' }, // Electrical
      '00870': { distance: 'mm', area: 'mm²', angle: '°' }, // Mechanical
      '00872': { distance: 'mm', area: 'mm²', angle: '°' }  // Structural
    };

    return unitMap[discipline]?.[type] || 'units';
  };

  // Validate measurement
  const validateMeasurement = async (measurement) => {
    try {
      // Basic validation
      const isValid = validateMeasurementGeometry(measurement);

      if (isValid) {
        // Call external validation service
        const validationResult = await validateWithService(measurement);
        onValidation && onValidation(validationResult);
      }
    } catch (error) {
      console.error('Validation error:', error);
    }
  };

  // Basic geometry validation
  const validateMeasurementGeometry = (measurement) => {
    if (!measurement.points || measurement.points.length < 2) return false;

    // Check for minimum distance between points
    for (let i = 0; i < measurement.points.length - 1; i++) {
      const distance = calculateDistance(measurement.points[i], measurement.points[i + 1]);
      if (distance < 5) return false; // Minimum 5 pixels
    }

    return true;
  };

  // External validation service call
  const validateWithService = async (measurement) => {
    // This would call the measurement validation API
    return {
      measurementId: measurement.id,
      isValid: true,
      confidence: 0.95,
      suggestions: []
    };
  };

  // Generate unique ID
  const generateId = () => {
    return `measurement_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  };

  // Update overlay when measurements change
  useEffect(() => {
    renderOverlay();
  }, [measurements, isDrawing]);

  return (
    <div className="measurement-canvas-container">
      <div className="measurement-toolbar">
        {tools.map(tool => (
          <button
            key={tool.id}
            className={`tool-button ${currentTool?.id === tool.id ? 'active' : ''}`}
            onClick={() => setCurrentTool(tool)}
            title={tool.name}
          >
            <span className="tool-icon">{tool.icon}</span>
            <span className="tool-label">{tool.name}</span>
          </button>
        ))}
        <div className="scale-indicator">
          Scale: {scaleCalibration ? `${scaleCalibration.pixelsPerUnit} px/unit` : 'Not set'}
        </div>
      </div>

      <div className="canvas-wrapper">
        <canvas
          ref={canvasRef}
          className="measurement-canvas"
          width={width}
          height={height}
        />
        <canvas
          ref={overlayRef}
          className="measurement-overlay"
          width={width}
          height={height}
          onPointerDown={handlePointerDown}
          onPointerMove={handlePointerMove}
          onPointerUp={handlePointerUp}
          style={{ touchAction: 'none' }}
        />
      </div>

      <div className="measurement-info">
        <div className="measurement-count">
          Measurements: {measurements.filter(m => m.status === 'completed').length}
        </div>
        <div className="current-mode">
          Mode: {measurementMode} | Tool: {currentTool?.name || 'None'}
        </div>
      </div>
    </div>
  );
};

MeasurementCanvas.propTypes = {
  drawing: PropTypes.object,
  discipline: PropTypes.string.isRequired,
  measurementMode: PropTypes.oneOf(['manual', 'semi-automatic', 'automatic']),
  scale: PropTypes.object,
  tools: PropTypes.arrayOf(PropTypes.object),
  onMeasurement: PropTypes.func,
  onValidation: PropTypes.func,
  width: PropTypes.number,
  height: PropTypes.number
};

export default MeasurementCanvas;
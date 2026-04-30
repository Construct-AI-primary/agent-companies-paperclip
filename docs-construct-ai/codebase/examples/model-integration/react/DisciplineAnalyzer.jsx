import React, { useState, useEffect } from 'react';
import './DisciplineAnalyzer.css';

const DisciplineAnalyzer = () => {
    const [disciplines, setDisciplines] = useState([]);
    const [selectedDiscipline, setSelectedDiscipline] = useState('');
    const [query, setQuery] = useState('');
    const [response, setResponse] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');
    const [modelHealth, setModelHealth] = useState({});

    // API base URL
    const API_BASE = process.env.REACT_APP_API_BASE || 'http://localhost:3001';

    // Load available disciplines on component mount
    useEffect(() => {
        loadDisciplines();
    }, []);

    // Load model health when discipline changes
    useEffect(() => {
        if (selectedDiscipline) {
            loadModelHealth(selectedDiscipline);
        }
    }, [selectedDiscipline]);

    const loadDisciplines = async () => {
        try {
            const response = await fetch(`${API_BASE}/disciplines`);
            const data = await response.json();

            if (data.success) {
                setDisciplines(data.disciplines);
            } else {
                setError('Failed to load disciplines');
            }
        } catch (err) {
            setError('Failed to connect to API');
            console.error('Disciplines load error:', err);
        }
    };

    const loadModelHealth = async (discipline) => {
        try {
            const response = await fetch(`${API_BASE}/models/${discipline}/health`);
            const data = await response.json();
            setModelHealth(prev => ({ ...prev, [discipline]: data }));
        } catch (err) {
            console.error('Health check error:', err);
        }
    };

    const analyzeQuery = async () => {
        if (!selectedDiscipline || !query.trim()) {
            setError('Please select a discipline and enter a query');
            return;
        }

        setLoading(true);
        setError('');
        setResponse('');

        try {
            const response = await fetch(`${API_BASE}/generate/${selectedDiscipline}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    prompt: query,
                    maxLength: 512,
                    temperature: 0.7
                })
            });

            const data = await response.json();

            if (data.success) {
                setResponse(data.response);
            } else {
                setError(data.error || 'Analysis failed');
            }
        } catch (err) {
            setError('Failed to analyze query');
            console.error('Analysis error:', err);
        } finally {
            setLoading(false);
        }
    };

    const getHealthStatusColor = (discipline) => {
        const health = modelHealth[discipline];
        if (!health) return 'gray';
        if (health.loaded && health.status === 'healthy') return 'green';
        if (health.loaded) return 'yellow';
        return 'red';
    };

    const getHealthStatusText = (discipline) => {
        const health = modelHealth[discipline];
        if (!health) return 'Checking...';
        if (health.loaded && health.status === 'healthy') return 'Ready';
        if (health.loaded) return 'Loaded';
        return 'Not loaded';
    };

    return (
        <div className="discipline-analyzer">
            <div className="analyzer-header">
                <h2>AI Discipline Analysis</h2>
                <p>Get expert analysis from specialized AI models trained on construction disciplines</p>
            </div>

            <div className="analyzer-controls">
                <div className="control-group">
                    <label htmlFor="discipline-select">Select Discipline:</label>
                    <select
                        id="discipline-select"
                        value={selectedDiscipline}
                        onChange={(e) => setSelectedDiscipline(e.target.value)}
                        className="discipline-select"
                    >
                        <option value="">Choose a discipline...</option>
                        {disciplines.map(discipline => (
                            <option key={discipline} value={discipline}>
                                {discipline.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}
                            </option>
                        ))}
                    </select>

                    {selectedDiscipline && (
                        <div className="model-status">
                            <span
                                className="status-indicator"
                                style={{ backgroundColor: getHealthStatusColor(selectedDiscipline) }}
                            ></span>
                            <span className="status-text">
                                Model: {getHealthStatusText(selectedDiscipline)}
                            </span>
                        </div>
                    )}
                </div>

                <div className="control-group">
                    <label htmlFor="query-input">Query:</label>
                    <textarea
                        id="query-input"
                        value={query}
                        onChange={(e) => setQuery(e.target.value)}
                        placeholder="Describe your construction question or issue..."
                        className="query-input"
                        rows={4}
                    />
                </div>

                <button
                    onClick={analyzeQuery}
                    disabled={loading || !selectedDiscipline || !query.trim()}
                    className="analyze-button"
                >
                    {loading ? 'Analyzing...' : 'Analyze with AI'}
                </button>
            </div>

            {error && (
                <div className="error-message">
                    <strong>Error:</strong> {error}
                </div>
            )}

            {response && (
                <div className="response-section">
                    <h3>AI Analysis ({selectedDiscipline.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())})</h3>
                    <div className="response-content">
                        {response}
                    </div>
                    <div className="response-meta">
                        <small>Generated using specialized {selectedDiscipline} model</small>
                    </div>
                </div>
            )}

            <div className="available-disciplines">
                <h4>Available Disciplines ({disciplines.length})</h4>
                <div className="disciplines-grid">
                    {disciplines.map(discipline => (
                        <div
                            key={discipline}
                            className={`discipline-card ${selectedDiscipline === discipline ? 'selected' : ''}`}
                            onClick={() => setSelectedDiscipline(discipline)}
                        >
                            <div className="discipline-name">
                                {discipline.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}
                            </div>
                            <div
                                className="discipline-status"
                                style={{ backgroundColor: getHealthStatusColor(discipline) }}
                            ></div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
};

export default DisciplineAnalyzer;
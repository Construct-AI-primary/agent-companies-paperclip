#!/usr/bin/env node
/**
 * Node.js Discipline Model Service
 * API service for accessing LoRA-adapted Qwen models
 */

const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

class DisciplineModelService {
    constructor(modelDir = './models/trained-models') {
        this.modelDir = modelDir;
        this.pythonLoader = path.join(__dirname, 'python_discipline_loader.py');
        this.loadedModels = new Set();
    }

    /**
     * List all available disciplines
     */
    listAvailableDisciplines() {
        try {
            if (!fs.existsSync(this.modelDir)) {
                return [];
            }

            return fs.readdirSync(this.modelDir)
                .filter(dir => {
                    const fullPath = path.join(this.modelDir, dir);
                    return fs.statSync(fullPath).isDirectory() &&
                           fs.existsSync(path.join(fullPath, 'adapter_model.safetensors'));
                });
        } catch (error) {
            console.error('Error listing disciplines:', error);
            return [];
        }
    }

    /**
     * Load a discipline model
     */
    async loadModel(discipline) {
        return new Promise((resolve, reject) => {
            // Check if Python loader exists
            if (!fs.existsSync(this.pythonLoader)) {
                reject(new Error('Python loader not found'));
                return;
            }

            const python = spawn('python', [
                this.pythonLoader,
                '--load-only',
                '--discipline', discipline
            ], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: process.cwd()
            });

            let stdout = '';
            let stderr = '';

            python.stdout.on('data', (data) => {
                stdout += data.toString();
            });

            python.stderr.on('data', (data) => {
                stderr += data.toString();
            });

            python.on('close', (code) => {
                if (code === 0) {
                    this.loadedModels.add(discipline);
                    resolve({ success: true, message: stdout.trim() });
                } else {
                    reject(new Error(`Failed to load model: ${stderr.trim()}`));
                }
            });

            // Timeout after 5 minutes
            setTimeout(() => {
                python.kill('SIGTERM');
                reject(new Error('Model loading timeout'));
            }, 5 * 60 * 1000);
        });
    }

    /**
     * Generate response using discipline model
     */
    async generateResponse(discipline, prompt, options = {}) {
        const {
            maxLength = 512,
            temperature = 0.7,
            maxRetries = 3
        } = options;

        for (let attempt = 1; attempt <= maxRetries; attempt++) {
            try {
                // Ensure model is loaded
                if (!this.loadedModels.has(discipline)) {
                    await this.loadModel(discipline);
                }

                return await this._callPythonGenerator(discipline, prompt, {
                    maxLength,
                    temperature
                });

            } catch (error) {
                console.error(`Attempt ${attempt} failed:`, error.message);

                if (attempt === maxRetries) {
                    throw new Error(`Generation failed after ${maxRetries} attempts: ${error.message}`);
                }

                // Unload and retry
                this.loadedModels.delete(discipline);
                await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
            }
        }
    }

    /**
     * Call Python generator script
     */
    _callPythonGenerator(discipline, prompt, options) {
        return new Promise((resolve, reject) => {
            const python = spawn('python', [
                this.pythonLoader,
                '--generate-only',
                '--discipline', discipline,
                '--prompt', prompt,
                '--max-tokens', options.maxLength.toString(),
                '--temperature', options.temperature.toString()
            ], {
                stdio: ['pipe', 'pipe', 'pipe'],
                cwd: process.cwd()
            });

            let response = '';
            let errorOutput = '';

            python.stdout.on('data', (data) => {
                response += data.toString();
            });

            python.stderr.on('data', (data) => {
                errorOutput += data.toString();
            });

            python.on('close', (code) => {
                if (code === 0) {
                    resolve(response.trim());
                } else {
                    reject(new Error(`Python generation failed: ${errorOutput.trim()}`));
                }
            });

            // Timeout after 2 minutes
            setTimeout(() => {
                python.kill('SIGTERM');
                reject(new Error('Generation timeout'));
            }, 2 * 60 * 1000);
        });
    }

    /**
     * Unload model to free memory
     */
    unloadModel(discipline) {
        this.loadedModels.delete(discipline);
        // Note: Python process manages actual memory cleanup
    }

    /**
     * Get model health status
     */
    async getModelHealth(discipline) {
        try {
            if (!this.loadedModels.has(discipline)) {
                return { loaded: false, status: 'not_loaded' };
            }

            // Could implement actual health checks here
            return {
                loaded: true,
                status: 'healthy',
                lastUsed: new Date().toISOString()
            };
        } catch (error) {
            return {
                loaded: false,
                status: 'error',
                error: error.message
            };
        }
    }
}

// Express API Server
class DisciplineModelAPI {
    constructor(port = 3001) {
        this.app = express();
        this.port = port;
        this.modelService = new DisciplineModelService();

        this.setupMiddleware();
        this.setupRoutes();
    }

    setupMiddleware() {
        this.app.use(express.json({ limit: '10mb' }));
        this.app.use(express.urlencoded({ extended: true }));

        // CORS middleware
        this.app.use((req, res, next) => {
            res.header('Access-Control-Allow-Origin', '*');
            res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
            res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
            next();
        });
    }

    setupRoutes() {
        // Health check
        this.app.get('/health', (req, res) => {
            res.json({
                status: 'healthy',
                timestamp: new Date().toISOString(),
                service: 'discipline-model-api'
            });
        });

        // List available disciplines
        this.app.get('/disciplines', (req, res) => {
            try {
                const disciplines = this.modelService.listAvailableDisciplines();
                res.json({
                    success: true,
                    disciplines,
                    count: disciplines.length
                });
            } catch (error) {
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });

        // Load model
        this.app.post('/models/:discipline/load', async (req, res) => {
            try {
                const { discipline } = req.params;
                const result = await this.modelService.loadModel(discipline);

                res.json({
                    success: true,
                    discipline,
                    ...result
                });
            } catch (error) {
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });

        // Generate response
        this.app.post('/generate/:discipline', async (req, res) => {
            try {
                const { discipline } = req.params;
                const { prompt, maxLength = 512, temperature = 0.7 } = req.body;

                if (!prompt) {
                    return res.status(400).json({
                        success: false,
                        error: 'Prompt is required'
                    });
                }

                const response = await this.modelService.generateResponse(discipline, prompt, {
                    maxLength,
                    temperature
                });

                res.json({
                    success: true,
                    discipline,
                    prompt,
                    response,
                    timestamp: new Date().toISOString()
                });

            } catch (error) {
                console.error('Generation error:', error);
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });

        // Model health
        this.app.get('/models/:discipline/health', async (req, res) => {
            try {
                const { discipline } = req.params;
                const health = await this.modelService.getModelHealth(discipline);

                res.json({
                    success: true,
                    discipline,
                    ...health
                });
            } catch (error) {
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });

        // Unload model
        this.app.delete('/models/:discipline', (req, res) => {
            try {
                const { discipline } = req.params;
                this.modelService.unloadModel(discipline);

                res.json({
                    success: true,
                    message: `Model ${discipline} unloaded`
                });
            } catch (error) {
                res.status(500).json({
                    success: false,
                    error: error.message
                });
            }
        });
    }

    start() {
        this.app.listen(this.port, () => {
            console.log(`🚀 Discipline Model API listening on port ${this.port}`);
            console.log(`📚 Available disciplines: ${this.modelService.listAvailableDisciplines().join(', ')}`);
            console.log(`🏥 Health check: http://localhost:${this.port}/health`);
        });
    }
}

// CLI usage
if (require.main === module) {
    const args = process.argv.slice(2);

    if (args.includes('--serve')) {
        // Start API server
        const port = parseInt(args[args.indexOf('--port') + 1]) || 3001;
        const api = new DisciplineModelAPI(port);
        api.start();

    } else if (args.includes('--test')) {
        // Quick test
        const service = new DisciplineModelService();

        console.log('Available disciplines:', service.listAvailableDisciplines());

        // Test generation if discipline specified
        const disciplineIndex = args.indexOf('--discipline');
        if (disciplineIndex !== -1) {
            const discipline = args[disciplineIndex + 1];
            const prompt = 'Analyze this safety issue: Worker fell from scaffolding.';

            service.generateResponse(discipline, prompt)
                .then(response => {
                    console.log(`\nDiscipline: ${discipline}`);
                    console.log(`Prompt: ${prompt}`);
                    console.log(`Response: ${response}`);
                })
                .catch(error => {
                    console.error('Test failed:', error.message);
                });
        }

    } else {
        console.log('Usage:');
        console.log('  --serve [--port 3001]    Start API server');
        console.log('  --test [--discipline <name>]  Run quick test');
    }
}

module.exports = { DisciplineModelService, DisciplineModelAPI };
---
memory_layer: durable_knowledge
para_section: pages/codebase/workflows
gigabrain_tags: workflows, codebase, automation
documentation
openstinger_context: workflow-automation, process-management
last_updated: 2026-03-21
related_docs:
  - codebase/workflows/
  - disciplines/
---
# AI-Powered Auto-Detection Workflow Solution

## 🎯 Problem Statement

**Current Broken Workflow:**
```
User → Select Discipline (required) → Select Document Type (required) → Upload File → Generate Form
```

**Expected Smart Workflow:**
```
User → Upload File → AI Auto-Detects Discipline & Document Type → User Reviews/Corrects → Generate Form
```

## 🔧 Solution Implementation

### **Modified DocumentUploadModal.js Workflow**

#### **Phase 1: Upload First (No Prerequisites)**

```javascript
// REMOVE required discipline and document type selection from upload step
const DocumentUploadModal = ({ show, onHide, onFormGenerated, ...props }) => {
  const [uploadedFile, setUploadedFile] = useState(null);
  const [aiDetectedData, setAiDetectedData] = useState(null);
  const [userCorrectedData, setUserCorrectedData] = useState(null);
  
  // REMOVE: selectedDiscipline, selectedDocumentType as required fields
  // Instead, make them optional until after AI analysis
  
  const handleFileUpload = async (file) => {
    // Step 1: Upload and analyze file
    setUploadedFile(file);
    
    // Step 2: Send to AI for automatic detection
    const formData = new FormData();
    formData.append("file", file);
    formData.append("analyzeOnly", true); // Special flag for AI analysis only
    
    const response = await fetch("/api/process", {
      method: "POST",
      body: formData,
    });
    
    const aiAnalysis = await response.json();
    
    // Step 3: Extract AI-detected information
    const detected = {
      discipline: aiAnalysis.detectedDiscipline, // e.g., "02400" for Safety
      disciplineName: aiAnalysis.detectedDisciplineName, // "Safety"
      documentType: aiAnalysis.detectedDocumentType, // e.g., "RISK"
      documentTypeName: aiAnalysis.detectedDocumentTypeName, // "Risk Assessments"
      confidence: aiAnalysis.confidence, // 0.0 to 1.0
      reasoning: aiAnalysis.reasoning, // Why AI made this decision
      alternatives: aiAnalysis.alternatives || [] // Other possible classifications
    };
    
    setAiDetectedData(detected);
    
    // Step 4: Pre-populate correction form with AI suggestions
    setUserCorrectedData({
      discipline: detected.discipline,
      documentType: detected.documentType,
      confidence: detected.confidence
    });
  };
```

#### **Phase 2: AI Results Display & User Correction**

```javascript
// After file upload and AI analysis
return (
  <div>
    {/* Step 1: File Upload (No Prerequisites) */}
    {!uploadedFile && (
      <FileUploadZone 
        onFileUpload={handleFileUpload}
        supportedTypes={["pdf", "xlsx", "xls", "txt"]}
      />
    )}
    
    {/* Step 2: AI Analysis Results & User Correction */}
    {uploadedFile && aiDetectedData && !userConfirmed && (
      <AIDetectionResults
        file={uploadedFile}
        aiDetection={aiDetectedData}
        userCorrections={userCorrectedData}
        onCorrectionChange={setUserCorrectedData}
        disciplines={disciplines}
        documentTypes={documentTypes}
        onConfirm={handleConfirmCorrections}
        onRetry={handleRetry}
      />
    )}
    
    {/* Step 3: Final Generation */}
    {userConfirmed && (
      <FormGeneration 
        file={uploadedFile}
        correctedData={userCorrectedData}
        onGenerate={handleFormGeneration}
      />
    )}
  </div>
);
```

#### **Phase 3: AI Detection Results Component**

```javascript
const AIDetectionResults = ({ 
  file, 
  aiDetection, 
  userCorrections, 
  onCorrectionChange,
  disciplines,
  documentTypes,
  onConfirm,
  onRetry 
}) => {
  return (
    <div className="ai-detection-results">
      {/* File Info */}
      <div className="file-info">
        <h4>📄 {file.name}</h4>
        <p>Size: {(file.size / 1024 / 1024).toFixed(2)} MB</p>
      </div>
      
      {/* AI Detection Results */}
      <div className="ai-results">
        <h5>🤖 AI Analysis Results</h5>
        
        {/* Confidence Indicator */}
        <div className="confidence-indicator">
          <span>Confidence: {(aiDetection.confidence * 100).toFixed(1)}%</span>
          <div className="confidence-bar">
            <div 
              className="confidence-fill" 
              style={{width: `${aiDetection.confidence * 100}%`}}
            />
          </div>
        </div>
        
        {/* Detected Discipline */}
        <div className="detection-item">
          <label>🏢 Discipline:</label>
          <select
            value={userCorrections.discipline}
            onChange={(e) => {
              onCorrectionChange({
                ...userCorrections,
                discipline: e.target.value,
                documentType: "" // Reset document type when discipline changes
              });
            }}
          >
            {disciplines.map(discipline => (
              <option key={discipline.id} value={discipline.id}>
                {discipline.name}
              </option>
            ))}
          </select>
          
          {/* Show AI reasoning */}
          {aiDetection.reasoning && (
            <div className="ai-reasoning">
              <small>🤖 AI Reasoning: {aiDetection.reasoning}</small>
            </div>
          )}
        </div>
        
        {/* Detected Document Type */}
        <div className="detection-item">
          <label>📄 Document Type:</label>
          <select
            value={userCorrections.documentType}
            onChange={(e) => {
              onCorrectionChange({
                ...userCorrections,
                documentType: e.target.value
              });
            }}
            disabled={!userCorrections.discipline}
          >
            <option value="">Select document type...</option>
            {documentTypes
              .filter(dt => dt.discipline_code === 
                disciplines.find(d => d.id === userCorrections.discipline)?.code
              )
              .map(docType => (
                <option key={docType.document_type_code} value={docType.document_type_code}>
                  {docType.document_type_code.toUpperCase()} - {docType.document_type}
                </option>
              ))
            }
          </select>
        </div>
        
        {/* Alternative Suggestions */}
        {aiDetection.alternatives && aiDetection.alternatives.length > 0 && (
          <div className="alternatives">
            <h6>💡 Alternative Suggestions:</h6>
            {aiDetection.alternatives.map((alt, index) => (
              <button
                key={index}
                className="alternative-btn"
                onClick={() => {
                  onCorrectionChange({
                    ...userCorrections,
                    discipline: alt.discipline,
                    documentType: alt.documentType
                  });
                }}
              >
                {alt.disciplineName} → {alt.documentTypeName} 
                <small>({(alt.confidence * 100).toFixed(1)}%)</small>
              </button>
            ))}
          </div>
        )}
      </div>
      
      {/* Action Buttons */}
      <div className="action-buttons">
        <button 
          className="retry-btn"
          onClick={onRetry}
        >
          🔄 Try Again
        </button>
        <button 
          className="confirm-btn"
          onClick={onConfirm}
          disabled={!userCorrections.discipline || !userCorrections.documentType}
        >
          ✅ Confirm & Generate Form
        </button>
      </div>
    </div>
  );
};
```

### **Backend AI Enhancement**

#### **Enhanced `/api/process` Endpoint**

```javascript
// server/src/routes/process-routes.js
app.post('/api/process', upload.single('file'), async (req, res) => {
  try {
    const file = req.file;
    const { analyzeOnly } = req.body; // New flag for AI analysis only
    
    // Step 1: Extract and analyze document
    const analysis = await DocumentAnalysisService.analyzeDocument(file);
    
    // Step 2: AI-Powered Classification
    const classification = await AIClassificationService.classifyDocument({
      content: analysis.extractedText,
      fileName: file.originalname,
      fileType: file.mimetype,
      metadata: analysis.metadata
    });
    
    // Step 3: Return AI detection results (if analyzeOnly=true)
    if (analyzeOnly) {
      return res.json({
        success: true,
        detectedDiscipline: classification.discipline.id,
        detectedDisciplineName: classification.discipline.name,
        detectedDocumentType: classification.documentType.code,
        detectedDocumentTypeName: classification.documentType.name,
        confidence: classification.confidence,
        reasoning: classification.reasoning,
        alternatives: classification.alternatives || [],
        extractedText: analysis.extractedText,
        textExtraction: analysis.textExtraction
      });
    }
    
    // Step 4: Continue with full processing...
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});
```

#### **Enhanced AIClassificationService**

```javascript
class AIClassificationService {
  static async classifyDocument({ content, fileName, fileType, metadata }) {
    // Multi-step AI analysis
    
    // Step 1: Extract domain keywords
    const domainAnalysis = this.analyzeDomainKeywords(content);
    
    // Step 2: Detect document structure patterns
    const structureAnalysis = this.analyzeStructurePatterns(content);
    
    // Step 3: Match against known patterns
    const patternMatches = this.matchAgainstPatterns(content, fileName);
    
    // Step 4: Calculate confidence scores
    const disciplineScores = this.calculateDisciplineScores(domainAnalysis, patternMatches);
    const documentTypeScores = this.calculateDocumentTypeScores(structureAnalysis, patternMatches);
    
    // Step 5: Select best matches
    const bestDiscipline = this.selectBestMatch(disciplineScores);
    const bestDocumentType = this.selectBestMatch(documentTypeScores, bestDiscipline);
    
    return {
      discipline: bestDiscipline,
      documentType: bestDocumentType,
      confidence: Math.min(bestDiscipline.confidence, bestDocumentType.confidence),
      reasoning: this.generateReasoning(bestDiscipline, bestDocumentType, domainAnalysis),
      alternatives: this.generateAlternatives(disciplineScores, documentTypeScores),
      analysis: {
        domainAnalysis,
        structureAnalysis,
        patternMatches
      }
    };
  }
  
  static analyzeDomainKeywords(content) {
    const domainKeywords = {
      safety: ['safety', 'hse', 'health', 'risk', 'hazard', 'ppe', 'inspection', 'incident'],
      procurement: ['purchase', 'procurement', 'vendor', 'supplier', 'po', 'tender', 'rfq'],
      construction: ['construction', 'contractor', 'building', 'civil', 'structural', 'architectural'],
      finance: ['budget', 'cost', 'financial', 'invoice', 'payment', 'accounting'],
      engineering: ['design', 'specification', 'drawing', 'calculation', 'technical']
    };
    
    const contentLower = content.toLowerCase();
    const scores = {};
    
    Object.entries(domainKeywords).forEach(([domain, keywords]) => {
      scores[domain] = keywords.reduce((score, keyword) => {
        const matches = (contentLower.match(new RegExp(keyword, 'g')) || []).length;
        return score + matches;
      }, 0);
    });
    
    return scores;
  }
  
  static matchAgainstPatterns(content, fileName) {
    const patterns = [
      {
        name: 'safety_risk_assessment',
        discipline: 'safety',
        documentType: 'RISK',
        pattern: /(risk\s+assessment|hazard\s+analysis|safety\s+evaluation)/i,
        weight: 0.9
      },
      {
        name: 'safety_inspection',
        discipline: 'safety', 
        documentType: 'INS',
        pattern: /(inspection\s+checklist|safety\s+inspection|site\s+inspection)/i,
        weight: 0.85
      },
      {
        name: 'procurement_po',
        discipline: 'procurement',
        documentType: 'po_goods',
        pattern: /(purchase\s+order|po\s+number|supplier\s+details)/i,
        weight: 0.9
      }
      // Add more patterns...
    ];
    
    return patterns
      .map(pattern => ({
        ...pattern,
        match: pattern.pattern.test(content) || pattern.pattern.test(fileName),
        confidence: pattern.match ? pattern.weight : 0
      }))
      .filter(p => p.match);
  }
}
```

### **UX Improvements**

#### **Progressive Disclosure Flow**

```javascript
// Step-by-step user journey with clear progress indicators
const WorkflowSteps = ({ currentStep, totalSteps }) => {
  const steps = [
    { number: 1, title: 'Upload Document', icon: '📁' },
    { number: 2, title: 'AI Analysis', icon: '🤖' },
    { number: 3, title: 'Review & Correct', icon: '✏️' },
    { number: 4, title: 'Generate Form', icon: '✅' }
  ];
  
  return (
    <div className="workflow-steps">
      {steps.map(step => (
        <div 
          key={step.number}
          className={`step ${step.number <= currentStep ? 'completed' : ''} ${step.number === currentStep ? 'active' : ''}`}
        >
          <span className="step-icon">{step.icon}</span>
          <span className="step-title">{step.title}</span>
        </div>
      ))}
    </div>
  );
};
```

#### **Error Recovery & Retry Mechanism**

```javascript
const handleRetryAnalysis = async () => {
  try {
    // Allow user to upload a different file or retry with same file
    const retryFormData = new FormData();
    retryFormData.append("file", uploadedFile);
    retryFormData.append("retry", true); // Flag for retry analysis
    
    const response = await fetch("/api/process", {
      method: "POST",
      body: retryFormData,
    });
    
    const retryResult = await response.json();
    
    if (retryResult.success) {
      setAiDetectedData(retryResult);
      // Reset corrections to new AI suggestions
      setUserCorrectedData({
        discipline: retryResult.detectedDiscipline,
        documentType: retryResult.detectedDocumentType,
        confidence: retryResult.confidence
      });
    } else {
      throw new Error(retryResult.error);
    }
  } catch (error) {
    setError(`AI analysis retry failed: ${error.message}`);
  }
};
```

### **Benefits of New Workflow**

#### **For Users:**
- ✅ **No more guessing** - AI automatically detects best matches
- ✅ **Faster workflow** - Upload first, classify later
- ✅ **Confidence guidance** - See AI confidence and reasoning
- ✅ **Easy corrections** - Simple dropdown corrections if needed
- ✅ **Alternative suggestions** - AI provides multiple options

#### **For System:**
- ✅ **Better accuracy** - AI analyzes actual document content
- ✅ **Learning system** - Tracks user corrections to improve AI
- ✅ **Reduced errors** - Users less likely to misclassify
- ✅ **Scalable** - Works for any discipline without manual mapping

### **Implementation Priority**

#### **Phase 1: Core AI Enhancement (Week 1)**
1. Enhance `/api/process` endpoint with `analyzeOnly` flag
2. Implement AIClassificationService with keyword analysis
3. Add confidence scoring and reasoning

#### **Phase 2: UI Workflow Changes (Week 2)**
1. Remove required discipline/document type from upload step
2. Add AI detection results component
3. Implement progressive disclosure workflow

#### **Phase 3: AI Learning Integration (Week 3)**
1. Track user corrections for AI improvement
2. Add alternative suggestions feature
3. Implement retry mechanisms

### **Migration Strategy**

1. **Keep current workflow as fallback** while new AI workflow is tested
2. **Feature flag** the new AI workflow for gradual rollout
3. **User testing** with real documents to validate AI accuracy
4. **Gradual deprecation** of manual selection workflow

---

**Result**: Users upload documents first, AI automatically detects discipline and document type with confidence scores, users review/correct AI suggestions, then generate forms. This creates a much more intuitive and efficient workflow.

---
memory_layer: durable_knowledge
para_section: pages/codebase/agents
gigabrain_tags: agents, codebase, ai-automation
documentation
openstinger_context: agent-development, ai-systems
last_updated: 2026-03-21
related_docs:
  - codebase/agents/
  - disciplines/
---
# Document Preprocessor Learning Configuration

**Agent ID**: `shared_document_preprocessor`
**Version**: 1.0.0
**Created**: 2026-02-20
**Purpose**: Configuration for learning capabilities of the shared document preprocessing agent

---

## 1. Overview

This document defines the learning configuration for the Document Preprocessor Agent, a shared agent responsible for extracting Q&A pairs from various document types and filtering out non-question content (headings, section titles, etc.).

The agent learns from:

- Human corrections during HITL review
- Pattern recognition from processed documents
- Feedback on classification accuracy

---

## 2. Document Type Detection

### 2.1 Supported Document Types

| Document Type     | File Extensions | Key Indicators                                     |
| ----------------- | --------------- | -------------------------------------------------- |
| HSE Questionnaire | `.xlsx`, `.xls` | "HSE", "questionnaire", "safety", columns with Q/A |
| Contract          | `.pdf`, `.docx` | "agreement", "party", "terms", "conditions"        |
| Proposal          | `.pdf`, `.docx` | "proposal", "offer", "quotation", "scope"          |
| Evaluation Form   | `.xlsx`, `.pdf` | "evaluation", "assessment", "score", "rating"      |
| General Document  | Any             | No specific indicators                             |

### 2.2 Detection Logic

```python
DOCUMENT_TYPE_PATTERNS = {
    "hse_questionnaire": {
        "keywords": ["hse", "health safety environment", "questionnaire", "qs24001", "safety questionnaire"],
        "extensions": [".xlsx", ".xls"],
        "column_headers": ["question", "answer", "q", "a", "exigence", "réponse"]
    },
    "contract": {
        "keywords": ["agreement", "contract", "terms and conditions", "party", "obligation"],
        "extensions": [".pdf", ".docx"],
        "min_length": 5000  # Contracts are typically longer
    },
    "proposal": {
        "keywords": ["proposal", "quotation", "offer", "scope of work", "pricing"],
        "extensions": [".pdf", ".docx", ".xlsx"]
    },
    "evaluation_form": {
        "keywords": ["evaluation", "assessment", "score", "rating", "competency"],
        "extensions": [".xlsx", ".pdf", ".docx"]
    }
}
```

---

## 3. Heading vs Question Classification

### 3.1 Heading Detection Patterns

Headings and section titles should be filtered OUT. A line is classified as a **HEADING** if it matches ANY of these patterns:

#### IMPORTANT: Numbered Questions vs Headings

**QUESTIONS** (keep for scoring) - These have a number prefix AND question text:

- `1.1 A Does the company have a documented safety policy?` → **QUESTION**
- `1.2 B.1 What training records are maintained?` → **QUESTION**
- `2.1 Is there a designated safety officer?` → **QUESTION**

**HEADINGS** (filter out) - These are pure section titles with NO question:

- `HSSE management and culture` → **HEADING**
- `Section 1: Introduction` → **HEADING**
- `Safety Records` → **HEADING**
- `Training Requirements` → **HEADING**

The key distinction: If the line has a question number (like "1.1 A") followed by actual question text (more than 15 characters), it's a QUESTION, not a heading.

```regex
# Numbered QUESTION format (these are QUESTIONS, not headings!)
# Pattern: number + letter + substantial text
^[\d]+\.[\d]+\s*[A-Za-z]?(\.[\d]+)?\s+.{15,}$

# Examples that are QUESTIONS (keep these!):
# "1.1 A Does the company have a documented safety policy?"
# "1.2 B.1 What training records are maintained?"
# "2.1 Is there a designated safety officer?"
```

#### Short Title Patterns

```regex
# Titles that are too short to be questions
^.{1,50}$  # Less than 50 characters
# AND does not contain "?"
# AND does not start with question words (what, how, why, when, where, does, can, will, should, is, are)
```

#### Header Keywords

```regex
# Common header/section title keywords
\b(introduction|overview|summary|section|chapter|appendix|annex|part|title)\b
```

### 3.2 Question Detection Patterns

A line is classified as a **QUESTION** if it meets ALL of these criteria:

#### Minimum Length

```python
MIN_QUESTION_LENGTH = 30  # Characters
```

#### Question Indicators (at least one required)

```regex
# Contains question mark
\?

# OR starts with question word
^(what|how|why|when|where|which|who|whose|whom|does|do|can|could|will|would|should|is|are|was|were|has|have|had)\b

# OR contains question-like structure
\b(please (describe|explain|list|provide|state|indicate|specify))\b
\b(are there|is there|do you|does the|has the)\b
```

#### Not a Heading

```python
# Must NOT match heading patterns above
def is_not_heading(text):
    # Check against all heading patterns
    for pattern in HEADING_PATTERNS:
        if re.match(pattern, text, re.IGNORECASE):
            return False
    return True
```

### 3.3 Classification Confidence Scoring

Each classified item gets a confidence score:

```python
def calculate_confidence(text, is_question):
    confidence = 0.5  # Base confidence

    if is_question:
        # Increase confidence for question indicators
        if '?' in text:
            confidence += 0.3
        if starts_with_question_word(text):
            confidence += 0.2
        if len(text) > 100:
            confidence += 0.1  # Longer questions are more likely real
        if has_interrogative_structure(text):
            confidence += 0.15
    else:
        # Heading confidence
        if matches_numeric_prefix(text):
            confidence += 0.3
        if is_short_title(text):
            confidence += 0.2
        if contains_header_keyword(text):
            confidence += 0.15

    return min(1.0, confidence)
```

---

## 4. Learning Data Schema

### 4.1 Classification Record

Each document processed creates classification records:

```json
{
  "record_id": "uuid",
  "timestamp": "2026-02-20T10:00:00Z",
  "document_id": "doc_123",
  "document_type": "hse_questionnaire",
  "source_file": "QS24001_HSE_Questionnaire.xlsx",
  "classification": {
    "text": "1.1 A - Management Systems",
    "predicted_type": "heading",
    "predicted_confidence": 0.92,
    "actual_type": null,
    "human_corrected": false,
    "corrected_by": null
  },
  "context": {
    "line_number": 5,
    "preceding_text": "Section 1: General Requirements",
    "following_text": "Does the company have a documented safety policy?"
  }
}
```

### 4.2 Feedback Record

When humans correct classifications:

```json
{
  "feedback_id": "uuid",
  "timestamp": "2026-02-20T11:00:00Z",
  "record_id": "uuid_of_original_classification",
  "document_id": "doc_123",
  "original_classification": "heading",
  "corrected_classification": "question",
  "reviewer_id": "user_456",
  "reviewer_role": "safety_officer",
  "confidence_in_correction": 1.0,
  "notes": "This is actually a question that was formatted with a section prefix"
}
```

---

## 5. Feedback Collection Mechanisms

### 5.1 Automatic Collection

The agent automatically collects feedback from:

1. **HITL Review Corrections**: When reviewers mark items as "this should be a question" or "this is just a heading"
2. **Manual Override**: When users manually edit extracted Q&A pairs
3. **Score Discrepancies**: When questions scored as 0 (no answer) but later marked as headings

### 5.2 Manual Feedback Submission

API endpoint for direct feedback:

```
POST /api/document-preprocessor/feedback
{
  "document_id": "doc_123",
  "text": "1.1 A - Management Systems",
  "original_classification": "question",
  "corrected_classification": "heading",
  "reason": "This is a section title, not a question"
}
```

### 5.3 Bulk Feedback Import

For batch corrections:

```python
async def import_bulk_feedback(feedback_file: str):
    """
    Import bulk feedback from CSV/JSON file.
    Format:
    [
      {"text": "...", "correct_type": "question|heading", "reason": "..."},
      ...
    ]
    """
    pass
```

---

## 6. Training Triggers

### 6.1 Automatic Retraining Conditions

The agent retrains when ANY of these thresholds are met:

| Condition                  | Threshold   | Action                        |
| -------------------------- | ----------- | ----------------------------- |
| Corrections accumulated    | 50          | Update classification rules   |
| Accuracy drops below       | 85%         | Trigger review and retraining |
| Days since last training   | 30          | Scheduled retraining          |
| New document type detected | 5 documents | Learn new patterns            |
| False positive rate >      | 15%         | Adjust heading patterns       |
| False negative rate >      | 10%         | Adjust question patterns      |

### 6.2 Training Process

```python
async def retrain_model():
    """Retrain classification model from accumulated feedback."""

    # 1. Load all feedback records
    feedback = await load_feedback_records()

    # 2. Analyze patterns in corrections
    patterns = analyze_correction_patterns(feedback)

    # 3. Update classification rules
    if patterns['new_heading_patterns']:
        HEADING_PATTERNS.extend(patterns['new_heading_patterns'])

    if patterns['new_question_patterns']:
        QUESTION_PATTERNS.extend(patterns['new_question_patterns'])

    # 4. Adjust confidence thresholds
    update_confidence_thresholds(patterns)

    # 5. Validate on test set
    accuracy = await validate_classification()

    # 6. Log training results
    await log_training_results(accuracy, patterns)
```

---

## 7. Metrics Tracking

### 7.1 Performance Metrics

Tracked per document type and overall:

| Metric                    | Description                              | Target |
| ------------------------- | ---------------------------------------- | ------ |
| `classification_accuracy` | % correctly classified                   | > 95%  |
| `heading_precision`       | % predicted headings that are headings   | > 90%  |
| `heading_recall`          | % actual headings correctly identified   | > 95%  |
| `question_precision`      | % predicted questions that are questions | > 95%  |
| `question_recall`         | % actual questions correctly identified  | > 90%  |
| `false_positive_rate`     | Headings incorrectly marked as questions | < 5%   |
| `false_negative_rate`     | Questions incorrectly marked as headings | < 10%  |
| `avg_confidence`          | Average confidence score                 | > 0.85 |

### 7.2 Learning Metrics

| Metric                       | Description                    |
| ---------------------------- | ------------------------------ |
| `total_documents_processed`  | Cumulative count               |
| `total_classifications_made` | Items classified               |
| `total_corrections_received` | Human corrections              |
| `correction_rate`            | Corrections / Classifications  |
| `learning_improvement_rate`  | Accuracy improvement over time |

### 7.3 Metrics Storage

```sql
CREATE TABLE document_preprocessor_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  metric_date DATE NOT NULL,
  document_type TEXT NOT NULL,
  classifications_count INTEGER DEFAULT 0,
  corrections_count INTEGER DEFAULT 0,
  accuracy DECIMAL(5,2),
  heading_precision DECIMAL(5,2),
  heading_recall DECIMAL(5,2),
  question_precision DECIMAL(5,2),
  question_recall DECIMAL(5,2),
  false_positive_rate DECIMAL(5,2),
  false_negative_rate DECIMAL(5,2),
  avg_confidence DECIMAL(5,2),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 8. Integration with Specialist Agents

### 8.1 Usage Example

```python
from deep_agents.agents.shared.document_preprocessor import QuestionAnswerExtractor

# Initialize extractor
extractor = QuestionAnswerExtractor()

# Extract Q&A from raw document text
result = await extractor.extract(
    raw_text=document_content,
    doc_type="hse_questionnaire",
    document_id="doc_123"
)

# Result structure:
# {
#   "qa_pairs": [
#     {"index": 0, "question": "...", "answer": "...", "confidence": 0.95},
#     ...
#   ],
#   "filtered_headings": [
#     {"text": "1.1 A - Management Systems", "reason": "numeric_prefix_pattern"},
#     ...
#   ],
#   "metadata": {
#     "total_lines": 100,
#     "questions_found": 50,
#     "headings_filtered": 20,
#     "avg_confidence": 0.92
#   }
# }
```

### 8.2 Learning Feedback Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Document Upload                                  │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│              QuestionAnswerExtractor.extract()                       │
│  - Classify each line as question or heading                        │
│  - Apply learned patterns from LEARNING_CONFIG                       │
│  - Return cleaned Q&A pairs with confidence scores                  │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│                  Specialist Agent Processing                        │
│  - HSE Management Agent                                             │
│  - Legal Compliance Agent                                           │
│  - Training Competency Agent                                        │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    HITL Review (if needed)                          │
│  - Reviewer sees Q&A pairs                                          │
│  - Can mark "this is a heading, not a question"                     │
│  - Correction saved to learning database                            │
└─────────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    Learning Update                                   │
│  - Correction stored with context                                   │
│  - Triggers rule update when threshold met                          │
│  - Classification patterns improve for future documents             │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 9. Configuration Updates

### 9.1 Adding New Patterns

New patterns can be added without code changes:

```json
// In learning_config.json (auto-generated from this MD)
{
  "custom_heading_patterns": [
    "^Section \\d+:",
    "^Part [A-Z]:",
    "^ANNEX [A-Z]$"
  ],
  "custom_question_patterns": ["Please describe how", "Explain the process for"]
}
```

### 9.2 Document-Specific Overrides

```json
{
  "document_overrides": {
    "hse_questionnaire": {
      "min_question_length": 40,
      "heading_prefix_patterns": ["^[0-9]+\\.[0-9]+\\s*[A-Z]"],
      "require_question_mark": false
    },
    "contract": {
      "min_question_length": 50,
      "require_question_mark": true
    }
  }
}
```

---

## 10. Error Handling

### 10.1 Low Confidence Items

Items with confidence < 0.7 are flagged for review:

```python
if confidence < 0.7:
    result["needs_review"].append({
        "text": text,
        "predicted_type": classification,
        "confidence": confidence,
        "reason": "low_confidence"
    })
```

### 10.2 Ambiguous Classifications

When both heading and question patterns match:

```python
if is_heading and is_question:
    # Use higher confidence score
    # Log for potential pattern review
    result["ambiguous"].append({
        "text": text,
        "heading_confidence": heading_conf,
        "question_confidence": question_conf,
        "final_decision": "question" if question_conf > heading_conf else "heading"
    })
```

---

## 11. Version History

| Version | Date       | Changes                                                   |
| ------- | ---------- | --------------------------------------------------------- |
| 1.0.0   | 2026-02-20 | Initial configuration for document preprocessing learning |

---

## 12. Related Documents

- `/deep-agents/deep_agents/agents/shared/document_preprocessor/qa_extractor.py` - Main extraction logic
- `/deep-agents/deep_agents/agents/shared/document_preprocessor/heading_classifier.py` - Classification implementation
- `/deep-agents/deep_agents/agents/shared/document_preprocessor/learning_store.py` - Learning data storage

---

**End of Document Preprocessor Learning Configuration**

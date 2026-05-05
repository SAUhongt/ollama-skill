---
name: ollama-local-models
description: Use when the user wants to use local AI models for tasks like OCR, image recognition, text generation, or embeddings. Also use when the user asks what local models are available, wants to process images/documents locally, or mentions running models via Ollama.
---

# Ollama Local Models

## Overview

Detect and use locally installed Ollama models. Match user tasks to the best available local model based on hardware capability and model functionality.

## Workflow

```
User asks for local AI task
        │
        ▼
  Ollama installed?
  (check: ollama --version)
        │
   ┌────┴────┐
   │ NO      │ YES
   ▼         ▼
  End    Read hardware-config.md
  (tell    → CPU, RAM, GPU, VRAM
   user)     │
             ▼
         Read local-models.md
         → Model list + capabilities + task mapping
             │
             ▼
         Match task to model
         → Find best model for user's request
             │
        ┌────┴────┐
        │ Found    │ Not Found
        ▼          ▼
      Use it    Tell user
      (API)     no suitable
                model available
```

## Task Matching Logic

When the user requests a task, check `local-models.md` for the best match:

1. **OCR / Image recognition / Document understanding** → llava-llama3 (multimodal)
2. **Text generation / Chat / Coding** → qwen2.5:7b or qwen3.5:9b (quality) or qwen3.5:4b (speed)
3. **Math / Logic / Complex reasoning** → deepseek-r1:8b
4. **Embeddings / Semantic search / RAG** → nomic-embed-text
5. **Chinese language tasks** → any qwen model

## API Usage

All models are accessed via Ollama's local API at `http://localhost:11434`:

```bash
# Text generation
curl http://localhost:11434/api/generate -d '{"model":"<model>","prompt":"..."}'

# Image recognition / OCR (multimodal models only)
curl http://localhost:11434/api/generate -d '{"model":"llava-llama3","prompt":"Describe this image","images":["<base64>"]}'

# Embeddings
curl http://localhost:11434/api/embeddings -d '{"model":"nomic-embed-text","prompt":"Text to embed"}'

# Streaming (add "stream":true)
curl http://localhost:11434/api/generate -d '{"model":"qwen2.5:7b","prompt":"...","stream":true}'
```

## Prompt Templates by Task

The prompt heavily influences output quality, especially for multimodal models. Use these templates as starting points:

### OCR / Text Extraction

```
Act as an OCR engine. Extract ALL visible text from this image.
Output the exact text, preserving layout (lines, columns, labels).
Do not describe or interpret — just transcribe what you see.
```

For structured content (tables, charts, forms), add: "Preserve the table/chart structure in your output."

### Image Description

```
Describe this image in detail. Include: subject, setting, colors,
text visible, objects, and the overall composition.
```

### Document / Screenshot Analysis

```
Analyze this screenshot. Identify: (1) what application or page this is,
(2) the key information displayed, (3) any errors, warnings, or
unusual elements, (4) the action the user should take next.
```

### Chinese / Mixed-language Images

For images containing Chinese text, use the Chinese prompt:

```
请识别图中所有文字内容，保持原有格式和排版。逐行输出，不要遗漏任何文字。
```

## Accuracy Notes

- **General multimodal models** (llava-llama3, minicpm) are NOT dedicated OCR engines. Results may vary between runs, especially for small or stylized text.
- For **critical OCR tasks**, run the same image 2-3 times and compare results. The model may "interpret" text rather than transcribe it verbatim.
- **Prompt engineering matters**: "Act as an OCR engine, transcribe exactly" produces different (often more literal) output than "Describe what you see in this image."
- For production OCR needs, consider dedicated tools (Tesseract, PaddleOCR) and use multimodal models for verification or context understanding.

## Keeping Data Fresh

Model and hardware data files may be stale. If the user recently downloaded new models, suggest running:

```powershell
.\scripts\model-info.ps1
```

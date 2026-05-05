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

# Image recognition (multimodal models only)
curl http://localhost:11434/api/generate -d '{"model":"llava-llama3","prompt":"Describe this image","images":["<base64>"]}'

# Embeddings
curl http://localhost:11434/api/embeddings -d '{"model":"nomic-embed-text","prompt":"Text to embed"}'

# Streaming (add "stream":true)
curl http://localhost:11434/api/generate -d '{"model":"qwen2.5:7b","prompt":"...","stream":true}'
```

## Keeping Data Fresh

Model and hardware data files may be stale. If the user recently downloaded new models, suggest running:

```powershell
.\scripts\model-info.ps1
```

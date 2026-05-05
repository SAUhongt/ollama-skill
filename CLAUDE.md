# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is an **Ollama local model skill** project. It provides a Claude Code skill that detects locally installed Ollama models and matches them to user tasks (OCR, image recognition, text generation, embeddings, etc.).

## How It Works

1. **On skill invocation** — Check if Ollama is installed (`scripts/detect-ollama.ps1`). If not found, skill ends.
2. **Read hardware config** (`hardware-config.md`) — CPU, RAM, GPU, VRAM determines which models can run.
3. **Read model registry** (`local-models.md`) — Lists downloaded models with capabilities and API usage.
4. **Match task → model** — Based on the task mapping table, recommend the best local model for the user's request.

## Commands

```powershell
# Check if Ollama is installed and running
.\scripts\detect-ollama.ps1 -CheckRunning

# Update hardware config file
.\scripts\hardware-info.ps1

# Update local model registry file
.\scripts\model-info.ps1

# Run both updates together
.\scripts\hardware-info.ps1; .\scripts\model-info.ps1
```

## File Structure

- `SKILL.md` — The Claude Code skill definition (loaded on invocation)
- `hardware-config.md` — Auto-generated hardware specs (run `hardware-info.ps1` to refresh)
- `local-models.md` — Auto-generated model catalog with task mapping (run `model-info.ps1` to refresh)
- `scripts/detect-ollama.ps1` — Check if Ollama is installed and running
- `scripts/hardware-info.ps1` — Gather CPU/RAM/GPU/VRAM info
- `scripts/model-info.ps1` — Gather model list with details from `ollama list` and `ollama show`

## Keeping Data Fresh

After downloading new models in Ollama, re-run:
```powershell
.\scripts\model-info.ps1
```

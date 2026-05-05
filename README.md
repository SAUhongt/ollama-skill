# Ollama Local Models — Claude Code Skill

[中文](README_ZH.md)

A [Claude Code](https://claude.ai/code) skill that detects locally installed [Ollama](https://ollama.com/) models and intelligently matches them to user tasks — OCR, image recognition, text generation, embeddings, and more.

## How It Works

1. **Detect** — Checks if Ollama is installed and running via `scripts/detect-ollama.ps1`
2. **Assess hardware** — Reads `hardware-config.md` to understand CPU, RAM, GPU, and VRAM limits
3. **Check models** — Reads `local-models.md` for the list of downloaded models and their capabilities
4. **Match task → model** — Recommends the best local model for the user's request based on task type

## Prerequisites

- [Ollama](https://ollama.com/) installed and running
- [Claude Code](https://claude.ai/code) (or GitHub Copilot CLI)
- At least one model pulled via `ollama pull <model>`

## Installation

### Option 1: Install via Claude Code (recommended)

In Claude Code, type:

```
/install https://github.com/SAUhongt/ollama-skill
```

### Option 2: Clone manually

```powershell
git clone https://github.com/SAUhongt/ollama-skill.git
```

### Setup

After installing, run these scripts to generate your hardware and model configs:

```powershell
.\scripts\hardware-info.ps1
.\scripts\model-info.ps1
```

The skill auto-activates when you ask Claude Code to use local models.

## File Structure

```
ollama-skill/
├── SKILL.md                  # Skill definition (loaded on invocation)
├── CLAUDE.md                 # Project instructions for Claude Code
├── hardware-config.md        # Auto-generated hardware specs
├── local-models.md           # Auto-generated model catalog with task mapping
├── scripts/
│   ├── detect-ollama.ps1     # Check if Ollama is installed and running
│   ├── hardware-info.ps1     # Gather CPU/RAM/GPU/VRAM info
│   └── model-info.ps1        # Gather model list with details
├── README.md                 # English README
└── README_ZH.md              # 中文说明
```

## Keeping Data Fresh

After downloading new models in Ollama, re-run:

```powershell
.\scripts\model-info.ps1
```

After hardware changes, re-run:

```powershell
.\scripts\hardware-info.ps1
```

## Task Matching

| Task | Recommended Model Type |
|------|------------------------|
| OCR / Image recognition | Multimodal (llava, minicpm) |
| Text generation / Chat / Coding | qwen, deepseek |
| Math / Logic / Complex reasoning | deepseek-r1, qwq |
| Embeddings / Semantic search / RAG | nomic-embed-text |
| Chinese language tasks | qwen series |

All models are accessed via Ollama's local API at `http://localhost:11434`.

---

> This skill was built by the author using [Claude Code](https://claude.ai/code).

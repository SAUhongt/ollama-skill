# Ollama 本地模型 — Claude Code 技能

一个 [Claude Code](https://claude.ai/code) 技能，可检测本地安装的 [Ollama](https://ollama.com/) 模型，并智能地将用户任务（OCR、图像识别、文本生成、嵌入向量等）匹配到最合适的模型。

## 工作原理

1. **检测** — 通过 `scripts/detect-ollama.ps1` 检查 Ollama 是否已安装并运行
2. **评估硬件** — 读取 `hardware-config.md` 了解 CPU、内存、GPU 和显存限制
3. **检查模型** — 读取 `local-models.md` 获取已下载的模型列表及其能力
4. **匹配任务 → 模型** — 根据任务类型推荐最佳本地模型

## 前置条件

- [Ollama](https://ollama.com/) 已安装并运行
- [Claude Code](https://claude.ai/code)（或 GitHub Copilot CLI）
- 已通过 `ollama pull <模型名>` 下载至少一个模型

## 安装

### 方式一：通过 Claude Code 安装（推荐）

在 Claude Code 对话中输入：

```
/install https://github.com/SAUhongt/ollama-skill
```

### 方式二：手动克隆

```powershell
git clone https://github.com/SAUhongt/ollama-skill.git
```

### 初始化配置

克隆后运行以下脚本生成硬件和模型配置文件：

```powershell
.\scripts\hardware-info.ps1
.\scripts\model-info.ps1
```

完成配置后，当你向 Claude Code 请求使用本地模型时，技能会自动激活。

## 文件结构

```
ollama-skill/
├── SKILL.md                  # 技能定义（调用时加载）
├── CLAUDE.md                 # Claude Code 项目说明
├── hardware-config.md        # 自动生成的硬件配置
├── local-models.md           # 自动生成的模型目录及任务映射
├── scripts/
│   ├── detect-ollama.ps1     # 检测 Ollama 是否安装并运行
│   ├── hardware-info.ps1     # 收集 CPU/内存/GPU/显存信息
│   └── model-info.ps1        # 收集模型列表及详细信息
├── README.md                 # English README
└── README_ZH.md              # 中文说明（本文件）
```

## 保持数据更新

在 Ollama 中下载新模型后，重新运行：

```powershell
.\scripts\model-info.ps1
```

硬件变更后，重新运行：

```powershell
.\scripts\hardware-info.ps1
```

## 任务匹配

| 任务 | 推荐模型类型 |
|------|-------------|
| OCR / 图文识别 | 多模态模型（llava, minicpm） |
| 文本生成 / 对话 / 代码 | qwen, deepseek |
| 数学 / 逻辑 / 复杂推理 | deepseek-r1, qwq |
| 嵌入向量 / 语义搜索 / RAG | nomic-embed-text |
| 中文任务 | qwen 系列 |

所有模型均通过 Ollama 本地 API 访问：`http://localhost:11434`。

---

> 本技能由作者使用 [Claude Code](https://claude.ai/code) 编写。

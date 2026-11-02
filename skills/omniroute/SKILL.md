---
name: omniroute
description: Universal AI Gateway with token compression, multi-provider auto-fallback, and access to 380+ LLM providers (including 150+ free tiers). Provides local proxy on localhost:20128 and 46 CLI/workflow management skills.
tags: [gateway, router, proxy, fallback, free-tiers, compression]
---

# OmniRoute — The Universal AI Gateway

OmniRoute routes all AI tools (Antigravity, Claude Code, Cursor, Cline, Copilot) through one unified local endpoint with automated fallback and RTK + Caveman token compression.

## Architecture & Features
- **Local Endpoint**: `http://localhost:20128/v1`
- **Dashboard**: `http://localhost:20128/dashboard`
- **Auto-Fallback Cascades**:
  1. Tier 1: Subscriptions (Claude Pro/Max, ChatGPT Plus)
  2. Tier 2: Paid API keys (OpenAI, Anthropic, Gemini, Mistral)
  3. Tier 3: Cheap models (DeepSeek, Groq, Cerebras)
  4. Tier 4: Free tiers (150+ cataloged providers)
- **Token Compression**: Saves 15–95% on tool outputs and conversation history.

## CLI & Skills Suite
Over 45 specialized sub-skills are installed in `.agents/skills/`:
- `cli-routing`, `cli-compression`, `cli-providers`, `cli-models`, `cli-keys`
- `omni-combos-routing`, `omni-resilience`, `omni-budget`, `omni-auth`
- `omni-agents-a2a`, `omni-context-rtk`, `omni-db-backups`

## Quick Start
```bash
# Global install & start
npm install -g omniroute
omniroute

# Check health & status
curl http://localhost:20128/v1/models
```

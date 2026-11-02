---
name: headroom
description: Context compression and token optimization layer for AI agents. Provides prompt compression, MCP tools (headroom_compress, headroom_retrieve, headroom_stats), and proxy support to reduce token usage by 50-90% without loss of key details.
tags: [compression, tokens, optimization, context, mcp]
---

# Headroom — Context Compression Layer for AI Agents

Headroom compresses everything your AI agent reads — tool outputs, logs, RAG chunks, files, and conversation history — before it reaches the LLM. Compression runs locally on your machine.

## Core Capabilities
- **Local AST & JSON Crusher**: Automatically collapses repetitive JSON, tracebacks, and large log dumps while preserving exact error lines, line numbers, and critical variables.
- **MCP Server Tools**:
  - `headroom_compress`: Shrinks text/JSON/logs on demand.
  - `headroom_retrieve`: Recovers exact byte-for-byte original chunks using content hashes (CCR).
  - `headroom_stats`: Returns real-time token savings and compression ratio.
- **Cross-Agent Memory**: Shared local memory store across Claude, Gemini, Codex, and Grok with automatic deduplication.

## Quick Start & Usage

### 1. Installation
```bash
npm install -g headroom-ai
# or lightweight python:
pip install "headroom-ai[mcp]"
```

### 2. Run Local Proxy
```bash
# Starts local compression proxy on port 8787
headroom proxy --port 8787
```

### 3. MCP Integration
Register Headroom as an MCP server in your IDE configuration:
```json
{
  "mcpServers": {
    "headroom": {
      "command": "npx",
      "args": ["-y", "headroom-ai", "mcp"]
    }
  }
}
```

## Best Practices
- Always compress outputs larger than 2,000 tokens when inspecting logs, test suites, or large database dumps.
- Use `headroom_retrieve` when exact string matching is required on code blocks.

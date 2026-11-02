---
name: claude-mem
description: Persistent memory compression system built for AI coding agents. Automatically captures tool usage observations, generates semantic summaries, and preserves project context across sessions with SQLite vector search and 30 workflow skills.
tags: [memory, context, persistence, sessions, learning]
---

# Claude-Mem — Persistent Cross-Session Memory System

Claude-Mem seamlessly preserves context across coding sessions by automatically capturing tool usage observations, generating semantic summaries, and making them available to future sessions.

## Core Capabilities
- **Session Continuity**: Preserves memory of architectural decisions, past bugs, active work threads, and user preferences across session resets.
- **Semantic Vector Memory**: Uses local SQLite + vector embeddings to recall relevant past observations when matching file patterns or tasks arise.
- **Specialized Memory Skills Suite**:
  Includes 30 installed sub-skills in `.agents/skills/`:
  - `mem-search`, `learn-codebase`, `make-plan`, `handoff`, `standup`
  - `knowledge-agent`, `timeline-report`, `weekly-digests`, `smart-explore`
  - `build-and-release`, `cloud-sync`, `agent-cost-report`

## Quick Start
```bash
# Global install / update
npx claude-mem install

# Run memory search
claude-mem search "pSEO architectural decisions"
```

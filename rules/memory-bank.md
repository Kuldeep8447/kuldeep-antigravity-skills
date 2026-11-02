---
trigger: always_on
description: "Forces Gemini/Antigravity to read and maintain the project Memory Bank across sessions."
---

# Gemini's Memory Bank for Google Antigravity

I am operating within Google Antigravity. I maintain the project's persistent context across resets using the `memory-bank/` directory.

## Core Rules:
1. At the beginning of major tasks or architectural work, review `memory-bank/` files to understand the current state, project goals, and constraints.
2. When the user says **update memory bank**, update the 6 core files in `memory-bank/`:
   - `projectbrief.md`
   - `productContext.md`
   - `systemPatterns.md`
   - `techContext.md`
   - `activeContext.md`
   - `progress.md`

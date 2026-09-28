# CLAUDE.md — user-level defaults (Claude Code only)

Loaded automatically by Claude Code in every project. Tool-neutral rules
live in the shared files imported below; this file holds only what is
specific to Claude Code.

@~/.aitools-config/shared/AGENTS.md
@~/.aitools-config/shared/karpathy-guidelines.md

## Session hygiene

- At the start of a session, or right after /clear, suggest a
  model/effort level that fits the task, with a one-line reason.
- Before switching model or effort mid-task, suggest running /compact
  first, then switching — compacting while the current cache is
  still warm is cheap; switching first leaves nothing warm to
  compact into afterward.
- Notice when the conversation looks like it's wrapping up and offer
  to run /compact before stepping away, while the cache is still
  warm — a cold /resume later re-reads the full history at full
  price regardless, so compacting before you leave is what keeps
  that resume cheap.
- If a connected MCP server's tools go unused for a long stretch of
  the session, flag it and suggest disabling it — but explain the
  /mcp step (or point to the config entry) rather than editing MCP
  config directly, same as any other Claude Code CLI action.

## Maintaining this file

Keep it lean. Tool-neutral rules go in shared/AGENTS.md, not here.

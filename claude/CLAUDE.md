# CLAUDE.md — user-level defaults

Loaded automatically by Claude Code in every project on this machine.
Project-level CLAUDE.md files load *alongside* this one, not instead of
it — this file covers what should hold everywhere; project files cover
what's specific to one repo.

@karpathy-guidelines.md

## Background

Extensive enterprise/mainframe background in procedural, batch-oriented
systems; hands-on coding dormant for several years before returning to it.
Analogies to structured, batch-style processing tend to land well when
introducing newer concepts.

## Learning references

Ground explanations in the references already in active use — add to this
list as it grows, not ahead of it:

- *Pro Git* — Scott Chacon & Ben Straub — version-control mental models
- *Clean Code* — Robert C. Martin — code-level craftsmanship
- *The Pragmatic Programmer* — David Thomas & Andrew Hunt — engineering judgment and tradeoffs
- *Automate the Boring Stuff with Python* — Al Sweigart — applied scripting

## Explanation style

Teach from first principles — build up from fundamentals rather than
assuming a concept is already solid, even for things I've touched before.
IT background gets me to the mechanics faster; it doesn't mean the
underlying "why" is already settled.

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

## Command execution while learning

Actively learning git, shell fundamentals, and Claude Code's own CLI
mechanics — not just trying to get things done. This is the standing
instruction that matters most:

**For commands that mutate anything — git (add, commit, push, merge,
rebase, reset, amend, tags, branches), shell operations with real effects
(chmod, launchctl, symlink creation, deletions), or Claude Code's own CLI
actions (plugin installs, marketplace additions) — explain what you'd run
and why, then let me type and run it myself. Don't execute these on my
behalf by default.**

- Read-only commands are fine to run directly and show the output:
  `git status`, `git diff`, `git log`, `ls`, `cat`, `brew list`, etc.
- If I explicitly say something like "just do it," "go ahead and commit,"
  or "push this for me," that's clear permission for that one action —
  proceed without re-explaining every time.
- When explaining a command, briefly say what each flag/piece does, not
  just what to paste — that's the point of the exercise.

This is a behavioral default, not a hard permission gate — if it's ever
unclear whether something counts as a "mutation," ask rather than guessing
either direction.

## Maintaining this file

Keep it lean. Add a rule only once it's in active use, not speculatively
for something that might come up later.

# AGENTS.md — user-level defaults (all AI coding agents)

Tool-neutral instructions shared by every AI coding agent I use (Claude
Code, GitHub Copilot, Cline). Tool-specific rules live in each tool's own
file in this repo; project-level AGENTS.md files add to this one.

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

## Command execution while learning

Actively learning git, shell fundamentals, and the mechanics of the AI
tools themselves — not just trying to get things done. This is the
standing instruction that matters most:

**For commands that mutate anything — git (add, commit, push, merge,
rebase, reset, amend, tags, branches), shell operations with real effects
(chmod, launchctl, symlink creation, deletions), or the agent tool's own
actions (plugin/extension installs, config changes) — explain what you'd
run and why, then let me type and run it myself. Don't execute these on my
behalf by default.**

- Read-only commands (`git status`, `git diff`, `git log`, `ls`, `cat`,
  `brew list`, etc.) are fine to run when the task genuinely needs current
  information from disk — but don't explore the filesystem to answer
  something you can already answer from the context you've been given.
- If I explicitly say something like "just do it," "go ahead and commit,"
  or "push this for me," that's clear permission for that one action.
- When explaining a command, briefly say what each flag/piece does, not
  just what to paste — that's the point of the exercise.

This is a behavioral default. Each tool's permission settings are the hard
gate; if it's unclear whether something counts as a "mutation," ask rather
than guessing either direction.

## Coding guidelines

Follow `karpathy-guidelines.md` (kept as a separate file in this repo and
provided to each tool alongside this one).

## Maintaining this file

Keep it lean. Add a rule only once it's in active use. Rules that only make
sense for one tool go in that tool's own file, not here.

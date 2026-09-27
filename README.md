# .aitools-config

Personal AI coding-tool configuration — user-level behavioral defaults
that apply across every project on this machine, plus a library of
reusable project-level starting points. Currently holds configuration
for Claude Code, under `claude/`.

Scope is AI-tooling configuration, not general machine setup.

---

## Contents

```
.aitools-config/
├── README.md
├── LICENSE
├── claude/
│   ├── CLAUDE.md               — user-level defaults, symlinked to ~/.claude/CLAUDE.md
│   ├── karpathy-guidelines.md  — imported by CLAUDE.md via @-reference
│   ├── settings.json           — user-level Claude Code settings, symlinked to ~/.claude/settings.json
│   ├── skills/                 — user-level skills, symlinked to ~/.claude/skills/
│   ├── hooks/                  — user-level hook scripts, symlinked to ~/.claude/hooks/
│   └── agents/                 — user-level subagents, symlinked to ~/.claude/agents/
├── project-templates/          — reusable starting points, COPIED (not linked) into a project
│   ├── claude-md/
│   ├── skills/
│   ├── hooks/
│   └── agents/
└── scripts/
    ├── setup_claude_symlinks.sh — links everything under claude/ into ~/.claude/
    └── init_project.sh          — copies one template into the current project's .claude/
```

Everything under `claude/` is scoped to things that are genuinely about
*you* — preferences and defaults that should follow you into every
project. Anything tied to a specific codebase (its tools, its lint
rules, its review standards) belongs in that project's own `.claude/`
instead — `project-templates/` exists so a good one, once proven useful
in a second project, doesn't have to be rewritten from scratch.

---

## Setup

```bash
git clone git@github.com:dpauldev/.aitools-config.git ~/.aitools-config
cd ~/.aitools-config
./scripts/setup_claude_symlinks.sh
```

This symlinks everything under `claude/` into `~/.claude/`, where
Claude Code reads it automatically at the start of every session, in
every project, on this machine. Re-run it any time after adding a new
skill, agent, or hook — it discovers new subfolders/files on its own,
no script edit needed.

Note on hooks specifically: a hook script being symlinked into
`~/.claude/hooks/` does not activate it by itself. It still needs a
one-time manual entry in `claude/settings.json` (this repo's copy, which
`~/.claude/settings.json` links to) — see `claude/hooks/README.md` for
the exact shape of that entry.

Note on `settings.json`: Claude Code itself also writes to this file
(e.g. `/model`, `/config`), and those writes land in this repo through
the symlink. Check `git status` after changing settings in-app, and
commit or `git restore` deliberately. Never put secrets here — use
`~/.claude/settings.local.json` (not tracked) for anything sensitive.

---

## Reusing something in a new project

```bash
cd ~/path/to/some-other-project
~/.aitools-config/scripts/init_project.sh <claude-md|skills|hooks|agents> <template-name>
```

Run with no arguments to list what's currently available. This copies
rather than links, deliberately — see `project-templates/README.md` for
why.

---

## What's in here

`CLAUDE.md` has these sections:

- **Background** — prior technical background, used to frame how
  explanations should land.
- **Learning references** — the reference books currently in active use.
- **Explanation style** — first-principles explanations, not assuming a
  concept is already solid.
- **Command execution while learning** — explain and hand off mutating
  git/shell/CLI commands rather than running them, while those
  fundamentals are still being learned.
- **Session hygiene** — when to suggest a model/effort choice, when to
  compact before switching models or stepping away, and when to flag an
  unused MCP server.
- **Maintaining this file** — keep it lean; add a rule only once it's
  in active use.

`karpathy-guidelines.md` is a separate file — general LLM-coding
behavioral guidelines (avoid overcomplication, make surgical changes,
define verifiable success criteria). Imported rather than duplicated
inline — see its header comment for source and license.

`skills/`, `hooks/`, and `agents/` (both under `claude/` and under
`project-templates/`) start empty on purpose — populated as something
proves genuinely useful in practice, not speculatively ahead of that.

---

## AI attribution

This repo's content was drafted collaboratively with Claude, then
reviewed and corrected across several rounds before being committed.

---

## License

MIT — see [LICENSE](./LICENSE).

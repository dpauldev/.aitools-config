# .aitools-config

Personal AI coding-tool configuration — user-level behavioral defaults
that apply across every project on this machine, plus a library of
reusable project-level starting points. Covers the AI coding agents I
use: Claude Code (`claude/`), GitHub Copilot in VS Code (fed from
`shared/`), and Cline (planned). Tool-neutral rules live once in
`shared/`; each tool gets them through a symlink or an import.

Scope is AI-tooling configuration, not general machine setup.

---

## Contents

```
.aitools-config/
├── README.md
├── LICENSE
├── shared/                     — tool-neutral rules, used by every AI coding agent
│   ├── AGENTS.md               — user-level defaults; imported by claude/CLAUDE.md,
│   │                             symlinked to ~/.copilot/copilot-instructions.md
│   └── karpathy-guidelines.md  — imported by claude/CLAUDE.md, symlinked to
│                                 ~/.copilot/instructions/karpathy-guidelines.instructions.md
├── claude/
│   ├── CLAUDE.md               — Claude-only rules + imports of shared/, symlinked to ~/.claude/CLAUDE.md
│   ├── settings.json           — user-level Claude Code settings, symlinked to ~/.claude/settings.json
│   ├── skills/                 — user-level skills, symlinked to ~/.claude/skills/
│   ├── hooks/                  — user-level hook scripts, symlinked to ~/.claude/hooks/
│   └── agents/                 — user-level subagents, symlinked to ~/.claude/agents/
├── project-templates/          — reusable starting points, COPIED (not linked) into a project
│   ├── agents-md/              — project AGENTS.md files (e.g. tutor mode), read by all agents
│   ├── claude-md/              — project CLAUDE.md files (e.g. a one-line @AGENTS.md import)
│   ├── skills/
│   ├── hooks/
│   └── agents/
└── scripts/
    ├── setup_claude_symlinks.sh — links claude/ into ~/.claude/ and shared/ into ~/.copilot/
    └── init_project.sh          — copies one template into the current project
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
every project, on this machine — and links `shared/AGENTS.md` and
`shared/karpathy-guidelines.md` into `~/.copilot/` for GitHub Copilot. Re-run it any time after adding a new
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

## Required VS Code settings (not stored in this repo)

The Copilot side of this setup depends on two VS Code **user** settings
(Cmd+, → User tab). They live in VS Code's own settings.json, which is
deliberately not managed here — set them by hand on a new machine:

| Setting | Value | Why |
|---|---|---|
| `chat.useAgentsMdFile` | on | Copilot reads project-level `AGENTS.md` (tutor mode etc.) |
| `chat.useClaudeMdFile` | off | Stops Copilot reading `CLAUDE.md` files, which contain Claude-only rules and `@imports` Copilot can't resolve |

Copilot's user-level instructions themselves come from `shared/` via the
symlinks created by `scripts/setup_claude_symlinks.sh`.

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

`shared/AGENTS.md` (tool-neutral, every agent) has these sections:

- **Background** — prior technical background, used to frame how
  explanations should land.
- **Learning references** — the reference books currently in active use.
- **Explanation style** — first-principles explanations, not assuming a
  concept is already solid.
- **Command execution while learning** — explain and hand off mutating
  git/shell/CLI commands rather than running them, while those
  fundamentals are still being learned.
- **Coding guidelines** / **Maintaining this file** — pointer to the
  Karpathy guidelines; keep it lean.

`claude/CLAUDE.md` imports both shared files and adds only Claude-specific
rules:

- **Session hygiene** — when to suggest a model/effort choice, when to
  compact before switching models or stepping away, and when to flag an
  unused MCP server.

`karpathy-guidelines.md` is a separate file — general LLM-coding
behavioral guidelines (avoid overcomplication, make surgical changes,
define verifiable success criteria). Kept as its own file: imported by
`claude/CLAUDE.md`, and linked into Copilot's instructions folder (its
`applyTo: "**"` header tells Copilot to apply it everywhere) — see its
header comment for source and license.

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

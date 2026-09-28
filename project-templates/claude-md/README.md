# CLAUDE.md templates

Each file here is a starting-point project-level `CLAUDE.md` — e.g. one
per project type, once more than one exists. Copy in with:

    ./scripts/init_project.sh claude-md <template-name>.md

Add a template here once a second real project CLAUDE.md exists and a
genuine starting point is worth extracting from it, not speculatively
ahead of that.

## Available templates

- `import-agents.md` — a one-line `CLAUDE.md` (`@AGENTS.md`) that makes
  Claude Code read the project's `AGENTS.md`. Use it alongside an
  `agents-md/` template so all rules live in one tool-neutral file.

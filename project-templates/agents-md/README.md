# AGENTS.md templates

Each file here is a starting-point project-level `AGENTS.md` — the
tool-neutral instruction file read by every AI coding agent I use
(Claude Code via an `@AGENTS.md` import, GitHub Copilot, Cline). Copy in
with:

    ./scripts/init_project.sh agents-md <template-name>.md

## Available templates

- `learning-tutor-mode.md` — for learning repos: I write the code, the
  agent coaches (explains, gives stubs, reviews, never edits files
  unasked; full code only on "override tutor mode"). Pair it with
  `claude-md/import-agents.md` so Claude Code reads it too.

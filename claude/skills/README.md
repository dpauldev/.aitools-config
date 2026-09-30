# Personal skills

Each subfolder here is one user-level skill: `<name>/SKILL.md`, plus any
supporting files that skill needs.

Run `scripts/setup_symlinks.sh` after adding a folder here — it
symlinks every subfolder into `~/.claude/skills/`, so the skill is
available in every project on this machine. No script edit needed to
add a new one; the setup script discovers folders automatically.

Reserve this for skills that are genuinely about you and your workflow,
not tied to one codebase — project-specific skills belong in that
project's own `.claude/skills/` instead (see `project-templates/skills/`
for a reusable starting point to copy in).

Note: user-level skills apply to local Claude Code sessions on this
machine. They do not reach Cowork or cloud sessions.

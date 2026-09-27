# Personal subagents

Each `.md` file here is one user-level subagent definition (frontmatter
+ system prompt), symlinked into `~/.claude/agents/` by
`scripts/setup_claude_symlinks.sh` — available in every project on this
machine, no script edit needed to add a new one.

Reserve this for an agent that's genuinely about you rather than one
codebase. Most subagents will be project-specific instead (tools,
review standards, and file layout differ per project) — those belong in
that project's own `.claude/agents/`, not here. See
`project-templates/agents/` for reusable starting points to copy in.

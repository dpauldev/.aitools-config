# Personal hooks

Each `.sh` file here is a hook script, symlinked into `~/.claude/hooks/`
by `scripts/setup_claude_symlinks.sh` for a stable path to reference.

That symlink alone does NOT activate a hook. Claude Code only runs a
hook once it's registered under the `"hooks"` key in its settings,
pointing at the script's path and naming which event fires it (e.g.
`PreToolUse`). Settings live in this repo at `claude/settings.json`
(symlinked to `~/.claude/settings.json`), so add the entry there by
hand, once per hook, and commit it.

Example registration, for a `PreToolUse` hook on the Bash tool:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "~/.claude/hooks/<script-name>.sh" }
        ]
      }
    ]
  }
}
```

Reserve this folder for hooks that are genuinely personal defaults
(e.g. blocking a dangerous command shape) rather than project-specific
(e.g. running a particular linter) — those belong in that project's own
`.claude/hooks/` instead. See `project-templates/hooks/` for reusable
starting points to copy in.

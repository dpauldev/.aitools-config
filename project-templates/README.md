# Project templates

Reusable starting points for a new project's own `.claude/` folder (or
its `CLAUDE.md`) — pulled in with `scripts/init_project.sh`, run from
inside the target project.

These are **copied**, not symlinked, and that's deliberate: a project's
`.claude/` folder needs to be self-contained, so it still works for
anyone who clones the project without also having `.aitools-config`, and
on any machine, including this one after the source template has since
changed. Once copied, a project's copy is independent — edit it there
without touching the template, and without the template silently
changing work already committed elsewhere.

```
./scripts/init_project.sh <claude-md|skills|hooks|agents> <template-name>
```

Run with no arguments from inside `.aitools-config` to list what's
currently available under each kind.

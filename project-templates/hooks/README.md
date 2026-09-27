# Reusable project hooks

Each file here is a project-scoped hook worth reusing across more than
one project (e.g. "run this project's formatter after every edit" —
the pattern is reusable even though the actual command differs per
project). Copy one into a project with:

    ./scripts/init_project.sh hooks <hook-script-name>.sh

Registration in that project's own `.claude/settings.json` is still a
manual step after copying — see `claude/hooks/README.md` for the shape
of that entry.

This is a placeholder folder — populate it once a hook built for one
project turns out to be worth reusing in a second, not speculatively
ahead of that.

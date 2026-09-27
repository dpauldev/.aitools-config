# CLAUDE.md templates

Each file here is a starting-point project-level `CLAUDE.md` — e.g. one
per project type, once more than one exists. Copy in with:

    ./scripts/init_project.sh claude-md <template-name>.md

Add a template here once a second real project CLAUDE.md exists and a
genuine starting point is worth extracting from it, not speculatively
ahead of that.

## Available templates

- `learning-tutor-mode.md` — for learning repos where I write the code
  and Claude coaches (explains, gives stubs, reviews, but doesn't edit
  files unasked). Delete the tutor-mode section in repos where Claude
  should write code freely.

#!/bin/bash

# Copy a reusable template from .aitools-config into the current
# project's .claude/ folder (or its CLAUDE.md).
#
# Unlike setup_claude_symlinks.sh, this COPIES rather than symlinks —
# deliberately. A project's .claude/ folder needs to be self-contained
# so it still works for anyone who clones the project without also
# having .aitools-config, and on any machine, including this one after
# the template has since changed. Run this from inside the target
# project's own directory.
#
# Usage:
#   ./init_project.sh claude-md generic.md
#   ./init_project.sh skills some-skill-name
#   ./init_project.sh hooks lint-on-save.sh
#   ./init_project.sh agents some-agent.md
#
# Run with no arguments to list what's currently available.

set -e

TEMPLATES_DIR="$HOME/.aitools-config/project-templates"
KIND="$1"
NAME="$2"

if [ -z "$KIND" ] || [ -z "$NAME" ]; then
    echo "Usage: $0 <claude-md|skills|hooks|agents> <template-name>"
    echo ""
    echo "Available templates:"
    for dir in "$TEMPLATES_DIR"/*/; do
        kind=$(basename "$dir")
        echo "  $kind:"
        ls -1 "$dir" 2>/dev/null | grep -v '^README.md$' | sed 's/^/    /'
    done
    exit 1
fi

SOURCE="$TEMPLATES_DIR/$KIND/$NAME"

if [ ! -e "$SOURCE" ]; then
    echo "No template found at: $SOURCE"
    exit 1
fi

case "$KIND" in
    claude-md)
        DEST="./CLAUDE.md"
        ;;
    skills)
        DEST="./.claude/skills/$NAME"
        ;;
    hooks)
        DEST="./.claude/hooks/$NAME"
        ;;
    agents)
        DEST="./.claude/agents/$NAME"
        ;;
    *)
        echo "Unknown kind: $KIND (expected claude-md, skills, hooks, or agents)"
        exit 1
        ;;
esac

if [ -e "$DEST" ]; then
    echo "$DEST already exists here — not overwriting."
    echo "Remove it first, or copy manually, if you want to replace it."
    exit 1
fi

mkdir -p "$(dirname "$DEST")"
cp -r "$SOURCE" "$DEST"

echo "Copied $SOURCE"
echo "    -> $DEST"
echo "This is now this project's own copy — edit it here without affecting the template in .aitools-config."

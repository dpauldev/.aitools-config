#!/bin/bash

# init_project.sh — copy one reusable template from .aitools-config into
# the project you're standing in.
#
# WHAT IT DOES
#   Takes a template from ~/.aitools-config/project-templates/<kind>/<name>
#   and COPIES it to the right place in the current folder:
#
#     kind        copied to
#     ---------   ------------------------------
#     agents-md   ./AGENTS.md          (rules read by every AI agent)
#     claude-md   ./CLAUDE.md          (Claude Code's project file)
#     skills      ./.claude/skills/<name>
#     hooks       ./.claude/hooks/<name>
#     agents      ./.claude/agents/<name>
#
# WHY COPY, NOT SYMLINK (unlike setup_claude_symlinks.sh)
#   A project must be self-contained: it has to work for anyone who clones
#   it without .aitools-config, and must not change silently when the
#   template is edited later. Once copied, the project's file is its own.
#
# HOW TO RUN — always from inside the target project's folder:
#   ~/.aitools-config/scripts/init_project.sh <kind> <template-name>
#
#   Typical new learning repo (tutor mode for all agents):
#     init_project.sh agents-md learning-tutor-mode.md
#     init_project.sh claude-md import-agents.md
#
#   Other examples:
#     init_project.sh skills some-skill-name
#     init_project.sh hooks lint-on-save.sh
#     init_project.sh agents some-agent.md
#
#   Run with no arguments to list what's currently available.

# Stop immediately if any command fails, instead of carrying on half-done.
set -e

# --- 1. Read the inputs ------------------------------------------------------
# $1 and $2 are the first and second words typed after the script name.
TEMPLATES_DIR="$HOME/.aitools-config/project-templates"
KIND="$1"     # which folder of templates, e.g. agents-md
NAME="$2"     # which template inside it, e.g. learning-tutor-mode.md

# --- 2. No arguments? Show usage and list the templates, then stop -----------
# [ -z "$X" ] is true when X is empty; || means "or".
if [ -z "$KIND" ] || [ -z "$NAME" ]; then
    echo "Usage: $0 <agents-md|claude-md|skills|hooks|agents> <template-name>"
    echo ""
    echo "Available templates:"
    # For each kind-folder: print its name, then its files (one per line,
    # skipping README.md, indented by four spaces).
    for dir in "$TEMPLATES_DIR"/*/; do
        kind=$(basename "$dir")
        echo "  $kind:"
        ls -1 "$dir" 2>/dev/null | grep -v '^README.md$' | sed 's/^/    /'
    done
    exit 1
fi

# --- 3. Check the requested template actually exists -------------------------
# [ ! -e path ] is true when the path does NOT exist.
SOURCE="$TEMPLATES_DIR/$KIND/$NAME"

if [ ! -e "$SOURCE" ]; then
    echo "No template found at: $SOURCE"
    exit 1
fi

# --- 4. Decide where the copy goes, based on the kind ------------------------
# case/esac works like COBOL's EVALUATE: first matching branch wins,
# ;; ends a branch, and *) is the WHEN OTHER catch-all.
case "$KIND" in
    agents-md)
        DEST="./AGENTS.md"
        ;;
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
        echo "Unknown kind: $KIND (expected agents-md, claude-md, skills, hooks, or agents)"
        exit 1
        ;;
esac

# --- 5. Never overwrite: refuse if the destination is already there ----------
if [ -e "$DEST" ]; then
    echo "$DEST already exists here — not overwriting."
    echo "Remove it first, or copy manually, if you want to replace it."
    exit 1
fi

# --- 6. Copy ------------------------------------------------------------------
# dirname gives the destination's parent folder (e.g. ./.claude/skills);
# mkdir -p creates it if missing. cp -r copies files AND whole folders
# (a skill is a folder).
mkdir -p "$(dirname "$DEST")"
cp -r "$SOURCE" "$DEST"

echo "Copied $SOURCE"
echo "    -> $DEST"
echo "This is now this project's own copy — edit it here without affecting the template in .aitools-config."

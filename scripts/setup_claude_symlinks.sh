#!/bin/bash

# Stop execution if an error occurs
set -e

CONFIG_REPO="$HOME/.aitools-config/claude"
CLAUDE_DIR="$HOME/.claude"

echo "Checking AI tool configuration (Claude Code, GitHub Copilot)..."

# Ensure the target directory exists (Claude Code creates it on first run,
# but a completely fresh machine may not have it yet)
mkdir -p "$CLAUDE_DIR"

# Symlink one file or directory from this repo into ~/.claude/, backing up
# anything already there that isn't already the correct symlink.
#
# Checks four states before linking: already correctly linked / linked
# elsewhere / something real to back up / nothing yet. Works for both
# plain files (CLAUDE.md) and whole directories (a skill's own folder) —
# symlinking a directory behaves the same way as symlinking a file, from
# the shell's point of view.
link_item() {
    local SOURCE="$1"
    local TARGET="$2"
    local NAME
    NAME=$(basename "$TARGET")

    if [ ! -e "$SOURCE" ]; then
        echo "Source $NAME not found:"
        echo "$SOURCE"
        exit 1
    fi

    # -L tests specifically for "is this a symlink" — even a broken one
    # whose target no longer exists. Checking -L before -e matters: a
    # dangling symlink would otherwise slip past the check below.
    if [ -L "$TARGET" ]; then

        CURRENT=$(readlink "$TARGET")

        if [ "$CURRENT" = "$SOURCE" ]; then
            echo "$NAME already linked ✓"
        else
            echo "$NAME is linked to another location:"
            echo "$CURRENT"
            exit 1
        fi

    # -e matches anything already at this path — reached only once TARGET
    # is confirmed not to be a symlink already, per the -L check above
    elif [ -e "$TARGET" ]; then

        BACKUP="$TARGET.backup-$(date +%Y-%m-%d-%H%M%S)"

        echo "Existing $NAME found."
        echo "Creating backup:"
        echo "$BACKUP"

        mv "$TARGET" "$BACKUP"
        ln -s "$SOURCE" "$TARGET"

        echo "$NAME linked ✓"

    else
        ln -s "$SOURCE" "$TARGET"
        echo "$NAME linked ✓"
    fi
}

# --- Root-level files ---------------------------------------------------

link_item "$CONFIG_REPO/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
link_item "$CONFIG_REPO/settings.json" "$CLAUDE_DIR/settings.json"

# --- Skills ---------------------------------------------------------------
# Each subfolder of claude/skills/ is one skill. Every subfolder found
# gets symlinked as a whole, so adding a new skill is just "add a
# folder" — no edit needed here.

mkdir -p "$CLAUDE_DIR/skills"
if [ -d "$CONFIG_REPO/skills" ]; then
    for skill_dir in "$CONFIG_REPO/skills"/*/; do
        [ -d "$skill_dir" ] || continue
        skill_name=$(basename "$skill_dir")
        link_item "${skill_dir%/}" "$CLAUDE_DIR/skills/$skill_name"
    done
fi

# --- Agents -----------------------------------------------------------
# Each .md file under claude/agents/ is one subagent definition.

mkdir -p "$CLAUDE_DIR/agents"
if [ -d "$CONFIG_REPO/agents" ]; then
    for agent_file in "$CONFIG_REPO/agents"/*.md; do
        [ -f "$agent_file" ] || continue
        agent_name=$(basename "$agent_file")
        # README.md documents this folder, it isn't itself an agent —
        # skip it rather than symlinking it into ~/.claude/agents/.
        [ "$agent_name" = "README.md" ] && continue
        link_item "$agent_file" "$CLAUDE_DIR/agents/$agent_name"
    done
fi

# --- Hooks --------------------------------------------------------------
# Hook scripts get symlinked into ~/.claude/hooks/ for a stable path to
# reference, but that alone does NOT activate them — Claude Code only
# runs a hook once it's registered under the "hooks" key in
# claude/settings.json (this repo's copy, symlinked above), pointing at
# the script's path — see claude/hooks/README.md for the exact entry
# to add by hand.

mkdir -p "$CLAUDE_DIR/hooks"
if [ -d "$CONFIG_REPO/hooks" ]; then
    for hook_file in "$CONFIG_REPO/hooks"/*.sh; do
        [ -f "$hook_file" ] || continue
        hook_name=$(basename "$hook_file")
        chmod +x "$hook_file"
        link_item "$hook_file" "$CLAUDE_DIR/hooks/$hook_name"
    done
fi

# --- GitHub Copilot (VS Code) --------------------------------------------
# Copilot has no @import, so the shared files are linked in directly.
SHARED_DIR="$HOME/.aitools-config/shared"
COPILOT_DIR="$HOME/.copilot"

mkdir -p "$COPILOT_DIR/instructions"
link_item "$SHARED_DIR/AGENTS.md" "$COPILOT_DIR/copilot-instructions.md"
link_item "$SHARED_DIR/karpathy-guidelines.md" "$COPILOT_DIR/instructions/karpathy-guidelines.instructions.md"

echo "Done."

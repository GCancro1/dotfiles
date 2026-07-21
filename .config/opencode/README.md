# OpenCode Multi-Agent Setup

This directory contains configuration for running multiple AI agents simultaneously using git worktrees.

## Quick Start

```bash
# Install plugins
./setup.sh

# Or install globally
./setup.sh --global

# Restart opencode after installation
```

## Plugins Installed

| Plugin | Purpose |
|--------|---------|
| `kdco/workspace` | Multi-agent orchestration bundle (includes worktree, background-agents, notify) |
| `kdco/dcp` | Differential context protocol for optimized token usage |

## Architecture

```
┌──────────────────────────────────────────────────────────┐
│                     ORCHESTRATORS                        │
│         ┌──────┐                    ┌───────┐            │
│         │ plan │                    │ build │            │
│         └──┬───┘                    └───┬───┘            │
└────────────┼────────────────────────────┼────────────────┘
             │                            │
     ┌───────┴───────┐            ┌───────┴───────┐
     ▼       ▼       ▼            ▼       ▼       ▼
┌─────────────────────────────────────────────────────────┐
│                      SPECIALISTS                        │
│  ┌─────────┐ ┌────────────┐ ┌───────┐ ┌──────┐ ┌──────┐ │
│  │ explore │ │ researcher │ │ coder │ │scribe│ │review│ │
│  └─────────┘ └────────────┘ └───────┘ └──────┘ └──────┘ │
└─────────────────────────────────────────────────────────┘
```

## Agents

### Primary Agents

- **build** - Default agent with full tool access for development work
- **plan** - Read-only agent for planning and analysis

### Specialist Agents

- **researcher** - External research using MCP tools, read-only
- **coder** - Implementation specialist with full file and bash access
- **scribe** - Documentation writer, file write only
- **reviewer** - Code review specialist, read-only with git inspection

## Usage

### Git Worktrees

Create isolated development environments:

```bash
# In opencode TUI, the AI can:
worktree_create("feature/dark-mode")    # Creates new worktree + terminal
worktree_delete("Feature complete")     # Commits and cleans up

# Or manually:
git worktree add ../feature-branch feature-branch
cd ../feature-branch
opencode
```

### Background Agents

Run tasks asynchronously without blocking:

```bash
# Delegate research tasks
delegate("Research OAuth2 PKCE best practices", "researcher")

# List all delegations
delegation_list()

# Read specific result
delegation_read("delegation-id")
```

### Multi-Agent Sessions

Navigate between sessions:

| Shortcut | Action |
|----------|--------|
| `Ctrl+X Up` | Jump to parent session |
| `Ctrl+X Left` | Previous sub-agent |
| `Ctrl+X Right` | Next sub-agent |
| `<Leader>+Down` | Enter first child session |
| `Right` | Next child session |
| `Left` | Previous child session |
| `Up` | Return to parent session |

## Configuration Files

| File | Purpose |
|------|---------|
| `opencode.jsonc` | Main OpenCode configuration |
| `worktree.jsonc` | Worktree sync and hook settings |
| `AGENTS.md` | Project-specific instructions |
| `agents/` | Custom agent definitions (markdown) |

## Worktree Configuration

Edit `worktree.jsonc` to customize file sync:

```jsonc
{
  "sync": {
    "copyFiles": [".env", ".env.local"],    // Files to copy
    "symlinkDirs": ["node_modules"],         // Directories to symlink
    "exclude": [".git", "dist"]              // Patterns to exclude
  },
  "hooks": {
    "postCreate": ["pnpm install"],          // Run after creation
    "preDelete": ["docker compose down"]     // Run before deletion
  }
}
```

## Permissions

Each agent has specific permission boundaries:

| Agent | Edit | Bash | Web | Task |
|-------|------|------|-----|------|
| build | allow | allow | allow | allow |
| plan | deny | limited | allow | allow |
| researcher | deny | deny | allow | deny |
| coder | allow | allow | deny | deny |
| scribe | allow | deny | deny | deny |
| reviewer | deny | limited | deny | deny |

## Transferring to Other Machines

This setup is designed to be portable:

1. Clone dotfiles: `git clone <repo> ~/dotfiles`
2. Stow config: `cd ~/dotfiles && stow --restow .`
3. Run setup: `~/.config/opencode/setup.sh`
4. Restart opencode

The `setup.sh` script handles:
- Installing OCX if missing
- Installing all required plugins
- Creating worktree configuration
- Setting up delegation storage

## Troubleshooting

### Plugins not loading

```bash
# Check installed plugins
ocx list

# Reinstall if needed
ocx add kdco/workspace --from https://registry.kdco.dev --force
```

### Worktree creation fails

- Ensure git is configured: `git config --global user.name "Your Name"`
- Check terminal support in `worktree.jsonc`
- Verify kitty/ghostty/wezterm is installed

### Background agents timeout

Delegations timeout after 15 minutes. For longer tasks:
- Break into smaller chunks
- Use native `task` tool for write-capable agents
- Check `delegation_list()` for status

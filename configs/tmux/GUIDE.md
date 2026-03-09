# Tmux Setup Guide

## Overview

This tmux setup combines three tools: **tmux** (multiplexer), **sesh** (session manager), and **tmuxinator** (project templates). A shell hook auto-attaches on terminal launch.

## Prefix Key

**`Ctrl+Space`** (replaces default `Ctrl+b`)

## Key Bindings

### Windows

| Binding           | Action                     |
| ----------------- | -------------------------- |
| `Alt+1`–`Alt+9`   | Switch to window by number |
| `Alt+h` / `Alt+l` | Previous / next window     |
| `Prefix + c`      | New window                 |
| `Prefix + r`      | Rename window              |
| `Prefix + &`      | Kill window                |

### Panes

| Binding                | Action             |
| ---------------------- | ------------------ |
| `Prefix + h`           | Horizontal split   |
| `Prefix + v`           | Vertical split     |
| `Ctrl+Alt+Arrow`       | Navigate panes     |
| `Ctrl+Alt+Shift+Arrow` | Resize panes (5px) |

### Sessions

| Binding      | Action                            |
| ------------ | --------------------------------- |
| `Prefix + t` | Sesh popup (fuzzy session finder) |
| `Prefix + L` | Switch to last session            |

### Sesh Popup Filters (`Prefix + t`)

| Binding  | Filter           |
| -------- | ---------------- |
| `Ctrl+a` | All sessions     |
| `Ctrl+t` | Tmux sessions    |
| `Ctrl+g` | Config dirs      |
| `Ctrl+x` | Zoxide dirs      |
| `Ctrl+f` | Find directories |
| `Ctrl+d` | Kill session     |

### Other

| Binding      | Action                                  |
| ------------ | --------------------------------------- |
| `Prefix + a` | Open Claude AI in 80-col side pane      |
| `Prefix + u` | Fuzzy-find URLs in pane output (plugin) |
| `Prefix + .` | Reload config & install plugins         |

## Copy Mode (Vi)

Enter with `Prefix + [`, then:

| Key      | Action            |
| -------- | ----------------- |
| `v`      | Begin selection   |
| `Ctrl+v` | Rectangle toggle  |
| `y`      | Copy to clipboard |

## Window Auto-Naming

Windows auto-rename based on the current directory and process via `bin/tmux-window-name`:

- In a git repo: `repo-name/process` (or `repo-name/subdir/process`)
- Outside git: `dirname/process`

## Status Bar

- **Position**: Top
- **Left**: Session name (blue pill)
- **Right**: Prefix highlight, zoom indicator, CPU usage (color-coded), time

## Sesh (Session Manager)

Config: `configs/sesh/sesh.toml`

Sesh aggregates sessions from multiple sources, displayed in this priority order:

1. **tmuxinator** — Project templates
2. **config** — `~/.config/` directories
3. **tmux** — Existing tmux sessions
4. **zoxide** — Frecent directories

A default session named "Default" (rooted at `~`) is always available.

## Tmuxinator (Project Templates)

Config: `configs/tmuxinator/*.yml`

Pre-configured project layouts. Most follow this pattern:

```yaml
name: project-name
root: ~/code/project
windows:
  - claude:
      panes:
        - claude -c --dangerously-skip-permissions
  - dev:
      panes:
        - nr dev
  - editor:
      panes:
        - nvim
```

### Available Projects

| Template        | Root                  | Dev Command   |
| --------------- | --------------------- | ------------- |
| dotfiles        | `~/.dotfiles`         | —             |
| f8n-labs        | `~/code/labs`         | `bun run dev` |
| f8n-marketplace | `~/code/marketplace`  | `bun run dev` |
| portfolio       | `~/code/portfolio`    | `nr dev`      |
| starframe       | `~/code/starframe`    | `nr dev`      |
| dailies         | `~/code/dailies`      | `nr dev`      |
| rodeo-native    | `~/code/rodeo-native` | —             |

## Shell Auto-Attach

In `shell/zshrc`, a hook auto-attaches to tmux on terminal launch:

```bash
if [[ -z "$TMUX" ]] && (( $+commands[tmux] )) && (( $+commands[sesh] )); then
  tmux ls &>/dev/null && tmux attach || sesh connect Default
fi
```

If already in tmux, nothing happens. Otherwise it attaches to an existing session or creates the Default session via sesh.

## Plugins (TPM)

- **tmux-fzf-url** — Fuzzy-find and open URLs from pane output
- **tmux-cpu** — CPU usage in status bar
- **tmux-prefix-highlight** — Visual indicator when prefix is active

Plugins are managed by TPM at `~/.config/tmux/plugins/tpm` and auto-install on config reload.

## Dependencies

`tmux`, `sesh`, `fzf`, `fd`, `tmuxinator`, `zsh`

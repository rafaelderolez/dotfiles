# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS dotfiles managed by [Dotbot](https://github.com/anishathalye/dotbot). Dotbot handles symlink creation, shell commands, and Homebrew package installation via `install.conf.yaml`.

## Commands

- **`./install`** — Run full Dotbot setup (symlinks, submodules, Homebrew, npm packages, shell reload)
- **`dot install`** — Same as above (alias via `scripts/menu.sh`)
- **`dot edit`** — Open dotfiles in `$EDITOR` (nvim)

## Architecture

### Dotbot (`install.conf.yaml`)
Central config that declares:
- **Symlinks**: Files from this repo → home directory (e.g., `shell/zshrc` → `~/.zshrc`, `configs/nvim` → `~/.config/nvim`)
- **Shell commands**: Submodule init, Homebrew install, shell reload, npm packages
- **Brewfile**: `packages/brewfile` via `dotbot-brewfile` plugin (git submodule)

### Directory Layout
- **`shell/`** — Zsh config split into: `zshrc` (main), `zshenv` (env vars like `$DOTFILES`), `zprofile` (brew shellenv), `exports.zsh`, `alias.zsh`, `functions.zsh`, `antigenrc` (plugins)
- **`configs/`** — App configs symlinked to `~/.config/`: nvim, lazygit, starship, ghostty, karabiner, sesh, tmux/tmuxinator
- **`gitfiles/`** — `gitconfig` (public), `gitconfig_private` (gitignored, signing key), `gitignore` (global)
- **`packages/`** — `brewfile` (Homebrew bundle), `npm.sh` (global npm packages)
- **`scripts/`** — `menu.sh` (`dot` command), `homebrew.sh`, `cj.sh`
- **`bin/`** — `chirp` (colorful shell logging utility), `b` — added to `$PATH` via exports

### Shell Setup
- Zsh with Antigen plugin manager (fzf-tab, fast-syntax-highlighting, zsh-autosuggestions, zsh-you-should-use, zsh-tab-title)
- Starship prompt, zoxide (aliased as `j`/`ji`), fnm for Node.js versions, pnpm
- Performance: zoxide/starship/fnm inits are cached in `~/.cache/` and only regenerated when binaries change
- `ls` is aliased to `eza`, `rm` to `trash`, `vi`/`vim` to `nvim`, `lg` to `lazygit`

### Git
- GPG signing via 1Password SSH agent
- Delta for diffs (side-by-side)
- Private config included from `gitconfig_private` (gitignored)

## Key Notes

- `gitfiles/gitconfig_private` is gitignored — contains signing key
- The `ls` alias uses `eza --tree` which can conflict with certain flags; use `/bin/ls` for raw listing
- `$DOTFILES` is set in `shell/zshenv` to `$HOME/.dotfiles`

# Editor
export EDITOR="nvim"
# Disable Homebrew lock file
export HOMEBREW_BUNDLE_NO_LOCK=true
# Auto load or install required node version in .nvmrc
export NVM_AUTO_USE=true
# Visual editor
export VISUAL="nvim"
# Set config dir
export XDG_CONFIG_HOME="$HOME/.config"
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Fix locale issues with macOS custom locale format
export LANG="${LC_ALL:-$LANG}"
unset LC_ALL

# History
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"

# Less pager
export LESS="-R -X -F"

# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# FZF defaults (if using fzf)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"

# Bat (if using bat)
command -v bat &> /dev/null && export BAT_THEME="Dracula"

# PATH management function - add to PATH if not already present
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

# Add directories to PATH using pathadd function
pathadd "$DOTFILES/bin"
pathadd "$HOME/.local/bin"
# Note: PNPM_HOME is added in zshrc after it's exported

# dirs
alias DL="cd $HOME/Downloads"
alias H="cd $HOME"
alias C="cd $HOME/Code"

# commands
alias dot="$DOTFILES/scripts/menu.sh"
alias ls="eza --icons --tree -L 1 --group-directories-first --all" # https://github.com/ogham/exa
alias mv="mv -v"
alias ping="prettyping --nolegend"
alias r="exec zsh"
alias rm="trash"
alias fast="fast --upload"
alias squoosh="squoosh-cli"
alias zperf="/usr/bin/time zsh -i -c exit"
alias lg="lazygit"
alias commit-raycast="git diff --cached | pbcopy; open raycast://ai-commands/git-commit-message && git commit"

# npm (aside from @antfu/ni's aliases)
alias nt="npm test"
alias ns="npm start"
alias nw="npm run watch"

alias j=__zoxide_z
alias ji=__zoxide_zi

# vim
alias vi="nvim"
alias vim="nvim"

alias bi="brew install"
alias bu="brew uninstall"
alias bup="brew upgrade"



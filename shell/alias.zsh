# ================================================================================ #
# Aliases
# ================================================================================ #

alias CL="cd $CLOUD_SYNC"
alias D="cd $DOTFILES"
alias DL="cd $HOME/Downloads"
alias H="cd $HOME"
alias C="cd $HOME/Code"

alias dot="$DOTFILES/scripts/menu.sh"
alias ls="exa --icons --tree -L 1 --group-directories-first"
alias mv="mv -v"
alias ping="prettyping --nolegend"
alias r="exec zsh"
alias rm="trash"
alias fast="fast --upload"
alias squoosh="squoosh-cli"
alias zperf="/usr/bin/time zsh -i -c exit"


# npm
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run-script"
alias nt="npm test"
alias nit="npm install && npm test"
alias nis="npm install && npm start"
alias nits="npm install && npm test && npm start"
alias ns="npm start"
alias nl="npm link"
alias nw="npm run watch"

# yarn
alias ya="yarn add"
alias yr="yarn remove"
alias yad="yarn add --dev"
alias yg="yarn global"
alias ys="yarn start"
alias yd="yarn dev"

npm() {
  if [ -e yarn.lock ]; then
    echo "⚠️ This is a yarn project."
    command yarn $@
  else
    command npm $@
  fi
}


yarn() {
  if [ -e package-lock.json ]; then
    echo "⚠️ This is an npm project."
    command npm run $@
  else
    command yarn $@
  fi
}

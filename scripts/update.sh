#!/bin/zsh
#============================================================================
# Title: Update
# Usage: sh update.sh
#
# Description:
# Launches an interactive prompt to select what items need updating then
# updates them accordingly
#============================================================================

source ${DOTFILES}/scripts/utils.sh

update() {
  local update_options=("App Store Apps" "Brews" "Casks" "Homebrew" "Node Modules" "Antigen")
  local IFS=$'\n' chosen_options=("$(printf "%s\n" "${update_options[@]}" | fzf --print-query --multi --layout=reverse --border --header="Tab to select:")")
  while read p; do
    case ${p} in
    "App Store Apps")
      info "Updating App Store Apps"
      mas upgrade
      success "App Store Apps are up to date"
      ;;
    "Brews")
      info "Updating Brews"
      brew upgrade
      success "Brews are up to date"
      ;;
    "Casks")
      info "Updating Casks"
      brew upgrade --cask
      success "Casks are up to date"
      ;;
    "Homebrew")
      info "Updating Homebrew"
      brew update
      success "Homebrew is up to date"
      ;;
    "Node Modules")
      info "Updating Node Modules"
      npm update -g
      success "Node Modules are up to date"
      ;;
    "Antigen")
      info "Updating antigen (brew)"
      brew upgrade antigen
      success "Antigen is up to date"
      antigen update
      success "Antigen bundles are up to date"
      ;;
    esac
  done <<<"$chosen_options"
  echo
  success "Updates complete!"
}

update
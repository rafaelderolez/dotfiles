#!/bin/zsh
#============================================================================
# Title: Utils
# Usage: source ${DOTFILES}/scripts/utils.sh
#
# Description:
# Use this at the top of your scripts to utilize colors, formatting and
# logging
#============================================================================

# Colors
GRAY='\033[1;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
PINK='\033[1;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# Decorators
BOLD='\033[1m'
NORMAL='\033[2m'

log() {
  # If we are running in the foreground, set formatting
  case $(ps -o stat= -p $$) in
  *+*) printf "$1" "$2" ;;
  # Otherwise just log!
  *) echo "$2" ;;
  esac
}

alt() {
  log "${MAGENTA}%s${RESET}\n" "$@"
}

info() {
  log "${BLUE}${BOLD}%s:${NORMAL}${RESET} \n" "$@"
}

warn() {
  log "${YELLOW}⚠ Warning:${RESET} %s!\n" "$@"
}

error() {
  log "${RED}⊘ Error:${RESET} %s!\n" "$@"
}

confirm() {
  printf "\n"
  log "\n${YELLOW}==> %s${RESET} " "$@"
  read -p "Continue? (y/n) " -n 1 -r
  printf "\n"
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
}

prompt() {
  log "${YELLOW}%s:${RESET} " "$@"
}

process_title() {
  log "${PINK}┃ %s${RESET}\n" "$@"
}

process() {
  log "${PINK}┃${RESET} %s...\n" "$@"
}

success() {
  log "${GREEN}✓ Success:${RESET} %s\n" "$@"
}
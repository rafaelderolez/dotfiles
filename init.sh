#!/bin/sh
#============================================================================
# Title: Bootstrap
# Usage: sh bootstrap.sh
#
# Description:
# This script should be run locally after remote-install.sh has installed
# everything we need to continue
#============================================================================

set -e

export DOTFILES="$HOME/.dotfiles"

on_start() {
	cat <<"EOF"

▓█████▄  ▒█████  ▄▄▄█████▓  █████▒██▓ ██▓    ▓█████   ██████
▒██▀ ██▌▒██▒  ██▒▓  ██▒ ▓▒▓██   ▒▓██▒▓██▒    ▓█   ▀ ▒██    ▒
░██   █▌▒██░  ██▒▒ ▓██░ ▒░▒████ ░▒██▒▒██░    ▒███   ░ ▓██▄
░▓█▄   ▌▒██   ██░░ ▓██▓ ░ ░▓█▒  ░░██░▒██░    ▒▓█  ▄   ▒   ██▒
░▒████▓ ░ ████▓▒░  ▒██▒ ░ ░▒█░   ░██░░██████▒░▒████▒▒██████▒▒
 ▒▒▓  ▒ ░ ▒░▒░▒░   ▒ ░░    ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░
 ░ ▒  ▒   ░ ▒ ▒░     ░     ░      ▒ ░░ ░ ▒  ░ ░ ░  ░░ ░▒  ░ ░
 ░ ░  ░ ░ ░ ░ ▒    ░       ░ ░    ▒ ░  ░ ░      ░   ░  ░  ░
   ░        ░ ░                   ░      ░  ░   ░  ░      ░
 ░

EOF
  echo "Prepare for automation heaven..."
	sudo -v
}


install_homebrew() {
	# Check for Homebrew and install if it doesn't exist
	if test ! $(which brew); then
		echo "Installing Homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		# Install all dependencies in Brewfile
	fi
	echo "Homebrew installed"
}

main() {
  on_start
	install_homebrew
}

main

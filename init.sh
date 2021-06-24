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

install_homebrew_dependencies() {
	echo "Installing dependencies from Brewfile"	
  open -a "App Store.app"
  echo "Login to the App Store to continue"

	# Install everything in Brewfile
	brew bundle --no-upgrade --file ./Brewfile
	echo "Homebrew bundle installed"
}

main() {
  on_start
	install_homebrew
	install_homebrew_dependencies
}

main

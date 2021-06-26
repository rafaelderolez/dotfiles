source ${DOTFILES}/scripts/utils.sh

install_homebrew() {
	if test ! $(which brew); then
		success "Homebrew already installed"
		echo "Installing Homebrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	fi
	success "Homebrew installed"
}
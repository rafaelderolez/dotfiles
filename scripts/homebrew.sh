chirp --process-title "Homebrew"

if ! command -v brew >/dev/null; then
	chirp --info "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	chirp --success "Homebrew installed successfully"
else
	chirp --success "Homebrew already installed"
fi

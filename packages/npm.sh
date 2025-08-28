chirp --process-title "NPM"

if ! command -v pnpm >/dev/null; then
  chirp --process-item "> Installing pnpm"
  brew install pnpm
  chirp --success "Installed pnpm"
else 
  chirp --success "pnpm is already installed"
fi

chirp --process-item "Installing packages"
pnpm i -g @antfu/ni
pnpm i -g diff-so-fancy
pnpm i -g fast-cli
pnpm i -g kill-port
pnpm i -g npmrc
pnpm i -g trash-cli
pnpm i -g typescript
pnpm i -g bashtop
pnpm i -g wipe-modules

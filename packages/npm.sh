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
pnpm i -g nodemon
pnpm i -g npm-check-updates
pnpm i -g npmrc
pnpm i -g sanity
pnpm i -g trash-cli
pnpm i -g typescript
pnpm i -g vercel
pnpm i -g vtop
pnpm i -g wipe-modules

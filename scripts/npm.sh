source ${DOTFILES}/scripts/utils.sh

install_node_modules() {
	process "Installing NPM packages"
	local npm_path=$DOTFILES/packages/npm
	local default_modules=$(cat $npm_path)
	local installed_modules=$(npm list -g --depth=0 | tail -n +2 | sed 's/.*── //')

	for default_module in $default_modules; do
		if ! echo $installed_modules | grep -w -q $default_module; then
			npm i -g $default_module
		fi
		success "$default_module is installed"
	done
	success "Default global node modules installed"
}

install_node_modules
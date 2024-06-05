function menu() {
	case $1 in
	install)
		$DOTFILES/install
		;;
	npm)
		chirp --process-title "Installing node modules"
		sh $DOTFILES/scripts/npm.sh
		;;
	edit)
		cd $DOTFILES && $EDITOR
		;;
	help)
		chirp --info "Usage: dot <command>"
		chirp --process-item "Commands:"
		chirp --option "install          " "Run dotbot to run through the whole flow"
		chirp --option "npm              " "Install node modules"
		chirp --option "edit             " "Open dotfiles in editor"
		chirp --option "help             " "This help message";;
	*)
		menu help
		;;
	esac
}

menu "$1"

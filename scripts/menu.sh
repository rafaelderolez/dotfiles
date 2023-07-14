source ${DOTFILES}/scripts/utils.sh

function menu() {

	case $1 in
	install)
		$DOTFILES/install
		;;
	ssh)
		sh $DOTFILES/scripts/ssh.sh
		;;
	npm)
		sh $DOTFILES/scripts/npm.sh
		;;
	edit)
		cd $DOTFILES && $EDITOR
		;;
	help)
		echo
		echo "${CYAN}${BOLD}DOTFILES${NORMAL}${RESET}"
		echo
		echo "Usage: dot <command>"
		echo
		echo "Commands:"
		echo "   ${MAGENTA}install${RESET}          Run dotbot to run through the whole flow"
		echo "   ${MAGENTA}ssh${RESET}              Set up ssh"
		echo "   ${MAGENTA}npm${RESET}              Install node modules"
		echo "   ${MAGENTA}edit${RESET}             Open dotfiles in editor"
		echo "   ${MAGENTA}update${RESET}           Update packages and package managers"
		echo "   ${MAGENTA}help${RESET}             This help message"
		;;
	update)
		sh ${DOTFILES}/scripts/update.sh
		;;
	*)
		menu help
		;;
	esac
}

menu "$1"

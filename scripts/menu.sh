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
        sh $DOTFILES/scripts/node_modules.sh
        ;;
    dock)
        sh $DOTFILES/scripts/dock.sh
        ;;
    duti)
        sh $DOTFILES/scripts/set-default-apps.sh
        ;;
    edit)
        cd $DOTFILES && $EDITOR .
        ;;
    help)
        echo
        echo "${CYAN}${BOLD}DOTFILES${NORMAL}${RESET}"
        echo "Manage your system like a boss"
        echo
        echo "Usage: dot <command>"
        echo
        echo "Commands:"
        echo "   ${MAGENTA}install${RESET}          Bootstraps your system"
        echo "   ${MAGENTA}ssh${RESET}              Set up ssh"
        echo "   ${MAGENTA}npm${RESET}              Install node modules"
        echo "   ${MAGENTA}dock${RESET}             Set up dock items"
        echo "   ${MAGENTA}duti${RESET}             Assign default applications for document types"
        echo "   ${MAGENTA}edit${RESET}             Open dotfiles in editor"
        echo "   ${MAGENTA}help${RESET}             This help message"
        echo "   ${MAGENTA}macos${RESET}            Apply macOS preferences"
        echo "   ${MAGENTA}update${RESET}           Update packages and package managers"
        ;;
    macos)
        sh $DOTFILES/scripts/macos.sh
        ;;
    update)
        sh ${DOTFILES}/scripts/update.sh
        ;;
    esac
}

menu "$1"
source ${DOTFILES}/scripts/utils.sh

function menu() {

    case $1 in
    install)
        $DOTFILES/install
        ;;
    # clean)
    #     info "Cleaning up your system with cleanup"
    #     alt "Read more about what it does https://git.io/JtiTr"
    #     cleanup -n
    #     success "Cleaning complete!"
    #     ;;
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
        # echo "   ${MAGENTA}clean${RESET}            Runs system cleanup"
        echo "   ${MAGENTA}install${RESET}          Bootstraps your system"
        echo "   ${MAGENTA}dock${RESET}             Setup dock items"
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
    *)
        menu help
        ;;
    esac
}

menu "$1"
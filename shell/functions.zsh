mkd() {
  mkdir -p "$@" && cd "$@" && echo "Now in `pwd`"
}

set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}

claude() {
    # Check if we're in a git repository
    if git rev-parse --git-dir >/dev/null 2>&1; then
        # Get git root directory
        git_root=$(git rev-parse --show-toplevel)
        current_dir=$(pwd)
        
        # If not in git root, navigate there
        if [[ "$git_root" != "$current_dir" ]]; then
            cd "$git_root"
            echo "Navigated to git root: $git_root"
        fi
    fi
    
    # Call the original claude command
    command claude "$@"
}

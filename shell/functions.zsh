mkd() {
  mkdir -p "$@" && cd "$@" && echo "Now in `pwd`"
}

set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}

mkd() {
  mkdir -p "$@" && cd "$@" && echo "Now in `pwd`"
}
#!/bin/bash
#============================================================================
# Title: Symlink
# Usage:
#   symlink "source-directory" "target-directory"
#   symlink "source-directory" "target-directory"
#
# Description:
# Symlinks all the files in a directory to another
#============================================================================

source ${DOTFILES}/scripts/utils.sh

_link() {
  local source=$1
  local target=$2
  # Check if the an existing target already links to the source.
  local existing_symlink=$(readlink "$target")
  if [[ "$existing_symlink" == "$source" ]]; then
    process "⚬ ${target}"
  else
    # Link file
    if test -f "$target"; then
      # Backup old file with .bak extension
      mv "$target" "$target".bak
      ln -s "$source" "$target" && process "+ ${target} [Existing ➔ ${target}.bak]"
    else
      ln -s "$source" "$target" && process "+ ${target}"
    fi
  fi
}

symlink() {
  local source_dir="$1"
  local target_dir="$2"
  process_title "Symlinking from $source_dir to $target_dir"
  _link "$source_dir" "$target_dir"
}

symlink_dir_files() {
  local source_dir="$1"
  local target_dir="$2"
  local ignored_files='/|^.DS_Store'
  process_title "Symlinking files from $source_dir to $target_dir"
  for file in $(cd "$source_dir" && ls -ap | egrep -iv "$ignored_files"); do
    local source_file="$source_dir/$file"
    local target_file="$target_dir/$file"
    _link "$source_file" "$target_file"
  done
  for broken_link in $(find -L "$target_dir" -maxdepth 1 -type l); do
    unlink "$broken_link" && process "- ${broken_link}"
  done
}
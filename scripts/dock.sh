#!/bin/sh
#============================================================================
# Title: Dock
# Usage: sh dock.sh
#
# Description:
# Sets up dock items according to config.json
#============================================================================

source ${DOTFILES}/scripts/utils.sh

remove_all_apps() {
  process "Removing current dock items"
  dockutil --remove all --no-restart
}

# Add apps from config, in order of app priority per space
add_apps() {
  while IFS=',' read -r app; do
    local name=$(jq -r '.' <<<"$app")
    process "Adding application $name"
    dockutil --add "/Applications/$name.app" --no-restart
  done <<EOF
$(jq -c '.dock[]' <"$DOTFILES/configs/config.json")
EOF
}

# Add folders with custom icons
add_folders() {
  while IFS=',' read -r folder; do
    local name=$(jq -r '.name' <<<"$folder")
    local view=$(jq -r '.view' <<<"$folder")
    local sort=$(jq -r '.sort' <<<"$folder")
    local icon=$(jq -r '.icon' <<<"$folder")
    local display=$(jq -r '.display' <<<"$folder")
    process "Adding folder $name"
    dockutil --add "$HOME/$name" --view $view --display $display --sort $sort --no-restart
    process "Setting $name icon"
    fileicon -q set "$HOME/$name" "$DOTFILES/icons/$icon"
  done <<EOF
$(jq -c '.dockFolders[]' <"$DOTFILES/configs/config.json")
EOF
}

restart_dock() {
  process "Restarting dock"
  killall Dock
}

main() {
  info "Setting up dock"
  remove_all_apps
  add_apps
  add_folders
  restart_dock
  success "Dock set up"
}

main
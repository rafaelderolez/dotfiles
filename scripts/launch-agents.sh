#!/bin/zsh
#============================================================================
# Title: Setup launch agents
# Usage: sh launch-agents.sh
#
# Description:
# Symlinks launch agents from ../launch-agents to ~/Library/LaunchAgents
# then reloads them
#============================================================================

source ${DOTFILES}/scripts/symlink.sh
source ${DOTFILES}/scripts/utils.sh

dotfile_launch_agents=$DOTFILES/launch-agents
system_launch_agents=$HOME/Library/LaunchAgents

symlink_dir_files "$dotfile_launch_agents" "$system_launch_agents"

info "Loading Launch Agents"
for file in $dotfile_launch_agents/*.plist; do
  filename=$(basename "$file")
  path="$HOME/Library/LaunchAgents/$filename"
  
  if [ -f "$path" ]; then
      warn "Unloading $filename"
      launchctl unload $path
  fi

  launchctl load $path
  success "Loading $path"
done

echo
success "All launch agents started"

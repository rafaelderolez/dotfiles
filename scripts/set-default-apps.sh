#!/bin/bash
#============================================================================
# Title: Set default apps
# Usage: sh set-default-apps.sh
#
# Description:
# Uses duti to set default applications for various document types
#============================================================================

source ${DOTFILES}/scripts/utils.sh

set_associations() {
  info "Setting default applications for file types"
  jq -c '.fileAssociations[]' $DOTFILES/config.json |
    while read associations; do
      local application=$(jq -r '.application' <<<"$associations")
      local bundleId=$(jq -r '.bundleId' <<<"$associations")
      local extensions=$(jq -r '.extensions' <<<"$associations")
      process "Setting file types for $application"
      echo $extensions | jq -r '.[]' | while read extension; do
        process "$extension"
        duti -s $bundleId $extension all
      done
    done
  success "Default applications configured"
}

set_associations

source ${DOTFILES}/scripts/utils.sh

setup_ssh_key() {
  process "Searching for an SSH key..."
  local ssh_key_dir=$HOME/.ssh
  local public_key=$ssh_key_dir/id_ed25519.pub
  local private_key=$ssh_key_dir/id_ed25519
  if test -f "$private_key"; then
    warn "An existing SSH key was found ($private_key) and copied to your clipboard"
  else
    log "No SSH key was found, creating directory"
    mkdir -p "$ssh_key_dir/"

		read -p 'Email: ' EMAIL
		log "Generating key for $EMAIL"
		ssh-keygen -t ed25519 -C $EMAIL -f $private_key

    log "Running SSH agent:"
    eval $(ssh-agent -s)
  
    ssh-add -K $ssh_key_path
  fi
  
  alt "Paste your ssh key to Github while homebrew and npm do their thing."
	alt "https://github.com/settings/keys"
  pbcopy < $public_key
}

setup_ssh_key
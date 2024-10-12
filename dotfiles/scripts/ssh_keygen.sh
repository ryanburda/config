#!/bin/zsh

is_valid_email() {
    regex='^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    [[ $1 =~ $regex ]]
}

# Prompt the user for email address.
while true; do
    read -r "email?Enter email address: "

    if is_valid_email "$email"; then
        break
    else
        echo "Invalid email address. Please try again."
    fi
done

# Generate ssh key.
ssh-keygen -t rsa -b 4096 -C $email
# Start the ssh-agent.
eval "$(ssh-agent -s)"

# Add SSH private key to the ssh-agent.
if [[ $OSTYPE == darwin* ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
else
    ssh-add ~/.ssh/id_ed25519
fi

gh auth login

# Give the ssh key a title in GitHub.
ssh_key_name_default="$(whoami)_$(date +%Y%m%d_%H%M%S)"
read "ssh_key_name?Enter GitHub ssh key title (default: $ssh_key_name_default): "

if [[ -z "$ssh_key_name" ]]; then
  ssh_key_name=$ssh_key_name_default
fi

# Add the ssh key to GitHub.
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing --title $ssh_key_name

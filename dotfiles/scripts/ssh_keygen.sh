#!/bin/zsh

echo "########################################"
echo "#          SSH Key Generation          #"
echo "########################################"
echo

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
ssh-keygen -t ed25519 -C $email
# Start the ssh-agent.
eval "$(ssh-agent -s)"

# Add SSH private key to the ssh-agent.
if [[ $OSTYPE == darwin* ]]; then
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
else
    ssh-add ~/.ssh/id_ed25519
fi

gh auth login

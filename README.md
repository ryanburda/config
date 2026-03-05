# config

Configuration and dotfiles.

### Setup Steps

1) Clone repo and run setup
```sh
PROJECT_DIR="${HOME}/code/config/config"

if [[ ! -d "${PROJECT_DIR}/.git" ]]; then
    git clone git@github.com:ryanburda/config.git $PROJECT_DIR
fi

if [[ "$(uname)" == "Darwin" ]]; then
    "$PROJECT_DIR/setup_macos.sh"
else
    "$PROJECT_DIR/setup_arch.sh"
fi
```

2) Restart

3) Generate SSH keys
``` zsh
ssh_keygen
```

4) Setup all other repos
- https://github.com/ryanburda/repos

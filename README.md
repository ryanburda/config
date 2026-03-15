# config

Configuration and dotfiles.

### Setup Steps

1) Clone repo and run setup
```sh
mkdir "{$HOME}/code"
BARE="${HOME}/code/config/.git"
WT="${HOME}/code/config/config"

git clone --bare git@github.com:ryanburda/config.git "$BARE"
git -C "$BARE" worktree add "$WT" main
git -C "$BARE" worktree lock "$WT"

if [[ "$(uname)" == "Darwin" ]]; then
    "$WT/setup_macos.sh"
else
    "$WT/setup_arch.sh"
fi
```

2) Restart

3) Generate SSH keys
``` zsh
ssh_keygen
```

4) Setup all other repos
- https://github.com/ryanburda/repos

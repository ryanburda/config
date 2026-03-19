# config

Configuration and dotfiles.

### Setup Steps

1) Clone repo and run setup
```sh
mkdir "${HOME}/code"
BARE="${HOME}/code/config/.git"
WT="${HOME}/code/config/base"

git clone --bare git@github.com:ryanburda/config.git "$BARE"
git -C "$BARE" config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
git -C "$BARE" for-each-ref --format='%(refname:short)' refs/heads/ \
    | grep -v '^main$' \
    | xargs git -C "$BARE" branch -D 2>/dev/null
git -C "$BARE" fetch origin
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

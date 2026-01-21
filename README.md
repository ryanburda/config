# config

Configuration and dotfiles.

### Setup Steps

1) Clone repo in home directory
``` zsh
git clone https://github.com/ryanburda/config.git
```

2) Run setup script
``` zsh
./config/setup_arch.sh
# OR
# ./config/setup_macos.sh
```

3) Restart

4) Generate SSH keys
``` zsh
ssh_keygen
```

5) Setup all other repos
``` zsh
./config/setup_repos.sh
```

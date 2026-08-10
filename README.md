# config

Configuration and dotfiles.

## First time setup

### 1) Clone over HTTPS

No SSH key exists yet so we'll clone it without one for now.
The remote gets switched to SSH in step 5.

```sh
git clone https://github.com/ryanburda/config.git ~/code/config
```

### 2) Run setup

```sh
cd ~/code/config
./setup.sh
```

### 3) Reboot

### 4) Switch to SSH remote

```zsh
ssh_keygen
git -C ~/code/config remote set-url origin git@github.com:ryanburda/config.git
```

### 5) Set up all other repos (PRIVATE)

I keep a separate private repository for project setup.

```zsh
git clone git@github.com:ryanburda/repos.git ~/code/repos
cd ~/code/repos/setup.sh
```

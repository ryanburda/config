#!/bin/zsh

# Stop at the first failed command. Without this, any failure partway through
# like an unavailable package, a stow conflict, a failed build just scrolls past
# and the script still prints "Setup complete!" at the end, leaving a machine
# that looks set up but isn't. Steps that are expected to fail on a fresh
# install are tolerated explicitly below.
set -e
trap 'echo >&2; echo "setup_macos.sh: FAILED at line ${LINENO}" >&2' ZERR

REPO_ROOT="${0:A:h}"

# Create any directories you'll need.
# NOTE: This is important since stow will "fold" directories if they don't already exist.
mkdir -p $HOME/.config
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/share
# ~/.claude must be a real directory, not a folded symlink into this repo --
# Claude Code writes credentials, session history, and project state into it,
# and only settings.json belongs under version control.
mkdir -p $HOME/.claude
# ~/.ssh must be a real directory, not a folded symlink into this repo --
# the bootstrap repo's github_ssh.sh writes a private key into it.
mkdir -p $HOME/.ssh
chmod 700 $HOME/.ssh

# ~/.gitconfig must exist, even empty. The static config is stowed to
# ~/.config/git/config, which git reads as a second global file -- but when
# ~/.gitconfig is absent, `git config --global` and `gh auth setup-git` fall
# back to writing ~/.config/git/config instead, which is a symlink into this
# repo. An empty file here keeps every tool write in $HOME.
touch $HOME/.gitconfig

# Install Homebrew
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # A fresh install only adds brew to PATH via shell profile, which doesn't
    # affect this already-running script -- so load it into this session too.
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
else
    brew update
fi

brew install \
    1password-cli \
    automake \
    bat \
    bottom \
    cloud-sql-proxy \
    cmake \
    composer \
    coreutils \
    curl \
    deno \
    direnv \
    fd \
    ffmpeg \
    fzf \
    fzy \
    gettext \
    gh \
    gifsicle \
    git-delta \
    go \
    jq \
    k9s \
    kubectl \
    kubectx \
    kubetui \
    lazydocker \
    lazygit \
    libpq \
    libtool \
    lsd \
    lua \
    neovim \
    ninja \
    node \
    npm \
    php \
    pkg-config \
    pspg \
    ripgrep \
    rlwrap \
    stow \
    tmux \
    tree-sitter \
    uv \
    wget

brew link --force libpq
$(brew --prefix)/opt/fzf/install --all

# kanata
# --HEAD because the stable release (as of writing) only supports
# Karabiner-DriverKit-VirtualHIDDevice v6.2.0, while the driver bundled by the
# karabiner-elements cask below is v8.0.0. Switch to a plain `brew install
# kanata` once a stable release supports v8.0.0.
# Runs as a *root* LaunchDaemon via `brew services` -- unlike the Arch user
# service, macOS kanata must be root because the VirtualHIDDevice daemon's
# IPC socket is root-only.
brew install --HEAD kanata

# Fonts
brew install --cask \
    font-caskaydia-mono-nerd-font \
    font-departure-mono-nerd-font \
    font-fira-mono-nerd-font \
    font-gohufont-nerd-font \
    font-hack-nerd-font \
    font-inconsolata-go-nerd-font \
    font-jetbrains-mono-nerd-font \
    font-martian-mono-nerd-font \
    font-recursive-mono-nerd-font \
    font-terminess-ttf-nerd-font

# Applications
# NOTE: karabiner-elements is installed *only* to bootstrap and own the
# Karabiner-DriverKit-VirtualHIDDevice driver that kanata (above) depends on --
# uninstalling this cask deletes /Library/Application Support/org.pqrs, which
# would take the driver out from under kanata. After install, approve the
# driver extension when prompted, then disable Karabiner-Elements' own
# background processes in System Settings > General > Login Items &
# Extensions > "Allow in the Background" (leave the Driver Extensions toggle
# for org.pqrs.Karabiner-DriverKit-VirtualHIDDevice on).
brew install --cask \
    1password \
    alfred \
    blackhole-2ch \
    claude-code \
    google-chrome \
    karabiner-elements \
    keycastr \
    obsidian \
    rancher \
    rectangle \
    shifty \
    spotify \
    wezterm@nightly

# Symlink config files
stow -d "$REPO_ROOT/dotfiles" -t ~ common macos

# kanata needs two TCC permissions that can't be granted non-interactively:
# System Settings > Privacy & Security > Input Monitoring, and > Accessibility.
# Add the binary at `readlink -f $(brew --prefix)/opt/kanata/bin/kanata`
# (resolve the symlink -- TCC grants are pinned to the real Cellar path and
# need to be redone after any `brew upgrade/reinstall kanata`) to both, then:
sudo brew services start kanata

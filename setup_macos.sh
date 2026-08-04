#!/bin/zsh

# Install Homebrew
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install tree-sitter-cli

# Symlink config files
stow -d dotfiles -t ~ common macos

# kanata needs two TCC permissions that can't be granted non-interactively:
# System Settings > Privacy & Security > Input Monitoring, and > Accessibility.
# Add the binary at `readlink -f $(brew --prefix)/opt/kanata/bin/kanata`
# (resolve the symlink -- TCC grants are pinned to the real Cellar path and
# need to be redone after any `brew upgrade/reinstall kanata`) to both, then:
sudo brew services start kanata

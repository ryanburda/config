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
    poetry \
    pspg \
    ripgrep \
    rlwrap \
    stow \
    tmux \
    uv \
    wget

brew link --force libpq
$(brew --prefix)/opt/fzf/install --all

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

# Symlink config files
stow -d dotfiles -t ~ common
# NOTE: there aren't any files that need symlinking in dotfiles/macos as of now.
# stow -d dotfiles -t ~ macos

# karabiner.json needs to be copied, not symlinked
# https://karabiner-elements.pqrs.org/docs/manual/misc/configuration-file-path/
mkdir -p "${HOME}/.config/karabiner"
SCRIPT_DIR=${0:a:h}
cp "${SCRIPT_DIR}/dotfiles/macos/.config/karabiner.json" "${HOME}/.config/karabiner/karabiner.json"

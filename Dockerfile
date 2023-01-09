FROM ubuntu:23.04

WORKDIR /root

RUN apt-get update && apt-get install -y \
    sudo \
    zsh \
    tar \
    curl \
    git \
    coreutils \
    tmux \
    tmate \
    tmuxinator \
    fzf \
    wget \
    golang \
    htop \
    lua5.4 \
    ripgrep \
    jq \
    rlwrap \
    pspg \
    neovim
    # diff-so-fancy \
    # deno \
    # node \
    # node@16 \

# lazygit
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')_Linux_x86_64.tar.gz"
RUN sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

# lazydocker
RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

RUN chsh -s /bin/zsh

# Neovim
# RUN curl -Lo nvim-linux64.tar.gz https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
# RUN tar xzvf nvim-linux64.tar.gz
# RUN ./nvim-linux64/bin/nvim
RUN ln -svfF ./dotfiles/nvim $XDG_CONFIG_HOME/nvim

ENV CONFIG_DIR = /opt/config
COPY . $CONFIG_DIR

# Symlink config files
RUN ln -svfF "${CONFIG_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/tmate.conf" "${HOME}/.tmate.conf"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
# RUN ln -svfF "${CONFIG_DIR}/dotfiles/lazygit.yml" "${HOME}/Library/Application Support/lazygit/config.yml"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"

CMD ["zsh"]

FROM ubuntu:23.04

ENV HOME=/root
WORKDIR $HOME

RUN apt-get update && apt-get install -y \
    sudo \
    make \
    man \
    zsh \
    tar \
    curl \
    openssl \
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
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    curl \
    doxygen
    # pspg
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
ENV NEOVIM_REPO_DIR="${HOME}/.neovim"
RUN git clone https://github.com/neovim/neovim.git $NEOVIM_REPO_DIR
RUN cd $NEOVIM_REPO_DIR && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make distclean && sudo make install

# Copy in config repo
ENV CONFIG_DIR=$HOME/Developer/config
COPY . $CONFIG_DIR

# Symlink config files
RUN ln -svfF "${CONFIG_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/tmate.conf" "${HOME}/.tmate.conf"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"
RUN mkdir -p "${HOME}/.config"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/nvim" "${HOME}/.config/nvim"
RUN mkdir -p "${HOME}/.config/lazygit"
RUN ln -svfF "${CONFIG_DIR}/dotfiles/lazygit.yml" "${HOME}/.config/lazygit/config.yml"

CMD ["zsh"]

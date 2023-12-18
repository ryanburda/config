FROM ubuntu:23.04

WORKDIR /usr/src

RUN apt-get update && apt-get install -y \
    sudo \
    coreutils \
    software-properties-common \
    make \
    man \
    zsh \
    tar \
    curl \
    openssl \
    git \
    tmux \
    tmate \
    tmuxinator \
    fzf \
    wget \
    golang \
    htop \
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
    doxygen \
    pspg

# neovim
RUN git clone https://github.com/neovim/neovim.git
RUN cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make distclean && sudo make install

# node
RUN curl -fsSL https://deb.nodesource.com/deb/setup_16.x | sudo -E bash -
RUN apt-get update && apt-get install -y nodejs
RUN apt-get install -y npm

# diff-so-fancy
RUN git clone https://github.com/so-fancy/diff-so-fancy.git /usr/local/bin/diff-so-fancy
ENV PATH="$PATH:/usr/local/bin/diff-so-fancy"

# lazygit
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')_Linux_x86_64.tar.gz"
RUN sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

# lazydocker
RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
RUN chsh -s /bin/zsh

# Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy in code and symlink config files
ENV PROJECT_DIR=/usr/local/config
ENV HOME=/root

WORKDIR ${PROJECT_DIR}

COPY . .

RUN ln -svfF "${PROJECT_DIR}/dotfiles/zshrc" "${HOME}/.zshrc"
RUN mkdir -p "${HOME}/.zsh/funcs"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/find_file" "${HOME}/.zsh/funcs/find_file"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/set_font" "${HOME}/.zsh/funcs/set_font"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/font_picker" "${HOME}/.zsh/funcs/font_picker"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/nvim_open" "${HOME}/.zsh/funcs/nvim_open"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/psqlp" "${HOME}/.zsh/funcs/psqlp"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/select_session" "${HOME}/.zsh/funcs/select_session"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/theme_picker" "${HOME}/.zsh/funcs/theme_picker"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/tse" "${HOME}/.zsh/funcs/tse"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/tmux.conf" "${HOME}/.tmux.conf"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/tmate.conf" "${HOME}/.tmate.conf"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/gitconfig" "${HOME}/.gitconfig"
RUN mkdir -p ~/.config/lazygit
RUN ln -svfF "${PROJECT_DIR}/dotfiles/lazygit.yml" "${HOME}/.config/lazygit/config.yml"
RUN mkdir -p ~/.config/lf
RUN curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o ~/.config/lf/icons
RUN ln -svfF "${PROJECT_DIR}/dotfiles/lfrc" "${HOME}/.config/lf/lfrc"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/psqlrc" "${HOME}/.psqlrc"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/pspgconf" "${HOME}/.pspgconf"
RUN mkdir -p "${HOME}/.config/tmux/plugins/tmux/src"
RUN ln -svfF "${PROJECT_DIR}/dotfiles/nord-status-content.conf" "${HOME}/.config/tmux/plugins/tmux/src/nord-status-content.conf"

# Let zsh and nvim set themselves up now that the configs have been linked
RUN ${HOME}/.zshrc
RUN nvim --headless "+Lazy! sync" +qa

ENTRYPOINT ["/bin/zsh"]

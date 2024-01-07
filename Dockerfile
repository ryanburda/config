# Installs tools needed by the `developer` user and starts a tmux server.
FROM ubuntu:23.04

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    cmake \
    coreutils \
    curl \
    doxygen \
    fzf \
    git \
    golang \
    htop \
    jq \
    libtool \
    libtool-bin \
    make \
    man \
    neovim \
    openssl \
    pkg-config \
    postgresql-client \
    pspg \
    ripgrep \
    rlwrap \
    software-properties-common \
    sudo \
    tar \
    tmux \
    tmuxinator \
    unzip \
    wget \
    zsh \

RUN yes | unminimize


# neovim
WORKDIR /usr/local/bin
RUN git clone https://github.com/neovim/neovim
WORKDIR /usr/local/bin/neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN sudo make install
# node is needed for mason lsp in neovim
RUN curl -fsSL https://deb.nodesource.com/deb/setup_16.x | sudo -E bash -
RUN apt-get update && apt-get install -y nodejs
RUN apt-get install -y npm

WORKDIR /usr/local/bin

# lazygit
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')_Linux_x86_64.tar.gz"
RUN sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
# lazydocker
RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN useradd -m developer
RUN echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer
USER developer
WORKDIR /home/developer

ENV TERM=xterm-256color
ENV SHELL=/bin/zsh
ENV XDG_CONFIG_HOME=/home/developer/.config

RUN mkdir -p /home/developer/.config
RUN mkdir -p /home/developer/Developer

# Copy in code and symlink config files
ENV PROJECT_DIR=/home/developer/Developer/config
COPY . ${PROJECT_DIR}

RUN ln -svfF "${PROJECT_DIR}/dotfiles/zshrc"     /home/developer/.zshrc
RUN ln -svfF "${PROJECT_DIR}/dotfiles/gitconfig" /home/developer/.gitconfig
RUN ln -svfF "${PROJECT_DIR}/dotfiles/nvim"      /home/developer/.config/nvim

RUN mkdir -p                                                    /home/developer/.config/tmux
RUN ln -svfF "${PROJECT_DIR}/dotfiles/tmux.conf"                /home/developer/.config/tmux/tmux.conf

RUN mkdir -p                                                /home/developer/.zsh/funcs
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/find_file"      /home/developer/.zsh/funcs/find_file
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/set_font"       /home/developer/.zsh/funcs/set_font
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/font_picker"    /home/developer/.zsh/funcs/font_picker
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/nvim_open"      /home/developer/.zsh/funcs/nvim_open
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/psqlp"          /home/developer/.zsh/funcs/psqlp
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/select_session" /home/developer/.zsh/funcs/select_session
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/theme_picker"   /home/developer/.zsh/funcs/theme_picker
RUN ln -svfF "${PROJECT_DIR}/dotfiles/funcs/tse"            /home/developer/.zsh/funcs/tse

RUN mkdir -p                                       /home/developer/.config/lazygit
RUN ln -svfF "${PROJECT_DIR}/dotfiles/lazygit.yml" /home/developer/.config/lazygit/config.yml

RUN mkdir -p                                                                       /home/developer/.config/lf
RUN curl https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example -o /home/developer/.config/lf/icons
RUN ln -svfF "${PROJECT_DIR}/dotfiles/lfrc"                                        /home/developer/.config/lf/lfrc

RUN ln -svfF "${PROJECT_DIR}/dotfiles/psqlrc"   /home/developer/.psqlrc
RUN ln -svfF "${PROJECT_DIR}/dotfiles/pspgconf" /home/developer/.pspgconf

# Let zsh and nvim set themselves up now that the configs have been linked
RUN ./.zshrc
RUN nvim --headless "+Lazy! sync" +qa

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

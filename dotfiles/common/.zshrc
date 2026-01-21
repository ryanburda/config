#!/bin/zsh

# Uncomment to profile zsh startup.
# NOTE: must also uncomment last line.
# zmodload zsh/zprof

PROMPT="%B%F{cyan%}$(whoami) %B%F{green}%~"$'\n%B%F{yellow}%D{%H:%M:%S} '"%F{cyan}󰅂 %b"

export XDG_CONFIG_HOME=$HOME/.config

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt +o nomatch

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Set default editor and pager
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

# Add to PATH
fpath=(
  ~/.zsh/funcs
  "${fpath[@]}"
)
autoload -Uz dark_mode
autoload -Uz psqlp
autoload -Uz tmux_session_select
autoload -Uz tmuxinator_session_select
autoload -Uz find_file
autoload -Uz ssh_keygen

for file in ~/.zsh/funcs/**.sh; do
    [ -r "$file" ] && source "$file"
done

# Raise max files and max procs
ulimit -n 200000
ulimit -u 2048

# zsh-vi-mode will overwrite keybindings unless they are added to `zvm_after_init_commands`.
# https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# Arch specific
[[ -f /etc/arch-release ]] && zvm_after_init_commands+=('[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh')

function zvm_after_init() {
  bindkey '^p' history-search-backward
  bindkey '^n' history-search-forward

  autoload edit-command-line
  zle -N edit-command-line
  bindkey '^o' edit-command-line
}

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}' \
  --bind=ctrl-d:preview-half-page-down
  --bind=ctrl-u:preview-half-page-up
  --bind=ctrl-i:previous-history
  --bind=ctrl-o:next-history
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy path into clipboard'"
export FZF_CTRL_R_OPTS="
  --bind=ctrl-i:previous-history
  --bind=ctrl-o:next-history
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_HISTORY_DIR=1

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
# https://github.com/pyenv/pyenv-virtualenv/issues/259
# eval "$(pyenv virtualenv-init -)"

# ChatGPT
OPENAI_API_KEY_FILE=$HOME/.openai_api_key
if [ -f $OPENAI_API_KEY_FILE ]; then
  export OPENAI_API_KEY=$(cat $OPENAI_API_KEY_FILE)
else
  export OPENAI_API_KEY=""
fi

# Rancher
export PATH="$HOME/.rd/bin:$PATH"

# Arch specific
if [[ -f /etc/arch-release ]]; then
  # tmuxinator specific (can only be installed via gem)
  export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  export PATH="$PATH:$GEM_HOME/bin"
  # claude specific
  export PATH="$HOME/.local/bin:$PATH"
fi

# Alias
alias l="lsd -lah"
alias s="tmux_session_select"
alias cal="cal -3"
alias ai="claude"
alias rg="rg --hidden"

# zshrc Extensions
# Looks for executable files in directory.
for file in ~/.zsh/zshrc_extensions/*; do
  if [[ -x "$file" ]]; then
    source "$file"
  fi
done

# Uncomment to profile zsh startup.
# NOTE: must also uncomment first line.
# zprof

#!/bin/zsh

tldr_fzf() {
    thing=$(tldr -l | sort | fzf --cycle \
                                 --preview 'tldr {}' \
                                 --bind=ctrl-d:preview-half-page-down \
                                 --bind=ctrl-u:preview-half-page-up \
                                 --bind=ctrl-i:previous-history \
                                 --bind=ctrl-o:next-history)

    if [[ ! -z $thing ]]; then
        tldr $thing | nvim -R
    fi
}

#!/bin/zsh

###############
# Setup Repos #
###############
REPOS_PROJECT_DIR=$HOME/Developer/repos
mkdir -p $REPOS_PROJECT_DIR

if [[ ! -d "${REPOS_PROJECT_DIR}/.git" ]]; then
    git clone git@github.com:ryanburda/repos.git $REPOS_PROJECT_DIR
fi

cd $REPOS_PROJECT_DIR
./setup.sh

#!/bin/zsh
SCRIPT_DIR=${0:a:h}
REPO_DIR=$HOME/Developer/sqsp/krabs
SCRATCH_DIR=$HOME/Developer/scratch/src/krabs

# make the scratch directory
mkdir -p SCRATCH_DIR

# symlink the tmuxinator yml.
ln -svfF "$SCRIPT_DIR/session.yml" "$HOME/.config/tmuxinator/krabs.yml"

# Clone the repo
if [[ ! -d $REPO_DIR ]]; then
    git clone git@github.com:sqsp/krabs.git $REPO_DIR
fi

docker pull postgres:11.13
docker volume create postgres-krabs-volume

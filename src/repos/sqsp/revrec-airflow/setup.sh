#!/bin/zsh
SCRIPT_DIR=${0:a:h}
REPO_DIR=$HOME/Developer/sqsp/revrec-airflow
SCRATCH_DIR=$HOME/Developer/scratch/src/revrec-airflow

# make the scratch directory
mkdir -p SCRATCH_DIR

# symlink the tmuxinator yml.
ln -svfF "$SCRIPT_DIR/session.yml" "$HOME/.config/tmuxinator/rr.yml"

# Clone the repo
if [[ ! -d $REPO_DIR ]]; then
    git clone git@github.com:sqsp/revrec-airflow.git $REPO_DIR
fi

# Create a python virtual environment
PYENV_PYTHON_VERSION="3.6.4"
VENV_NAME="revrec-airflow"
pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > $REPO_DIR/.python-version

docker pull postgres:11.13
docker volume create postgres-rr-volume

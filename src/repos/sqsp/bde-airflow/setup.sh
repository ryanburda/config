#!/bin/zsh
SCRIPT_DIR=${0:a:h}
REPO_DIR=$HOME/Developer/sqsp/bde-airflow
SCRATCH_DIR=$HOME/Developer/scratch/src/bde-airflow

# make the scratch directory
mkdir -p SCRATCH_DIR

# symlink the tmuxinator yml
ln -svfF "$SCRIPT_DIR/session.yml" "$HOME/.config/tmuxinator/dv.yml"

# Clone the repo
if [[ ! -d $REPO_DIR ]]; then
    git clone git@github.com:sqsp/bde-airflow.git $REPO_DIR
fi

# Create a python virtual environment
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="bde-airflow"
pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > $REPO_DIR/.python-version

# Pull a postgres image and create a volume
docker pull postgres:10.3
docker volume create postgres-dv-volume

#!/bin/zsh
SCRIPT_DIR=${0:a:h}
REPO_DIR=$HOME/Developer/sqsp/revrec-airflow
SCRATCH_DIR=$HOME/Developer/scratch/src/revrec-airflow

# make the scratch directory
mkdir -p $SCRATCH_DIR
mkdir -p $SCRATCH_DIR/python
mkdir -p $SCRATCH_DIR/sql

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

# Activate the virtualenv when entering the following directories.
echo $VENV_NAME > $REPO_DIR/.python-version
echo $VENV_NAME > $SCRATCH_DIR/.python-version

# Add a .pth file to the site-packages directory of the virtualenv so that the repo is accessible
# whenever the virtualenv is active.
pyenv activate $VENV_NAME
SITE_PACKAGES_PATH=$(python -c 'import site; print(site.getsitepackages()[0])')
echo $REPO_DIR/docker/code > $SITE_PACKAGES_PATH/.pth
pyenv deactivate

# Pull a postgres image and create a volume
docker pull postgres:11.13
docker volume create postgres-rr-volume

#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/revrec-airflow"
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="revrec-airflow"

git clone ssh://git@code.squarespace.net:7999/data/revrec-airflow.git $DIR

brew install pyenv
brew install pyenv-virtualenv
brew cask install 1password-cli

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > "${DIR}/.python-version"

# Get password information
# TODO

# Run the make command in a subshell
# TODO: fix this
# (cd $DIR; pyenv activate $VENV_NAME; make pip-install)


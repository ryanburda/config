#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/db_role_administration"
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="db_role_administration"

git clone ssh://git@code.squarespace.net:7999/data/db_role_administration.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > "${DIR}/.python-version"

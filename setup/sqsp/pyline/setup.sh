#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/pyline"
PYENV_PYTHON_VERSION="2.7.13"
VENV_NAME="pyline"

git clone ssh://git@code.squarespace.net:7999/data/pyline.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > "${DIR}/.python-version"

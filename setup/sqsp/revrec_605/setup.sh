#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/revrec_605"
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="revrec_605"

git clone ssh://git@code.squarespace.net:7999/data/revrec_605.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME

echo $VENV_NAME > "${DIR}/.python-version"

#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/balance"
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="balance"

git clone ssh://git@code.squarespace.net:7999/itl/balance.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME

echo $VENV_NAME > "${DIR}/.python-version"

brew install direnv
echo "kubectl -n balance-corp get pods" > "${DIR}/.envrc"

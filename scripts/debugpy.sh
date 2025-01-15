#!/bin/zsh

PYENV_PYTHON_VERSION="3.11.7"
VENV_NAME="debugpy"
pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv activate $VENV_NAME
pip install debugpy

#!/usr/bin/env bash

DIR="${HOME}/Developer/projects/revrec-airflow"
PYENV_PYTHON_VERSION="3.6.4"
VENV_NAME="revrec-airflow"

git clone ssh://git@code.squarespace.net:7999/data/revrec-airflow.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME
echo $VENV_NAME > "${DIR}/.python-version"

# Automatically switch AIRFLOW_HOME with direnv
brew install direnv
echo "export AIRFLOW_HOME=${DIR}" > "${DIR}/.envrc"
echo "kubectl -n revrec-airflow-prod get pods" > "${DIR}/.envrc"

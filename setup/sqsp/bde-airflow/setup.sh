DIR="${HOME}/Developer/projects/bde-airflow"
PYENV_PYTHON_VERSION="3.6.9"
VENV_NAME="bde-airflow"

git clone ssh://git@code.squarespace.net:7999/data/bde-airflow.git $DIR

brew install pyenv
brew install pyenv-virtualenv

pyenv install $PYENV_PYTHON_VERSION
pyenv virtualenv $PYENV_PYTHON_VERSION $VENV_NAME

echo $VENV_NAME > "${DIR}/.python-version"

# Run the make command in a subshell
(cd $DIR; make pip-install)

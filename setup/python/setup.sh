# https://ipython.readthedocs.io/en/stable/
brew install ipython

# https://github.com/pyenv/pyenv
brew install pyenv
pyenv install 3.8.1

# https://github.com/pyenv/pyenv-virtualenv
brew install pyenv-virtualenv

# Create a virtual environment for python 3.8
pyenv virtualenv 3.8.1 python_3.8.1

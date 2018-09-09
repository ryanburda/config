##################
# Source ~/.bashrc
##################
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

#############
# Grep Colors
#############
export GREP_COLOR='1;37;41'
alias grep=' grep --color=auto'

# virtualenv
export PATH=/usr/local/bin:$PATH
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

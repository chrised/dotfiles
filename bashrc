#!/bin/bash
#~/.bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Pull in the system shell first so we inherit any specifics (and override the ones we care about)
if [ -f /etc/profile ]; then
    source /etc/profile
fi

if [[ ${EUID} == 0 ]] ; then
    export PS1="[\[\033[1;31m\]\$(uname)\[\033[m\]:\[\033[32m\]\h\[\033[m\]]\[\033[1;31m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
else
    export PS1="[\[\033[1;31m\]\$(uname)\[\033[m\]:\[\033[32m\]\h\[\033[m\]]\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
fi

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

if [ "$(uname)" == 'Darwin' ]; then
    alias ls='ls -GFh'
else
    alias ls='ls -Fh --color=auto'
fi
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias grep='grep --color=auto --exclude-dir=.git --exclude-dir=.svn --binary-files=without-match'
export CSCOPE_DB=$HOME/.cscope.out
export PYCSCOPE_DB=$HOME/.pycscope.out

export LESSCOLOR=yes
export LESSOPEN="|lesspipe %s"

alias gitupmod='git submodule foreach --recursive git checkout master; git submodule foreach --recursive git pull'

if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi

VENV_WRAPPER="$(which virtualenvwrapper.sh 2> /dev/null)"
if [ -f "$VENV_WRAPPER" ]; then
    export WORKON_HOME="$HOME/virtualenvs"
    if [ ! -d "$WORKON_HOME" ]; then
        mkdir "$WORKON_HOME"
    fi
    source "$VENV_WRAPPER"
fi

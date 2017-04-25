#!/bin/bash
#~/.bashrc

# Do this early, so we get magic local aliases
if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi

# Test for an interactive shell.  There is no need to set anything else
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# Pull in the system shell first so we inherit any specifics (and override the ones we care about)
for rc in "/etc/profile" "${HOME}/.iterm2_shell_integration.bash" "${HOME}/.bashrc_functions"; do
    test -e "$rc" && source "$rc"
done

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
export ERLCSCOPE_DB=$HOME/.erlcscope.out

export LESSCOLOR=yes
export LESSOPEN="|lesspipe %s"
export EDITOR=vim

# Other aliaii
alias docker-clean-untagged="docker images --no-trunc | grep '<none>' | awk '{ print \$3 }' | xargs docker rmi"
alias docker-clean-dead="docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v"
alias docker-clean-volumes="docker volume ls -qf dangling=true | xargs docker volume rm"

# Elongate bash_history
HISTSIZE=5000
HISTFILESIZE=10000
# Enforce history appending
shopt -s histappend

VENV_WRAPPER="$(which virtualenvwrapper.sh 2> /dev/null)"
if [ -f "$VENV_WRAPPER" ]; then
    export WORKON_HOME="$HOME/virtualenvs"
    if [ ! -d "$WORKON_HOME" ]; then
        mkdir "$WORKON_HOME"
    fi
    source "$VENV_WRAPPER"
fi

if [ -d "${HOME}/bin" ]; then
    export PATH="${HOME}/bin:${PATH}"
fi
if [ -d "${HOME}/.cache/rebar3/bin" ]; then
    export PATH="${HOME}/.cache/rebar3/bin:${PATH}"
fi

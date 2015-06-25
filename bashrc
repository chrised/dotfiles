# ~/.bashrc

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export PS1="[\[\033[1;31m\]\$(uname)\[\033[m\]]\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

if [ $(uname) == 'Darwin' ]; then
    alias ls='ls -GFh'
else
    alias ls='ls -Fh --color=auto'
fi
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias grep='grep --exclude-dir=.git --exclude-dir=.svn'
export CSCOPE_DB=$HOME/.cscope.out
export PYCSCOPE_DB=$HOME/.pycscope.out

if [ -f $HOME/.bashrc.local ]; then
    . $HOME/.bashrc.local
fi


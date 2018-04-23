
# ------------------ Environment Variables -----------------------
export CT_DEVENV_HOME=/tools/devenv
export CT_DEVENV_SYSTEM_HOME=/tools/devenv/Linux

# Deprecated export NGL_DATASET=/autofs/navber_jenkins/navKitResources/ngl/
export NGL_DATASET=/media/lingebrig/06b9476a-c653-4c84-b07c-447d1515f2c8/navber_jenkins/navKitResources/ngl

# Deprecated export NAVKIT_DATASET=/autofs/navber_jenkins/navKitResources/navkit/
export NAVKIT_DATASET=/media/lingebrig/06b9476a-c653-4c84-b07c-447d1515f2c8/navber_jenkins/navKitResources/navkit

export P4PORT="perforce-ams.tomtomgroup.com:1666" # Use Amsterdam port as Berlin proxy is currently not working ==> desrvud-bhttp01.ber.global:1666
export P4CONFIG=".p4config"


# PATH
export PATH=$PATH:/opt/make/bin
export PATH=$PATH:/usr/share/bcc/tools
export PATH=/ssd/npmstuff/bin:$PATH


# prompt
PS1='\u:\W$ '
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_END=" \$ "
source ~/.bash-git-prompt/gitprompt.sh


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors $HOME/dircolors.ansi-dark)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# ------------------ Environment Variables -----------------------{{{
export HISTFILESIZE=50000
export HISTSIZE=10000
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit"
shopt -s histappend
#}}}}

stty -ixon  # Enabling Ctrl+S forward history search
shopt -s autocd  # dir -> cd dir
shopt -s globstar  # Recursive globbing


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

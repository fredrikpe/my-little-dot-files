# PATH
export PATH=$PATH:/opt/make/bin
export PATH=$PATH:/usr/share/bcc/tools
export PATH=/ssd/npmstuff/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

export SE_CORE=$SE_CORE:$HOME/.vim/se_core.rb


# Prompt
PS1='\u:\W$ '
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_END=" \$ "
source ~/.bash-git-prompt/gitprompt.sh

# Enable color support of ls and also add handy aliases
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

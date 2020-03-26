# PATH
export PATH=$PATH:/opt/make/bin
export PATH=$PATH:/usr/share/bcc/tools
export PATH=/ssd/npmstuff/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export SE_CORE=$SE_CORE:$HOME/.vim/se_core.rb
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$HOME/.nimble/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/opt/zig-linux-x86_64-0.5.0+d3e67d992:$PATH
export PATH=/opt/node-v12.14.1-linux-x64/bin:$PATH
export PATH=/opt/arcanist/arcanist/bin:$PATH


# Prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u:\[\033[01;34m\]\w\[\033[00m\]\$ '
#PS1='\u:\W$ '
GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_END=" \$ "
source ~/.bash-git-prompt/gitprompt.sh

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #eval "$(dircolors $HOME/dircolors.ansi-dark)"
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
shopt -s globstar  # Recursive globbing


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/fredrik/.sdkman"
[[ -s "/home/fredrik/.sdkman/bin/sdkman-init.sh" ]] && source "/home/fredrik/.sdkman/bin/sdkman-init.sh"


# For flamegraphs
export FLAMEGRAPH_DIR=/home/fredrik/git/clones/FlameGraph
export PERF_RECORD_FREQ=997

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

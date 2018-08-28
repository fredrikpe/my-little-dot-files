shopt -s expand_aliases

# Aliases
alias ll='ls -lAFh'
alias cd='pushd 2>&1 1>/dev/null'
alias ag="/usr/local/bin/ag --color-match '01;31' --color-path '6;35' --color-line-number '6;32' --no-group"
alias vimi='vim --cmd "let g:loaded_youcompleteme = 1"'

#Git aliases
alias gl="git log"
alias glf="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"

alias nvim="~/git/clones/./nvim.appimage"

git()
{
  if [[ $# -gt 0 && ( "$1" == "pull" || "$1" == "review" ) ]] ; then
    subcommand=$1
    shift
    ( exec $HOME/./git/Scripts/ask-for-confirmation.sh ) && command git "$subcommand" "$@"
  else
    command git "$@"
  fi
}


alias scabb='scan-build clang++'

# Safe rm, which puts in trash like in Nautilus.
alias trm='gvfs-trash'

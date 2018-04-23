shopt -s expand_aliases

# Aliases
alias ll='ls -lAFh'
alias cd='pushd 2>&1 1>/dev/null'
alias ag="/usr/local/bin/ag --color-match '01;31' --color-path '6;35' --color-line-number '6;32' --no-group"
alias 1build='sandbox /rssd/git/dev-routing1/Build/build.py -f /rssd/git/dev-routing1/Build/NavArt.yaml'
alias 2build='sandbox /workspace/dev-routing-clones/2/Build/build.py -f /workspace/dev-routing-clones/2/Build/NavArt.yaml'

#Git aliases
alias gl="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"
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
    ( exec /home/lingebrig/./git/Scripts/ask-for-confirmation.sh ) && command git "$subcommand" "$@"
  else
    command git "$@"
  fi
}



alias scabb='scan-build clang++'

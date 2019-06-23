shopt -s expand_aliases

# Aliases
alias ll='ls -lAFh'

# Git aliases
alias gl="git log"
alias glf="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"

curl()
{
    command curl "$@" | python -m json.tool
}

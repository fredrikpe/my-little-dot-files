shopt -s expand_aliases

# Sannsyn
alias run_commander='sbt "run 9010"'
alias aggregator_pid="ps -a | grep Aggregator | awk '{print $1;}'"
alias java_flames="/home/./fredrik/git/clones/perf-map-agent/bin/perf-java-flames"
alias rest_krouter_start="gnome-terminal --tab-with-profile=Black -e  'sh -c \"cd ~/sannsyn/git/recommender-bootstrap; ./recommender.sh start rest; exec bash\"' --tab-with-profile=Black -e 'sh -c \"cd ~/sannsyn/git/recommender-bootstrap; ./recommender.sh start krouter; exec bash\"' && exit"

# Aliases
alias ll='ls -lAFh'
alias cd='pushd 2>&1 1>/dev/null'
alias ag="/usr/bin/ag --color-match '01;31' --color-path '6;35' --color-line-number '6;32' --no-group"
alias vimi='vim --cmd "let g:loaded_youcompleteme = 1"'
alias format-java-git='git status -s | cut -c4-  | xargs java -jar ~/Downloads/google-java-format-1.6-all-deps.jar -i -a'

# Git aliases
alias gl="git log"
alias glf="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"

alias nvim="~/git/clones/./nvim.appimage"

alias scabb='scan-build clang++'

# Safe rm, which puts in trash like in Nautilus.
alias trm='gvfs-trash'

curl()
{
    command curl "$@" | python -m json.tool
}

java_prov_name()
{
    LD_PRELOAD=/home/fredrik/git/clones/procname/libprocname.so PROCNAME="$1" command "$@"
}

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

delete_iptable_rule()
{
    if sudo iptables -C $1 > /dev/null 2>&1;
    then
        sudo iptables -D $1
    fi
}

add_iptable_rule()
{
    if sudo iptables -C $1 > /dev/null 2>&1;
    then :
    else
        sudo iptables -A $1
    fi
}

close_connection_to_prod()
{
    add_iptable_rule 'INPUT -s 10.0.0.5 -j DROP'
    add_iptable_rule 'INPUT -s 10.0.0.6 -j DROP'
}

open_connection_to_prod()
{
    delete_iptable_rule 'INPUT -s 10.0.0.5 -j DROP'
    delete_iptable_rule 'INPUT -s 10.0.0.6 -j DROP'
}

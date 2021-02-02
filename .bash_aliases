shopt -s expand_aliases

# Aliases
alias ll='ls -lAFh'
alias bc='bc -l <<<'
alias rg='rg --hidden'

# Git aliases
alias gl="git log"
alias glf="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit"

alias jsonless="python -m json.tool | less"

ca()
{
    bc "$@"
}

jcurl()
{
    command curl "$@" | python -m json.tool
}

coauthors()
{
    if [[ $# -eq 0 ]] ; then
        echo -e "usage: coauthors search_terms..."
        return
    fi
    local all_authors=$(git log | sed -nE "s/.*uthor.*: (.*)/\1/p" | sort | uniq -c | sort -nr)

    local result=""
    for search_term in "$@"; do
        if author=$(echo "$all_authors"| grep $search_term | head -n1 | sed -nE "s/.*[[:digit:]]+ (.*)/\1/p"); then
            result=$result$'Co-authored-by: '$author$'\n'
        fi
    done

    echo "$result" | pbcopy
    echo "$result"
}

# Safe k8s
k() {
    local current_context=$(kubectl config current-context)

    if ! [[ $current_context =~ ^prod.*$ ]]
    then
        kubectl "$@"
        return $?
    fi

    read -p "You are in prod. Sure you want to do this? " -n 1 -r
    echo
    if ! [[ $REPLY =~ ^[Y]$ ]]
    then
        return 2
    fi

    kubectl "$@"
}

podname()
{
    echo "$(kubectl get pods | rg "$@" | choose 0)"
}

port_forward()
{
    if [ "$#" -lt 2 ]; then
        echo "Usage: port_forward [port] [pod-search ...]"
        return 2
    fi

    local port="$1"
    shift

    local pods=$(kubectl get pods | rg "$1")
    echo "Found these pods:"
    echo "$pods"
    echo ""

    local target=$(echo "$pods" | choose 0 | head -n1)
    local container_port=$(kubectl get pod $target --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}')

    echo "Forwarding from $target"
    echo ""
    kubectl port-forward pods/$target $port:$container_port
}


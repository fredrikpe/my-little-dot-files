shopt -s expand_aliases

# Aliases
alias less='less --incsearch'
alias ll='ls -lAFh'
alias bc='bc -l <<<'
alias rg='rg --hidden'
alias python='python3'

# Git aliases
alias glf="git log --graph --date=format-local:'%d.%m.%y %H:%M' --pretty=format:'%Cred%>|(15)%h %C(yellow)%<|(29,trunc)%an %C(green)%ad  %C(yellow)%<|(60,trunc)%cn %C(green)%cd %C(bold blue)%d %Creset%s'"

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
            if [ -z "$result" ]; then
                result=$'Co-authored-by: '$author
            else
                result=$result$'\n'$'Co-authored-by: '$author
            fi
        fi
    done

    echo "$result" | pbcopy
    echo "$result"
}

# Safe k8s
#k() {
    #local current_context=$(kubectl config current-context)
#
    #if ! [[ $current_context =~ ^prod.*$ ]]
    #then
        #kubectl "$@"
        #return $?
    #fi

    #read -p "You are in prod. Sure you want to do this? " -n 1 -r
    #echo
    #if ! [[ $REPLY =~ ^[Y]$ ]]
    #then
        #return 2
    #fi
#
    #kubectl "$@"
#}

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

    local pods=$(kubectl get pods --all-namespaces | rg "$1")
    echo "Found these pods:"
    echo "$pods"
    echo ""

    local target=$(echo "$pods" | cut -d' ' -f2 | head -n1)
    echo $target
    local container_port=$(kubectl get pod -n nais $target --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}')

    echo "Forwarding from $target"
    echo ""
    kubectl port-forward pods/$target $port:$container_port
}

alias weeknumber='date +"%V"'


url_psql_fra_vault()
{
    if [ "$#" -lt 2 ]; then
        echo "Usage: postgres_url <env> <database>"
        return 2
    fi

    if ! vault token lookup 2>&1 > /dev/null; then
        vault login -method=oidc > /dev/null
    fi

    local db_host="dev-pg.intern.nav.no:5432"
    if [ "$1" = "prod-fss" ]; then
        db_host="prod-pg.intern.nav.no:5432"
    fi

    local vault_credentials=$(vault read postgresql/"$1"/creds/"$2"-readonly)
    local password=$(echo "$vault_credentials" | tail -n2 | head -n1 | awk '{print $2}')
    local username=$(echo "$vault_credentials" | tail -n1 | awk '{print $2}')
    echo "postgres://$username:$password@$db_host/$2" | pbcopy
    echo "postgres://$username:$password@$db_host/$2"
}

klogs()
{
    if [ "$#" -lt 2 ]; then
        echo "Usage: klogs <namespace> <pod>"
        return 2
    fi


    local container=$(echo "$2" | sed -nE "s/(.*)-[[:digit:]]{10}.*/\1/p")

    kubectl logs -n "$1" "$2" -c "$container"
}

sternl()
{
    stern --color=always "$@" > /tmp/stern-tmp &
    local stern_pid=$(echo $!)
    less -R /tmp/stern-tmp
    kill -sigint $stern_pid
    rm /tmp/stern-tmp
}

hedo() {
    if id | grep -o "80(admin)" >/dev/null; then
        echo "I Have The Power"
    else
        echo "By The Power Of Greyskull"
        /Applications/Privileges.app/Contents/Resources/PrivilegesCLI --add
        echo "I Have The Power"
    fi
}

change_delta_theme()
{
    if [ "$#" -lt 1 ]; then
        echo "Usage: change_delta_theme <theme>"
        return 2
    fi

    if [ "$1" = "dark" ]; then
        perl -i -pe 's/(.*syntax-theme =).*/\1 Solarized (dark)/p' ~/.gitconfig
        return 0
    fi
    if [ "$1" = "light" ]; then
        perl -i -pe 's/(.*syntax-theme =).*/\1 Solarized (light)/p' ~/.gitconfig
        return 0
    fi

    echo "Usage: change_delta_theme <theme>"
    return 2
}


# Mellomrom fungerer ikke
#function calc()
#{
        #local result=""
        #result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
        #                       └─ default (when `--mathlib` is used) is 20
        #
        #if [[ "$result" == *.* ]]; then
                # improve the output for decimal numbers
                #printf "$result" |
                #sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
                    #-e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
                    #-e 's/0*$//;s/\.$//'   # remove trailing zeros
        #else
                #printf "$result"
        #fi
        #printf "\n"
#}

lines () {
    ghead --lines "$1" | gtail --lines 1
}

urlencode() {
    # urlencode <string>

    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

fetch_api_data() {
    k config use-context dev-gcp
    nohup nais postgres proxy -p 5434 mulighetsrommet-api >/dev/null 2>&1 &
    local proxy_pid=$!

    echo "Waiting for db connection..."
    while true; do
        pg_isready --host=localhost --port=5434 --username=fredrik.ingebrigtsen@nav.no >/dev/null 2>&1 && break
        sleep 0.1
    done

    pg_dump postgresql://localhost:5434/mulighetsrommet-api-db?user=fredrik.ingebrigtsen@nav.no > devdump
    if test -f devdump; then
        sed -i '' '/search_path/d' devdump
        sed -i '' 's/mulighetsrommet-api/valp/g' devdump
        psql postgresql://valp:valp@localhost:5442/mr-api < devdump 2>/dev/null
        psql postgresql://valp:valp@localhost:5442/mr-api < devdump 2>/dev/null
        rm devdump
    else
        echo "error dumping from dev"
    fi

    kill -sigterm $proxy_pid
}

fetch_tiltakshistorikk_data() {
    k config use-context dev-gcp
    nohup nais postgres proxy -p 5434 tiltakshistorikk >/dev/null 2>&1 &
    local proxy_pid=$!

    echo "Waiting for db connection..."
    while true; do
        pg_isready --host=localhost --port=5434 --username=fredrik.ingebrigtsen@nav.no >/dev/null 2>&1 && break
        sleep 0.1
    done

    pg_dump postgresql://localhost:5434/tiltakshistorikk?user=fredrik.ingebrigtsen@nav.no > devdump
    if test -f devdump; then
        sed -i '' '/search_path/d' devdump
        sed -i '' 's/tiltakshistorikk/valp/g' devdump
        psql postgresql://valp:valp@localhost:5442/mr-tiltakshistorikk < devdump 2>/dev/null
        psql postgresql://valp:valp@localhost:5442/mr-tiltakshistorikk < devdump 2>/dev/null
        rm devdump
    else
        echo "error dumping from dev"
    fi

    kill -sigterm $proxy_pid
}

refetch_db_data() {
    echo "Removing docker volumes..."
    docker compose -p mulighetsrommet down -v
    echo "Restarting docker..."
    docker compose --profile dev --profile dev up -d

    echo "Fetching api data..."
    fetch_api_data
    echo "Fetching tiltakshistorikk data..."
    fetch_tiltakshistorikk_data
}

function glogin()
{
    if ! gcloud auth print-identity-token >/dev/null 2>&1; then
        gcloud auth login --update-adc >/dev/null 2>&1
    fi
}

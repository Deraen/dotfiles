# Add dir to PATH if dir exists and is not on PATH already
function addPath {
    [[ -d "$1" ]] && [[ :$PATH: != *:"$1":* ]] && export PATH="$1:$PATH"
}

# If second parameter is a directory, export to first param
function exportIfExists {
    [[ -d "$2" ]] && export "$1"="$2"
}

# Source file if it exists
function addSource {
    [[ -f "$1" ]] && source "$1"
}

function removePath {
    WORK=:$PATH:
    for var in "$@"; do
        WORK=${WORK/:$var:/:}
    done
    WORK=${WORK%:}
    WORK=${WORK#:}
    export PATH="$WORK"
}

if [[ $HOST == "juho-laptop" ]] || \
    [[ $HOST == "juho-ThinkPad-T490" ]]
then
    LAPTOP=true
    DESKTOP=false
elif [[ $HOST == "juho-desktop" ]]
then
    LAPTOP=false
    DESKTOP=true
fi

export LAPTOP
export DESKTOP

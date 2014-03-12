#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

# NOTE: Doesn't support deb-src

declare -A SOURCE_FILES
OPS=0
SOURCESDIR="/etc/apt/sources.list.d"

function confirm {
        read -r -p "$1 [Y/n] " yes
        yes=${yes,,} # tolower
        [[ $yes =~ ^(yes|y| ) ]]
}

function changed {
        if [[ ! -f $old ]]; then return 1; fi

        local old=($(md5sum $1))
        local new=($(echo "$2" | md5sum))
        # Indexing array by the name only, returns the first part, in this case the hash
        [[ $new != $old ]]
}

function saveRepo {
        local filename=$SOURCESDIR/$1
        local content="$2"

        SOURCE_FILES["$filename"]=1

        if changed $filename "$content"; then
                echo "$(basename $filename) changed or added"
                echo -e $content > $filename
                OPS=$((OPS + 1))
        fi
}

function ppa {
        # node.js -> node_js
        local ppaname=${2//\./_}

        saveRepo $1-$ppaname-$3.list "deb http://ppa.launchpad.net/$1/$2/ubuntu $3 main"
}

function repo {
        saveRepo $1.list "$2"
}

function clearRepos {
        local extras=""
        for file in $SOURCESDIR/*.list; do
                if [[ -z ${SOURCE_FILES["$file"]} ]]; then
                        echo "Found extra repo? $(basename $file)"
                        extras="$extras $file"
                fi
        done

        if [[ $extras ]] && confirm "Remove extras"; then
                rm $extras
                OPS=$((OPS + 1))
        fi

        if [[ $OPS -gt 0 ]] && confirm "PPAs/repos changed, run getkeys?"; then
                launchpad-getkeys

                if confirm "Did keys change, run update?"; then
                        apt-get update
                fi
        fi
}

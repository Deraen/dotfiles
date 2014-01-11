#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

# NOTE: Doesn't support deb-src

SOURCE_FILES=""
OPS=0
SOURCESDIR="/etc/apt/sources.list.d"

function confirm {
        read -r -p "$1 [Y/n]" yes
        yes=${yes,,}
        if [[ $yes =~ ^(yes|y| ) ]]; then
                echo 0 # true
        else
                echo 1 # false
        fi
}

function save {
        local filename=$1
        local content="$2"

        SOURCE_FILES="${SOURCE_FILES}
        ${filename}"

        local new=($(echo "$content" | md5sum | cut -f1))
        local old=($(md5sum $SOURCESDIR/$filename))
        if [[ $new != $old ]]; then
                echo "PPA/repo changed or added"
                echo $content > $SOURCESDIR/${filename}
                OPS=$((OPS + 1))
        fi
}

function ppa {
        local filename="${1}-$(echo ${2} | sed 's/\./_/')-${3}.list"
        local content="deb http://ppa.launchpad.net/${1}/${2}/ubuntu ${3} main"

        save $filename "$content"
}

function repo {
        save ${1}.list "$2"
}

function clearRepos {
        local extras=""
        for x in /etc/apt/sources.list.d/*; do
                local file=$(basename ${x})
                echo ${file} | grep -q "\.save" && continue

                local found="0"
                for y in ${SOURCE_FILES}; do
                        if [[ "${file}" == "${y}" ]]; then
                                found="1"
                                break
                        fi
                done

                if [[ "${found}" == "0" ]]; then
                        echo "Found extra repo? ${file}"
                        extras="${extras} ${x}"
                fi
        done

        if [[ "${extras}" != "" ]]; then
                if confirm "Remove extras"; then
                        rm ${extras}
                        OPS=$((OPS + 1))
                fi
        fi

        if [[ $OPS -gt 0 ]]; then
                if confirm "PPAs/repos changed, run getkeys"; then
                        launchpad-getkeys
                fi

                if confirm "PPAs/repos changed, run update"; then
                        apt-get update
                fi
        fi
}

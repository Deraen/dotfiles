#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

# NOTE: Doesn't support deb-src

SOURCE_FILES=""

function ppa {
        local filename="${1}-$(echo ${2} | sed 's/\./_/')-${3}.list"
        SOURCE_FILES="${SOURCE_FILES}
        ${filename}"

        echo "deb http://ppa.launchpad.net/${1}/${2}/ubuntu ${3} main" > /etc/apt/sources.list.d/${filename}
}

function repo {
        local filename="${1}.list"
        SOURCE_FILES="${SOURCE_FILES}
        ${filename}"

        echo "${2}" > /etc/apt/sources.list.d/${filename}
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
                read -r -p "Remove extras? [Y/n] " yes
                yes=${yes,,} # tolower
                if [[ "${yes}" =~ ^(yes|y| ) ]]; then
                        rm ${extras}
                fi
        fi
}

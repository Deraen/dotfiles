#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

INSTALL=""

function getVersion {
        apt-cache show ${1} | grep Version | head -n1 | cut -d " " -f2
}

function installLocal {
        local package=(${1})
        local name=${package[0]}
        local version=${package[1]}
        local url=${package[2]}

        if [[ "${url}" != "" ]]; then
                wget -O /tmp/${name}.deb "${url}"
                dpkg -i /tmp/${name}.deb
        elif [[ "${version}" != "" ]]; then
                echo "	No URL given for local package Install manually plz?"
        fi
}

function install {
        INSTALL="${INSTALL}"$'\n'"${1} ${2} ${3}"
}

function markauto {
        # Check for manually installed packages which are not needed
        local manual=($(apt-mark showmanual))

        OIFS=$IFS; IFS=$'\n'; INSTALL=($INSTALL); IFS=$OIFS
        for x in "${INSTALL[@]}"; do
                local package=(${x})
                local name=${package[0]}
                local version=${package[1]}
                local url=${package[2]}

                echo "- ${name}?"
                local installed=$(dpkg --get-selections ${name} 2>&1 | grep install | wc -l)
                if [[ "${installed}" == "0" ]]; then
                        # Second parameter = manual version
                        # Third paramter = url for manual install
                        echo "	Not installed -> installing"
                        if [[ "${version}" != "" ]]; then
                                installLocal ${x}
                        else
                                apt-get install ${name}
                        fi
                fi

                # Check version if package is already installed and version is defined (="local package")
                if [[ "${installed}" == "1" ]] && [[ "${version}" != "" ]]; then
                        local current_version=$(getVersion ${name})
                        if [[ "${version}" != "${current_version}" ]]; then
                                echo "	Upgrade might be available?"
                                echo "	${current_version} -> ${version}"
                                installLocal ${x}
                        fi
                fi

                local auto="1"
                for y in "${manual[@]}"; do
                        if [[ ${name} == ${y} ]]; then
                                auto="0"
                                break
                        fi
                done

                if [[ "${auto}" == "1" ]]; then
                        echo "	Automatically installed -> mark manual"
                        apt-mark manual ${name} > /dev/null
                fi
        done

        for x in ${manual[@]}; do
                needed="0"
                for y in "${INSTALL[@]}"; do
                        local package=(${x})
                        local name=${package[0]}
                        if [[ ${x} == ${name} ]]; then
                                needed="1"
                                break
                        fi
                done

                if [[ "${needed}" == "0" ]]; then
                        echo "${x} is marked manual but is not needed -> mark auto"
                        apt-mark auto ${x} > /dev/null
                fi
        done
}


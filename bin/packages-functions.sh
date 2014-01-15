#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

declare -a NAMES
declare -A INSTALL

function getVersion {
        apt-cache show $1 | grep Version | head -n1 | cut -d " " -f2
}

function installLocal {
        local name=$1
        local package=($2)
        local version=${package[0]}
        local url=${package[1]}

        if [[ $url ]]; then
                wget -O /tmp/$name.deb "$url" && dpkg -i /tmp/$name.deb && rm /tmp/$name.deb
        elif [[ $version ]]; then
                echo "	No URL given for local package Install manually plz?"
        fi
}

function install {
        # Keep order of packages in indexed array
        NAMES+=($1)
        # Store data in associative array by package name (fast to check if package by some name is wanted)
        INSTALL["$1"]="$2 $3"
}

function markauto {
        # Build associate array of packages which are manually selected
        # Used to check if package by some name is not manyally selected
        declare -A manual
        for x in $(apt-mark showmanual); do manual["$x"]=1; done

        # Build associative array of packages installed in system
        declare -A installed
        for x in $(dpkg --get-selections "*:amd64" "*:all" | grep -w install$ | cut -f1); do installed["${x%:amd64}"]=1; done
        for x in $(dpkg --get-selections "*:i386" | grep -w install$ | cut -f1); do installed["${x%:i386}:i386"]=1; done

        for name in ${NAMES[@]}; do
                local package=(${INSTALL["$name"]})
                local version=${package[0]}

                echo "- $name?"
                if [[ -z ${installed["$name"]} ]]; then
                        # Second parameter = manual version
                        # Third paramter = url for manual install
                        echo "	Not installed -> installing"
                        if [[ $version ]]; then
                                installLocal $name "${package[*]}"
                        else
                                apt-get install $name
                        fi
                else
                        if [[ $version ]]; then
                                # Check version if package is already installed and version is defined (="local package")
                                local current_version=$(getVersion $name)
                                if [[ $version != $current_version ]]; then
                                        echo "	Upgrade might be available?"
                                        echo "	$current_version -> $version"
                                        installLocal $name "${package[*]}"
                                fi
                        fi

                        if [[ -z ${manual["$name"]} ]]; then
                                echo "	Automatically installed -> mark manual"
                                apt-mark manual $name > /dev/null
                        fi
                fi
        done

        for x in ${!manual[@]}; do
                if [[ -z ${INSTALL["$x"]} ]]; then
                        echo "$x is marked manual but is not needed -> mark auto"
                        apt-mark auto $x > /dev/null
                fi
        done
}


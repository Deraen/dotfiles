#!/bin/bash
# Author: Juho Teperi <juho.teperi@iki.fi>

INSTALL=""

function getVersion {
        apt-cache show ${1} | grep Version | head -n1 | cut -d " " -f2
}

function mark {
        # FIXME: This is slow? Is there some other command to get same info?
        local auto=$(apt-mark showauto ${1} | wc -l)
        if [[ "${auto}" == "1" ]]; then
                echo "	Automatically installed -> mark manual"
                apt-mark manual ${1} > /dev/null
        fi
}

function installApt {
        apt-get install ${1}
}

function installLocal {
        echo"	No URL given for local page. Install manually plz?"
}

function installRemote {
        wget -O /tmp/${1}.deb "${3}"
        dpkg -i /tmp/${1}.deb
}

function install {
        echo "- ${1}?"
        INSTALL="${INSTALL}
        ${1}"

        local installed=$(dpkg --get-selections ${1} | grep -q install)
        if [[ "${installed}" == "0" ]]; then
                # Second parameter = manual version
                # Third paramter = url for manual install
                echo "	Not installed -> installing"
                if [[ -z "${2}" ]]; then
                        installApt ${1}
                elif [[ -z "${3}" ]]; then
                        installLocal ${1} ${2}
                else
                        installRemote ${1} ${2} ${3}
                fi
        fi

        if [[ "${2}" != "" ]]; then
                local version=$(getVersion ${1})
                if [[ "${2}" != "${version}" ]]; then
                        echo "	Upgrade might be available?"
                        echo "	${version} -> ${2}"
                        if [[ -z "${3}" ]]; then
                                installLocal ${1} ${2}
                        else
                                installRemote ${1} ${2} ${3}
                        fi
                fi
        fi

        mark ${1}
}

function markauto {
        # Check for manually installed packages which are not needed
        for x in $(apt-mark showmanual); do
                needed="0"
                for y in ${INSTALL}; do
                        if [[ "${x}" == "${y}" ]]; then
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

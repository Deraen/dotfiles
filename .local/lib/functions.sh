#!/bin/bash

confirm() {
    local OPTIND
    local prompt="[Y/n]"
    local default="y"
    while getopts ":i" opt; do
        case $opt in
            i)
                default="n"
                prompt="[y/N]"
                ;;
        esac
    done

    shift $(($OPTIND - 1))

    read -r -p "$1 $prompt " ans
    ans=${ans,,} # tolower
    if [[ ! $ans ]]; then
        ans=$default
    fi
    [[ $ans =~ ^(yes|y) ]]
}

header() {
    echo
    echo -e "\e[1m\e[32m▄"
    echo -e "█ $1"
    echo -e "▀\e[0m"
}

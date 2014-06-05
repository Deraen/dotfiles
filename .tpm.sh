#!/bin/bash

export TPM_BIN=$HOME/.local/tpm-bin
export TPM_DIR=$HOME/.local/tpm
. ${TPM_DIR}/tpm/tpm

plug tpm "baabelfish/tpm"

plug liquidprompt "nojhan/liquidprompt"
addSource liquidprompt "liquidprompt"

if [[ $HOSTNAME == "juho-desktop" ]] || [[ $HOSTNAME == "juho-laptop" ]]; then
    plug dspmgr "Deraen/dspmgr"
    plug pwrmgr "Deraen/pwrmgr"
    plug tpm-filemanagement "baabelfish/tpm-filemanagement"
    plug urxvt-perls "muennich/urxvt-perls"
    plug urxvt-font-size "majutsushi/urxvt-font-size"
    plug xcape "alols/xcape"
    build xcape "make"
    addBin xcape xcape xcape

    plug dunst "knopwob/dunst"
    build dunst "make"
    addBin dunst dunst dunst

    plug ponymix "falconindy/ponymix"
    build ponymix "make"
    addBin ponymix ponymix ponymix

    plug oh-my-zsh "robbyrussell/oh-my-zsh"
fi

commit

#!/bin/bash
# Author: baabelfish

if [[ -z $1 ]]; then
    exit 1
fi

filename=$1
leave=0
echo $filename

case "$filename" in
    *.mp4|*.mkv|*.avi|*.mpg) exe="smplayer2" && leave=1 ;;
    *.mp3|*.ogg|*.wav|*.flac) exe="smplayer2" && leave=0 ;;
    *.jpg|*.jpeg|*.png|*.bmp) exe="feh" && leave=1 ;;
    *.gif) exe="google-chrome" && leave=0 ;;
    *.htm|*.html|*.xhtml) exe="google-chrome" ;;
    *.pdf|*.djvu) exe="zathura" && leave=1 ;;
    *.cbr|*.cbz) exe="mcomix" && leave=1 ;;
    *.doc|*.odt|*.ods|*.odp|*.odf) exe="libreoffice" && leave=1 ;;
    *) exe="vim" ;;
esac

if [[ $leave -eq 1 && "$exe" != "vim" ]]; then
    echo "disowning"
    nohup $exe "$filename" &> /dev/null &
else
    if [[ ! -z $ZSH_VERSION ]]; then
        $exe $filename
    else
        $exe $filename
    fi
fi

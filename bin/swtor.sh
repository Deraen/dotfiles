#!/bin/bash

export WINEPREFIX=~/.wine/swtor
cd "/home/juho/.wine/swtor/drive_c/Program Files (x86)/Electronic Arts/BioWare/Star Wars - The Old Republic"

/home/juho/.PlayOnLinux/wine/linux-amd64/1.4.1/bin/wine swtor_fix.exe &
# sleep 2
# __GL_THREADED_OPTIMIZATIONS=1
#WINEDEBUG=-all
/home/juho/.PlayOnLinux/wine/linux-amd64/1.4.1/bin/wine launcher.exe

# wineserver -k

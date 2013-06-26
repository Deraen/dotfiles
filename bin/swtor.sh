#!/bin/bash

export WINEPREFIX=~/.wine/swtor
cd "/home/juho/.wine/swtor/drive_c/Program Files (x86)/Electronic Arts/BioWare/Star Wars - The Old Republic"

/home/juho/.PlayOnLinux/wine/linux-amd64/1.6-rc2/bin/wine swtor_fix.exe &
# sleep 2
# __GL_THREADED_OPTIMIZATIONS=1
#WINEDEBUG=-all
WINEDEBUG=+tid,+seh /home/juho/.PlayOnLinux/wine/linux-amd64/1.6-rc2/bin/wine launcher.exe 2>&1|gzip> ~/swtor.log
# grep -sir 0017: swtor.log>swtor2.log
# tail -n 10000 swtor2.log>swtor_tid0017.log

# wineserver -k

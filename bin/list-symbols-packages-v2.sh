#!/bin/bash -x
# Michele Bini, the author of this script, disclaims copyright to it
# thus placing it in the public domain.

progname=`basename "$0"`

explain() {
    cat <<EOF
Usage: $progname [-adt] [-p pid]|[executable]

You must specify a pid (-p) or an executable name/path.

This script lists the debug symbols packages you need to install for a complete
dump of the given executable (which must be a full pathname). Already installed
symbols packages are not shown.

Options are:
  -p pid  uses the running process with the given pid to get the list.
          If specified, you may omit the executable name.
  -a      show all the required symbol packages (not only the not-installed
          ones)
  -d      prefer XXX-dbg symbol packages over XXX-dbgsym ones
  -t      terse: print the packages names only (no package description).
          Useful to pass output directly to apt-get install.

NOTE: in some cases $progname may report already installed
packages. This currently happens with binaries using libpthread.so as
libc6-i686-dbgsym apparently doesn't contain debug symbols for it.

To examine a running server process by pid, you will need to run this script
using sudo.
EOF
    exit -1
# Hidden option:  -g      enable debugging output for the script
}

all=false
preferred="dbgsym dbg"
debug=false
terse=false
pid=
while getopts :adgp:t opt; do
    case $opt in
        a)
            all=true
            ;;
        d)
            preferred="dbg dbgsym"
            ;;
        g)
            debug=true
            ;;
        p)
            pid="$OPTARG"
            binary=$(readlink /proc/$pid/exe)
            [ -z "$binary" ] && echo "Unable to get binary path for pid $pid" && exit -1
            ;;
        t)
            terse=true
            ;;
        \?)
            explain
            ;;
    esac
done

if [ -z "$binary" ]; then
    shift $(( $OPTIND - 1 ))
    [ $# -ne 1 ] && explain
    binary="$1"
    [ ! -x "$binary" -a `basename @"$binary"` = @"$binary" -a -n "`which $binary`" ] && binary=`which $binary`
fi

find-debug() {
    while read i; do
        for ext in $preferred; do
            apt-cache search "^$i-$ext\$"
        done |head -1
    done
}

if [ ! -z "$pid" ]; then
   Args="--pid=$pid"
else
   Args="$binary"
fi

echo q| gdb "$Args" | \
grep 'Reading symbols from '| \
if $all; then cat; else grep 'no debugging symbols found'; fi | \
sed -e 's/^Reading symbols from \(.*\)\.\.\.\((\|Reading \).*$/\1/' | \
while read i; do \
    #dpkg -S "$i" |while read j; do if $debug; then echo '!' $i '-->' $j 1>&2; fi; echo $j; done
    ( if ! dpkg -S "$i" 2>/dev/null; then [ -L "$i" ] && dpkg -S `readlink "$i"`; fi ) | \
    while read j; do if $debug; then echo '!' $i '-->' $j 1>&2; fi; echo $j; done \
done| sed -e 's/^\(.*\): .*$/\1/' | sort -u | \
find-debug | if $terse; then sed -e 's/ - .*$//'; else cat; fi |sort -u


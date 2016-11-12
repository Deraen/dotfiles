#!/bin/bash

target=$(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/DISTRIB_CODENAME=//' | head -1)
# repo_list=$(cd /etc/apt/sources.list.d && cat *.list /etc/apt/sources.list | grep deb\ http.* | sed -e 's/.*help\.ubuntu\.com.*//' -e 's/^#.*//' -e 's/deb\ //' -e 's/deb-src\ //' -e '/^$/d' | sort -u | awk '{print $1"|"$2}' | sed -e 's/\/|/|/' -e 's/-[a-z]*$//' | uniq && cd)
# releases=("vivid" "utopic" "trusty" "precise")

for file in $(find /etc/apt -type f -name '*.list'); do
  OIFS=$IFS
  IFS=$'\n'
  for source in $(grep "deb http.*" $file | sed -e 's/.*help\.ubuntu\.com.*//' -e 's/^#.*//' -e 's/deb\ //' -e 's/deb-src\ //' -e '/^$/d'); do
    IFS=$' '
    source=($source)
    url=${source[0]}
    series=${source[1]}

    if [[ $series != "$target"* ]]; then
      IFS=$'\n'
      avail=($(curl --silent $url/dists/ | grep -oi href\=\"[^\/].*/\" | sed -e 's/href\=\"//i' -e 's/\/\"//' -e 's/-.*//' -e 's/\ NAME.*//i' | sort -u | uniq))

      IFS=$' '
      avail=(${avail[@]//\.\./})

      avail_f=$(IFS=, ; echo "${avail[*]}")
      echo "$(basename $file) current: ${series} available: ${avail_f}"
    fi
  done
  IFS=$OIFS
done

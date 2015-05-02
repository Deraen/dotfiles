#!/bin/bash

myrelease=$(grep 'DISTRIB_CODENAME' /etc/lsb-release | sed 's/DISTRIB_CODENAME=//' | head -1)
repo_list=$(cd /etc/apt/sources.list.d && cat $repo_clean /etc/apt/sources.list | grep deb\ http.* | sed -e 's/.*help\.ubuntu\.com.*//' -e 's/^#.*//' -e 's/deb\ //' -e 's/deb-src\ //' -e '/^$/d' | sort -u | awk '{print $1"|"$2}' | sed -e 's/\/|/|/' -e 's/-[a-z]*$//' | uniq && cd)

# releases=("vivid" "utopic" "trusty" "precise")

for repo_0 in $repo_list; do
  repo="$(echo $repo_0 | sed 's/|.*//')"
  rir="$(echo $repo_0 | sed 's/.*|//')"

  rir_list=("$(curl --silent $repo/dists/ | grep -oi href\=\"[^\/].*/\" | sed -e 's/href\=\"//i' -e 's/\/\"//' -e 's/-.*//' -e 's/\ NAME.*//i' | sort -u | uniq)")
  if [ '$rir_list' = '' ]; then
    rir_list=("$(curl --silent $repo/ | grep -oi href\=\"[^\/].*\" | sed -e 's/href\=\"//i' -e 's/\/\"//' -e 's/-.*//' -e 's/\ NAME.*//i' -e 's/\/index\.html\"//' -e 's/.*".*//' -e 's/http.*//' | sort -u | uniq)")
  fi

  echo "$repo $rir_list"
done

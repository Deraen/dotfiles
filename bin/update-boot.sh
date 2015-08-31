#!/bin/bash

header=""
if [[ -f boot ]]; then
    mod=$(stat -c %y boot)
    mod_f=$(date -d "$mod" -R)
    header="-H \"If-Modified-Since: $mod_f\""
fi
release=$(curl -s https://api.github.com/repos/boot-clj/boot/releases/latest)
name=$(echo $release | jq -r ".name")
url=$(echo $release | jq -r ".assets [] | select(.name == \"boot.sh\") | .browser_download_url")

echo "Latest boot version in $name"

http_code=$(eval curl -s $header -L $url -w "%{http_code} -o boot")
case $http_code in
    304) echo "Already up-to-date";;
    200) echo "Updated";;
    *) echo "Unknown status: $http_code";;
esac
chmod +x boot

#!/bin/bash

PARALLEL_MAX=$(($(nproc) * 2))

update_module() {
  while [ $(ps --no-headers -o pid --ppid=$$ | wc -l) -gt $PARALLEL_MAX ]; do
    sleep .1
  done
  (
  cd "$@"
  git checkout
  git pull origin master
  echo "<<< Ready $@"
  ) &
}

submodules=($(git submodule foreach --quiet pwd))

for m in ${submodules[@]}; do
  echo ">> Update $m"
  update_module "$m"
done

wait

git add $(git submodule foreach --quiet pwd)

git submodule update --init --recursive

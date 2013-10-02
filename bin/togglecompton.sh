#!/bin/bash
if [[ $(pidof -x compton) ]]; then
  pkill compton
else
  compton &
fi

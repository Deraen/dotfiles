#!/bin/bash
if [[ $(pidof -x picom) ]]; then
  pkill picom
else
  picom &
fi

#!/bin/bash

if [[ -z $SWAYSOCK ]]; then
    lock.sh
fi

systemctl suspend

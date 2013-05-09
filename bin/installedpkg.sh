#! /bin/sh
aptitude search ~i | grep -v "^i A" | cut -d " " -f 4

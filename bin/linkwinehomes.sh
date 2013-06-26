#!/bin/bash
cd
find -name 'My Documents' -type l -exec ls -l {} \; -exec rm {} \; -exec ln -s $HOME/pelit/My\ Documents/ {} \;


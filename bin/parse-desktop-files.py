#!/usr/bin/env python3
# Author: Juho Teperi

from xdg.BaseDirectory import load_data_paths
from xdg.DesktopEntry import DesktopEntry
from glob import glob
from re import sub

# To remove duplicates
data = {}

for d in load_data_paths("applications"):
    for app in glob(d + "/*.desktop"):
        desktop = DesktopEntry(app)
        name = desktop.getName()

        if (not desktop.getHidden() and not desktop.getNoDisplay()) and name not in data:
            # Remove %u, %U, %f, %F from commands
            cmd = sub(r'(?i)(%U|%F)', '', desktop.getExec()).strip()
            # Android studio cmd is surrounded by ", bash won't like that
            if cmd.startswith("\"") and cmd.endswith("\""):
                cmd = cmd[1:-1]
            data[name] = cmd

for name, cmd in data.items():
    print('{}\t{}'.format(name, cmd))

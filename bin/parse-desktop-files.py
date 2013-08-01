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
            data[name] = sub(r'(?i)(%U|%F)', '', desktop.getExec())

for name, cmd in data.items():
    print('{}\t{}'.format(name, cmd))

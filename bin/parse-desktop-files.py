#!/usr/bin/env python3
# Author: Juho Teperi

from xdg.BaseDirectory import load_data_paths
from xdg.DesktopEntry import DesktopEntry
from glob import glob
from re import sub
from os.path import basename, expanduser
from os import makedirs, walk, remove

# To remove duplicates
data = {}

for d in load_data_paths("applications"):
    for app in glob(d + "/*.desktop"):
        desktop = DesktopEntry(app)
        name = desktop.getName()

        if (not desktop.getHidden() and not desktop.getNoDisplay()) and name not in data:
            data[name] = basename(app)

path = expanduser("~/.cache/desktopfiles/")
makedirs(path, exist_ok=True)

for name, cmd in data.items():
    with open(path + name, 'w') as f:
        f.write(cmd)

# Old files are kept so their extended attributes are preserved
# Remove old files
existing_files = set(next(walk(path))[2])
for filename in existing_files.difference(set(data.keys())):
    remove(path + filename)

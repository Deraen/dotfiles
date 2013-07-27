#!/usr/bin/env python3
# Author: Juho Teperi

from xdg.BaseDirectory import load_data_paths
from xdg.DesktopEntry import DesktopEntry
from glob import glob
from re import sub

for d in load_data_paths("applications"):
    for app in glob(d + "/*.desktop"):
        desktop = DesktopEntry(app)
        if (not desktop.getHidden() and not desktop.getNoDisplay()):
            print(desktop.getName() + "\t" + sub(r'(?i)(%U|%F)', '', desktop.getExec()))
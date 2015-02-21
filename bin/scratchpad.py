#!/usr/bin/env python3

import sys
import i3ipc

conn = i3ipc.Connection()
tree = conn.get_tree()

exe = sys.argv[1]
inst = sys.argv[2]

matches = [c for c in tree.descendents() if hasattr(c, 'window_instance') and c.window_instance == inst]

print(matches)

if len(matches) is 0:
    print("starting...")
    conn.command('exec {}'.format(exe))

conn.command('[instance={}] scratchpad show'.format(inst))

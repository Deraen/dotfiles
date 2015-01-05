#!/usr/bin/env python3

import i3ipc

conn = i3ipc.Connection()

# Keep current container focused
conn.command('mark switch-all')

# Move visible workspaces last so they stay visible
workspaces = sorted(conn.get_workspaces(), key=lambda x: x['visible'])
for workspace in workspaces:
    conn.command('workspace %s' % workspace['name'])
    conn.command('move workspace to output left')

conn.command('[con_mark="switch-all"] focus')
conn.command('unmark switch-all')

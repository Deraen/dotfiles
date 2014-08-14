#!/usr/bin/python2.7

import i3

# Keep current container focused
i3.command('mark', 'switch-all')

# Move visible workspaces last so they stay visible
workspaces = sorted(i3.get_workspaces(), key=lambda x: x['visible'])
for workspace in workspaces:
    i3.command('workspace', workspace['name'])
    i3.command('move', 'workspace to output left')

i3.command('[con_mark="switch-all"]', 'focus')
i3.command('unmark', 'switch-all')

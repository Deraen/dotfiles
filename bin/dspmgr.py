#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
from subprocess import Popen, PIPE
from re import search

maxdisplays = 2
default = 0
config = [
    {
        'connected': ['LVDS1'],
        'modes': {
            'LVDS1': {'auto': True}
        },
        'config': {}
    },
    {
        'connected': ['LVDS1', 'DP2', 'DP3'],
        'modes': {
            'DP2': {'mode': '1920x1200', 'rotate': 'left'},
            'DP3': {'mode': '2560x1440'}
        },
        'config': {
            'DP3': {'right-of': 'DP2', 'primary': True}
        }
    },
    {
        'connected': ['LVDS1', 'DP1'],
        'modes': {
            'LVDS1': {'auto': True},
            'DP1': {'auto': True}
        },
        'config': {
            'DP1': {'left-of': 'LVDS1'}
        }
    },
    {
        'connected': ['DVI-D-0', 'DVI-I-1'],
        'modes': {
            'DVI-D-0': {'mode': '1920x1200', 'rotate': 'left'},
            'DVI-I-1': {'mode': '2560x1440'},
        },
        # FIXME: Duplicated settings
        'config': {
            'DVI-D-0': {'mode': '1920x1200', 'pos': '0x0', 'rotate': 'left'},
            'DVI-I-1': {'mode': '2560x1440', 'right-of': 'DVI-D-0'}
        }
    }]


def getInfo():
    output = Popen('xrandr', stdout=PIPE).communicate()[0].strip().split('\n')

    connected = set()
    active = set()
    disabled = set()

    for line in output:
        status = search('(?P<name>[\w-]*) (?P<status>\w*)', line)
        info = search('(?P<w>\d+)x(?P<h>\d+)\+(?P<x>\d+)\+(?P<y>\d+) (?P<rotate>inverted|left|right|)', line)
        name = status.group('name')
        if status.group('status') == 'connected':
            connected.add(name)
            if info is not None:
                # Connected and active
                active.add(name)
            else:
                # Connected but not active
                disabled.add(name)

        elif status.group('status') == 'disconnected' and info is not None:
            # Not connected but active
            active.add(name)

    return (connected, active, disabled)


def select(connected):
    for c in config:
        if connected == set(c['connected']):
            return c
    return config[default]


def buildOpt(key, val):
    r = ['--{}'.format(key)]
    if type(val) == str:
        r.append(val)
    return r


def build(connected, active, disabled, config):
    print("Connected", connected)

    enable = set([x for x in config['modes']])

    # Disable active outputs that we aren't going to use
    disable = active - enable
    print("Disable", disable)

    # Enable monitors we are going to use and aren't already active
    enable -= active
    print("Enable", enable)

    commands = []

    # Enable and disable outputs
    current = list(active)
    print('current', current)
    command = ['xrandr']
    while enable or disable:
        # If maxium amount of outputs are active, disable one
        if len(current) >= maxdisplays and disable:
            name = disable.pop()

            command += ['--output', name, '--off']

            # Split into another xrandr call
            if len(current) == maxdisplays:
                commands.append(command)
                command = ['xrandr']

            current.remove(name)
        elif len(current) < maxdisplays and enable:
            name = enable.pop()
            modes = config['modes'][name]

            command += ['--output', name]

            for x, y in modes.items():
                command += buildOpt(x, y)

            current.append(name)

        else:
            print("Impossible config?")
            return

        print('current', current)

    # Set positions etc
    for name, val in config['config'].items():
        command += ['--output', name]
        for x, y in val.items():
            command += buildOpt(x, y)

    if len(command) > 1:
        commands.append(command)

    return commands


def run(commands):
    for cmd in commands:
        # Execute and wait until completion
        Popen(cmd).communicate()


def main():
    print("# DSPMGR")

    connected, active, disabled = getInfo()

    selected = select(connected)
    if not selected:
        return

    commands = build(connected, active, disabled, selected)
    if not commands:
        return

    print("Commands")
    print(commands)

    run(commands)


if __name__ == "__main__":
    main()

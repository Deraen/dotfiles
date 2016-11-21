#!/usr/bin/env python
import dbus
import os
from dbus.mainloop.glib import DBusGMainLoop
import gobject
from subprocess import call

def pulse_bus_address():
    if 'PULSE_DBUS_SERVER' in os.environ:
        return os.environ['PULSE_DBUS_SERVER']
    else:
        bus = dbus.SessionBus()
        server_lookup = bus.get_object("org.PulseAudio1", "/org/pulseaudio/server_lookup1")
        return server_lookup.Get("org.PulseAudio.ServerLookup1", "Address", dbus_interface="org.freedesktop.DBus.Properties")

DBusGMainLoop(set_as_default=True)
loop = gobject.MainLoop()
pulse_bus = None
pulse_core = None

def set_fallback_sink(name):
    print("Setting fallback sink to %s" % name)
    # FIXME: org.PulseAudio.Core1.NoSuchPropertyError: There are no sinks, and therefore no fallback sink either.
    # pulse_core.Set('org.PulseAudio.Core1', 'FallbackSink', dbus.ObjectPath(path, variant_level=1))
    call(["ponymix", "set-default", "-d", name])

def new_sink(sink_path):
    print("New Sink, %s" % sink_path)
    sink = pulse_bus.get_object(object_path=sink_path)
    name = sink.Get('org.PulseAudio.Core1.Device', 'Name')

    if name == 'alsa_output.usb-Audinst__Inc._Audinst_HUD-mx1-01.analog-stereo':
        # set_fallback_sink(sink_path)
        set_fallback_sink(name)

def connect():
    global pulse_bus, pulse_core
    print("Connecting to DBus")
    pulse_bus = dbus.connection.Connection(pulse_bus_address())
    pulse_core = pulse_bus.get_object(object_path='/org/pulseaudio/core1')
    pulse_core.ListenForSignal('org.PulseAudio.Core1.NewSink', dbus.Array(signature='o'))
    pulse_bus.add_signal_receiver(new_sink, 'NewSink')

    # Set default when starting also

    name='alsa_output.usb-Audinst__Inc._Audinst_HUD-mx1-01.analog-stereo'

    try:
        sink_path = pulse_core.GetSinkByName(name)
        set_fallback_sink(name)
        # set_fallback_sink(sink_path)
    except dbus.DBusException, e:
        pass

connect()

# Reconnect if Pulse is restarted

def ping():
    global pulse_bus, pulse_core
    try:
        if not pulse_bus:
            connect()
            print("Connected")
        pulse_core.Get('org.PulseAudio.Core1', 'Name')
    except dbus.DBusException, e:
        pulse_bus = None
        pulse_core = None

    return True

timer = gobject.timeout_add(5000, ping)

loop.run()

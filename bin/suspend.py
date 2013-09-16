#!/usr/bin/python
import dbus
import gobject

def main():
    bus = dbus.SystemBus()

    power_proxy = bus.get_object('org.freedesktop.UPower',
                                 '/org/freedesktop/UPower')

    pow_prop_iface = dbus.Interface(power_proxy,
                                    'org.freedesktop.DBus.Properties')
    pow_iface = dbus.Interface(power_proxy,
                               'org.freedesktop.UPower')

    battery = pow_prop_iface.Get('', 'OnBattery')

    print('Suspending? OnBattery: {}'.format(battery))
    if battery:
        pow_iface.Suspend()

if __name__ == '__main__':
    main()


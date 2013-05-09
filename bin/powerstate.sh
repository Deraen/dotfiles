#!/bin/bash

echo Sound powersave: $(</sys/module/snd_hda_intel/parameters/power_save)
echo
if (iwconfig wlan1 | grep -q "Power Management:on"); then
	wlan="On";
else
	wlan="Off";
fi;
echo Wifi power management: $wlan
echo
echo USB:

find /sys/devices/*/*/usb* -name idVendor -print | (
    while read vfile
    do
        dir=$(dirname $vfile);
        echo -e $(<$dir/power/level) $(<$dir/power/autosuspend)"	"$dir"	"`lsusb | grep $(<$dir/idVendor) | grep $(<$dir/idProduct) | head -n 1`
    done
)

echo
echo SCSI:
find /sys/bus/scsi/devices/host*/scsi_host/host*/ -name link_power_management_policy -print | (
    while read file; do echo $file; cat $file; done
)

echo
echo PCI ASPM:
cat /sys/module/pcie_aspm/parameters/policy

echo
echo PCI:
for i in /sys/bus/pci/devices/*/power/control; do echo $i; cat $i; done

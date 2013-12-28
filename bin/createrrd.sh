#!/bin/bash
# Author: Juho Teperi

DIR=/raid/var/rrdtool
if [ ! -f "$DIR/lammot.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/lammot.rrd" DS:cput:GAUGE:450:10:120 DS:levy1:GAUGE:450:10:120 DS:levy2:GAUGE:450:10:120 DS:levy3:GAUGE:450:10:120 DS:levy4:GAUGE:450:10:120  DS:levy5:GAUGE:450:10:120  DS:ulko:GAUGE:450:10:120 RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/server_temp_cpu.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/server_temp_cpu.rrd" DS:cput:GAUGE:450:10:120 RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/desktop-gpucoretemp.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/desktop-gpucoretemp.rrd" DS:gpucoretemp:GAUGE:450:10:120 RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/load.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/load.rrd" DS:min1:GAUGE:450:U:U DS:min5:GAUGE:450:U:U DS:min15:GAUGE:450:U:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/server_load.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/server_load.rrd" DS:min1:GAUGE:450:U:U DS:min5:GAUGE:450:U:U DS:min15:GAUGE:450:U:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/levyt.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/levyt.rrd" DS:root:GAUGE:450:0:U DS:levy1:GAUGE:450:0:U DS:levy2:GAUGE:450:0:U  DS:levy3:GAUGE:450:0:U DS:levy4:GAUGE:450:0:U  DS:levy5:GAUGE:450:0:U  DS:ulko:GAUGE:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/levy-levyt.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/levy-levyt.rrd" DS:free:GAUGE:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/server_disk_root.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/server_disk_root.rrd" DS:free:GAUGE:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/mem.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/mem.rrd" DS:free:GAUGE:450:0:U DS:buffers:GAUGE:450:0:U DS:cached:GAUGE:450:0:U DS:apps:GAUGE:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/server_mem.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/server_mem.rrd" DS:free:GAUGE:450:0:U DS:buffers:GAUGE:450:0:U DS:cached:GAUGE:450:0:U DS:apps:GAUGE:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/cpup.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/cpup.rrd" DS:cpu:COUNTER:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/server_cpup.rrd" ]; then
	rrdtool create --start N --step 300 "$DIR/server_cpup.rrd" DS:cpu:COUNTER:450:0:U RRA:AVERAGE:0.5:1:800 RRA:AVERAGE:0.5:6:800 RRA:AVERAGE:0.5:24:800 RRA:AVERAGE:0.5:288:800 RRA:MAX:0.5:288:800 RRA:MIN:0.5:288:800
fi

if [ ! -f "$DIR/lan.rrd" ]; then
    rrdtool create --start N --step 300 "$DIR/lan.rrd" DS:in:DERIVE:450:0:U DS:out:DERIVE:450:0:U RRA:AVERAGE:0.5:1:576 RRA:AVERAGE:0.5:6:672 RRA:AVERAGE:0.5:24:732 RRA:AVERAGE:0.5:144:1460
fi

if [ ! -f "$DIR/wan.rrd" ]; then
    rrdtool create --start N --step 300 "$DIR/wan.rrd" DS:in:DERIVE:450:0:U DS:out:DERIVE:450:0:U RRA:AVERAGE:0.5:1:576 RRA:AVERAGE:0.5:6:672 RRA:AVERAGE:0.5:24:732 RRA:AVERAGE:0.5:144:1460
fi

if [ ! -f "$DIR/wlan.rrd" ]; then
    rrdtool create --start N --step 300 "$DIR/wlan.rrd" DS:in:DERIVE:450:0:U DS:out:DERIVE:450:0:U RRA:AVERAGE:0.5:1:576 RRA:AVERAGE:0.5:6:672 RRA:AVERAGE:0.5:24:732 RRA:AVERAGE:0.5:144:1460
fi

if [ ! -f "$DIR/wlan2.rrd" ]; then
    rrdtool create --start N --step 300 "$DIR/wlan2.rrd" DS:in:DERIVE:450:0:U DS:out:DERIVE:450:0:U RRA:AVERAGE:0.5:1:576 RRA:AVERAGE:0.5:6:672 RRA:AVERAGE:0.5:24:732 RRA:AVERAGE:0.5:144:1460
fi

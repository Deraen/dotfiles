#!/bin/sh
# Author: Juho Teperi

DIR=/raid/var/rrdtool

HOSTNAME=$(hostname -s)

MIN1=`awk '{ print $1 }' /proc/loadavg`
MIN5=`awk '{ print $2 }' /proc/loadavg`
MIN15=`awk '{ print $3 }' /proc/loadavg`

ROOT=`df -PB1 / | grep / | awk '{ print $4 }'`
[ "$ROOT" ] || ROOT=U

FREE=$(free -b)
MEMFREE=$(echo $FREE | awk '{ print $10 }')
MEMBUFFERS=$(echo $FREE | awk '{ print $12 }')
MEMCACHED=$(echo $FREE | awk '{ print $13 }')
MEMAPPS=$(echo $FREE | awk '{ print $16 }')
CPUS=$(($(grep 'cpu ' /proc/stat | awk '{ print $2+$3+$4 }')/4)) #4 Corea


if [ "$HOSTNAME" = "juho-server" ]; then

	CPUT=`echo $(cat /sys/devices/platform/it87.656/temp2_input) / 1000 | bc`
	[ "$CPUT" ] || CPUT=U

	LEVYT=`df -PB1 /raid | grep /raid | awk '{ print $4 }'`
	[ "$LEVYT" ] || LEVYT=U

	rrdtool update "$DIR/server_temp_cpu.rrd" N:$CPUT
	rrdtool update "$DIR/server_load.rrd" N:$MIN1:$MIN5:$MIN15
	rrdtool update "$DIR/server_cpup.rrd" N:$CPUS
	rrdtool update "$DIR/server_disk_root.rrd" N:$ROOT
	rrdtool update "$DIR/levy-levyt.rrd" N:$LEVYT
	rrdtool update "$DIR/server_mem.rrd" N:$MEMFREE:$MEMBUFFERS:$MEMCACHED:$MEMAPPS

	## ROUTER
	# eth0: lan
	# eth1: wlan, 2.4ghz
	# eth2: wlan, 5ghz
	# vlan2: wan

	# RCONN=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 1.3.6.1.2.1.6.6.0 -O qv)
	LAN_IN=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifInOctets.2 -O qv)
	LAN_OUT=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifOutOctets.2 -O qv)
	WAN_IN=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifInOctets.9 -O qv)
	WAN_OUT=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifOutOctets.9 -O qv)
	WLAN_IN=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifInOctets.3 -O qv)
	WLAN_OUT=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifOutOctets.3 -O qv)
	WLAN2_IN=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifInOctets.4 -O qv)
	WLAN2_OUT=$(snmpwalk -v 1 -c eskomorko 192.168.1.1 IF-MIB::ifOutOctets.4 -O qv)

	# [ "$RCONN" ] || RCONN=U
	[ "$LAN_IN" ] || LAN_IN=U
	[ "$LAN_OUT" ] || LAN_OUT=U
	[ "$WAN_IN" ] || WAN_IN=U
	[ "$WAN_OUT" ] || WAN_OUT=U
	[ "$WLAN_IN" ] || WLAN_IN=U
	[ "$WLAN_OUT" ] || WLAN_OUT=U
	[ "$WLAN2_IN" ] || WLAN2_IN=U
	[ "$WLAN2_OUT" ] || WLAN2_OUT=U

	rrdtool update "$DIR/lan.rrd" N:$LAN_IN:$LAN_OUT
	rrdtool update "$DIR/wan.rrd" N:$WAN_IN:$WAN_OUT
	rrdtool update "$DIR/wlan.rrd" N:$WLAN_IN:$WLAN_OUT
	rrdtool update "$DIR/wlan2.rrd" N:$WLAN2_IN:$WLAN2_OUT

elif [ "$HOSTNAME" = "juho-desktop" ]; then

	CPUT=`echo $(cat /sys/devices/platform/it87.656/temp3_input) / 1000 | bc`
	[ "$CPUT" ] || CPUT=U

	# HOME=`df -PB1 /home | grep /home | awk '{ print $4 }'`
	# [ "$HOME" ] || HOME=U

	rrdtool update "$DIR/lammot.rrd" N:$CPUT:U:U:U:U:U:U
	rrdtool update "$DIR/load.rrd" N:$MIN1:$MIN5:$MIN15
	rrdtool update "$DIR/cpup.rrd" N:$CPUS
	rrdtool update "$DIR/levyt.rrd" N:$ROOT:U:U:U:U:U:U
	# rrdtool update "$DIR/levy-home.rrd" N:$HOME
	rrdtool update "$DIR/mem.rrd" N:$MEMFREE:$MEMBUFFERS:$MEMCACHED:$MEMAPPS

fi

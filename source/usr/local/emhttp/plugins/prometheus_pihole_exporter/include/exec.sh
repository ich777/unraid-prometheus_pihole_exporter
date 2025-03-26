#!/bin/bash

function get_pihole_hostname(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "pihole_hostname=" | cut -d '=' -f2-)"
}

function get_pihole_password(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "pihole_password=" | cut -d '=' -f2-)"
}

function get_pihole_protocol(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "pihole_protocol=" | cut -d '=' -f2-)"
}

function get_pihole_port(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "pihole_port=" | cut -d '=' -f2-)"
}

function get_exporter_port(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "exporter_port=" | cut -d '=' -f2-)"
}

function get_exporter_timeout(){
echo -n "$(cat /boot/config/plugins/prometheus_pihole_exporter/settings.cfg | grep "exporter_timeout=" | cut -d '=' -f2-)"
}

function change_pihole_settings(){
sed -i "/pihole_hostname=/c\pihole_hostname=${1}" "/boot/config/plugins/prometheus_pihole_exporter/settings.cfg"
sed -i "/pihole_password=/c\pihole_password=${6}" "/boot/config/plugins/prometheus_pihole_exporter/settings.cfg"
sed -i "/pihole_port=/c\pihole_port=${3}" "/boot/config/plugins/prometheus_pihole_exporter/settings.cfg"
if [ ! -z "$(pgrep -f prometheus_pihole_exporter_init.sh)" ]; then
  kill $(pgrep -f prometheus_pihole_exporter_init.sh)
fi
kill $(pidof prometheus_pihole_exporter)
echo -n "$(/usr/local/emhttp/plugins/prometheus_pihole_exporter/include/prometheus_pihole_exporter_start.sh $1 $2 $3 $4 $5 $6)"
}

function get_status(){
if [ ! -z "$(pgrep -f prometheus_pihole_exporter_init.sh)" ]; then
  echo -e "starting"
elif [ ! -z "$(pidof prometheus_pihole_exporter)" ]; then
  echo -e "running"
else
  echo "stopped"
fi
}

function start(){
echo -n "$(/usr/local/emhttp/plugins/prometheus_pihole_exporter/include/prometheus_pihole_exporter_start.sh $1 $2 $3 $4 $5 $6)"
}

function stop_exporter(){
echo -n "$(kill $(pidof prometheus_pihole_exporter))"
}

$@

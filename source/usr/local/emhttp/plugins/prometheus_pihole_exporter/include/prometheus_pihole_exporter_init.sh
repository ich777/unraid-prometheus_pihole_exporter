#!/bin/bash
((count = 150))
while [[ $count -ne 0 ]] ; do
    ping -c 1 $1
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))
    fi
    ((count = count - 1))
done

if [ ! -z "$6" ]; then
  PIHOLE_PWD="-pihole_password $6 "
else
  PIHOLE_PWD=""
fi

if [[ $rc -eq 0 ]] ; then
    echo "prometheus_pihole_exporter ${PIHOLE_PWD}-pihole_hostname $1 -pihole_protocol $2 -pihole_port $3 -port $4 -timeout $5s" | at now -M
    echo running
else
    echo stopped
fi

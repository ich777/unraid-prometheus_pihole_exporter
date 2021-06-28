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

if [[ $rc -eq 0 ]] ; then
    echo "prometheus_pihole_exporter -pihole_api_token $2 -pihole_hostname $1 -pihole_protocol $3 -pihole_port $4 -port $5 -interval $6s" | at now
    echo running
else
    echo stopped
fi

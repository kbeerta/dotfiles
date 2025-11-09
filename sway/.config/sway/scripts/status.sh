#!/usr/bin/env sh

while true; do
    time=$(date +'%H:%M %d/%m/%y')
    disk=$(df -h / | awk 'NR==2 {print $5}')
    connection=$(nmcli -t -f GENERAL.CONNECTION dev show | head -n1 | cut -d: -f2)
    ip_address=$(nmcli -t -f IP4.ADDRESS dev show | head -n1 | cut -d: -f2 | cut -d/ -f1)
    battery=$(cat /sys/class/power_supply/BAT0/capacity)
    upd=$(checkupdates 2>/dev/null | wc -l)

    echo "${ip_address}@${connection}  / ${disk}  UPD: ${upd}  BAT: ${battery}%  ${time} "
    sleep 60
done

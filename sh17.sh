#! /bin/bash
# Use ping command to check the network's PC state.
network='192.168.1'
for sitenu in $(seq 1 100)
do
    ping -c 1 -w 1 ${network}.${sitenu} &> /dev/null && result=0 || result=1

    if [ "$result" == 0 ]; then
        echo "Server ${network}.$sitenu is UP."
    else
        echo "Server ${network}.${sitenu} is DOWN."
    fi

done

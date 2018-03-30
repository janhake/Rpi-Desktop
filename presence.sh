#!/bin/bash
# Checks for presence of device and speaks a notification

NOW=$(date +"%s")
dayBegin=$(date --date="Today 07:00" +"%s")
dayEnd=$(date --date="Today 22:00" +"%s")


ip=(192.168.2.37 192.168.2.39 192.168.2.82)

for i in "${ip[@]}"
do
	echo $i

if [ ${NOW} -gt ${dayBegin} ] && [ ${NOW} -lt ${dayEnd} ]; then
    ping $i -c 1 -W 5 > /home/pi/devicelist
    status=$(grep -i -c '1 received' /home/pi/devicelist)
echo $status
    prevStatus=$(cat /home/pi/ishome)

    if [ $status = $prevStatus ]; then
        echo "No change"
    else
        if [ $status = "1" ]; then
            echo "Phone detected"
        else
            echo "Phone lost"
        fi
    fi

    echo $status > /home/pi/ishome
fi
done

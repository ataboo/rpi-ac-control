#!/bin/bash

# Send Delonghi air conditioner on or off command a fixed number of times.
# Intended to be called by crontab.
# Example runs from 10 am to 10 pm: `crontab -e`
# 0 10 * * * /home/pi/aircon_run.sh on
# 0 22 * * * /home/pi/aircon_run.sh off

send_count=5

if [[ $1 = "on" ]] 
then
  signal=POWER_ON
elif [[ $1 = "off" ]]
then
  signal=POWER_OFF
else
  echo "param 1 must be 'on' or 'off'"
  exit -1  
fi

echo Sending $signal $send_count times...

for ((i=0; i<$send_count; i++))
do
  irsend SEND_ONCE delonghi $signal
  sleep 1
done

echo ...done!

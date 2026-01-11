#!/bin/bash

##### NOSLEEP.SH - prevent suspend while CPU busy #####
# put it in your startup script: .~/nosleep.sh >/dev/null & disown
# install xautomation
#---------------------
#Initialize variables
sleep_timer=0
cpu_all=0
while :; do #infinite loop
  # Get the first line with aggregate of all CPUs
  cpu_now=($(head -n1 /proc/stat))
  # Get all columns but skip the first (which is the "cpu" string)
  cpu_sum="${cpu_now[@]:1}"
  # Replace the column seperator (space) with +
  cpu_sum=$((${cpu_sum// /+}))
  # Get the delta between two reads
  cpu_delta=$((cpu_sum - cpu_last_sum))
  # Get the idle time Delta (difference)
  cpu_idle=$((cpu_now[4]- cpu_last[4]))
  # Calc time spent working
  cpu_used=$((cpu_delta - cpu_idle))
  # Calc permilles (‰)
  if [ cpu_delta > 0 ]; then
  cpu_usage=$((1000 * cpu_used / cpu_delta))
  sleep_time=$((sleep_time + 1))
  # Keep this as last for next read
  cpu_last=("${cpu_now[@]}")
  cpu_last_sum=$cpu_sum
  fi

# Add together successive calculations of CPU usage
  cpu_all=$((cpu_all + cpu_usage))
#Sleep 1/10th of a minute (60s)
  sleep 6               #external bash command

#If the timer reaches 60s (10 loops) then
  if [ $sleep_time = 10 ]; then
#Calculate the average CPU load per minute
    cpu_avg=$((cpu_all / 60))
    echo -n " -> 1min CPU load average: $cpu_avg‰ "
#If the CPU load average is greater than half of 60 (THRESHOLD),
#Move the mouse pointer then restore it, to prevent system suspend
     if [ $cpu_avg -ge 30 ]; then
     xte 'mousermove 1 1'         #external command
     xte 'mousermove -1 -1'
     echo -n  "> 30 = mouse movement "
     fi
#Clear variables for next 10 cycles
    sleep_time=0
    cpu_all=0
#Print UTC seconds for reference
    date +UTC:%Ss
  fi
done

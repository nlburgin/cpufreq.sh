#!/bin/bash
#Multicall script. Symlink to name of cpufreq governor and it will set it.
#Bashism in "if" tests here. So don't try to run this on other shells.

COMMAND=`basename $0`
HELP='----------------------\n
cpufreq.sh\n
------------------------\n
Multicall script to set cpu frequency scaling governor.\n
Do not call directly, but symlinked to names such as "ondemand" or "performance"\n
to set those governors.\n
\n
a list of governors can be got by calling with --list-gov\n
\n
If called as "userspace", an argument is accepted to the value in hz\n
\n
for example `userspace 3000000` sets to 3Ghz\n
\n
you can get frequencies with --list-freq\n
\n
and the current frequency with --cur-freq\n
\n
this help message can be gotten with -h or --help\n
\n
you will probably need to run as root or with sudo\n
----------------------------------'
echo $COMMAND

if (($#)) && [ "$1" == '--list-gov' ]
then
  cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
elif (($#)) && [ $1 == '--list-freq' ]
then
  cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
elif (($#)) && [ $1 == '--cur-freq' ]
then
  for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq; do cat $i; done
elif  [ "$COMMAND" == 'cpufreq.sh' ]
then
  echo -e $HELP
elif  (($#)) &&  [ $1 == '-h' ]
then
  echo -e $HELP
elif  (($#)) && [ $1 == '--help' ] 
then
  echo -e $HELP
else

  for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo $COMMAND > $i; done
  

  #If we're setting userspace governor and there's at least one argument, 
  #interpret that argument as the frequency in Hz.
  if (($#)) && [ $COMMAND == "userspace" ]
  then
    for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_setspeed; do sudo echo $1 > $i; done
  fi
fi

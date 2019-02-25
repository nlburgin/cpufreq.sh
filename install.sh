#/bin/bash

#need to run as root

install_path=/usr/local/bin

cp -i ./cpufreq.sh $install_path/cpufreq.sh
chmod +x $install_path/cpufreq.sh
for i in $(echo $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors))
do
  ln -is /usr/local/bin/cpufreq.sh $install_path/$i
done
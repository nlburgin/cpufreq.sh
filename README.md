A multicall BASH script to control the cpu frequency governor for Linux.

Cpupower's command line syntax is too wordy to be convenient, and on some distros it doesn't seem to work if you're using a custom kernel (something about util-linux package being connected to a specific kernel version?). So this is a simple and relatively portable BASH-based replacement that uses sysfs directly.

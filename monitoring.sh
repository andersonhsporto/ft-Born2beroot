#!/bin/bash

ram_used=$(free -m | awk 'NR == 2 {print $3}')
ram_total=$(free -m | awk 'NR == 2 {printf "%sMB", $2}')
ram_percent=$(free -m | awk 'NR == 2 {printf "%.2f%%", $3*100/$2}')

disk_used=$(df -m --total |  awk 'NR == 10 {print $3}')
disk_total=$(df --total --block-size=GB | awk 'NR == 10 {print $2}')
disk_percent=$(df -h --total | awk 'END{print $5}')

lvm_check=$(lsblk | grep "lvm" | wc -l)

ipv4=$(ip route get 1.2.3.4 | awk 'NR ==1 {print $7}')
macadd=$(ip address | grep "link/ether" | awk '{printf "(%s)", $2}')


echo "#Architecture:" $(uname -a)
echo "#CPU physical:" $(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
echo "#vCPU:" $(grep "processor" /proc/cpuinfo | sort | uniq | wc -l)
echo "#Memory Usage:" "$ram_used/$ram_total" "($ram_percent)"
echo "#Disk Usage:" "$disk_used/$disk_total" "($disk_percent)"
echo "#CPU load:" $(mpstat | awk 'NR == 4 {printf "%.1f%%", 100-$12}')
echo "#Last boot:" $(who -b -t | awk '{print $4} {print $5}')
echo "#LVM use:" $(if [ $lvm_check == 0 ]; then echo no; else echo yes; fi)
echo "#Connexions TCP:" $(ss -s | awk '/TCP:/ {print $2}')
echo "#User log:" $(who | wc -l)
echo "#Network: IP" $ipv4 $macadd
echo "#Sudo:" $(grep "COMMAND" /var/log/sudo/sudo.log | wc -l) "cmd"

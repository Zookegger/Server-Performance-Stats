#!/bin/bash
echo "################################"
echo "#   System uptime infomation   #"
echo "################################"

uptime -p

echo 


echo "################################"
echo "#       Total CPU Usage        #"
echo "################################"

top -bn 1 | grep "%Cpu" | cut -d "," -f 4 | awk '{printf "CPU Usage: " 100-$1 "%\n"}'

echo

echo "################################"
echo "#         Memory Usage         #"
echo "################################"

free -m | grep Mem: | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n", $2/1024, $3/1024, $3/$2 * 100, ($2 - $3)/1024, $4/$2 * 100}'

echo

echo "################################"
echo "#      Storage Infomation      #"
echo "################################"

df -h | grep -E "C:|D:" | awk 'BEGIN {total=0; used=0; available=0}
{
    print $1 "\nTotal: " $2 "\nUsed: " $3 "\nAvailable: " $4 "\n"
    total += substr($2, 1, length($2) - 1)
    used += substr($3, 1, length($3) - 1) # Remove last character
    available += substr($4, 1, length($4) - 1) #Remove last character
}END {print "System\nTotal: " total"G" "\nTotal used: " used"G" "\nTotal available: " available"G"}' 

echo

echo "################################"
echo "# Top 5 Processes by CPU usage #"
echo "################################"

ps aux --sort=-%cpu | head -n 6 | awk '{printf "%-10s %-10s %-10s %-20s\n", $1, $2, $3, $11}'

echo

echo "###################################"
echo "# Top 5 Processes by Memory usage #"
echo "###################################"


ps aux --sort -%mem | head -n 6 | awk '{printf "%-10s %-10s %-10s %-20s\n", $1, $2, $4, $11}'

echo

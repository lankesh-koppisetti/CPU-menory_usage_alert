#!/bin/bash

# Log Start
echo "==============================" >> /root/memory_monitor.log
echo "Script Started: $(date)" >> /root/memory_monitor.log

# Memory Threshold Percentage
MEM_THRESHOLD=2

# Host Details
HOSTNAME=$(hostname)
DATE=$(date)

# Memory Usage Calculation
MEM_USAGE=$(free | grep Mem | awk '{print ($3/$2) * 100.0}')

# Log Memory Usage
echo "Current Memory Usage: $MEM_USAGE %" >> /root/memory_monitor.log

# Remove Decimal
MEM_INT=${MEM_USAGE%.*}

# Top Memory Consuming Processes
TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10)

# Threshold Check
if [ "$MEM_INT" -gt "$MEM_THRESHOLD" ]
then

echo "Threshold Crossed. Sending Alert..." >> /root/memory_monitor.log

cat > /tmp/memory_alert.txt << EOF
===================================
        MEMORY ALERT
===================================

Hostname : $HOSTNAME

Date     : $DATE

-----------------------------------
Memory Usage Details
-----------------------------------

Current Memory Usage : $MEM_USAGE %

Memory Threshold     : $MEM_THRESHOLD %

-----------------------------------
Top Memory Processes
-----------------------------------

$TOP_PROCESSES

EOF

# Send Mail
python3 /root/send_memory_mail.py

else
    echo "Memory Usage Normal : $MEM_USAGE %"
    echo "Memory Usage Normal" >> /root/memory_monitor.log
fi

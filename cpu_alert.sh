#!/bin/bash

# CPU Threshold Percentage
THRESHOLD=2

# Get CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# Remove decimal value
CPU_INT=${CPU_USAGE%.*}

# Host Details
HOSTNAME=$(hostname)
DATE=$(date)

# Top CPU Processes
TOP_PROCESSES=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -10)

# Check Threshold
if [ "$CPU_INT" -gt "$THRESHOLD" ]
then

cat > /tmp/cpu_alert.txt << EOF
===================================
          CPU ALERT
===================================

Hostname : $HOSTNAME

Date     : $DATE

CPU Usage: $CPU_USAGE %

===================================
Top CPU Consuming Processes
===================================

$TOP_PROCESSES

EOF

# Send Mail Using Python Script
python3 /root/send_mail.py

else
    echo "CPU Usage Normal : $CPU_USAGE %"
fi

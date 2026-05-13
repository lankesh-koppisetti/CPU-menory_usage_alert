****create log files for writing the logs

To check the live logs run below command
tail -f /root/memory_monitor.log

add the below lines in crontab -e  (and -l) for sending mail alrets fro every 5 mins


/5 * * * * /root/cpu_alert.sh >> /root/monitor.log 2>&1

*/5 * * * * /root/mem_usage.sh >> /root/memory_monitor.log 2>&1

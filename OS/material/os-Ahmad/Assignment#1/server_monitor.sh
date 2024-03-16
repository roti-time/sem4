#!/bin/bash
if [[ $(df -h | awk 'NR>1 && int($5)>30') ]]; then
    echo >>q1.log                                   # Prints an empty line before new enteries
    date >>q1.log
    echo >>q1.log
    echo "ALERT!! THESE DISKS ARE ABOVE THRESHOLD"
    df -h | awk 'NR==1 || int($5)>30'
    echo "ALERT!! THESE DISKS ARE ABOVE THRESHOLD" >>q1.log
    df -h | awk 'NR==1 || int($5)>30'>>q1.log
    echo >> q1.log
else                                                        # DISK USAGE CHECK
    echo "There Are no DISKS above 30% usage!"
fi
                                                            # df(disk free) tells us how much disk is free and 
                                                            # -h presents it in human readable form
                                                            # '|' is a pipe which takes output of left command 
                                                            # and makes it input of command on right
                                                            # awk is used for text filtering and NR>1 ensures that 
                                                            # header line  always get ingored
                                                            # int($5) >30 looks into fifth coloumn of the data and 
                                                            # filter outs values bigger than 30%(the values are already in %)
                                                            # and lastly the enteries gets printed in Disk_usage.txt





            # CPU USAGE CHECK
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')       
cpu_usage=${cpu_usage%.*}

if [ $cpu_usage -gt 30 ]; then
    echo "CPU usage is above 30%!"
    echo "ALERT!! CPU usage is above 30&">> q1.log
    echo "CPU usage was $cpu_usage%" >> q1.log
    echo >> q1.log

else 
    echo "CPU usage was $cpu_usage%" >> q1.log  
    echo >> q1.log  

fi                                                                  # top -bn1 gives the cpu usage of that instance
                                                                    # grep "Cpu(s)" filters out the line with string "Cpu(s)"
                                                                    # awk '{print $2 + $4}' adds the 2nd and 4th coloumn
                                                                    # which gives us the total cpu usage
                                                                    # and stores it in cpu_usage
                                                                    # -gt(greater than) is used to compare the value




    
                # RAM USAGE CHECK
mem_usage_total=$(top -bn1 | grep "MiB Mem" | awk '{print $4}')
mem_usage_total=${mem_usage_total%.*}
mem_usage_free=$(top -bn1 | grep "MiB Mem" | awk '{print $6*100}')
percent_free=$(($mem_usage_free / $mem_usage_total))
if [ $percent_free -lt 10 ]; then
echo "ALERT!! RAM is around $percent_free% remaining"
echo "ALERT!! RAM was around $percent_free% remaining">> q1.log
echo >>q1.log
else
echo "Your Computer had $percent_free% RAM availabe"
echo "Your Computer had $percent_free% RAM availabe" >> q1.log
echo >>q1.log
fi                                                                  # top -bn1 gives the memory usage of that instance
                                                                    # grep "MiB Mem" filters out the line with string "MiB Mem"
                                                                    # awk '{print $4}' gives us the total memory usage
                                                                    # and stores it in mem_usage_total
                                                                    # -gt(greater than) is used to compare the value
                                                                    # awk '{print $6*100}' gives us the free memory
                                                                    # and stores it in mem_usage_free
                                                                    # $mem_usage_free / $mem_usage_total gives us the  
                                                                    # percentage of free memory
                                                                    # -lt(less than) is used to compare the value
                                                                    # and lastly the enteries gets printed in q1.log




    # DISK SPACE/LOG FILE CHECK

log_file="q1.log"
    max_size=10485760 # 10MB in bytes

    
    if [ -f "$log_file" ]; then

        #checks if the size of the file is greater than 10MB(10485760 bytes)
        if [ $(stat -c%s "$log_file") -gt $max_size ];then
            echo "Log file is larger than $(($max_size/1048576))MB." >>q1.log
            backup_file="${log_file}.$(date +%Y%m%d%H%M%S)"
            cp "$log_file" "$backup_file"
            > "$log_file"
            echo "Last backup file $backup_file" >>q1.log
            echo >>q1.log
            gzip "$backup_file"
        else 
            echo "Log file is smaller than $(($max_size/1048576))MB." >>q1.log   
            echo >>q1.log   
        fi
    else
        echo "Log file does not exist"
        touch "$log_file"
    fi                                                              # checks if the log file exists
                                                                    # checks if the size of the file is greater than 10MB
                                                                    # Create a backup of the log file with a timestamp
                                                                    # Empty the log file
                                                                    # Write the backup file name to the log file
                                                                    # Compress the backup file
                                                                    # and lastly the enteries gets printed in q1.log

    
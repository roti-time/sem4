#!/bin/bash

# Define thresholds for disk usage, CPU usage, and available memory
DISK_THRESHOLD=30
CPU_THRESHOLD=30
MEMORY_THRESHOLD=10

# Define log file path
LOG_FILE="server.log"

# Define the log file to be rotated
LOG_ROTATE_FILE="server.log"

# Define the maximum log file size (10MB)
MAX_LOG_SIZE=10M

# Function to log messages to the log file
log_message() {
    local message="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S"): $message" >> "$LOG_FILE"
}

# Function to check and alert on disk usage
check_disk_usage() {
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
    
    if [ "$(echo "$disk_usage > $DISK_THRESHOLD" | bc -l)" -eq 1 ]; then
    	log_message "Disk usage exceeded threshold: $disk_usage%"
    	# Send an alert (e.g., email, notification, etc.)
    fi
}

# Function to check and alert on CPU usage
check_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    
    if [ "$(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l)" -eq 1 ]; then
        log_message "CPU usage exceeded threshold: $cpu_usage%"
        # Send an alert (e.g., email, notification, etc.)
        #else
        #log_message "CPU usage: $cpu_usage%"
    fi
}

# Function to check and alert on memory usage
check_memory_usage() {
    local memory_free=$(free -m | awk 'NR==2 {print $4}')
    local memory_total=$(free -m | awk 'NR==2 {print $2}')
    local memory_percent=$(( (memory_total - memory_free) * 100 / memory_total ))
    
    if [ "$memory_percent" -lt "$MEMORY_THRESHOLD" ]; then
        log_message "Available memory is below threshold: $memory_free MB"
        # Send an alert (e.g., email, notification, etc.)
        #else
        #log_message "Memory usage: $memory_percent%"
	
    fi
}

# Function to perform log rotation
perform_log_rotation() {
    if [ -f "$LOG_ROTATE_FILE" ]; then
        local log_file_size=$(stat -c%s "$LOG_ROTATE_FILE")
        local max_log_size_bytes=$(( ${MAX_LOG_SIZE%M} * 1024 * 1024 ))  # Convert "10M" to bytes
        
        if [ "$log_file_size" -ge "$max_log_size_bytes" ]; then
            logrotate -f /etc/logrotate.conf # Rotate the log file
            log_message "Log file rotated."
        fi
    fi
}

# Main script execution
log_message "Server monitoring script started."

while true; do
    check_disk_usage
    check_cpu_usage
    check_memory_usage
    perform_log_rotation
    sleep 30 # Sleep for 5 minutes (adjust as needed)
done

# Exit script (not reached in this example)
# log_message "Server monitoring script stopped."

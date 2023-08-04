###############################
Day4 Task
##############################


#!/bin/bash

# This script defines functions to check if a process is running and to restart it if not.

# Function to check if the process is running
check_process() {
    process_name=$1

    # Find the process ID (PID) using pgrep command
    pid=$(pgrep -x "$process_name")

    if [ -n "$pid" ]; then
        echo "Process $process_name is running with PID $pid."
        return 0
    else
        echo "Process $process_name is not running."
        return 1
    fi
}

# Function to restart the process
restart_process() {
    process_name=$1
    attempts=$2

    for ((i=1; i<=$attempts; i++)); do
        echo "Attempt $i to restart process $process_name."

        # Add the command to start the process here.
        # For example: "command_to_start_process"
        # Replace the above line with the appropriate command to start the process.
        
        sleep 1 # Wait for a moment before checking if the process is running.

        if check_process "$process_name"; then
            echo "Process $process_name restarted successfully."
            return 0
        fi
    done

    echo "Unable to restart process $process_name after $attempts attempts."
    return 1
}

# Main script
if [ $# -eq 0 ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

process_name=$1
max_attempts=3

if check_process "$process_name"; then
    exit 0
else
    restart_process "$process_name" "$max_attempts"
fi


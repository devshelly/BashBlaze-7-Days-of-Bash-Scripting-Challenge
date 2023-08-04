#!/bin/bash

# Check if the script was provided with a process name argument
if [ $# -eq 0 ]; then
    echo "Error: Please provide the process name as an argument."
    echo "Usage: $0 <process_name>"
    exit 1
fi

# Function to check if the specified process is running
process_existence_check() {
    process_name="$1"
    # pgrep command searches for the process by name
    if systemctl is-active "$process_name" >/dev/null; then
        echo "Process $process_name is running."
        return 0
    else
        return 1
    fi
}

# Function to restart the specified process
restart_process() {
    process_name="$1"
    attempts="$2"

    # Try to restart the process for a limited number of attempts
    for ((i = 1; i <= attempts; i++)); do
        echo "Attempting to restart $process_name (Attempt $i)..."
        sudo systemctl restart "$process_name"

        # Sleep for a few seconds to allow the process to start
        sleep 4

        # Check if the process is running after the restart
        if process_existence_check "$process_name"; then
            echo "$process_name successfully restarted."
            return 0
        fi
    done

    echo "Failed to restart $process_name after $attempts attempts, restart it manually."
    return 1
}


# Get the process name from the command-line argument
process_name="$1"

# Call the process_existence_check function
if process_existence_check "$process_name"; then
    # Process is running, no further action needed.
    exit 0
fi

# Process is not running, attempt to restart it.
# You can adjust the number of attempts as needed.
max_attempts=3
restart_process "$process_name" "$max_attempts"



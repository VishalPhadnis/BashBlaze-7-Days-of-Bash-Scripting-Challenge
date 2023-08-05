#!/bin/bash

# Check if a log file name is provided
if [ ${#1} -eq 0 ]; then
    echo "Please enter a log file name"
    echo "Usage: ./log_analyzer.sh log_file.txt"
else
    file=$1

    # Check if the file exists
    if [ -f "$file" ]; then
        i=1
        no_of_error=0
        date_of_analysis=$(date '+%Y-%m-%d_%H-%M-%S')
        lines=$(cat $file | wc -l)
        no_of_error=$(cat $file | grep -E "ERROR|FAILED" | wc -l)
        
        # Get the top 5 error messages with their occurrence count
        top_error=$(cat $file | awk -F'] |- ' '{print $2}' | sort | uniq -c | sort -nr | head -n 6 | tail -n 5)

        # Generate the report
        echo "Date of analysis: $date_of_analysis" > report.txt
        echo "Log file name: $file" >> report.txt
        echo "Total lines processed: $lines" >> report.txt
        echo "Total error count: $no_of_error" >> report.txt
        echo "Top 5 error messages with their occurrence count:" >> report.txt
        echo "$top_error" >> report.txt
        echo "List of critical events with line numbers:" >> report.txt
        
        # Process each line and find critical events
        while read line; do
            if [[ $line == *"CRITICAL"* ]]; then
                echo "Line No. $i: $line" >> report.txt
            fi
            i=$((i+1))
        done < $file
        
        dest_path="logs_archive"
        
        # Rename and move the log file to the archive
        mv $file "$date_of_analysis""_log.txt"
        file="$date_of_analysis""_log.txt"
        
        # Create the archive directory if it doesn't exist
        mkdir -p $dest_path
        
        # Move the log file to the archive directory
        mv $file $dest_path
        
        echo "Log has been analyzed and the report is generated"
    else
        echo "This file doesn't exist."
        echo "Please enter a proper file name"
    fi
fi


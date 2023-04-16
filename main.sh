#!/bin/bash

read -p "Enter day (e.g. 16): " day

# Get current month in MMM format (e.g. Mar)
month=$(date +%b)

# Print log entries for the specified day, ignoring the timestamp, and remove duplicates
grep "^$month $day" /var/log/messages | cut -d ' ' -f 4- | sort -u > log_summary.txt

# Remove lines containing "ded4machine systemd: Started Session" from the temp file
sed -i '/^ded4machine systemd: Started Session/d' log_summary.txt

# Remove lines containing "imunify-notifier" from the temp file
sed -i '/imunify-notifier/d' log_summary.txt

# Remove lines containing "User Slice" from the temp file
sed -i '/User Slice/d' log_summary.txt

# Remove lines containing "segfault" from the temp file
sed -i '/segfault/d' log_summary.txt

# Print the temp file to the console
cat log_summary.txt

# Clean up the temp file
rm log_summary.txt

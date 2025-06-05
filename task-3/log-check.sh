#!/bin/bash

logfile=""

# list arguments
while getopts "f:" opt; do
  case "$opt" in
    f) logfile="$OPTARG" ;;
    *) echo "Usage: $0 -f <logfile>"; exit 1 ;;
  esac
done

# Validasi
if [[ -z "$logfile" || ! -f "$logfile" ]]; then
  echo "File log not found"
  echo "How to use >> $0 -f <logfile>"
  exit 1
fi

# Total requests
total_requests=$(wc -l < "$logfile")

# Total brute force attempts
bf_count=$(grep 'GET /login' "$logfile" | grep '403' | wc -l)

# total success login
success_count=$(grep 'GET /login' "$logfile" | grep '200' | wc -l)

# List IPs
bf_ips=$(grep 'GET /login' "$logfile" | grep '403' | awk '{print $1}' | sort | uniq)

# List IPs
success_ips=$(grep 'GET /login' "$logfile" | grep '200' | awk '{print $1}' | sort | uniq)

echo "Total Requests: $total_requests"
echo "Total Success login: $success_count"
echo "Total Brute Force in /login: $bf_count"
echo "List Ips success login: "
echo "$success_ips"
echo "List of IPs attempting brute force:"
echo "$bf_ips"


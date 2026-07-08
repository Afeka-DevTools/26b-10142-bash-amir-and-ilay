#!/bin/bash

# ==============================================
# Script: check_internet.sh
# Purpose: Check internet connectivity and print a log to the screen
# Usage: ./check_internet.sh
# ==============================================

LOG_FILE="connectivity_log.txt"
TARGET="8.8.8.8"          # Google DNS - reliable ping target
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# --- Check that 'ping' is installed, install if missing ---
if ! command -v ping &> /dev/null; then
    echo "ping לא מותקן, מנסה להתקין..."
    sudo apt-get update -y && sudo apt-get install -y iputils-ping
fi

# --- Perform the connectivity test ---
if ping -c 1 -W 2 "$TARGET" &> /dev/null; then
    STATUS="CONNECTED"
    echo -e "[$TIMESTAMP] סטטוס: מחובר לאינטרנט ✅"
else
    STATUS="DISCONNECTED"
    echo -e "[$TIMESTAMP] סטטוס: אין חיבור לאינטרנט ❌"
fi

# --- Write result to log file ---
echo "[$TIMESTAMP] Ping to $TARGET - $STATUS" >> "$LOG_FILE"

echo "התוצאה נשמרה ל-$LOG_FILE"

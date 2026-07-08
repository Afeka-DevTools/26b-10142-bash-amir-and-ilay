#!/bin/bash

# ==============================================
# Script: port_scanner.sh
# Purpose: Scan an IP address for open ports in a given range
# Usage: ./port_scanner.sh <ip_address> [start_port] [end_port]
#        If no port range is given, scans common ports 1-1024
# ==============================================

# --- Validate input ---
if [ $# -lt 1 ]; then
    echo "שימוש: $0 <כתובת IP> [פורט התחלה] [פורט סיום]"
    exit 1
fi

IP="$1"
START_PORT="${2:-1}"
END_PORT="${3:-1024}"

# --- Validate IP format (basic check) ---
if ! [[ "$IP" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    echo "שגיאה: '$IP' אינה כתובת IP תקינה."
    exit 1
fi

# --- Check if nc (netcat) is installed, install if missing ---
if ! command -v nc &> /dev/null; then
    echo "netcat (nc) לא מותקן, מנסה להתקין..."
    sudo apt-get update -y && sudo apt-get install -y netcat-openbsd
    if [ $? -ne 0 ]; then
        echo "שגיאה: לא ניתן להתקין netcat. אנא התקינו ידנית ונסו שוב."
        exit 1
    fi
fi

echo "סורק פורטים בכתובת $IP בטווח $START_PORT-$END_PORT ..."
echo "-----------------------------------------"

FOUND_ANY=0
for PORT in $(seq "$START_PORT" "$END_PORT"); do
    if nc -z -w1 "$IP" "$PORT" 2>/dev/null; then
        echo "פורט $PORT: פתוח ✅"
        FOUND_ANY=1
    fi
done

echo "-----------------------------------------"
if [ "$FOUND_ANY" -eq 0 ]; then
    echo "לא נמצאו פורטים פתוחים בטווח שנבדק."
else
    echo "הסריקה הושלמה."
fi

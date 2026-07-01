#!/bin/bash

if ! command -v curl &> /dev/null; then
    echo "התוכנה curl אינה מותקנת. מנסה להתקין..."
    sudo apt-get update && sudo apt-get install -y curl
    
    if ! command -v curl &> /dev/null; then
        echo "שגיאה: כשל בהתקנת curl. אנא התקן אותה ידנית."
        exit 1
    fi
fi

CITY=$1
if [ -z "$CITY" ]; then
    read -p "אנא הכנס שם עיר (באנגלית): " CITY
fi

echo "שולף מזג אוויר עבור $CITY..."
curl -s "wttr.in/${CITY}?0"

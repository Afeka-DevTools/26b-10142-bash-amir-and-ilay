#!/bin/bash

# ==============================================
# Script: countdown_timer.sh
# Purpose: Countdown timer for a duration given in HH:MM:SS format
# Usage: ./countdown_timer.sh HH:MM:SS
# ==============================================

# --- Validate input ---
if [ $# -ne 1 ]; then
    echo "שימוש: $0 <HH:MM:SS>"
    exit 1
fi

INPUT="$1"

if ! [[ "$INPUT" =~ ^([0-9]{1,2}):([0-9]{2}):([0-9]{2})$ ]]; then
    echo "שגיאה: הפורמט חייב להיות HH:MM:SS (לדוגמה 00:05:30)."
    exit 1
fi

HOURS="${BASH_REMATCH[1]}"
MINUTES="${BASH_REMATCH[2]}"
SECONDS="${BASH_REMATCH[3]}"

TOTAL_SECONDS=$((10#$HOURS * 3600 + 10#$MINUTES * 60 + 10#$SECONDS))

if [ "$TOTAL_SECONDS" -le 0 ]; then
    echo "שגיאה: משך הזמן חייב להיות גדול מאפס."
    exit 1
fi

echo "מתחיל ספירה לאחור מ-$INPUT ..."

while [ "$TOTAL_SECONDS" -gt 0 ]; do
    H=$((TOTAL_SECONDS / 3600))
    M=$(((TOTAL_SECONDS % 3600) / 60))
    S=$((TOTAL_SECONDS % 60))
    printf "\r%02d:%02d:%02d " "$H" "$M" "$S"
    sleep 1
    TOTAL_SECONDS=$((TOTAL_SECONDS - 1))
done

printf "\r00:00:00 \n"
echo "הזמן נגמר! ⏰"

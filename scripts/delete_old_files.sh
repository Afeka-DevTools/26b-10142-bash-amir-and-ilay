#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "שימוש: $0 <נתיב_לתיקייה> <מספר_ימים>"
    exit 1
fi

DIR=$1
DAYS=$2

if [ ! -d "$DIR" ]; then
    echo "שגיאה: התיקייה $DIR אינה קיימת."
    exit 1
fi

echo "מחפש ומנקה קבצים הישנים מ-$DAYS ימים בתיקייה $DIR..."
find "$DIR" -type f -mtime +"$DAYS" -exec rm -v {} \;

echo "הניקוי הסתיים."

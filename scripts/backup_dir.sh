#!/bin/bash

if [ -z "$1" ]; then
    echo "שגיאה: יש לספק נתיב לתיקייה לגיבוי."
    echo "שימוש: $0 /path/to/folder"
    exit 1
fi

TARGET_DIR=$1
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

if [ ! -d "$TARGET_DIR" ]; then
    echo "שגיאה: התיקייה $TARGET_DIR לא קיימת."
    exit 1
fi

tar -czf "$BACKUP_NAME" "$TARGET_DIR"
echo "הגיבוי הושלם בהצלחה! הקובץ נוצר: $BACKUP_NAME"

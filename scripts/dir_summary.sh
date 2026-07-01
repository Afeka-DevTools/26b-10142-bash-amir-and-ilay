#!/bin/bash

DIR=${1:-.}

if [ ! -d "$DIR" ]; then
    echo "שגיאה: התיקייה $DIR אינה קיימת."
    exit 1
fi

echo "מנתח את התיקייה: $DIR"
echo "-------------------------"

files_count=$(find "$DIR" -maxdepth 1 -type f | wc -l)
dirs_count=$(find "$DIR" -maxdepth 1 -type d | wc -l)
links_count=$(find "$DIR" -maxdepth 1 -type l | wc -l)

dirs_count=$((dirs_count - 1))

echo "מספר קבצים: $files_count"
echo "מספר תת-תיקיות: $dirs_count"
echo "מספר קישורים (Symlinks): $links_count"

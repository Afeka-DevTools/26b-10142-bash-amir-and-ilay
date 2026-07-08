#!/bin/bash

# ==============================================
# Script: count_by_extension.sh
# Purpose: Count files in a folder grouped by file extension
# Usage: ./count_by_extension.sh [folder_path]
#        If no folder is given, uses the current directory
# ==============================================

TARGET_DIR="${1:-.}"

if [ ! -d "$TARGET_DIR" ]; then
    echo "שגיאה: התיקייה '$TARGET_DIR' לא קיימת."
    exit 1
fi

echo "סופר קבצים לפי סיומת בתיקייה: $TARGET_DIR"
echo "-----------------------------------------"

# --- Find files, extract extensions, count occurrences ---
find "$TARGET_DIR" -maxdepth 1 -type f | \
    sed 's/.*\.//' | \
    sort | \
    uniq -c | \
    sort -rn | \
    while read -r COUNT EXT; do
        printf "%-15s %s קבצים\n" ".$EXT" "$COUNT"
    done

echo "-----------------------------------------"

TOTAL=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)
echo "סה\"כ קבצים: $TOTAL"

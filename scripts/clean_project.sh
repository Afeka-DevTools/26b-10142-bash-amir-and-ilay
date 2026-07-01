#!/bin/bash

echo "מתחיל בניקוי קבצים זמניים ושאריות קומפילציה מהתיקייה הנוכחית..."

find . -type f \( -name "*.class" -o -name "*.pyc" -o -name "*.log" \) -delete -print
find . -type d -name "node_modules" -exec rm -rf {} + -print

echo "הפרויקט נקי!"

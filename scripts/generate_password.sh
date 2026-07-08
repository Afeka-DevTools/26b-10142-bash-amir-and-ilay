#!/bin/bash

# ==============================================
# Script: generate_password.sh
# Purpose: Generate a random 10-character password containing at least
#          one uppercase letter, one lowercase letter, one digit, and one symbol
# Usage: ./generate_password.sh
# ==============================================

PASSWORD_LENGTH=10

UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
LOWER="abcdefghijklmnopqrstuvwxyz"
DIGITS="0123456789"
SYMBOLS='!@#$%^&*()_+-='

# --- Guarantee at least one character from each required category ---
PASS_CHARS=()
PASS_CHARS+=("${UPPER:$((RANDOM % ${#UPPER})):1}")
PASS_CHARS+=("${LOWER:$((RANDOM % ${#LOWER})):1}")
PASS_CHARS+=("${DIGITS:$((RANDOM % ${#DIGITS})):1}")
PASS_CHARS+=("${SYMBOLS:$((RANDOM % ${#SYMBOLS})):1}")

# --- Fill the rest of the password randomly from all categories combined ---
ALL_CHARS="${UPPER}${LOWER}${DIGITS}${SYMBOLS}"
REMAINING=$((PASSWORD_LENGTH - 4))

for ((i = 0; i < REMAINING; i++)); do
    PASS_CHARS+=("${ALL_CHARS:$((RANDOM % ${#ALL_CHARS})):1}")
done

# --- Shuffle the characters so required ones aren't always at the start ---
SHUFFLED=$(printf "%s\n" "${PASS_CHARS[@]}" | shuf | tr -d '\n')

echo "הסיסמה שנוצרה: $SHUFFLED"

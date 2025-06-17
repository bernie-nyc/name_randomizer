#!/bin/bash

# CONFIG
CSV_FILE="/path/to/tws_vx_trans-_hhold.csv"
BACKUP_FILE="${CSV_FILE}.bak_$(date +%Y%m%d_%H%M%S)"
TMP_FILE="/tmp/tws_vx_trans-_hhold.tmp.csv"
LAST_NAMES_URL="https://www.randomlists.com/data/last-names.json"
LOG_FILE="/var/log/randomize_names.log"

# Start log entry
echo "[$(date)] Starting name randomization on $CSV_FILE" >> "$LOG_FILE"

# 1. Download and parse list of last names
last_names=$(curl -s "$LAST_NAMES_URL" | jq -r '.data[]')
if [ -z "$last_names" ]; then
    echo "[$(date)] Failed to retrieve last names list" >> "$LOG_FILE"
    exit 1
fi

readarray -t name_array <<<"$last_names"
name_count=${#name_array[@]}

# 2. Backup the original CSV
cp "$CSV_FILE" "$BACKUP_FILE"
echo "[$(date)] Backup created at $BACKUP_FILE" >> "$LOG_FILE"

# 3. Modify the file conditionally (only if 'name' field is blank)
awk -v names="${name_array[*]}" -v count="$name_count" -F',' -v OFS=',' '
BEGIN {
    split(names, narray, " ")
}
NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i == "name") name_col=i
    }
}
NR > 1 && name_col {
    if ($name_col == "") {
        srand()
        r = int(1 + rand() * count)
        $name_col = narray[r]
    }
}
{ print }
' "$CSV_FILE" > "$TMP_FILE"

# 4. Replace the original file
mv "$TMP_FILE" "$CSV_FILE"
echo "[$(date)] Successfully updated $CSV_FILE" >> "$LOG_FILE"

#!/bin/bash
# Slow but reliable translation - 30s delay to avoid Google rate limits
cd /Users/researchworldwide2026/tnhco

while true; do
    # Find first failed file
    DST=$(grep -l "Übersetzung fehlgeschlagen" markdown_de/*.md markdown_de/website/*.md 2>/dev/null | head -1)
    [ -z "$DST" ] && break
    
    BASE=$(basename "$DST")
    SRC="markdown/$BASE"
    [ -f "$SRC" ] || SRC="markdown/website/$BASE"
    [ -f "$SRC" ] || { echo "SKIP $BASE - no source"; rm -f "$DST"; continue; }
    
    echo -n "[$(date +%H:%M)] $BASE ... "
    
    # Translate with 25s timeout
    if gtimeout 25 cat "$SRC" | trans -b :de > "$DST" 2>/dev/null; then
        if [ -s "$DST" ] && ! head -1 "$DST" | grep -q "Übersetzung fehlgeschlagen"; then
            echo "OK ($(wc -c < "$DST" | tr -d ' ') bytes)"
        else
            echo "EMPTY"
        fi
    else
        echo "TIMEOUT"
    fi
    
    # 30 second delay to stay under rate limit
    sleep 30
done

echo "=== ALL DONE ==="

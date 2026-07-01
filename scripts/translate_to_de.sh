#!/bin/bash
# Translate all TNHCO markdown files to German
# Uses translate-shell (trans) via Google Translate
# Skips files already in German (_de suffix)

SRC_DIR="../markdown"
DST_DIR="../markdown_de"
mkdir -p "$DST_DIR/website"

total=0
translated=0
skipped=0
failed=0

echo "========================================="
echo "  TNHCO → Deutsch Übersetzung"
echo "========================================="
echo ""

translate_file() {
    local src="$1"
    local dst="$2"
    local rel="${src#$SRC_DIR/}"
    
    # Skip if already German
    if echo "$rel" | grep -qE '_de\.md$'; then
        echo "  SKIP (DE): $rel"
        skipped=$((skipped + 1))
        return
    fi
    
    echo -n "  [$((total+1))] $rel ... "
    
    # Translate via stdin pipe, brief mode (-b) to German (:de)
    # Retry up to 3 times with increasing delays for rate limiting
    success=0
    for attempt in 1 2 3; do
        cat "$src" | trans -b :de > "$dst" 2>/dev/null
        
        if [ -s "$dst" ]; then
            # Check if it's a real translation (not just error message)
            if ! head -1 "$dst" | grep -q "Übersetzung fehlgeschlagen"; then
                success=1
                break
            fi
        fi
        
        # Wait before retry (exponential backoff)
        if [ $attempt -lt 3 ]; then
            sleep $((attempt * 10))
        fi
    done
    
    if [ "$success" -eq 1 ]; then
        local src_bytes=$(wc -c < "$src" | tr -d ' ')
        local dst_bytes=$(wc -c < "$dst" | tr -d ' ')
        echo "OK (${src_bytes}→${dst_bytes} bytes)"
        translated=$((translated + 1))
    else
        echo "FEHLER (Rate-Limit)"
        {
            echo "# $(basename "$src" .md) (Übersetzung fehlgeschlagen)"
            echo ""
            echo "*Automatische Übersetzung nicht verfügbar (Google Translate Rate-Limit). Originaltext:*"
            echo ""
            cat "$src"
        } > "$dst"
        failed=$((failed + 1))
    fi
    
    # Delay between requests to avoid rate limiting (5 seconds)
    sleep 5
    total=$((total + 1))
}

# Process all markdown files
for f in "$SRC_DIR"/*.md; do
    [ -f "$f" ] || continue
    dst="$DST_DIR/$(basename "$f")"
    translate_file "$f" "$dst"
done

for f in "$SRC_DIR"/website/*.md; do
    [ -f "$f" ] || continue
    dst="$DST_DIR/website/$(basename "$f")"
    translate_file "$f" "$dst"
done

echo ""
echo "========================================="
echo "  FERTIG"
echo "========================================="
echo "Übersetzt: $translated"
echo "Übersprungen (DE): $skipped"
echo "Fehlgeschlagen: $failed"
echo "Gesamt: $total"
echo "Ausgabe: $DST_DIR"
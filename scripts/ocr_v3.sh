#!/bin/bash
# TNHCO PDF -> Markdown Extraction v3 - Parallel with xargs
PDF_DIR="../pdfs"
MD_DIR="../markdown"
WORK_TEMP="../.ocr_temp"
MAX_PROCS=3

mkdir -p "$MD_DIR" "$WORK_TEMP"

# Worker script for each PDF
cat << 'WORKER' > /tmp/tnhco_worker.sh
#!/bin/bash
pdf="$1"
MD_DIR="$2"
WORK_TEMP="$3"

basename=$(basename "$pdf" .pdf)
md_file="$MD_DIR/${basename}.md"
pdf_temp="$WORK_TEMP/$basename"

mkdir -p "$pdf_temp" 2>/dev/null

# Language detection
ocr_lang="deu+eng"
if echo "$basename" | grep -qiE "hu[._]|hatarozat"; then
    ocr_lang="hun+eng"
fi

# Try pdftotext first
pdftotext -layout "$pdf" "$pdf_temp/extracted.txt" 2>/dev/null
text_bytes=$(wc -c < "$pdf_temp/extracted.txt" 2>/dev/null | tr -d ' ')

{
    echo "# $basename"
    echo ""
    echo "**Source PDF:** \`$(basename "$pdf")\`"
    echo ""
    
    if [ "$text_bytes" -gt 100 ]; then
        echo "**Extraction method:** pdftotext (embedded text)"
        echo ""
        echo "---"
        echo ""
        cat "$pdf_temp/extracted.txt"
        echo ""
        echo "[TEXT:$text_bytes]"
    else
        pdftoppm -png -r 100 "$pdf" "$pdf_temp/p" 2>/dev/null
        pages=$(ls "$pdf_temp"/p-*.png 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$pages" -eq 0 ]; then
            echo "**Extraction method:** Failed"
            echo ""
            echo "*No content could be extracted*"
        else
            echo "**Extraction method:** OCR (tesseract $ocr_lang, 100 DPI)"
            echo "**Pages:** $pages"
            echo ""
            echo "---"
            echo ""
            
            for page_img in "$pdf_temp"/p-*.png; do
                [ -f "$page_img" ] || continue
                pnum=$(basename "$page_img" .png | sed 's/p-//')
                ptxt="$pdf_temp/ocr_${pnum}"
                
                tesseract "$page_img" "$ptxt" -l "$ocr_lang" --psm 6 2>/dev/null
                
                if [ -f "${ptxt}.txt" ]; then
                    echo "## Page $pnum"
                    echo ""
                    cat "${ptxt}.txt"
                    echo ""
                    echo ""
                fi
            done
            echo "[OCR:$pages:$ocr_lang]"
        fi
    fi
} > "$md_file"

echo "$(basename "$pdf") -> $(wc -c < "$md_file" | tr -d ' ') bytes"
rm -rf "$pdf_temp"
WORKER

chmod +x /tmp/tnhco_worker.sh

echo "========================================="
echo "  TNHCO PDF Extraction v3"
echo "========================================="
echo "Processing $(ls "$PDF_DIR"/*.pdf | wc -l | tr -d ' ') PDFs with $MAX_PROCS parallel workers..."
echo ""

# Use xargs for parallel processing
find "$PDF_DIR" -maxdepth 1 -name '*.pdf' -print0 | \
  xargs -0 -P "$MAX_PROCS" -I {} /tmp/tnhco_worker.sh "{}" "$MD_DIR" "$WORK_TEMP"

# Cleanup
rm -rf "$WORK_TEMP" /tmp/tnhco_worker.sh

echo ""
echo "========================================="
echo "  COMPLETE"
echo "========================================="
echo "Markdown files: $(ls "$MD_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Output: $MD_DIR"
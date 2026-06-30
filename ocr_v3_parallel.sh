#!/bin/bash
# TNHCO PDF -> Markdown Extraction v3 - Optimized with parallel processing
# Uses pdftotext for text-based PDFs, OCR with tesseract for image-based ones

PDF_DIR="./pdfs"
MD_DIR="./markdown"
WORK_TEMP="./.ocr_temp"
MAX_JOBS=4  # Parallel OCR jobs

mkdir -p "$MD_DIR" "$WORK_TEMP"

# Counters
TEXT_DONE=0
OCR_DONE=0
FAILED=0

process_one_pdf() {
    local pdf="$1"
    local basename=$(basename "$pdf" .pdf)
    local md_file="$MD_DIR/${basename}.md"
    local pdf_temp="$WORK_TEMP/$basename"
    
    mkdir -p "$pdf_temp" 2>/dev/null
    
    # Determine language for OCR
    local ocr_lang="deu+eng"
    if echo "$basename" | grep -qiE "hu[._]|hatarozat"; then
        ocr_lang="hun+eng"
    fi
    
    # Try pdftotext first
    pdftotext -layout "$pdf" "$pdf_temp/extracted.txt" 2>/dev/null
    local text_bytes=$(wc -c < "$pdf_temp/extracted.txt" 2>/dev/null | tr -d ' ')
    
    # Build markdown
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
            echo "[TEXT:$text_bytes]"
        else
            # OCR needed - use 100 DPI for speed
            pdftoppm -png -r 100 "$pdf" "$pdf_temp/p" 2>/dev/null
            
            local pages=$(ls "$pdf_temp"/p-*.png 2>/dev/null | wc -l | tr -d ' ')
            
            if [ "$pages" -eq 0 ]; then
                echo "**Extraction method:** Failed"
                echo ""
                echo "*No content could be extracted*"
                echo "[FAILED]"
            else
                echo "**Extraction method:** OCR (tesseract $ocr_lang, 100 DPI, --psm 6)"
                echo "**Pages:** $pages"
                echo ""
                echo "---"
                echo ""
                
                for page_img in "$pdf_temp"/p-*.png; do
                    [ -f "$page_img" ] || continue
                    local pnum=$(basename "$page_img" .png | sed 's/p-//')
                    local ptxt="$pdf_temp/ocr_${pnum}"
                    
                    tesseract "$page_img" "$ptxt" -l "$ocr_lang" --psm 6 2>/dev/null
                    
                    if [ -f "${ptxt}.txt" ]; then
                        echo "## Page $pnum"
                        echo ""
                        cat "${ptxt}.txt"
                        echo ""
                        echo ""
                    fi
                done
                echo "[OCR:$pages]"
            fi
        fi
    } > "$md_file"
    
    # Report
    local final_bytes=$(wc -c < "$md_file" | tr -d ' ')
    if echo "$final_bytes" | grep -q "FAILED"; then
        echo "  FAIL: $basename"
    elif [ "$text_bytes" -gt 100 ]; then
        echo "  TEXT: $basename ($text_bytes bytes)"
    else
        echo "  OCR:  $basename ($pages pages, $final_bytes bytes md, lang=$ocr_lang)"
    fi
    
    rm -rf "$pdf_temp"
}

export -f process_one_pdf
export PDF_DIR MD_DIR WORK_TEMP

echo "========================================="
echo "  TNHCO PDF Extraction v3 (Parallel)"
echo "========================================="
echo ""

# Get all PDFs
cd "$PDF_DIR"
pdfs=(*.pdf)
total=${#pdfs[@]}

# Process in parallel with job control
running=0
for pdf in "${pdfs[@]}"; do
    fullpath="$PDF_DIR/$pdf"
    
    # Wait if we've reached max jobs
    while [ $running -ge $MAX_JOBS ]; do
        wait -n 2>/dev/null
        running=$((running - 1))
    done
    
    process_one_pdf "$fullpath" &
    running=$((running + 1))
done

# Wait for remaining jobs
wait

# Cleanup
rm -rf "$WORK_TEMP"

echo ""
echo "========================================="
echo "  EXTRACTION COMPLETE"
echo "========================================="
echo "Total PDFs: $total"
md_count=$(ls "$MD_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Markdown files: $md_count"
echo "Output: $MD_DIR"
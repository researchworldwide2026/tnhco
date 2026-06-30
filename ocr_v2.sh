#!/bin/bash
# OCR all PDFs from tnhco.org - Optimized version
# Phase 1: Fast pdftotext for text-based PDFs
# Phase 2: OCR with 150 DPI for image-based PDFs

PDF_DIR="./pdfs"
MD_DIR="./markdown"
WORK_TEMP="./.ocr_temp"

mkdir -p "$MD_DIR" "$WORK_TEMP"

TEXT_COUNT=0
OCR_COUNT=0

process_pdf() {
    local pdf="$1"
    local basename=$(basename "$pdf" .pdf)
    local md_file="$MD_DIR/${basename}.md"
    local pdf_temp="$WORK_TEMP/$basename"
    
    mkdir -p "$pdf_temp"
    
    # Try pdftotext first
    pdftotext -layout "$pdf" "$pdf_temp/extracted.txt" 2>/dev/null
    local text_bytes=$(wc -c < "$pdf_temp/extracted.txt" 2>/dev/null | tr -d ' ')
    
    # Start markdown file
    echo "# $basename" > "$md_file"
    echo "" >> "$md_file"
    echo "**Source PDF:** \`$(basename "$pdf")\`" >> "$md_file"
    echo "" >> "$md_file"
    
    if [ "$text_bytes" -gt 100 ]; then
        echo "    TEXT: $text_bytes bytes"
        echo "**Extraction method:** pdftotext (embedded text)" >> "$md_file"
        echo "" >> "$md_file"
        echo "---" >> "$md_file"
        echo "" >> "$md_file"
        cat "$pdf_temp/extracted.txt" >> "$md_file"
        TEXT_COUNT=$((TEXT_COUNT + 1))
    else
        echo "    OCR needed ($text_bytes bytes text)"
        # Convert to images at 150 DPI
        pdftoppm -png -r 150 "$pdf" "$pdf_temp/p" 2>/dev/null
        
        local actual_pages=$(ls "$pdf_temp"/p-*.png 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$actual_pages" -eq 0 ]; then
            echo "    WARNING: No pages!"
            echo "**Extraction method:** Failed (no pages)" >> "$md_file"
            echo "" >> "$md_file"
            echo "*No content extracted*" >> "$md_file"
        else
            echo "    OCR: $actual_pages pages"
            echo "**Extraction method:** OCR (tesseract deu+eng, 150 DPI, --psm 6)" >> "$md_file"
            echo "**Pages:** $actual_pages" >> "$md_file"
            echo "" >> "$md_file"
            echo "---" >> "$md_file"
            echo "" >> "$md_file"
            
            local total_ocr=0
            for page_img in "$pdf_temp"/p-*.png; do
                [ -f "$page_img" ] || continue
                local pnum=$(basename "$page_img" .png | sed 's/p-//')
                local ptxt="$pdf_temp/ocr_${pnum}"
                
                tesseract "$page_img" "$ptxt" -l deu+eng --psm 6 2>/dev/null
                
                if [ -f "${ptxt}.txt" ]; then
                    local ob=$(wc -c < "${ptxt}.txt" | tr -d ' ')
                    total_ocr=$((total_ocr + ob))
                    
                    echo "## Page $pnum" >> "$md_file"
                    echo "" >> "$md_file"
                    cat "${ptxt}.txt" >> "$md_file"
                    echo "" >> "$md_file"
                    echo "" >> "$md_file"
                fi
            done
            echo "    -> $total_ocr bytes OCR'd"
            OCR_COUNT=$((OCR_COUNT + 1))
        fi
    fi
    
    rm -rf "$pdf_temp"
}

echo "========================================="
echo "  TNHCO PDF -> Markdown Extraction v2"
echo "========================================="
echo ""

count=0
total=$(ls "$PDF_DIR"/*.pdf 2>/dev/null | wc -l | tr -d ' ')

for pdf in "$PDF_DIR"/*.pdf; do
    count=$((count+1))
    echo "[$count/$total] $(basename "$pdf")"
    process_pdf "$pdf"
done

rm -rf "$WORK_TEMP"

echo ""
echo "========================================="
echo "  COMPLETE"
echo "========================================="
echo "Text-based (fast): $TEXT_COUNT"
echo "OCR'd (slow): $OCR_COUNT"
echo "Total: $count PDFs"
echo "Output: $MD_DIR"
ls "$MD_DIR"/*.md 2>/dev/null | wc -l | tr -d ' '
echo "markdown files"

#!/bin/bash
# OCR all PDFs from tnhco.org and convert to Markdown
# Uses pdftotext first, falls back to pdftoppm + tesseract for image-based PDFs

PDF_DIR="./pdfs"
MD_DIR="./markdown"
WORK_TEMP="./.ocr_temp"

mkdir -p "$MD_DIR"

process_pdf() {
    local pdf="$1"
    local basename=$(basename "$pdf" .pdf)
    local md_file="$MD_DIR/${basename}.md"
    local pdf_temp="$WORK_TEMP/$basename"
    
    echo "  [$basename]"
    
    mkdir -p "$pdf_temp"
    
    # Step 1: Try pdftotext first
    pdftotext -layout "$pdf" "$pdf_temp/extracted.txt" 2>/dev/null
    local text_bytes=$(wc -c < "$pdf_temp/extracted.txt" 2>/dev/null | tr -d ' ')
    
    # Start markdown file
    echo "# $basename" > "$md_file"
    echo "" >> "$md_file"
    echo "**Source PDF:** \`$(basename "$pdf")\`" >> "$md_file"
    echo "" >> "$md_file"
    
    if [ "$text_bytes" -gt 100 ]; then
        # pdftotext worked well
        echo "    -> pdftotext: $text_bytes bytes"
        echo "**Extraction method:** pdftotext (embedded text)" >> "$md_file"
        echo "" >> "$md_file"
        echo "---" >> "$md_file"
        echo "" >> "$md_file"
        cat "$pdf_temp/extracted.txt" >> "$md_file"
    else
        # Need OCR fallback
        echo "    -> pdftotext: $text_bytes bytes, falling back to OCR"
        
        # Convert to images (200 DPI)
        pdftoppm -png -r 200 "$pdf" "$pdf_temp/p" 2>/dev/null
        
        local actual_pages=$(ls "$pdf_temp"/p-*.png 2>/dev/null | wc -l | tr -d ' ')
        
        if [ "$actual_pages" -eq 0 ]; then
            echo "    WARNING: No pages extracted"
            echo "**Extraction method:** Failed (no pages)" >> "$md_file"
            echo "" >> "$md_file"
            echo "*No content could be extracted*" >> "$md_file"
        else
            echo "    -> OCR: $actual_pages pages"
            echo "**Extraction method:** OCR (tesseract, deu+eng, --psm 6)" >> "$md_file"
            echo "**Pages:** $actual_pages" >> "$md_file"
            echo "" >> "$md_file"
            echo "---" >> "$md_file"
            echo "" >> "$md_file"
            
            local total_ocr_bytes=0
            for page_img in "$pdf_temp"/p-*.png; do
                if [ -f "$page_img" ]; then
                    local page_num=$(basename "$page_img" .png | sed 's/p-//')
                    local page_txt="$pdf_temp/ocr_${page_num}"
                    
                    tesseract "$page_img" "$page_txt" -l deu+eng --psm 6 2>/dev/null
                    
                    if [ -f "${page_txt}.txt" ]; then
                        local ocr_bytes=$(wc -c < "${page_txt}.txt" | tr -d ' ')
                        total_ocr_bytes=$((total_ocr_bytes + ocr_bytes))
                        
                        echo "## Page $page_num" >> "$md_file"
                        echo "" >> "$md_file"
                        cat "${page_txt}.txt" >> "$md_file"
                        echo "" >> "$md_file"
                        echo "" >> "$md_file"
                    fi
                fi
            done
            echo "    -> OCR text: $total_ocr_bytes bytes"
        fi
    fi
    
    # Cleanup per-PDF temp
    rm -rf "$pdf_temp"
}

# Main
echo "========================================="
echo "  TNHCO PDF -> Markdown Extraction"
echo "========================================="
echo ""

count=0
total=$(ls "$PDF_DIR"/*.pdf 2>/dev/null | wc -l | tr -d ' ')

for pdf in "$PDF_DIR"/*.pdf; do
    count=$((count+1))
    echo "[$count/$total]"
    process_pdf "$pdf"
done

# Final cleanup
rm -rf "$WORK_TEMP"

echo ""
echo "========================================="
echo "  EXTRACTION COMPLETE"
echo "========================================="
echo "Processed: $count PDFs"
md_count=$(ls "$MD_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Markdown files: $md_count"
echo "Output directory: $MD_DIR"

#!/bin/bash
# TNHCO PDF -> Markdown Extraction v4 - HIGH QUALITY
# Uses pdfimages (instant JPEG extraction) + magick preprocessing + tesseract OCR
# Falls back to pdftoppm for PDFs without embedded JPEGs
# Uses pdftotext for text-based PDFs

PDF_DIR="./pdfs"
MD_DIR="./markdown"
WORK_TEMP="./.ocr_temp"
MAX_PROCS=3

mkdir -p "$MD_DIR" "$WORK_TEMP"

cat << 'WORKER' > /tmp/tnhco_worker_v4.sh
#!/bin/bash
pdf="$1"
MD_DIR="$2"
WORK_TEMP="$3"

basename=$(basename "$pdf" .pdf)
md_file="$MD_DIR/${basename}.md"
pdf_temp="$WORK_TEMP/$basename"
mkdir -p "$pdf_temp"

# Language detection
ocr_lang="deu+eng"
if echo "$basename" | grep -qiE "hu[._]|hatarozat"; then
    ocr_lang="hun+eng"
fi

# Step 1: Try pdftotext first
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
    else
        # Check if PDF has embedded JPEG images
        img_count=$(pdfimages -list "$pdf" 2>/dev/null | grep -c "image")
        
        if [ "$img_count" -gt 0 ]; then
            # METHOD A: Extract embedded images (supports JPEG, JPEG2000, etc.)
            pdfimages "$pdf" "$pdf_temp/img" 2>/dev/null
            
            # Count all extracted images (jpg, ppm, pbm, etc.)
            pages=$(ls "$pdf_temp"/img-*.* 2>/dev/null | wc -l | tr -d ' ')
            
            if [ "$pages" -gt 0 ]; then
                echo "**Extraction method:** OCR via embedded image extraction + preprocessing"
                echo "**Images extracted:** $pages"
                echo "**OCR:** tesseract $ocr_lang, threshold preprocessing"
                echo ""
                echo "---"
                echo ""
                
                for img in "$pdf_temp"/img-*.*; do
                    [ -f "$img" ] || continue
                    imgfile=$(basename "$img")
                    inum=$(echo "$imgfile" | sed 's/img-//;s/\.[^.]*$//')
                    proc="$pdf_temp/proc_${inum}.png"
                    ocr_out="$pdf_temp/ocr_${inum}"
                    
                    # Preprocessing: crop margins, trim, threshold to remove decorative elements
                    magick "$img" \
                        -gravity West -chop 8%x0 \
                        -gravity East -chop 3%x0 \
                        -trim \
                        -bordercolor White -border 20x20 \
                        -colorspace Gray \
                        -threshold 60% \
                        "$proc" 2>/dev/null
                    
                    tesseract "$proc" "$ocr_out" -l "$ocr_lang" --psm 3 2>/dev/null
                    
                    if [ -f "${ocr_out}.txt" ]; then
                        echo "## Section $inum"
                        echo ""
                        cat "${ocr_out}.txt"
                        echo ""
                        echo ""
                    fi
                done
            else
                echo "**Extraction method:** Failed (no images extracted)"
                echo ""
                echo "*No content could be extracted*"
            fi
        else
            # METHOD B: No embedded JPEGs, use pdftoppm + preprocessing
            pdftoppm -png -r 100 "$pdf" "$pdf_temp/p" 2>/dev/null
            pages=$(ls "$pdf_temp"/p-*.png 2>/dev/null | wc -l | tr -d ' ')
            
            if [ "$pages" -gt 0 ]; then
                echo "**Extraction method:** OCR via pdftoppm + preprocessing"
                echo "**Pages:** $pages"
                echo "**OCR:** tesseract $ocr_lang, threshold preprocessing"
                echo ""
                echo "---"
                echo ""
                
                for page_img in "$pdf_temp"/p-*.png; do
                    [ -f "$page_img" ] || continue
                    pnum=$(basename "$page_img" .png | sed 's/p-//')
                    proc="$pdf_temp/proc_${pnum}.png"
                    ocr_out="$pdf_temp/ocr_${pnum}"
                    
                    magick "$page_img" \
                        -gravity West -chop 8%x0 \
                        -gravity East -chop 3%x0 \
                        -trim \
                        -bordercolor White -border 20x20 \
                        -colorspace Gray \
                        -threshold 60% \
                        "$proc" 2>/dev/null
                    
                    tesseract "$proc" "$ocr_out" -l "$ocr_lang" --psm 3 2>/dev/null
                    
                    if [ -f "${ocr_out}.txt" ]; then
                        echo "## Page $pnum"
                        echo ""
                        cat "${ocr_out}.txt"
                        echo ""
                        echo ""
                    fi
                done
            else
                echo "**Extraction method:** Failed (no pages)"
                echo ""
                echo "*No content could be extracted*"
            fi
        fi
    fi
} > "$md_file"

final_bytes=$(wc -c < "$md_file" | tr -d ' ')
echo "$(basename "$pdf") -> $final_bytes bytes"
rm -rf "$pdf_temp"
WORKER

chmod +x /tmp/tnhco_worker_v4.sh

echo "========================================="
echo "  TNHCO PDF Extraction v4 (High Quality)"
echo "  Key improvements: pdfimages (all formats) + threshold preprocessing = clean OCR"
echo "========================================="
echo "Processing $(ls "$PDF_DIR"/*.pdf | wc -l | tr -d ' ') PDFs with $MAX_PROCS workers..."
echo ""

# Parallel processing with xargs
find "$PDF_DIR" -maxdepth 1 -name '*.pdf' -print0 | \
  xargs -0 -P "$MAX_PROCS" -I {} /tmp/tnhco_worker_v4.sh "{}" "$MD_DIR" "$WORK_TEMP"

rm -rf "$WORK_TEMP" /tmp/tnhco_worker_v4.sh

echo ""
echo "========================================="
echo "  COMPLETE"
echo "========================================="
echo "Markdown files: $(ls "$MD_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')"
echo "Output: $MD_DIR"
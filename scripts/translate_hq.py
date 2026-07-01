#!/usr/bin/env python3.10
"""
High-Quality Markdown Translation to German
Uses deep-translator (Google Translate) with exponential backoff.
Translates complete files for best contextual quality.
"""

import os, sys, time, random
from pathlib import Path
from deep_translator import GoogleTranslator

SRC_DIR = Path("../markdown")
DST_DIR = Path("../markdown_de")
DST_DIR.mkdir(parents=True, exist_ok=True)
(DST_DIR / "website").mkdir(exist_ok=True)

BASE_DELAY = 10
MAX_DELAY = 180
MAX_RETRIES = 6

def translate_text(text, retries=MAX_RETRIES):
    """Translate with exponential backoff for rate limits."""
    for attempt in range(retries):
        try:
            result = GoogleTranslator(source='auto', target='de').translate(text)
            if result and len(result.strip()) > 10:
                return result
        except Exception as e:
            err = str(e).lower()
            if any(kw in err for kw in ['429','too many','rate','quota']):
                delay = min(BASE_DELAY*(2**attempt)+random.uniform(0,5), MAX_DELAY)
                print(f" [rate-limit, {delay:.0f}s]", end='', flush=True)
                time.sleep(delay)
            elif any(kw in err for kw in ['timeout','connect','reset','refused']):
                delay = min(10*(attempt+1), 60)
                time.sleep(delay)
            elif '413' in err or 'too large' in err or 'entity' in err:
                return None
            else:
                time.sleep(BASE_DELAY)
    return None

def split_large(text, max_chars=4500):
    """Split at paragraph boundaries."""
    if len(text) <= max_chars:
        return [text]
    parts = text.split('\n\n')
    chunks, current = [], ""
    for p in parts:
        if len(current)+len(p)+2 <= max_chars:
            current = (current+"\n\n"+p).strip() if current else p
        else:
            if current: chunks.append(current)
            current = p if len(p) <= max_chars else p[:max_chars]
    if current: chunks.append(current)
    return chunks

def translate_file(src, dst):
    """Translate complete file, splitting if needed."""
    text = src.read_text(encoding='utf-8')
    
    # Try whole file first (best quality)
    result = translate_text(text)
    if result:
        dst.write_text(result, encoding='utf-8')
        return dst.stat().st_size
    
    # Split and translate chunks
    chunks = split_large(text)
    translated = []
    for i, ch in enumerate(chunks):
        time.sleep(BASE_DELAY)
        t = translate_text(ch)
        translated.append(t if t else ch)
    
    dst.write_text('\n\n'.join(translated), encoding='utf-8')
    return dst.stat().st_size

def main():
    # Find files needing translation
    todo = []
    skipped = 0
    for src in sorted(list(SRC_DIR.glob("*.md")) + list((SRC_DIR/"website").glob("*.md"))):
        if '_de.md' in src.name: continue
        parent = "website" if "website" in str(src) else ""
        dst = DST_DIR/parent/src.name if parent else DST_DIR/src.name
        if dst.exists():
            # Skip if file has substantial translated content (not just error header)
            content = dst.read_text(encoding='utf-8')
            lines = content.split('\n')
            first = lines[0] if lines else ''
            # Skip if already properly translated (no error marker in first line)
            if 'fehlgeschlagen' not in first.lower() and 'failed' not in first.lower():
                skipped += 1
                continue
        todo.append((src, dst))
    
    if not todo:
        print(f"Alle {skipped} Dateien bereits uebersetzt!")
        return
    
    total = len(todo)
    eta = total * (BASE_DELAY + 5)
    print(f"{'='*55}")
    print(f"  High-Quality DE Translation (Google)")
    print(f"  Neu/Fehlerhaft: {total}  |  Bereits OK: {skipped}  |  ~{eta//60}min  |  Delay: {BASE_DELAY}s")
    print(f"{'='*55}\n")
    
    ok = fail = 0
    t0 = time.time()
    
    for i, (src, dst) in enumerate(todo, 1):
        rel = str(src.relative_to(SRC_DIR))
        elapsed = int(time.time()-t0)
        print(f"[{i:3d}/{total}] {rel:<50s}", end='', flush=True)
        
        try:
            size = translate_file(src, dst)
            if size > 50:
                print(f" OK  {size:>6d} B  ({elapsed//60}m{elapsed%60:02d}s)")
                ok += 1
            else:
                print(f" FAIL (leer)")
                fail += 1
        except Exception as e:
            print(f" ERROR: {e}")
            fail += 1
        
        time.sleep(BASE_DELAY)
    
    total_t = int(time.time()-t0)
    print(f"\n{'='*55}")
    print(f"  FERTIG in {total_t//60}m{total_t%60}s")
    print(f"  OK: {ok}  |  Fehler: {fail}  |  Gesamt: {total}")
    print(f"{'='*55}")

if __name__ == "__main__":
    main()

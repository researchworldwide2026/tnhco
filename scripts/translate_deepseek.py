#!/usr/bin/env python3.10
"""
High-Quality Markdown Translation to German using DeepSeek V4 API.
API key stored securely in macOS Keychain.
"""

import os, sys, time, subprocess, json
from pathlib import Path
from openai import OpenAI

SRC_DIR = Path("../markdown")
DST_DIR = Path("../markdown_de")
DST_DIR.mkdir(parents=True, exist_ok=True)
(DST_DIR / "website").mkdir(exist_ok=True)

# ── API Key from macOS Keychain ──────────────────────────────────
def get_api_key():
    try:
        result = subprocess.run(
            ["security", "find-generic-password", "-a", os.environ["USER"], "-s", "deepseek-api", "-w"],
            capture_output=True, text=True, timeout=5
        )
        if result.returncode == 0 and result.stdout.strip():
            return result.stdout.strip()
    except Exception:
        pass
    print("ERROR: DeepSeek API key not found in Keychain.")
    print("Run: security add-generic-password -a $USER -s deepseek-api -w 'sk-your-key'")
    sys.exit(1)

API_KEY = get_api_key()
client = OpenAI(api_key=API_KEY, base_url="https://api.deepseek.com")

# ── Configuration ─────────────────────────────────────────────────
MODEL = "deepseek-chat"       # DeepSeek V4 chat model
MAX_CHARS = 60000             # DeepSeek can handle long texts
MAX_RETRIES = 5
BASE_DELAY = 10

def translate_text(text, retries=MAX_RETRIES):
    """Translate with DeepSeek V4. Returns translated text or None."""
    system_prompt = (
        "Du bist ein professioneller Übersetzer. Übersetze den folgenden Text "
        "ins Deutsche. Behalte die Markdown-Formatierung (Überschriften, Listen, "
        "Tabellen, Links) EXAKT bei. Übersetze NUR den Fließtext, nicht die Struktur. "
        "Technische Begriffe und Eigennamen NICHT übersetzen. "
        "Gib NUR die Übersetzung zurück, keine Erklärungen."
    )

    for attempt in range(retries):
        try:
            response = client.chat.completions.create(
                model=MODEL,
                messages=[
                    {"role": "system", "content": system_prompt},
                    {"role": "user", "content": text}
                ],
                temperature=0.1,      # Low temp for consistent translations
                max_tokens=8192,      # Max output
            )
            result = response.choices[0].message.content.strip()
            if result and len(result) > 10:
                return result

        except Exception as e:
            err = str(e).lower()
            if any(kw in err for kw in ['rate', '429', 'quota', 'limit']):
                delay = min(BASE_DELAY * (2 ** attempt), 120)
                print(f" [rate-limit, {delay}s]", end='', flush=True)
                time.sleep(delay)
            elif any(kw in err for kw in ['timeout', 'connect', 'reset']):
                time.sleep(min(10 * (attempt + 1), 60))
            elif 'auth' in err or 'key' in err or '401' in err:
                print(f"\n  AUTH ERROR: Check your API key in Keychain.")
                return None
            else:
                time.sleep(BASE_DELAY)

    return None

def split_large(text, max_chars=55000):
    """Split at paragraph boundaries for very large documents."""
    if len(text) <= max_chars:
        return [text]
    parts = text.split('\n\n')
    chunks, current = [], ""
    for p in parts:
        if len(current) + len(p) + 2 <= max_chars:
            current = (current + "\n\n" + p).strip() if current else p
        else:
            if current:
                chunks.append(current)
            current = p if len(p) <= max_chars else p[:max_chars]
    if current:
        chunks.append(current)
    return chunks

def translate_file(src, dst):
    """Translate complete file, splitting if needed."""
    text = src.read_text(encoding='utf-8')
    file_size = len(text)

    # Small files: translate in one shot
    if file_size <= MAX_CHARS:
        result = translate_text(text)
        if result:
            dst.write_text(result, encoding='utf-8')
            return dst.stat().st_size
        return None

    # Large files: split, translate, reassemble
    chunks = split_large(text)
    translated = []
    for i, ch in enumerate(chunks):
        time.sleep(2)  # Gentle rate limiting between chunks
        t = translate_text(ch)
        translated.append(t if t else ch)

    dst.write_text('\n\n'.join(translated), encoding='utf-8')
    return dst.stat().st_size

def main():
    force = "--force" in sys.argv
    
    # Find files needing translation
    todo = []
    skipped = 0
    for src in sorted(list(SRC_DIR.glob("*.md")) + list((SRC_DIR / "website").glob("*.md"))):
        if '_de.md' in src.name:
            continue
        parent = "website" if "website" in str(src) else ""
        dst = DST_DIR / parent / src.name if parent else DST_DIR / src.name
        if dst.exists() and not force:
            content = dst.read_text(encoding='utf-8')
            first = content.split('\n')[0] if content else ''
            if 'fehlgeschlagen' not in first.lower() and len(content) > 100:
                skipped += 1
                continue
        todo.append((src, dst))

    if not todo:
        print(f"Alle {skipped} Dateien bereits uebersetzt!")
        return

    total = len(todo)
    mode = "FORCE (alle)" if force else "Nur fehlende"
    print(f"{'='*55}")
    print(f"  DeepSeek V4 DE Translation")
    print(f"  Modus: {mode}  |  Neu: {total}  |  Bereits OK: {skipped}")
    print(f"  Model: {MODEL}  |  Max chars: {MAX_CHARS}")
    print(f"{'='*55}\n")

    ok = fail = 0
    t0 = time.time()

    for i, (src, dst) in enumerate(todo, 1):
        rel = str(src.relative_to(SRC_DIR))
        elapsed = int(time.time() - t0)
        print(f"[{i:3d}/{total}] {rel:<50s}", end='', flush=True)

        try:
            size = translate_file(src, dst)
            if size and size > 50:
                print(f" OK  {size:>6d} B  ({elapsed // 60}m{elapsed % 60:02d}s)")
                ok += 1
            else:
                print(f" FAIL (zu klein)")
                fail += 1
        except Exception as e:
            print(f" ERROR: {e}")
            fail += 1

    elapsed = int(time.time() - t0)
    print(f"\n{'='*55}")
    print(f"  OK: {ok}  |  Fehler: {fail}  |  Gesamt: {total}")
    print(f"  Zeit: {elapsed // 60}m{elapsed % 60:02d}s")
    print(f"{'='*55}")

if __name__ == "__main__":
    main()

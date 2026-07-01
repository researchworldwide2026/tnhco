#!/bin/bash
# Save all tnhco.org website pages as markdown
OUT="../markdown/website"
mkdir -p "$OUT"

save_page() {
    local url="$1"
    local filename="$2"
    local title="$3"
    echo "# $title" > "$OUT/$filename"
    echo "" >> "$OUT/$filename"
    echo "**URL:** $url" >> "$OUT/$filename"
    echo "" >> "$OUT/$filename"
    curl -sL "$url" 2>/dev/null | sed -n '/<main/,/<\/main>/p' | sed 's/<[^>]*>//g' | tr -s '\n' '\n' >> "$OUT/$filename"
    echo "Saved: $filename ($(wc -c < "$OUT/$filename") bytes)"
}

# English pages
save_page "https://tnhco.org/en/home/" "homepage_en.md" "TNHCO Homepage (EN)"
save_page "https://tnhco.org/en/monetary-one/" "monetary-one_en.md" "Monetary One (EN)"
save_page "https://tnhco.org/en/news-en/" "news_en.md" "News (EN)"
save_page "https://tnhco.org/en/contact/" "contact_en.md" "Contact (EN)"
save_page "https://tnhco.org/en/documents/" "documents_en.md" "Documents (EN)"

# German pages
save_page "https://tnhco.org/" "homepage_de.md" "TNHCO Homepage (DE)"
save_page "https://tnhco.org/monetary-one_de/" "monetary-one_de.md" "Monetary One (DE)"
save_page "https://tnhco.org/neuigkeiten/" "news_de.md" "Neuigkeiten (DE)"
save_page "https://tnhco.org/contact_de/" "contact_de.md" "Kontakt (DE)"
save_page "https://tnhco.org/documents_de/" "documents_de.md" "Dokumente (DE)"
save_page "https://tnhco.org/de/activities_de/" "activities_de.md" "Aktivitäten (DE)"
save_page "https://tnhco.org/de/goals_de/" "goals_de.md" "Ziele (DE)"
save_page "https://tnhco.org/de/focus_de/" "focus_de.md" "Fokus (DE)"

# Italian pages
save_page "https://tnhco.org/it/home_it/" "homepage_it.md" "TNHCO Homepage (IT)"
save_page "https://tnhco.org/it/documents_it/" "documents_it.md" "Documenti (IT)"

# French pages
save_page "https://tnhco.org/fr/home_fr/" "homepage_fr.md" "TNHCO Homepage (FR)"
save_page "https://tnhco.org/fr/documents_fr/" "documents_fr.md" "Documents (FR)"

# Info events page
save_page "https://tnhco.org/daten-infoveranstaltungen/" "info-events_de.md" "Infoveranstaltungen (DE)"

echo ""
echo "=== All website pages saved ==="
ls -la "$OUT/"
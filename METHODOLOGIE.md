# METHODOLOGIE — Wie diese Recherche durchgeführt wurde

> **Stand:** 03.07.2026 | **Transparenzhinweis:** Dieses Dokument beschreibt
> die Methodik, Werkzeuge und ethischen Grundsätze dieser Recherche, damit Dritte
> die Arbeit nachvollziehen, überprüfen und weiterverwenden können.

---

## 1. Quellenbeschaffung

### 1.1 Primärquellen: TNHCO-Website (tnhco.org)

Die **90 PDF-Dokumente** (48 Resolutionen + 34 ungarische Übersetzungen + 8 Sonderdokumente)
wurden **vollständig von der öffentlich zugänglichen Website tnhco.org heruntergeladen**.
Die PDFs sind 1:1-Kopien ohne Veränderung.

| Quelle | Anzahl | Format |
|--------|--------|--------|
| Resolutionen (EN/DE) | 48 | PDF, heruntergeladen von tnhco.org/documents |
| Hatarozat (HU) | 34 | PDF, heruntergeladen von tnhco.org |
| Sonderdokumente (042-1, 043, 044) | 3 | PDF |
| Webseiten (tnhco.org) | 18 | HTML, manuell extrahiert |

**Zeitraum der Beschaffung:** Mai–Juni 2026  
**Status der Website zu diesem Zeitpunkt:** Aktiv

### 1.2 Sekundärquellen: Behörden & Register

| Quelle | Art | Verwendet für |
|--------|-----|---------------|
| **FINMA** (finma.ch) | Warnliste | Glaubwürdigkeitsanalyse, FINMA-Warnung 04.02.2025 |
| **IOSCO** (iosco.org) | I-SCAN | Internationale Verbreitung der Warnung (#36211) |
| **Zefix** (zefix.ch) | Handelsregister | Firmendaten TNHCO, GSPC AG, simpleapps.ch |
| **SHAB** (shab.ch) | Handelsamtsblatt | Gründungsdaten, Mutationen, Board-Änderungen |
| **CNB** (cnb.cz) | Zentralbank-Warnung | Tschechische Warnung vor M1 |
| **SARB** (resbank.co.za) | Joint Statement | Südafrikanische Behördenwarnung 2021 |

### 1.3 Öffentlich zugängliche Recherche-Plattformen

| Quelle | Verwendet für |
|--------|---------------|
| **DuckDuckGo** | Websuche (keine personalisierten Ergebnisse) |
| **North Data** | Firmenverflechtungen (EU) |
| **business-monitor.ch** | Schweizer Firmenprofile |
| **OffshoreAlert** | FINMA-Warnung + Keywords |
| **Wikipedia** | Hintergrundwissen, Vergleichsfälle |
| **sekty.tv** | Recherche über Paramonov/Zlatá éra in Tschechien |
| **LinkedIn** | Beruflicher Hintergrund René Immoos |

---

## 2. OCR-Extraktion

### 2.1 Tools & Workflow

| Werkzeug | Einsatz |
|----------|---------|
| **pdftotext** (Poppler) | PDFs mit embedded text (52 Dateien) |
| **Tesseract OCR** | Bildbasierte PDFs (38 Dateien) |

### 2.2 Qualitätsstufen

| Stufe | Beschreibung | Anzahl |
|-------|-------------|--------|
| **Text** | Eingebetteter Text, direkt extrahiert | ~52 |
| **OCR** | Bild-Scan, Tesseract-Erkennung | ~38 |

**Bekannte Einschränkungen:**
- OCR-Ergebnisse können Erkennungsfehler enthalten (z.B. „rn" statt „m")
- Formatierungsartefakte der Original-PDFs sind in den Markdown-Dateien erhalten
- Einige PDFs sind gescannte Dokumente mit handschriftlichen Elementen
- Ungarische OCR-Qualität variiert (Sprachmodell: hun+eng)

---

## 3. Übersetzungs-Pipeline

### 3.1 Verwendete Systeme

| System | Verwendung |
|--------|-----------|
| **DeepSeek V4** | Primäres Übersetzungstool für EN→DE und HU→DE |
| **Google Translate** | Zweitmeinung und Vergleich |

### 3.2 Workflow

1. OCR-extrahierten Text bereinigen (offensichtliche Artefakte entfernen)
2. Übersetzung durch DeepSeek V4
3. Stichprobenartige Qualitätskontrolle durch Google Translate
4. Manuelle Korrektur bei offensichtlichen Fehlern
5. Formatierung in Markdown

**Wichtiger Hinweis:** Die Übersetzungen sind **maschinell erstellt** und erheben
keinen Anspruch auf juristische oder amtliche Präzision. Sie dienen dem inhaltlichen
Verständnis für deutschsprachige Leser. Für rechtliche Zwecke sind ausschließlich
die Original-PDFs maßgeblich.

---

## 4. Analytische Methodik

### 4.1 Mehrdimensionale Analyse

Jede Resolution wird auf **vier Ebenen** analysiert:

| Ebene | Fragestellung |
|-------|---------------|
| **Faktisch** | Gibt es verifizierbare Beweise für die Behauptungen? |
| **Logisch** | Sind die Aussagen untereinander konsistent? |
| **Psychologisch** | Welche Wirkung sollen die Texte auf Leser haben? |
| **Kontextuell** | Wie reiht sich das Dokument in die Gesamtentwicklung ein? |

### 4.2 Querschnittsanalysen

Die Einzelanalysen werden durch **acht Querschnittsanalysen** ergänzt,
die Muster über alle 48 Resolutionen hinweg identifizieren:

- **Ungereimtheiten:** Interne Widersprüche zwischen Resolutionen
- **Themenvermischung:** Fusion von Finanzen/Religion/Verschwörung
- **Geldsystem-Paradox:** Strukturelle Selbstwidersprüche
- **Kultstruktur:** BITE-Modell und Sektenmechanismen
- **Spirituelle Paradoxie:** Licht-Dunkel-Rhetorik vs. tatsächliche Wirkung
- **BTC vs. Krypto:** Dezentralisierungsvergleich
- **LGBT-Verbot:** Einzelanalyse Resolution 035
- **Vergleichsrecherche:** 15 ähnliche Organisationen weltweit

---

## 5. Verifikationsmethodik

### 5.1 Positive Verifikation (was BELEGT ist)

✅ Behauptungen gelten als **belegt**, wenn sie durch unabhängige, öffentlich
zugängliche Quellen bestätigt werden (Handelsregister, Zentralbanken, Gerichte).

### 5.2 Negative Verifikation (was NICHT belegt ist)

❌ Behauptungen gelten als **unbelegt**, wenn:
- Keine unabhängige Quelle sie bestätigt
- Die behauptende Partei selbst die einzige Quelle ist
- Die Behauptung logisch widersprüchlich oder physikalisch unmöglich ist

### 5.3 Beispiele aus dieser Recherche

| Behauptung (M1) | Verifikationsversuch | Ergebnis |
|-----------------|---------------------|----------|
| UN-Registrierung 509519 / 521730 | Suche in UN-Registern | ❌ Nicht auffindbar |
| LEI-Nummer 2534008YC6NRP4BLQF15 | GLEIF-Datenbank | ❌ Kein aktiver Eintrag |
| FINMA-Warnung | finma.ch | ✅ Bestätigt, aktiv seit 02/2025 |
| TNHCO-Handelsregistereintrag | Zefix | ✅ Bestätigt, CHE-242.461.997 |
| 1.000t Gold für CryptoXAu | Kein Audit, kein Lagerort genannt | ❌ Unbelegt |

---

## 6. Ethische Grundsätze

### 6.1 Was wir TUN

- ✅ Ausschließlich **öffentlich zugängliche** Quellen verwenden
- ✅ Alle Behauptungen **mit Quellen belegen**
- ✅ Zwischen **Fakten** (belegt), **Analyse** (Interpretation) und **Meinung** (Wertung) unterscheiden
- ✅ Eigene Wissenslücken transparent machen
- ✅ Personenbezogene Daten nur aus öffentlichen Registern verwenden

### 6.2 Was wir NICHT tun

- ❌ Kein Hacking, kein unbefugter Zugriff auf Systeme
- ❌ Keine verdeckte Recherche (keine falschen Identitäten)
- ❌ Keine Belästigung oder Kontaktaufnahme mit TNHCO-Mitarbeitern gegen deren Willen
- ❌ Keine Veröffentlichung privater, nicht-öffentlicher Informationen
- ❌ Keine Vorverurteilung — die Analyse spricht für sich

### 6.3 Abgrenzung zu „OSINT" und investigativem Journalismus

Diese Recherche verwendet OSINT-Techniken (Open Source Intelligence), aber
ausschließlich im Rahmen **passiver, nicht-interaktiver Quellenanalyse**.
Es werden keine aktiven Ermittlungsmethoden (Undercover, Lockvogel-Angebote,
verdeckte Kommunikation) eingesetzt.

---

## 7. Technische Infrastruktur

| Komponente | Tool/Plattform |
|-----------|---------------|
| Dateiformat | Markdown (.md) |
| Diagramme | Mermaid (in Markdown eingebettet) |
| Versionskontrolle | Git |
| Hosting | Lokales Repository |
| Übersetzungs-API | DeepSeek V4 |

---

## 8. Grenzen dieser Recherche

1. **Sprachbarrieren:** Die russischen und ungarischen Originalquellen
   wurden maschinell übersetzt. Kulturelle Nuancen können verloren gehen.
2. **Fehlender Feldzugang:** Es wurden keine Interviews mit TNHCO-Mitgliedern
   oder -Opfern geführt. Die Innenperspektive fehlt.
3. **Keine forensische Finanzanalyse:** Es wurde kein Blockchain-Forensik-Tool
   eingesetzt. Die Finanzflüsse des ICO sind nicht nachverfolgt.
4. **Zeitpunkt-Abhängigkeit:** Die Recherche bildet den Stand Mai–Juli 2026 ab.
   TNHCO entwickelt sich weiter.
5. **Kein Handelsregisterauszug:** Für die Klärung der exakten TNHCO-Verwaltungsstruktur
   wäre ein kostenpflichtiger Handelsregisterauszug des Kantons Zug nötig.

---

## 9. Visuelles Farbschema (Styleguide)

Alle Analysen verwenden ein einheitliches Bewertungssystem:

### Prioritäten / Status

| Symbol | Bedeutung | Verwendung |
|--------|-----------|------------|
| 🔴 | Hoch / Kritisch | Prioritäten, akute Warnsignale |
| 🟡 | Mittel / Ungeklärt | Mittlere Priorität, Klärungsbedarf |
| 🟢 | Niedrig / Gering | Niedrige Priorität, positive Bewertung |
| ✨ | Optional / Humorvoll | Kreative/humorvolle Inhalte |

### Beweislage

| Symbol | Bedeutung | Verwendung |
|--------|-----------|------------|
| ✅ | Belegt | Durch unabhängige Quellen bestätigt |
| ⚠️ | Teilweise / Widersprüchlich | Gemischte Beleglage |
| ❌ | Unbelegt | Keine unabhängige Bestätigung |

### Vermischungsgrad (THEMEN_VERMISCHUNG.md)

| Symbol | Bedeutung |
|--------|-----------|
| 🟢 | Gering |
| 🟡 | Mittel |
| 🔴 | Hoch |

### Ähnlichkeitsgrad (VERGLEICHSRECHERCHE.md)

| Symbol | Bedeutung |
|--------|-----------|
| 🔴 | Extrem hoch |
| 🟠 | Sehr hoch |
| 🟡 | Hoch |
| 🟢 | Mittel |

---

> **Zitat zur Methodik:**
> *„Behauptungen, die ohne Beweise aufgestellt werden, können auch ohne Beweise
> zurückgewiesen werden."* — Christopher Hitchens

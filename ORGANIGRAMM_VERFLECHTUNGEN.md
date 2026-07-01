# TNHCO / White Spiritual Boy — Organigramm & Verflechtungen

> Sämtliche Verbindungen basierend auf Dokumentenanalyse und Internetrecherche
>
> 📎 **Verwandte Dokumente:** [Hauptrecherche](WHITE_SPIRITUAL_BOY_RESEARCH.md) · [Ermittlungen & Warnungen](ERMITTLUNGEN_WARNUNGEN.md) · [Gesamtindex](INDEX.md)

---

## 1. Gesamtnetzwerk (vollständige Verflechtung)

```mermaid
graph TB
    %% ZENTRALE FIGUR
    PARAMONOV["👤 **Alexander N. Paramonov**<br/>═══ Titel ═══<br/>• Chief Treasurer, M1<br/>• King of Kings<br/>• President, IFC<br/>• President, WSB R.S.B. Global Corp<br/>• Commander, Grand Magisterium<br/>• Grand Intendant, Order of Hospitallers"]

    %% KERNORGANISATIONEN
    M1["💰 **International Treasury<br/>Monetary One (M1)**<br/>LEI: 2534008YC6NRP4BLQF15<br/>UN ID: 626139<br/>Moskau, +7-495-1258418"]
    
    TNHCO["🏛️ **Terra Nova Helvetica<br/>Cooperative**<br/>Industriestr. 3<br/>6345 Neuheim, Schweiz<br/>tnhco.org | info@tnhco.org"]
    
    WSB_MAIN["🏦 **World Sovereign Bank<br/>of the Order of Hospitallers**<br/>Account: 01-00-01-4-AAA-777-C3-AM-01<br/>Account: 01-1-700-3516 222 777 8888 999"]

    %% RECHTLICHE ENTITÄTEN
    RSB["📄 **White Spiritual Boy<br/>R.S.B. Global Corp Inc**<br/>World Citizen"]
    IFC["📄 **International Financial<br/>Corporation**"]
    USSL["📄 **Union of Sovereign<br/>Slavic Lineages**<br/>unionssl.org"]
    ZWP["📄 **ZWP Coop**<br/>zwpcoop.pl (Polen)"]
    RUSKAZNA["📄 **RusKazna.su**<br/>russisches Schatzamt"]

    %% POLITISCHE STRUKTUREN
    GOVUSSR["🏴 **Government USSR**<br/>governmentussr.org"]
    ANTICRISIS["🏴 **Anti-Crisis Center**<br/>Special Department"]
    COUNTERTERROR["🏴 **Union Counter-Terrorism**<br/>State Service"]
    JOINTCOM["🏴 **Joint Executive Committee<br/>with Special Powers**"]

    %% HISTORISCHE ORDEN
    SMOM["⚜️ **Sovereign & Military Order<br/>of Saint John of Jerusalem**<br/>(Order of Hospitallers)<br/>UN ID: 521730"]
    MAGISTERIUM["⚜️ **Grand Magisterium**"]

    %% FINANZPRODUKTE
    MOM1["💲 **MOM1 (XAU) GDL**<br/>Gold Dollar<br/>1 Mrd. GDL = 1000t Gold"]
    CRYPTO["💲 **CryptoXAu (AXM)**<br/>Gold-Kryptowährung"]
    TB_M1["💲 **TB M1**<br/>Treasury Bills<br/>3 Reservewährungen"]
    GOLD_RES["🥇 **Weltgoldreserve**<br/>Bankbilanz + Außerbilanz"]

    %% EXTERNE VERBINDUNGEN
    SEXWALE["🇿🇦 Tokyo Sexwale<br/>ANC-Veteran<br/>Heritage Fund"]
    HAWKS["🇿🇦 Hawks Police<br/>Ermittlungen"]
    ROTHSCHILD["🏛️ Rothschild Family<br/><i>Beziehungen widerrufen<br/>(Resolution 011)</i>"]
    BIS["🏛️ Bank for International<br/>Settlements (BIS)"]
    NATO["🏛️ NATO<br/><i>kritisiert in Resolution 016</i>"]
    BASEL["🏛️ Basel III<br/>Committee on Banking<br/>Supervision"]

    %% VERBINDUNGEN
    PARAMONOV -->|"Chief Treasurer"| M1
    PARAMONOV -->|"President"| RSB
    PARAMONOV -->|"President"| IFC
    PARAMONOV -->|"Commander"| SMOM
    PARAMONOV -->|"Grand Intendant"| MAGISTERIUM
    
    M1 -->|"Owner & Manager"| WSB_MAIN
    M1 -->|"Creator"| MOM1
    M1 -->|"Creator"| CRYPTO
    M1 -->|"Issuer"| TB_M1
    M1 -->|"Halter & Verwalter"| GOLD_RES
    M1 -->|"Betreibt"| ANTICRISIS
    M1 -->|"Betreibt"| COUNTERTERROR
    M1 -->|"Kontrolliert"| JOINTCOM
    
    TNHCO -->|"Hostet Dokumente"| M1
    TNHCO -->|"Kooperiert mit"| USSL
    ZWP -->|"Spiegelt Dokumente"| TNHCO
    RUSKAZNA -->|"Spiegelt Dokumente"| M1
    
    RSB -->|"Gelistet auf"| USSL
    GOVUSSR -->|"Press Center für"| M1
    
    MOM1 -->|"Gedeckt durch"| GOLD_RES
    CRYPTO -->|"Gedeckt durch"| MOM1
    
    M1 -->|"Beziehungen abgebrochen"| ROTHSCHILD
    M1 -->|"Kritisiert"| NATO
    M1 -->|"Empfiehlt"| BASEL
    
    SEXWALE -->|"Verwickelt in"| HAWKS
    HAWKS -->|"Ermittelt zu"| RSB
    
    %% STYLES
    style PARAMONOV fill:#ff4444,color:#fff,stroke:#cc0000,stroke-width:3px
    style M1 fill:#ffd700,color:#000,stroke:#cc9900,stroke-width:2px
    style TNHCO fill:#ff6b6b,color:#fff
    style WSB_MAIN fill:#4ecdc4,color:#000
    style RSB fill:#a8e6cf,color:#000
    style HAWKS fill:#6c5ce7,color:#fff
    style GOLD_RES fill:#ffd700,color:#000
```

---

## 2. Dokumentenfluss & Mirrors

```mermaid
graph LR
    ORIGIN["📝 Resolutionen<br/>& Dekrete<br/>M1 Treasury Moskau"]
    
    TNHCO_SITE["🌐 tnhco.org<br/>Schweiz<br/>90 PDFs<br/>DE/EN/IT/FR/HU"]
    ZWP_SITE["🌐 zwpcoop.pl<br/>Polen<br/>Resolution-022<br/>+ weitere"]
    RUSKAZNA_SITE["🌐 ruskazna.su<br/>Russland<br/>Order 030"]
    GOVUSSR_SITE["🌐 governmentussr.org<br/>Resolution 011"]
    YOUTUBE["📺 YouTube<br/>Official Statements<br/>2 Videos gefunden"]
    
    ORIGIN -->|"Primärhosting"| TNHCO_SITE
    ORIGIN -->|"Spiegel"| ZWP_SITE
    ORIGIN -->|"Spiegel"| RUSKAZNA_SITE
    ORIGIN -->|"Press Releases"| GOVUSSR_SITE
    ORIGIN -->|"Video Statements"| YOUTUBE
    
    style ORIGIN fill:#ffd700,color:#000
    style TNHCO_SITE fill:#ff6b6b,color:#fff
```

---

## 3. Resolutionen-Typologie & Themen

```mermaid
mindmap
  root((TNHCO Resolutionen<br/>001-048))
    Finanzsystem
      Anti-Crisis Measures 001
      Gold Standard 001
      Weltreservewährungen 001
      CryptoXAu Emission 042-1
      Tether Decree 044
    Souveränität
      King of Kings 010
      Sovereign Rights 028
      Order of Hospitallers
      World Account Management
    Geopolitik
      Anti-NATO 016
      Anti-Rothschild 011
      Bilderbergs 034
      Nuclear Disarmament 016
      Sunrise Program 031
    Esoterik
      Creator RA
      White Spiritual Boy
      Divine Accounts
      Sacred Attributes
      Spiritual Wonder Boy
    Struktur
      Treasury Bills M1
      Anti-Crisis Center
      Counter-Terrorism
      Joint Executive Committee
```

---

## 4. Geldflüsse (behauptet)

```mermaid
flowchart TD
    GOLD["🥇 Weltgoldreserve<br/>Bankbilanz + Außerbilanz"]
    
    M1_TREASURY["💰 M1 Treasury"]
    
    WORLD_ACC["🏦 World Sovereign Bank<br/>Konto 01-00-01-4-AAA-777"]
    WORLD_ACC2["🏦 World Sovereign Bank<br/>Konto 01-1-700-3516"]
    
    SUB_ACCOUNTS["📋 17+ Sub-Accounts<br/>White Spiritual Boy<br/>Spiritual Wonder Boy<br/>Morning Star<br/>King David<br/>Prophet Muhammad<br/>White Mongolia<br/>White Vatican<br/>White Eagle<br/>Maria Sinukuan<br/>Maria Banahaw<br/>Maria Cristina<br/>Maria Makiling<br/>Easter Egg<br/>Falcon<br/>Alpha-Omega<br/>Demas & Saint Timothy<br/>+ weitere"]
    
    BANKS["🏦 189 Länder<br/>Gazprombank<br/>Evrofinance Mosnarbank<br/>Sberbank<br/>+ 186 weitere"]
    
    CURRENCIES["💱 Emission<br/>MOM1 Gold Dollar<br/>CryptoXAu Krypto<br/>TB M1 Treasury Bills"]
    
    COUNTRIES["🌍 Nationale Treasuries<br/>Zentralbanken<br/>Reservebanken"]

    GOLD -->|"100%"| M1_TREASURY
    M1_TREASURY -->|"Manager"| WORLD_ACC
    M1_TREASURY -->|"Manager"| WORLD_ACC2
    WORLD_ACC -->|"enthält"| SUB_ACCOUNTS
    WORLD_ACC2 -->|"enthält"| SUB_ACCOUNTS
    SUB_ACCOUNTS -->|"verteilt auf"| BANKS
    M1_TREASURY -->|"emittiert"| CURRENCIES
    CURRENCIES -->|"platziert in"| COUNTRIES

    style GOLD fill:#ffd700,color:#000,stroke:#cc9900,stroke-width:3px
    style M1_TREASURY fill:#ff4444,color:#fff
    style WORLD_ACC fill:#4ecdc4,color:#000
    style SUB_ACCOUNTS fill:#a8e6cf,color:#000
```

---

## 5. Akteursnetzwerk (Personen & Rollen)

```mermaid
graph TB
    PARAMONOV["👤 Alexander N. Paramonov<br/>═══ Rollen ═══<br/>Chief Treasurer M1<br/>King of Kings<br/>President IFC<br/>President WSB Global Corp<br/>Grand Commander Hospitallers"]

    TOKYO["👤 Tokyo Sexwale<br/>ANC-Veteran<br/>Ex-Minister Südafrika<br/>Heritage Fund Claims"]

    subgraph "Signatare in Resolutionen"
        WSB_SIG["White Spiritual Boy<br/><i>Commander, Grand Intendant</i>"]
        PARAMONOV_SIG["H.E. Alexander N. Paramonov<br/><i>Chief Treasurer</i>"]
    end

    subgraph "Externe Akteure"
        HAWKS_INV["Hawks Police SA<br/><i>Ermittler</i>"]
        ROTHSCHILD_FAM["Rothschild Familie<br/><i>Beziehungen gekappt</i>"]
        SEKTY_CZ["sekty.tv<br/><i>Investigativer Journalismus</i>"]
    end

    PARAMONOV -->|"ist"| WSB_SIG
    PARAMONOV -->|"ist"| PARAMONOV_SIG
    TOKYO -->|"Behauptet Zugang zu"| WSB_SIG
    HAWKS_INV -->|"Ermittelt gegen"| TOKYO
    HAWKS_INV -->|"Betrifft"| WSB_SIG
    SEKTY_CZ -->|"Berichtet über"| PARAMONOV
    PARAMONOV -->|"Widerruft Rechte von"| ROTHSCHILD_FAM

    style PARAMONOV fill:#ff4444,color:#fff,stroke:#cc0000,stroke-width:3px
    style TOKYO fill:#ffd700,color:#000
    style HAWKS_INV fill:#6c5ce7,color:#fff
```

---

## 6. Zeitstrahl der Schlüsselereignisse

```mermaid
timeline
    title Chronologie TNHCO / M1 / White Spiritual Boy
    section Vorgeschichte
        1961 : Goldener Sowjet-Rubel<br/>definiert (0.987g Gold)
        1944 : Bretton Woods<br/>Goldener US-Dollar
        2008 : White Spiritual Boy<br/>Account Audit $9.965 Mrd.
    section 2020
        April : Resolution 001<br/>Anti-Crisis Measures<br/>Paramonov tritt auf
        Juni : Resolution 002-003<br/>Weltfinanzsystem
    section 2021
        Feb-Okt : Resolutionen 004-007<br/>Strukturaufbau
        Dez : Resolution 008-009<br/>Weltaccount-Details
    section 2022
        Jan : Resolution 010<br/>King of Kings Proklamation
        Jan : Resolution 011<br/>Rothschild-Beziehungen beendet
        Jan-Nov : Resolutionen 012-022<br/>Operationelle Dekrete
    section 2023
        Jan-Dez : Resolutionen 023-043<br/>Expansion & Gold/Zyper
        Apr : Resolution 031 Sunrise
        Mai : Resolution 032 Pokon
        Jun : Resolution 033 Decree / 034 Bilderbergs
        Dez : 042-1 CryptoXAu / 043 DEC2023
    section 2024
        Jan : Resolution 044 Tether Decree
        Apr : Resolution 045
        Jul : Resolution 046
        Apr : sekty.tv Bericht über Paramonov
    section 2025
        Mai : Resolution 047
        Jun : Resolution 048
        SABC : Hawks-Ermittlungen zu Sexwale/Heritage Fund
    section 2026
        Mrz-Jun : TNHCO Infoveranstaltungen<br/>in der Schweiz
```

---

## 7. Geographische Verteilung

```mermaid
graph TB
    subgraph "🇨🇭 Schweiz"
        TNHCO_HQ["Neuheim ZG<br/>TNHCO Hauptsitz"]
    end

    subgraph "🇷🇺 Russland"
        M1_HQ["Moskau<br/>M1 Treasury<br/>+7-495-1258418"]
        BANKS["Gazprombank<br/>Evrofinance<br/>Sberbank"]
    end

    subgraph "🇵🇱 Polen"
        ZWP_HQ["ZWP Coop<br/>Dokumenten-Mirror"]
    end

    subgraph "🇸🇰 Slowakei"
        USSL_HQ["Union of Sovereign<br/>Slavic Lineages"]
    end

    subgraph "🇨🇿 Tschechien"
        SEKTY_MEDIA["sekty.tv<br/>Berichterstattung"]
    end

    subgraph "🇿🇦 Südafrika"
        SEXWALE_HQ["Tokyo Sexwale<br/>Heritage Fund"]
        HAWKS_HQ["Hawks Police<br/>Ermittlungen"]
    end

    subgraph "🇪🇺 EU / Global"
        BASEL_EU["Basel III<br/>Banking Supervision"]
        LEI_GLOBAL["GLEIF LEI Registry"]
        UN_GLOBAL["United Nations<br/>UN ID Registry"]
    end

    TNHCO_HQ <-->|"Dokumentenhosting"| M1_HQ
    M1_HQ -->|"Konten"| BANKS
    TNHCO_HQ <-->|"Dokumentenspiegel"| ZWP_HQ
    TNHCO_HQ <-->|"Board-Verbindung"| USSL_HQ
    SEKTY_MEDIA -->|"Berichtet über"| M1_HQ
    SEXWALE_HQ -->|"Behauptet Zugang zu"| M1_HQ
    HAWKS_HQ -->|"Ermittelt"| SEXWALE_HQ
    M1_HQ -->|"Referenziert"| BASEL_EU
    M1_HQ -->|"Registriert bei"| LEI_GLOBAL
    M1_HQ -->|"Registriert bei"| UN_GLOBAL

    style TNHCO_HQ fill:#ff6b6b,color:#fff
    style M1_HQ fill:#ffd700,color:#000
    style HAWKS_HQ fill:#6c5ce7,color:#fff
```

---

> **Hinweis:** Alle dargestellten Verbindungen basieren auf den in den TNHCO-Dokumenten gefundenen Angaben sowie öffentlich zugänglichen Internetquellen. Die Behauptungen der genannten Organisationen sind durch unabhängige Dritte nicht verifiziert.

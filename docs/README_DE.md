# Librelancer - Deutsche Dokumentation

[![](https://img.shields.io/badge/chat-on%20discord-green.svg)](https://discord.gg/QW2vzxx)

Eine Neuimplementierung des Weltraumspiels [Freelancer](https://de.wikipedia.org/wiki/Freelancer_(Computerspiel)) von 2003 in C# und OpenGL.

Läuft derzeit auf Windows und Linux (macOS wartet auf einen Maintainer).

Pull Requests sind willkommen!

## Inhaltsverzeichnis

- [Überblick](#überblick)
- [Systemanforderungen](#systemanforderungen)
- [Installation](#installation)
- [Dokumentation](#dokumentation)
- [Unterstützung](#unterstützung)
- [Lizenz](#lizenz)

## Überblick

Librelancer ist ein Open-Source-Projekt, das darauf abzielt, das klassische Weltraumspiel Freelancer mit moderner Technologie neu zu implementieren. Das Projekt nutzt C# für die Spiellogik und OpenGL für die Grafik-Rendering, um eine plattformübergreifende, erweiterbare und mod-freundliche Engine zu schaffen.

### Hauptmerkmale

- **Plattformübergreifend**: Läuft auf Windows und Linux
- **Moderne Rendering-Engine**: OpenGL 3.1+ basiert
- **Mod-Unterstützung**: Kompatibel mit Vanilla Freelancer und vielen Mods
- **Open Source**: MIT-Lizenz ermöglicht freie Nutzung und Modifikation
- **Aktive Entwicklung**: Regelmäßige Updates und Verbesserungen

## Systemanforderungen

### Allgemeine Anforderungen

- **GPU**: OpenGL 3.1+ kompatibel
- **Freelancer-Installation**: Vanilla Freelancer empfohlen, einige Mods können funktionieren
- **Speicher**: Mindestens 4 GB RAM
- **Festplatte**: Mindestens 2 GB freier Speicherplatz

### Plattformspezifische Anforderungen

#### Windows
- 64-bit Windows 10 oder neuer
- .NET 8.0 Runtime oder SDK

#### Linux
- x86-64 oder arm64 Architektur
- .NET 8.0 Runtime oder SDK
- SDL2 (oder SDL3)
- OpenAL-Soft
- GTK3

## Installation

### Vorkompilierte Binaries

Die einfachste Methode ist der Download vorkompilierter Binaries:

1. Besuchen Sie https://librelancer.net/downloads.html
2. Laden Sie die neueste Version für Ihre Plattform herunter
3. Entpacken Sie das Archiv
4. Führen Sie die ausführbare Datei aus

### Aus dem Quellcode bauen

Detaillierte Anweisungen zum Bauen aus dem Quellcode finden Sie in [INSTALLATION_DE.md](INSTALLATION_DE.md).

## Dokumentation

📖 **[Vollständige Dokumentations-Übersicht](DOKUMENTATION_ÜBERSICHT.md)** - Navigationshilfe für alle Dokumentations-Ressourcen

Die Librelancer-Dokumentation ist in mehrere Bereiche unterteilt:

### Für Benutzer

- **[Benutzerhandbuch](BENUTZERHANDBUCH.md)**: Anleitung zur Verwendung von Librelancer
- **[FAQ](FAQ_DE.md)**: Häufig gestellte Fragen und Antworten
- **[Installation](INSTALLATION_DE.md)**: Detaillierte Installationsanweisungen

### Für Entwickler

- **[Entwicklerhandbuch](ENTWICKLERHANDBUCH.md)**: Anleitung zur Entwicklung für Librelancer
- **[Architektur](ARCHITEKTUR.md)**: Technische Architektur-Übersicht
- **[Beitragen](BEITRAGEN.md)**: Richtlinien für Beiträge zum Projekt
- **[CI/CD](JENKINS_ANLEITUNG.md)**: Jenkins-Konfiguration für automatisierte Builds

### Für Modder

- **[Modding-Guide](modding/MODDING_GUIDE_DE.md)**: Anleitung zum Erstellen von Mods
- **[Scripting](scripts.md)**: Scripting-API-Referenz (Englisch)
- **[Model Importer](model-importer.md)**: Import von 3D-Modellen (Englisch)

### API-Dokumentation

Die vollständige API-Dokumentation ist im `docs/api`-Verzeichnis verfügbar.

## Unterstützung

### Community

- **Discord**: https://discord.gg/QW2vzxx
- **GitHub Issues**: https://github.com/Librelancer/Librelancer/issues
- **Website**: https://librelancer.net

### Finanzielle Unterstützung

Unterstützen Sie Librelancer auf Patreon: https://www.patreon.com/librelancer

## Lizenz

Librelancer ist unter der MIT-Lizenz lizenziert. Siehe [LICENSE](../LICENSE) für Details.

Copyright (c) Callum McGing, Librelancer Contributors 2013-2025

## Weitere Ressourcen

- [Projekt-Website](https://librelancer.net)
- [Screenshots](https://librelancer.net/screenshots.html)
- [GitHub Repository](https://github.com/Librelancer/Librelancer)
- [Original Freelancer Wiki](https://en.wikipedia.org/wiki/Freelancer_(video_game))

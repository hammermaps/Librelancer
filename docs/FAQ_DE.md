# Häufig gestellte Fragen (FAQ)

Antworten auf die häufigsten Fragen zu Librelancer.

## Inhaltsverzeichnis

- [Allgemeine Fragen](#allgemeine-fragen)
- [Installation und Setup](#installation-und-setup)
- [Spielen](#spielen)
- [Modding](#modding)
- [Technische Fragen](#technische-fragen)
- [Entwicklung und Beitragen](#entwicklung-und-beitragen)

## Allgemeine Fragen

### Was ist Librelancer?

Librelancer ist eine Open-Source-Neuimplementierung der Game Engine des Weltraumspiels Freelancer von 2003. Es ist in C# und OpenGL geschrieben und zielt darauf ab, das klassische Freelancer-Erlebnis auf modernen Systemen mit verbesserter Stabilität und Erweiterbarkeit zu bieten.

### Ist Librelancer dasselbe wie Freelancer?

Nein. Librelancer ist eine komplett neue Engine, die die Freelancer-Datenformate lesen und verwenden kann. Der Code wurde von Grund auf neu geschrieben und ist nicht mit dem originalen Freelancer-Code verwandt.

### Ist Librelancer legal?

Ja. Librelancer ist komplett eigenständiger Code unter der MIT-Lizenz. Es benötigt jedoch die Original-Freelancer-Assets (Modelle, Texturen, Sounds), die Sie legal durch den Kauf von Freelancer erwerben müssen.

### Wo kann ich Freelancer kaufen?

Freelancer ist auf verschiedenen Plattformen verfügbar:
- **GOG.com** (häufig im Angebot)
- **Gebraucht**: Original-CDs über eBay oder ähnliche Plattformen
- **Steam**: Momentan nicht verfügbar, war früher verfügbar

### Kostet Librelancer Geld?

Nein, Librelancer ist komplett kostenlos und Open Source. Sie können jedoch das Projekt finanziell unterstützen über:
- **Patreon**: https://www.patreon.com/librelancer
- **Direkte Beiträge**: Code, Dokumentation, Testing

### Auf welchen Plattformen läuft Librelancer?

- ✅ **Windows**: Windows 10 und neuer (64-bit)
- ✅ **Linux**: Ubuntu, Debian, Fedora, Arch und andere (x64, ARM64)
- ⏳ **macOS**: Theoretisch unterstützt, wartet auf Maintainer

### Wie unterscheidet sich Librelancer vom Original?

**Vorteile**:
- Läuft auf modernen Systemen ohne Kompatibilitätsprobleme
- Bessere Performance durch moderne Rendering-Techniken
- Cross-Platform (Linux-Unterstützung!)
- Open Source und erweiterbar
- Aktive Entwicklung

**Einschränkungen**:
- Noch in Entwicklung, nicht alle Features implementiert
- Multiplayer in früher Entwicklung
- Einige Mods funktionieren möglicherweise nicht

## Installation und Setup

### Welche Systemanforderungen gibt es?

**Minimum**:
- GPU mit OpenGL 3.1+ Unterstützung
- 4 GB RAM
- 2 GB freier Festplattenspeicher
- Freelancer-Installation

**Empfohlen**:
- GPU mit OpenGL 4.5+ (neuere Treiber)
- 8 GB RAM
- 5 GB freier Festplattenspeicher
- SSD für schnellere Ladezeiten

### Meine GPU unterstützt kein OpenGL 3.1+. Was kann ich tun?

Leider benötigt Librelancer mindestens OpenGL 3.1. Sehr alte Hardware (vor 2010) wird wahrscheinlich nicht funktionieren. Optionen:
- Aktualisieren Sie Ihre Grafiktreiber
- Upgrade der GPU (wenn möglich)
- Verwenden Sie das Original-Freelancer auf älterer Hardware

### Wie installiere ich Librelancer?

Siehe die detaillierte [Installationsanleitung](INSTALLATION_DE.md).

**Kurzfassung**:
1. Freelancer installieren
2. Librelancer von https://librelancer.net/downloads.html herunterladen
3. Entpacken und ausführen
4. Freelancer-Pfad beim ersten Start angeben

### Librelancer findet meine Freelancer-Installation nicht. Was tun?

1. **Automatische Suche**: Librelancer sucht in Standard-Verzeichnissen
2. **Manuelle Konfiguration**:
   - Erstellen Sie `freelancer.ini` im Librelancer-Verzeichnis oder
   - Windows: `%APPDATA%\Librelancer\freelancer.ini`
   - Linux: `~/.config/librelancer/freelancer.ini`
   
   Inhalt:
   ```ini
   [Freelancer]
   path = C:\Pfad\Zu\Freelancer
   ```

3. **Beim Start angeben**: Beim ersten Start nach dem Pfad fragen lassen

### Kann ich Librelancer und Original-Freelancer gleichzeitig installiert haben?

Ja, absolut! Librelancer nutzt nur die Daten von Freelancer, ändert aber nichts an der Installation. Beide können problemlos parallel existieren.

## Spielen

### Funktioniert die Kampagne?

Die Single-Player-Kampagne ist in Entwicklung. Einige Missionen funktionieren, andere noch nicht. Der Fokus liegt aktuell auf:
- Free Flight (Freies Fliegen)
- Handel
- Multiplayer

### Kann ich Spielstände vom Original-Freelancer übernehmen?

Derzeit nicht. Librelancer verwendet ein eigenes Speicherformat. In Zukunft könnte eine Konvertierungs-Option hinzugefügt werden.

### Funktioniert Multiplayer?

Multiplayer ist in aktiver Entwicklung:
- ✅ Grundlegendes Networking implementiert
- ✅ Server-Software (LLServer) verfügbar
- ⏳ Noch nicht feature-komplett
- ❌ Nicht kompatibel mit Original-Freelancer-Servern

### Kann ich mit Leuten spielen, die Original-Freelancer verwenden?

Nein. Librelancer verwendet ein eigenes Netzwerk-Protokoll und ist nicht mit Original-Freelancer-Servern kompatibel. Sie können nur mit anderen Librelancer-Spielern auf Librelancer-Servern spielen.

### Wie hostete ich einen Server?

1. Führen Sie `LLServer.exe` (Windows) oder `./LLServer` (Linux) aus
2. Konfigurieren Sie `server.ini`
3. Portfreigabe in Router/Firewall (Standard: Port 2302)
4. Spieler verbinden über Ihre IP-Adresse

Details in der Server-Dokumentation (in Entwicklung).

### Die Performance ist schlecht. Was kann ich tun?

**Grafik-Einstellungen reduzieren**:
1. Niedrigere Auflösung
2. VSync deaktivieren
3. Anti-Aliasing reduzieren oder deaktivieren
4. Schatten-Qualität reduzieren

**System-Optimierungen**:
1. Aktualisieren Sie Grafiktreiber
2. Schließen Sie Hintergrund-Programme
3. Stellen Sie sicher, dass Librelancer auf dedizierter GPU läuft (bei Laptops)

**Wenn nichts hilft**:
- Melden Sie ein Performance-Issue auf GitHub mit Ihren Systemspezifikationen

### Das Spiel stürzt ab. Was soll ich tun?

1. **Logs überprüfen**:
   - Windows: `%APPDATA%\Librelancer\logs\`
   - Linux: `~/.config/librelancer/logs/`

2. **Häufige Lösungen**:
   - Grafiktreiber aktualisieren
   - Freelancer-Installation validieren
   - Shader-Cache löschen
   - Librelancer neu installieren

3. **Hilfe holen**:
   - GitHub Issue erstellen mit Log-Dateien
   - Discord-Community fragen

## Modding

### Funktionieren Freelancer-Mods mit Librelancer?

**Teilweise**. Kompatibilität hängt vom Mod ab:

**✅ Funktionieren wahrscheinlich**:
- Daten-Mods (neue Ships, Waffen, Systeme)
- Texturen-Packs
- Audio-Mods
- Mods die nur INI/UTF-Dateien ändern

**❌ Funktionieren wahrscheinlich nicht**:
- Mods die Freelancer.exe hacken oder patchen
- Mods die Freelancer-spezifische DLLs nutzen
- Mods mit Custom-Launcher

**?** Muss getestet werden:
- Große Total Conversion Mods
- Mods mit Custom-Scripts

### Wie installiere ich einen Mod?

1. Installieren Sie den Mod wie gewohnt in Ihr Freelancer-Verzeichnis
2. Starten Sie Librelancer
3. Testen Sie, ob der Mod funktioniert

Bei Problemen:
- Überprüfen Sie Logs
- Melden Sie Kompatibilitätsprobleme auf GitHub

### Kann ich eigene Mods für Librelancer erstellen?

Ja! Sie können:
- Standard-Freelancer-Modding-Techniken verwenden
- Librelancer-Scripting-Features nutzen (Thorn-Scripts)
- LancerEdit für Model-Editing verwenden

Siehe [Modding-Guide](modding/MODDING_GUIDE_DE.md) (in Entwicklung).

### Unterstützt Librelancer neue Features, die Original-Freelancer nicht hat?

Teilweise. Einige geplante Features:
- Verbesserte Grafik-Optionen
- Erweiterte Scripting-API
- Moderne Multiplayer-Features
- Better Mod-Support

Die Priorität liegt aktuell auf Kompatibilität mit Original-Freelancer.

## Technische Fragen

### In welcher Sprache ist Librelancer geschrieben?

- **Haupt-Engine**: C# (.NET 8)
- **Native Komponenten**: C/C++ (OpenGL-Bindings, Audio, etc.)
- **Scripting**: Thorn (eigene Sprache) + C# für Editor-Scripts

### Warum C# und nicht C++?

**Vorteile von C#**:
- Schnellere Entwicklung
- Bessere Speichersicherheit
- Cross-Platform mit .NET
- Moderne Language-Features
- Gute Performance (vor allem mit .NET 8)

Performance-kritische Teile (Rendering, Physik) sind hochoptimiert oder nutzen native Code.

### Welche OpenGL-Version wird benötigt?

**Minimum**: OpenGL 3.1
**Empfohlen**: OpenGL 4.5+

Ältere Versionen werden nicht unterstützt, da moderne Shader-Features benötigt werden.

### Unterstützt Librelancer Vulkan oder DirectX?

Aktuell nur OpenGL. Andere APIs sind möglich, aber:
- Vulkan: Sehr niedrig-level, hoher Entwicklungsaufwand
- DirectX: Nur Windows, keine Cross-Platform-Vorteile
- Metal: Nur macOS/iOS

OpenGL bietet gute Cross-Platform-Unterstützung und ausreichende Performance.

### Kann ich den Quellcode einsehen?

Ja! Librelancer ist Open Source unter MIT-Lizenz:
- **GitHub**: https://github.com/Librelancer/Librelancer
- **Lizenz**: MIT (sehr permissiv)

Sie können den Code frei verwenden, ändern und weitergeben.

### Wie wird Librelancer gebaut?

Siehe [Installationsanleitung](INSTALLATION_DE.md) und [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md).

**Kurz**:
```bash
# Windows
git clone --recursive https://github.com/Librelancer/Librelancer
cd Librelancer
.\build.ps1

# Linux
git clone --recursive https://github.com/Librelancer/Librelancer
cd Librelancer
./build.sh
```

## Entwicklung und Beitragen

### Wie kann ich zum Projekt beitragen?

Viele Wege:
1. **Code**: Features implementieren, Bugs fixen
2. **Testing**: Bugs finden und melden
3. **Dokumentation**: Docs schreiben oder verbessern
4. **Übersetzung**: UI und Docs in andere Sprachen
5. **Artwork**: Icons, Screenshots, Promotional Material
6. **Community**: Anderen Nutzern helfen

Siehe [Beitragsrichtlinien](BEITRAGEN.md).

### Ich kann nicht programmieren. Kann ich trotzdem helfen?

Absolut! Nicht-Code-Beiträge sind sehr wertvoll:
- **Testing**: Finden Sie Bugs und melden Sie diese
- **Dokumentation**: Schreiben oder verbessern Sie Docs
- **Übersetzungen**: Übersetzen Sie UI und Dokumentation
- **Community-Support**: Helfen Sie anderen im Discord/Forum
- **Content-Creation**: Videos, Tutorials, Blog-Posts

### Welche Programmiersprachen muss ich können?

Für verschiedene Bereiche:
- **C#**: Haupt-Engine, Editor, Tools
- **C/C++**: Native Komponenten (optional)
- **HLSL**: Shader-Entwicklung (optional)
- **Keine**: Testing, Dokumentation, Community-Support!

### Wie ist der Entwicklungs-Workflow?

1. Fork das Repository
2. Erstelle einen Feature-Branch
3. Implementiere Feature/Fix
4. Teste deine Änderungen
5. Erstelle Pull Request
6. Code Review durch Maintainer
7. Merge nach Approval

Details: [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md)

### Gibt es Coding-Standards?

Ja, Librelancer folgt:
- .NET Coding Conventions
- EditorConfig im Repository
- Code-Style-Guidelines im [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md)

Moderne IDEs wenden diese automatisch an.

### Wie lange dauert es, bis mein Pull Request gemerged wird?

Hängt ab von:
- Komplexität der Änderung
- Qualität des Codes
- Verfügbarkeit der Maintainer
- Review-Feedback

Typischerweise: Wenige Tage bis Wochen. Große Features können länger dauern.

### Gibt es einen Entwicklungs-Roadmap?

Grobe Prioritäten:
1. ✅ Core Engine-Stabilität
2. ⏳ Single-Player-Kampagne
3. ⏳ Multiplayer
4. ⏳ Modding-Tools
5. 📋 Performance-Optimierungen
6. 📋 Zusätzliche Features

Details in GitHub Issues und Discussions.

## Support und Community

### Wo bekomme ich Hilfe?

1. **Discord**: https://discord.gg/QW2vzxx (schnellste Antwort)
2. **GitHub Issues**: Für Bug-Reports und Feature-Requests
3. **GitHub Discussions**: Für Fragen und Diskussionen
4. **Dokumentation**: Diese Docs durchsuchen

### Ich habe einen Bug gefunden. Wie melde ich ihn?

1. **Überprüfen**: Ist es ein bekanntes Problem? (GitHub Issues checken)
2. **Informationen sammeln**:
   - Betriebssystem und Version
   - Librelancer-Version
   - Schritte zur Reproduktion
   - Log-Dateien
   - Screenshots/Videos (wenn relevant)
3. **GitHub Issue erstellen**: https://github.com/Librelancer/Librelancer/issues/new

### Wie kann ich ein Feature vorschlagen?

1. **Discord diskutieren**: Feedback von Community holen
2. **GitHub Discussion**: Für größere Features
3. **GitHub Issue**: Feature Request mit klarer Beschreibung

### Gibt es ein Wiki oder Forum?

- **GitHub Wiki**: https://github.com/Librelancer/Librelancer/wiki
- **GitHub Discussions**: https://github.com/Librelancer/Librelancer/discussions
- **Discord**: Haupt-Community-Hub

### Kann ich Librelancer für kommerzielle Projekte verwenden?

Ja! Die MIT-Lizenz erlaubt kommerzielle Nutzung. Beachten Sie:
- Sie benötigen trotzdem Freelancer-Assets (separat lizenziert)
- Namensnennung wird geschätzt, ist aber nicht erforderlich
- Keine Garantie oder Gewährleistung

Für spezifische Fragen: Kontaktieren Sie die Maintainer.

## Weitere Fragen?

Wenn Ihre Frage hier nicht beantwortet wurde:

1. Durchsuchen Sie die [vollständige Dokumentation](README_DE.md)
2. Fragen Sie im [Discord](https://discord.gg/QW2vzxx)
3. Erstellen Sie eine [GitHub Discussion](https://github.com/Librelancer/Librelancer/discussions)

Wir helfen gerne! 🚀

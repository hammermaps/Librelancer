# Benutzerhandbuch für Librelancer

Willkommen beim Librelancer Benutzerhandbuch! Dieses Dokument hilft Ihnen dabei, Librelancer zu installieren, zu konfigurieren und zu verwenden.

## Inhaltsverzeichnis

- [Einführung](#einführung)
- [Installation](#installation)
- [Erste Schritte](#erste-schritte)
- [Spielen](#spielen)
- [LancerEdit - Der Editor](#lanceredit---der-editor)
- [Multiplayer](#multiplayer)
- [Konfiguration](#konfiguration)
- [Fehlerbehebung](#fehlerbehebung)
- [Häufig gestellte Fragen](#häufig-gestellte-fragen)

## Einführung

Librelancer ist eine Open-Source-Neuimplementierung des Weltraumspiels Freelancer von 2003. Es zielt darauf ab, das klassische Spielerlebnis auf modernen Systemen mit verbesserter Stabilität, Mod-Unterstützung und plattformübergreifender Kompatibilität zu bieten.

### Was kann Librelancer?

- ✅ Spiele Freelancer auf modernen Windows- und Linux-Systemen
- ✅ Verbesserte Grafik und Performance durch moderne OpenGL-Rendering
- ✅ Unterstützung für viele Freelancer-Mods
- ✅ Multiplayer-Support (in Entwicklung)
- ✅ Model-Editor und Entwickler-Tools
- ✅ Scripting für Modding und Automatisierung

### Was wird benötigt?

- Eine Freelancer-Installation (Original oder Steam-Version)
- GPU mit OpenGL 3.1+ Unterstützung
- Windows 10+ oder eine moderne Linux-Distribution
- Mindestens 4 GB RAM

## Installation

### Schnellstart

1. **Freelancer installieren**
   - Original-CD oder digitale Version (z.B. GOG, Steam falls verfügbar)
   - Notieren Sie sich den Installationspfad

2. **Librelancer herunterladen**
   - Besuchen Sie https://librelancer.net/downloads.html
   - Laden Sie die Version für Ihr Betriebssystem herunter

3. **Librelancer installieren**
   - Entpacken Sie das Archiv
   - Windows: Keine weitere Installation nötig
   - Linux: Installieren Sie Abhängigkeiten (siehe unten)

4. **Starten**
   - Führen Sie die Anwendung aus
   - Wählen Sie Ihr Freelancer-Verzeichnis beim ersten Start

### Detaillierte Installationsanleitung

Eine vollständige Installationsanleitung finden Sie in [INSTALLATION_DE.md](INSTALLATION_DE.md).

## Erste Schritte

### Librelancer konfigurieren

Beim ersten Start öffnet sich ein Dialog zur Konfiguration:

1. **Freelancer-Pfad auswählen**
   - Navigieren Sie zu Ihrem Freelancer-Installationsverzeichnis
   - Beispiel (Windows): `C:\Program Files (x86)\Microsoft Games\Freelancer`
   - Beispiel (Linux/Wine): `~/.wine/drive_c/Program Files/Microsoft Games/Freelancer`

2. **Einstellungen überprüfen**
   - Grafik-Einstellungen (Auflösung, Vollbild, etc.)
   - Audio-Einstellungen
   - Steuerung

3. **Spiel starten**
   - Klicken Sie auf "Start" oder "Play"

### Hauptmenü

Nach dem Start sehen Sie das Hauptmenü mit folgenden Optionen:

- **Neues Spiel**: Startet eine neue Kampagne
- **Spiel laden**: Lädt einen gespeicherten Spielstand
- **Multiplayer**: Verbindet zu Online-Servern
- **Optionen**: Ändert Einstellungen
- **Beenden**: Schließt das Spiel

## Spielen

### Steuerung

#### Standard-Tastenbelegung

**Raumschiff-Steuerung:**
- `W/A/S/D`: Pitch und Yaw
- `Q/E`: Roll
- `Maus`: Freie Kamera-Steuerung
- `Leertaste`: Schub
- `Tab`: Nachbrenner
- `X`: Motor stoppen

**Kampf:**
- `Linke Maustaste`: Primärwaffe
- `Rechte Maustaste`: Sekundärwaffe
- `R`: Ziel wechseln
- `T`: Nächstes feindliches Ziel
- `Y`: Freundliches Ziel

**Interface:**
- `F1`: Hilfe
- `F2`: Inventar
- `F3`: Karte
- `F9`: Screenshot
- `Escape`: Menü

#### Steuerung anpassen

1. Öffnen Sie das Optionsmenü
2. Wählen Sie "Steuerung"
3. Klicken Sie auf die zu ändernde Taste
4. Drücken Sie die neue Taste
5. Speichern Sie mit "Übernehmen"

### Grafik-Einstellungen

#### Auflösung ändern

1. Optionen → Grafik
2. Wählen Sie die gewünschte Auflösung
3. Vollbild/Fenster-Modus wählen
4. Übernehmen

#### Erweiterte Einstellungen

- **VSync**: Verhindert Screen Tearing
- **Anti-Aliasing**: Glättet gezackte Kanten
- **Anisotropes Filtering**: Verbessert Textur-Qualität
- **Schatten-Qualität**: Detailgrad der Schatten
- **Sichtweite**: Wie weit Sie sehen können

### Audio-Einstellungen

- **Master-Lautstärke**: Gesamtlautstärke
- **Musik**: Hintergrundmusik-Lautstärke
- **Effekte**: Sound-Effekte
- **Dialog**: Sprachausgabe
- **Audio-Gerät**: Ausgabegerät wählen (nur verfügbar wenn mehrere vorhanden)

## LancerEdit - Der Editor

LancerEdit ist das integrierte Tool zum Bearbeiten von Freelancer-Assets.

### LancerEdit starten

- **Windows**: Führen Sie `LancerEdit.exe` aus
- **Linux**: Führen Sie `./LancerEdit` aus

### Funktionen

#### Model Viewer

1. **Model öffnen**
   - File → Open
   - Navigieren Sie zu `.cmp` oder `.3db` Dateien
   - Wählen Sie ein Model aus

2. **Navigation**
   - `Linke Maustaste + Ziehen`: Kamera drehen
   - `Mittlere Maustaste + Ziehen`: Kamera bewegen
   - `Mausrad`: Zoom
   - `R`: Model zurücksetzen

3. **Ansicht anpassen**
   - View → Grid: Gitter ein/ausblenden
   - View → Wireframe: Drahtgitter-Modus
   - View → Textures: Texturen ein/ausblenden

#### Model Importer

So importieren Sie 3D-Modelle:

1. File → Import
2. Wählen Sie ein unterstütztes Format:
   - `.obj` (Wavefront OBJ)
   - `.dae` (Collada)
   - `.fbx` (Autodesk FBX)
3. Konfigurieren Sie Import-Optionen
4. Klicken Sie auf "Import"

Mehr Details: [Model Importer Dokumentation](model-importer.md)

#### Hardpoint Editor

Hardpoints sind Anknüpfungspunkte für Waffen, Triebwerke, etc.

1. Öffnen Sie ein Model
2. Wechseln Sie zum "Hardpoints" Tab
3. Bearbeiten Sie bestehende oder fügen Sie neue hinzu:
   - **Position**: XYZ-Koordinaten
   - **Rotation**: Orientierung
   - **Typ**: Waffe, Triebwerk, Equipment, etc.

#### Icon Generator

Generieren Sie 3DB-Icons für Inventar-Darstellung:

1. Tools → Generate Icons
2. Wählen Sie Input-Verzeichnis (Models)
3. Wählen Sie Output-Verzeichnis
4. Konfigurieren Sie Optionen (Größe, Beleuchtung)
5. Klicken Sie auf "Generate"

Mehr Details: [Icon Generator Dokumentation](genicons.md)

#### Scripting

LancerEdit unterstützt C#-Scripting für Automatisierung:

1. Scripts → Verfügbare Scripts werden angezeigt
2. Wählen Sie ein Script aus
3. Füllen Sie benötigte Parameter aus
4. Klicken Sie auf "Run"

Eigene Scripts erstellen:
- Platzieren Sie `.cs-script` Dateien im `editorscripts/` Ordner
- Siehe [Scripting-Dokumentation](scripts.md)

## Multiplayer

**Hinweis**: Multiplayer ist noch in aktiver Entwicklung. Funktionalität kann eingeschränkt sein.

### Server beitreten

1. Hauptmenü → Multiplayer
2. Server-Browser öffnet sich
3. Wählen Sie einen Server aus der Liste
4. Klicken Sie auf "Verbinden"
5. Erstellen Sie ein Charakter oder wählen Sie einen bestehenden

### Eigenen Server hosten

Für Serveradministratoren:

1. Führen Sie `LLServer.exe` (Windows) oder `./LLServer` (Linux) aus
2. Konfigurieren Sie `server.ini`:
   ```ini
   [Server]
   name = Mein Librelancer Server
   description = Ein freundlicher Server
   port = 2302
   max_players = 32
   ```
3. Starten Sie den Server
4. Andere können über Ihre IP-Adresse verbinden

## Konfiguration

### Konfigurationsdateien

Librelancer speichert Einstellungen in folgenden Dateien:

**Windows**:
- Benutzereinstellungen: `%APPDATA%\Librelancer\settings.ini`
- Freelancer-Pfad: `%APPDATA%\Librelancer\freelancer.ini`

**Linux**:
- Benutzereinstellungen: `~/.config/librelancer/settings.ini`
- Freelancer-Pfad: `~/.config/librelancer/freelancer.ini`

### settings.ini Optionen

```ini
[Graphics]
width = 1920
height = 1080
fullscreen = true
vsync = true
msaa = 4

[Audio]
master_volume = 1.0
music_volume = 0.7
sfx_volume = 0.8

[Game]
mouse_sensitivity = 1.0
invert_y = false
```

### Freelancer-Pfad manuell setzen

Bearbeiten Sie `freelancer.ini`:

```ini
[Freelancer]
path = C:\Games\Freelancer
```

## Fehlerbehebung

### Spiel startet nicht

**Problem**: Schwarzer Bildschirm oder sofortiger Absturz

**Lösungen**:
1. Überprüfen Sie GPU-Treiber (OpenGL 3.1+ erforderlich)
2. Prüfen Sie Freelancer-Pfad in `freelancer.ini`
3. Führen Sie als Administrator aus (Windows)
4. Prüfen Sie Logs in `%APPDATA%\Librelancer\logs\` (Windows) oder `~/.config/librelancer/logs/` (Linux)

### Schlechte Performance

**Lösungen**:
1. Reduzieren Sie Grafik-Einstellungen
2. Deaktivieren Sie VSync falls aktiviert
3. Reduzieren Sie Auflösung
4. Schließen Sie Hintergrund-Programme
5. Aktualisieren Sie Grafiktreiber

### Kein Ton

**Lösungen**:
1. Überprüfen Sie Audio-Einstellungen im Spiel
2. Prüfen Sie System-Lautstärke
3. Stellen Sie sicher, dass OpenAL installiert ist (Linux)
4. Wechseln Sie Audio-Gerät in den Einstellungen

### Texturen fehlen oder sind schwarz

**Lösungen**:
1. Überprüfen Sie Freelancer-Installation
2. Validieren Sie Spieldateien
3. Prüfen Sie Logs auf Ladefelher
4. Reinstallieren Sie Freelancer falls nötig

### Absturz beim Laden

**Lösungen**:
1. Prüfen Sie, ob Freelancer-Dateien beschädigt sind
2. Deaktivieren Sie Mods temporär
3. Löschen Sie Shader-Cache:
   - Windows: `%APPDATA%\Librelancer\shadercache\`
   - Linux: `~/.config/librelancer/shadercache/`

### Mod funktioniert nicht

**Lösungen**:
1. Überprüfen Sie Mod-Kompatibilität (nicht alle Mods werden unterstützt)
2. Installieren Sie Mod korrekt in Freelancer-Verzeichnis
3. Prüfen Sie Mod-Dokumentation
4. Melden Sie Probleme im Discord oder GitHub

## Häufig gestellte Fragen

Siehe auch: [FAQ_DE.md](FAQ_DE.md)

### Ist Librelancer dasselbe wie Freelancer?

Nein, Librelancer ist eine Neuimplementierung der Freelancer-Engine. Es kann Freelancer-Assets laden und verwenden, aber der Code ist komplett neu geschrieben.

### Brauche ich eine Freelancer-Installation?

Ja, Librelancer benötigt die Original-Freelancer-Dateien (Models, Texturen, Sounds, etc.) zum Ausführen.

### Funktionieren Freelancer-Mods mit Librelancer?

Viele Mods funktionieren, aber nicht alle. Vanilla-kompatible Mods haben die beste Chance. Mods die stark auf Freelancer.exe-Hacks basieren funktionieren nicht.

### Kann ich online mit Freelancer-Servern spielen?

Nein, Librelancer verwendet ein eigenes Netzwerk-Protokoll und ist nicht mit Original-Freelancer-Servern kompatibel.

### Wie kann ich helfen?

- Testen Sie das Spiel und melden Sie Bugs
- Beitragen Sie Code über GitHub
- Erstellen Sie Dokumentation
- Unterstützen Sie auf Patreon: https://www.patreon.com/librelancer

### Wo bekomme ich Hilfe?

- **Discord**: https://discord.gg/QW2vzxx
- **GitHub Issues**: https://github.com/Librelancer/Librelancer/issues
- **Dokumentation**: https://librelancer.net

## Weitere Ressourcen

- [Offizielle Website](https://librelancer.net)
- [GitHub Repository](https://github.com/Librelancer/Librelancer)
- [Discord Community](https://discord.gg/QW2vzxx)
- [Screenshots](https://librelancer.net/screenshots.html)

Viel Spaß beim Spielen! 🚀

# Installationsanleitung für Librelancer

Diese Anleitung beschreibt detailliert, wie Sie Librelancer auf Ihrem System installieren und aus dem Quellcode bauen können.

## Inhaltsverzeichnis

- [Vorkompilierte Binaries installieren](#vorkompilierte-binaries-installieren)
- [Aus dem Quellcode bauen](#aus-dem-quellcode-bauen)
  - [Windows](#windows-build-anleitung)
  - [Linux](#linux-build-anleitung)
  - [Nix](#nix-build-anleitung)
- [Freelancer-Installation konfigurieren](#freelancer-installation-konfigurieren)
- [Fehlerbehebung](#fehlerbehebung)

## Vorkompilierte Binaries installieren

### Windows

1. **Download**
   - Besuchen Sie https://librelancer.net/downloads.html
   - Laden Sie die neueste Windows-Version herunter (z.B. `librelancer-win64.zip`)

2. **Entpacken**
   - Entpacken Sie die ZIP-Datei an einen beliebigen Ort
   - Empfohlen: `C:\Program Files\Librelancer` oder `C:\Games\Librelancer`

3. **Freelancer konfigurieren**
   - Beim ersten Start werden Sie nach Ihrer Freelancer-Installation gefragt
   - Navigieren Sie zum Freelancer-Installationsverzeichnis (normalerweise `C:\Program Files (x86)\Microsoft Games\Freelancer`)

4. **Starten**
   - Führen Sie `Freelancer.exe` aus dem entpackten Verzeichnis aus

### Linux

1. **Download**
   - Besuchen Sie https://librelancer.net/downloads.html
   - Laden Sie die neueste Linux-Version herunter (z.B. `librelancer-ubuntu-amd64.tar.gz`)

2. **Entpacken**
   ```bash
   tar -xzf librelancer-ubuntu-amd64.tar.gz
   cd librelancer
   ```

3. **Abhängigkeiten installieren**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install libsdl2-2.0-0 libopenal1 libgtk-3-0
   
   # Fedora
   sudo dnf install SDL2 openal-soft gtk3
   
   # Arch Linux
   sudo pacman -S sdl2 openal gtk3
   ```

4. **Ausführbar machen**
   ```bash
   chmod +x Freelancer
   ```

5. **Starten**
   ```bash
   ./Freelancer
   ```

## Aus dem Quellcode bauen

**Wichtig für Entwickler**: `build.ps1` (Windows) oder `build.sh` (Linux) **muss** ausgeführt werden, bevor die `.sln`-Datei geöffnet wird, da erforderliche Dateien für die Lösung generiert werden.

### Windows Build-Anleitung

#### Voraussetzungen

1. **Betriebssystem**
   - 64-bit Windows 10 oder neuer
   - Windows 11 empfohlen für beste Kompatibilität

2. **Visual Studio 2022**
   - Laden Sie Visual Studio 2022 Community Edition herunter: https://visualstudio.microsoft.com/de/downloads/
   - Installieren Sie folgende Workloads:
     - **.NET Desktop-Entwicklung** (inkl. .NET 8.0 SDK)
     - **Desktopentwicklung mit C++**

3. **CMake**
   - Version 3.15 oder höher
   - Download: https://cmake.org/download/
   - Stellen Sie sicher, dass CMake zum PATH hinzugefügt wird

4. **Git**
   - Git for Windows: https://git-scm.com/download/win
   - Erforderlich für das Klonen des Repositories mit Submodules

#### Build-Schritte

1. **Repository klonen**
   ```powershell
   git clone --recursive https://github.com/Librelancer/Librelancer.git
   cd Librelancer
   ```

   Oder mit Visual Studio:
   - Team Explorer → Clone → URL eingeben
   - Stellen Sie sicher, dass "Recursively clone submodules" aktiviert ist

2. **Build-Skript ausführen**
   ```powershell
   .\build.ps1
   ```

   Falls Powershell-Ausführungsrichtlinien Probleme bereiten:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\build.ps1
   ```

3. **Visual Studio öffnen** (optional)
   ```powershell
   start LibreLancer.sln
   ```

4. **Projekt bauen**
   - In Visual Studio: Build → Build Solution (Strg+Shift+B)
   - Oder weiter über Kommandozeile arbeiten

#### Build-Targets

Das Build-Skript unterstützt verschiedene Targets:

```powershell
.\build.ps1 BuildAll        # Baut Engine und SDK (Standard)
.\build.ps1 BuildEngine     # Baut nur die Engine
.\build.ps1 BuildSdk        # Baut das komplette SDK
.\build.ps1 Test            # Führt Tests aus
.\build.ps1 BuildAndTest    # Baut und testet
```

#### Ausgabe-Verzeichnis

Die gebauten Binaries befinden sich in:
- `bin/Debug/net8.0/` (Debug-Build)
- `bin/Release/net8.0/` (Release-Build)

### Linux Build-Anleitung

#### Voraussetzungen

1. **.NET 8.0 SDK**
   ```bash
   # Ubuntu/Debian
   wget https://dot.net/v1/dotnet-install.sh
   chmod +x dotnet-install.sh
   ./dotnet-install.sh --channel 8.0
   
   # Oder über Package Manager (Ubuntu 22.04+)
   sudo apt-get update
   sudo apt-get install -y dotnet-sdk-8.0
   ```

2. **Entwicklungstools**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install -y cmake gcc g++ git
   
   # Fedora
   sudo dnf install cmake gcc gcc-c++ git
   
   # Arch Linux
   sudo pacman -S cmake gcc git
   ```

3. **Grafik- und Audio-Bibliotheken**
   ```bash
   # Ubuntu/Debian
   sudo apt-get install -y libgtk-3-dev libopenal-dev libsdl2-dev
   
   # Fedora
   sudo dnf install gtk3-devel openal-soft-devel SDL2-devel
   
   # Arch Linux
   sudo pacman -S gtk3 openal sdl2
   ```

#### Build-Schritte

1. **Repository klonen**
   ```bash
   git clone --recursive https://github.com/Librelancer/Librelancer.git
   cd Librelancer
   ```

2. **Build-Skript ausführbar machen und starten**
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. **Mit mehreren Threads bauen** (schneller)
   ```bash
   ./build.sh -j$(nproc) BuildAll
   ```

#### Build-Targets (Linux)

```bash
./build.sh BuildAll        # Baut Engine und SDK (Standard)
./build.sh BuildEngine     # Baut nur die Engine
./build.sh BuildSdk        # Baut das komplette SDK
./build.sh Test            # Führt Tests aus
./build.sh BuildAndTest    # Baut und testet
./build.sh LinuxDaily      # Erstellt Daily-Build-Pakete
```

#### Fehlerbehebung auf RedHat/Fedora

**Problem**: OpenSSL SHA1-Signatur-Fehler
```
error:03000098:digital envelope routines::invalid digest
```

**Lösung**: SHA1-Signaturen temporär aktivieren
```bash
OPENSSL_ENABLE_SHA1_SIGNATURES=1 ./build.sh
```

**Hinweis**: RedHat hat RSA+SHA1-Signaturen deaktiviert, was .NET Strong Name Signatures beeinträchtigt.

### Nix Build-Anleitung

Wenn Sie den Nix Package Manager verwenden:

1. **Nix Shell starten**
   ```bash
   nix-shell --pure
   ```

2. **Bauen**
   ```bash
   ./build.sh
   ```

Die Nix-Shell stellt automatisch alle benötigten Abhängigkeiten bereit.

## Freelancer-Installation konfigurieren

### Windows

1. **Automatische Erkennung**
   - Beim ersten Start versucht Librelancer, Freelancer automatisch zu finden
   - Standard-Suchpfade:
     - `C:\Program Files (x86)\Microsoft Games\Freelancer`
     - `C:\Program Files\Microsoft Games\Freelancer`
     - Steam-Installation (falls vorhanden)

2. **Manuelle Konfiguration**
   - Erstellen Sie eine Datei `freelancer.ini` im Librelancer-Verzeichnis:
   ```ini
   [Freelancer]
   path = C:\Path\To\Your\Freelancer
   ```

### Linux

1. **Freelancer über Wine/Proton**
   - Installieren Sie Freelancer über Wine oder Steam Proton
   - Standard-Pfad für Steam/Proton:
     ```
     ~/.steam/steam/steamapps/compatdata/[AppID]/pfx/drive_c/Program Files (x86)/Microsoft Games/Freelancer
     ```

2. **Konfigurationsdatei**
   - Erstellen Sie `~/.config/librelancer/freelancer.ini`:
   ```ini
   [Freelancer]
   path = /path/to/freelancer
   ```

## Fehlerbehebung

### Häufige Probleme

#### Windows: 32-bit und 64-bit .NET SDK konflikt

**Symptom**: Build schlägt fehl mit .NET-Pfad-Fehlern

**Diagnose**:
```cmd
where dotnet.exe
```

**Problem**: Wenn 32-bit vor 64-bit erscheint:
```
C:\Program Files (x86)\dotnet\dotnet.exe
C:\Program Files\dotnet\dotnet.exe
```

**Lösung**:
1. Deinstallieren Sie das 32-bit .NET SDK (empfohlen), oder
2. Ändern Sie die PATH-Umgebungsvariable, sodass 64-bit zuerst kommt

#### Linux: Submodules nicht vorhanden

**Symptom**: Fehlermeldungen über fehlende Dateien

**Lösung**:
```bash
git submodule update --init --recursive
```

#### Build schlägt mit CMake-Fehlern fehl

**Lösung**:
```bash
# Überprüfen Sie CMake-Version
cmake --version  # Sollte 3.15 oder höher sein

# Aktualisieren Sie CMake falls nötig
# Ubuntu/Debian
sudo apt-get install cmake

# Oder von cmake.org herunterladen
```

#### Visual Studio findet .NET SDK nicht

**Lösung**:
1. Öffnen Sie Visual Studio Installer
2. Modifizieren Sie Visual Studio 2022
3. Stellen Sie sicher, dass ".NET 8.0 SDK" installiert ist
4. Reparieren Sie Visual Studio falls nötig

#### Linux: Fehlende Bibliotheken

**Symptom**: Laufzeitfehler über fehlende .so-Dateien

**Lösung**:
```bash
# Überprüfen Sie installierte Bibliotheken
ldd bin/Debug/net8.0/Freelancer

# Installieren Sie fehlende Abhängigkeiten
sudo apt-get install libsdl2-2.0-0 libopenal1 libgtk-3-0
```

### Build-Cache löschen

Falls Builds fehlschlagen oder inkonsistent sind:

**Windows**:
```powershell
# Löschen Sie Build-Artefakte
Remove-Item -Recurse -Force bin, obj, extern\build

# Bauen Sie neu
.\build.ps1
```

**Linux**:
```bash
# Löschen Sie Build-Artefakte
rm -rf bin obj extern/build

# Bauen Sie neu
./build.sh
```

### Hilfe erhalten

Wenn Sie weiterhin Probleme haben:

1. **Überprüfen Sie GitHub Issues**: https://github.com/Librelancer/Librelancer/issues
2. **Discord Community**: https://discord.gg/QW2vzxx
3. **Erstellen Sie ein neues Issue** mit:
   - Betriebssystem und Version
   - .NET SDK Version (`dotnet --version`)
   - Vollständige Fehlermeldung
   - Build-Log (falls verfügbar)

## Weitere Informationen

- [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md) - Detaillierte Entwicklungsinformationen
- [CI/CD Setup](JENKINS_ANLEITUNG.md) - Automatisierte Build-Konfiguration
- [Beitragen](BEITRAGEN.md) - Wie Sie zum Projekt beitragen können

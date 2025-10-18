# Jenkins Schnellstart-Anleitung

Eine Kurzanleitung für die schnelle Einrichtung von Jenkins für Librelancer.

## Voraussetzungen

- Java 11+ installiert
- Jenkins installiert und läuft
- .NET 8.0 SDK installiert
- Git installiert

## In 5 Schritten zum ersten Build

### 1. Jenkins Plugin installieren

Öffnen Sie Jenkins und navigieren Sie zu:
**Manage Jenkins** → **Manage Plugins** → **Available**

Installieren Sie:
- Git Plugin
- Pipeline Plugin

### 2. Neues Pipeline-Projekt erstellen

1. Klicken Sie auf **New Item**
2. Name: `Librelancer-Build`
3. Typ: **Pipeline**
4. Klicken Sie **OK**

### 3. Pipeline konfigurieren

Im Konfigurationsbereich:

**Pipeline** Abschnitt:
- Definition: **Pipeline script from SCM**
- SCM: **Git**
- Repository URL: `https://github.com/hammermaps/Librelancer.git`
- Branch: `*/main`
- Script Path: `Jenkinsfile.simple` (für einfachen Build) oder `Jenkinsfile` (für erweiterten Build)

**Speichern**

### 4. Build starten

Klicken Sie auf **Build Now**

### 5. Build-Status überprüfen

Klicken Sie auf die Build-Nummer und dann auf **Console Output** um den Fortschritt zu sehen.

## Verfügbare Jenkinsfiles

Das Projekt enthält zwei Jenkinsfile-Varianten:

### `Jenkinsfile.simple`
- Einfache Konfiguration
- Baut auf einem beliebigen Agent (Linux oder Windows)
- Gut für Testzwecke oder einfache Setups

### `Jenkinsfile`
- Erweiterte Konfiguration
- Parallele Builds für Linux und Windows
- Automatische Paketierung für main Branch
- Empfohlen für Produktions-Setups

## Build-Targets

Das Projekt unterstützt verschiedene Build-Targets:

- `BuildAll` - Baut Engine und SDK
- `BuildEngine` - Baut nur die Engine
- `BuildSdk` - Baut das komplette SDK
- `Test` - Führt Tests aus
- `BuildAndTest` - Baut und testet
- `LinuxDaily` - Erstellt Daily Build Pakete

Verwendung in Jenkinsfile:
```bash
./build.sh BuildAndTest          # Linux
.\build.ps1 BuildAndTest         # Windows
```

## Häufige Probleme

### Problem: "Submodules not present"
**Lösung**: Stellen Sie sicher, dass Git-Submodule aktiviert sind in der SCM-Konfiguration.

### Problem: ".NET SDK not found"
**Lösung**: 
- Linux: `dotnet --version` ausführen, bei Fehler SDK installieren
- Windows: .NET 8.0 SDK von https://dotnet.microsoft.com/download installieren

### Problem: "CMake not found"
**Lösung**: 
- Linux: `sudo apt-get install cmake`
- Windows: CMake von https://cmake.org/download/ installieren

### Problem: Native Abhängigkeiten fehlen (Linux)
**Lösung**:
```bash
sudo apt-get update
sudo apt-get install -y libgtk-3-dev cmake libopenal-dev libsdl2-dev gcc g++
```

### Problem: Visual Studio nicht gefunden (Windows)
**Lösung**: Visual Studio 2022 mit "Desktop development with C++" Workload installieren.

## Erweiterte Konfiguration

Für erweiterte Features siehe: [JENKINS_ANLEITUNG.md](JENKINS_ANLEITUNG.md)

- Multi-Node Setup (separate Linux/Windows Agents)
- Webhook-Integration
- E-Mail-Benachrichtigungen
- Branch-spezifische Builds
- Deployment-Pipelines

## Nächste Schritte

1. Richten Sie separate Build-Knoten für Linux und Windows ein
2. Konfigurieren Sie GitHub Webhooks für automatische Builds
3. Aktivieren Sie E-Mail-Benachrichtigungen bei Fehlern
4. Erstellen Sie branch-spezifische Pipelines für Release und Development

## Support

- Vollständige Anleitung: [JENKINS_ANLEITUNG.md](JENKINS_ANLEITUNG.md)
- Librelancer Discord: https://discord.gg/QW2vzxx
- GitHub Issues: https://github.com/Librelancer/Librelancer/issues

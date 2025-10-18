# Jenkins Anleitung für Librelancer

Diese Anleitung beschreibt, wie Sie Jenkins für den automatischen Build und die Prüfung des Librelancer-Projekts unter Windows und Linux einrichten.

## Inhaltsverzeichnis

1. [Voraussetzungen](#voraussetzungen)
2. [Jenkins Installation](#jenkins-installation)
3. [Jenkins Konfiguration](#jenkins-konfiguration)
4. [Pipeline Einrichtung](#pipeline-einrichtung)
5. [Build-Knoten Konfiguration](#build-knoten-konfiguration)
6. [Fehlerbehebung](#fehlerbehebung)

## Voraussetzungen

### Jenkins Server
- Java 11 oder höher
- Mindestens 4 GB RAM
- 50 GB freier Speicherplatz

### Linux Build-Knoten
- x86-64 oder arm64 Architektur
- .NET 8.0 SDK
- CMake 3.15+
- gcc und g++
- SDL2 (oder SDL3)
- openal-soft
- GTK3 Headers (beinhaltet freetype usw.)
- g++-mingw-w64-x86-64 (für Windows Cross-Compilation)

Installation der Abhängigkeiten unter Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install -y libgtk-3-dev cmake libopenal-dev libsdl2-dev gcc g++ g++-mingw-w64-x86-64
```

### Windows Build-Knoten
- 64-bit Windows 10 oder neuer
- Visual Studio 2022 mit:
  - .NET 8.0 SDK
  - Desktop C++ Development Workflow
- CMake 3.15+
- PowerShell 5.0 oder höher

## Jenkins Installation

### Linux Installation

1. Java installieren:
```bash
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk
```

2. Jenkins Repository hinzufügen und installieren:
```bash
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
```

3. Jenkins starten:
```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

4. Initial-Passwort abrufen:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Windows Installation

1. Java JDK 11 oder höher herunterladen und installieren von: https://adoptium.net/

2. Jenkins Windows Installer herunterladen von: https://www.jenkins.io/download/

3. Installer ausführen und den Anweisungen folgen

4. Jenkins wird als Windows-Dienst installiert und automatisch gestartet

5. Im Browser öffnen: http://localhost:8080

6. Initial-Passwort eingeben aus: `C:\Program Files\Jenkins\secrets\initialAdminPassword`

## Jenkins Konfiguration

### Ersteinrichtung

1. Jenkins im Browser öffnen: http://localhost:8080 (oder Ihre Server-IP)

2. Initial-Passwort eingeben

3. "Install suggested plugins" auswählen

4. Admin-Benutzer erstellen

5. Jenkins URL bestätigen

### Erforderliche Plugins installieren

Navigieren Sie zu **Manage Jenkins** > **Manage Plugins** > **Available** und installieren Sie:

- **Git Plugin** - für Git-Repository-Integration
- **Pipeline Plugin** - für Pipeline-Unterstützung (meist schon installiert)
- **Pipeline: Stage View Plugin** - für bessere Visualisierung
- **Workspace Cleanup Plugin** - für automatisches Aufräumen
- **Timestamper Plugin** - für Zeitstempel in Logs

Nach der Installation Jenkins neu starten:
```bash
sudo systemctl restart jenkins  # Linux
# oder über Jenkins UI: Manage Jenkins > Prepare for Shutdown
```

## Pipeline Einrichtung

### Neues Pipeline-Projekt erstellen

1. Klicken Sie auf **New Item** in der Jenkins-Hauptseite

2. Geben Sie einen Namen ein, z.B. "Librelancer-Build"

3. Wählen Sie **Pipeline** als Projekttyp

4. Klicken Sie auf **OK**

### Pipeline konfigurieren

1. Im Konfigurationsbereich des Projekts:

2. **General** Abschnitt:
   - Aktivieren Sie "Discard old builds"
   - Behalten Sie maximal 10 Builds

3. **Build Triggers** Abschnitt:
   - Aktivieren Sie "Poll SCM" für automatische Builds
   - Schedule: `H/15 * * * *` (prüft alle 15 Minuten auf Änderungen)
   - Oder aktivieren Sie "GitHub hook trigger for GITScm polling" wenn Sie Webhooks verwenden

4. **Pipeline** Abschnitt:
   - Definition: "Pipeline script from SCM"
   - SCM: "Git"
   - Repository URL: `https://github.com/hammermaps/Librelancer.git`
   - Credentials: Fügen Sie bei Bedarf Zugangsdaten hinzu
   - Branch Specifier: `*/main` (oder gewünschter Branch)
   - Script Path: `Jenkinsfile`

5. Klicken Sie auf **Save**

## Build-Knoten Konfiguration

### Linux Build-Knoten hinzufügen

1. Navigieren Sie zu **Manage Jenkins** > **Manage Nodes and Clouds**

2. Klicken Sie auf **New Node**

3. Konfiguration:
   - Node Name: `linux-builder`
   - Type: **Permanent Agent**
   - Number of executors: 2 (oder mehr je nach CPU-Kernen)
   - Remote root directory: `/var/jenkins`
   - Labels: `linux`
   - Usage: "Only build jobs with label expressions matching this node"
   - Launch method: "Launch agents via SSH"
   - Host: IP-Adresse oder Hostname des Linux-Rechners
   - Credentials: SSH-Zugangsdaten hinzufügen

4. SSH-Zugangsdaten einrichten:
   - Kind: "SSH Username with private key"
   - Username: jenkins-Benutzer auf dem Linux-System
   - Private Key: SSH-Schlüssel einfügen oder Datei auswählen

5. Auf dem Linux-Knoten:
```bash
# Jenkins-Benutzer erstellen
sudo useradd -m -s /bin/bash jenkins
sudo mkdir -p /var/jenkins
sudo chown jenkins:jenkins /var/jenkins

# SSH-Schlüssel einrichten
sudo -u jenkins ssh-keygen -t rsa -b 4096
# Öffentlichen Schlüssel zu authorized_keys hinzufügen
```

6. Speichern und den Knoten starten

### Windows Build-Knoten hinzufügen

1. Navigieren Sie zu **Manage Jenkins** > **Manage Nodes and Clouds**

2. Klicken Sie auf **New Node**

3. Konfiguration:
   - Node Name: `windows-builder`
   - Type: **Permanent Agent**
   - Number of executors: 2
   - Remote root directory: `C:\Jenkins`
   - Labels: `windows`
   - Usage: "Only build jobs with label expressions matching this node"
   - Launch method: "Launch agent by connecting it to the controller"

4. Nach dem Speichern erscheint eine Anleitung zum Starten des Agents

5. Auf dem Windows-Knoten:
   - Laden Sie die `agent.jar` herunter
   - Erstellen Sie ein Verzeichnis `C:\Jenkins`
   - Führen Sie den Agent aus:
   ```powershell
   java -jar agent.jar -jnlpUrl http://JENKINS_SERVER:8080/computer/windows-builder/jenkins-agent.jnlp -secret SECRET_KEY -workDir "C:\Jenkins"
   ```

6. Optional: Als Windows-Dienst einrichten mit dem Jenkins Slave Service Wrapper

### Abhängigkeiten auf Build-Knoten installieren

#### Linux-Knoten:
```bash
# .NET SDK installieren
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 8.0

# Native Abhängigkeiten installieren
sudo apt-get update
sudo apt-get install -y libgtk-3-dev cmake libopenal-dev libsdl2-dev gcc g++ g++-mingw-w64-x86-64

# Git konfigurieren
git config --global core.autocrlf input
```

#### Windows-Knoten:
```powershell
# .NET SDK installieren (von https://dotnet.microsoft.com/download)
# Visual Studio 2022 mit C++ Development installieren
# CMake installieren (von https://cmake.org/download/)

# Git für Windows installieren (falls nicht vorhanden)
# Von: https://git-scm.com/download/win
```

## Verwendung

### Build manuell starten

1. Öffnen Sie das Pipeline-Projekt in Jenkins

2. Klicken Sie auf **Build Now**

3. Verfolgen Sie den Fortschritt in der Build-Historie

4. Klicken Sie auf die Build-Nummer für Details und Logs

### Build-Artefakte

Nach erfolgreichem Build finden Sie die Artefakte:

- **Linux Build**: Unter "Archived Artifacts" im Build
- **Windows Build**: Unter "Archived Artifacts" im Build
- **Daily Packages** (nur main Branch): 
  - `librelancer-daily-ubuntu-amd64.tar.gz`
  - `librelancer-sdk-daily-ubuntu-amd64.tar.gz`
  - `librelancer-daily-win64.zip`
  - `librelancer-sdk-daily-win64.zip`

### Build-Status überwachen

1. **Stage View**: Zeigt den Fortschritt der verschiedenen Pipeline-Stages

2. **Console Output**: Vollständige Log-Ausgabe des Builds

3. **Test Results**: Automatisch veröffentlicht (falls Tests konfiguriert)

## Jenkins Pipeline Struktur

Die Jenkinsfile im Projekt-Root definiert folgende Stages:

### 1. Build and Test (Parallel)
- **Linux Build**: Baut und testet das Projekt unter Linux
- **Windows Build**: Baut und testet das Projekt unter Windows

### 2. Package Daily Builds (nur main Branch)
- Erstellt Paketierte Versionen für Linux und Windows
- Inkludiert Cross-Compilation für Windows 64-bit auf Linux

## Erweiterte Konfiguration

### Webhook für automatische Builds

#### GitHub Webhook einrichten:

1. In Ihrem GitHub Repository: **Settings** > **Webhooks** > **Add webhook**

2. Payload URL: `http://JENKINS_SERVER:8080/github-webhook/`

3. Content type: `application/json`

4. Events: "Just the push event"

5. Aktivieren Sie den Webhook

6. In Jenkins: Aktivieren Sie "GitHub hook trigger for GITScm polling" im Projekt

### E-Mail-Benachrichtigungen

1. **Manage Jenkins** > **Configure System**

2. **E-mail Notification** Abschnitt:
   - SMTP Server: Ihr Mail-Server
   - Erweiterte Einstellungen für Authentifizierung

3. Im Pipeline-Projekt, fügen Sie in der Jenkinsfile hinzu:
```groovy
post {
    failure {
        mail to: 'team@example.com',
             subject: "Build Failed: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
             body: "Build failed. Check: ${env.BUILD_URL}"
    }
}
```

### Mehrstufige Builds für verschiedene Branches

Erweitern Sie die Jenkinsfile für branch-spezifisches Verhalten:

```groovy
stage('Deploy') {
    when {
        branch 'release'
    }
    steps {
        // Deployment-Schritte
    }
}
```

## Fehlerbehebung

### Häufige Probleme

#### 1. "Agent offline" oder "Agent nicht verbunden"
- Prüfen Sie die Netzwerkverbindung zwischen Master und Agent
- Stellen Sie sicher, dass der Agent-Prozess läuft
- Überprüfen Sie die Firewall-Einstellungen

#### 2. "Git submodule update failed"
- Stellen Sie sicher, dass der Jenkins-Benutzer Zugriff auf das Repository hat
- Prüfen Sie SSH-Schlüssel oder Credentials

#### 3. "Dotnet SDK not found"
- Überprüfen Sie, ob .NET SDK 8.0 installiert ist: `dotnet --version`
- Stellen Sie sicher, dass dotnet im PATH ist

#### 4. "CMake not found" (Linux)
- Installieren Sie CMake: `sudo apt-get install cmake`
- Überprüfen Sie: `cmake --version`

#### 5. "Native build failed" (Windows)
- Stellen Sie sicher, dass Visual Studio 2022 mit C++ installiert ist
- Prüfen Sie, ob CMake im PATH ist

#### 6. Build-Timeout
- Erhöhen Sie den Timeout in der Pipeline:
```groovy
options {
    timeout(time: 3, unit: 'HOURS')
}
```

### Debug-Modus

Für detaillierte Debug-Informationen, ändern Sie die Jenkinsfile:

```groovy
environment {
    DOTNET_CLI_TELEMETRY_OPTOUT = '1'
    MSBUILD_VERBOSITY = 'detailed'
}
```

### Logs überprüfen

- **Jenkins Logs**: `/var/log/jenkins/jenkins.log` (Linux) oder Event Viewer (Windows)
- **Build Logs**: Über Jenkins UI unter "Console Output"
- **Agent Logs**: Auf dem Agent-System unter `<workspace>/remoting/logs/`

## Performance-Optimierung

### Build-Cache nutzen

Konfigurieren Sie persistente Workspaces für schnellere Builds:

```groovy
options {
    skipDefaultCheckout()  // Überspringt automatisches Checkout
}
```

### Parallele Builds

Das aktuelle Setup nutzt bereits parallele Stages für Linux und Windows.
Für mehr Parallelität, erhöhen Sie die Anzahl der Executors auf den Knoten.

### Ressourcen-Management

- Begrenzen Sie gleichzeitige Builds: **Throttle Concurrent Builds** Plugin
- Planen Sie schwere Builds außerhalb der Spitzenzeiten

## Sicherheitshinweise

1. **Credentials sicher verwalten**: Nutzen Sie Jenkins Credentials Store
2. **Zugriffskontrolle**: Konfigurieren Sie Benutzerrollen und -berechtigungen
3. **HTTPS verwenden**: Für Jenkins Web-Interface
4. **Regelmäßige Updates**: Halten Sie Jenkins und Plugins aktuell
5. **Firewall-Regeln**: Schränken Sie Zugriff auf Jenkins-Port ein

## Zusätzliche Ressourcen

- Jenkins Dokumentation: https://www.jenkins.io/doc/
- Pipeline Syntax: https://www.jenkins.io/doc/book/pipeline/syntax/
- Librelancer Repository: https://github.com/Librelancer/Librelancer
- Librelancer Website: https://librelancer.net

## Support

Bei Fragen oder Problemen:
- Librelancer Discord: https://discord.gg/QW2vzxx
- GitHub Issues: https://github.com/Librelancer/Librelancer/issues

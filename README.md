# Librelancer [![](https://img.shields.io/badge/chat-on%20discord-green.svg)](https://discord.gg/QW2vzxx)
A re-implementation of the 2003 Space Game [Freelancer](https://en.wikipedia.org/wiki/Freelancer_(video_game)) in C# and OpenGL.

Currently running on Windows and Linux (macOS pending maintainer)
Pull Requests are welcome!

Support Librelancer on Patreon: https://www.patreon.com/librelancer


Download compiled binaries from https://librelancer.net/downloads.html

## Über das Projekt (About the Project - German)

Librelancer ist eine vollständige Neuimplementierung des klassischen Weltraum-Spiels Freelancer von 2003. Das Projekt zielt darauf ab, das ursprüngliche Spielerlebnis auf modernen Systemen zu bewahren und gleichzeitig die Vorteile aktueller Technologien zu nutzen.

**Projektstatus:**
- ✅ Läuft auf Windows und Linux
- 🔄 macOS-Support in Entwicklung (Betreuer gesucht)
- 🎮 Aktive Entwicklung und Community

**Hauptmerkmale:**
- Geschrieben in C# mit OpenGL für moderne Hardware-Unterstützung
- Open-Source und kostenlos verfügbar
- Kompatibel mit originalen Freelancer-Installationen
- Erweiterbare Architektur für Modding
- Plattformübergreifende Unterstützung

**Community & Unterstützung:**
- Discord-Server für Diskussionen und Hilfe
- Aktive Entwickler-Community
- Pull Requests sind willkommen!
- Patreon-Unterstützung verfügbar für Projektentwicklung

Für detaillierte Informationen in deutscher Sprache, siehe die [Deutsche Dokumentation](#-deutsche-dokumentation-german-documentation) unten.

## Documentation

### 📖 Deutsche Dokumentation (German Documentation)

Umfassende deutsche Dokumentation ist verfügbar:
- **[Hauptdokumentation](docs/README_DE.md)** - Übersicht und Einstieg
- **[Installationsanleitung](docs/INSTALLATION_DE.md)** - Detaillierte Installationsschritte
- **[Benutzerhandbuch](docs/BENUTZERHANDBUCH.md)** - Anleitung für Benutzer
- **[Entwicklerhandbuch](docs/ENTWICKLERHANDBUCH.md)** - Für Entwickler
- **[Architektur](docs/ARCHITEKTUR.md)** - Technische Architektur-Übersicht
- **[FAQ](docs/FAQ_DE.md)** - Häufig gestellte Fragen
- **[Beitragen](docs/BEITRAGEN.md)** - Richtlinien für Beiträge
- **[CI/CD](docs/JENKINS_ANLEITUNG.md)** - Jenkins-Setup (Deutsch)

### English Documentation

- [LancerEdit Documentation](docs/index.md)
- [Scripts](docs/scripts.md)
- [Model Importer](docs/model-importer.md)
- [Development & Optimization](docs/README_OPTIMIZATION_DOCS.md)

## General Requirements
* GPU must be capable of OpenGL 3.1+
* A Freelancer installation (Vanilla recommended, some mods may work)

## Build Instructions

Note for developers: .\build.ps1 or build.sh _must_ be ran before opening the .sln file, as it generates required files for the solution.

### Continuous Integration

For automated builds and testing, Jenkins configuration files are provided:
- See [docs/JENKINS_ANLEITUNG.md](docs/JENKINS_ANLEITUNG.md) for detailed German documentation
- See [docs/JENKINS_SCHNELLSTART.md](docs/JENKINS_SCHNELLSTART.md) for quick start guide (German)
- Use `Jenkinsfile` for full parallel builds on Linux and Windows
- Use `Jenkinsfile.simple` for basic single-agent builds

### Windows
**Prerequisites:**

* 64-bit Windows 10 or newer
* Visual Studio 2022 with:
* * .NET 8.0 SDK
* *  Desktop C++ Development Workflow
* [CMake](https://cmake.org/) version 3.15+

**Steps:**

1. Clone this repository with all submodules (Visual Studio's Team Explorer, Git bash, etc.)
2. Run `build.ps1` in Powershell. (Can be launched from cmd by `powershell -File .\build.ps1`)

**Troubleshooting**:

If you run into issues with Powershell execution policies, you can bypass them with `powershell -ExecutionPolicy Bypass -File .\build.ps1`

If you have installed both the 32-bit and 64-bit dotnet SDKs, your PATH can be in an invalid state and the build will fail.
This can be checked with `where dotnet.exe` in the command prompt. If it returns output like:

```
> where.exe dotnet
C:\Program Files (x86)\dotnet\dotnet.exe
C:\Program Files\dotnet\dotnet.exe
```

You need to either uninstall the 32-bit dotnet SDK (recommended), or modify your PATH so the 64-bit SDK appears first in the list.

### Linux

**Prerequisites:**

* x86-64 or arm64 .NET 8.0 SDK
* SDL2 (or SDL3)
* openal-soft
* gcc and g++
* CMake 3.15+
* GTK3 headers (libgtk-3-dev) - includes freetype, fontconfig, harfbuzz

On Ubuntu/Debian, install build dependencies with:
```bash
sudo apt-get install build-essential cmake libgtk-3-dev libsdl2-dev libopenal-dev
```

**Steps:**

1. Clone this repository with `git clone --recursive https://github.com/Librelancer/Librelancer`
2. Run `build.sh`

**Troubleshooting:**

`Microsoft.CSharp.Core.targets(84,5): Error  : Unhandled exception. Interop+Crypto+OpenSslCryptographicException: error:03000098:digital envelope routines::invalid digest` on Fedora/RHEL:

RedHat has disabled RSA+SHA1 signatures in OpenSSL with a vendor patch, breaking strong name signatures in dotnet.

If you are using `./build.sh`, run the command as `OPENSSL_ENABLE_SHA1_SIGNATURES=1 ./build.sh` to work around this safely. 

For developers, noting that this is **not recommended** by RedHat, you can follow instructions from RedHat to re-enable SHA1 signatures system-wide: https://docs.redhat.com/fr/documentation/red_hat_enterprise_linux/9/html/security_hardening/proc_re-enabling-sha-1_using-the-system-wide-cryptographic-policies


### Nix

If you are using the Nix package manager, you can use the provided shell script to easily acquire all the packages. You can do so by running the `nix-shell --pure` command then running `./build.sh`.

## Screenshots
See: https://librelancer.net/screenshots.html

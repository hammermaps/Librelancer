# Entwicklerhandbuch für Librelancer

Willkommen beim Librelancer-Entwicklerhandbuch! Dieses Dokument richtet sich an Entwickler, die zum Librelancer-Projekt beitragen oder die Engine für eigene Projekte erweitern möchten.

## Inhaltsverzeichnis

- [Erste Schritte](#erste-schritte)
- [Projektstruktur](#projektstruktur)
- [Entwicklungsumgebung einrichten](#entwicklungsumgebung-einrichten)
- [Code-Konventionen](#code-konventionen)
- [Build-System](#build-system)
- [Testing](#testing)
- [Debugging](#debugging)
- [Architektur-Übersicht](#architektur-übersicht)
- [Wichtige Komponenten](#wichtige-komponenten)
- [Continuous Integration](#continuous-integration)
- [Beiträge einreichen](#beiträge-einreichen)

## Erste Schritte

### Voraussetzungen

Bevor Sie mit der Entwicklung beginnen, stellen Sie sicher, dass Sie folgendes installiert haben:

1. **.NET 8.0 SDK**
2. **IDE**: Visual Studio 2022 (Windows) oder JetBrains Rider / VS Code (plattformübergreifend)
3. **Git** mit Submodule-Unterstützung
4. **CMake** 3.15+
5. **Plattformspezifische Tools** (siehe [INSTALLATION_DE.md](INSTALLATION_DE.md))

### Repository klonen

```bash
git clone --recursive https://github.com/Librelancer/Librelancer.git
cd Librelancer
```

**Wichtig**: Verwenden Sie `--recursive`, um alle Submodules zu klonen.

### Ersten Build ausführen

**Windows**:
```powershell
.\build.ps1
```

**Linux**:
```bash
chmod +x build.sh
./build.sh
```

Dies generiert erforderliche Dateien und baut das Projekt.

## Projektstruktur

```
Librelancer/
├── src/                          # Quellcode
│   ├── LibreLancer/             # Hauptengine
│   ├── LibreLancer.Base/        # Basis-Bibliotheken
│   ├── LibreLancer.Data/        # Daten-Parser
│   ├── LibreLancer.Physics/     # Physik-Engine
│   ├── LibreLancer.Media/       # Audio/Video
│   ├── LibreLancer.Thorn/       # Scripting-Engine
│   ├── Editor/                  # LancerEdit
│   ├── LLServer/                # Server-Implementation
│   ├── Launcher/                # Launcher-Anwendung
│   └── ...
├── docs/                         # Dokumentation
├── extern/                       # Externe Abhängigkeiten
├── scripts/                      # Build-Skripte
├── uixml/                        # UI-Definitionen
├── deps/                         # Dependency-Konfiguration
├── build.ps1                     # Windows Build-Skript
├── build.sh                      # Linux Build-Skript
└── LibreLancer.sln              # Visual Studio Solution

```

### Haupt-Komponenten

- **LibreLancer**: Kern-Engine mit Rendering, Input, Networking
- **LibreLancer.Base**: Grundlegende Utilities, Mathematik, Datenstrukturen
- **LibreLancer.Data**: Parser für Freelancer-Datenformate (INI, UTF, etc.)
- **LibreLancer.Physics**: Jitter-basierte Physik-Engine
- **LibreLancer.Media**: OpenAL-basiertes Audio-System
- **Editor**: LancerEdit - Model-Editor und Tools
- **LLServer**: Multiplayer-Server

## Entwicklungsumgebung einrichten

### Visual Studio 2022 (Windows)

1. **Build-Skript ausführen**:
   ```powershell
   .\build.ps1
   ```

2. **Solution öffnen**:
   ```powershell
   start LibreLancer.sln
   ```

3. **Startup-Projekt setzen**:
   - Rechtsklick auf `Launcher` oder `Editor` im Solution Explorer
   - "Set as Startup Project" wählen

4. **Debugging konfigurieren**:
   - Projekt-Eigenschaften → Debug
   - Arbeitsverzeichnis und Argumente nach Bedarf anpassen

### JetBrains Rider (plattformübergreifend)

1. **Build-Skript ausführen** (wie oben)

2. **Solution in Rider öffnen**:
   - File → Open → `LibreLancer.sln` auswählen

3. **Run Configuration erstellen**:
   - Run → Edit Configurations
   - Add New Configuration → .NET Project
   - Projekt auswählen (z.B. Launcher)

### Visual Studio Code

1. **Build-Skript ausführen**

2. **Erforderliche Extensions installieren**:
   - C# Dev Kit
   - C/C++ Extension Pack (für native Builds)

3. **Ordner öffnen**:
   ```bash
   code .
   ```

4. **Tasks konfigurieren** (`.vscode/tasks.json`):
   ```json
   {
     "version": "2.0.0",
     "tasks": [
       {
         "label": "build",
         "command": "dotnet",
         "type": "process",
         "args": [
           "build",
           "${workspaceFolder}/src/Launcher/Launcher.csproj"
         ],
         "problemMatcher": "$msCompile"
       }
     ]
   }
   ```

## Code-Konventionen

### C# Coding Standards

Librelancer folgt weitgehend den [.NET Coding Conventions](https://learn.microsoft.com/de-de/dotnet/csharp/fundamentals/coding-style/coding-conventions).

#### Benennungskonventionen

```csharp
// PascalCase für Klassen, Methoden, Eigenschaften
public class RenderSystem
{
    public void RenderFrame() { }
    public int FrameCount { get; set; }
}

// camelCase für lokale Variablen und Parameter
public void ProcessData(int itemCount)
{
    var totalItems = itemCount * 2;
}

// PascalCase für Konstanten
public const int MaxPlayers = 128;

// Private Felder mit Unterstrich-Präfix
private int _frameCounter;
```

#### Formatierung

- **Einrückung**: 4 Leerzeichen (keine Tabs)
- **Geschweifte Klammern**: Neue Zeile (Allman-Stil)
  ```csharp
  if (condition)
  {
      DoSomething();
  }
  ```
- **Namespaces**: File-scoped namespaces bevorzugt (C# 10+)
  ```csharp
  namespace LibreLancer.Render;
  
  public class Renderer { }
  ```

#### XML-Dokumentationskommentare

Öffentliche APIs sollten dokumentiert werden:

```csharp
/// <summary>
/// Rendert einen Frame mit den angegebenen Parametern.
/// </summary>
/// <param name="deltaTime">Zeit seit dem letzten Frame in Sekunden</param>
/// <returns>True wenn erfolgreich, sonst false</returns>
public bool RenderFrame(double deltaTime)
{
    // Implementation
}
```

### Editor-Konfiguration

Das Projekt enthält eine `.editorconfig`-Datei mit Code-Style-Regeln. Moderne IDEs wenden diese automatisch an.

## Build-System

### Build-Skripte

Librelancer verwendet Cake (C# Make) als Build-System.

**Build-Targets**:

```bash
# Windows
.\build.ps1 BuildAll        # Alles bauen (Standard)
.\build.ps1 BuildEngine     # Nur Engine
.\build.ps1 BuildSdk        # SDK
.\build.ps1 Test            # Tests ausführen
.\build.ps1 BuildAndTest    # Bauen und Testen
.\build.ps1 Clean           # Build-Artefakte löschen

# Linux
./build.sh BuildAll
./build.sh BuildEngine
./build.sh BuildSdk
./build.sh Test
./build.sh BuildAndTest
./build.sh LinuxDaily       # Daily-Build-Pakete erstellen
```

### Native Abhängigkeiten

Einige Komponenten haben native C/C++-Abhängigkeiten, die mit CMake gebaut werden:

- **cimgui_ext**: ImGui C-Bindings
- **crnlibglue**: Texture-Kompression

Diese werden automatisch vom Build-Skript gebaut.

### Generierte Dateien

Das Build-System generiert automatisch Code:

- **BindingsGen**: Generiert P/Invoke-Bindings
- **LibreLancer.Data.Generator**: Generiert Daten-Parser
- **LibreLancer.Net.Generator**: Generiert Netzwerk-Code

**Wichtig**: Diese Generatoren müssen vor dem Öffnen der Solution ausgeführt werden!

## Testing

### Unit Tests

Tests befinden sich in `src/LibreLancer.Tests/`.

```bash
# Alle Tests ausführen
dotnet test src/LibreLancer.Tests/LibreLancer.Tests.csproj

# Spezifische Tests
dotnet test --filter "FullyQualifiedName~RenderTests"

# Mit Verbosity
dotnet test -v detailed
```

### Test-Struktur

```csharp
using Xunit;

namespace LibreLancer.Tests
{
    public class MyComponentTests
    {
        [Fact]
        public void TestBasicFunctionality()
        {
            // Arrange
            var component = new MyComponent();
            
            // Act
            var result = component.DoSomething();
            
            // Assert
            Assert.True(result);
        }
        
        [Theory]
        [InlineData(1, 2, 3)]
        [InlineData(0, 0, 0)]
        public void TestWithMultipleInputs(int a, int b, int expected)
        {
            var result = Calculator.Add(a, b);
            Assert.Equal(expected, result);
        }
    }
}
```

### Tests schreiben

1. **Testprojekt**: Alle Tests in `LibreLancer.Tests`
2. **Framework**: xUnit
3. **Assertions**: xUnit Assertions
4. **Naming**: Deskriptive Namen, die den Test beschreiben
5. **AAA-Pattern**: Arrange, Act, Assert

## Debugging

### Windows (Visual Studio)

1. **Breakpoints setzen**: Klick auf linken Rand oder F9
2. **Debugging starten**: F5
3. **Step Over**: F10
4. **Step Into**: F11
5. **Continue**: F5

**Nützliche Fenster**:
- **Autos**: Zeigt Variablen im aktuellen Kontext
- **Locals**: Zeigt lokale Variablen
- **Watch**: Benutzerdefinierte Ausdrücke überwachen
- **Call Stack**: Aufruf-Hierarchie

### Native Code Debugging

Für C/C++ native Libraries:

1. **Visual Studio**: Debug → Launcher Properties → Enable native code debugging
2. **Breakpoints**: In C/C++-Dateien setzen
3. **Mixed Debugging**: C# und C++ gleichzeitig debuggen

### Performance-Profiling

**Visual Studio Performance Profiler**:
1. Debug → Performance Profiler
2. Wählen Sie Tools (CPU Usage, Memory Usage, etc.)
3. Starten Sie Profiling-Session

**dotTrace / dotMemory** (JetBrains):
Kommerzielle Tools für detailliertes Profiling.

## Architektur-Übersicht

### Engine-Architektur

Librelancer folgt einem komponentenbasierten Design:

```
┌─────────────────────────────────────────┐
│           Game Loop                      │
│  (Input → Update → Render → Present)    │
└──────────────┬──────────────────────────┘
               │
    ┌──────────┴──────────┐
    │                     │
┌───▼────┐         ┌─────▼─────┐
│ Systems│         │ Components │
└────────┘         └───────────┘
    │                     │
    └──────────┬──────────┘
               │
        ┌──────▼──────┐
        │   Entities   │
        └─────────────┘
```

### Rendering-Pipeline

```
Scene Graph → Frustum Culling → Sorting → Rendering
                                             │
                    ┌────────────────────────┼────────────┐
                    │                        │            │
              ┌─────▼─────┐          ┌──────▼─────┐  ┌──▼────┐
              │  Geometry  │          │  Particles  │  │  UI   │
              └────────────┘          └────────────┘  └───────┘
```

### Daten-Flow

```
Freelancer Files (.ini, .utf, .cmp, etc.)
         │
         ▼
   LibreLancer.Data (Parsing)
         │
         ▼
   Resource Manager (Caching, Loading)
         │
         ▼
   Game Objects (Ships, Stations, etc.)
```

Weitere Details in [ARCHITEKTUR.md](ARCHITEKTUR.md).

## Wichtige Komponenten

### Resource Management

```csharp
// Ressourcen laden
var texture = resourceManager.GetTexture("path/to/texture.dds");
var model = resourceManager.GetDrawable("path/to/model.cmp");

// Ressourcen werden automatisch gecacht
```

### Rendering

```csharp
// Render-Commands
renderContext.Renderer.DrawQuad(texture, position, size);
renderContext.Renderer.DrawModel(model, transform);
```

### Physics

```csharp
// Physics-World
var world = new PhysicsWorld();
var rigidBody = new RigidBody(shape);
world.AddBody(rigidBody);

// Simulation
world.Step(deltaTime);
```

### Scripting (Thorn)

```csharp
// Thorn-Script ausführen
var runtime = new ThornRuntime();
var script = runtime.CompileScript(scriptCode);
script.Run(context);
```

## Continuous Integration

Librelancer verwendet Jenkins für CI/CD. Details in [JENKINS_ANLEITUNG.md](JENKINS_ANLEITUNG.md).

### GitHub Actions (experimentell)

Für Pull Requests werden automatisch Builds ausgeführt.

## Beiträge einreichen

### Workflow

1. **Fork** des Repositories erstellen
2. **Feature Branch** erstellen: `git checkout -b feature/meine-funktion`
3. **Änderungen committen**: `git commit -am 'Füge neue Funktion hinzu'`
4. **Branch pushen**: `git push origin feature/meine-funktion`
5. **Pull Request** erstellen

### Pull Request Guidelines

- **Beschreibung**: Klare Beschreibung der Änderungen
- **Tests**: Fügen Sie Tests für neue Funktionen hinzu
- **Code-Style**: Befolgen Sie die Code-Konventionen
- **Commits**: Sinnvolle, atomare Commits
- **Dokumentation**: Aktualisieren Sie Dokumentation bei API-Änderungen

### Code Review

- PRs werden vom Maintainer-Team überprüft
- Konstruktives Feedback wird gegeben
- Änderungen können angefordert werden
- Nach Approval wird der PR gemergt

Mehr Details in [BEITRAGEN.md](BEITRAGEN.md).

## Hilfreiche Ressourcen

### Dokumentation

- [Librelancer Wiki](https://github.com/Librelancer/Librelancer/wiki)
- [API-Dokumentation](docs/api/)
- [Freelancer Modding Wiki](https://wiki.the-starport.net/)

### Community

- **Discord**: https://discord.gg/QW2vzxx
- **GitHub Discussions**: https://github.com/Librelancer/Librelancer/discussions

### Externe Dokumentation

- [.NET Documentation](https://docs.microsoft.com/de-de/dotnet/)
- [OpenGL Documentation](https://www.opengl.org/documentation/)
- [ImGui](https://github.com/ocornut/imgui)

## Fehlerbehebung

### Häufige Entwickler-Probleme

#### "Generated files not found"

**Lösung**: Build-Skript ausführen:
```bash
.\build.ps1  # Windows
./build.sh   # Linux
```

#### IntelliSense funktioniert nicht

**Lösung**:
1. Visual Studio neu starten
2. Solution schließen und neu öffnen
3. Rebuild Solution

#### Native Library Linking-Fehler

**Lösung**:
```bash
# CMake-Build-Cache löschen
rm -rf extern/build
.\build.ps1  # Neu bauen
```

#### Git Submodule-Probleme

**Lösung**:
```bash
git submodule update --init --recursive
git submodule sync
```

## Nächste Schritte

- Erkunden Sie die [Architektur-Dokumentation](ARCHITEKTUR.md)
- Lesen Sie [Beitragsrichtlinien](BEITRAGEN.md)
- Treten Sie der [Discord-Community](https://discord.gg/QW2vzxx) bei
- Schauen Sie sich [Open Issues](https://github.com/Librelancer/Librelancer/issues) an

Viel Erfolg beim Entwickeln! 🚀

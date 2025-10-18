# Beitragsrichtlinien für Librelancer

Vielen Dank für Ihr Interesse, zu Librelancer beizutragen! Dieses Dokument enthält Richtlinien und Best Practices für Beiträge zum Projekt.

## Inhaltsverzeichnis

- [Code of Conduct](#code-of-conduct)
- [Wie kann ich beitragen?](#wie-kann-ich-beitragen)
- [Entwicklungs-Workflow](#entwicklungs-workflow)
- [Code-Richtlinien](#code-richtlinien)
- [Pull Request-Prozess](#pull-request-prozess)
- [Issue-Richtlinien](#issue-richtlinien)
- [Dokumentations-Beiträge](#dokumentations-beiträge)
- [Community-Richtlinien](#community-richtlinien)

## Code of Conduct

### Unsere Verpflichtung

Wir verpflichten uns, eine offene und einladende Community zu schaffen. Alle Teilnehmer sollen frei von Belästigung sein, unabhängig von:

- Alter, Körpergröße, Behinderung, Ethnizität, Geschlechtsidentität
- Erfahrungsniveau, Nationalität, persönliches Aussehen
- Rasse, Religion oder sexueller Identität und Orientierung

### Erwartetes Verhalten

- Seien Sie respektvoll und inklusiv
- Akzeptieren Sie konstruktive Kritik
- Konzentrieren Sie sich auf das Beste für die Community
- Zeigen Sie Empathie gegenüber anderen Community-Mitgliedern

### Unakzeptables Verhalten

- Trolling, beleidigende Kommentare, persönliche Angriffe
- Öffentliche oder private Belästigung
- Veröffentlichung privater Informationen anderer ohne Erlaubnis
- Anderes Verhalten, das in einem professionellen Umfeld unangemessen wäre

### Durchsetzung

Verstöße können an die Projekt-Maintainer gemeldet werden. Alle Beschwerden werden überprüft und untersucht.

## Wie kann ich beitragen?

### Für alle

#### 1. Bug-Reports

Helfen Sie uns, Librelancer zu verbessern, indem Sie Bugs melden:

1. **Überprüfen Sie bestehende Issues**: Stellen Sie sicher, dass der Bug noch nicht gemeldet wurde
2. **Sammeln Sie Informationen**:
   - Librelancer-Version
   - Betriebssystem und Version
   - Reproduktionsschritte
   - Erwartetes vs. tatsächliches Verhalten
   - Log-Dateien (falls verfügbar)
   - Screenshots/Videos (wenn hilfreich)
3. **Erstellen Sie ein Issue**: https://github.com/Librelancer/Librelancer/issues/new

**Beispiel für einen guten Bug-Report**:
```markdown
**Beschreibung**
Game stürzt ab beim Laden des Manhattan-Systems

**Schritte zur Reproduktion**
1. Neues Spiel starten
2. Tutorial überspringen
3. Zu Manhattan fliegen
4. Crash beim Systemübergang

**Erwartetes Verhalten**
System sollte normal laden

**Tatsächliches Verhalten**
Anwendung stürzt mit Fehlermeldung ab: [Fehlermeldung hier]

**Umgebung**
- OS: Windows 11 22H2
- Librelancer Version: 0.8.1
- GPU: NVIDIA GTX 1060
- Driver Version: 531.18

**Logs**
[Anhang: crash.log]
```

#### 2. Feature-Requests

Schlagen Sie neue Features vor:

1. **Diskutieren Sie zuerst**: Nutzen Sie Discord oder GitHub Discussions
2. **Beschreiben Sie den Use Case**: Warum ist das Feature nützlich?
3. **Skizzieren Sie die Implementation**: Falls Sie technische Ideen haben
4. **Erstellen Sie ein Issue**: Mit Label "enhancement"

#### 3. Testing

- Testen Sie neue Releases
- Verifizieren Sie Bug-Fixes
- Testen Sie verschiedene Konfigurationen
- Testen Sie mit verschiedenen Mods

#### 4. Dokumentation

- Schreiben Sie Tutorials
- Verbessern Sie bestehende Dokumentation
- Korrigieren Sie Tippfehler und Grammatikfehler
- Übersetzen Sie Dokumentation

### Für Entwickler

#### 5. Code-Beiträge

Implementieren Sie Features oder fixen Sie Bugs:

1. Finden Sie ein Issue oder erstellen Sie eines
2. Kommentieren Sie, dass Sie daran arbeiten
3. Forken Sie das Repository
4. Implementieren Sie Ihre Änderungen
5. Testen Sie gründlich
6. Erstellen Sie einen Pull Request

#### 6. Code-Reviews

Helfen Sie bei der Review von Pull Requests:

- Überprüfen Sie Code-Qualität
- Testen Sie die Änderungen
- Geben Sie konstruktives Feedback
- Schlagen Sie Verbesserungen vor

#### 7. Performance-Optimierung

- Identifizieren Sie Performance-Bottlenecks
- Implementieren Sie Optimierungen
- Erstellen Sie Benchmarks
- Dokumentieren Sie Performance-Verbesserungen

## Entwicklungs-Workflow

### 1. Repository forken

```bash
# Forken Sie das Repo auf GitHub, dann:
git clone https://github.com/IHR-USERNAME/Librelancer.git
cd Librelancer
git remote add upstream https://github.com/Librelancer/Librelancer.git
```

### 2. Entwicklungsumgebung einrichten

Siehe [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md) für detaillierte Anweisungen.

```bash
# Windows
.\build.ps1

# Linux
./build.sh
```

### 3. Branch erstellen

```bash
# Holen Sie die neuesten Änderungen
git checkout main
git pull upstream main

# Erstellen Sie einen Feature-Branch
git checkout -b feature/meine-neue-funktion

# Oder für Bugfixes
git checkout -b fix/bug-beschreibung
```

**Branch-Naming-Konventionen**:
- `feature/beschreibung` - Neue Features
- `fix/beschreibung` - Bug-Fixes
- `docs/beschreibung` - Dokumentation
- `refactor/beschreibung` - Code-Refactoring
- `perf/beschreibung` - Performance-Verbesserungen

### 4. Änderungen implementieren

- Schreiben Sie sauberen, lesbaren Code
- Folgen Sie den Code-Richtlinien (siehe unten)
- Committen Sie regelmäßig mit aussagekräftigen Nachrichten
- Schreiben Sie Tests für neue Features

### 5. Tests ausführen

```bash
# Alle Tests ausführen
dotnet test

# Spezifische Tests
dotnet test --filter "FullyQualifiedName~MeinTest"
```

### 6. Code committen

```bash
git add .
git commit -m "feat: Beschreibung der Änderung"
```

**Commit-Message-Konventionen** (Conventional Commits):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: Neue Feature
- `fix`: Bug-Fix
- `docs`: Dokumentation
- `style`: Formatierung (kein Code-Änderung)
- `refactor`: Code-Refactoring
- `perf`: Performance-Verbesserung
- `test`: Tests hinzufügen/korrigieren
- `chore`: Build-Prozess, Tools, etc.

**Beispiele**:
```bash
git commit -m "feat(renderer): Add HDR tone mapping support"
git commit -m "fix(physics): Correct collision detection for large objects"
git commit -m "docs(installation): Update Linux installation instructions"
```

### 7. Push und Pull Request erstellen

```bash
# Push zu Ihrem Fork
git push origin feature/meine-neue-funktion

# Dann auf GitHub: Pull Request erstellen
```

## Code-Richtlinien

### C# Code-Style

Folgen Sie den [.NET Coding Conventions](https://learn.microsoft.com/de-de/dotnet/csharp/fundamentals/coding-style/coding-conventions).

#### Naming

```csharp
// PascalCase für Typen, Methoden, Properties
public class SpaceShip
{
    public void FireWeapon() { }
    public int Health { get; set; }
}

// camelCase für lokale Variablen, Parameter
public void ProcessData(int itemCount)
{
    var processedItems = 0;
}

// Private Felder mit Unterstrich
private int _frameCount;
private readonly IRenderer _renderer;

// Konstanten PascalCase
public const int MaxPlayers = 128;
```

#### Formatierung

```csharp
// Geschweifte Klammern auf neuer Zeile (Allman-Stil)
if (condition)
{
    DoSomething();
}

// Einrückung: 4 Leerzeichen (keine Tabs)
public void Method()
{
    if (condition)
    {
        NestedCall();
    }
}

// File-scoped namespaces (C# 10+)
namespace LibreLancer.Rendering;

public class Renderer { }
```

#### Dokumentation

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

### Best Practices

#### Fehlerbehandlung

```csharp
// DO: Spezifische Exceptions verwenden
if (path == null)
    throw new ArgumentNullException(nameof(path));

// DON'T: Generische Exceptions
// throw new Exception("path is null");

// DO: Exception-Handling nur wo nötig
try
{
    var data = LoadData(path);
}
catch (FileNotFoundException ex)
{
    Logger.Error($"File not found: {path}", ex);
    return null;
}

// DON'T: Leere catch-Blöcke
// try { LoadData(path); } catch { }
```

#### Resource Management

```csharp
// DO: using-Statements für IDisposable
using var stream = File.OpenRead(path);
// Stream wird automatisch disposed

// DO: using-Declarations (C# 8+)
using var texture = LoadTexture(path);
ProcessTexture(texture);
// texture wird am Ende des Scopes disposed
```

#### Performance

```csharp
// DO: Verwenden Sie Span<T> für Zero-Copy
public void ProcessData(ReadOnlySpan<byte> data)
{
    // Kein Array-Allocation
}

// DO: StringBuilder für String-Concatenation
var sb = new StringBuilder();
for (int i = 0; i < 1000; i++)
    sb.Append(i);
var result = sb.ToString();

// DON'T: String-Concatenation in Loops
// var result = "";
// for (int i = 0; i < 1000; i++)
//     result += i; // Sehr langsam!

// DO: ArrayPool für temporäre Arrays
var pool = ArrayPool<byte>.Shared;
var buffer = pool.Rent(size);
try
{
    // Use buffer
}
finally
{
    pool.Return(buffer);
}
```

### Tests schreiben

```csharp
using Xunit;

public class RendererTests
{
    [Fact]
    public void RenderFrame_WithValidData_ReturnsTrue()
    {
        // Arrange
        var renderer = new Renderer();
        var scene = CreateTestScene();
        
        // Act
        var result = renderer.RenderFrame(scene, 0.016);
        
        // Assert
        Assert.True(result);
    }
    
    [Theory]
    [InlineData(0.0)]
    [InlineData(0.016)]
    [InlineData(1.0)]
    public void RenderFrame_WithVariousDeltaTimes_Succeeds(double deltaTime)
    {
        var renderer = new Renderer();
        var result = renderer.RenderFrame(null, deltaTime);
        Assert.True(result);
    }
}
```

## Pull Request-Prozess

### Vor dem Erstellen

1. **Rebase auf main**: Holen Sie die neuesten Änderungen
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Tests ausführen**: Stellen Sie sicher, dass alle Tests bestehen
   ```bash
   dotnet test
   ```

3. **Code-Style prüfen**: Verwenden Sie EditorConfig

4. **Build testen**:
   ```bash
   .\build.ps1 BuildAndTest  # Windows
   ./build.sh BuildAndTest   # Linux
   ```

### PR erstellen

1. **Push zu Ihrem Fork**:
   ```bash
   git push origin feature/meine-funktion
   ```

2. **Auf GitHub**: "New Pull Request" klicken

3. **PR-Beschreibung ausfüllen**:
   ```markdown
   ## Beschreibung
   [Klare Beschreibung der Änderungen]
   
   ## Motivation und Kontext
   [Warum ist diese Änderung notwendig?]
   
   ## Wie wurde getestet?
   - [ ] Unit Tests hinzugefügt
   - [ ] Manuell getestet auf Windows
   - [ ] Manuell getestet auf Linux
   
   ## Screenshots (falls UI-Änderungen)
   [Screenshots hier]
   
   ## Checklist
   - [ ] Code folgt Code-Style-Richtlinien
   - [ ] Self-review durchgeführt
   - [ ] Kommentare hinzugefügt (für komplexe Bereiche)
   - [ ] Dokumentation aktualisiert
   - [ ] Keine neuen Warnings
   - [ ] Tests hinzugefügt und bestehen
   
   ## Related Issues
   Closes #123
   ```

### Review-Prozess

1. **Automatische Checks**: CI/CD-Pipeline läuft automatisch
2. **Code Review**: Maintainer reviewen Ihren Code
3. **Feedback**: Möglicherweise werden Änderungen angefordert
4. **Iterieren**: Nehmen Sie Feedback an und aktualisieren Sie den PR
5. **Approval**: Nach Approval wird der PR gemerged

### Nach dem Merge

1. **Branch löschen**:
   ```bash
   git checkout main
   git pull upstream main
   git branch -d feature/meine-funktion
   git push origin --delete feature/meine-funktion
   ```

2. **Feiern**: Sie haben beigetragen! 🎉

## Issue-Richtlinien

### Bug-Reports

Verwenden Sie die Issue-Template und geben Sie an:

- **Beschreibung**: Was ist das Problem?
- **Reproduktion**: Wie kann man es reproduzieren?
- **Erwartetes Verhalten**: Was sollte passieren?
- **Tatsächliches Verhalten**: Was passiert tatsächlich?
- **Umgebung**: OS, Version, Hardware
- **Logs**: Relevante Log-Dateien

### Feature-Requests

- **Problem**: Welches Problem löst dieses Feature?
- **Vorgeschlagene Lösung**: Wie sollte es funktionieren?
- **Alternativen**: Andere Lösungsansätze?
- **Zusätzlicher Kontext**: Screenshots, Mockups, etc.

### Labels

- `bug`: Etwas funktioniert nicht
- `enhancement`: Neue Feature-Anfrage
- `documentation`: Verbesserungen oder Ergänzungen zur Dokumentation
- `good first issue`: Gut für neue Contributors
- `help wanted`: Zusätzliche Aufmerksamkeit benötigt
- `question`: Weitere Informationen angefordert
- `wontfix`: Wird nicht bearbeitet

## Dokumentations-Beiträge

### Arten von Dokumentation

1. **Code-Dokumentation**: XML-Kommentare in C#-Code
2. **User-Dokumentation**: Markdown-Dateien in `docs/`
3. **API-Dokumentation**: Generiert aus Code-Kommentaren
4. **README**: Projekt-Übersicht und Quick-Start

### Dokumentations-Style

- **Klar und präzise**: Vermeiden Sie Fachjargon wo möglich
- **Strukturiert**: Verwenden Sie Überschriften und Listen
- **Beispiele**: Zeigen Sie praktische Beispiele
- **Screenshots**: Für UI-Dokumentation
- **Aktuell**: Halten Sie Docs synchron mit Code

### Markdown-Konventionen

```markdown
# H1 für Haupt-Titel (nur einer pro Datei)

## H2 für Haupt-Abschnitte

### H3 für Unter-Abschnitte

**Fett** für Hervorhebung
*Kursiv* für Betonung

`Code` für inline Code
```

## Community-Richtlinien

### Discord

- Seien Sie respektvoll und freundlich
- Bleiben Sie on-topic in Channels
- Kein Spam oder Werbung
- Helfen Sie anderen Mitgliedern
- Fragen Sie, bevor Sie große Mengen an Text posten

### GitHub Discussions

- Suchen Sie nach bestehenden Diskussionen
- Verwenden Sie aussagekräftige Titel
- Kategorisieren Sie richtig
- Markieren Sie gelöste Fragen als beantwortet

### Anerkennung

Beiträge werden geschätzt und anerkannt:

- Contributors werden in `Credits.txt` aufgeführt
- Significant contributions werden in Release Notes erwähnt
- Community-Mitglieder können als Maintainer eingeladen werden

## Rechtliches

### Lizenz

Durch Beiträge zum Projekt stimmen Sie zu, dass Ihre Beiträge unter der MIT-Lizenz lizenziert werden.

### Copyright

- Beiträge sollten Ihr eigenes Werk sein
- Keine urheberrechtlich geschützten Assets ohne Erlaubnis
- Keine Closed-Source-Code-Kopien

## Hilfe bekommen

Wenn Sie Fragen haben:

1. **Dokumentation**: Lesen Sie [Entwicklerhandbuch](ENTWICKLERHANDBUCH.md)
2. **Discord**: Fragen Sie in `#development` Channel
3. **GitHub Discussions**: Für längere Diskussionen
4. **Direkt fragen**: Kontaktieren Sie Maintainer

## Danke!

Vielen Dank, dass Sie Librelancer helfen, besser zu werden! Jeder Beitrag, egal wie klein, ist wertvoll für die Community.

Frohes Coding! 🚀

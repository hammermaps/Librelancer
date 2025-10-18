# Architektur-Dokumentation für Librelancer

Diese Dokumentation beschreibt die technische Architektur von Librelancer, einschließlich Design-Entscheidungen, Komponenten-Struktur und Implementierungsdetails.

## Inhaltsverzeichnis

- [Überblick](#überblick)
- [Architektur-Prinzipien](#architektur-prinzipien)
- [Komponenten-Übersicht](#komponenten-übersicht)
- [Rendering-System](#rendering-system)
- [Daten-Management](#daten-management)
- [Physik-Engine](#physik-engine)
- [Audio-System](#audio-system)
- [Networking](#networking)
- [Scripting-Engine](#scripting-engine)
- [Performance-Überlegungen](#performance-überlegungen)

## Überblick

Librelancer ist eine modulare, plattformübergreifende Game Engine, die speziell für die Neuimplementierung von Freelancer entwickelt wurde. Die Architektur folgt modernen Software-Engineering-Prinzipien und nutzt .NET 8 für die Haupt-Engine sowie C/C++ für performance-kritische native Komponenten.

### Technologie-Stack

- **Sprache**: C# (.NET 8) für Haupt-Engine
- **Native Code**: C/C++ für Performance-kritische Teile
- **Grafik-API**: OpenGL 3.1+ (mit Shader Model 4.0+)
- **Physik**: Jitter Physics Engine (modifiziert)
- **Audio**: OpenAL-Soft
- **UI**: ImGui (via cimgui)
- **Windowing**: SDL2/SDL3
- **Build-System**: MSBuild + CMake

### Plattform-Unterstützung

- **Windows**: x64, native Unterstützung
- **Linux**: x64, ARM64
- **macOS**: Wartet auf Maintainer (theoretisch unterstützt)

## Architektur-Prinzipien

### Modularität

Die Engine ist in klar getrennte Module organisiert, wobei jedes Modul eine spezifische Verantwortung hat:

```
┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│ LibreLancer │  │   Editor    │  │   Server    │
│   (Game)    │  │ (LancerEdit)│  │ (LLServer)  │
└──────┬──────┘  └──────┬──────┘  └──────┬──────┘
       │                │                │
       └────────────────┴────────────────┘
                        │
        ┌───────────────┴───────────────┐
        │                               │
┌───────▼────────┐            ┌─────────▼─────────┐
│ LibreLancer    │            │ LibreLancer.Data  │
│   .Base        │            │   (Data Parsing)  │
└───────┬────────┘            └──────────┬────────┘
        │                                │
┌───────▼────────┐            ┌──────────▼────────┐
│ LibreLancer    │            │ LibreLancer.Media │
│   .Physics     │            │   (Audio/Video)   │
└────────────────┘            └───────────────────┘
```

### Trennung von Concerns

- **Präsentation**: Rendering und UI (LibreLancer, Editor)
- **Geschäftslogik**: Spielmechanik, Simulation (LibreLancer, LLServer)
- **Daten**: Parsing und Ressourcen-Management (LibreLancer.Data)
- **Infrastruktur**: Low-Level-Utilities (LibreLancer.Base)

### Performance-First-Design

- Null-Allocation-Pfade für Hot Paths
- Object Pooling für häufig erstellte Objekte
- Struktur-basierte APIs wo möglich
- SIMD-Operationen für Mathematik (via System.Numerics)

### Plattform-Abstraktion

Plattformspezifischer Code wird durch Abstraktions-Schichten isoliert:

```csharp
// Abstrakte Interface
public interface IPlatform
{
    string GetSaveDirectory();
    void ShowMessageBox(string message);
}

// Windows-Implementation
class WindowsPlatform : IPlatform { }

// Linux-Implementation  
class LinuxPlatform : IPlatform { }
```

## Komponenten-Übersicht

### LibreLancer (Kern-Engine)

Die Haupt-Game-Engine enthält:

- **Game Loop**: Update/Render-Zyklen
- **State Management**: Spielzustände (Menu, Flight, etc.)
- **Input Handling**: Tastatur, Maus, Gamepad
- **Resource Loading**: Asset-Management
- **Rendering**: OpenGL-Wrapper und Rendering-Pipeline
- **UI System**: ImGui-Integration

**Wichtige Klassen**:
- `Game`: Haupt-Game-Klasse, Entry Point
- `GameState`: Basis-Klasse für Spielzustände
- `ResourceManager`: Lädt und cached Assets
- `RenderContext`: Rendering-Kontext und -State

### LibreLancer.Base

Grundlegende Utilities und Datenstrukturen:

- **Math**: Vektoren, Matrizen, Quaternions (erweitert System.Numerics)
- **Collections**: Spezialisierte Datenstrukturen
- **Platform**: Plattform-Abstraktionen
- **Utilities**: Allgemeine Helper-Funktionen

**Wichtige Typen**:
- `Vector3`, `Vector4`: 3D/4D-Vektoren
- `Matrix4x4`: Transformations-Matrizen
- `BoundingBox`, `BoundingSphere`: Collision-Primitives
- `ObjectPool<T>`: Generic Object Pooling

### LibreLancer.Data

Parser für alle Freelancer-Datenformate:

- **INI Files**: Konfiguration und Gameplay-Daten
- **UTF Files**: Universal Tree Format (Models, Textures, etc.)
- **CMP Files**: Compound Models
- **MAT Files**: Material-Definitionen
- **ALE Files**: Effects
- **THN Files**: Cutscenes

**Architektur**:
```csharp
// INI-Parsing mit reflexionsbasiertem Mapping
[Section("Ship")]
public class ShipIni
{
    [Entry("nickname")]
    public string Nickname;
    
    [Entry("mass")]
    public float Mass;
}

var ships = IniParser.Parse<ShipIni>("ships.ini");
```

**Performance-Optimierungen**:
- Lazy Loading: Daten werden erst bei Bedarf geladen
- Caching: Geparste Daten werden gecacht
- Memory-Mapped Files: Für große Dateien

### LibreLancer.Physics

Physik-Simulation basierend auf Jitter Physics:

- **Rigid Body Dynamics**: Bewegung von starren Körpern
- **Collision Detection**: Broad-Phase und Narrow-Phase
- **Constraints**: Joints, Motors, etc.
- **Raycasting**: Strahl-Kollision-Tests

**Integration**:
```csharp
// Physics World erstellen
var world = new PhysicsWorld();

// Rigid Body hinzufügen
var shape = new BoxShape(1, 1, 1);
var body = new RigidBody(shape);
body.Position = new Vector3(0, 10, 0);
world.AddBody(body);

// Simulieren
world.Step(deltaTime);
```

### LibreLancer.Media

Audio-System basierend auf OpenAL:

- **Sound Playback**: 2D und 3D-Audio
- **Streaming**: Für Musik und große Audio-Dateien
- **Effekte**: Reverb, Doppler, etc.
- **Music System**: Background-Music-Management

**Architektur**:
```csharp
// Audio Manager
var audioManager = new AudioManager();

// Sound laden und abspielen
var sound = audioManager.LoadSound("explosion.wav");
var instance = sound.CreateInstance();
instance.Position = explosionPosition;
instance.Play();

// Musik abspielen
var musicPlayer = new MusicPlayer(audioManager);
musicPlayer.Play("music/combat.mp3");
```

### LibreLancer.Thorn

Scripting-Engine für Cutscenes und Events:

- **Bytecode VM**: Eigene Virtual Machine
- **Compiler**: Thorn-Script zu Bytecode
- **Runtime**: Ausführung von Scripts
- **Interop**: C#-Objekte in Scripts nutzen

**Script-Beispiel**:
```thorn
// Thorn Script
entity player = GetPlayer()
entity ship = GetShip(player)
ship.SetPosition(0, 0, 0)
PlayEffect("warp_in", ship.Position)
```

## Rendering-System

### Rendering-Pipeline

```
┌─────────────────────────────────────────────────┐
│              Scene Graph Update                  │
│  (Transform Hierarchy, Animations, LOD)         │
└───────────────────┬─────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│           Frustum Culling                        │
│  (Octree/BVH for spatial partitioning)          │
└───────────────────┬─────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│           Render Queue Building                  │
│  (Sort by: Shader → Material → Mesh)            │
└───────────────────┬─────────────────────────────┘
                    │
        ┌───────────┴───────────┐
        │                       │
┌───────▼──────┐        ┌───────▼────────┐
│ Opaque Pass  │        │ Transparent    │
│ (Z-Test ON)  │        │ Pass (Sorted)  │
└───────┬──────┘        └───────┬────────┘
        │                       │
        └───────────┬───────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│              Post-Processing                     │
│  (Bloom, Tone Mapping, Color Grading)           │
└───────────────────┬─────────────────────────────┘
                    │
┌───────────────────▼─────────────────────────────┐
│                UI Rendering                      │
│              (ImGui, HUD)                        │
└───────────────────┬─────────────────────────────┘
                    │
                 Present
```

### Shader-System

Librelancer nutzt ein modernes Shader-System:

- **SPIR-V**: Shader werden als SPIR-V-Bytecode gespeichert
- **HLSL Source**: Geschrieben in HLSL, kompiliert mit DXC
- **Runtime Compilation**: Fallback für Plattformen ohne SPIR-V
- **Shader Variants**: Automatische Generierung von Varianten

**Shader-Pipeline**:
```
HLSL Source (.hlsl)
      │
      ▼
DXC Compiler (build time)
      │
      ▼
SPIR-V Bytecode (.spv)
      │
      ▼
Runtime: Load + Specialize
      │
      ▼
OpenGL Shader Program
```

### Material-System

```csharp
public class Material
{
    public string Name { get; set; }
    public Texture2D DiffuseTexture { get; set; }
    public Texture2D NormalMap { get; set; }
    public Vector4 DiffuseColor { get; set; }
    public float Metallic { get; set; }
    public float Roughness { get; set; }
    public BlendMode BlendMode { get; set; }
}
```

**Material-Batching**:
Objekte mit demselben Material werden zusammengefasst, um Draw Calls zu reduzieren.

### Textur-Management

- **Kompression**: DDS (DXT1/3/5), CRN (Crunch)
- **Mipmapping**: Automatische Generierung
- **Streaming**: Asynchrones Laden großer Texturen
- **Atlasing**: Kombinieren kleiner Texturen

## Daten-Management

### Resource Manager

Zentrales Asset-Management-System:

```csharp
public class ResourceManager
{
    // Cache für geladene Ressourcen
    private Dictionary<string, object> resourceCache;
    
    public T GetResource<T>(string path) where T : class
    {
        // Check cache
        if (resourceCache.TryGetValue(path, out var cached))
            return cached as T;
            
        // Load from disk
        var resource = LoadResource<T>(path);
        resourceCache[path] = resource;
        return resource;
    }
    
    // Spezifische Loader
    public Texture2D GetTexture(string path);
    public ModelResource GetModel(string path);
    public SoundData GetSound(string path);
}
```

### Virtuelle Dateisysteme

Librelancer nutzt ein VFS-System für Modding-Unterstützung:

```
┌─────────────────────────────────────┐
│        Virtual File System          │
└────────┬────────────────────────────┘
         │
    ┌────┴────┬────────┬──────────┐
    │         │        │          │
┌───▼───┐ ┌──▼──┐ ┌───▼────┐ ┌──▼──┐
│ Base  │ │ Mod │ │ Mod 2  │ │ ... │
│ Game  │ │ 1   │ │        │ │     │
└───────┘ └─────┘ └────────┘ └─────┘
```

Mods können Dateien aus dem Basis-Spiel überschreiben.

## Physik-Engine

### Jitter Integration

Librelancer nutzt eine modifizierte Version von Jitter Physics:

**Modifikationen**:
- .NET Standard Kompatibilität
- SIMD-Optimierungen via System.Numerics
- Reduced Allocations
- Custom Collision Shapes

### Collision Detection

**Broad Phase**: Sweep and Prune (SAP)
```
Sort objects by AABB bounds
Check overlapping intervals
Generate potential collision pairs
```

**Narrow Phase**: GJK/EPA
```
For each collision pair:
  Run GJK to find if shapes intersect
  If intersect, use EPA to find penetration depth
  Generate contact manifold
```

### Integration mit Game Objects

```csharp
public class Ship : GameObject
{
    public RigidBody PhysicsBody { get; private set; }
    
    public override void Update(double deltaTime)
    {
        // Sync physics to rendering
        Transform.Position = PhysicsBody.Position;
        Transform.Rotation = PhysicsBody.Orientation;
    }
    
    public void ApplyThrust(Vector3 direction, float power)
    {
        var force = direction * power;
        PhysicsBody.AddForce(force);
    }
}
```

## Audio-System

### OpenAL-Architektur

```
┌─────────────────────────────────────┐
│         Audio Manager               │
└────────┬────────────────────────────┘
         │
    ┌────┴──────┬──────────┐
    │           │          │
┌───▼────┐  ┌──▼────┐  ┌──▼─────┐
│ Music  │  │ Sound │  │ Voice  │
│ Player │  │ FX    │  │ (3D)   │
└────────┘  └───────┘  └────────┘
    │           │          │
    └────────┬──┴──────────┘
             │
        ┌────▼────┐
        │ OpenAL  │
        │ Context │
        └─────────┘
```

### 3D-Audio

```csharp
// Listener (Player/Camera)
audioManager.SetListenerPosition(camera.Position);
audioManager.SetListenerOrientation(camera.Forward, camera.Up);
audioManager.SetListenerVelocity(player.Velocity);

// Sound Source
var engine = ship.EngineSound;
engine.Position = ship.Position;
engine.Velocity = ship.Velocity; // Für Doppler-Effekt
engine.ReferenceDistance = 10.0f;
engine.MaxDistance = 1000.0f;
```

### Audio Streaming

Für Musik und große Audio-Dateien:

```csharp
public class StreamingSource
{
    private const int BufferCount = 3;
    private const int BufferSize = 4096;
    
    public void Stream()
    {
        // Fill initial buffers
        for (int i = 0; i < BufferCount; i++)
            QueueBuffer();
        
        // Play
        AL.SourcePlay(sourceId);
    }
    
    public void Update()
    {
        // Check for processed buffers
        AL.GetSource(sourceId, ALGetSourcei.BuffersProcessed, out int processed);
        
        // Refill processed buffers
        while (processed-- > 0)
        {
            int buffer = AL.SourceUnqueueBuffer(sourceId);
            FillBuffer(buffer);
            AL.SourceQueueBuffer(sourceId, buffer);
        }
    }
}
```

## Networking

### Client-Server-Architektur

```
┌──────────┐         ┌──────────┐
│  Client  │ ◄─────► │  Server  │
│ (Player) │  UDP/   │(LLServer)│
└──────────┘  TCP    └──────────┘
                            │
                     ┌──────┴──────┐
                     │             │
              ┌──────▼──┐    ┌─────▼────┐
              │ Client  │    │  Client  │
              └─────────┘    └──────────┘
```

### Netzwerk-Protokoll

- **TCP**: Zuverlässige Kommunikation (Chat, Transaktionen)
- **UDP**: Unreliable, niedrige Latenz (Position-Updates, Physik)
- **Serialization**: Binäres Protokoll, Code-generiert

**Packet-Struktur**:
```csharp
public class NetworkPacket
{
    public PacketType Type { get; set; }
    public uint SequenceNumber { get; set; }
    public byte[] Payload { get; set; }
}
```

### State Synchronization

**Client-Side Prediction**:
```csharp
// Client führt Input sofort aus
ship.ApplyInput(input);
clientState.PredictedPosition = ship.Position;

// Server-Authoritative Update empfangen
OnServerUpdate(serverState)
{
    // Reconcile with server state
    if (Distance(clientState, serverState) > threshold)
        ship.Position = serverState.Position; // Snap
    else
        ship.Position = Lerp(ship.Position, serverState.Position, 0.1f); // Smooth
}
```

## Scripting-Engine

### Thorn Virtual Machine

**Bytecode-Instructions**:
```
LOAD_CONST <index>     # Lade Konstante auf Stack
LOAD_VAR <name>        # Lade Variable auf Stack
STORE_VAR <name>       # Speichere Top-of-Stack in Variable
CALL <function>        # Rufe Funktion auf
JUMP <offset>          # Unbedingter Sprung
JUMP_IF_FALSE <offset> # Bedingter Sprung
RETURN                 # Rückkehr aus Funktion
```

**Execution**:
```csharp
public class ThornVM
{
    private Stack<object> stack;
    private Dictionary<string, object> variables;
    private Instruction[] instructions;
    private int pc; // Program Counter
    
    public void Execute()
    {
        while (pc < instructions.Length)
        {
            var inst = instructions[pc++];
            switch (inst.OpCode)
            {
                case OpCode.LOAD_CONST:
                    stack.Push(constants[inst.Operand]);
                    break;
                case OpCode.CALL:
                    ExecuteCall(inst.Operand);
                    break;
                // ...
            }
        }
    }
}
```

## Performance-Überlegungen

### Memory Management

- **Object Pooling**: Für häufig erstellte/zerstörte Objekte
- **Struct statt Class**: Wo möglich, um Heap-Allocations zu vermeiden
- **ArrayPool**: Für temporäre Arrays
- **Span<T>**: Für Zero-Copy-Operations

### CPU-Optimierung

- **SIMD**: System.Numerics für vektorisierte Operationen
- **Parallelisierung**: Task Parallel Library für Multi-Threading
- **Cache-Friendly**: Data-Oriented Design wo möglich

### GPU-Optimierung

- **Instancing**: Für viele identische Objekte
- **Frustum Culling**: Reduziert Draw Calls
- **Level-of-Detail**: Verschiedene Model-Komplexitäten basierend auf Entfernung
- **Occlusion Culling**: (Geplant) Verdeckte Objekte nicht rendern

### Profiling

```csharp
// Built-in Performance Counter
using (Profiler.Begin("RenderScene"))
{
    RenderScene();
}

// Ergebnisse in Profiler-Fenster anzeigen
```

## Zusammenfassung

Die Librelancer-Architektur ist darauf ausgelegt, eine moderne, wartbare und erweiterbare Game Engine zu sein, die das klassische Freelancer-Erlebnis bewahrt, während sie auf aktuelle Best Practices und Technologien setzt.

**Kernprinzipien**:
- Modularität und klare Trennung von Concerns
- Performance durch intelligentes Design
- Plattform-Unabhängigkeit durch Abstraktion
- Erweiterbarkeit durch Scripting und Modding

Weitere technische Details finden Sie in den Quellcode-Kommentaren und der API-Dokumentation.

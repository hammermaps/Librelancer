# Quick Optimization Guide - Librelancer

## 🎯 Top 10 Sofortige Optimierungen / Top 10 Immediate Optimizations

### 1. Object Pooling für Projektile
**Datei:** `src/LibreLancer/World/ProjectileManager.cs`
**Problem:** Häufige Allokation/Deallokation
**Lösung:** Implementiere Projektil-Pool
**Erwarteter Gewinn:** 15-20% Performance in Kämpfen

### 2. Frustum Culling
**Datei:** `src/LibreLancer/Render/SystemRenderer.cs`
**Problem:** Alle Objekte werden gerendert
**Lösung:** Culling außerhalb des Sichtbereichs
**Erwarteter Gewinn:** 20-40% Rendering-Performance

### 3. Async Asset Loading
**Dateien:** `src/LibreLancer/Resources/ResourceManager.cs`
**Status:** Teilweise vorhanden, erweitern
**Lösung:** Mehr Ressourcen asynchron laden
**Erwarteter Gewinn:** Schnellere Ladezeiten

### 4. Multi-Threading für Physik
**Datei:** `src/LibreLancer.Physics/PhysicsWorld.cs`
**Problem:** Physik im Hauptthread
**Lösung:** Parallel.ForEach für Objekt-Updates
**Erwarteter Gewinn:** 25-35% CPU-Auslastung

### 5. LOD für entfernte Schiffe
**Dateien:** `src/LibreLancer/Render/ModelRenderer.cs`
**Problem:** Volle Details auch in der Ferne
**Lösung:** Level-of-Detail-System
**Erwarteter Gewinn:** 15-30% GPU-Last

### 6. Spatial Hash statt Linear Search
**Datei:** `src/LibreLancer/World/SpatialLookup.cs`
**Problem:** Einfache Implementierung
**Lösung:** Octree oder besseres Grid
**Erwarteter Gewinn:** 20-40% bei vielen Objekten

### 7. String-Allocations reduzieren
**Überall:** Häufige String-Operationen
**Problem:** Garbage Collection Pressure
**Lösung:** Span<char>, StringBuilder, Interning
**Erwarteter Gewinn:** 5-10% Memory, weniger GC-Pauses

### 8. Shader-Kompilierung optimieren
**Datei:** `src/LibreLancer.Base/Graphics/Shader.cs`
**Problem:** Runtime-Kompilierung
**Lösung:** Pre-kompilierte Shader + Cache
**Erwarteter Gewinn:** Weniger Stottern

### 9. Texture Atlas für UI
**Dateien:** `src/LibreLancer/Interface/`
**Problem:** Viele einzelne Textur-Binds
**Lösung:** UI-Elemente in Atlas
**Erwarteter Gewinn:** 10-20% UI-Rendering

### 10. Network Delta Compression
**Datei:** `src/LibreLancer/Net/GameNetClient.cs`
**Problem:** Volle Updates jedes Mal
**Lösung:** Nur Änderungen senden
**Erwarteter Gewinn:** 40-60% Bandwidth

---

## 🐛 Kritische TODOs (aus 106+ TODOs)

### Gameplay-kritisch
- [ ] `ShipPhysicsComponent.cs` - Engine Kill-Funktion
- [ ] `ScriptedAction_Spawn.cs` - Formation-Spawning implementieren
- [ ] `WeaponComponent.cs` - Barrel Construct richtig finden
- [ ] `ShipPhysicsComponent.cs` - Cruise während Strafe beenden

### Rendering-kritisch
- [ ] `ThnCamera.cs` - Clip Plane justieren
- [ ] `MaterialMap.cs` - Instance statt globaler Map

### Netzwerk-kritisch
- [ ] Client-Side Prediction implementieren
- [ ] Interest Management für Updates

### Daten-kritisch
- [ ] `BodypartsIni.cs` - Animations, DetailSwitchTable, PetalAnimations, Skeleton

---

## 📊 Code-Hotspots (Refactoring-Kandidaten)

### Zu große Dateien
1. **ServerWorld.cs** - 37,839 Zeilen → In Module aufteilen
2. **SpaceGameplay.cs** - 64,419 Zeilen → State-Pattern verwenden
3. **GameObject.cs** - 24,637 Zeilen → Component-System verbessern
4. **Player.cs** - 22,105 Zeilen → Logik extrahieren
5. **NetCharacter.cs** - 22,105 Zeilen → Services extrahieren

### Performance-kritische Loops
```csharp
// VORHER (in GameWorld.cs):
foreach (var obj in allObjects)
{
    obj.Update(deltaTime);
}

// NACHHER:
Parallel.ForEach(allObjects, obj => 
{
    obj.Update(deltaTime);
});
```

---

## 🚀 Quick Wins (< 1 Tag Arbeit)

### 1. Enable Span<T> in INI-Parser
```csharp
// src/LibreLancer.Data/Ini/
// Statt: string.Split() -> Span<char> verwenden
ReadOnlySpan<char> line = ...;
var parts = line.Split(',');
```

### 2. Cache häufig verwendete Strings
```csharp
// src/LibreLancer/GameData/
private static readonly string[] CommonStrings = 
{
    "li_fighter", "li_elite", "ge_fighter", // ...
};
```

### 3. Disable Logging in Release
```csharp
// src/LibreLancer.Base/FLLog.cs
[Conditional("DEBUG")]
public static void Debug(string category, string message)
```

### 4. Use StackAlloc für kleine Arrays
```csharp
// Statt: var buffer = new byte[256];
Span<byte> buffer = stackalloc byte[256];
```

### 5. Object Pooling für Particles
```csharp
// src/LibreLancer/Fx/
private static ObjectPool<Particle> particlePool = new(1000);
```

---

## 🎮 Gameplay-Features Quick Start

### 1. Einfacher Auto-Pilot (2-3 Stunden)
```csharp
// In ShipPhysicsComponent.cs hinzufügen:
public void SetAutoPilotTarget(Vector3 target)
{
    isAutoPilot = true;
    autoPilotTarget = target;
}

public void UpdateAutoPilot(float delta)
{
    if (!isAutoPilot) return;
    
    var direction = Vector3.Normalize(autoPilotTarget - Position);
    var distance = Vector3.Distance(Position, autoPilotTarget);
    
    if (distance < 10f)
    {
        isAutoPilot = false;
        return;
    }
    
    // Steuere zum Ziel
    SteerToward(direction);
}
```

### 2. Dynamische Preise (4-5 Stunden)
```csharp
// Neue Datei: src/LibreLancer/GameData/DynamicPricing.cs
public class DynamicPricing
{
    private Dictionary<(string commodity, string base), float> priceModifiers = new();
    
    public float GetPrice(Good good, Base station)
    {
        var key = (good.Nickname, station.Nickname);
        var modifier = priceModifiers.GetValueOrDefault(key, 1.0f);
        return good.Price * modifier;
    }
    
    public void UpdatePrices(float deltaTime)
    {
        // Einfache Schwankungen
        foreach (var key in priceModifiers.Keys.ToList())
        {
            var variance = (float)(random.NextDouble() - 0.5) * 0.02f;
            priceModifiers[key] = Math.Clamp(
                priceModifiers[key] + variance, 
                0.8f, 1.2f
            );
        }
    }
}
```

### 3. Mission-Generator (1 Tag)
```csharp
// Neue Datei: src/LibreLancer/Missions/SimpleMissionGenerator.cs
public class SimpleMissionGenerator
{
    private Random rng = new();
    
    public Mission GenerateTrading(Player player)
    {
        var systems = gameData.Systems.ToList();
        var fromSystem = systems[rng.Next(systems.Count)];
        var toSystem = systems[rng.Next(systems.Count)];
        
        return new Mission
        {
            Type = MissionType.Trading,
            Title = $"Deliver goods to {toSystem.Name}",
            Reward = CalculateReward(fromSystem, toSystem),
            // ...
        };
    }
}
```

---

## 🔍 Profiling-Setup (15 Minuten)

### 1. BenchmarkDotNet hinzufügen
```xml
<!-- src/LibreLancer.Tests/LibreLancer.Tests.csproj -->
<ItemGroup>
  <PackageReference Include="BenchmarkDotNet" Version="0.13.10" />
</ItemGroup>
```

### 2. Einfacher Benchmark
```csharp
// src/LibreLancer.Tests/Benchmarks/RenderingBenchmarks.cs
[MemoryDiagnoser]
public class RenderingBenchmarks
{
    private SystemRenderer renderer;
    
    [Benchmark]
    public void RenderFrame()
    {
        renderer.Draw();
    }
}
```

### 3. Runtime-Profiler
```csharp
// src/LibreLancer/FreelancerGame.cs - Update-Methode
#if DEBUG
using (var _ = Profiler.Begin("Update"))
{
    currentState.Update(delta);
}
#endif
```

---

## 📈 Messbare Ziele

### Performance
- [ ] 60 FPS konstant mit 100+ NPCs
- [ ] < 3 Sekunden Ladezeit für Systeme
- [ ] < 50ms Frame-Time Spikes
- [ ] < 100 MB/s Netzwerk-Traffic

### Code-Qualität
- [ ] 0 kritische Warnungen
- [ ] > 50% Test-Abdeckung
- [ ] < 10 offene kritische TODOs
- [ ] Alle Dateien < 1000 Zeilen

### Gameplay
- [ ] Auto-Pilot funktioniert
- [ ] Dynamische Preise aktiv
- [ ] 10+ procedural Mission-Typen
- [ ] Reputation beeinflusst Gameplay

---

## 🛠️ Empfohlene Tools

### Development
- **JetBrains Rider** oder **Visual Studio 2022** - IDE
- **dotTrace** - Profiling
- **dotMemory** - Memory-Analyse
- **ReSharper** - Code-Analyse

### Testing
- **BenchmarkDotNet** - Performance-Tests
- **NUnit** oder **xUnit** - Unit-Tests
- **Moq** - Mocking

### Debugging
- **RenderDoc** - Graphics Debugging
- **Wireshark** - Netzwerk-Analyse
- **PerfView** - .NET Performance

---

## 📝 Nächste Schritte

1. **Woche 1:** Object Pooling + Frustum Culling implementieren
2. **Woche 2:** Multi-Threading für Physik
3. **Woche 3:** LOD-System + Spatial Partitioning
4. **Woche 4:** Network-Optimierungen

**Danach:** Siehe vollständiges `CODE_ANALYSIS_OPTIMIZATIONS.md` für Langzeit-Plan.

---

**Letzte Aktualisierung:** 2025-10-18

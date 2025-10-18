# CI/CD Overview - Librelancer

This document provides an overview of the continuous integration and continuous deployment (CI/CD) options available for the Librelancer project.

## Available CI/CD Systems

### 1. GitHub Actions (Current)
- **Status**: Active and configured
- **Configuration**: `.github/workflows/`
- **Workflows**:
  - `dev-builds.yml` - Automated builds on push to main
  - `pr-check.yml` - Pull request validation
- **Platforms**: Linux (with Windows cross-compilation)
- **Artifacts**: Daily builds for Ubuntu and Windows

### 2. Jenkins (New)
- **Status**: Configuration files provided
- **Configuration**: `Jenkinsfile` and `Jenkinsfile.simple`
- **Documentation**: 
  - German: `docs/JENKINS_ANLEITUNG.md` (detailed guide)
  - German: `docs/JENKINS_SCHNELLSTART.md` (quick start)
- **Platforms**: Parallel builds on Linux and Windows
- **Features**:
  - Multi-platform parallel builds
  - Automated testing
  - Artifact archiving
  - Branch-specific pipelines

### 3. AppVeyor (Legacy)
- **Status**: Configuration exists
- **Configuration**: `appveyor.yml`
- **Note**: May be deprecated in favor of GitHub Actions

## Jenkins Configuration

The project includes two Jenkinsfile variants:

### Standard Jenkinsfile
**File**: `Jenkinsfile`

**Features**:
- Parallel builds for Linux and Windows
- Separate build agents with labels ('linux', 'windows')
- Automated dependency installation
- Test execution on both platforms
- Daily package creation for main branch
- Cross-compilation support (Windows on Linux)

**Recommended for**: Production environments with dedicated build agents

**Stages**:
1. **Build and Test** (Parallel)
   - Linux Build: Full build and test on Linux
   - Windows Build: Full build and test on Windows
2. **Package Daily Builds**: Creates distribution packages (main branch only)

### Simple Jenkinsfile
**File**: `Jenkinsfile.simple`

**Features**:
- Single-agent builds
- Platform detection (runs on either Linux or Windows)
- Basic build and test workflow
- Simpler configuration

**Recommended for**: Testing, development, or environments with limited resources

**Stages**:
1. Checkout
2. Build
3. Test

## Build Targets

The project uses a custom build system through `BuildLL.csproj`. Available targets:

| Target | Description | Use Case |
|--------|-------------|----------|
| `BuildAll` | Build engine and SDK | Default build |
| `BuildEngine` | Build only the game engine | Minimal build |
| `BuildSdk` | Build complete SDK with tools | Development build |
| `Test` | Run unit tests | Testing |
| `BuildAndTest` | Build everything and run tests | CI validation |
| `LinuxDaily` | Create daily build packages | Release automation |

### Usage Examples

**Linux**:
```bash
./build.sh BuildAll
./build.sh BuildAndTest
./build.sh -j$(nproc) LinuxDaily --with-win64
```

**Windows**:
```powershell
.\build.ps1 BuildAll
.\build.ps1 BuildAndTest
```

## Requirements by Platform

### Linux Build Agent
- .NET 8.0 SDK
- CMake 3.15+
- gcc, g++
- GTK3 development headers
- SDL2
- OpenAL-Soft
- Git

Optional for cross-compilation:
- g++-mingw-w64-x86-64 (for Windows builds on Linux)

### Windows Build Agent
- .NET 8.0 SDK
- Visual Studio 2022 with Desktop C++ Development
- CMake 3.15+
- Git
- PowerShell 5.0+

## Setting Up Jenkins

### Quick Start (5 minutes)
1. Install Jenkins with Java 11+
2. Install Git and Pipeline plugins
3. Create a new Pipeline project
4. Configure SCM to point to this repository
5. Set Script Path to `Jenkinsfile.simple` or `Jenkinsfile`
6. Build!

For detailed instructions, see:
- **German**: [docs/JENKINS_SCHNELLSTART.md](JENKINS_SCHNELLSTART.md)
- **English**: Use `Jenkinsfile.simple` as template

### Production Setup
For production environments with multiple build agents:
1. Set up Jenkins master server
2. Configure Linux build agent with label 'linux'
3. Configure Windows build agent with label 'windows'
4. Install all required dependencies on each agent
5. Use the standard `Jenkinsfile`
6. Configure webhooks for automated builds

For detailed instructions, see:
- **German**: [docs/JENKINS_ANLEITUNG.md](JENKINS_ANLEITUNG.md)

## CI/CD Comparison

| Feature | GitHub Actions | Jenkins | AppVeyor |
|---------|---------------|---------|----------|
| Configuration | YAML workflows | Jenkinsfile (Groovy) | YAML |
| Hosted Option | Yes (free for public repos) | Self-hosted only | Yes |
| Parallel Builds | Yes | Yes | Limited |
| Windows Support | Via cross-compilation | Native | Native |
| Linux Support | Native | Native | Ubuntu only |
| Artifact Storage | GitHub | Custom | Built-in |
| Customization | Limited | Extensive | Moderate |
| Setup Complexity | Low | Medium-High | Low |

## Recommendations

### For Open Source Projects
- **Primary**: GitHub Actions (already configured)
- **Secondary**: Jenkins for additional testing

### For Enterprise/Private
- **Primary**: Jenkins with dedicated build agents
- **Advantage**: Full control over build environment
- **Advantage**: Support for private networks

### For Quick Testing
- **Use**: `Jenkinsfile.simple`
- **Deploy**: Single build agent (Linux or Windows)

## Migration Paths

### From AppVeyor to Jenkins
1. Keep existing `appveyor.yml` for reference
2. Set up Jenkins using `Jenkinsfile`
3. Validate builds match AppVeyor output
4. Transition webhooks from AppVeyor to Jenkins

### From GitHub Actions to Jenkins
1. GitHub Actions can remain active
2. Add Jenkins for additional coverage
3. Use Jenkins for internal/private builds
4. Keep GitHub Actions for public PR validation

## Troubleshooting

### Common Issues

**Submodules not cloning**:
- Ensure Git submodule options are enabled in SCM configuration
- Check SSH keys or credentials for private submodules

**.NET SDK not found**:
- Verify SDK installation: `dotnet --version`
- Check PATH environment variable
- Linux: May need to add to PATH manually

**Native build failures**:
- Linux: Install all required development libraries
- Windows: Verify Visual Studio C++ tools are installed
- Check CMake installation and version

**Permission denied on build scripts**:
- Linux: `chmod +x build.sh`
- Usually happens if workspace was copied

For more troubleshooting, see:
- Jenkins: [docs/JENKINS_ANLEITUNG.md](JENKINS_ANLEITUNG.md#fehlerbehebung)

## Additional Resources

- Librelancer Website: https://librelancer.net
- GitHub Repository: https://github.com/Librelancer/Librelancer
- Discord Community: https://discord.gg/QW2vzxx
- Jenkins Documentation: https://www.jenkins.io/doc/

## Contributing

To improve CI/CD configurations:
1. Test changes thoroughly on both platforms
2. Update relevant documentation
3. Submit pull request with clear description
4. Ensure backward compatibility when possible

## Support

For CI/CD related questions:
- GitHub Issues: Tag with `ci/cd` label
- Discord: #development channel
- Documentation: This file and linked guides

<p align="center">
  <a href="https://developer.apple.com/swift/"><img alt="Swift" src="https://img.shields.io/badge/Swift-6.3-ea7a50.svg?logo=swift&logoColor=white"></a>
  <a href="https://developer.apple.com/xcode/"><img alt="Xcode" src="https://img.shields.io/badge/Xcode-26.4-50ace8.svg?logo=xcode&logoColor=white"></a>
  <a href="https://developer.apple.com/documentation/xcode/swift-packages"><img alt="SPM" src="https://img.shields.io/badge/SPM-ready-b68f6a.svg?logo=gitlfs&logoColor=white"></a>
  <a href="https://en.wikipedia.org/wiki/List_of_Apple_operating_systems"><img alt="Platforms" src="https://img.shields.io/badge/Platforms-iOS%2026+%20%7C%20macOS%2026+%20%7C%20tvOS%2026+%20%7C%20watchOS%2026+%20%7C%20visionOS%2026+-lightgrey.svg?logo=apple&logoColor=white"></a>
  <a href="https://thatfactory.github.io/progresskit/documentation/progressionkit/"><img alt="DocC" src="https://img.shields.io/badge/DocC-documentation-0288D1.svg?logo=bookstack&logoColor=white"></a>
  <a href="https://en.wikipedia.org/wiki/MIT_License"><img alt="License" src="https://img.shields.io/badge/License-MIT-67ac5b.svg?logo=googledocs&logoColor=white"></a>
  <a href="https://github.com/thatfactory/progresskit/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/thatfactory/progresskit/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://github.com/thatfactory/progresskit/actions/workflows/release.yml"><img alt="Release" src="https://github.com/thatfactory/progresskit/actions/workflows/release.yml/badge.svg"></a>
</p>

# ProgressionKit
A reusable progression engine that turns player performance into configurable XP, levels, and unlocks across games and apps. 📈

`ProgressionKit` is a pure Swift package for apps and games that need deterministic progression logic without coupling progression rules to storage or UI frameworks.

It models:

- `XP` gain from successful performance.
- Player levels derived from total XP.
- Track-scoped mastery across distinct content.
- Tier unlocks such as `beginner`, `intermediate`, and `advanced`.

The package is deliberately content-agnostic. Host apps decide what a track, content item, and tier mean, then feed those identifiers into `ProgressionKit`.

## Implemented APIs

- `PKEngine`: applies a progression event to a profile and returns the updated profile plus derived progress values.
- `PKProfile`: persisted progression state for a player.
- `PKConfig`: tunable progression rules such as level size, XP reward, tier order, and unlock thresholds.
- `PKEvent`: a single outcome emitted by the host app.
- `PKUpdate`: the result of applying one event.

## Structure

```mermaid
flowchart TB
  subgraph HOST["Host App/Game"]
    EVENTS["Performance Events"]
    STORAGE["Storage Layer"]
    UI["UI / HUD / XP Bar"]
  end

  subgraph PK[" "]
    ENGINE["ProgressionKit"]
    PROFILE["PKProfile"]
    CONFIG["PKConfig"]
    UPDATE["PKUpdate"]
  end

  EVENTS --> ENGINE
  CONFIG --> ENGINE
  ENGINE --> PROFILE
  ENGINE --> UPDATE
  PROFILE --> STORAGE
  UPDATE --> UI
```

## Integration

### Xcode
Use Xcode's [built-in support for SPM](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

*or...*

### Package.swift
In your `Package.swift`, add `ProgressionKit` as a dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/thatfactory/progresskit",
        from: "0.1.0"
    )
]
```

Associate the dependency with your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(
                name: "ProgressionKit",
                package: "progresskit"
            )
        ]
    )
]
```

Run: `swift build`

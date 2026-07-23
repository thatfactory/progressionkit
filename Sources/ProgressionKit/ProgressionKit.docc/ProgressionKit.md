# ``ProgressionKit``

Deterministic progression logic for XP, levels, and tier unlocks.

@Metadata {
    @Available(iOS, introduced: "26.0")
    @Available(macOS, introduced: "26.0")
    @Available(tvOS, introduced: "26.0")
    @Available(watchOS, introduced: "26.0")
    @Available(visionOS, introduced: "26.0")
}

## Overview

`ProgressionKit` is a pure Swift package for apps and games that need deterministic progression logic without coupling progression rules to storage or UI frameworks.

It models XP gain from successful performance, player levels derived from total XP, track-scoped mastery across distinct content, and tier unlocks such as `beginner`, `intermediate`, and `advanced`.

The package is content-agnostic. Host apps decide what a track, content item, and tier mean, then feed those identifiers into ``PKEngine``.

Each applied event emits one concise `📈` debug log through `AppLogger`. ProgressionKit uses subsystem `com.thatfactory.progressionkit`, category `progression`, and omits content, track, and tier identifiers.

## Usage

```swift
import ProgressionKit

let profile = PKProfile()
let event = PKEvent(
    contentID: "A11IYR-CE4D7B84",
    trackID: "A11IYR",
    tierID: "beginner",
    wasSuccessful: true
)

let update = PKEngine.apply(
    event: event,
    to: profile
)
```

```swift
let config = PKConfig(
    levelXP: 120,
    masteryXP: 15,
    tierOrder: ["bronze", "silver", "gold"],
    masteryRequirement: 4
)

let tunedUpdate = PKEngine.apply(
    event: event,
    to: profile,
    config: config
)
```

## Topics

### Core Types

Use ``PKProfile`` to store player progression, ``PKEvent`` to represent one gameplay outcome, and ``PKUpdate`` to read the derived result after applying an event.

### Engine

Use ``PKEngine/apply(event:to:config:)`` to apply progression rules synchronously and deterministically.

### Configuration

Use ``PKConfig`` to tune level size, mastery XP, tier order, and the unlock threshold for your app or game.

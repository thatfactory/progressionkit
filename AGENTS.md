# ProgressionKit

## Context

ProgressionKit is a pure Swift package for deterministic XP, player levels, track mastery, and tier unlocks. Read [README.md](README.md) and the DocC catalog before changing public behavior.

The package is content-, storage-, UI-, and application-architecture agnostic. Host applications decide what content, tracks, tiers, persistence, and presentation mean.

## Shared guidelines

Read only the guides relevant to the task:

- [Swift](AgentGuidelines/Guidelines/Swift/Swift.md)
- [Swift style](AgentGuidelines/Guidelines/Swift/SwiftStyle.md)
- [SwiftLint](AgentGuidelines/Guidelines/Swift/SwiftLint.md)
- [Unit and integration testing](AgentGuidelines/Guidelines/Testing/UnitTesting.md)
- [Documentation](AgentGuidelines/Guidelines/Documentation.md)
- [Packages](AgentGuidelines/Guidelines/Packages.md)
- [CI/CD](AgentGuidelines/Guidelines/CICD.md)
- [Xcode MCP](AgentGuidelines/Guidelines/Xcode/MCP.md)
- [Xcode security audits](AgentGuidelines/Guidelines/Xcode/Security.md)

Redux, SwiftUI, and application-localization guidance do not apply to the package target.

## Physical folder map

| Role | Physical folder |
|---|---|
| Package sources | `Sources/ProgressionKit/` |
| DocC catalog | `Sources/ProgressionKit/ProgressionKit.docc/` |
| Unit tests | `Tests/ProgressionKitTests/` |

## Package specialization

- Keep progression updates deterministic for the same profile, event, and configuration.
- Do not add storage, network, UI, Redux, or game-content dependencies.
- Host applications own mapping from their domain identifiers and outcomes into `PKEvent`.
- Preserve compiler-synthesized value semantics and serialization when evolving public models.
- Update tests, DocC, README examples, and release notes when public behavior changes.

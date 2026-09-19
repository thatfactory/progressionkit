# Changelog

All notable changes to ProgressionKit are documented here.

## 0.1.7 — 2026-09-19

### Changed

- Adopted Agent Guidelines `0.0.33` and the Swift package compiler-settings baseline.
- Declared Swift 6, warnings as errors, and the required upcoming language features for every package target.
- Made imports and existential types explicit where required by the stricter compiler policy without intentionally changing runtime behavior.


## [0.1.6] - 2026-08-18

### Changed

- Updated the package's shared agent-guidelines integration to `0.0.18`.
- Adopted the shared `swift-format` configuration across the package manifest, sources, and tests.
- Added strict, non-mutating Swift-format validation to pull-request and protected-branch CI.

### Compatibility

- No public API or progression-behavior changes.

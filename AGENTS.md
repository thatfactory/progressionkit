# ProgressionKit

## Context

ProgressionKit is a pure Swift package for deterministic XP, player levels, track mastery, and tier unlocks. Read [README.md](README.md) and the DocC catalog before changing public behavior.

The package is content-, storage-, UI-, and application-architecture agnostic. Host applications decide what content, tracks, tiers, persistence, and presentation mean.

## Shared guidelines

Read only the guides relevant to the task:

- [Agent workflow](AgentGuidelines/Guidelines/AgentWorkflow.md)
- [Swift](AgentGuidelines/Guidelines/Swift/Swift.md)
- [Swift style](AgentGuidelines/Guidelines/Swift/SwiftStyle.md)
- [Swift format](AgentGuidelines/Guidelines/Swift/SwiftFormat.md)
- [Unit and integration testing](AgentGuidelines/Guidelines/Testing/UnitTesting.md)
- [Documentation](AgentGuidelines/Guidelines/Documentation.md)
- [Logging](AgentGuidelines/Guidelines/Logging.md)
- [Packages](AgentGuidelines/Guidelines/Packages.md)
- [Development workflow](AgentGuidelines/Guidelines/Development.md)
- [CI/CD](AgentGuidelines/Guidelines/CICD.md)
- [Git repositories and SSH-first cloning](AgentGuidelines/Guidelines/Git/Repositories.md)
- [GitHub pull requests](AgentGuidelines/Guidelines/GitHub/PullRequests.md)
- [Xcode MCP](AgentGuidelines/Guidelines/Xcode/MCP.md)
- [Xcode security audits](AgentGuidelines/Guidelines/Xcode/Security.md)

Redux, SwiftUI, and application-localization guidance do not apply to the package target.

<!-- BEGIN THATFACTORY CODE REVIEW CONTRACT v1 -->
## Code Review Rules

Review for release-blocking defects introduced or materially exposed by the pull request. A clean review means no unresolved P0/P1 findings; it does not mean exhaustive or perfect software.

A blocking finding must identify a concrete, reachable path in a supported use case or the documented threat model that can cause a credible security-boundary bypass, durable data loss or corruption, a crash or deadlock, loss of availability, violation of an explicit acceptance criterion, or a serious compatibility regression.

For every blocking finding, state the severity, preconditions, execution path, impact, evidence, and actionable remediation. Group manifestations that share the same root cause into one finding.

Treat P2/P3 observations as non-blocking, including defense-in-depth, theoretical completeness, unsupported use cases, malformed state that trusted code cannot produce, behavior by components outside the threat model, style preferences, and speculative refactoring. Record a useful lower-severity observation once as deferred, declined, duplicate, or follow-up work; do not keep the review loop open for it.

In an initial review, report substantiated blockers together. A follow-up review is limited to unresolved P0/P1 findings, changes since the last reviewed commit, and code directly affected by those changes. Do not restart an unrestricted review of unchanged code. A new follow-up finding must be a P0/P1 defect introduced by the remediation or genuinely hidden by the previous blocker.

Automatic Codex review is the initial review. Do not request a manual Codex review unless the repository owner explicitly asks. Never request another review after each remediation commit. Within the normal review budget, at most one owner-authorized, delta-scoped verification review may be requested under [the pull-request review workflow](AgentGuidelines/Guidelines/GitHub/PullRequests.md).
<!-- END THATFACTORY CODE REVIEW CONTRACT v1 -->

## Physical folder map

| Role | Physical folder |
|---|---|
| Package sources | `Sources/ProgressionKit/` |
| DocC catalog | `Sources/ProgressionKit/ProgressionKit.docc/` |
| Unit tests | `Tests/ProgressionKitTests/` |

## CI/CD

- Swift package CI uses the self-hosted runner labels `self-hosted` and `macOS`.
- Pull-request validation runs from `.github/workflows/ci-pr.yml`; protected-branch validation runs from `.github/workflows/ci.yml`.

## Package specialization

- Keep progression updates deterministic for the same profile, event, and configuration.
- Do not add storage, network, UI, Redux, or game-content dependencies.
- Host applications own mapping from their domain identifiers and outcomes into `PKEvent`.
- Preserve compiler-synthesized value semantics and serialization when evolving public models.
- Update tests, DocC, README examples, and release notes when public behavior changes.
- Use logging subsystem `com.thatfactory.progressionkit`, category `progression`, and canonical package emoji `📈`.
## Codex review scope

For consumer pull requests, do not substantively review `AgentGuidelines/**` after exact tagged-tree provenance has been verified. Verify its `VERSION`, compare its tree with the matching central tag, and verify the required `.gitattributes` rule. If provenance does not match exactly, review the subtree contents and stop the merge. Report substantive guideline feedback against the central `agent-guidelines` pull request.

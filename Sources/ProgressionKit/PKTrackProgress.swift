import Foundation

/// Stores progression for one track, including unlocked tiers and mastery history.
public struct PKTrackProgress: Equatable, Codable, Sendable {
    /// The set of tiers currently unlocked for this track.
    public var unlockedTierIDs: Set<String>

    /// The mastery state grouped by tier identifier.
    public var tierProgress: [String: PKTierProgress]

    /// Creates track progress state.
    ///
    /// - Parameters:
    ///   - unlockedTierIDs: The set of tiers currently unlocked for this track.
    ///   - tierProgress: The mastery state grouped by tier identifier.
    public init(
        unlockedTierIDs: Set<String> = [],
        tierProgress: [String: PKTierProgress] = [:]
    ) {
        self.unlockedTierIDs = unlockedTierIDs
        self.tierProgress = tierProgress
    }
}

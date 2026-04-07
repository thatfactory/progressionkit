import Foundation

/// Stores the persisted progression state for one player.
public struct PKProfile: Equatable, Codable, Sendable {
    /// The player's cumulative XP across all tracks.
    public var totalXP: Int

    /// The player's progression grouped by track identifier.
    public var trackProgress: [String: PKTrackProgress]

    /// Creates a player progression profile.
    ///
    /// - Parameters:
    ///   - totalXP: The player's cumulative XP across all tracks.
    ///   - trackProgress: The player's progression grouped by track identifier.
    public init(
        totalXP: Int = 0,
        trackProgress: [String: PKTrackProgress] = [:]
    ) {
        self.totalXP = totalXP
        self.trackProgress = trackProgress
    }
}

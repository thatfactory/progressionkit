import Foundation

/// Describes the result of applying one progression event.
public struct PKUpdate: Equatable, Codable, Sendable {
    /// Indicates whether the event granted new XP.
    public let didGrantXP: Bool

    /// The tiers unlocked by this event, if any.
    public let newlyUnlockedTierIDs: [String]

    /// The player's current level derived from total XP.
    public let playerLevel: Int

    /// The updated profile after applying the event.
    public let profile: PKProfile

    /// The XP required to complete the current level.
    public let xpForNextLevel: Int

    /// The amount of XP already earned within the current level.
    public let xpIntoLevel: Int

    /// Creates a progression update.
    ///
    /// - Parameters:
    ///   - didGrantXP: Indicates whether the event granted new XP.
    ///   - newlyUnlockedTierIDs: The tiers unlocked by this event, if any.
    ///   - playerLevel: The player's current level derived from total XP.
    ///   - profile: The updated profile after applying the event.
    ///   - xpForNextLevel: The XP required to complete the current level.
    ///   - xpIntoLevel: The amount of XP already earned within the current level.
    public init(
        didGrantXP: Bool,
        newlyUnlockedTierIDs: [String],
        playerLevel: Int,
        profile: PKProfile,
        xpForNextLevel: Int,
        xpIntoLevel: Int
    ) {
        self.didGrantXP = didGrantXP
        self.newlyUnlockedTierIDs = newlyUnlockedTierIDs
        self.playerLevel = playerLevel
        self.profile = profile
        self.xpForNextLevel = xpForNextLevel
        self.xpIntoLevel = xpIntoLevel
    }
}

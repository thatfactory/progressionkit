import Foundation

/// Defines the rules that control XP gain, levels, and tier unlocks.
public struct PKConfig: Equatable, Codable, Sendable {
    /// The amount of XP needed for each player level.
    public let levelXP: Int

    /// The XP awarded when a content item grants mastery for the first time.
    public let masteryXP: Int

    /// The ordered tier identifiers used to unlock more difficult content.
    public let tierOrder: [String]

    /// The number of distinct mastered content items required to unlock the next tier.
    public let masteryRequirement: Int

    /// Creates a progression configuration.
    ///
    /// - Parameters:
    ///   - levelXP: The amount of XP needed for each player level.
    ///   - masteryXP: The XP awarded when a content item grants mastery for the first time.
    ///   - tierOrder: The ordered tier identifiers used to unlock more difficult content.
    ///   - masteryRequirement: The number of distinct mastered content items required to unlock the next tier.
    public init(
        levelXP: Int = 100,
        masteryXP: Int = 10,
        tierOrder: [String] = ["beginner", "intermediate", "advanced"],
        masteryRequirement: Int = 5
    ) {
        precondition(levelXP > 0, "levelXP must be greater than zero.")
        precondition(masteryXP >= 0, "masteryXP must be zero or greater.")
        precondition(!tierOrder.isEmpty, "tierOrder must not be empty.")
        precondition(masteryRequirement > 0, "masteryRequirement must be greater than zero.")

        self.levelXP = levelXP
        self.masteryXP = masteryXP
        self.tierOrder = tierOrder
        self.masteryRequirement = masteryRequirement
    }
}

// MARK: - Defaults

extension PKConfig {
    /// The default configuration for tiered progression systems.
    public static let standard = PKConfig()
}

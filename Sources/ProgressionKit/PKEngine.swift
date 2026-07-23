import Foundation

/// Applies progression events to profiles using a deterministic rule set.
///
/// Each application emits one `📈` debug log containing only the XP granted, resulting level, and unlock count.
public enum PKEngine {
    /// Applies one progression event to a player profile.
    ///
    /// - Parameters:
    ///   - event: The event emitted by the host app.
    ///   - profile: The player profile to update.
    ///   - config: The progression rule set to apply.
    /// - Returns: The updated profile and its derived values.
    public static func apply(
        event: PKEvent,
        to profile: PKProfile,
        config: PKConfig = .standard
    ) -> PKUpdate {
        var updatedProfile = profile
        var trackProgress = updatedProfile.trackProgress[event.trackID] ?? defaultTrackProgress(config: config)
        let isTierUnlocked = trackProgress.unlockedTierIDs.contains(event.tierID)

        guard event.wasSuccessful, isTierUnlocked else {
            updatedProfile.trackProgress[event.trackID] = trackProgress
            return makeUpdate(
                profile: updatedProfile,
                config: config,
                didGrantXP: false,
                newlyUnlockedTierIDs: []
            )
        }

        var tierProgress = trackProgress.tierProgress[event.tierID] ?? PKTierProgress()
        guard !tierProgress.masteredContentIDs.contains(event.contentID) else {
            updatedProfile.trackProgress[event.trackID] = trackProgress
            return makeUpdate(
                profile: updatedProfile,
                config: config,
                didGrantXP: false,
                newlyUnlockedTierIDs: []
            )
        }

        tierProgress.masteredContentIDs.insert(event.contentID)
        trackProgress.tierProgress[event.tierID] = tierProgress
        updatedProfile.totalXP += config.masteryXP

        let newlyUnlockedTierIDs = unlockNextTierIfNeeded(
            trackProgress: &trackProgress,
            tierID: event.tierID,
            config: config
        )

        updatedProfile.trackProgress[event.trackID] = trackProgress

        return makeUpdate(
            profile: updatedProfile,
            config: config,
            didGrantXP: true,
            newlyUnlockedTierIDs: newlyUnlockedTierIDs
        )
    }
}

// MARK: - Private

private extension PKEngine {
    static func defaultTrackProgress(config: PKConfig) -> PKTrackProgress {
        let firstTierID = config.tierOrder[0]

        return PKTrackProgress(
            unlockedTierIDs: [firstTierID]
        )
    }

    static func unlockNextTierIfNeeded(
        trackProgress: inout PKTrackProgress,
        tierID: String,
        config: PKConfig
    ) -> [String] {
        guard
            let currentIndex = config.tierOrder.firstIndex(of: tierID),
            currentIndex < config.tierOrder.count - 1,
            let tierProgress = trackProgress.tierProgress[tierID],
            tierProgress.masteredContentIDs.count >= config.masteryRequirement
        else {
            return []
        }

        let nextTierID = config.tierOrder[currentIndex + 1]
        guard !trackProgress.unlockedTierIDs.contains(nextTierID) else {
            return []
        }

        trackProgress.unlockedTierIDs.insert(nextTierID)
        return [nextTierID]
    }

    static func makeUpdate(
        profile: PKProfile,
        config: PKConfig,
        didGrantXP: Bool,
        newlyUnlockedTierIDs: [String]
    ) -> PKUpdate {
        let playerLevel = (profile.totalXP / config.levelXP) + 1
        let xpIntoLevel = profile.totalXP % config.levelXP

        let update = PKUpdate(
            didGrantXP: didGrantXP,
            newlyUnlockedTierIDs: newlyUnlockedTierIDs,
            playerLevel: playerLevel,
            profile: profile,
            xpForNextLevel: config.levelXP,
            xpIntoLevel: xpIntoLevel
        )
        PKLogging.logProgression(
            update: update,
            xpGranted: didGrantXP ? config.masteryXP : 0
        )
        return update
    }
}

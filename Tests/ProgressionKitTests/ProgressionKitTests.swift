import Testing
@testable import ProgressionKit

@Test func grantsXPForFirstSuccessfulCompletion() {
    // Given
    let event = PKEvent(
        contentID: "lesson-1",
        trackID: "a11-reading",
        tierID: "beginner",
        wasSuccessful: true
    )

    // When
    let update = PKEngine.apply(
        event: event,
        to: PKProfile()
    )

    // Then
    #expect(update.didGrantXP)
    #expect(update.profile.totalXP == 10)
    #expect(update.playerLevel == 1)
    #expect(update.xpIntoLevel == 10)
}

@Test func doesNotGrantXPForRepeatedSuccessfulCompletion() {
    // Given
    let event = PKEvent(
        contentID: "lesson-1",
        trackID: "a11-reading",
        tierID: "beginner",
        wasSuccessful: true
    )
    let firstUpdate = PKEngine.apply(
        event: event,
        to: PKProfile()
    )

    // When
    let secondUpdate = PKEngine.apply(
        event: event,
        to: firstUpdate.profile
    )

    // Then
    #expect(!secondUpdate.didGrantXP)
    #expect(secondUpdate.profile.totalXP == 10)
}

@Test func doesNotGrantXPForIncorrectAttempts() {
    // Given
    let event = PKEvent(
        contentID: "lesson-1",
        trackID: "a11-reading",
        tierID: "beginner",
        wasSuccessful: false
    )

    // When
    let update = PKEngine.apply(
        event: event,
        to: PKProfile()
    )

    // Then
    #expect(!update.didGrantXP)
    #expect(update.profile.totalXP == 0)
}

@Test func unlocksIntermediateAfterDistinctBeginnerMastery() {
    // Given
    let events = (1 ... 5).map { index in
        PKEvent(
            contentID: "lesson-\(index)",
            trackID: "a11-reading",
            tierID: "beginner",
            wasSuccessful: true
        )
    }

    // When
    let finalUpdate = events.reduce(
        PKUpdate(
            didGrantXP: false,
            newlyUnlockedTierIDs: [],
            playerLevel: 1,
            profile: PKProfile(),
            xpForNextLevel: 100,
            xpIntoLevel: 0
        )
    ) { partialUpdate, event in
        PKEngine.apply(
            event: event,
            to: partialUpdate.profile
        )
    }

    // Then
    #expect(finalUpdate.newlyUnlockedTierIDs == ["intermediate"])
    #expect(
        finalUpdate.profile.trackProgress["a11-reading"]?.unlockedTierIDs.contains("intermediate") == true
    )
}

@Test func unlocksAdvancedAfterDistinctIntermediateMastery() {
    // Given
    let beginnerEvents = (1 ... 5).map { index in
        PKEvent(
            contentID: "beginner-\(index)",
            trackID: "a11-writing",
            tierID: "beginner",
            wasSuccessful: true
        )
    }
    let intermediateEvents = (1 ... 5).map { index in
        PKEvent(
            contentID: "intermediate-\(index)",
            trackID: "a11-writing",
            tierID: "intermediate",
            wasSuccessful: true
        )
    }

    let unlockedIntermediateProfile = beginnerEvents.reduce(PKProfile()) { profile, event in
        PKEngine.apply(
            event: event,
            to: profile
        ).profile
    }

    // When
    let finalUpdate = intermediateEvents.reduce(
        PKUpdate(
            didGrantXP: false,
            newlyUnlockedTierIDs: [],
            playerLevel: 1,
            profile: unlockedIntermediateProfile,
            xpForNextLevel: 100,
            xpIntoLevel: 0
        )
    ) { partialUpdate, event in
        PKEngine.apply(
            event: event,
            to: partialUpdate.profile
        )
    }

    // Then
    #expect(finalUpdate.newlyUnlockedTierIDs == ["advanced"])
    #expect(
        finalUpdate.profile.trackProgress["a11-writing"]?.unlockedTierIDs.contains("advanced") == true
    )
}

@Test func derivesLevelAcrossBoundary() {
    // Given
    let config = PKConfig(
        levelXP: 100,
        masteryXP: 25,
        tierOrder: ["beginner", "intermediate", "advanced"],
        masteryRequirement: 5
    )
    let events = (1 ... 4).map { index in
        PKEvent(
            contentID: "lesson-\(index)",
            trackID: "a11-listening",
            tierID: "beginner",
            wasSuccessful: true
        )
    }

    // When
    let finalProfile = events.reduce(PKProfile()) { profile, event in
        PKEngine.apply(
            event: event,
            to: profile,
            config: config
        ).profile
    }
    let finalUpdate = PKEngine.apply(
        event: PKEvent(
            contentID: "lesson-5",
            trackID: "a11-listening",
            tierID: "beginner",
            wasSuccessful: false
        ),
        to: finalProfile,
        config: config
    )

    // Then
    #expect(finalUpdate.profile.totalXP == 100)
    #expect(finalUpdate.playerLevel == 2)
    #expect(finalUpdate.xpIntoLevel == 0)
    #expect(finalUpdate.xpForNextLevel == 100)
}

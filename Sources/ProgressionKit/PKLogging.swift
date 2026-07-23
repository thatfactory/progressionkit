import AppLogger

/// Routes ProgressionKit-owned diagnostics through the package logging identity.
enum PKLogging {
    typealias Sink = @Sendable (AppLogLevel, PKLogCategory, String, Bool) -> Void

    static let emoji = "📈"
    static let subsystem = "com.thatfactory.progressionkit"

    @TaskLocal
    static var sink: Sink = { level, category, message, isPrivate in
        let logger = AppLogger(
            subsystem: subsystem,
            category: category.rawValue
        )
        logger.log(
            level: level,
            message,
            isPrivate: isPrivate
        )
    }

    static func logProgression(
        update: PKUpdate,
        xpGranted: Int
    ) {
        sink(
            .debug,
            .progression,
            """
            \(emoji) apply | xpGranted=\(xpGranted), \
            level=\(update.playerLevel), unlocked=\(update.newlyUnlockedTierIDs.count)
            """,
            false
        )
    }
}

/// Identifies stable diagnostic categories owned by ProgressionKit.
enum PKLogCategory: String, Sendable {
    case progression
}

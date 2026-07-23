import AppLogger
import Foundation
import Testing
@testable import ProgressionKit

@Suite struct PKLoggingTests {
    @Test func applyingEventLogsOnePackageOwnedOutcome() throws {
        // Given
        let recorder = PKLogRecorder()
        let event = PKEvent(
            contentID: "Sensitive content",
            trackID: "Sensitive track",
            tierID: "beginner",
            wasSuccessful: true
        )
        let config = PKConfig(
            levelXP: 10,
            masteryXP: 15,
            tierOrder: ["beginner", "intermediate"],
            masteryRequirement: 1
        )

        // When
        PKLogging.$sink.withValue(recorder.record) {
            _ = PKEngine.apply(
                event: event,
                to: PKProfile(),
                config: config
            )
        }

        // Then
        let entry = try #require(recorder.entries.first)
        #expect(recorder.entries.count == 1)
        #expect(entry.category == .progression)
        #expect(!entry.isPrivate)
        #expect(entry.message == "📈 apply | xpGranted=15, level=2, unlocked=1")
        #expect(!entry.message.contains(event.contentID))
        #expect(!entry.message.contains(event.trackID))
        #expect(!entry.message.contains(event.tierID))
        #expect(PKLogging.subsystem == "com.thatfactory.progressionkit")
        expectDebug(entry.level)
    }
}

// MARK: - Private

private func expectDebug(
    _ level: AppLogLevel,
    sourceLocation: SourceLocation = #_sourceLocation
) {
    guard case .debug = level else {
        Issue.record(
            "Expected a debug log level.",
            sourceLocation: sourceLocation
        )
        return
    }
}

/// Records ProgressionKit log entries emitted during a test.
private final class PKLogRecorder: @unchecked Sendable {
    private var internalEntries: [PKRecordedLog] = []
    private let lock = NSLock()

    var entries: [PKRecordedLog] {
        lock.lock()
        defer {
            lock.unlock()
        }
        return internalEntries
    }

    func record(
        _ level: AppLogLevel,
        _ category: PKLogCategory,
        _ message: String,
        _ isPrivate: Bool
    ) {
        lock.lock()
        defer {
            lock.unlock()
        }
        internalEntries.append(
            PKRecordedLog(
                level: level,
                category: category,
                message: message,
                isPrivate: isPrivate
            )
        )
    }
}

private struct PKRecordedLog {
    let level: AppLogLevel
    let category: PKLogCategory
    let message: String
    let isPrivate: Bool
}

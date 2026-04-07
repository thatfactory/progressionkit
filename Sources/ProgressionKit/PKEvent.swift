import Foundation

/// Represents one gameplay outcome that can affect player progression.
public struct PKEvent: Equatable, Codable, Sendable {
    /// The stable identifier for the content item that was attempted.
    public let contentID: String

    /// The stable identifier for the track this content belongs to.
    public let trackID: String

    /// The tier identifier for the attempted content.
    public let tierID: String

    /// Indicates whether the attempt should grant progression credit.
    public let wasSuccessful: Bool

    /// Creates a progression event.
    ///
    /// - Parameters:
    ///   - contentID: The stable identifier for the content item that was attempted.
    ///   - trackID: The stable identifier for the track this content belongs to.
    ///   - tierID: The tier identifier for the attempted content.
    ///   - wasSuccessful: Indicates whether the attempt should grant progression credit.
    public init(
        contentID: String,
        trackID: String,
        tierID: String,
        wasSuccessful: Bool
    ) {
        self.contentID = contentID
        self.trackID = trackID
        self.tierID = tierID
        self.wasSuccessful = wasSuccessful
    }
}

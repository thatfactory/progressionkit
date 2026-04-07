import Foundation

/// Stores mastery information for a single tier within a track.
public struct PKTierProgress: Equatable, Codable, Sendable {
    /// The distinct content identifiers that already granted mastery credit.
    public var masteredContentIDs: Set<String>

    /// Creates tier progress state.
    ///
    /// - Parameter masteredContentIDs: The distinct content identifiers that already granted mastery credit.
    public init(masteredContentIDs: Set<String> = []) {
        self.masteredContentIDs = masteredContentIDs
    }
}

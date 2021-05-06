import Foundation

/// A collection of activities to be uploaded using Send Conversation History.
public struct Transcript: Encodable {
    /// An array of Activity objects.
    /// They should each have a unique ID and timestamp.
    public let activities: [Activity]
    
    public init(activities: [Activity]) {
        self.activities = activities
    }
}

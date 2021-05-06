import Foundation

/// Page of members returned by Get Conversation Paged Members.
public struct PagedMembersResult: Decodable {
    /// The continuation token that can be used in subsequent calls to Get Conversation Paged Members.
    public let continuationToken: String
    /// An array of conversation members.
    public let members: [ChannelAccount]
    
    public init(continuationToken: String, members: [ChannelAccount]) {
        self.continuationToken = continuationToken
        self.members = members
    }
}

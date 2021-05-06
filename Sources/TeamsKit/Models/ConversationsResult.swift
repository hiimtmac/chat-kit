import Foundation

/// Defines the result of Get Conversations.
public struct ConversationsResult: Decodable {
    /// The members in each of the conversations.
    public let conversations: [ConversationMembers]
    /// The continuation token that can be used in subsequent calls to Get Conversations.
    public let continuationToken: String
    
    public init(conversations: [ConversationMembers], continuationToken: String) {
        self.conversations = conversations
        self.continuationToken = continuationToken
    }
}

extension ConversationsResult {
    /// Defines the members of a conversation.
    public struct ConversationMembers: Decodable {
        /// The conversation ID.
        public let id: String
        /// List of members in this conversation.
        public let members: [ChannelAccount]
        
        public init(id: String, members: [ChannelAccount]) {
            self.id = id
            self.members = members
        }
    }
}

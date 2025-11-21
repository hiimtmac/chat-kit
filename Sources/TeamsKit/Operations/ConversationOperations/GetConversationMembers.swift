import Foundation

/// Gets the members of the specified conversation.
public struct GetConversationMembers: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// An array of ChannelAccount objects for the members of the conversation.
    public typealias Response = [ChannelAccount]
    
    public let conversationId: String
    
    public init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    public var route: Router { .getConversationMembers(conversationId: conversationId) }
}

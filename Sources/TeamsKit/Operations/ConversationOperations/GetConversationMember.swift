import Foundation

/// Gets details about a specific member of a specific conversation.
public struct GetConversationMember: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// A ChannelAccount object for the member.
    public typealias Response = ChannelAccount
    
    public let conversationId: String
    public let memberId: String
    
    public init(conversationId: String, memberId: String) {
        self.conversationId = conversationId
        self.memberId = memberId
    }
    
    public var route: Router { .getConversationMember(conversationId: conversationId, memberId: memberId) }
}

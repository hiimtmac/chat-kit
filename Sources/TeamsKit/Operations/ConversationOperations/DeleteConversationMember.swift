import Foundation

/// Removes a member from a conversation.
/// If that member was the last member of the conversation, the conversation will also be deleted.
public struct DeleteConversationMember: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// An HTTP Status code that indicates the outcome of the operation.
    /// Nothing is specified in the body of the response.
    public typealias Response = Never
    
    public let conversationId: String
    public let memberId: String
    
    public init(conversationId: String, memberId: String) {
        self.conversationId = conversationId
        self.memberId = memberId
    }
    
    public var route: Router { .deleteConversationMember(conversationId: conversationId, memberId: memberId) }
}

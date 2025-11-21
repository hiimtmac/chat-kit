import Foundation

/// Sends an activity (message) to the specified conversation.
/// The activity will be appended to the end of the conversation according to the timestamp or semantics of the channel.
/// To reply to a specific message within the conversation, use Reply to Activity instead.
public struct SendToConversation: ConversationOperation {
    /// An Activity object
    public typealias Body = Activity
    /// A ResourceResponse object
    public typealias Response = ResourceResponse
    
    public let conversationId: String
    
    public init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    public var route: Router { .sendToConversation(conversationId: conversationId) }
}

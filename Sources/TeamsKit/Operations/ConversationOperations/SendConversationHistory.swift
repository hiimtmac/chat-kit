import Foundation

/// Uploads a transcript of past activities to the conversation so that the client can render them.
public struct SendConversationHistory: ConversationOperation {
    /// A Transcript object.
    public typealias Body = Transcript
    /// A ResourceResponse object.
    public typealias Response = ResourceResponse
    
    public let conversationId: String
    
    public init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    public var route: Router { .sendConversationHistory(conversationId: conversationId) }
}

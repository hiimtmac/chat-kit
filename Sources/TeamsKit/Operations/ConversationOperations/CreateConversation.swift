import Foundation

/// Creates a new conversation.
public struct CreateConversation: ConversationOperation {
    /// A ConversationParameters object
    public typealias Body = ConversationParameters
    /// A ConversationResourceResponse object
    public typealias Response = ConversationResourceResponse
    
    public init() {
        
    }
    
    public var route: Router { .createConversation }
}

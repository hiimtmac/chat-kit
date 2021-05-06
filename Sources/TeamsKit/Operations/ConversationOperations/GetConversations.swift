import Foundation

/// Gets a list of conversations the bot has participated in.
public struct GetConversations: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// A ConversationsResult object
    public typealias Response = ConversationsResult
    
    public let continuationToken: String
    
    public init(continuationToken: String) {
        self.continuationToken = continuationToken
    }
    
    public var route: Router { .getConversations(continuationToken: continuationToken) }
}

import Foundation

/// Gets the members of the specified conversation one page at a time.
public struct GetConversationPagedMembers: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// A PagedMembersResult object
    public typealias Response = PagedMembersResult
    
    public let conversationId: String
    public let pageSize: String
    public let continuationToken: String
    
    public init(conversationId: String, pageSize: String, continuationToken: String) {
        self.conversationId = conversationId
        self.pageSize = pageSize
        self.continuationToken = continuationToken
    }
    
    public var route: Router {
        .getConversationPagedMembers(conversationId: conversationId, pageSize: pageSize, continuationToken: continuationToken)
    }
}

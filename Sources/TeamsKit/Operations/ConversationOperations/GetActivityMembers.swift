import Foundation

/// Gets the members of the specified activity within the specified conversation.
public struct GetActivityMembers: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// An array of ChannelAccount objects
    public typealias Response = [ChannelAccount]
    
    public let conversationId: String
    public let activityId: String
    
    public init(conversationId: String, activityId: String) {
        self.conversationId = conversationId
        self.activityId = activityId
    }
    
    public var route: Router { .getActivityMembers(conversationId: conversationId, activityId: activityId) }
}

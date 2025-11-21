import Foundation

/// Sends an activity (message) to the specified conversation, as a reply to the specified activity.
/// The activity will be added as a reply to another activity, if the channel supports it.
/// If the channel does not support nested replies, then this operation behaves like Send to Conversation.
public struct ReplyToActivity: ConversationOperation {
    /// An Activity object
    public typealias Body = Activity
    /// A ResourceResponse object
    public typealias Response = ResourceResponse
    
    public let conversationId: String
    public let activityId: String
    
    public init(conversationId: String, activityId: String) {
        self.conversationId = conversationId
        self.activityId = activityId
    }
    
    public var route: Router { .replyToActivity(conversationId: conversationId, activityId: activityId) }
}

import Foundation

/// Some channels allow you to delete an existing activity.
/// If successful, this operation removes the specified activity from the specified conversation.
public struct DeleteActivity: ConversationOperation {
    /// N/A
    public typealias Body = Never
    /// An HTTP Status code that indicates the outcome of the operation.
    /// Nothing is specified in the body of the response.
    public typealias Response = Never
    
    public let attachmentId: String
    public let activityId: String
    
    public init(attachmentId: String, activityId: String) {
        self.attachmentId = attachmentId
        self.activityId = activityId
    }
    
    public var route: Router { .deleteActivity(conversationId: attachmentId, activityId: activityId) }
}

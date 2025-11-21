import Foundation

/// Some channels allow you to edit an existing activity to reflect the new state of a bot conversation.
/// For example, you might remove buttons from a message in the conversation after the user has clicked one of the buttons.
/// If successful, this operation updates the specified activity within the specified conversation.
public struct UpdateActivity: ConversationOperation {
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
    
    public var route: Router { .updateActivity(conversationId: conversationId, activityId: activityId) }
}

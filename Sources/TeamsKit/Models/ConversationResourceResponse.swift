import Foundation

/// Defines a response to Create Conversation.
public struct ConversationResourceResponse: Decodable {
    /// ID of the activity, if sent.
    public let activityId: String?
    /// ID of the resource.
    public let id: String
    /// Service endpoint where operations concerning the conversation may be performed.
    public let serviceUrl: URL
    
    public init(activityId: String?, id: String, serviceUrl: URL) {
        self.activityId = activityId
        self.id = id
        self.serviceUrl = serviceUrl
    }
}

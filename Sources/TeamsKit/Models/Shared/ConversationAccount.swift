import Foundation

/// Defines a conversation in a channel.
public struct ConversationAccount: Codable {
    /// This account's object ID within Azure Active Directory (AAD).
    public let aadObjectId: String?
    /// Indicates the type of the conversation in channels that distinguish between conversation types (e.g. group, personal).
    public let conversationType: ConversationType?
    /// The ID that identifies the conversation.
    public let id: String
    /// Flag to indicate whether the conversation contains more than two participants at the time the activity was generated.
    public let isGroup: Bool?
    /// A display name that can be used to identify the conversation.
    public let name: String?
    /// This conversation's tenant ID.
    public let tenantId: String?
    
    public init(
        aadObjectId: String?,
        conversationType: ConversationType?,
        id: String,
        isGroup: Bool? = false,
        tenantId: String?,
        name: String?
    ) {
        self.aadObjectId = aadObjectId
        self.conversationType = conversationType
        self.id = id
        self.isGroup = isGroup
        self.tenantId = tenantId
        self.name = name
    }
    
    public enum ConversationType: String, Codable {
        case group
        case personal
        case channel
    }
}

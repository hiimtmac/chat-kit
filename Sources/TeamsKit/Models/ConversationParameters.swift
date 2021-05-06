import Foundation

/// Defines parameters for creating a new conversation.
public struct ConversationParameters: Encodable {
    /// The initial message to send to the conversation when it is created.
    public let activity: Activity
    /// Channel account information needed to route a message to the bot.
    public let bot: ChannelAccount
    /// Channel-specific payload for creating the conversation.
    public let channelData: ChannelData?
    /// Indicates whether this is a group conversation.
    public let isGroup: Bool
    /// Channel account information needed to route a message to each user.
    public let members: [ChannelAccount]
    /// The tenant ID in which the conversation should be created.
    public let tenantId: String
    /// Topic of the conversation. This property is only used if a channel supports it.
    public let topicName: String
    
    public init(activity: Activity, bot: ChannelAccount, channelData: ChannelData?, isGroup: Bool, members: [ChannelAccount], tenantId: String, topicName: String) {
        self.activity = activity
        self.bot = bot
        self.channelData = channelData
        self.isGroup = isGroup
        self.members = members
        self.tenantId = tenantId
        self.topicName = topicName
    }
}

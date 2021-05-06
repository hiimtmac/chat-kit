import Foundation

/// Defines a bot or user account on the channel.
public struct ChannelAccount: Codable {
    /// This account's object ID within Azure Active Directory.
    public let aadObjectId: String?
    /// Unique ID for the user or bot on this channel.
    public let id: String
    /// Display-friendly name of the bot or user.
    public let name: String?
    
    public init(aadObjectId: String?, id: String, name: String?) {
        self.aadObjectId = aadObjectId
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case aadObjectId
        case id
        case name
    }
}

extension ChannelAccount {
    public static let webhookResponse = ChannelAccount(aadObjectId: nil, id: UUID().uuidString, name: nil)
}

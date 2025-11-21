import Foundation

/// Some channels provide features that cannot be implemented by using only message text and attachments.
/// To implement channel-specific functionality, you can pass native metadata to a channel in the [Activity[]] object's channelData property.
/// For example, your bot can use the channelData property to instruct Telegram to send a sticker or to instruct Office365 to send an email.
public enum ChannelData: Codable {
    case teams(TeamsChannelData)
    /// Send and receive an email that contains body, subject, and importance metadata
    case email(Email)
    /// Send full fidelity Slack messages
    case slack(SlackMessage)
    /// Send Facebook notifications natively
    case facebook(FacebookNotification)
    /// Perform Telegram-specific actions, such as sharing a voice memo or a sticker
    case telegram(TelegramAction)
    /// Send and receive native Kik messages
    case kik(KikMessage)
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .teams(let teams): try container.encode(teams)
        case .email(let email): try container.encode(email)
        case .slack(let slack): try container.encode(slack)
        case .facebook(let facebook): try container.encode(facebook)
        case .telegram(let telegram): try container.encode(telegram)
        case .kik(let kik): try container.encode(kik)
        }
    }
    
    public init(from decoder: Decoder) throws {
        self = .teams(try TeamsChannelData(from: decoder))
    }
}

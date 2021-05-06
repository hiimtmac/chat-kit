import Foundation

/// Perform Telegram-specific actions, such as sharing a voice memo or a sticker
public struct TelegramAction: Encodable {
    /// The Telegram Bot API method to call.
    public let method: Method
    /// The parameters of the specified method.
    public let parameters: Parameters
    
    public init(method: Method, parameters: Parameters) {
        self.method = method
        self.parameters = parameters
    }
}

extension TelegramAction {
    public struct Parameters: Encodable {
        // https://docs.microsoft.com/en-us/previous-versions/azure/bot-service/rest-api/bot-framework-rest-connector-channeldata?view=azure-bot-service-3.0#create-a-telegram-message
        // https://core.telegram.org/bots/api#available-methods
    }
    
    public enum Method: String, Encodable {
        case answerInlineQuery
        case editMessageCaption
        case editMessageReplyMarkup
        case editMessageText
        case forwardMessage
        case kickChatMember
        case sendAudio
        case sendChatAction
        case sendContact
        case sendDocument
        case sendLocation
        case sendMessage
        case sendPhoto
        case sendSticker
        case sendVenue
        case sendVideo
        case sendVoice
        case unbanChateMember
    }
}

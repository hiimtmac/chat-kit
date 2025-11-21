import Foundation

/// Send and receive native Kik messages
public struct KikMessage: Encodable {
    /// An array of Kik messages. For details about Kik message format, see Kik Message Formats.
    public let messages: [Message]
    
    public init(messages: [Message]) {
        self.messages = messages
    }
}

extension KikMessage {
    public struct Message: Encodable {
        // https://docs.microsoft.com/en-us/previous-versions/azure/bot-service/rest-api/bot-framework-rest-connector-channeldata?view=azure-bot-service-3.0#create-a-native-kik-message
        // https://dev.kik.com/#/docs/messaging#message-formats
    }
}

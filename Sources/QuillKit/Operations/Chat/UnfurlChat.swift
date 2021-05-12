import Foundation
import BlockKit

/// Allows your integration to unfurl a link that was shared to you via the events API.
/// This allows you to replace the link message with a Quill message that has more context.
public struct UnfurlChat: Operation {
    public init() {}
    
    public var route: Router { .unfurlChat }
    
    public struct Body: Encodable {
        /// Access token. We prefer you pass this in as an Authorization: Bearer [access_token] http header, but will also accept it as a parameter.
        public let token: String?
        /// Channel, direct messsage, or group. Usually of the form C123123123 or G123123123 for example.
        public let channel: String
        /// The ts of the message to be updated. This is a unique identifier of the message.
        public let ts: String
        /// Text body to send. This field works differently whether you're using blocks or attachments.
        public let text: String
        /// A JSON-basesd array of structured attachments, presented as a URL-encoded string.
//        public let attachments: Array
        /// A JSON-based array of structured blocks, presented as a URL-encoded string.
        public let blocks: [Block]?
        
        public init(
            token: String? = nil,
            channel: String,
            ts: String,
            text: String,
            blocks: [Block]? = nil
        ) {
            self.token = token
            self.channel = channel
            self.ts = ts
            self.text = text
            self.blocks = blocks
        }
    }
    
    public struct Response: Decodable {
        public let ok: Bool
        public let ts: String?
        public let error: String?
    }
}
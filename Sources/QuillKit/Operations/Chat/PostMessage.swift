import Foundation
import BlockKit

/// Post a new thread to the given channel.
/// Posts a message to a thread if thread_ts is given or the channel is a direct message or group.
public struct PostMessage: Operation {
    public init() {}
    
    public var route: Router { .postMessage }
    
    public struct Body: Encodable {
        /// Access token. We prefer you pass this in as an Authorization: Bearer [access_token] http header, but will also accept it as a parameter.
        public let token: String?
        /// Channel, direct messsage, or group. Usually of the form C123123123 or G123123123 for example.
        public let channel: String
        /// Text body to send. This field works differently whether you're using blocks or attachments.
        public let text: String
        /// A JSON-basesd array of structured attachments, presented as a URL-encoded string.
//        public let attachments: Array
        /// A JSON-based array of structured blocks, presented as a URL-encoded string.
        public let blocks: [Block]?
        /// Provide a thread_ts from a previous message's ts to thread the reply vs making a new thread in a channel.
        public let thread_ts: String?
        
        public init(
            token: String? = nil,
            channel: String,
            text: String,
            blocks: [Block]? = nil,
            thread_ts: String? = nil
        ) {
            self.token = token
            self.channel = channel
            self.text = text
            self.blocks = blocks
            self.thread_ts = thread_ts
        }
    }
    
    public struct Response: Decodable {
        public let ok: Bool
        public let ts: String?
        public let error: String?
    }
}

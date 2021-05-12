import Foundation
import BlockKit

/// Post an ephemeral message, which is only visible to the assigned user.
/// Ephemeral message delivery is not guaranteed if the user isn't currently active in Quill.
/// Use ephemeral messages to send users context-sensitive message relevant to them.
public struct PostEphemeral: Operation {    
    public init() {}
    
    public var route: Router { .postEphemeral }
    
    public struct Body: Encodable {
        /// Access token. We prefer you pass this in as an Authorization: Bearer [access_token] http header, but will also accept it as a parameter.
        public let token: String?
        /// Channel, direct messsage, or group. Usually of the form C123123123 or G123123123 for example.
        public let channel: String
        /// The user who will receive the ephemeral message. Usually of the form U123123123
        public let user: String
        /// Text body to send. This field works differently whether you're using blocks or attachments.
        public let text: String
        /// A JSON-basesd array of structured attachments, presented as a URL-encoded string.
//        public let attachments: Array
        /// A JSON-based array of structured blocks, presented as a URL-encoded string.
        public let blocks: [Block]?
        
        public init(
            token: String? = nil,
            channel: String,
            user: String,
            text: String,
            blocks: [Block]? = nil
        ) {
            self.token = token
            self.channel = channel
            self.user = user
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

import Foundation
import BlockKit

/// This method is used to create a channel.
public struct CreateChannel: Operation {
    public init() {}
    
    public var route: Router { .createChannel }
    
    public struct Body: Encodable {
        /// Access token. We prefer you pass this in as an Authorization: Bearer [access_token] http header, but will also accept it as a parameter.
        public let token: String?
        /// Name of the channel to create
        public let name: String
        
        public init(
            token: String? = nil,
            name: String
        ) {
            self.token = token
            self.name = name
        }
    }
    
    public struct Response: Decodable {
        public let ok: Bool
        public let channel: Channel?
        public let error: String?
        
        public struct Channel: Decodable {
            public let id: String
            public let name: String
        }
    }
}

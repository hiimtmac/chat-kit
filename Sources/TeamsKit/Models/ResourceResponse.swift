import Foundation

/// Defines a response that contains a resource ID.
public struct ResourceResponse: Decodable, Sendable {
    /// ID that uniquely identifies the resource.
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

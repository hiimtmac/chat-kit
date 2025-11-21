import Foundation

public struct ID: Codable, Equatable, Sendable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

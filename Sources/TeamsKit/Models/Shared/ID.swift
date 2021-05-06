import Foundation

public struct ID: Codable, Equatable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}

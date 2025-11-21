import Foundation

public enum URLSource: Codable {
    /// URL to the source of the image
    case url(URL)
    /// base64 binary of the image (for example, data:image/png;base64,iVBORw0KGgo...).
    case base64(String)
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .url(let url): try container.encode(url)
        case .base64(let string): try container.encode(string)
        }
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        if let url = try? container.decode(URL.self) {
            self = .url(url)
        } else if let string = try? container.decode(String.self) {
            self = .base64(string)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "Could not decode URLSource"
                )
            )
        }
    }
}

import Foundation

/// Defines the URL to an image's source.
public struct ThumbnailUrl: Codable {
    /// Description of the image.
    /// You should include the description to support accessibility.
    public let alt: String?
    /// URL to the source of the image or the base64 binary of the image (for example, data:image/png;base64,iVBORw0KGgo...).
    public let url: URLSource
    
    public init(source: URLSource, alt: String?) {
        self.url = source
        self.alt = alt
    }
}

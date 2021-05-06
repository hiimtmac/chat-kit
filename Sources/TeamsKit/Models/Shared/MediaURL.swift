import Foundation

/// Defines the URL to a media file's source.
public struct MediaUrl: Codable {
    /// Hint that describes the media's content.
    public let profile: String
    /// URL to the source of the media file.
    public let url: URL
    
    public init(profile: String, url: URL) {
        self.profile = profile
        self.url = url
    }
}

import Foundation

public struct CardImage: Codable {
    /// Description of the image.
    /// You should include the description to support accessibility.
    public let alt: String?
    /// A CardAction object that specifies the action to perform if the user taps or clicks the image.
    public let tap: CardAction?
    /// URL to the source of the image or the base64 binary of the image (for example, data:image/png;base64,iVBORw0KGgo...).
    public let url: URLSource
    
    public init(
        url: URL,
        alt: String? = nil,
        tap: CardAction? = nil
    ) {
        self.alt = alt
        self.tap = tap
        self.url = .url(url)
    }
    
    public init(
        base64: String,
        alt: String? = nil,
        tap: CardAction? = nil
    ) {
        self.alt = alt
        self.tap = tap
        self.url = .base64(base64)
    }
}

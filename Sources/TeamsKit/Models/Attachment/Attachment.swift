import Foundation

/// Defines additional information to include in the message.
/// An attachment may be a file (such as an image, audio, or video) or a rich card.
/// A7100: Senders SHOULD NOT include both content and contentUrl fields in a single attachment.
public struct Attachment: Codable {
    /// The content of the attachment.
    public let content: Content?
    /// The media type of the content in the attachment.
    public let contentType: String
    /// URL for the content of the attachment. Supported protocols are: HTTP, HTTPS, File, and Data.
    public let contentUrl: URL?
    /// Name of the attachment
    public let name: String?
    /// URL to a thumbnail image that the channel can use if it supports using an alternative, smaller form of content or contentUrl.
    public let thumbnailUrl: URL?
    
    public init(
        _ url: URL,
        contentType: String,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = nil
        self.contentType = contentType
        self.contentUrl = url
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: AdaptiveCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .adaptive(card)
        self.contentType = "application/vnd.microsoft.card.adaptive"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: ListCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .list(card)
        self.contentType = "application/vnd.microsoft.card.list"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: AnimationCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .animation(card)
        self.contentType = "application/vnd.microsoft.card.animation"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: AudioCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .audio(card)
        self.contentType = "application/vnd.microsoft.card.audio"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: HeroCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .hero(card)
        self.contentType = "application/vnd.microsoft.card.hero"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: ReceiptCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .receipt(card)
        self.contentType = "application/vnd.microsoft.card.receipt"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: SignInCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .signIn(card)
        self.contentType = "application/vnd.microsoft.card.signin"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: ThumbnailCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .thumbnail(card)
        self.contentType = "application/vnd.microsoft.card.thumbnail"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    public init(
        _ card: VideoCard,
        name: String? = nil,
        thumbnailUrl: URL? = nil
    ) {
        self.content = .video(card)
        self.contentType = "application/vnd.microsoft.card.video"
        self.contentUrl = nil
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case content
        case contentType
        case contentUrl
        case name
        case thumbnailUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let contentType = try container.decode(String.self, forKey: .contentType)
        if let url = try container.decodeIfPresent(URL.self, forKey: .contentUrl) {
            self.contentUrl = url
            self.content = nil
        } else {
            switch contentType {
            case "application/vnd.microsoft.card.adaptive":
                self.content = .adaptive(try container.decode(AdaptiveCard.self, forKey: .content))
            case "application/vnd.microsoft.teams.card.list":
                self.content = .list(try container.decode(ListCard.self, forKey: .content))
            case "application/vnd.microsoft.card.animation":
                self.content = .animation(try container.decode(AnimationCard.self, forKey: .content))
            case "application/vnd.microsoft.card.audio":
                self.content = .audio(try container.decode(AudioCard.self, forKey: .content))
            case "application/vnd.microsoft.card.hero":
                self.content = .hero(try container.decode(HeroCard.self, forKey: .content))
            case "application/vnd.microsoft.card.receipt":
                self.content = .receipt(try container.decode(ReceiptCard.self, forKey: .content))
            case "application/vnd.microsoft.card.signin":
                self.content = .signIn(try container.decode(SignInCard.self, forKey: .content))
            case "application/vnd.microsoft.card.thumbnail":
                self.content = .thumbnail(try container.decode(ThumbnailCard.self, forKey: .content))
            case "application/vnd.microsoft.card.video":
                self.content = .video(try container.decode(VideoCard.self, forKey: .content))
            default:
                self.content = .other(try container.decode(String.self, forKey: .content))
            }
            self.contentUrl = nil
        }
        self.contentType = contentType
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.thumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .thumbnailUrl)
    }

    public enum Content: Encodable {
        case other(String)
        case list(ListCard)
        case adaptive(AdaptiveCard)
        case animation(AnimationCard)
        case audio(AudioCard)
        case hero(HeroCard)
        case receipt(ReceiptCard)
        case signIn(SignInCard)
        case thumbnail(ThumbnailCard)
        case video(VideoCard)
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .other(let content): try container.encode(content)
            case .list(let content): try container.encode(content)
            case .adaptive(let content): try container.encode(content)
            case .animation(let content): try container.encode(content)
            case .audio(let content): try container.encode(content)
            case .hero(let content): try container.encode(content)
            case .receipt(let content): try container.encode(content)
            case .signIn(let content): try container.encode(content)
            case .thumbnail(let content): try container.encode(content)
            case .video(let content): try container.encode(content)
            }
        }
    }
}

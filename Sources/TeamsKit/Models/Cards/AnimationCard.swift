import Foundation

/// Defines a card that can play animated GIFs or short videos.
///
///  - Teams: ✖
public struct AnimationCard: CardType {    
    /// Aspect ratio of thumbnail/media placeholder.
    /// Allowed values are "16:9" and "4:3".
    public let aspect: AspectRatio
    /// Flag that indicates whether to replay the list of animated GIFs when the last one ends.
    /// Set this property to true to automatically replay the animation; otherwise, false.
    /// The default value is true.
    public let autoloop: Bool
    /// Flag that indicates whether to automatically play the animation when the card is displayed.
    /// Set this property to true to automatically play the animation; otherwise, false.
    /// The default value is true.
    public let autostart: Bool
    /// Array of CardAction objects that enable the user to perform one or more actions.
    /// The channel determines the number of buttons that you may specify.
    public let buttons: [CardAction]
    /// The length of the media content, in ISO 8601 duration format.
    public let duration: String
    /// A ThumbnailUrl object that specifies the image to display on the card.
    public let image: ThumbnailUrl
    /// Array of MediaUrl objects.
    /// When this field contains more than one URL, each URL is an alternative format of the same content.
    public let media: [MediaUrl]
    /// Flag that indicates whether the animation may be shared with others.
    /// Set this property to true if the animation may be shared; otherwise, false.
    /// The default value is true.
    public let shareable: Bool
    /// Subtitle to display under the card's title.
    public let subtitle: String
    /// Description or prompt to display under the card's title or subtitle.
    public let text: String
    /// Title of the card.
    public let title: String
    /// Supplementary parameter for this card.
//    let value: object
    
    public init(
        aspect: AspectRatio,
        autoloop: Bool,
        autostart: Bool,
        buttons: [CardAction],
        duration: String,
        image: ThumbnailUrl,
        media: [MediaUrl],
        shareable: Bool,
        subtitle: String,
        text: String,
        title: String
    ) {
        self.aspect = aspect
        self.autoloop = autoloop
        self.autostart = autostart
        self.buttons = buttons
        self.duration = duration
        self.image = image
        self.media = media
        self.shareable = shareable
        self.subtitle = subtitle
        self.text = text
        self.title = title
    }
}

import Foundation

/// Defines a card with a large image, title, text, and action buttons.
///
/// Compatibility:
///  - Bots in Teams: ✔
///  - Messaging Extensions: ✔
///  - Connectors: ✖
///  - Bot Framework: ✔
///  - Teams: ✔
public struct HeroCard: CardType {    
    /// Array of CardAction objects that enable the user to perform one or more actions.
    /// The channel determines the number of buttons that you may specify.
    public let buttons: [CardAction]
    /// Array of CardImage objects that specifies the image to display on the card.
    /// A Hero card contains only one image.
    public let images: [CardImage]
    /// Subtitle to display under the card's title.
    public let subtitle: String
    /// A CardAction object that specifies the action to perform if the user taps or clicks the card.
    /// This can be the same action as one of the buttons or a different action.
    public let tap: CardAction?
    /// Description or prompt to display under the card's title or subtitle.
    public let text: String
    /// Title of the card.
    public let title: String
    
    public init(
        image: CardImage,
        title: String,
        subtitle: String,
        text: String,
        buttons: [CardAction],
        tap: CardAction? = nil
    ) {
        self.images = [image]
        self.title = title
        self.subtitle = subtitle
        self.text = text
        self.buttons = buttons
        self.tap = tap
    }
}

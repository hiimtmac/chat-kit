import Foundation

/// Defines a card that lets a user sign in to a service.
///
/// Compatibility:
///  - Bots in Teams: ✔
///  - Messaging Extensions: ✖
///  - Connectors: ✖
///  - Bot Framework: ✔
///  - Teams: ✔
public struct SignInCard: CardType {    
    /// Array of CardAction objects that enable the user to sign in to a service.
    /// The channel determines the number of buttons that you may specify.
    public let buttons: [CardAction]
    /// Description or prompt to include on the sign in card.
    public let text: String
    
    public init(buttons: [CardAction], text: String) {
        self.buttons = buttons
        self.text = text
    }
}

import Foundation

extension BlockElement {
    /// Works with block types: Section Actions
    ///
    /// An interactive component that inserts a button. The button can be a trigger for anything from opening a simple link to starting a complex workflow.
    /// To use interactive components, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct Button: Encodable {
        /// The type of element. In this case type is always button.
        public let type: String
        /// A text object that defines the button's text. Can only be of type: plain_text.
        /// Maximum length for the text in this field is 75 characters.
        public let text: CompositionObject.Text
        /// An identifier for this action.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A URL to load in the user's browser when the button is clicked.
        /// Maximum length for this field is 3000 characters.
        /// If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
        public let url: String?
        /// The value to send along with the interaction payload.
        /// Maximum length for this field is 2000 characters.
        public let value: String?
        /// Decorates buttons with alternative visual color schemes. Use this option with restraint.
        /// If you don't include this field, the default button style will be used.
        public let style: Style?
        /// A confirm object that defines an optional confirmation dialog after the button is clicked.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            text: CompositionObject.Text,
            action_id: String,
            url: String? = nil,
            value: String? = nil,
            style: Style? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "button"
            self.text = text
            self.action_id = action_id
            self.url = url
            self.value = value
            self.style = style
            self.confirm = confirm
        }
        
        public enum Style: String, Encodable {
            /// primary gives buttons a green outline and text, ideal for affirmation or confirmation actions. primary should only be used for one button within a set.
            case primary
            /// danger gives buttons a red outline and text, and should be used when the action is destructive.
            /// Use danger even more sparingly than primary.
            case danger
        }
    }
}

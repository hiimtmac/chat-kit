import Foundation

extension BlockElement {
    /// A plain-text input, similar to the HTML <input> tag, creates a field where a user can enter freeform data. It can appear as a single-line field or a larger textarea using the multiline flag.
    ///
    /// Works with block types: Input
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// Plain-text input elements are supported in the following app surfaces: Home tabs, Messages, Modals
    /// To use plain-text input elements in modals, you will need to make some changes to prepare your app. Read about preparing your app for modals.
    public struct PlainTextInput: Encodable {
        /// The type of element. In this case type is always plain_text_input.
        public let type: String
        /// An identifier for the input value when the parent modal is submitted.
        /// You can use this when you receive a view_submission payload to identify the value of the input element.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown in the plain-text input.
        /// Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text
        /// The initial value in the plain-text input when it is loaded.
        public let initial_value: String?
        /// Indicates whether the input will be a single line (false) or a larger textarea (true).
        /// Defaults to false.
        public let multiline: Bool?
        /// The minimum length of input that the user must provide.
        /// If the user provides less, they will receive an error.
        /// Maximum value is 3000.
        public let min_length: Int?
        /// The maximum length of input that the user can provide.
        /// If the user provides more, they will receive an error.
        public let max_length: Int?
        /// A dispatch configuration object that determines when during text input the element returns a block_actions payload.
        public let dispatch_action_config: CompositionObject.DispatchActionConfiguration?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text,
            initial_value: String? = nil,
            multiline: Bool? = nil,
            min_length: Int? = nil,
            max_length: Int? = nil,
            dispatch_action_config: CompositionObject.DispatchActionConfiguration? = nil
        ) {
            self.type = "plain_text_input"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_value = initial_value
            self.multiline = multiline
            self.min_length = min_length
            self.max_length = max_length
            self.dispatch_action_config = dispatch_action_config
        }
    }
}

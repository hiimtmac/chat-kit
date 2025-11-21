import Foundation

extension BlockElement {
    /// A radio button group that allows a user to choose one item from a list of possible options.
    ///
    /// Works with block types: Section, Actions, Input
    /// Radio buttons are supported in the following app surfaces: Home tabs, Modals, Messages
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct RadioButtonGroup: Encodable {
        /// The type of element. In this case type is always radio_buttons.
        public let type: String
        /// An identifier for the action triggered when the radio button group is changed.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// An array of option objects. A maximum of 10 options are allowed.
        public let options: [CompositionObject.Option]
        /// An option object that exactly matches one of the options within options.
        /// This option will be selected when the radio button group initially loads.
        public let initial_option: CompositionObject.Option?
        /// A confirm object that defines an optional confirmation dialog that appears after clicking one of the radio buttons in this element.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            options: [CompositionObject.Option],
            initial_option: CompositionObject.Option? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "radio_buttons"
            self.action_id = action_id
            self.options = options
            self.initial_option = initial_option
            self.confirm = confirm
        }
    }
}

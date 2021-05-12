import Foundation

extension BlockElement {
    /// A checkbox group that allows a user to choose multiple items from a list of possible options.
    ///
    /// Checkboxes are only supported in the following app surfaces: Home tabs, Modals, Messages
    /// Works with block types: Section, Actions, Input
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct CheckboxGroup: Encodable {
        /// The type of element. In this case type is always checkboxes.
        public let type: String
        /// An identifier for the action triggered when the checkbox group is changed.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// An array of option objects. A maximum of 10 options are allowed.
        public let options: [CompositionObject.Option]
        /// An array of option objects that exactly matches one or more of the options within options. These options will be selected when the checkbox group initially loads.
        public let initial_options: [CompositionObject.Option]?
        /// A confirm object that defines an optional confirmation dialog that appears after clicking one of the checkboxes in this element.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            options: [CompositionObject.Option],
            initial_options: [CompositionObject.Option]? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "checkboxes"
            self.action_id = action_id
            self.options = options
            self.initial_options = initial_options
            self.confirm = confirm
        }
    }
}

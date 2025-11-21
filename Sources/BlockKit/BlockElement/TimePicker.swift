import Foundation

extension BlockElement {
    /// An element which allows selection of a time of day.
    ///
    /// Works with block types: Section, Actions, Input
    ///
    /// Beta feature
    /// This is an in-development app feature that must be enabled in the Beta Features section of your app config before use.
    /// On desktop clients, this time picker will take the form of a dropdown list with free-text entry for precise choices. On mobile clients, the time picker will use native time picker UIs.
    ///
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct TimePicker: Encodable {
        /// The type of element. In this case type is always timepicker.
        public let type: String
        /// An identifier for the action triggered when a time is selected.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown on the timepicker.
        /// Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text?
        /// The initial time that is selected when the element is loaded.
        /// This should be in the format HH:mm, where HH is the 24-hour format of an hour (00 to 23) and mm is minutes with leading zeros (00 to 59), for example 22:25 for 10:25pm.
        public let initial_time: String?
        /// A confirm object that defines an optional confirmation dialog that appears after a time is selected.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text? = nil,
            initial_time: String? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "timepicker"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_time = initial_time
            self.confirm = confirm
        }
    }
}

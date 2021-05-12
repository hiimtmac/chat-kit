import Foundation

extension BlockElement {
    /// An element which lets users easily select a date from a calendar style UI.
    ///
    /// Works with block types: Section, Actions, Input
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct DatePicker: Encodable {
        /// The type of element. In this case type is always datepicker.
        public let type: String
        /// An identifier for the action triggered when a menu option is selected.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown on the datepicker. Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text?
        /// The initial date that is selected when the element is loaded.
        /// This should be in the format YYYY-MM-DD.
        public let initial_date: String?
        /// A confirm object that defines an optional confirmation dialog that appears after a date is selected.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text? = nil,
            initial_date: Date? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "datepicker"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_date = initial_date.flatMap { Self.formatter.string(from: $0) }
            self.confirm = confirm
        }
        
        static let formatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd"
            return f
        }()
    }
}

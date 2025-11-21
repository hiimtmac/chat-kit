import Foundation

extension Block {
    /// A block that collects information from users - it can hold a plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// Read our guides to collecting input in modals or in Home tabs to learn how input blocks pass information to your app.
    public struct Input: Encodable {
        /// The type of block. For an input block, type is always input.
        public let type: String
        /// A label that appears above an input element in the form of a text object that must have type of plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let label: CompositionObject.Text
        /// An plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
        public let element: BlockElement
        /// A boolean that indicates whether or not the use of elements in this block should dispatch a block_actions payload.
        /// Defaults to false.
        public let dispatch_action: Bool?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        /// An optional hint that appears below an input element in a lighter grey.
        /// It must be a a text object with a type of plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let hint: CompositionObject.Text?
        /// A boolean that indicates whether the input element may be empty when a user submits the modal.
        /// Defaults to false.
        public let optional: Bool?
        
        init(
            label: CompositionObject.Text,
            element: BlockElement,
            dispatch_action: Bool? = nil,
            block_id: String? = nil,
            hint: CompositionObject.Text? = nil,
            optional: Bool? = nil
        ) {
            self.type = "input"
            self.label = label
            self.element = element
            self.dispatch_action = dispatch_action
            self.block_id = block_id
            self.hint = hint
            self.optional = optional
        }
    }
}

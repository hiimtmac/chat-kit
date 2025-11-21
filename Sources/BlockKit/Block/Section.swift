import Foundation

extension Block {
    /// A section is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    public struct Section: Encodable {
        /// The type of block. For a section block, type will always be section.
        public let type: String
        /// The text for the block, in the form of a text object.
        /// Maximum length for the text in this field is 3000 characters.
        /// This field is not required if a valid array of fields objects is provided instead.
        public let text: CompositionObject.Text?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        /// Required if no text is provided.
        /// An array of text objects.
        /// Any text objects included with fields will be rendered in a compact format that allows for 2 columns of side-by-side text.
        /// Maximum number of items is 10.
        /// Maximum length for the text in each item is 2000 characters.
        public let fields: [CompositionObject.Text]?
        /// One of the available element objects.
        public let accessory: BlockElement?
        
        init(
            text: CompositionObject.Text? = nil,
            block_id: String? = nil,
            fields: [CompositionObject.Text]? = nil,
            accessory: BlockElement? = nil
        ) {
            self.type = "section"
            self.text = text
            self.block_id = block_id
            self.fields = fields
            self.accessory = accessory
        }
    }
}

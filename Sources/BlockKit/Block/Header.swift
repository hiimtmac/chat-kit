import Foundation

extension Block {
    /// A header is a plain-text block that displays in a larger, bold font.
    /// Use it to delineate between different groups of content in your app's surfaces.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    public struct Header: Encodable {
        /// The type of block. For this block, type will always be header.
        public let type: String
        /// The text for the block, in the form of a plain_text text object.
        /// Maximum length for the text in this field is 150 characters.
        public let text: CompositionObject.Text
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            text: CompositionObject.Text,
            block_id: String? = nil
        ) {
            self.type = "header"
            self.text = text
            self.block_id = block_id
        }
    }
}

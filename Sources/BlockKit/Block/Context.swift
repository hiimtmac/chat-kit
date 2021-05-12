import Foundation

extension Block {
    /// Displays message context, which can include both images and text.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    public struct Context: Encodable {
        /// The type of block. For a context block, type is always context.
        public let type: String
        /// An array of interactive element objects - buttons, select menus, overflow menus, or date pickers.
        /// There is a maximum of 5 elements in each action block.
        public let elements: [BlockElement]
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            elements: [BlockElement],
            block_id: String? = nil
        ) {
            self.type = "context"
            self.elements = elements
            self.block_id = block_id
        }
    }
}

import Foundation

extension Block {
    /// A content divider, like an <hr>, to split up different blocks inside of a message.
    /// The divider block is nice and neat, requiring only a type.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Divider: Encodable {
        /// The type of block. For a divider block, type is always divider.
        public let type: String
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            block_id: String? = nil
        ) {
            self.type = "divider"
            self.block_id = block_id
        }
    }
}

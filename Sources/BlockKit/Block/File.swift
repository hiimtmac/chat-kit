import Foundation

extension Block {
    /// Displays a remote file. You can't add this block to app surfaces directly, but it will show up when retrieving messages that contain remote files.
    ///
    /// Appears in surfaces: Messages
    /// If you want to add remote files to messages, follow our guide.
    public struct File: Encodable {
        /// The type of block. For a file block, type is always file.
        public let type: String
        /// The external unique ID for this file.
        public let external_id: String
        /// At the moment, source will always be remote for a remote file.
        public let source: String
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            external_id: String,
            source: String,
            block_id: String? = nil
        ) {
            self.type = "file"
            self.external_id = external_id
            self.source = source
            self.block_id = block_id
        }
    }
}

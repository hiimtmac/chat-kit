import Foundation

extension Block {
    /// A simple image block, designed to make those cat photos really pop.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    public struct Image: Encodable {
        /// The type of block. For an image block, type is always image.
        public let type: String
        /// The URL of the image to be displayed.
        /// Maximum length for this field is 3000 characters.
        public let image_url: String
        /// A plain-text summary of the image. This should not contain any markup.
        /// Maximum length for this field is 2000 characters.
        public let alt_text: String
        /// An optional title for the image in the form of a text object that can only be of type: plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let title: CompositionObject.Text?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        public init(
            image_url: String,
            alt_text: String,
            title: CompositionObject.Text? = nil,
            block_id: String? = nil
        ) {
            self.type = "image"
            self.image_url = image_url
            self.alt_text = alt_text
            self.title = title
            self.block_id = block_id
        }
    }
}

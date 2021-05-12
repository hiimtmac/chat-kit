import Foundation

extension BlockElement {
    /// An element to insert an image as part of a larger block of content.
    ///
    /// Works with block types: Section Context
    /// If you want a block with only an image in it, you're looking for the image block.
    public struct Image: Encodable {
        /// The type of element. In this case type is always image.
        public let type: String
        /// The URL of the image to be displayed.
        public let image_url: String
        /// A plain-text summary of the image. This should not contain any markup.
        public let alt_text: String
        
        init(
            image_url: String,
            alt_text: String
        ) {
            self.type = "image"
            self.image_url = image_url
            self.alt_text = alt_text
        }
    }
}

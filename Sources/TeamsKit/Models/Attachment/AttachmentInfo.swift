import Foundation

/// Metadata for an attachment.
public struct AttachmentInfo: Decodable {
    /// Name of the attachment.
    public let name: String
    /// Content type of the attachment.
    public let type: String
    /// Array of AttachmentView objects that represent the available views for the attachment.
    public let views: [AttachmentView]
    
    public init(name: String, contentType: String, views: [AttachmentView]) {
        self.name = name
        self.type = contentType
        self.views = views
    }
}

extension AttachmentInfo {
    /// Defines a attachment view.
    public struct AttachmentView: Decodable {
        /// Size of the file.
        public let size: Double
        /// View ID.
        public let viewId: String
        
        public init(size: Double, viewId: String) {
            self.size = size
            self.viewId = viewId
        }
    }
}

import Foundation

/// Describes an attachment's data.
public struct AttachmentData: Encodable {
    /// Name of the attachment.
    public let name: String
    /// Attachment content.
    public let originalBase64: String
    /// Attachment thumbnail content.
    public let thumbnailBase64: String?
    /// Content type of the attachment.
    public let type: String
    
    public init(name: String, original: Data, contentType: String, thumbnail: Data?) {
        self.originalBase64 = original.base64EncodedString()
        self.type = contentType
        self.name = name
        self.thumbnailBase64 = thumbnail?.base64EncodedString()
    }
    
    public init(name: String, original: String, contentType: String, thumbnail: String?) {
        self.originalBase64 = original
        self.type = contentType
        self.name = name
        self.thumbnailBase64 = thumbnail
    }
}

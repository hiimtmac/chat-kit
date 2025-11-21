import Foundation

/// Gets the specified view of the specified attachment as binary content.
public struct GetAttachment: AttachmentOperation {
    /// N/A
    public typealias Body = Never
    /// Binary content that represents the specified view of the specified attachment
    public typealias Response = Data
    
    public let attachmentId: String
    public let viewId: String
    
    public init(attachmentId: String, viewId: String) {
        self.attachmentId = attachmentId
        self.viewId = viewId
    }
    
    public var route: Router { .getAttachment(attachmentId: attachmentId, viewId: viewId) }
}

import Foundation

/// Gets information about the specified attachment, including file name, type, and the available views (e.g. original or thumbnail).
public struct GetAttachmentInfo: AttachmentOperation {
    /// N/A
    public typealias Body = Never
    /// An AttachmentInfo object
    public typealias Response = AttachmentInfo
    
    public let attachmentId: String
    
    public init(attachmentId: String) {
        self.attachmentId = attachmentId
    }
    
    public var route: Router { .getAttachmentInfo(attachmentId: attachmentId) }
}

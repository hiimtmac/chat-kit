import Foundation

/// Uploads an attachment for the specified conversation directly into a channel's blob storage.
/// This enables you to store data in a compliant store.
public struct UploadAttachmentToChannel: ConversationOperation {
    /// An AttachmentData object.
    public typealias Body = AttachmentData
    /// A ResourceResponse object.
    /// The id property specifies the attachment ID that can be used with the Get Attachment Info operation and the Get Attachment operation.
    public typealias Response = ResourceResponse
    
    public let conversationId: String
    
    public init(conversationId: String) {
        self.conversationId = conversationId
    }
    
    public var route: Router { .uploadAttachmentToChannel(conversationId: conversationId) }
}
